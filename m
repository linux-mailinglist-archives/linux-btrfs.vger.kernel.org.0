Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A4C2CE416
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 01:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgLDAKY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 19:10:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:57855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgLDAKX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 19:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607040515;
        bh=sV0NHUl3Rf542x3KiRITdOa+BgjZkLOYyLkaowwbTrs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fym0oy7Y414vQV0KuPacXOCobB+7qaVroppdi/4YIzfoXXEfzFLLudDVWnbqTR8eV
         4Uw4Uds/rOvSWZysOJHlB7Y2NqDBxhdpzVBcIAI1AC8tSDsX9/4ZE9d51KVCHg+Rkb
         oBxErmbaZMsYGtyjCRupGUPJugnoNWFrWCceoE6Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuDc7-1jsrb52Jll-00ucfv; Fri, 04
 Dec 2020 01:08:35 +0100
Subject: Re: [PATCH v4 2/3] btrfs-progs: inspect: Fix logical-resolve file
 path lookup
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
References: <20201127193035.19171-1-marcos@mpdesouza.com>
 <20201127193035.19171-3-marcos@mpdesouza.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <617afee6-2e3b-99b3-3c94-ca2ab4063373@gmx.com>
Date:   Fri, 4 Dec 2020 08:08:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201127193035.19171-3-marcos@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tLJhmI7E10VruJ2KvZzAZpMqVE1CcYyUN"
X-Provags-ID: V03:K1:1DDduyOoRJivGT9jR+yuJXe6DNLZHPk0D0D2wL6se6p1IHbmttD
 KLx1XbGK+fMpmZ3TSKDJHV+18l3fPZfhvK+YfpKfgUq6sZOye5BiUUORMb77B8P1xQAEfvZ
 ALcI+uszzYfs51ld2fteShujwr5Vfm4jgPn3enoLzcToTuJX32KgbkR7h2epip6OgKjGlMc
 wMxotX2PQd7i47tTHjn3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DZvoKjzHjNE=:VetEKrWZV2w4FmDKF0zNtY
 Cwr63FNG2ywJyNtOgsQOtImmGClBvojLdEdOa/CHY9bjssnRDOXwrJhVg/JM95YG5VBxMiyKi
 WXAtZKPgymL/Pd6BtG3lxGrl/INW8jj6lJf5ul3OV7CvxUo6hRlsvCCrE2LMykpwGuCDECIxs
 hvRmVEwXYVHeV94NFS3eZNLrvd5Fr5RbSWEVS3uiQbgpEHf6pujGQJmkMAV61hwfw0iY0adXv
 KfWyxYjvawDzM+cDqFmsJTACXwR8TrvGo3k93MCoDyXImCmHbM12avD42M0R+wzjR3+ZXvj99
 8augVs/W5IpSDSz3mCl/mtKiZ+EIZqUuw1IQG0OZyZXW593Qdni2vHp4mHLHjtLi6lKVQXi/D
 dtcrSf+W+CDr4oDfbxDgcDSz8iIEOOvuzKtgZpPTn58dEbSpjF1la4P79Nm77U/itu4fjc02j
 7pPe21ikhozrgJQwzIZMfMa2bgjEq3XJlBOZWJaVa8ix2vZes0G2qMgB9FWBpSBoizck1Kddh
 rFn27LaLnbm4x9gZ0Q1M+6IAfdJjiRuOY1BlaRD6+HJ3kvJWUWSFR93k7lfzaoU/GTosBvJqJ
 7XyJ0QM7xAOjlNpI65+r4NKdXPrRoZK5MbWVR0R50kL/tggmSQagfOTZVQGVhWvX6S2FL9NQh
 TU2eJva6IQ2IepEvfMqRzZhM8gLXc003v+e23uvub56ts5vhNI4lRfUfkfny8QSnsLJn//jUv
 AeLwlg/mXT/uHra8oW5n6yj1iAyx7HfvJ6nbh5+ck9h9Lj8yWel6QzWffytQ5xrPaSZA5k/BW
 ojfrgeqPqUx7vao29G7R5EVheyYbXTHRLRWlAk6qFch4sXvrImIaedUDZwKMmxjImXYRZWvb8
 P4z/KKXMT0pmwdCYTDbA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tLJhmI7E10VruJ2KvZzAZpMqVE1CcYyUN
Content-Type: multipart/mixed; boundary="G84p76nXLukGz9blWFkrBNpZjZmkQw1yY"

