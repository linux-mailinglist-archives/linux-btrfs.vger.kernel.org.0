Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910822BA48B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Nov 2020 09:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKTIXI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Nov 2020 03:23:08 -0500
Received: from mout.gmx.net ([212.227.15.18]:35081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgKTIXI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Nov 2020 03:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605860569;
        bh=r1CS6c0CaSQBEsE5aj+MhCmteCHlFgUcgXMGBa0J5ec=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KRTP9Q+ROcl7UB0K7S8Ydw8jlEy2bnnxk+mH3MF875gAzUROb6nu7Ey8tbKbo1IAf
         wMHvt5/aZf03IbOSBp1QRuez21U1iM1fJhs/vzOCesHI9Nu/wGRZxee9A8X4hsPFXN
         sECx9hfe7N3pcJjzm1SdoBQNH5IJBqGjwJ3STSSM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9nxn-1kaEOb2XZd-005qmE; Fri, 20
 Nov 2020 09:22:49 +0100
Subject: Re: [PATCH v2 1/3] btrfs-progs: Adapt find_mount_root to verify other
 fields of mntent struct
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
References: <20201116173249.11847-1-marcos@mpdesouza.com>
 <20201116173249.11847-2-marcos@mpdesouza.com>
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
Message-ID: <9335c923-d83b-d1e2-4fc1-86c3d8de9e9f@gmx.com>
Date:   Fri, 20 Nov 2020 16:22:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201116173249.11847-2-marcos@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ce08DO9rPG2ySgtyLIB5WnDUrBCuld7Iz"
X-Provags-ID: V03:K1:L+Jg7L7RZdhq9wmlE7PAIs99Tbk9+4Tq/SGNynYiyA9sMrqNUgr
 6qIqH5E0f7GO2x9Bv2TyFHi4mJqKgb+IyENkx2BDFNKunMKho6TKSGwAU79Jh4IJO4wwSt3
 j2B2iZXDLp9DDshS6waZhKgwjaNh+U1iRgCoW0J27uEH9rJZTVPKriW6ow/otXi9i6tidVZ
 x9zweVRVoxghC4/PGZG7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zcAvRyxrVlA=:8nDgRkn3UPPct0F6z6yymM
 Awh19F2k2sfxxS5Xx8nmncCrxNZg4MLsCcb8bocpBgRZQKoafme7i3xePbFdMigxrPbROzMxQ
 TtHQ1rQSBD1rGj6Fu82yi8aFv0yP/xsuvkfza2pAlFQqmiQFG/UVSSMcHhbElSPDm4j41dcfZ
 QFPbYz1hifcs2QesZzf2xHPkJa8nFGoR0SP/URqLkUz1GCXJKjw6PDKaJoyT5Yh6YPVeOnsCK
 iAqQbEDrDrsvDjxhFOjoZxHxEYQHXcBm4prrNUhsAhB9z/Wo9ShEnangJ4XPeKTcRmQuY6g/k
 xPbxUPQnJa/vaoUVlMp6DftqbLO2XrMK5hnY/8EtFG0IHFZBcxl1xm0tiDOtzq7O8QMQ2kMRc
 wo9789HOjfPPASBsGZoDbYybqMFuF5cHvXfZrZqTVVNzbaR3bF774OQ+MphWgwBOrMOojejlU
 L8t/STT+FlT2LLzDrx7O1/IiHmGXyZODfbYxpLUr18k6cB4Z9bquuoswvsaZAqFUkqk/MO3pQ
 P8zgfQ6dq8u2iOYoNDnm3Tp6Cqi3IST79i1Iu0k151O0erjgMgBWeBv9WWyj8Ux4WhuqrzVPU
 cVkIVSXnaZNIuT/cZaBv5GweTideI0ONXoikgSKUI3MkFZqG1msE2fSYMSraVkyTdwycfWLdV
 OYk0mdWM2TDPhKrJihzcEE+RoiD6h6ZA+BeGOGhFGDxngR8e+CdFmdSdU54PTc5p05R40bCj2
 GuzDMsWgTqKygs6zAiKklKL1Sa29RK6j4hNHeZA6M8Ec3Po7YYW03l82L3tv3n+iRA7L/er8w
 tv+b+OiIh2FNeKAd1VPyyQ7qHfZAyoAkmBYrKLG7q4Tiia2Hjc19MR/7oSuXRxhkhTLkHqAno
 8slRsDtULaxQy/FmzcIA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ce08DO9rPG2ySgtyLIB5WnDUrBCuld7Iz
Content-Type: multipart/mixed; boundary="81iTdN20vvQhMhMbHVxKZq4QaRAL61jid"

--81iTdN20vvQhMhMbHVxKZq4QaRAL61jid
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/17 =E4=B8=8A=E5=8D=881:32, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> Currently find_mount_root searches for all btrfs filesystems
> mounted and comparing <path> with mnt_dir of each mountpoint.
>=20
> But there are cases when we need to find the mountpoint for a determine=
d
> subvolid or subvol path, and these informations are present in mnt_opts=

> of mntent struct.

Mind to share why we want that?

The main concern here is, I didn't see the point that how the mount
point of a subvolume would affect anything.

Thanks,
Qu

>=20
> This patch adds two arguments to find_mount_root (data and flag). The
> data argument hold the information that we want to compare, and the fla=
g
> argument specifies which field of mntent struct that we want to compare=
=2E
> Currently there is only one flag, BTRFS_FIND_ROOT_PATH, implementing th=
e
> current behavior. The next patch will add a new flag to expand the func=
tionality.
>=20
> Users of find_mount_root were changed, having the data argument the sam=
e
> as path, since they are only trying to find the mountpoint based on pat=
h alone.
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  cmds/receive.c |  3 ++-
>  cmds/send.c    |  6 ++++--
>  common/utils.c | 15 ++++++++++++---
>  common/utils.h |  8 +++++++-
>  4 files changed, 25 insertions(+), 7 deletions(-)
>=20
> diff --git a/cmds/receive.c b/cmds/receive.c
> index 2aaba3ff..dc64480e 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -1079,7 +1079,8 @@ static int do_receive(struct btrfs_receive *rctx,=
 const char *tomnt,
>  	if (realmnt[0]) {
>  		rctx->root_path =3D realmnt;
>  	} else {
> -		ret =3D find_mount_root(dest_dir_full_path, &rctx->root_path);
> +		ret =3D find_mount_root(dest_dir_full_path, dest_dir_full_path,
> +				BTRFS_FIND_ROOT_PATH, &rctx->root_path);
>  		if (ret < 0) {
>  			errno =3D -ret;
>  			error("failed to determine mount point for %s: %m",
> diff --git a/cmds/send.c b/cmds/send.c
> index b8e3ba12..7757f0da 100644
> --- a/cmds/send.c
> +++ b/cmds/send.c
> @@ -329,7 +329,8 @@ static int init_root_path(struct btrfs_send *sctx, =
const char *subvol)
>  	if (sctx->root_path)
>  		goto out;
> =20
> -	ret =3D find_mount_root(subvol, &sctx->root_path);
> +	ret =3D find_mount_root(subvol, subvol, BTRFS_FIND_ROOT_PATH,
> +				&sctx->root_path);
>  	if (ret < 0) {
>  		errno =3D -ret;
>  		error("failed to determine mount point for %s: %m", subvol);
> @@ -659,7 +660,8 @@ static int cmd_send(const struct cmd_struct *cmd, i=
nt argc, char **argv)
>  			goto out;
>  		}
> =20
> -		ret =3D find_mount_root(subvol, &mount_root);
> +		ret =3D find_mount_root(subvol, subvol, BTRFS_FIND_ROOT_PATH,
> +					&mount_root);
>  		if (ret < 0) {
>  			errno =3D -ret;
>  			error("find_mount_root failed on %s: %m", subvol);
> diff --git a/common/utils.c b/common/utils.c
> index 1253e87d..1c264455 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -1248,7 +1248,7 @@ int ask_user(const char *question)
>   * return 1 if a mount point is found but not btrfs
>   * return <0 if something goes wrong
>   */
> -int find_mount_root(const char *path, char **mount_root)
> +int find_mount_root(const char *path, const char *data, u8 flag, char =
**mount_root)
>  {
>  	FILE *mnttab;
>  	int fd;
> @@ -1258,6 +1258,10 @@ int find_mount_root(const char *path, char **mou=
nt_root)
>  	int not_btrfs =3D 1;
>  	int longest_matchlen =3D 0;
>  	char *longest_match =3D NULL;
> +	char *cmp_field =3D NULL;
> +	bool found;
> +
> +	BUG_ON(flag !=3D BTRFS_FIND_ROOT_PATH);
> =20
>  	fd =3D open(path, O_RDONLY | O_NOATIME);
>  	if (fd < 0)
> @@ -1269,8 +1273,13 @@ int find_mount_root(const char *path, char **mou=
nt_root)
>  		return -errno;
> =20
>  	while ((ent =3D getmntent(mnttab))) {
> -		len =3D strlen(ent->mnt_dir);
> -		if (strncmp(ent->mnt_dir, path, len) =3D=3D 0) {
> +		cmp_field =3D ent->mnt_dir;
> +
> +		len =3D strlen(cmp_field);
> +
> +		found =3D strncmp(cmp_field, data, len) =3D=3D 0;
> +
> +		if (found) {
>  			/* match found and use the latest match */
>  			if (longest_matchlen <=3D len) {
>  				free(longest_match);
> diff --git a/common/utils.h b/common/utils.h
> index 119c3881..449e1d3e 100644
> --- a/common/utils.h
> +++ b/common/utils.h
> @@ -52,6 +52,11 @@
>  #define UNITS_HUMAN			(UNITS_HUMAN_BINARY)
>  #define UNITS_DEFAULT			(UNITS_HUMAN)
> =20
> +enum btrfs_find_root_flags {
> +	/* check mnt_dir of mntent */
> +	BTRFS_FIND_ROOT_PATH =3D 0
> +};
> +
>  void units_set_mode(unsigned *units, unsigned mode);
>  void units_set_base(unsigned *units, unsigned base);
> =20
> @@ -93,7 +98,8 @@ int csum_tree_block(struct btrfs_fs_info *root, struc=
t extent_buffer *buf,
>  int ask_user(const char *question);
>  int lookup_path_rootid(int fd, u64 *rootid);
>  int get_btrfs_mount(const char *dev, char *mp, size_t mp_size);
> -int find_mount_root(const char *path, char **mount_root);
> +int find_mount_root(const char *path, const char *data, u8 flag,
> +		char **mount_root);
>  int get_device_info(int fd, u64 devid,
>  		struct btrfs_ioctl_dev_info_args *di_args);
>  int get_df(int fd, struct btrfs_ioctl_space_args **sargs_ret);
>=20


--81iTdN20vvQhMhMbHVxKZq4QaRAL61jid--

--ce08DO9rPG2ySgtyLIB5WnDUrBCuld7Iz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+3fNQACgkQwj2R86El
/qhJqgf/VsOlt/s7aJDUIj9iOea6BekAq6urSeRyCQQVcEK+ZeU1umDlI7PoyGTs
ihzYtI47BSLZEAN/5gZTUPChOjT9eGC4MH5Em9SxtvfaIMiPykFsoTXoM77W2A9R
9cVFXT+8EPpataDmuABQFKIfsvkxsT4VtuCrODP6h8X/ovN7RXo8ro8I+9R0TgIN
6vVmEI7X5qSu3IeZEmWOEY5/640XGgljNSCGzezqwqVqqwE8hulEyaUk+35x8Lgn
ziVAsICRVbEYRNJG3lcG6FizOi+CBTLWxIi9hQVwU8LeU3Z8lOUQKMhKMjPs2vTO
gJro+212u6KPrLMFK4k0gpm7Fde51w==
=/uZd
-----END PGP SIGNATURE-----

--ce08DO9rPG2ySgtyLIB5WnDUrBCuld7Iz--
