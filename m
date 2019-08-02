Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F397FB95
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbfHBNyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:54:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:46657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730391AbfHBNyW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564754057;
        bh=j6eZ4wAXQtjovdP/lTs3B2tm9ZitghIx+Sy1/Ora6rQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jlyI8FY5xzeusLBZIt0R5HcuECzRbAiLjgNlR9nB0Q+RAC5ESo/AAcdBpwBb4u2jQ
         WtseUauK/TvAZz0SplC8HjIHC4FkZpDX7NWH9JowdFo2OO50KsPjlv7tjYdU+O8QR0
         tqTlVH3ysUCdLSOOvmY+XieeCK11Js3a2Q0qEHuQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mz9Un-1iGSaJ13aN-00wILh; Fri, 02
 Aug 2019 15:54:17 +0200
Subject: Re: [PATCH] btrfs-progs: add a --check-bg-usage option to fsck
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20190802130635.3698-1-josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <c4ffca4b-f2a2-b570-5354-c13ac46154fd@gmx.com>
Date:   Fri, 2 Aug 2019 21:54:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802130635.3698-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cuHOHb1HHfDvcwAg1yGCVH0cdTHP83LvI"
X-Provags-ID: V03:K1:fr/Mg3WnOyZ86ETJ8cMhsTWH/DrlRG9aMvTheuZ8u8QkTtPiOT1
 cwyInd3h8N4AfV7d846LzjLbKsLrQQLvPRJahs7tISTAwldyIbogfMpDcW8I2PqT9p9Vif7
 9uaAemewEa7aZhuqcYH5BrTrKuTinR6nXGe7C6hStkgV1pXyS8S7PsBTZH+YeG/o7k0LKpK
 UPslpZ0otX7bvPKhWKgfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RLy4PU9989c=:DTpr1i4cXMqBrQOXU0e2TO
 /epwdbLkJyWc3EyeeWkXkL2vW6nLaD9Bpx7bXsFWMeTf6bXa9yptYu6LH5chCKqoYAkRtsPWY
 ty0upaAen/G75AjbY9pAN8MIwok+JFvmudgHkzscSu3peNhW2mUde64WlAhJ0JulnmVm88aUk
 j9ZWBXURXwOfiK7O5DHNTHPufUXZru2DdFDt3vKR1YGSmQoySF52h94iyg0b2lUMsGAYKFXY+
 YE7tibWODLbFVV8xWMPJrUo2T6vXDpQCMPrBqXwtvOTgQAinQtsLGc1yVP4GSoBABvQkO1ALE
 0Zimm6Xk8dP/8iVZSgU84Bmy86eXXVxDs/DL885QCdFHkD3ejSMc8kp6erK55xUn5F2WT7n1a
 zNuJH9q1+YLbQrsqp651wYe45oo4buRpZHVi6slNvhU03jjF6+csKe7aW30LftAwT1eIrsLj2
 LARcqDb2LsPZ+OW4UI4yfIXhiHShHLk+dT8+WnB52QPAYmdBecVKYnMSg+fFiEpgsN8zI1gTr
 sIKwxCxSWaIO+J29kFxfM2wrzbGmJICi0jwHUu19ucluHksuXYZ9TD9erN/7+G9LpcTsCehwc
 YDxXeToYwo+49Lr2WRKmjwRdx+nr3f7Zrq1ghdv/jm08D0FDptshl5/sMbP/lKnIJv8Y/PM0Y
 iSj78DKN2vV85/KH+gCl8u2ENe9XrIllOsRnNR8bdUP18a1tfNc5eOxgmRYraH4zPgyPRUBmX
 ZtfbsjDFH6YsjqQ2Ko4gBOvsXcWQoXzmu1OZH+RQ5dsrK2Xnxsb5yM6mW8yUGiq1vN3wOsOX8
 /K4PkPhLaNYd1SRA8Kf6iv/SZwtTu32zkn8QWcxWCd9oU1bpPFVjPd7qqXFgi2lUV0y0rmYc+
 SSLvYR0OoJV+KJLAYIo6ZgPemsa6bgaDbFq76KAOHkQwaMh0Ch4+P8bQz9HMn/UHeJfPNZwlR
 urrO4gOhddoRUBIWh7O9dM86ONmB1xFX1ec6DCIM+vi0gkHH0d3hTI0BW4bNfYOMaA8iCmjsW
 +DlfumLxDk49+ApIW8Xbqdd7LZqEFvkQ8uhYV3cMEGMK3vT/PPPyI/U11ccHZ14z8TV0CQaHh
 PbOCYBk3EO1koWhtJoa68p0u8YYfceamMnlsyFqBD1yOQQEli3pgKp96Q==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cuHOHb1HHfDvcwAg1yGCVH0cdTHP83LvI