--G84p76nXLukGz9blWFkrBNpZjZmkQw1yY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/28 =E4=B8=8A=E5=8D=883:30, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> [BUG]
> logical-resolve is currently broken on systems that have a child
> subvolume being mounted without access to the parent subvolume.
> This is the default for SLE/openSUSE installations. openSUSE has the
> subvolume '@' as the parent of all other subvolumes like /boot, /home.
> The subvolume '@' is never mounted and accessed, but only it's childs:
>=20
> mount | grep btrfs
> /dev/sda2 on / type btrfs (rw,relatime,ssd,space_cache,subvolid=3D267,s=
ubvol=3D/@/.snapshots/1/snapshot)
> /dev/sda2 on /opt type btrfs (rw,relatime,ssd,space_cache,subvolid=3D26=
2,subvol=3D/@/opt)
> /dev/sda2 on /boot/grub2/i386-pc type btrfs (rw,relatime,ssd,space_cach=
e,subvolid=3D265,subvol=3D/@/boot/grub2/i386-pc)
>=20
> logical-resolve command calls btrfs_list_path_for_root, that returns th=
e
> subvolume full-path that corresponds to the tree id of the logical
> address. As the name implies, the 'full-path' returns the subvolume ful=
l
> path, starting from '@'. Later on, btrfs_open_dir is called using the p=
ath
> returned, but it fails to resolve it since it contains the '@' and this=

> subvolume cannot be accessed.
>=20
> The same problem can be triggered to any user that calls for
> logical-resolve on a child subvolume that has the parent subvolume
> not accessible.
>=20
> Another problem in the current approach is that it believes that a
> subvolume will be mounted in a directory with the same name e.g /@/boot=

> being mounted in /boot. When this is not true, the code also fails,
> since it uses the subvolume name as the path.
>=20
> [FIX]
> Extent the find_mount_root function by allowing it to check for mnt_opt=
s
> member of mntent struct. Using this new approach we can change
> logical-resolve command to search for subvolid=3DXXX,subvol=3DYYY retur=
ning
> the correct path accessible to the user. Using this approach we can sol=
ve
> the problems stated above by not trusting the subvolume name being the
> mountpoint, and not executing the lookup based only in the subvolume
> tree.
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>


