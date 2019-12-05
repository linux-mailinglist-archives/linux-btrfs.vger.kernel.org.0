Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C1113C59
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 08:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfLEHaG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 02:30:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:36469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfLEHaF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 02:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575531003;
        bh=0y+rJeTNYK4DYwkM/40bZD8G306V2mtTJYuekPru3ck=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=K5m8eY65CGUYzNIWe/ojdDZq2umJlT3F08iTVObUnqJJV0q3MPn18GWDiHCnTHJY7
         +upENkZW2EfSzneaEtDJH/kAfyukpjtkuw0hDXc4aMxCdUXAD0+/OidY59kKxJLOxw
         3lwwWbIDSJdNaCfbEWv+dD5GauhpoVueKBmT2xqI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MoO6M-1hwmuo3Zsm-00oqSb; Thu, 05
 Dec 2019 08:30:03 +0100
Subject: Re: [PATCH 03/10] btrfs-progs: port block group cache tree insertion
 and lookup functions
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-4-Damenly_Su@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d75b62a9-b88b-d44c-16b5-55ebef426534@gmx.com>
Date:   Thu, 5 Dec 2019 15:29:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205042921.25316-4-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BEpEANdMZulxgyCEnC3IOBqetUXb6egcE"
X-Provags-ID: V03:K1:97KkjzCcJ/VRIyIXZ5lHB8elc0MRL19GkWArmgK1XHlSDEuNo1c
 orKP0d5uE/pm4dnynieSv36LTBUzAdu9n+8Bjz1li6ASW+xeLl9HCSDjAccO0NDy5a1K5f8
 qjK3BgZk9pjziGEMwtjKhn/LyCbHuGYvCb6fadGGXOuCQBHpG3VH4kvJSlog8e54UmGf+7x
 lz4QRupJIr6qf6NXF688w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u1orcctnVrw=:Q3iYhOyXaBDwQsQf6Za1vM
 u61htXoJRKMyceC48Q8iErV1s1SiRVX2NrfMbQb6AlCNLqd6sQ367hR9LUO0bhQd7I+xhvxY8
 Qwj8+lMcH3kl7B5d7VU8VpiIdQpUcSa6z3ed9+BdToa1qp2uqHZFXk1ubZJPbodSPmPc5MS1a
 Pi/cVHLzK8yVJgD+/QrVcX3eepnsEMKiWbArWUrcMdZOJ5tEK4ftuKNIO6v/ipSN6a9mK1MdG
 kT9z3Mp6iiU9R3Y6ZeU2bI2IfRsoBo56vKXnlLaerQcmFTRP4NXyS/3NOk6vXopFbSvFzGHmK
 bRq0RFy3+Hso+44KH3Lv5RWaQI731zLlr6nTC5foUjQ1oAqzQaZrPIBHZjanTanyqOMbM2Me9
 A7lZj1Ig8JT8ZJXgjRjFx44QkdIKOYTZDeFwKlFBkyzlctscyizplgffkCMRdJjC3WwR1wHtU
 jvDJRD3rpdan9yCdHygLu9ec7NmmH+U7WHGUYxwoRtC7m8grKM9rTM4mLZW85RtvJwxbtSZyr
 AbO0CdrQVpSh0/znxK9ehk7j3zIJfcREhS9NbZxKAzT+JR5854pbcNX9/VcWPDQ8SegLJMojM
 kSQ9Xeg1nRm6UKI2/PqbXytkvr/FsbRHYsGWzfOM+qwtrHnUQBNC46MBoADG9I5QXwq4yZuVb
 2COhr5UqwfRz5HMlDgbZKMrKsO6YYCD9upz/iW3xlM7UVIdWT2QIhdTCow/AoHrqPleqwGMxI
 MeJLfEi18hLBydXctJFIShHnpL8LcAt2fZRQWnvpa+TJ9Wz8FTRdYydDJOpzwihGCj0fHJrau
 jkJ3uvGBnKvpNUbL4KIdhL+/QQUWcvbjd3U1dB6HQna+QTNTEue0L2AwCJ03DarVweaoEoXhX
 OcEuRiRHIQsygx4GYffUkVlV8h0nXMHvKeIAQ2gW2nrjLr/iEBSSs2M7dkAet2mA47rLKAq00
 waacChYxHGeRV020idblrZJJtyN4dKzmhB3adE3r6JqUPu+QGuFeb006V9xQ4oBBsDph7V+Nz
 qE7xUF4TL/6Lg82ROXDaHHipk9yDnNDuLqzC1mjI93zAL3dL/cLFT1m/sOuKaO8IGkVOlD/Rz
 oH+Wp1sXC9yjEfqxSNnaJQVLfOSIjcCgvA4ok9RuD40aFV/kSnNAmzvE4/xEmTwPv7hWEW3ip
 sZ2pDvMyNSgmdhOdYYxHZf6UD4nif7O1ZTFtBERf2Vht5EsSu6ru6vfEk7kPWB/eT7eUFG8JA
 7Nt2ofEcvhVkCAJ4WS1EaQSKLj1qbAA5c93NWSBGAeHlWExDevgxbgAKBYSM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BEpEANdMZulxgyCEnC3IOBqetUXb6egcE
