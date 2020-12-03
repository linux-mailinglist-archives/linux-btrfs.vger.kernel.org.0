Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F272CCC46
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgLCCKB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:10:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:59063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgLCCKA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606961304;
        bh=DZzH9gpdVdRzjdDEP226Goh5VXvMTHlzgHvFozDDS+U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IS6jo1fks8Z8FsPnKNCkFi+vN+L8UtQRgg+oFKoxHl+zNA5fhosJXnG7Ka5wqbmmD
         xIDECcZV6UEaRTP+Umdx+zfuUAlXyr2W/E7uYZkeZgnQ+RweQI3pZyu76TPBG3BDvE
         5H9dC2G98fssGV8Orh0EspY0UqASdoNdBH7ozWII=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1kIlHe0dP0-00kzdP; Thu, 03
 Dec 2020 03:08:24 +0100
Subject: Re: [PATCH v3 06/54] btrfs: do not cleanup upper nodes in
 btrfs_backref_cleanup_node
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <5baef1129ee209bc9d31fc46972bb8df3f7dd4f2.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <8960c0d8-7cef-bc55-97db-be48bc916a9b@gmx.com>
Date:   Thu, 3 Dec 2020 10:08:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5baef1129ee209bc9d31fc46972bb8df3f7dd4f2.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9pQpD6ZYCHn2rCNSrceE6UnQkHlHCmcsk"
X-Provags-ID: V03:K1:2XMCACNe4thMgulvcJzaVteDBebfJ0lu7b+8SddabE4/Vc3oxB1
 Nm4Abv8GjxRcqDQH47UTo3/UmaqdYTSeYohpHT8Y6heUx+T2ZTbUsVcxc+Bk3iJtyzcs3kC
 lbIt0d2TG1opIusA6PvYnceLv3q1DdSwbb59kf8bb82WPQoQXWK1jdSCLWNvKI9XVabwTRH
 DAn6ZLJ/92LU3uaAvdVsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S4UeWj7hd+U=:BFE/ynMG2mKi09JfAgPTqV
 AcBAJZU/rb/J4Wrqky0ant5P5+JFkqFz0uKF7+bKSw5AsutT9IkNejuCkYuFd0zcqn3Ey/RY7
 oyDdIQshE7Lio9uDV1cnU2AYvxOZoqG8GOJPu3WdRRHKx8rmgobdND9E3qWbnNwByq/hWks8c
 e3WmvfXWXSlLH2M02BXliET8e/BgsweawCEbd6vcFU3DOHniwU/P07H1QsvrI8i/4zrEhusLz
 YMsDmsa0q57yRbCFSckzQxEUxB5xArWU9gYLNrU+S+f5Ddv+Qv69NSbHXrQlq52LGKrYzaRfg
 emqFskGWXgXbf1MCGD6s0NP/4e+dcNwykOgULH/agO/fcqSdQjnx0KR7o9JvuHh/nMRq+bTgq
 AOII09CysIbgF1RHabXKX7i4ldoR+CiCtCTipshlN9TyalYyOchI/JE//1uJw+1Rj4/gk0Mlg
 woa1NA1YoQMlwHfBTwowTxtHn0NfBGj2c7VayMTOG23PePtX907B4N4/Cbi2uYU06orPQlM4p
 FJb2GVZuBG7JfsGczQEOj3YSxrY5KSPwZVHtyJVahaWMsk5qgpM00KW8rVLn4HX8WnjvxIdgG
 c4n+9g/nbUHlXhQxV0oMDGmfyKU2SZRmIlE/Z0DG8Ciq5iHLizFkl8F/qu21F2L5JTJq7VfB2
 RnyiI5nGMQqdU9ZWO+9aODli9ZIDjmRy6MCVTYXRAKm0voytPPofT4DGgLZufJInKPA/DPgcD
 yelsuRtVJzxZEp6YuynzpJECAq6jzuJeqVKnu4p3BI5fEvKfwMoVbzf+u3Wythhu/wllTz196
 rpqvL9OFLxtP0x+xWPIgyvnKOZjldrQWbVDbGQtsb5TrGNJl2eK7n2NV1qwntvpILCiMIwyCt
 E+ELdFajwXuS95gt0k+g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9pQpD6ZYCHn2rCNSrceE6UnQkHlHCmcsk
Content-Type: multipart/mixed; boundary="szlyqWG6B5s1p7cWGOtsSzsvfd4QNWnqo"

