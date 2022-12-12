Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B231C64A585
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiLLRGK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 12:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiLLRFf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 12:05:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E911C09
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 09:05:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1649A61170
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 17:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADABC433F0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 17:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670864733;
        bh=jMRtedQwLDky2AHrIJXD/L8peqZiqTccXN+NmRvAxAk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=emtJDG19rJPDHl+eh05nF3zetgaiEFs3v1QHbMZEzRUJvSwUKP4M1mDqsUllmut+V
         OqKerTbPf5oU83VJoPjda0PmrNgfBonqZetRb9sDVuD9VdkIa3NfYTjNqTV+7wn3OJ
         4n+HYAgqEroznn/OvcNe776LKfqKqA0JH0KigcX00dD1LnrjUd0FlQBviK9om9aUDL
         Zctfa3VQD9wdKzxphu+vQrbFuO7YBVNIJ1d3nOoEXkkIcHc+rjuQUHxyulZe9Ng1X+
         tz/ObChX+E3VLWYvaZKN5GrmgoPG9RGfOnPOY0+1N7J6QoJY/IWq5wVuwyToc1Bsas
         1j+YkC8zjvYVg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-14449b7814bso9158061fac.3
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 09:05:33 -0800 (PST)
X-Gm-Message-State: ANoB5plqi8vD8VYbMhPJRn66v67dtGWr949TFYUvvh3Uhbyz+DEHBY6s
        Ev/aNbY3wclyry8aTclkvz+21mzVR6WYe+n76aM=
X-Google-Smtp-Source: AA0mqf5dfdoQZc8w/Or32jN9um3kQkQYiIZ0ddklj+cS2GFyEk9wgfN66D5C6RZmUVownrOlORiiVYqpUO8hHIhp3VY=
X-Received: by 2002:a05:6870:668a:b0:145:3a7:99c with SMTP id
 ge10-20020a056870668a00b0014503a7099cmr1161569oab.92.1670864732519; Mon, 12
 Dec 2022 09:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20221205095122.17011-1-robbieko@synology.com> <20221205095122.17011-2-robbieko@synology.com>
In-Reply-To: <20221205095122.17011-2-robbieko@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 12 Dec 2022 17:04:56 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5aX6_ht0DMRg=_XHhBWMeVOYWSNUzvtbiSq+AFEbkA_w@mail.gmail.com>
Message-ID: <CAL3q7H5aX6_ht0DMRg=_XHhBWMeVOYWSNUzvtbiSq+AFEbkA_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: refactor anon_dev with new_fs_root_args for
 create subvolume/snapshot
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 5, 2022 at 10:11 AM robbieko <robbieko@synology.com> wrote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> Create a new structure called btrfs_new_fs_root_args that
> refactor the type of anon_dev.
> With the new structure, btrfs_get_new_fs_root can input
> btrfs_new_fs_root_args into btrfs_init_fs_root by order.
>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/btrfs/disk-io.c     | 63 ++++++++++++++++++++++++++++++------------
>  fs/btrfs/disk-io.h     | 10 ++++++-
>  fs/btrfs/ioctl.c       | 34 +++++++++++------------
>  fs/btrfs/transaction.c |  2 +-
>  fs/btrfs/transaction.h |  5 ++--
>  5 files changed, 74 insertions(+), 40 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index d99bf7c64611..afe16e1f0b18 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1422,12 +1422,44 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
>         return root;
>  }
>
> +struct btrfs_new_fs_root_args *btrfs_new_fs_root_args_prepare(gfp_t gfp_mask)

Can we remove the argument?
Even after the whole patchset, it will always be GFP_KERNEL.

I know patch 3/3 adds an assertion to verify we get GFP_KERNEL, but
lockdep is smart enough to detect an issue and complain.

Also, can you name the function something like btrfs_alloc_new_fs_roots_arg() ?
The naming pattern we use for allocator functions is to use "alloc" in
the name, for e.g. btrfs_alloc_path(), alloc_extent_map(), etc.
So having an allocator named *_prepare() breaks the pattern and it's
also confusing (as it allocates the structure).

> +{
> +       int err;
> +       struct btrfs_new_fs_root_args *args;
> +
> +       args = kzalloc(sizeof(*args), gfp_mask);
> +       if (!args) {
> +               err = -ENOMEM;
> +               goto error;
> +       }

if (!args)
     return ERR_PTR(-ENOMEM);

That's simpler.

> +
> +       err = get_anon_bdev(&args->anon_dev);
> +       if (err)
> +               goto error;
> +
> +       return args;
> +
> +error:
> +       btrfs_new_fs_root_args_destroy(args);
> +       return ERR_PTR(err);
> +}
> +
> +void btrfs_new_fs_root_args_destroy(struct btrfs_new_fs_root_args *args)

Same thing about the naming consistency here. Something like:
btrfs_free_new_fs_roots_arg()
We have btrfs_free_path(), free_extent_map(), etc.

Thanks.

