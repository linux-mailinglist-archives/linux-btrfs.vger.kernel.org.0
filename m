Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E2B1730C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2019 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfEHIAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 May 2019 04:00:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:47233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfEHIAg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 May 2019 04:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557302429;
        bh=r0ybloxOOg9elCXnH8F8VP2E3zpNWFNsXPkLdw/9yZQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LlqaCGu2NY6cFZ63y6QQM8XH6y2fMpQbjuCWXp1n8f2egSruCRU7d/plMHor+VIoe
         HpD5W13GkeZeYzzBqs+XNLnjWkojGl1TwJZOTLUac2gBq2BA+HPfC8Bc6GzApgIvq5
         VpSp8I1AS65FXrroSpyF/kkbwx0saLKIfpkfJcBA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LevUh-1gwPbQ2svf-00qmMl; Wed, 08
 May 2019 10:00:29 +0200
Subject: Re: [PATCH 2/2] Btrfs: teach tree-checker to detect file extent items
 with overlapping ranges
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20190506154412.20147-1-fdmanana@kernel.org>
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
Message-ID: <06d11795-ae11-e2bf-1ce6-ad4b0e04d02f@gmx.com>
Date:   Wed, 8 May 2019 16:00:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506154412.20147-1-fdmanana@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dKLr8bD8KaxZL4l20O4bjqsS81V9yQW9m"
X-Provags-ID: V03:K1:gnfh3rGYLn/wqxp0WygbNTed47IC8CSR0V5tZ6pAq2j9Ns+sOoC
 f7+42SIWAF7no3YIVv7gZNoPhe552lNUdWEFTSQqS0tKPw6BMFZwfSX41+YD1wVWvsZJJiQ
 KC/yzm3KOHJnBoSGvJl8+iwMuFBCHKFq6r+UePsO3ASBznPvcvN2isS9Nnh4tQLIAyqcME/
 49oQ6idEUwTC3ExF0Wptg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F5/0VQBVGII=:nFLGBycw0ZfFU+AYedytY1
 JYQ4TArcgj9rKT3tS+gKj36ncS/Im1Z9G+ZfJnsQN7ttk08iZQvcgiSgxTxh4+9fYcBrE3tgk
 ckP5jMkir/rKK5zWiPmoovkkuKjoifC7iu5Aj+UbCmGuH67CUG++CgrAqZtGXWgrlIxtOyQNU
 9F1Uleskhj5gyXAWo/eZbtqeOffHUYTFtvskNqPJFPJ0cIiz+THp9t3JemnrtnPQ9zpfWrXh6
 SG+8vAKS1EmXAmny7L/+7TcF9C9XKlkkZIcm2eN/UhbaPqSDBtFI5QBnpIhMr/19u+BtJ1GzK
 rjfqu5WU/lZMUiARtsdE5yhNRuQFBhO1Q7euT3sbK0yeG99GuxkXncAVPtQmnwIM/igYQ7TJ/
 ZBNmsIvbNrYQZsjnnB1EUmQEyhqqJrtJSAA35xXS1Md8Yg/lpUezjNcn85on4YbY8G1SIyEXl
 jmEd15LY/7n04g0iyZaLY37RiKwgumLTFyY1KI3hpJ8QgdIN43ki4d6MokCCAs/RGSI6IACKF
 nJybTC9W1N3KPKKJQJY788I9gSFTylmdqPCbyPmPO2BvROrgCJbwdd4PbbStIkAtjmL6G7/mO
 XsfTAyvcXzRLW6RGnF7Avb7403zU7Xzs1ptLkdfq3JhmPc5Ennmh0ljryQrtbmDs3iJQQeawx
 5jEWnGWoUYi8FfpSiYWKVAm9BmxlR9oBky+gLyy6SfyQa3mFbvePsE9ECwXT+Tr54Xhf5aSFR
 iOIONwyda7uDbBrfKu8fWHWWUqye9so/Bczx3vXVYFpMQwdoVpD4H9gErVjHffNWH5zzv16Rn
 3TSpXmjnPakkZeycWzDporb3PqQEHImA7U1QcwZ5G9H2x5iFfgQcyhua4AxoIxS00vk5xPcdt
 N2S5SSP7ZknFusLZmLPVFRBY4XZGECaCaMiccF529T+CesSonxJ4/SSpwbYCX5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dKLr8bD8KaxZL4l20O4bjqsS81V9yQW9m
Content-Type: multipart/mixed; boundary="HBa5o6to8U1ngreZ1VHbgQqaBRRb7CTdf";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Message-ID: <06d11795-ae11-e2bf-1ce6-ad4b0e04d02f@gmx.com>
Subject: Re: [PATCH 2/2] Btrfs: teach tree-checker to detect file extent items
 with overlapping ranges
References: <20190506154412.20147-1-fdmanana@kernel.org>
In-Reply-To: <20190506154412.20147-1-fdmanana@kernel.org>

--HBa5o6to8U1ngreZ1VHbgQqaBRRb7CTdf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/6 =E4=B8=8B=E5=8D=8811:44, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Having file extent items with ranges that overlap each other is a serio=
us
> issue that leads to all sorts of corruptions and crashes (like a BUG_ON=
()
> during the course of __btrfs_drop_extents() when it traims file extent
> items). Therefore teach the tree checker to detect such cases. This is
> motivated by a recently fixed bug (race between ranged full fsync and
> writeback or adjacent ranges).
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

It's better than my previous patch which only checks overflow.

This one also compare with previous extent.