Content-Type: multipart/mixed; boundary="t2VU053wi0J7OF0svGALkxheXPbLY6o8R";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
Message-ID: <c4ffca4b-f2a2-b570-5354-c13ac46154fd@gmx.com>
Subject: Re: [PATCH] btrfs-progs: add a --check-bg-usage option to fsck
References: <20190802130635.3698-1-josef@toxicpanda.com>
In-Reply-To: <20190802130635.3698-1-josef@toxicpanda.com>

--t2VU053wi0J7OF0svGALkxheXPbLY6o8R
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/2 =E4=B8=8B=E5=8D=889:06, Josef Bacik wrote:
> Sometimes when messing with the chunk allocator code we can end up
> over-allocating chunks.  Generally speaking I'll notice this when a
> random xfstest fails with ENOSPC when it shouldn't, but I'm super
> worried that I won't catch a problem until somebody has a fs completely=

> filled up with empty block groups.  Add a fsck option to check for too
> many empty block groups.  This way I can set FSCK_OPTIONS=3D"-B" to cat=
ch
> cases where we're too aggressive with the chunk allocator but not so
> aggressive that it causes problems in xfstests.
>=20
> Thankfully this doesn't trip up currently, so this will just keep me
> from regressing us.  Thanks,

I think the empty bg check is valid.

Although I hope this check can be a warning for default check, and a new
option to report too many empty bgs as error.

>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  btrfsck.h    |  1 +
>  check/main.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++--=