> +{
> +       if (!args)
> +               return;
> +       if (args->anon_dev)
> +               free_anon_bdev(args->anon_dev);
> +       kfree(args);
> +}
> +
>  /*
>   * Initialize subvolume root in-memory structure
>   *
>   * @anon_dev:  anonymous device to attach to the root, if zero, allocate new
>   */
> -static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
> +static int btrfs_init_fs_root(struct btrfs_root *root,
> +                             struct btrfs_new_fs_root_args *new_fs_root_args)
>  {
>         int ret;
>         unsigned int nofs_flag;
> @@ -1454,12 +1486,13 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
>          */
>         if (is_fstree(root->root_key.objectid) &&
>             btrfs_root_refs(&root->root_item) > 0) {
> -               if (!anon_dev) {
> +               if (!new_fs_root_args || !new_fs_root_args->anon_dev) {
>                         ret = get_anon_bdev(&root->anon_dev);
>                         if (ret)
>                                 goto fail;
>                 } else {
> -                       root->anon_dev = anon_dev;
> +                       root->anon_dev = new_fs_root_args->anon_dev;
> +                       new_fs_root_args->anon_dev = 0;
>                 }
>         }
>
> @@ -1633,7 +1666,8 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>   *             for orphan roots
>   */
>  static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
> -                                            u64 objectid, dev_t anon_dev,
> +                                            u64 objectid,
> +                                            struct btrfs_new_fs_root_args *new_fs_root_args,
>                                              bool check_ref)
>  {
>         struct btrfs_root *root;
> @@ -1647,8 +1681,8 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
>  again:
>         root = btrfs_lookup_fs_root(fs_info, objectid);
>         if (root) {
> -               /* Shouldn't get preallocated anon_dev for cached roots */
> -               ASSERT(!anon_dev);
> +               /* Shouldn't get new_fs_root_args for cached roots */
> +               ASSERT(!new_fs_root_args);
>                 if (check_ref && btrfs_root_refs(&root->root_item) == 0) {
>                         btrfs_put_root(root);
>                         return ERR_PTR(-ENOENT);
> @@ -1668,7 +1702,7 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
>                 goto fail;
>         }
>
> -       ret = btrfs_init_fs_root(root, anon_dev);
> +       ret = btrfs_init_fs_root(root, new_fs_root_args);
>         if (ret)
>                 goto fail;
>
> @@ -1698,14 +1732,6 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
>         }
>         return root;
>  fail:
> -       /*
> -        * If our caller provided us an anonymous device, then it's his
> -        * responsibility to free it in case we fail. So we have to set our
> -        * root's anon_dev to 0 to avoid a double free, once by btrfs_put_root()
> -        * and once again by our caller.
> -        */
> -       if (anon_dev)
> -               root->anon_dev = 0;
>         btrfs_put_root(root);
>         return ERR_PTR(ret);
>  }
> @@ -1720,7 +1746,7 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
>  struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
>                                      u64 objectid, bool check_ref)
>  {
> -       return btrfs_get_root_ref(fs_info, objectid, 0, check_ref);
> +       return btrfs_get_root_ref(fs_info, objectid, NULL, check_ref);
>  }
>
>  /*
> @@ -1732,9 +1758,10 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
>   *             parameter value
>   */
>  struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
> -                                        u64 objectid, dev_t anon_dev)
> +                                        u64 objectid,
> +                                        struct btrfs_new_fs_root_args *new_fs_root_args)
>  {
> -       return btrfs_get_root_ref(fs_info, objectid, anon_dev, true);
> +       return btrfs_get_root_ref(fs_info, objectid, new_fs_root_args, true);
>  }
>
>  /*
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 9fa923e005a3..a7c91bfb0c16 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -25,6 +25,11 @@ static inline u64 btrfs_sb_offset(int mirror)
>         return BTRFS_SUPER_INFO_OFFSET;
>  }
>
> +struct btrfs_new_fs_root_args {
> +       /* Preallocated anonymous block device number */
> +       dev_t anon_dev;
> +};
> +
>  struct btrfs_device;
>  struct btrfs_fs_devices;
>
> @@ -58,6 +63,8 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>  int btrfs_commit_super(struct btrfs_fs_info *fs_info);
>  struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
>                                         struct btrfs_key *key);
> +struct btrfs_new_fs_root_args *btrfs_new_fs_root_args_prepare(gfp_t gfp_mask);
> +void btrfs_new_fs_root_args_destroy(struct btrfs_new_fs_root_args *args);
>  int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
>                          struct btrfs_root *root);
>  void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
> @@ -65,7 +72,8 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
>  struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
>                                      u64 objectid, bool check_ref);
>  struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
> -                                        u64 objectid, dev_t anon_dev);
> +                                        u64 objectid,
> +                                        struct btrfs_new_fs_root_args *new_fs_root_args);
>  struct btrfs_root *btrfs_get_fs_root_commit_root(struct btrfs_fs_info *fs_info,
>                                                  struct btrfs_path *path,
>                                                  u64 objectid);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 5ba2e810dc6e..5785336ab7cf 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -588,8 +588,8 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
>         };
>         unsigned int trans_num_items;
>         int ret;
> -       dev_t anon_dev;
>         u64 objectid;
> +       struct btrfs_new_fs_root_args *new_fs_root_args = NULL;
>
>         root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
>         if (!root_item)
> @@ -608,14 +608,17 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
>                 goto out_root_item;
>         }
>
> -       ret = get_anon_bdev(&anon_dev);
> -       if (ret < 0)
> +       new_fs_root_args = btrfs_new_fs_root_args_prepare(GFP_KERNEL);
> +       if (IS_ERR(new_fs_root_args)) {
> +               ret = PTR_ERR(new_fs_root_args);
> +               new_fs_root_args = NULL;
>                 goto out_root_item;
> +       }
>
>         new_inode_args.inode = btrfs_new_subvol_inode(mnt_userns, dir);
>         if (!new_inode_args.inode) {
>                 ret = -ENOMEM;
> -               goto out_anon_dev;
> +               goto out_root_item;
>         }
>         ret = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
>         if (ret)
> @@ -706,14 +709,12 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
>         free_extent_buffer(leaf);
>         leaf = NULL;
>
> -       new_root = btrfs_get_new_fs_root(fs_info, objectid, anon_dev);
> +       new_root = btrfs_get_new_fs_root(fs_info, objectid, new_fs_root_args);
>         if (IS_ERR(new_root)) {
>                 ret = PTR_ERR(new_root);
>                 btrfs_abort_transaction(trans, ret);
>                 goto out;
>         }
> -       /* anon_dev is owned by new_root now. */
> -       anon_dev = 0;
>         BTRFS_I(new_inode_args.inode)->root = new_root;
>         /* ... and new_root is owned by new_inode_args.inode now. */
>
> @@ -752,10 +753,8 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
>         btrfs_new_inode_args_destroy(&new_inode_args);
>  out_inode:
>         iput(new_inode_args.inode);
> -out_anon_dev:
> -       if (anon_dev)
> -               free_anon_bdev(anon_dev);
>  out_root_item:
> +       btrfs_new_fs_root_args_destroy(new_fs_root_args);
>         kfree(root_item);
>         return ret;
>  }
> @@ -791,9 +790,13 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
>         if (!pending_snapshot)
>                 return -ENOMEM;
>
> -       ret = get_anon_bdev(&pending_snapshot->anon_dev);
> -       if (ret < 0)
> +       pending_snapshot->new_fs_root_args = btrfs_new_fs_root_args_prepare(GFP_KERNEL);
> +       if (IS_ERR(pending_snapshot->new_fs_root_args)) {
> +               ret = PTR_ERR(pending_snapshot->new_fs_root_args);
> +               pending_snapshot->new_fs_root_args = NULL;
>                 goto free_pending;
> +       }
> +
>         pending_snapshot->root_item = kzalloc(sizeof(struct btrfs_root_item),
>                         GFP_KERNEL);
>         pending_snapshot->path = btrfs_alloc_path();
> @@ -850,16 +853,11 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
>
>         d_instantiate(dentry, inode);
>         ret = 0;
> -       pending_snapshot->anon_dev = 0;
>  fail:
> -       /* Prevent double freeing of anon_dev */
> -       if (ret && pending_snapshot->snap)
> -               pending_snapshot->snap->anon_dev = 0;
>         btrfs_put_root(pending_snapshot->snap);
>         btrfs_subvolume_release_metadata(root, &pending_snapshot->block_rsv);
>  free_pending:
> -       if (pending_snapshot->anon_dev)
> -               free_anon_bdev(pending_snapshot->anon_dev);
> +       btrfs_new_fs_root_args_destroy(pending_snapshot->new_fs_root_args);
>         kfree(pending_snapshot->root_item);
>         btrfs_free_path(pending_snapshot->path);
>         kfree(pending_snapshot);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index d1f1da6820fb..614eb84422e1 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1777,7 +1777,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>         }
>
>         key.offset = (u64)-1;
> -       pending->snap = btrfs_get_new_fs_root(fs_info, objectid, pending->anon_dev);
> +       pending->snap = btrfs_get_new_fs_root(fs_info, objectid, pending->new_fs_root_args);
>         if (IS_ERR(pending->snap)) {
>                 ret = PTR_ERR(pending->snap);
>                 pending->snap = NULL;
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 970ff316069d..34648a617a2c 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -10,6 +10,7 @@
>  #include "btrfs_inode.h"
>  #include "delayed-ref.h"
>  #include "ctree.h"
> +#include "disk-io.h"
>
>  enum btrfs_trans_state {
>         TRANS_STATE_RUNNING,
> @@ -161,8 +162,8 @@ struct btrfs_pending_snapshot {
>         struct btrfs_block_rsv block_rsv;
>         /* extra metadata reservation for relocation */
>         int error;
> -       /* Preallocated anonymous block device number */
> -       dev_t anon_dev;
> +       /* Preallocated new_fs_root_args */
> +       struct btrfs_new_fs_root_args *new_fs_root_args;
>         bool readonly;
>         struct list_head list;
>  };
> --
> 2.17.1
>
