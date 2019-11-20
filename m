Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE69010349A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 07:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKTGvm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 01:51:42 -0500
Received: from mout.gmx.net ([212.227.15.18]:42961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfKTGvm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 01:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574232700;
        bh=7hCSWd2HqDVguKnjK+nDn0BfRAIBwJTNsAmJxkW0zGY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Sl4AVTU5OKoi4JN4HoWzJX0uIolctqXpjhrF//8OwiSFnbY1gfawWOetzZXdcBHjP
         vXOjF+r6O4SMvsDu92Le5a7yar8YCmhaz9YO7kHMI3D07Z5C/B0gG/ml6dvmYUgaig
         OAkkViOlqASSPyBK6qR+5tUrrfj8Mg2KEIVKXE18=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [34.92.246.95] ([34.92.246.95]) by
 msvc-mesg-gmx021.server.lan (via HTTP); Wed, 20 Nov 2019 07:51:40 +0100
MIME-Version: 1.0
Message-ID: <trinity-422d40c2-b371-492d-bfe9-e55f3ea3a7db-1574232700743@msvc-mesg-gmx021>
From:   "Su Yue" <Damenly_Su@gmx.com>
To:     damenly.su@gmail.com
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: block group: do not exclude bytenr
 adjacent to block group
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 20 Nov 2019 07:51:40 +0100
In-Reply-To: <20191118055335.9927-1-Damenly_Su@gmx.com>
References: <20191118055335.9927-1-Damenly_Su@gmx.com>
X-Provags-ID: V03:K1:k+vdI1OQQCm5LevkK8QvrtgLWHeatDsuSksUOaSmCblHLUN1NraGL65w+HsStNtnKnEZ4
 rBVU5PcmP/mH5LLfLxU13RKAabUXvMspYmHXHd8lcIMa+pPb51krheo+rOy/mnxqnSpNvrq5hVYn
 AlGByCGLVQa+feZVJ0PaIE+9EXBdK7CT1JI5yeTxFLubOXNAe7Ex/qWuP3EbofwJcr6iVf6aAyTu
 9kg6afdBoQGd87armdBj19uTvW4xdgpfkzhGanSkttCN+wRrAKCuUuQEau444tdn7GmhRuWZz5co
 BmvxgkhZwDM2ryXPaXnxnzi
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:R6bS/aVxYD0=:sjW2wCR7wgtX4jkRhFBq00
 3e5/nA8heTgB1gZvT7lOExvy3Kbr9UR4UU8Gz0m6Q5KMd7G4PdoW37SKs23WET3AX7e4SzddD
 2UseaDkno9Ro2uzpxwfiKnYP308D3mf27MqswOmLwr7h+4g1eQJMmZpVmNPM6DQRsQzaevAfM
 GiRChZvR4K4AKGcXpK51zDE2ppxBueqipBJrbmokL9RBPKXYqARilIlIO5NmB1VWZWBY0N11x
 FDnCgy48liZqsw4dK2c72WNF4bzmcHxByReHPb4XKacima/BjISWzl7OUO1jZl8esw0n4re1a
 UTpJaQyRtQv0Gje5ce2l8HdK8is/d2RdNAHv3gREtokVSdFo/gHhfDuo/C8IJn45+SKbZJ/hc
 v279j+3wm4UVcP2MzSv00B217cceNpd8rXpFCxuBozPwGKV8pHxq2B3APXEP7UHnSLFFawODL
 HCAvup/EOq34NbuyUDlrSP1nrmRx3iyVzU3BXO3nQBl1WbOIbT90MDE6MItO4a6AYXOCwds/7
 TLgKnrjjQOMWAXoGy4VSwNauYMIcjcJGnq/q30jiNYEDpClWcMPIdI+IxStIRP669TA8sKjHx
 cs6UOOjShp2yZmQy0TFdPoK1Tce48BEYwjgOPWqj5Nff7J7TdnUVVXhFoJgsNaEoZx3/OyVzf
 ceYjmx9sR5UrnUtvh7S4YLkSTm581ai5PYILnrqbUlrssouwYiJNXifGxuyhgzI6FSCYel/jn
 t4Alz+ou760YLf2YtsVYL37G5TbA+pfpkcSwe1dy4YY2pqfzgOO21y97mCwnw+Z5kVgEPE2kN
 ZUDQUJV
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Drop those too, will send new version fixed by another method.



On 2019/11/18 at 13:53, damenly.su@gmail.com wrote:

> From: Su Yue <Damenly_Su@gmx.com>
>
> While checking the image provided by the reporter, the btrfsck aborts:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Opening filesystem to check...
> extent_io.c:158: insert_state: BUG_ON `end < start` triggered, value 1
> btrfs check(+0xa3fa8)[0x5614c14c7fa8]
> btrfs check(+0xa4046)[0x5614c14c8046]
> btrfs check(+0xa45f1)[0x5614c14c85f1]
> btrfs check(set_extent_bits+0x83)[0x5614c14c8c63]
> btrfs check(+0xbfb90)[0x5614c14e3b90]
> btrfs check(exclude_super_stripes+0x1fc)[0x5614c14e3de9]
> btrfs check(+0xbd85d)[0x5614c14e185d]
> btrfs check(btrfs_read_block_groups+0xd3)[0x5614c14e19f5]
> btrfs check(btrfs_setup_all_roots+0x454)[0x5614c14d7740]
> btrfs check(+0xb4219)[0x5614c14d8219]
> btrfs check(open_ctree_fs_info+0x177)[0x5614c14d8415]
> btrfs check(+0x693dd)[0x5614c148d3dd]
> btrfs check(+0x14dc7)[0x5614c1438dc7]
> btrfs check(main+0x126)[0x5614c1439713]
> /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7fe3f1ecf153]
> btrfs check(_start+0x2e)[0x5614c1438cce]
> [1]    6196 abort (core dumped)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> It's excluding super stripes from one block group, the bytenr equals
> block group's start + len, so the @num_bytes is 0. Then
> add_exclude_extent() calculates the @end is less than the @start
> which trigers the abort.
>
> Anyway, the logical bytenr should not be excluded if the block group's
> start + len equals it, because it's not belong to the block group.
>
> Link: https://github.com/kdave/btrfs-progs/issues/210
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
> ---
>  extent-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/extent-tree.c b/extent-tree.c
> index f690ae999f37..848fb72f90a4 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -3630,7 +3630,7 @@ int exclude_super_stripes(struct btrfs_fs_info *fs=
_info,
>  		while (nr--) {
>  			u64 start, len;
>
> -			if (logical[nr] > cache->key.objectid +
> +			if (logical[nr] >=3D cache->key.objectid +
>  			    cache->key.offset)
>  				continue;
>
> --
> 2.23.0

