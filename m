Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9CE14A560
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 14:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgA0Nqj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 08:46:39 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42344 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0Nqi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 08:46:38 -0500
Received: by mail-vk1-f195.google.com with SMTP id c8so1350914vkn.9
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2020 05:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WST3DX/26h5utB1I75tXcdetgDi+gs7EuiqPIuF1Jw4=;
        b=BWutudrlZ6mT61enwslaj8Es1HfJIBXn0RE5QlTeig7ucgTB/g1so3rq8i+YL7G570
         8kbAYoDRcAXh9GBfhmt48LbLHFd6p7ZOoocUR88Je9qUCGlQzJyqKmtDV87W9Nkzs83y
         qx54/BMvNLbIJ0rQ7I1rDYZm4wDFuiX4kOCpKx2Oh8VWZkXoFV30v8revf/J6oYsMz6R
         wxW36M/8wW2hdXdpV82JI0RzNUEfKTE0264Cb4UQBhc31+U1Ul1HVGrqDBB1KXSAr7do
         5BpNnGAQeHzQiOObhgLEfYD3ZKQD1oKpWCTXP3oOun2XigBO80S3UFFFY62FZBjfrr/L
         k+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WST3DX/26h5utB1I75tXcdetgDi+gs7EuiqPIuF1Jw4=;
        b=lgGm2+PxkLtj0niG7acpOpEFbMnjbM8QEhH+605iJwDm1pMyePj5WNUt0DXPgQ0l+V
         /YrSDWcG5bksD1BoAVakDwj8Dz0g2wr6v7+y78ei4l1mDHlDyprqtWWoSS1F4bNT7PJQ
         BIWhFdHbtJgw9lqcOQEWQU5G7PbJjHgG/ateYz6tP/0O4yPzWEQQJnwdnAEuRoQq6DtF
         URhb+9WBfRRZROGI/lF8wRhoG6eqaXdVLzuDki6s0inDTG0SFViSzAJsAlFUAQtU5BZh
         m5WiaOoptvda+Y2CuB2UGAIfcuW7twg5robsAQD3sU0FTDIz+9Vq5SfiDjLiqjewHLiU
         QRcg==
X-Gm-Message-State: APjAAAV7fprIFw7QX/AdG0EOrVJhfdgTybk1PeXy20Db+JQHOPhIS3Q6
        zSLGE7yILlcNVVDleWrlS/agqcAq6L/YLBsKjBv1qw==
X-Google-Smtp-Source: APXvYqzxoCU8UqjttzpmiuTdBDNvNzitZpEA4dkxwNnxiVQ0opvmwcMPw82+KU7K1RMRvuscbICyp6NMdXMuZ64UorM=
X-Received: by 2002:a1f:2753:: with SMTP id n80mr10295615vkn.24.1580132797028;
 Mon, 27 Jan 2020 05:46:37 -0800 (PST)
