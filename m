Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86970039F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 May 2023 11:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbjELJYs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 May 2023 05:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbjELJYr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 May 2023 05:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56916A7A;
        Fri, 12 May 2023 02:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8242C6542F;
        Fri, 12 May 2023 09:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A9AC4339C;
        Fri, 12 May 2023 09:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683883484;
        bh=5xaie/327Six79YPK3xX+aRpQWphHAtwg0HPjgkoFuE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mPjLDTwBvO2rq+vOoJ+1ywaFEFNU2hW61nidLRsIvq+e31Lqnx1WjX4M9c1775gR5
         c1z1fEc5KfZMcIpxnV4w0i0+5ZXgb5b6t7hFSTYobDlm3bUzvXbH/UIUuu88rI6VgQ
         GPO7hUkhGIhF80XRIAqs4mVeh9cDOsN82HLpJfDa6/i2Mqk6v5pYKN3/axQB/cvhJj
         A6DmTuB1bOCNBhwUUpQNWGRiZFHohQqa0sUoYKrVIPslwJHbVYBACXyQf3ieXk8b1h
         BGcK7HWhQZg6Fv98ShkU8HTAtqAPKa+McVloetVSv0y+cVKXDNRfs3OUA7+qQoD1Nq
         WVklvlwN5wbDw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-39212bf4ff0so5157312b6e.1;
        Fri, 12 May 2023 02:24:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDzlKvjERfHISKjZU31mWdmK48+4I7YM5Xkk9ohpJLmf9A/artnj
        u1bm11bKsMI43Ya8/1IFXPQqJXRlK/6dmbDQn6U=
X-Google-Smtp-Source: ACHHUZ7sQapZbvPm9ei1VQcge+aO7pstFYf9Yywhr90+bvVBPu2hssqE4mlEXPamtnYUURjYDYGLTsWU678jMI+YcVA=
X-Received: by 2002:a05:6808:a0c:b0:38e:6a6b:c6df with SMTP id
 n12-20020a0568080a0c00b0038e6a6bc6dfmr6372871oij.28.1683883483931; Fri, 12
 May 2023 02:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230512024135.325711-1-samho@synology.com>
In-Reply-To: <20230512024135.325711-1-samho@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 12 May 2023 10:24:07 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5+4v+0aLDC+JrnAKUbYFcWPuXh8Rtif5vGS2URNSe-dQ@mail.gmail.com>
Message-ID: <CAL3q7H5+4v+0aLDC+JrnAKUbYFcWPuXh8Rtif5vGS2URNSe-dQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: check extent type while finding extent clone source
To:     samho <samho@synology.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 12, 2023 at 4:26=E2=80=AFAM samho <samho@synology.com> wrote:
>
> For btrfs incremental backup:
> `btrfs send -p /vol/subvol_835 /vol/subvol_846 | btrfs receive /vol/`
>
> The following pattern will result in the data inconsistency between
> the received subvol and the subvol to be sent.
>
> (66755 EXTENT_DATA 2121728) is supposed to be regular extent data,
> while `find_extent_clone()` may find the extent item in tree 835
> which is prealloc data.
>
> DS:server[~]# btrfs-debug-tree -t 835 /dev/dev_1
>         item 129 key (58924 EXTENT_DATA 2412544) itemoff 7891 itemsize 53
>                 prealloc data disk byte 6599543226368 nr 389120
>                 prealloc data offset 0 nr 389120
> DS:server[~]# btrfs-debug-tree -t 846 /dev/dev_1
>         item 42 key (66755 EXTENT_DATA 2109440) itemoff 9964 itemsize 53
>                 prealloc data disk byte 6599543226368 nr 389120
>                 prealloc data offset 0 nr 12288
>         item 43 key (66755 EXTENT_DATA 2121728) itemoff 9911 itemsize 53
>                 extent data disk byte 6599543226368 nr 389120
>                 extent data offset 12288 nr 4096 ram 389120
>                 extent compression(none)
>         item 44 key (66755 EXTENT_DATA 2125824) itemoff 9858 itemsize 53
>                 prealloc data disk byte 6599543226368 nr 389120
>                 prealloc data offset 16384 nr 159744
> DS:server[~]#

So, I'm reading this and I can't understand anything at all.

You mention a data inconsistency between the received subvolume and
the original subvolume.
What is that inconsistency exactly? Does reading the file in the
received subvolume returns different data from the same file in the
original subvolume?
Or something else? Something that for example, "btrfs check" complains abou=
t?

There's a dumping of part of the trees, the send and parent roots,
used for the send operation, but that doesn't explain anything at all.

You say "(66755 EXTENT_DATA 2121728)  is supposed to be regular extent data=
".
Why?

This is a dump of the original trees, which are not affected by the
send operation - that would only make sense for the tree of the
received subvolume - which may get a different extent layout, as we
don't (and can't) guarantee the receiver will get the same extent
layout.

Do you have a reproducer for this?
Not only would it help understand better the problem, but it would
also serve to create a test case for fstests to prevent regressions in
the future.

Please provide a detailed changelog, I can't understand what the
problem is, and I doubt anyone else can.

Also, some minor comments inlined below.


