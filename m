Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556587B7F52
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbjJDMhK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 08:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242623AbjJDMga (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 08:36:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CEB10F2
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 05:36:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C16C433C7
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 12:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696422963;
        bh=x41bABXYpoE5dtNvQ8JwIqEt20rm7rmIkODxfSK6l/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sGlDHfhODjFLhmUB/+2YLM+Piwqoac51HeWWS28FXNgqjQch2kOO69gJTyEWc3CB0
         oLw3L09zJsWMdZpb6YJsmdcpqlC/WjrlyeOiTpZvoDunxtBwcklMtLH3yVsi2AXo5g
         2vl3FeqJcP0f0ZeKlE2Yppco96p+6HW16CvdCaB+K6BjVwEnYxTytC2+PdbZbo+2pz
         5oaASsXGoo7R+MJwhnFTdoYgsc9DrgOKj7E/Yh8CLk7siccORmFzYEmqguKIJuI+q5
         YmTsPyBL+M8TnEFtpT5ZIefTCZQTJUfKFCc1Zq4203RT6I70YRNGrA82cx1LCSAn+1
         RFLFlwmwLTIOg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1c0fcbf7ae4so1466523fac.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Oct 2023 05:36:03 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx4aeYMnu54XTex397a56rd7RKjnRu+Y99jonpNE8YQJcheDsDF
        L1yXW0Z3zk4e0zt46bGwX+nJwZH0NUuLzoYj6Js=
X-Google-Smtp-Source: AGHT+IEQU0M1vWkfYdj3hyjELvAh1tFA+DggIxH+P1TO64PvDZXD/vVfWWyoRa1BEAVZZZJkDTqB5ZY0I66wolcveI4=
X-Received: by 2002:a05:6870:808a:b0:1c7:ebf5:b6cb with SMTP id
 q10-20020a056870808a00b001c7ebf5b6cbmr2409680oab.25.1696422962798; Wed, 04
 Oct 2023 05:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695380646.git.dsterba@suse.com> <7588cec46a2d548400de33930811fa12026f1dd1.1695380646.git.dsterba@suse.com>
In-Reply-To: <7588cec46a2d548400de33930811fa12026f1dd1.1695380646.git.dsterba@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 4 Oct 2023 13:35:26 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6wryrNsjk8HZqqiSyMHTcxcPC-kd2U-uCEVxWYHAPV2Q@mail.gmail.com>
Message-ID: <CAL3q7H6wryrNsjk8HZqqiSyMHTcxcPC-kd2U-uCEVxWYHAPV2Q@mail.gmail.com>
Subject: Re: [PATCH 7/8] btrfs: relocation: use on-stack iterator in build_backref_tree
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 22, 2023 at 2:26=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
>
> build_backref_tree() is called in a loop by relocate_tree_blocks()
> for each relocated block. The iterator is allocated and freed repeatedly
> while we could simply use an on-stack variable to avoid the allocation
> and remove one more failure case. The stack grows by 48 bytes.
>
> This was the only use of btrfs_backref_iter_alloc() so it's changed to
> be an initializer and btrfs_backref_iter_free() can be removed
> completely.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/backref.c    | 26 ++++++++++----------------
>  fs/btrfs/backref.h    | 11 ++---------
>  fs/btrfs/relocation.c | 12 ++++++------
>  3 files changed, 18 insertions(+), 31 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 0dc91bf654b5..691b20b47065 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2828,26 +2828,20 @@ void free_ipath(struct inode_fs_paths *ipath)
>         kfree(ipath);
>  }
>
> -struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info=
 *fs_info)
