Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA59113C3F
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 08:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfLEHWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 02:22:49 -0500
Received: from mout.gmx.net ([212.227.17.22]:39627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfLEHWs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 02:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575530567;
        bh=8fm3oUqIY7o17TDSjOliY8MrRhNl9+1BEvhzf3TCH0k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=K0c0BQ23nFxWNoW64fA1/waLvhtUThwd78yNfHwLpPuqoHBROMcdkvNFaENZYWJBu
         fYWN+Bzrxhodoki+PC5tUSpuwPOWvNeL2KM6BueRboi8ERdeELluRUArV8Is/YQe9L
         FL+hdslemNL+EP7lIboOkflq5qvvv4vaNwFdVrxk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBlxM-1iSqOA0sM0-00C86J; Thu, 05
 Dec 2019 08:22:46 +0100
Subject: Re: [PATCH 02/10] btrfs-progs: block_group: add rb tree related
 memebers
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-3-Damenly_Su@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <eb8ada00-32b7-93ca-15e4-01d481656ba6@gmx.com>
Date:   Thu, 5 Dec 2019 15:22:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205042921.25316-3-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Z6gvxpEVU3ySuhrRDeuzAw0Ab7HWyqNUM"
X-Provags-ID: V03:K1:AzUNgeKXcR0HaTUnyVUQVrm5ZuZBIYrSNpd1778r1hriyq7oJUA
 qfO7nC5E80UGM8WCcduJo0SiCQEaLOeRcRjiTHF+a5X6qryQ7VmCehYt5e4C3OTHBmX/mqf
 ugLnDHICVWC5j3Dpq8ShMiHTa12//XBNH9UrDnWPzOuxpNSNqmtaC63FOiVZZRi12mMFlVU
 gDs6Wfr0Y6aBc/JpiPFzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XyoG6BY9cDE=:Ps+C55Yam0xN0U7Rhidv+C
 9sWlN3ceRVRJHl4BfV0EYjCv6MpzRDdrNCjH2aAXBcw768DLwuunle+K/s5B22bCMU6mU0R4z
 6p9VtEuaCr8eEP3JnPSAl3JPWMcrlFJ531qJWTrWHvGTsZHgjBpknpF1XMKDVZmZmDdHeDx10
 9hSkHbr4MSbQ++dOEcmd3qFWRTl5nCjvlYQpBoLxIDq9Qv7oMXewldc7CP0sUDMv2ihjs/Nuo
 Dtk7MqwZI5DwpBakRKxLq8DY4xzkP2+DO0IyfAkUGuGcX1EQ2/8WwR24DlwphUQPUUL5OAbmy
 5R/mbE3xpA9I4Hey8giWsZUxbCYgHKYQfQgdKEbJT4sspfHTL9qT5cu0Pr9on/AnYAUXselYz
 2VDIvdBbNLUHW614LlKs4pBNZbWKe/JKqys2zcBsXpaWMporyHhRa1CKNtVxho5kYCh5iEoqY
 izx8rxBNIFHiafhQiKEGljyyJe3XCJwRJnV6mrhWm6QVLqa9bMW6oys2hIFBnB4O+BoJyWtTW
 3xeda2GjxmLkc6gNJA0KWBVQX1uxWvqrMgoG9M3KdnB8L1vhnhOK5T+WMR9WfJvgb5Exot8bu
 akSPUgve5EfYCm1Rs820b9AQFTKaS5IjyrkdxYHvcmZXnhcykojabTLJK0FWi3Qexi+9UY6X1
 1I/YUlj3G2PyuOsiHjVp4NTaokfyU3q61GaZj4F0MOkbughpDn98T6aUplG9+NlBp2+mhKH0G
 h8ueNUMHZVvil3UCEPZX/CyRFwj8Xo4HIsFNw9+VHSPw2wEUGrJkeE/cm2aSwJeRMfZCBNUan
 IOqyKvVlhKbW0zux+vJt2nsDHKwSeI8aO9frDKs4iarhY0VacEo3Qv2VWw3kHImaWAq6Aihi3
 sCjwd/A+k05JRUbukkbaqKqjtwtsJwe3yo5siZ9bd89+lthqr6w1EtzEuckJbskbn9H3PRPda
 SpYys6motL3eV0+px2FpEp3SNGvr5nduFrF+b3QjSyRS6ozmaUZYZQ7ak3hYMHJzOcRTJVQwS
 yltScngeBIOuOjP9dxk3IdfZ+q6wYmM+MjuhfWUAeaniR+N9fXkWSWlMiHtFVS2r6t3SBY4ar
 dTBqi9MtKUx3TshPQEkBmpmtwePpqmIyvj6BwSvIKY3i8mLtz6XcEKJ2zbLBjuwKCyvfaAPlJ
 Ry2n4gvkzaHfQwuhFz8pz0KIDFIgmMDV8nX4RjMxpOy831IkVsipDk/EGVrU22XxVIQIL0jKD
 BVGvV5SUdLa1UR0zlVTbzIhMyj6oWP0Ce78jBwbjlFC7cwoYT3T82Z6lh9Hk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z6gvxpEVU3ySuhrRDeuzAw0Ab7HWyqNUM
Content-Type: multipart/mixed; boundary="gmVwHyJJxyB0iyJjbtwWcyEn0VZZ9ExhC"

--gmVwHyJJxyB0iyJjbtwWcyEn0VZZ9ExhC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> To convert from existed extent_cache to plain rb_tree, add
> btrfs_block_group_cache::cache_node and btrfs_fs_info::block_group_
> cache_tree.
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  ctree.h   | 21 ++++++++++++---------
>  disk-io.c |  2 ++
>  2 files changed, 14 insertions(+), 9 deletions(-)
>=20
> diff --git a/ctree.h b/ctree.h
> index 3e50d0863bde..f3f5f52f2559 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -1107,16 +1107,18 @@ struct btrfs_block_group_cache {
>  	int cached;
>  	int ro;
>  	/*
> -         * If the free space extent count exceeds this number, convert=
 the block
> -         * group to bitmaps.
> -         */
> -        u32 bitmap_high_thresh;
> -        /*
> -         * If the free space extent count drops below this number, con=
vert the
> -         * block group back to extents.
> -         */
> -        u32 bitmap_low_thresh;
> +	 * If the free space extent count exceeds this number, convert the bl=
ock
> +	 * group to bitmaps.
> +	 */
> +	u32 bitmap_high_thresh;
> +	/*
> +	 * If the free space extent count drops below this number, convert th=
e
> +	 * block group back to extents.
> +	 */
> +	u32 bitmap_low_thresh;
> =20
> +	/* Block group cache stuff */
> +	struct rb_node cache_node;
>  };
> =20
>  struct btrfs_device;
> @@ -1146,6 +1148,7 @@ struct btrfs_fs_info {
>  	struct extent_io_tree extent_ins;
>  	struct extent_io_tree *excluded_extents;
> =20
> +	struct rb_root block_group_cache_tree;
>  	/* logical->physical extent mapping */
>  	struct btrfs_mapping_tree mapping_tree;
> =20
> diff --git a/disk-io.c b/disk-io.c
> index 659f8b93a7ca..b7ae72a99f59 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -797,6 +797,8 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writabl=
e, u64 sb_bytenr)
>  	extent_io_tree_init(&fs_info->block_group_cache);
>  	extent_io_tree_init(&fs_info->pinned_extents);
>  	extent_io_tree_init(&fs_info->extent_ins);
> +
> +	fs_info->block_group_cache_tree =3D RB_ROOT;
>  	fs_info->excluded_extents =3D NULL;
> =20
>  	fs_info->fs_root_tree =3D RB_ROOT;
>=20


--gmVwHyJJxyB0iyJjbtwWcyEn0VZZ9ExhC--

--Z6gvxpEVU3ySuhrRDeuzAw0Ab7HWyqNUM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3osEEXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhR5wf8CwogVDBMRN4JSC7MeGA11VgO
zueyQ6rsJVQW6qLjVxn4dL+09xCZI+sXKN9yudlM6IS56xwMxZEDmnu6cF5BuUuG
ioVrxJ68XcsAkTRRr3aFnbSDyd4CshMTeo5FWvchpS/nPOgpKH2pbHWKFe31Zm5d
xBFnqVHep6y7SHXSk9MLv3R0NHJom32cjTcBaAIpxtLxqLMzEWLAoIrLRIXAg9V2
BkWaGk0YcvLFLU3djDXl9txHT+rMZaBeURYJMwrw5ut915oVibJel3QfwjQzo+Vo
KtIN3JX4ytytvA/4ETVEdPnt6EQHHkf+IFSfVj3wuG87+OaFija0X4iDQFvt+A==
=Ya3a
-----END PGP SIGNATURE-----

--Z6gvxpEVU3ySuhrRDeuzAw0Ab7HWyqNUM--