>
> Signed-off-by: samho <samho@synology.com>
> ---
>  fs/btrfs/backref.c | 10 +++++++---
>  fs/btrfs/backref.h |  2 +-
>  fs/btrfs/scrub.c   |  2 +-
>  fs/btrfs/send.c    | 12 ++++++++++--
>  4 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index e54f0884802a..e446ca35b96c 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -29,6 +29,7 @@ struct extent_inode_elem {
>         u64 inum;
>         u64 offset;
>         u64 num_bytes;
> +       int extent_type;
>         struct extent_inode_elem *next;
>  };
>
> @@ -40,6 +41,7 @@ static int check_extent_in_eb(struct btrfs_backref_walk=
_ctx *ctx,
>  {
>         const u64 data_len =3D btrfs_file_extent_num_bytes(eb, fi);
>         u64 offset =3D key->offset;
> +       const int extent_type =3D btrfs_file_extent_type(eb, fi);
>         struct extent_inode_elem *e;
>         const u64 *root_ids;
>         int root_count;
> @@ -70,7 +72,7 @@ static int check_extent_in_eb(struct btrfs_backref_walk=
_ctx *ctx,
>                 int ret;
>
>                 ret =3D ctx->indirect_ref_iterator(key->objectid, offset,
> -                                                data_len, root_ids[i],
> +                                                data_len, extent_type, r=
oot_ids[i],
>                                                  ctx->user_ctx);
>                 if (ret)
>                         return ret;
> @@ -85,6 +87,7 @@ static int check_extent_in_eb(struct btrfs_backref_walk=
_ctx *ctx,
>         e->inum =3D key->objectid;
>         e->offset =3D offset;
>         e->num_bytes =3D data_len;
> +       e->extent_type =3D btrfs_file_extent_type(eb, fi);
>         *eie =3D e;
>
>         return 0;
> @@ -2388,7 +2391,7 @@ static int iterate_leaf_refs(struct btrfs_fs_info *=
fs_info,
>                             "ref for %llu resolved, key (%llu EXTEND_DATA=
 %llu), root %llu",
>                             extent_item_objectid, eie->inum,
>                             eie->offset, root);
> -               ret =3D iterate(eie->inum, eie->offset, eie->num_bytes, r=
oot, ctx);
> +               ret =3D iterate(eie->inum, eie->offset, eie->num_bytes, e=
ie->extent_type, root, ctx);
>                 if (ret) {
>                         btrfs_debug(fs_info,
>                                     "stopping iteration for %llu due to r=
et=3D%d",
> @@ -2526,7 +2529,8 @@ int iterate_extent_inodes(struct btrfs_backref_walk=
_ctx *ctx,
>         return ret;
>  }
>
> -static int build_ino_list(u64 inum, u64 offset, u64 num_bytes, u64 root,=
 void *ctx)
> +static int build_ino_list(u64 inum, u64 offset, u64 num_bytes, int exten=
t_type,
> +                               u64 root, void *ctx)
>  {
>         struct btrfs_data_container *inodes =3D ctx;
>         const size_t c =3D 3 * sizeof(u64);
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index ef6bbea3f456..bcbea7baefc5 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -28,7 +28,7 @@
>   * value to immediately stop iteration and possibly signal an error back=
 to
>   * the caller.
>   */
> -typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 num_byte=
s,
> +typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 num_byte=
s, int extent_type,
>                                       u64 root, void *ctx);
>
>  /*
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 836725a19661..904051bebe0d 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -374,7 +374,7 @@ static noinline_for_stack struct scrub_ctx *scrub_set=
up_ctx(
>         return ERR_PTR(-ENOMEM);
>  }
>
> -static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes=
,
> +static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes=
, int extent_type,
>                                      u64 root, void *warn_ctx)
>  {
>         u32 nlink;
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index af2e153543a5..77b4b5db11be 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -1297,6 +1297,9 @@ struct backref_ctx {
>         u64 backref_owner;
>         /* The offset of the data backref for the current extent. */
>         u64 backref_offset;
> +
> +       /* used for extent iteration to check if the type is matched */

Please follow the existing comment style.
Capitalize the first word in the sentence and add punctuation at the end.

> +       int extent_type;
>  };
>
>  static int __clone_root_cmp_bsearch(const void *key, const void *elt)
> @@ -1327,8 +1330,8 @@ static int __clone_root_cmp_sort(const void *e1, co=
nst void *e2)
>   * Called for every backref that is found for the current extent.
>   * Results are collected in sctx->clone_roots->ino/offset.
>   */
> -static int iterate_backrefs(u64 ino, u64 offset, u64 num_bytes, u64 root=
_id,
> -                           void *ctx_)
> +static int iterate_backrefs(u64 ino, u64 offset, u64 num_bytes, int exte=
nt_type,
> +                           u64 root_id, void *ctx_)
>  {
>         struct backref_ctx *bctx =3D ctx_;
>         struct clone_root *clone_root;
> @@ -1341,6 +1344,10 @@ static int iterate_backrefs(u64 ino, u64 offset, u=
64 num_bytes, u64 root_id,
>         if (!clone_root)
>                 return 0;
>
> +       /* Type is not matched */

This comment is useless. Looking at the variable and member names
below, it's perfectly clear we are comparing
extent types, and it's also perfectly clear we are testing for a mismatch.
Comments should be used for non-obvious things, otherwise they just distrac=
t.

Also, since this seems to be a send specific issue (though not clear
given the changelog above), the
subject should be like:  "btrfs: send: ...."

Thanks.

> +       if (extent_type !=3D bctx->extent_type)
> +               return 0;
> +
>         /* This is our own reference, bail out as we can't clone from it.=
 */
>         if (clone_root->root =3D=3D bctx->sctx->send_root &&
>             ino =3D=3D bctx->cur_objectid &&
> @@ -1599,6 +1606,7 @@ static int find_extent_clone(struct send_ctx *sctx,
>         extent_type =3D btrfs_file_extent_type(eb, fi);
>         if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE)
>                 return -ENOENT;
> +       backref_ctx.extent_type =3D extent_type;
>
>         disk_byte =3D btrfs_file_extent_disk_bytenr(eb, fi);
>         if (disk_byte =3D=3D 0)
> --
> 2.34.1
>
