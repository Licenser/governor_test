gov_dir=$1
target_dir=$2
config=~/.riak_test.config

if [ "x${gov_dir}x" = "xx" -o "x${target_dir}x" = "xx" ]
then
	echo "usage: $0 <path to riak_govenor> <target for riak_test deployment>"
	exit 1
fi

if [ ! -d "${gov_dir}" ]
then
	echo "$gov_dir does not exist!"
	exit 1
fi

if [ -d "${target_dir}" ]
then
	echo "Target directory '${target_dir}' exists we'll need to nuke it is that ok?"
	echo 'Delete '${target_dir}'? [y/N]'
        read DELETE
	case "$DELETE" in
		y*|Y*)
			echo "Now going to delete '${target_dir}'"
			rm -rf "${target_dir}"
			;;
		*)
			echo "Aborting."
			exit 0
			;;
	esac
fi

if [ -d "${gov_dir}/dev" ]
then
        echo "Devrel seems to exist! Do you want to use this? If not it means the directory '${gov_dir}/dev' gets deleted and recreated."
	echo "Use existing devrel? [Y/n]"
        read KEEP
        case "$KEEP" in
                n*|N*)
                        echo "Generating new dev-rel"
			rm -rf "${gov_dir}/dev" 
			(cd "${gov_dir}" && make devrel)
			;;
		*)
                        echo "We're going to keep your dev-rel"
			;;
	esac
else
	echo "Generating new dev-rel"
	(cd "${gov_dir}" && make devrel)
fi

if [ ! -d "${gov_dir}/dev" ]
then
	echo "Could not get a devrel, something went wrong, oops!"
	exit 1
fi

echo "Generating target directory"
mkdir -p "${target_dir}"
echo "Copying dev-rel"
cp -r "${gov_dir}/dev" "${target_dir}"
echo "Initializing git repository"
echo "dev/dev*/data" > "${target_dir}/.gitignore"
echo "dev/dev*/log" >> "${target_dir}/.gitignore"
(cd ${target_dir} && git init && git add . && git commit -a -m "initial")

if [ -f "${config}" ]
then
	echo "A riak_test config file already exist, do you want to delete and re-generate? If not you need to manually modify it."
	echo "Delete and regenerate '${config}'? [y/N]"
	read DELETE
	case "$DELETE" in
		y*|Y*)
			rm "${config}"
			;;
		*)
			echo "We're done!"
			;;
	esac
fi

sed "s;{{target_dir}};${target_dir};" governor_test.config > ${config}

