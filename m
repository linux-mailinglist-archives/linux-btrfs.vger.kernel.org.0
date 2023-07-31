Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0E5769BD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 18:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjGaQGN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 12:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjGaQGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 12:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF541BC0
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 09:05:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDF99611F9
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 16:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7C8C433C8
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690819531;
        bh=b5HkO/SzzxCMhMKuGK45Mgc8HYmgKJUj9oc+FSGnP7M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oyjHVJAuVO9/z1/4Z9psH2LG57sW6nUGXRCGw7Obje8IcUvkbGSrrOmekOeMTMld/
         Q1GsUbK8fPKkOD5aY/H6kGvym7DsbKFlMCJuyudGaPvvpQwPa2KZgl2tXx/bCXkT1t
         qL1oO6x63Yo20EhIALDOL8Kr7s8gM+iP+1uX50o+as9b+vrlxWLJZuQUKcfmWPMb5D
         O0UfPj0a3Z96nMbl+A2hU+gAnx2lG28GYFecHomDyuOlXm3GkT/3O4c5AdmNrV4iFo
         ZQspH0rFyqgtyGkFgHeioKD0SqE5R4TWUYiqUPQ6U6rG2RvUGFlbeisveZpSdcggMi
         ihmHWA3IsdaKQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1bb89ac2013so3576197fac.1
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 09:05:31 -0700 (PDT)
X-Gm-Message-State: ABy/qLbAZfSOyDFguBCCOvD8Nloorhv6Bm5corJ0qpO4lE1uHF9re3hw
        kvYb99rH5QFGZqedG1ww0W4aSdhtfh2tBQihdT0=
X-Google-Smtp-Source: APBJJlFQrn+CopJ7PS9A+gA2Hj1GuZua713KqhV2S04UGYLcNZBSdY4QQLKpyqCFrgq1ccX3g9Ef7cf02Us4zzz3Aa8=
X-Received: by 2002:a05:6870:b50b:b0:1bb:8abf:4a80 with SMTP id
 v11-20020a056870b50b00b001bb8abf4a80mr14077099oap.9.1690819530510; Mon, 31
 Jul 2023 09:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <447c5374eeee4ad7abb5320602be92bf5748c04c.1690816368.git.josef@toxicpanda.com>
In-Reply-To: <447c5374eeee4ad7abb5320602be92bf5748c04c.1690816368.git.josef@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 31 Jul 2023 17:04:54 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5q4Fgox+pSW7SgotHYHfWn5gAX41nQoehuDFsP3jU4cQ@mail.gmail.com>
Message-ID: <CAL3q7H5q4Fgox+pSW7SgotHYHfWn5gAX41nQoehuDFsP3jU4cQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: set_page_extent_mapped after read_folio in relocate_one_page
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 31, 2023 at 4:43=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> One of the CI runs triggered the following panic
>
> assertion failed: PagePrivate(page) && page->private, in fs/btrfs/subpage=
.c:229
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/subpage.c:229!
> Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> CPU: 0 PID: 923660 Comm: btrfs Not tainted 6.5.0-rc3+ #1
> pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D--)
> pc : btrfs_subpage_assert+0xbc/0xf0
> lr : btrfs_subpage_assert+0xbc/0xf0
> sp : ffff800093213720
> x29: ffff800093213720 x28: ffff8000932138b4 x27: 000000000c280000
> x26: 00000001b5d00000 x25: 000000000c281000 x24: 000000000c281fff
> x23: 0000000000001000 x22: 0000000000000000 x21: ffffff42b95bf880
> x20: ffff42b9528e0000 x19: 0000000000001000 x18: ffffffffffffffff
> x17: 667274622f736620 x16: 6e69202c65746176 x15: 0000000000000028
> x14: 0000000000000003 x13: 00000000002672d7 x12: 0000000000000000
> x11: ffffcd3f0ccd9204 x10: ffffcd3f0554ae50 x9 : ffffcd3f0379528c
> x8 : ffff800093213428 x7 : 0000000000000000 x6 : ffffcd3f091771e8
> x5 : ffff42b97f333948 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : ffff42b9556cde80 x0 : 000000000000004f
> Call trace:
>  btrfs_subpage_assert+0xbc/0xf0
>  btrfs_subpage_set_dirty+0x38/0xa0
>  btrfs_page_set_dirty+0x58/0x88
>  relocate_one_page+0x204/0x5f0
>  relocate_file_extent_cluster+0x11c/0x180
>  relocate_data_extent+0xd0/0xf8
>  relocate_block_group+0x3d0/0x4e8
>  btrfs_relocate_block_group+0x2d8/0x490
>  btrfs_relocate_chunk+0x54/0x1a8
>  btrfs_balance+0x7f4/0x1150
>  btrfs_ioctl+0x10f0/0x20b8
>  __arm64_sys_ioctl+0x120/0x11d8
>  invoke_syscall.constprop.0+0x80/0xd8
>  do_el0_svc+0x6c/0x158
>  el0_svc+0x50/0x1b0
>  el0t_64_sync_handler+0x120/0x130
>  el0t_64_sync+0x194/0x198
> Code: 91098021 b0007fa0 91346000 97e9c6d2 (d4210000)
>
> This is the same problem outlined in "btrfs: set_page_extent_mapped
> after read_folio in btrfs_cont_expand", and the fix is the same.

Btw, that patch is already in Linus' tree, so it's convenient to use
the git commit here as well (17b17fcd6d44).

> I originally looked for the same pattern elsewhere in our code, but
> mistakenly skipped over this code because I saw the page cache readahead
> before we set_page_extent_mapped, not realizing that this was only in
> the !page case, that we can still end up with a !uptodate page and then
> do the btrfs_read_folio further down.
>
> The fix here is the same as the above mentioned patch, move the
> set_page_extent_mapped call to after the btrfs_read_folio() block to
> make sure that we have the subpage blocksize stuff setup properly before
> using the page.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Anyway, it looks good to me, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/relocation.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 9db2e6fa2cb2..e01819f8de5b 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2977,9 +2977,6 @@ static int relocate_one_page(struct inode *inode, s=
truct file_ra_state *ra,
>                 if (!page)
>                         return -ENOMEM;
>         }
> -       ret =3D set_page_extent_mapped(page);
> -       if (ret < 0)
> -               goto release_page;
>
>         if (PageReadahead(page))
>                 page_cache_async_readahead(inode->i_mapping, ra, NULL,
> @@ -2995,6 +2992,15 @@ static int relocate_one_page(struct inode *inode, =
struct file_ra_state *ra,
>                 }
>         }
>
> +       /*
> +        * We could have lost page private when we dropped the lock to re=
ad the
> +        * page above, make sure we set_page_extent_mapped here so we hav=
e any
> +        * of the subpage blocksize stuff we need in place.
> +        */
> +       ret =3D set_page_extent_mapped(page);
> +       if (ret < 0)
> +               goto release_page;
> +
>         page_start =3D page_offset(page);
>         page_end =3D page_start + PAGE_SIZE - 1;
>
> --
> 2.41.0
>
