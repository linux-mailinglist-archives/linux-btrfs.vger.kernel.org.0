Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01E02BA4AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Nov 2020 09:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgKTIcj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Nov 2020 03:32:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:58121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgKTIci (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Nov 2020 03:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605861141;
        bh=OD5gtoeeRfFMnWUQV+g9aJ7d/ZWkaBO8ujSNp2VQmbA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dXnoEuTY/odAk8JigLFh3y37aCzw/WIgO0WgZUasm9ctZfhjLg1XpSnszXroek6+s
         LF0LfDj/aEC24lET+Aho9Ggu2HYN1sjZdUtzqCx5vb4+KTvt4EvqebfYSmvjvNWpyd
         rh3/3oh6//avGQfpZ3VrUlkrYzA1IuL8k42Y2t+I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M59GA-1kevNQ2SJA-001BVJ; Fri, 20
 Nov 2020 09:32:21 +0100
Subject: Re: [PATCH v2 2/3] btrfs-progs: inspect: Fix logical-resolve file
 path lookup
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
References: <20201116173249.11847-1-marcos@mpdesouza.com>
 <20201116173249.11847-3-marcos@mpdesouza.com>
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
Message-ID: <977d37a3-5240-c5d6-b117-d91f0e5a5f9c@gmx.com>
Date:   Fri, 20 Nov 2020 16:32:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201116173249.11847-3-marcos@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="73ZoWbL3pwfNE1W5JNT2uRrIIhQ9WsBR4"
X-Provags-ID: V03:K1:AdcVP9qIvuDS+BmsIGk3R0wAKjQdcDTcw2sI2IFscToCaF1pd8N
 R3BUafGTGs0PmcFQqKus15V+q6ShqbCp9rq4PWlQaMGot+XbD2wnpgUBz5QskcAAUIigqfp
 tls8wIW07Vi5tIIq2BxumHjM4c9obHBD8c0/yGbtoMYF0H8EmPug71YZHFBn9G4W1n78ylU
 HUkTGDwZg1v7WDhFUhUCw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t1PG4uYw+Lk=:hEaFW4XY5L2ZrODAWI+FEs
 Wn+ou88gCIH3hPB0xJcxfLkw1hZ/FyLZ/7B7tOfMs2SeODzjBb7O6ZKKt8csM0mRurNaQWpk0
 IaMKUk2kh8E2vTH9oIP3ILZ2kbheIQyQzWix35pSX5Hjz6pMy1yacPNUCq4MblKo8/DCfemNb
 OsrMBjYG1vsA5+7R96W5+FE/Pz7rXC5zJOXj+DqnMMcfroJ4+R0UG3YiJ0KdMsV6DSxoH2Eke
 pTPptythmNTUEc/fFHbQO16oZINQ+8bY7vsk29uhLhxz6QhujUfusP2v2WOXZUZgbVV3l0BFY
 LbgWsCvA5wSsxXM10c82nftsDNrvaMN5ft64Qt9oMecXBFOvVfa9PRREYAMo6x0Y8sjAnBm4H
 KSTSWJSx2f+6oAcGJCNYiJMgE7/pDLieK1fiLB8p/XvOYMC6oTpxk7QX2PTm8Kc/p6/KkX+6X
 bBL2KW557WM5hK20TN2OCHbAPb8hulGmxfienY/0W2H5rIEGI3edcBylCaJPr21m25iMnX80R
 isEUnqTuk7Le2cYq3NbPXi2Jrqwq1vE1rzCMxVS6cW96m1JQ8alQT8r9JTjijv/WSYvsBPiPQ
 b1YWn4bLpQnT/JotEDEQkW8BTpyovppI0oI3pKQacwouQy9bUHuV4/LWNV7YBblHDtq5qV/30
 KmR1pNEJ1YmlvVDFbT1TROwbdLJmqyUWmhoBIg+77rryp6TSRBEgz3FrVQAarvjavy3A9uoyP
 WS64T8MPgz0A65KH2BdODJpFbK4hOn/NfpHXcF+pFY+PmCKjuKPgSUdTL7ivTM9IFpHckWg+V
 gdtjB4akFqLNNDwWYulrwE02GkBGvBEeuhOyphjPUnRsDLbPXA4f3pmOgYdBR242QbQGjHkuc
 qVtCta77i9I1iGDPPN/Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--73ZoWbL3pwfNE1W5JNT2uRrIIhQ9WsBR4
Content-Type: multipart/mixed; boundary="8rtecAVmWAb9UPfij9Hx94p4gpziNEWdw"

--8rtecAVmWAb9UPfij9Hx94p4gpziNEWdw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/17 =E4=B8=8A=E5=8D=881:32, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> [BUG]
> logical-resolve is currently broken on systems that have a child
> subvolume being mounted without access to the parent subvolume.
> This is the default for SLE/openSUSE installations. openSUSE has the
> subvolume '@' as the parent of all other subvolumes like /boot, /home.
> The subvolume '@' is never mounted, and accessed, but only it's child:
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
> address. As the name implies, the 'full-path' returns all subvolumes,
> starting from '@'. Later on, btrfs_open_dir is calles using the path
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
> since it uses the subvolume name as the path accessible by the user.
>=20
> [FIX]
> Extent the find_mount_root function by allowing it to check for mnt_opt=
s
> member of mntent struct. Using this new approach we can change
> logical-resolve command to search for subvolid=3DXXX,subvol=3DYYY. This=
 is
> the two problems stated above by not trusting the subvolume name being
> the mountpoint name, and not following the subvolume tree blindly.
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  cmds/inspect.c | 30 ++++++++++++++++++++++--------
>  common/utils.c | 13 +++++++++----
>  common/utils.h |  5 ++++-
>  3 files changed, 35 insertions(+), 13 deletions(-)
>=20
> diff --git a/cmds/inspect.c b/cmds/inspect.c
> index 2530b904..0dc62d18 100644
> --- a/cmds/inspect.c
> +++ b/cmds/inspect.c
> @@ -245,15 +245,29 @@ static int cmd_inspect_logical_resolve(const stru=
ct cmd_struct *cmd,
>  				path_ptr[-1] =3D '\0';
>  				path_fd =3D fd;
>  			} else {
> -				path_ptr[-1] =3D '/';
> -				ret =3D snprintf(path_ptr, bytes_left, "%s",
> -						name);
> -				free(name);
> -				if (ret >=3D bytes_left) {
> -					error("path buffer too small: %d bytes",
> -							bytes_left - ret);
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
> +				if (ret < 0)
>  					goto out;
> -				}

OK, I see how you utilize the new parameter now.

But considering there is only one user for BTRFS_FIND_ROOT_OPTS, i
really hope to not touching the existing callers.
Anyway this is just a nitpick, and mostly personal taste.

Another thing is, what if we bind mount a dir of btrfs to another locatio=
n.
Wouldn't this trick the find_mount_root() again?

Personally speaking, we should only permit subvolume entry to be passes
to the btrfs-logical-resolve command to avoid such problems.

Thanks,
Qu
> +
> +				strncpy(full_path, mounted, PATH_MAX);
> +				free(mounted);
> +
>  				path_fd =3D btrfs_open_dir(full_path, &dirs, 1);
>  				if (path_fd < 0) {
>  					ret =3D -ENOENT;
> diff --git a/common/utils.c b/common/utils.c
> index 1c264455..7e6f406b 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -1261,8 +1261,6 @@ int find_mount_root(const char *path, const char =
*data, u8 flag, char **mount_ro
>  	char *cmp_field =3D NULL;
>  	bool found;
> =20
> -	BUG_ON(flag !=3D BTRFS_FIND_ROOT_PATH);
> -
>  	fd =3D open(path, O_RDONLY | O_NOATIME);
>  	if (fd < 0)
>  		return -errno;
> @@ -1273,11 +1271,18 @@ int find_mount_root(const char *path, const cha=
r *data, u8 flag, char **mount_ro
>  		return -errno;
> =20
>  	while ((ent =3D getmntent(mnttab))) {
> -		cmp_field =3D ent->mnt_dir;
> +		/* BTRFS_FIND_ROOT_PATH is the default behavior */
> +		if (flag =3D=3D BTRFS_FIND_ROOT_OPTS)
> +			cmp_field =3D ent->mnt_opts;
> +		else
> +			cmp_field =3D ent->mnt_dir;
> =20
>  		len =3D strlen(cmp_field);
> =20
> -		found =3D strncmp(cmp_field, data, len) =3D=3D 0;
> +		if (flag =3D=3D BTRFS_FIND_ROOT_OPTS)
> +			found =3D strstr(cmp_field, data) !=3D NULL;
> +		else
> +			found =3D strncmp(cmp_field, data, len) =3D=3D 0;
> =20
>  		if (found) {
>  			/* match found and use the latest match */
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


--8rtecAVmWAb9UPfij9Hx94p4gpziNEWdw--

--73ZoWbL3pwfNE1W5JNT2uRrIIhQ9WsBR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+3fxAACgkQwj2R86El
/qjSpggAnjLsLH8Srt5Q/ZYj+e+jBRKGNSI52FGcMm7rK3744fu6GY3COXSa0mQ+
Q+AVgFqT7y52jCYA6OJ9EajWynevU1ZwfqYVAv8HikbccR87+LNXwKnvCbtQR0mC
vvlw8349dvPtiG8VqsSqiRUODckYL8q9cL3AsSqRBB3Uft5xplMaHGtZbN9p8zJw
wMClyZmJQ6XGcot8m8BnHkznapNv0p8mP/gnWcVYZaSMO9ppxWqU85tw6fWWEz9z
T0rcxmmjtMr4+hagIW6Vfu3OzrFLZGiYyyeRvRtbdp5FmNq4cr7py2+hTdpKkb21
9WNVqJNa2Iwro8Bzy3rRBk3RWcPIFg==
=TvSw
-----END PGP SIGNATURE-----

--73ZoWbL3pwfNE1W5JNT2uRrIIhQ9WsBR4--
