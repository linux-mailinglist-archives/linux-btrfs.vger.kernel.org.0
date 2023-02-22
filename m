Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E1369F3B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 12:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBVLxY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 06:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjBVLxL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 06:53:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C112822E
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 03:53:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CD13B812A4
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 11:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABF9C4339B
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 11:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677066781;
        bh=lmdh3yQpUaAFn0VOmSfFm80iuLnQJhovGUaBLCgBRlU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=di+EiiyMd+95hCvGweYxHastWK5nuW5G+ogQcw88m3pu9GTVzP8SM2DpZo628E0+O
         KzrLD90HpbGAfNgIJ1h6YiJ7JRjdJUPuqO4dSpkw/EzWyiKwJdVJ5ZJMuImSXTvbsj
         y+9Elln96QLfeaJt1Xr5SS869+BBBK5zjmPh7re3Y7DahtJZWoS+rTENgyOy3Mj+rG
         kBkUb6obdXihvRvKhRytkUsPLXpFmOx2ykhI08EupUOKJE7iBEr1pchhrYG0ib7mKa
         z7ufxPllAiWsrC+XhTGB+MQO2ac9Vk85yvQ5lQqQUgKnppoeYfrOyyVOSCxD0GMDq7
         WhRiwt/cLnU7g==
Received: by mail-oi1-f171.google.com with SMTP id bh20so7107461oib.9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 03:53:01 -0800 (PST)
X-Gm-Message-State: AO0yUKWP49HMS1WvHAooT6L/MUtOrJ1shVSBhkA+JF2NBpR7sKRCXcr9
        sek44So66ActmIxJYl5lTMsf0Fq7Sf6ADPZR+Y0=
X-Google-Smtp-Source: AK7set/WX9nN2TPJvsTx3ybALXwS4TGyVV4gGyPyDtHXmHzi32SgY2juzd6TSi1WV7em1utrDWB4bSFL9DgTDjZ5OvY=
X-Received: by 2002:a05:6808:171b:b0:37d:5e52:6844 with SMTP id
 bc27-20020a056808171b00b0037d5e526844mr421052oib.98.1677066780499; Wed, 22
 Feb 2023 03:53:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677026757.git.boris@bur.io> <70260eb8a1df6ad3b32ff4be62c9799fcc12ebc3.1677026757.git.boris@bur.io>
In-Reply-To: <70260eb8a1df6ad3b32ff4be62c9799fcc12ebc3.1677026757.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 22 Feb 2023 11:52:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4ZZwRzBXoY_AiwkYkrHo=O=2Un_LN8DqbXNFV_CXuLgw@mail.gmail.com>
Message-ID: <CAL3q7H4ZZwRzBXoY_AiwkYkrHo=O=2Un_LN8DqbXNFV_CXuLgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: btrfs_alloc_ordered_extent
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 22, 2023 at 1:04 AM Boris Burkov <boris@bur.io> wrote:
>
> Currently, btrfs_add_ordered_extent allocates a new ordered extent, adds
> it to the rb_tree, but doesn't return a referenced pointer to the
> caller. There are cases where it is useful for the creator of a new
> ordered_extent to hang on to such a pointer, so add a new function
> btrfs_alloc_ordered_extent which is the same as
> btrfs_add_ordered_extent, except it takes an additional reference count
> and returns a pointer to the ordered_extent. Implement
> btrfs_add_ordered_extent as btrfs_alloc_ordered_extent followed by
> dropping the new reference and handling the IS_ERR case.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/ordered-data.c | 45 ++++++++++++++++++++++++++++++++---------
>  fs/btrfs/ordered-data.h |  7 ++++++-
>  2 files changed, 42 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 6c24b69e2d0a..35c082ef163e 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -160,14 +160,16 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
>   * @compress_type:   Compression algorithm used for data.
>   *
>   * Most of these parameters correspond to &struct btrfs_file_extent_item. The
> - * tree is given a single reference on the ordered extent that was inserted.
> + * tree is given a single reference on the ordered extent that was inserted, and
> + * the returned pointer is given a second reference.
>   *
> - * Return: 0 or -ENOMEM.
> + * Return: the new ordered_extent or ERR_PTR(-ENOMEM).

Can we be consistent with the rest of the comments, and mention
"ordered extent" instead of "ordered_extent"? After all, the latter is
not a type name (which would be btrfs_ordered_extent).

>   */
> -int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
> -                            u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> -                            u64 disk_num_bytes, u64 offset, unsigned flags,
> -                            int compress_type)
> +struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
> +                       struct btrfs_inode *inode, u64 file_offset,
> +                       u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> +                       u64 disk_num_bytes, u64 offset, unsigned long flags,
> +                       int compress_type)
>  {
>         struct btrfs_root *root = inode->root;
>         struct btrfs_fs_info *fs_info = root->fs_info;
> @@ -181,7 +183,7 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
>                 /* For nocow write, we can release the qgroup rsv right now */
>                 ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
>                 if (ret < 0)
> -                       return ret;
> +                       return ERR_PTR(ret);
>                 ret = 0;
>         } else {
>                 /*
> @@ -190,11 +192,11 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
>                  */
>                 ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes);
>                 if (ret < 0)
> -                       return ret;
> +                       return ERR_PTR(ret);
>         }
>         entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
>         if (!entry)
> -               return -ENOMEM;
> +               return ERR_PTR(-ENOMEM);
>
>         entry->file_offset = file_offset;
>         entry->num_bytes = num_bytes;
> @@ -256,6 +258,31 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
>         btrfs_mod_outstanding_extents(inode, 1);
>         spin_unlock(&inode->lock);
>
> +       /* one ref for the returned entry to match semantics of lookup */
> +       refcount_inc(&entry->refs);
> +       return entry;
> +}
> +
> +

Double newline, use a single one.

Can we also get a better subject than just "btrfs: btrfs_alloc_ordered_extent"?

Perhaps something like: "btrfs: add function to create and return an
ordered extent".

Those are just minor things, David can fix them up when he picks the
patch if he wants to, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>



> +/*
> + * Add a new btrfs_ordered_extent for the range, but drop the reference
> + * instead of returning it to the caller.
> + */
> +int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
> +                            u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> +                            u64 disk_num_bytes, u64 offset, unsigned long flags,
> +                            int compress_type)
> +{
> +       struct btrfs_ordered_extent *ordered;
> +
> +       ordered = btrfs_alloc_ordered_extent(inode, file_offset, num_bytes,
> +                                            ram_bytes, disk_bytenr,
> +                                            disk_num_bytes, offset, flags,
> +                                            compress_type);
> +
> +       if (IS_ERR(ordered))
> +               return PTR_ERR(ordered);
> +       btrfs_put_ordered_extent(ordered);
>         return 0;
>  }
>
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index eb40cb39f842..18007f9c00ad 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -178,9 +178,14 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>  bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>                                     struct btrfs_ordered_extent **cached,
>                                     u64 file_offset, u64 io_size);
> +struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
> +                       struct btrfs_inode *inode, u64 file_offset,
> +                       u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> +                       u64 disk_num_bytes, u64 offset, unsigned long flags,
> +                       int compress_type);
>  int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
>                              u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> -                            u64 disk_num_bytes, u64 offset, unsigned flags,
> +                            u64 disk_num_bytes, u64 offset, unsigned long flags,
>                              int compress_type);
>  void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
>                            struct btrfs_ordered_sum *sum);
> --
> 2.38.1
>