Thanks,
Qu

> ---
>  fs/btrfs/tree-checker.c | 51 +++++++++++++++++++++++++++++++++++++++++=
++++----
>  1 file changed, 47 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index a62e1e837a89..093cef702a4b 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -104,9 +104,27 @@ static void file_extent_err(const struct btrfs_fs_=
info *fs_info,
>  	(!IS_ALIGNED(btrfs_file_extent_##name((leaf), (fi)), (alignment)));  =
 \
>  })
> =20
> +static u64 file_extent_end(struct extent_buffer *leaf,
> +			   struct btrfs_key *key,
> +			   struct btrfs_file_extent_item *extent)
> +{
> +	u64 end;
> +	u64 len;
> +
> +	if (btrfs_file_extent_type(leaf, extent) =3D=3D BTRFS_FILE_EXTENT_INL=
INE) {
> +		len =3D btrfs_file_extent_ram_bytes(leaf, extent);
> +		end =3D ALIGN(key->offset + len, leaf->fs_info->sectorsize);
> +	} else {
> +		len =3D btrfs_file_extent_num_bytes(leaf, extent);
> +		end =3D key->offset + len;
> +	}
> +	return end;
> +}
> +
>  static int check_extent_data_item(struct btrfs_fs_info *fs_info,
>  				  struct extent_buffer *leaf,
> -				  struct btrfs_key *key, int slot)
> +				  struct btrfs_key *key, int slot,
> +				  struct btrfs_key *prev_key)
>  {
>  	struct btrfs_file_extent_item *fi;
>  	u32 sectorsize =3D fs_info->sectorsize;
> @@ -185,6 +203,28 @@ static int check_extent_data_item(struct btrfs_fs_=
info *fs_info,
>  	    CHECK_FE_ALIGNED(fs_info, leaf, slot, fi, offset, sectorsize) ||
>  	    CHECK_FE_ALIGNED(fs_info, leaf, slot, fi, num_bytes, sectorsize))=

>  		return -EUCLEAN;
> +
> +	/*
> +	 * Check that no two consecutive file extent items, in the same leaf,=

> +	 * present ranges that overlap each other.
> +	 */
> +	if (slot > 0 &&
> +	    prev_key->objectid =3D=3D key->objectid &&
> +	    prev_key->type =3D=3D BTRFS_EXTENT_DATA_KEY) {
> +		struct btrfs_file_extent_item *prev_fi;
> +		u64 prev_end;
> +
> +		prev_fi =3D btrfs_item_ptr(leaf, slot - 1,
> +					 struct btrfs_file_extent_item);
> +		prev_end =3D file_extent_end(leaf, prev_key, prev_fi);
> +		if (prev_end > key->offset) {
> +			file_extent_err(fs_info, leaf, slot - 1,
> +"file extent end range (%llu) goes beyond start offset (%llu) of the n=
ext file extent",
> +					prev_end, key->offset);
> +			return -EUCLEAN;
> +		}
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -453,13 +493,15 @@ static int check_block_group_item(struct btrfs_fs=
_info *fs_info,
>   */
>  static int check_leaf_item(struct btrfs_fs_info *fs_info,
>  			   struct extent_buffer *leaf,
> -			   struct btrfs_key *key, int slot)
> +			   struct btrfs_key *key, int slot,
> +			   struct btrfs_key *prev_key)
>  {
>  	int ret =3D 0;
> =20
>  	switch (key->type) {
>  	case BTRFS_EXTENT_DATA_KEY:
> -		ret =3D check_extent_data_item(fs_info, leaf, key, slot);
> +		ret =3D check_extent_data_item(fs_info, leaf, key, slot,
> +					     prev_key);
>  		break;
>  	case BTRFS_EXTENT_CSUM_KEY:
>  		ret =3D check_csum_item(fs_info, leaf, key, slot);
> @@ -620,7 +662,8 @@ static int check_leaf(struct btrfs_fs_info *fs_info=
, struct extent_buffer *leaf,
>  			 * Check if the item size and content meet other
>  			 * criteria
>  			 */
> -			ret =3D check_leaf_item(fs_info, leaf, &key, slot);
> +			ret =3D check_leaf_item(fs_info, leaf, &key, slot,
> +					      &prev_key);
>  			if (ret < 0)
>  				return ret;
>  		}
>=20


--HBa5o6to8U1ngreZ1VHbgQqaBRRb7CTdf--

--dKLr8bD8KaxZL4l20O4bjqsS81V9yQW9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzSjJYACgkQwj2R86El
/qhPDwgAgFInZwICg5vuFrNpFm/bS7swhawvHY3MvFsrtXqeKtqV0o7cKy/C5ddK
HbqOy4JUcffbLWnTSjoXtbhkPw3fW3eRidkhHf5+3wPn/fDEid85LyAWpAY/EOf+
dg6tH8jmcBOGDLp40ynJXL4Q/OoowBzWNO1F0llE0DS3ZUQgdKcVy1qlp4QPxIRt
T4jn4NgVvjAyI76uvaIZwVTMDpWDZcO9rl6yrq7t6rHR6Gg4EOqodPbf8+bawbRK
KWAIhuUYYQP/wk9ARP/SPM2iC5LRYr9Mz31WthkrToBDq28NRhxxayZUutA/qpkT
T1CmQjcxCd6dRB8uC2+xTTA2H9JjqA==
=snaO
-----END PGP SIGNATURE-----

--dKLr8bD8KaxZL4l20O4bjqsS81V9yQW9m--