Content-Type: multipart/mixed; boundary="HQcTif3eQIFaD2WVubnwoyUNLDr0yEfwV"

--HQcTif3eQIFaD2WVubnwoyUNLDr0yEfwV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> Simple copy and paste codes, remove useless lock operantions in progs.
> Th new coming lookup functions are named with suffix _kernel in
> temporary.
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just an extra hint, it would be much better if we backport this
functions to block-group.c.

Thanks,
Qu
> ---
>  extent-tree.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 86 insertions(+)
>=20
> diff --git a/extent-tree.c b/extent-tree.c
> index 4a3db029e811..ab576f8732a2 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -164,6 +164,92 @@ err:
>  	return 0;
>  }
> =20
> +/*
> + * This adds the block group to the fs_info rb tree for the block grou=
p cache
> + */
> +static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
> +				struct btrfs_block_group_cache *block_group)
> +{
> +	struct rb_node **p;
> +	struct rb_node *parent =3D NULL;
> +	struct btrfs_block_group_cache *cache;
> +
> +	p =3D &info->block_group_cache_tree.rb_node;
> +
> +	while (*p) {
> +		parent =3D *p;
> +		cache =3D rb_entry(parent, struct btrfs_block_group_cache,
> +				 cache_node);
> +		if (block_group->key.objectid < cache->key.objectid)
> +			p =3D &(*p)->rb_left;
> +		else if (block_group->key.objectid > cache->key.objectid)
> +			p =3D &(*p)->rb_right;
> +		else
> +			return -EEXIST;
> +	}
> +
> +	rb_link_node(&block_group->cache_node, parent, p);
> +	rb_insert_color(&block_group->cache_node,
> +			&info->block_group_cache_tree);
> +
> +	return 0;
> +}
> +
> +/*
> + * This will return the block group at or after bytenr if contains is =
0, else
> + * it will return the block group that contains the bytenr
> + */
> +static struct btrfs_block_group_cache *block_group_cache_tree_search(
> +		struct btrfs_fs_info *info, u64 bytenr, int contains)
> +{
> +	struct btrfs_block_group_cache *cache, *ret =3D NULL;
> +	struct rb_node *n;
> +	u64 end, start;
> +
> +	n =3D info->block_group_cache_tree.rb_node;
> +
> +	while (n) {
> +		cache =3D rb_entry(n, struct btrfs_block_group_cache,
> +				 cache_node);
> +		end =3D cache->key.objectid + cache->key.offset - 1;
> +		start =3D cache->key.objectid;
> +
> +		if (bytenr < start) {
> +			if (!contains && (!ret || start < ret->key.objectid))
> +				ret =3D cache;
> +			n =3D n->rb_left;
> +		} else if (bytenr > start) {
> +			if (contains && bytenr <=3D end) {
> +				ret =3D cache;
> +				break;
> +			}
> +			n =3D n->rb_right;
> +		} else {
> +			ret =3D cache;
> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +
> +/*
> + * Return the block group that starts at or after bytenr
> + */
> +struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(=

> +		struct btrfs_fs_info *info, u64 bytenr)
> +{
> +	return block_group_cache_tree_search(info, bytenr, 0);
> +}
> +
> +/*
> + * Return the block group that contains the given bytenr
> + */
> +struct btrfs_block_group_cache *btrfs_lookup_block_group_kernel(
> +		struct btrfs_fs_info *info, u64 bytenr)
> +{
> +	return block_group_cache_tree_search(info, bytenr, 1);
> +}
> +
>  /*
>   * Return the block group that contains @bytenr, otherwise return the =
next one
>   * that starts after @bytenr
>=20


--HQcTif3eQIFaD2WVubnwoyUNLDr0yEfwV--

--BEpEANdMZulxgyCEnC3IOBqetUXb6egcE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3osfcXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qh90gf/VzVmjXgav8IhxtyYc+F7aOW5
aCiDB9z2Iev+2kT360fLhjLUFKD5j0r7Z7DuBr7Bi2F7eprMdN0REu2J41Yrb3R9
6OD7CKJH7KgUzFmNltjOQp77zClXp14q1pSIBrNQSKR3gFL3wBRNzvYZLm7hFYs4
j173y6fMTAgo0/GXCmYs/lFx4/Bf1Wqhrgh9SJ3mZvIl3LmeI8w12ZIJhwvZ19qs
492BC9ltJW/3a/N+ARuLo07n9tD9I9eiSDpgbWpL5TIcw3XS9C0iv3LgpZWeFiLb
qsJCYjSHV1mKzOLOS/Dv7zv5ZNctdGTmkdwzsELDJocxRHeKq1ncdyTt49J1Jw==
=Vjzf
-----END PGP SIGNATURE-----

--BEpEANdMZulxgyCEnC3IOBqetUXb6egcE--