MIME-Version: 1.0
References: <20200127095926.26069-1-nborisov@suse.com>
In-Reply-To: <20200127095926.26069-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 27 Jan 2020 13:46:25 +0000
Message-ID: <CAL3q7H4TX63DDtu9KR7KaSgMd+Vp=F_NBrJk=VqZ6wAzDJOKew@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Correctly handle empty trees in find_first_clear_extent_bit
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, dsterba@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 27, 2020 at 10:01 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> Raviu reported that running his regular fs_trim segfaulted with the
> following backtrace:
>
> [  237.525947] assertion failed: prev, in ../fs/btrfs/extent_io.c:1595
> [  237.525984] ------------[ cut here ]------------
> [  237.525985] kernel BUG at ../fs/btrfs/ctree.h:3117!
> [  237.525992] invalid opcode: 0000 [#1] SMP PTI
> [  237.525998] CPU: 4 PID: 4423 Comm: fstrim Tainted: G     U     OE     =
5.4.14-8-vanilla #1
> [  237.526001] Hardware name: ASUSTeK COMPUTER INC.
> [  237.526044] RIP: 0010:assfail.constprop.58+0x18/0x1a [btrfs]
> [  237.526079] Call Trace:
> [  237.526120]  find_first_clear_extent_bit+0x13d/0x150 [btrfs]
> [  237.526148]  btrfs_trim_fs+0x211/0x3f0 [btrfs]
> [  237.526184]  btrfs_ioctl_fitrim+0x103/0x170 [btrfs]
> [  237.526219]  btrfs_ioctl+0x129a/0x2ed0 [btrfs]
> [  237.526227]  ? filemap_map_pages+0x190/0x3d0
> [  237.526232]  ? do_filp_open+0xaf/0x110
> [  237.526238]  ? _copy_to_user+0x22/0x30
> [  237.526242]  ? cp_new_stat+0x150/0x180
> [  237.526247]  ? do_vfs_ioctl+0xa4/0x640
> [  237.526278]  ? btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
> [  237.526283]  do_vfs_ioctl+0xa4/0x640
> [  237.526288]  ? __do_sys_newfstat+0x3c/0x60
> [  237.526292]  ksys_ioctl+0x70/0x80
> [  237.526297]  __x64_sys_ioctl+0x16/0x20
> [  237.526303]  do_syscall_64+0x5a/0x1c0
> [  237.526310]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> That was due to btrfs_fs_device::aloc_tree being empty. Initially I
> thought this wasn't possible and as a percaution have put the assert in
> find_first_clear_extent_bit. Turns out this is indeed possible and could
> happen when a file system with SINGLE data/metadata profile has a 2nd
> device added. Until balance is run or a new chunk is allocated on this
> device it will be completely empty.
>
> In this case find_first_clear_extent_bit should return the full range
> [0, -1ULL] and let the caller handle this i.e for trim the end will be
> capped at the size of actual device.
>
> Link: https://lore.kernel.org/linux-btrfs/izW2WNyvy1dEDweBICizKnd2KDwDiDy=
Y2EYQr4YCwk7pkuIpthx-JRn65MPBde00ND6V0_Lh8mW0kZwzDiLDv25pUYWxkskWNJnVP0kgdM=
A=3D@protonmail.com/
> Fixes: 45bfcfc168f8 ("btrfs: Implement find_first_clear_extent_bit")
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>
> David can you try and squeeze this into 5.5? It only leads to an assertio=
n
> failure trigger (if assertion
>  fs/btrfs/extent_io.c             | 32 ++++++++++++++++++--------------
>  fs/btrfs/tests/extent-io-tests.c |  7 +++++++
>  2 files changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 0351dbe64550..9bf7dffa22b1 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1593,21 +1593,25 @@ void find_first_clear_extent_bit(struct extent_io=
_tree *tree, u64 start,
>         /* Find first extent with bits cleared */
>         while (1) {
>                 node =3D __etree_search(tree, start, &next, &prev, NULL, =
NULL);
> -               if (!node) {
> +               if (!node && !next && !prev) {
> +                       /*
> +                        * Tree is completely empty, send full range and =
let
> +                        * caller deal with it
> +                        */
> +                       *start_ret =3D 0;
> +                       *end_ret =3D -1;
> +                       goto out;
> +               } else if (!node && !next) {
> +                       /*
> +                        * We are past the last allocated chunk, set star=
t at
> +                        * the end of the last extent.
> +                        */
> +                       state =3D rb_entry(prev, struct extent_state, rb_=
node);
> +                       *start_ret =3D state->end + 1;
> +                       *end_ret =3D -1;
> +                       goto out;
> +               } else if (!node) {
>                         node =3D next;
> -                       if (!node) {
> -                               /*
> -                                * We are past the last allocated chunk,
> -                                * set start at the end of the last exten=
t. The
> -                                * device alloc tree should never be empt=
y so
> -                                * prev is always set.
> -                                */
> -                               ASSERT(prev);
> -                               state =3D rb_entry(prev, struct extent_st=
ate, rb_node);
> -                               *start_ret =3D state->end + 1;
> -                               *end_ret =3D -1;
> -                               goto out;
> -                       }
>                 }
>                 /*
>                  * At this point 'node' either contains 'start' or start =
is
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-=
tests.c
> index 123d9a614357..2708c7e620cb 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -441,8 +441,15 @@ static int test_find_first_clear_extent_bit(void)
>         int ret =3D -EINVAL;
>
>         test_msg("running find_first_clear_extent_bit test");
> +
>         extent_io_tree_init(NULL, &tree, IO_TREE_SELFTEST, NULL);
>
> +       /* Test correct handling of empty tree */
> +       find_first_clear_extent_bit(&tree, 0, &start, &end, CHUNK_TRIMMED=
);
> +       if (start !=3D 0 || end !=3D -1) {
> +               test_err("error getting a range from completely empty tre=
e: start %llu end %llu",
> +                        start, end);
> +       }

Missing a 'goto out', otherwise the test doesn't fail.

Thanks.

>         /*
>          * Set 1M-4M alloc/discard and 32M-64M thus leaving a hole betwee=
n
>          * 4M-32M
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