--szlyqWG6B5s1p7cWGOtsSzsvfd4QNWnqo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> Zygo reported the following panic when testing my error handling patche=
s
> for relocation
>=20
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/backref.c:2545!
> invalid opcode: 0000 [#1] SMP KASAN PTI CPU: 3 PID: 8472 Comm: btrfs Ta=
inted: G        W 14
> Hardware name: QEMU Standard PC (i440FX + PIIX,
>=20
> Call Trace:
>  btrfs_backref_error_cleanup+0x4df/0x530
>  build_backref_tree+0x1a5/0x700
>  ? _raw_spin_unlock+0x22/0x30
>  ? release_extent_buffer+0x225/0x280
>  ? free_extent_buffer.part.52+0xd7/0x140
>  relocate_tree_blocks+0x2a6/0xb60
>  ? kasan_unpoison_shadow+0x35/0x50
>  ? do_relocation+0xc10/0xc10
>  ? kasan_kmalloc+0x9/0x10
>  ? kmem_cache_alloc_trace+0x6a3/0xcb0
>  ? free_extent_buffer.part.52+0xd7/0x140
>  ? rb_insert_color+0x342/0x360
>  ? add_tree_block.isra.36+0x236/0x2b0
>  relocate_block_group+0x2eb/0x780
>  ? merge_reloc_roots+0x470/0x470
>  btrfs_relocate_block_group+0x26e/0x4c0
>  btrfs_relocate_chunk+0x52/0x120
>  btrfs_balance+0xe2e/0x18f0
>  ? pvclock_clocksource_read+0xeb/0x190
>  ? btrfs_relocate_chunk+0x120/0x120
>  ? lock_contended+0x620/0x6e0
>  ? do_raw_spin_lock+0x1e0/0x1e0
>  ? do_raw_spin_unlock+0xa8/0x140
>  btrfs_ioctl_balance+0x1f9/0x460
>  btrfs_ioctl+0x24c8/0x4380
>  ? __kasan_check_read+0x11/0x20
>  ? check_chain_key+0x1f4/0x2f0
>  ? __asan_loadN+0xf/0x20
>  ? btrfs_ioctl_get_supported_features+0x30/0x30
>  ? kvm_sched_clock_read+0x18/0x30
>  ? check_chain_key+0x1f4/0x2f0
>  ? lock_downgrade+0x3f0/0x3f0
>  ? handle_mm_fault+0xad6/0x2150
>  ? do_vfs_ioctl+0xfc/0x9d0
>  ? ioctl_file_clone+0xe0/0xe0
>  ? check_flags.part.50+0x6c/0x1e0
>  ? check_flags.part.50+0x6c/0x1e0
>  ? check_flags+0x26/0x30
>  ? lock_is_held_type+0xc3/0xf0
>  ? syscall_enter_from_user_mode+0x1b/0x60
>  ? do_syscall_64+0x13/0x80
>  ? rcu_read_lock_sched_held+0xa1/0xd0
>  ? __kasan_check_read+0x11/0x20
>  ? __fget_light+0xae/0x110
>  __x64_sys_ioctl+0xc3/0x100
>  do_syscall_64+0x37/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> This occurs because of this check
>=20
> if (RB_EMPTY_NODE(&upper->rb_node))
> 	BUG_ON(!list_empty(&node->upper));
>=20
> As we are dropping the backref node, if we discover that our upper node=

> in the edge we just cleaned up isn't linked into the cache that we are
> now done with this node, thus the BUG_ON().
>=20
> However this is an erroneous assumption, as we will look up all the
> references for a node first, and then process the pending edges.  All o=
f
> the 'upper' nodes in our pending edges won't be in the cache's rb_tree
> yet, because they haven't been processed.  We could very well have many=

> edges still left to cleanup on this node.
>=20
> The fact is we simply do not need this check, we can just process all o=
f
> the edges only for this node, because below this check we do the
> following
>=20
> if (list_empty(&upper->lower)) {
> 	list_add_tail(&upper->lower, &cache->leaves);
> 	upper->lowest =3D 1;
> }
>=20
> If the upper node truly isn't used yet, then we add it to the
> cache->leaves list to be cleaned up later.  If it is still used then th=
e
> last child node that has it linked into its node will add it to the
> leaves list and then it will be cleaned up.

That's tree.

>=20
> Fix this problem by dropping this logic altogether.  With this fix I no=

> longer see the panic when testing with error injection in the backref
> code.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/backref.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 02d7d7b2563b..56f7c840031e 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2541,13 +2541,6 @@ void btrfs_backref_cleanup_node(struct btrfs_bac=
kref_cache *cache,
>  		list_del(&edge->list[UPPER]);
>  		btrfs_backref_free_edge(cache, edge);
> =20
> -		if (RB_EMPTY_NODE(&upper->rb_node)) {
> -			BUG_ON(!list_empty(&node->upper));
> -			btrfs_backref_drop_node(cache, node);
> -			node =3D upper;
> -			node->lowest =3D 1;
> -			continue;
> -		}
>  		/*
>  		 * Add the node to leaf node list if no other child block
>  		 * cached.
>=20


--szlyqWG6B5s1p7cWGOtsSzsvfd4QNWnqo--

--9pQpD6ZYCHn2rCNSrceE6UnQkHlHCmcsk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/ISJIACgkQwj2R86El
/qjEJAf8DyZRs9s/x9BI9mS1RiKwvmfxm8Y/nTnBi/Vlhs61KnlwGIsh1zfHzOd/
jFGNnk7t6z99IwIluUtA7s94K/+pj/JETcTo0FxeyWTRa7Yi1Mafu5t0JxUv2aSP
ypipsEoXC3nOsrm1CuR4yvQyfh71+z4iqyw/gp9Tz6qmpGK45cDu2o1Mm+eeiK4E
CBT89R0SVx/oC40vbvdMR5yMu9DVliCRp6yqCX+JE1A1inJH1NWhMByeSVLJIRif
Pq6ow62CFsSJ7Nsv6nhvETliuOwTCYws41qVZdwN+IierZu5ilID7lalUY7r+5jR
mYokoP7W8l7+sjPkpjYPe/6w1HpM7g==
=Lufx
-----END PGP SIGNATURE-----

--9pQpD6ZYCHn2rCNSrceE6UnQkHlHCmcsk--