With the extra prompt for subvolume can't be accessed, it looks good to
me now.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  cmds/inspect.c | 44 ++++++++++++++++++++++++++++++++++----------
>  common/utils.c | 29 +++++++++++++++++++++++------
>  common/utils.h |  5 ++++-
>  3 files changed, 61 insertions(+), 17 deletions(-)
>=20
> diff --git a/cmds/inspect.c b/cmds/inspect.c
> index 2530b904..cfa2f708 100644
> --- a/cmds/inspect.c
> +++ b/cmds/inspect.c
> @@ -236,6 +236,7 @@ static int cmd_inspect_logical_resolve(const struct=
 cmd_struct *cmd,
>  		DIR *dirs =3D NULL;
> =20
>  		if (getpath) {
> +			char mount_path[PATH_MAX];
>  			name =3D btrfs_list_path_for_root(fd, root);
>  			if (IS_ERR(name)) {
>  				ret =3D PTR_ERR(name);
> @@ -244,23 +245,46 @@ static int cmd_inspect_logical_resolve(const stru=
ct cmd_struct *cmd,
>  			if (!name) {
>  				path_ptr[-1] =3D '\0';
>  				path_fd =3D fd;
> +
> +				strncpy(mount_path, full_path, PATH_MAX);
>  			} else {
> -				path_ptr[-1] =3D '/';
> -				ret =3D snprintf(path_ptr, bytes_left, "%s",
> -						name);
> -				free(name);
> -				if (ret >=3D bytes_left) {
> -					error("path buffer too small: %d bytes",
> -							bytes_left - ret);
> -					goto out;
> +				char *mounted =3D NULL;
> +				char volid_str[PATH_MAX];
> +
> +				/*
> +				 * btrfs_list_path_for_root returns the full
> +				 * path to the subvolume pointed by root, but the
> +				 * subvolume can be mounted in a directory name
> +				 * different from the subvolume name. In this
> +				 * case we need to find the correct mountpoint
> +				 * using same subvol path and subvol id found
> +				 * before.
> +				 */
> +				snprintf(volid_str, PATH_MAX, "subvolid=3D%llu,subvol=3D/%s",
> +						root, name);
> +
> +				ret =3D find_mount_root(full_path, volid_str,
> +						BTRFS_FIND_ROOT_OPTS, &mounted);
> +
> +				if (ret =3D=3D -ENOENT) {
> +					printf("inode %llu subvol %s could not be accessed: not mounted\n=
",
> +							inum, name);
> +					continue;
>  				}
> -				path_fd =3D btrfs_open_dir(full_path, &dirs, 1);
> +
> +				if (ret < 0)
> +					goto out;
> +
> +				strncpy(mount_path, mounted, PATH_MAX);
> +				free(mounted);
> +
> +				path_fd =3D btrfs_open_dir(mount_path, &dirs, 1);
>  				if (path_fd < 0) {
>  					ret =3D -ENOENT;
>  					goto out;
>  				}
>  			}
> -			ret =3D __ino_to_path_fd(inum, path_fd, full_path);
> +			ret =3D __ino_to_path_fd(inum, path_fd, mount_path);
>  			if (path_fd !=3D fd)
>  				close_file_or_dir(path_fd, dirs);
>  		} else {
> diff --git a/common/utils.c b/common/utils.c
> index 1c264455..1562ac52 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -1259,9 +1259,6 @@ int find_mount_root(const char *path, const char =
*data, u8 flag, char **mount_ro
>  	int longest_matchlen =3D 0;
>  	char *longest_match =3D NULL;
>  	char *cmp_field =3D NULL;
> -	bool found;
> -
> -	BUG_ON(flag !=3D BTRFS_FIND_ROOT_PATH);
> =20
>  	fd =3D open(path, O_RDONLY | O_NOATIME);
>  	if (fd < 0)
> @@ -1273,12 +1270,32 @@ int find_mount_root(const char *path, const cha=
r *data, u8 flag, char **mount_ro
>  		return -errno;
> =20
>  	while ((ent =3D getmntent(mnttab))) {
> -		cmp_field =3D ent->mnt_dir;
> +		bool found =3D false;
> =20
> -		len =3D strlen(cmp_field);
> +		/* BTRFS_FIND_ROOT_PATH is the default behavior */
> +		if (flag =3D=3D BTRFS_FIND_ROOT_OPTS)
> +			cmp_field =3D ent->mnt_opts;
> +		else
> +			cmp_field =3D ent->mnt_dir;
> =20
> -		found =3D strncmp(cmp_field, data, len) =3D=3D 0;
> +		len =3D strlen(cmp_field);
> =20
> +		if (flag =3D=3D BTRFS_FIND_ROOT_OPTS) {
> +			size_t dlen =3D strlen(data);
> +			char *tmp_str =3D strstr(cmp_field, data);
> +			/*
> +			 * Make sure that we are dealing with the wanted string,
> +			 * since strstr returns the start of the string found.
> +			 * Compare the end string position from data with the
> +			 * mount point found, and make sure that we have an
> +			 * option separator or string end.
> +			 */
> +			if (tmp_str)
> +				found =3D tmp_str[dlen] =3D=3D ',' ||
> +					tmp_str[dlen] =3D=3D 0;
> +		} else {
> +			found =3D strncmp(cmp_field, data, len) =3D=3D 0;
> +		}
>  		if (found) {
>  			/* match found and use the latest match */
>  			if (longest_matchlen <=3D len) {
> diff --git a/common/utils.h b/common/utils.h
> index 449e1d3e..b5d256c6 100644
> --- a/common/utils.h
> +++ b/common/utils.h
> @@ -54,7 +54,10 @@
> =20
>  enum btrfs_find_root_flags {
>  	/* check mnt_dir of mntent */
> -	BTRFS_FIND_ROOT_PATH =3D 0
> +	BTRFS_FIND_ROOT_PATH =3D 0,
> +
> +	/* check mnt_opts of mntent */
> +	BTRFS_FIND_ROOT_OPTS
>  };
> =20
>  void units_set_mode(unsigned *units, unsigned mode);
>=20


--G84p76nXLukGz9blWFkrBNpZjZmkQw1yY--

--tLJhmI7E10VruJ2KvZzAZpMqVE1CcYyUN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/Jff4ACgkQwj2R86El
/qhViAf+JZD4UD0s5EuV4Gjhoif+7voezUbAngOb3Hq6piUf5mOHhUP8y4vZUAXE
rrDQowyuDRoH/5V69X9BYvm6Yi3vl/aZEcFXWK88K3N5ozNaA6PI92K7pemKa67J
4FsVjIyfsZ31+jk0V4BLKyBRhAvD2vON/XOtssOUJMGfbK576N+7rqrFT72tIGSy
UfRxgW2d0GNH+ARiL/lsh7iG8RYG1Ab7woqMd0rP7D4m5aL5yCXVm5ZyoXy1xaEx
eXNUlo+4qx6QGBAWWwwxMbbWLhhUkIlCMUVVhei8WToopqy24xk7JDk+CPf/m+ZU
TPbo0kt1Zjib1/DKx4zbgt/k3pMU3Q==
=tC1q
-----END PGP SIGNATURE-----

--tLJhmI7E10VruJ2KvZzAZpMqVE1CcYyUN--