> +int btrfs_backref_iter_init(struct btrfs_fs_info *fs_info,
> +                           struct btrfs_backref_iter *iter)
>  {
> -       struct btrfs_backref_iter *ret;
> -
> -       ret =3D kzalloc(sizeof(*ret), GFP_NOFS);
> -       if (!ret)
> -               return NULL;
> -
> -       ret->path =3D btrfs_alloc_path();
> -       if (!ret->path) {
> -               kfree(ret);
> -               return NULL;
> -       }
> +       memset(iter, 0, sizeof(struct btrfs_backref_iter));
> +       iter->path =3D btrfs_alloc_path();

So this is breaking misc-next, as paths are leaking here, easily
visible after "rmmod btrfs":

[ 2265.115295] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
[ 2265.115938] BUG btrfs_path (Not tainted): Objects remaining in
btrfs_path on __kmem_cache_shutdown()
[ 2265.116615] ------------------------------------------------------------=
-----------------

[ 2265.117614] Slab 0x00000000dbb6fd30 objects=3D36 used=3D3
fp=3D0x000000001768ab21
flags=3D0x17fffc000000800(slab|node=3D0|zone=3D2|lastcpupid=3D0x1ffff)
[ 2265.118423] CPU: 1 PID: 402761 Comm: rmmod Not tainted
6.6.0-rc3-btrfs-next-139+ #1
[ 2265.118440] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[ 2265.118457] Call Trace:
[ 2265.118483]  <TASK>
[ 2265.118491]  dump_stack_lvl+0x44/0x60
[ 2265.118521]  slab_err+0xb6/0xf0
[ 2265.118547]  __kmem_cache_shutdown+0x15f/0x2f0
[ 2265.118565]  kmem_cache_destroy+0x4c/0x170
[ 2265.118588]  exit_btrfs_fs+0x24/0x40 [btrfs]
[ 2265.119121]  __x64_sys_delete_module+0x193/0x290
[ 2265.119137]  ? exit_to_user_mode_prepare+0x3d/0x170
[ 2265.119154]  do_syscall_64+0x38/0x90
[ 2265.119169]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 2265.119185] RIP: 0033:0x7f55ec127997
[ 2265.119199] Code: 73 01 c3 48 8b 0d 81 94 0c 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 51 94 0c 00 f7 d8 64 89
01 48
[ 2265.119210] RSP: 002b:00007ffe06412d98 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[ 2265.119225] RAX: ffffffffffffffda RBX: 00005589627f26f0 RCX: 00007f55ec1=
27997
[ 2265.119234] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005589627=
f2758
[ 2265.119241] RBP: 0000000000000000 R08: 1999999999999999 R09: 00000000000=
00000
[ 2265.119249] R10: 00007f55ec19aac0 R11: 0000000000000206 R12: 00007ffe064=
12fe0
[ 2265.119257] R13: 00007ffe064133da R14: 00005589627f22a0 R15: 00007ffe064=
12fe8
[ 2265.119276]  </TASK>
[ 2265.119281] Disabling lock debugging due to kernel taint
[ 2265.119289] Object 0x0000000062d6ea78 @offset=3D784
[ 2265.120073] Object 0x0000000042bd66e6 @offset=3D1904
[ 2265.120712] Object 0x00000000603962f0 @offset=3D2240
[ 2265.121397] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
[ 2265.122021] BUG btrfs_path (Tainted: G    B             ): Objects
remaining in btrfs_path on __kmem_cache_shutdown()
(...)

I get thousands and thousands of these messages after running fstests
and doing "rmmod btrfs".

The problem here is the code is reusing the iterator, and every time
allocating a new path without freeing the previous one.
It could simply avoid path allocation and reuse it.

Thanks.



> +       if (!iter->path)
> +               return -ENOMEM;
>
>         /* Current backref iterator only supports iteration in commit roo=
t */
> -       ret->path->search_commit_root =3D 1;
> -       ret->path->skip_locking =3D 1;
> -       ret->fs_info =3D fs_info;
> +       iter->path->search_commit_root =3D 1;
> +       iter->path->skip_locking =3D 1;
> +       iter->fs_info =3D fs_info;
>
> -       return ret;
> +       return 0;
>  }
>
>  int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr=
)
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 83a9a34e948e..24fabbd2a80a 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -269,15 +269,8 @@ struct btrfs_backref_iter {
>         u32 end_ptr;
>  };
>
> -struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info=
 *fs_info);
> -
> -static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *it=
er)
> -{
> -       if (!iter)
> -               return;
> -       btrfs_free_path(iter->path);
> -       kfree(iter);
> -}
> +int btrfs_backref_iter_init(struct btrfs_fs_info *fs_info,
> +                           struct btrfs_backref_iter *iter);
>
>  static inline struct extent_buffer *btrfs_backref_get_eb(
>                 struct btrfs_backref_iter *iter)
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d1dcbb15baa7..6a31e73c3df7 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -464,7 +464,7 @@ static noinline_for_stack struct btrfs_backref_node *=
build_backref_tree(
>                         struct reloc_control *rc, struct btrfs_key *node_=
key,
>                         int level, u64 bytenr)
>  {
> -       struct btrfs_backref_iter *iter;
> +       struct btrfs_backref_iter iter;
>         struct btrfs_backref_cache *cache =3D &rc->backref_cache;
>         /* For searching parent of TREE_BLOCK_REF */
>         struct btrfs_path *path;
> @@ -474,9 +474,9 @@ static noinline_for_stack struct btrfs_backref_node *=
build_backref_tree(
>         int ret;
>         int err =3D 0;
>
> -       iter =3D btrfs_backref_iter_alloc(rc->extent_root->fs_info);
> -       if (!iter)
> -               return ERR_PTR(-ENOMEM);
> +       ret =3D btrfs_backref_iter_init(rc->extent_root->fs_info, &iter);
> +       if (ret < 0)
> +               return ERR_PTR(ret);
>         path =3D btrfs_alloc_path();
>         if (!path) {
>                 err =3D -ENOMEM;
> @@ -494,7 +494,7 @@ static noinline_for_stack struct btrfs_backref_node *=
build_backref_tree(
>
>         /* Breadth-first search to build backref cache */
>         do {
> -               ret =3D btrfs_backref_add_tree_node(cache, path, iter, no=
de_key,
> +               ret =3D btrfs_backref_add_tree_node(cache, path, &iter, n=
ode_key,
>                                                   cur);
>                 if (ret < 0) {
>                         err =3D ret;
> @@ -522,7 +522,7 @@ static noinline_for_stack struct btrfs_backref_node *=
build_backref_tree(
>         if (handle_useless_nodes(rc, node))
>                 node =3D NULL;
>  out:
> -       btrfs_backref_iter_free(iter);
> +       btrfs_backref_iter_release(&iter);
>         btrfs_free_path(path);
>         if (err) {
>                 btrfs_backref_error_cleanup(cache, node);
> --
> 2.41.0
>