>  2 files changed, 51 insertions(+), 2 deletions(-)
>=20
> diff --git a/btrfsck.h b/btrfsck.h
> index ac7f5d48..5e779075 100644
> --- a/btrfsck.h
> +++ b/btrfsck.h
> @@ -44,6 +44,7 @@ struct block_group_record {
>  	u64 offset;
> =20
>  	u64 flags;
> +	u64 used;
>  };
> =20
>  struct block_group_tree {
> diff --git a/check/main.c b/check/main.c
> index 0cc6fdba..a3ff3791 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -62,6 +62,7 @@ int no_holes =3D 0;
>  static int is_free_space_tree =3D 0;
>  int init_extent_tree =3D 0;
>  int check_data_csum =3D 0;
> +int check_bg_usage =3D 0;
>  struct btrfs_fs_info *global_info;
>  struct task_ctx ctx =3D { 0 };
>  struct cache_tree *roots_info_cache =3D NULL;
> @@ -5126,6 +5127,7 @@ btrfs_new_block_group_record(struct extent_buffer=
 *leaf, struct btrfs_key *key,
> =20
>  	ptr =3D btrfs_item_ptr(leaf, slot, struct btrfs_block_group_item);
>  	rec->flags =3D btrfs_disk_block_group_flags(leaf, ptr);
> +	rec->used =3D btrfs_disk_block_group_used(leaf, ptr);
> =20
>  	INIT_LIST_HEAD(&rec->list);
> =20
> @@ -8522,6 +8524,41 @@ out:
>  	return ret;
>  }
> =20
> +static int check_block_group_usage(struct block_group_tree *block_grou=
p_cache)
> +{
> +	struct block_group_record *bg_rec;
> +	int empty_data =3D 0, empty_metadata =3D 0, empty_system =3D 0;
> +	int ret =3D 0;
> +
> +	list_for_each_entry(bg_rec, &block_group_cache->block_groups, list) {=

> +		if (bg_rec->used)
> +			continue;
> +		if (bg_rec->flags & BTRFS_BLOCK_GROUP_DATA)
> +			empty_data++;
> +		else if (bg_rec->flags & BTRFS_BLOCK_GROUP_METADATA)
> +			empty_metadata++;
> +		else
> +			empty_system++;
> +	}
> +
> +	if (empty_data > 1) {
> +		ret =3D -EINVAL;
> +		fprintf(stderr, "Too many empty data block groups: %d\n",
> +			empty_data);
> +	}
> +	if (empty_metadata > 1) {
> +		ret =3D -EINVAL;
> +		fprintf(stderr, "Too many empty metadata block groups: %d\n",
> +			empty_metadata);
> +	}
> +	if (empty_system > 1) {
> +		ret =3D -EINVAL;
> +		fprintf(stderr, "Too many empty system block groups: %d\n",
> +			empty_system);
> +	}

This hard coded threshold (1) is too vague and maybe too restrict.
What will happen for things like a lot of data got removed and cleaner
didn't get kicked in quickly enough before unmount?

Thanks,
Qu

> +	return ret;
> +}
> +
>  static int check_chunks_and_extents(struct btrfs_fs_info *fs_info)
>  {
>  	struct rb_root dev_cache;
> @@ -8630,6 +8667,12 @@ again:
>  		err =3D ret;
>  	}
> =20
> +	if (check_bg_usage) {
> +		ret =3D check_block_group_usage(&block_group_cache);
> +		if (ret)
> +			err =3D ret;
> +	}
> +
>  	ret =3D check_extent_refs(root, &extent_cache);
>  	if (ret < 0) {
>  		if (ret =3D=3D -EAGAIN)
> @@ -9810,6 +9853,7 @@ static const char * const cmd_check_usage[] =3D {=

>  	"       -E|--subvol-extents <subvolid>",
>  	"                                   print subvolume extents and shari=
ng state",
>  	"       -p|--progress               indicate progress",
> +	"       -B|--check-bg-usage         check for too many empty block gr=
oups",
>  	NULL
>  };
> =20
> @@ -9841,7 +9885,7 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
>  			GETOPT_VAL_INIT_EXTENT, GETOPT_VAL_CHECK_CSUM,
>  			GETOPT_VAL_READONLY, GETOPT_VAL_CHUNK_TREE,
>  			GETOPT_VAL_MODE, GETOPT_VAL_CLEAR_SPACE_CACHE,
> -			GETOPT_VAL_FORCE };
> +			GETOPT_VAL_FORCE};
>  		static const struct option long_options[] =3D {
>  			{ "super", required_argument, NULL, 's' },
>  			{ "repair", no_argument, NULL, GETOPT_VAL_REPAIR },
> @@ -9864,10 +9908,11 @@ static int cmd_check(const struct cmd_struct *c=
md, int argc, char **argv)
>  			{ "clear-space-cache", required_argument, NULL,
>  				GETOPT_VAL_CLEAR_SPACE_CACHE},
>  			{ "force", no_argument, NULL, GETOPT_VAL_FORCE },
> +			{ "check-bg-usage", no_argument, NULL, 'B' },
>  			{ NULL, 0, NULL, 0}
>  		};
> =20
> -		c =3D getopt_long(argc, argv, "as:br:pEQ", long_options, NULL);
> +		c =3D getopt_long(argc, argv, "as:br:pEQB", long_options, NULL);
>  		if (c < 0)
>  			break;
>  		switch(c) {
> @@ -9875,6 +9920,9 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
>  			case 'b':
>  				ctree_flags |=3D OPEN_CTREE_BACKUP_ROOT;
>  				break;
> +			case 'B':
> +				check_bg_usage =3D 1;
> +				break;
>  			case 's':
>  				num =3D arg_strtou64(optarg);
>  				if (num >=3D BTRFS_SUPER_MIRROR_MAX) {
>=20


--t2VU053wi0J7OF0svGALkxheXPbLY6o8R--

--cuHOHb1HHfDvcwAg1yGCVH0cdTHP83LvI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1EQIQACgkQwj2R86El
/qj2+wf9GIT0m/sulwuYo6F29mQDis5ZWEDWVvd+fNcKPHjQGJ+KzSe206Cw6dSw
RXUcwO5B5aMNIPSEbhlw1VGgp7+4MeD8++ZNxwh7KbVC9JcJNDrqu0vuDwn/ftkO
UClAO3wavS69gLi5D6mFtBR5kMu5Bbqc6AbzU/rYozkaidKeFut7iVcSs4sWjAur
b4nfVfQjCU46HOUEMQghflDBLXwFnaEmMVLEIqUe013QPrKzE12cVtO/ckxnPHdF
ECQ9pi8ia0vywsroOD/bMEaC6/EyfUNyE3TcnNZ2lM8PeswPsClqVJ1R2DT9Rtb8
7BGaDG/d3bbytXOCUnLhqdtUgpohBw==
=pdAf
-----END PGP SIGNATURE-----

--cuHOHb1HHfDvcwAg1yGCVH0cdTHP83LvI--
