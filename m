Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B828364A58A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 18:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiLLRHX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 12:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiLLRHU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 12:07:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FBE2711
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 09:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92B2CB80DC8
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 17:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43294C433D2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 17:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670864835;
        bh=Dm387btxpZaHWQPaiXzTznKd86jrWzJWHtTgBvMflx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UDAInhOR4u4IyoYOtZQNhv/2yaQ5YhjVgMugi5xyswfY9czEESyTPVxaHwmWM68A/
         dMJUVQyQu2seRcS+353GMiPpdrc1u+vyw3hKUdY1+VET8ZxM+9y2Ww0gzk5yXG4LQW
         +5C0YxabAXnk2iE0MZ7Cji1ZCdlpVsMSv85dkP6ocvljj2yDHcUtF74QEiqC5zsSv6
         kG/IGkwZUY23YcFONtqlgr6Vg1hFAsphqnUnfAxvy0rlhNKljimKRDIzmTPR05yAV2
         srYt5zzcXNZE/btZAZoj4gzSXRMJi8FslVtxY4CFOpkkNppC1CnQXzmq0pURSBPVVj
         eSlwujuBbdcdQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1443a16b71cso9117696fac.13
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 09:07:15 -0800 (PST)
X-Gm-Message-State: ANoB5pnoMDztGNiszwxgsnr2l2gnxz62y5bGhQD3C6bpt55eH4TnVKxg
        5mR9zx2zNCWW74ToMqqrjvabQ+wIWi25MntcZm0=
X-Google-Smtp-Source: AA0mqf7rAR3+lleBUnJxL7xkkLssuj5MV30dmZxsRM9T8CJf03Y6MG7s/UmRV0Uo1N/F0qLxxlBn2KfohqvsaITjKow=
X-Received: by 2002:a05:6870:668a:b0:145:3a7:99c with SMTP id
 ge10-20020a056870668a00b0014503a7099cmr1161996oab.92.1670864834348; Mon, 12
 Dec 2022 09:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20221205095122.17011-1-robbieko@synology.com> <20221205095122.17011-4-robbieko@synology.com>
In-Reply-To: <20221205095122.17011-4-robbieko@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 12 Dec 2022 17:06:38 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5aMnihK3rDWweFgzDYsDjigDxR8xitCG2vVjYQu55MEA@mail.gmail.com>
Message-ID: <CAL3q7H5aMnihK3rDWweFgzDYsDjigDxR8xitCG2vVjYQu55MEA@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: add snapshot_lock to new_fs_root_args
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

On Mon, Dec 5, 2022 at 10:36 AM robbieko <robbieko@synology.com> wrote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> Add snapshot_lock into new_fs_root_args to prevent
> percpu_counter_init enter unexpected -ENOMEM when
> calling btrfs_init_fs_root.

You could be more detailed here and mention that all this is to
prevent transaction aborts in case percpu_counter_init() fails to
allocate memory.

Interpreting literally what you wrote, it gives the idea that after
this patch the memory allocation can never fail, which isn't true.
The goal is just to allocate the snapshot lock before holding a
transaction handle, so that we can use GFP_KERNEL, which reduces the
chances of memory allocation failing and, above all, avoid aborting a
transaction and turn the fs to RO mode.

>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/btrfs/disk-io.c | 44 +++++++++++++++++++++++++++++++-------------
>  fs/btrfs/disk-io.h |  2 ++
>  2 files changed, 33 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5760c2b1a100..5704c8f5873c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1437,6 +1437,16 @@ struct btrfs_new_fs_root_args *btrfs_new_fs_root_args_prepare(gfp_t gfp_mask)
>         if (err)
>                 goto error;
>
> +       args->snapshot_lock = kzalloc(sizeof(*args->snapshot_lock), gfp_mask);
> +       if (!args->snapshot_lock) {
> +               err = -ENOMEM;
> +               goto error;
> +       }
> +       ASSERT((gfp_mask & GFP_KERNEL) == GFP_KERNEL);

As commented for patch 1/3, we could get away with the argument and
directly use GFP_KERNEL above, and let lockdep warn us (which makes
fstests fail).

> +       err = btrfs_drew_lock_init(args->snapshot_lock);
> +       if (err)
> +               goto error;
> +
>         return args;
>
>  error:
> @@ -1448,6 +1458,9 @@ void btrfs_new_fs_root_args_destroy(struct btrfs_new_fs_root_args *args)
>  {
>         if (!args)
>                 return;
> +       if (args->snapshot_lock)
> +               btrfs_drew_lock_destroy(args->snapshot_lock);
> +       kfree(args->snapshot_lock);

You could combine the kfree of the lock inside the if statement,
making it more clear imo.

>         if (args->anon_dev)
>                 free_anon_bdev(args->anon_dev);
>         kfree(args);
> @@ -1464,20 +1477,25 @@ static int btrfs_init_fs_root(struct btrfs_root *root,
>         int ret;
>         unsigned int nofs_flag;
>
> -       root->snapshot_lock = kzalloc(sizeof(*root->snapshot_lock), GFP_NOFS);
> -       if (!root->snapshot_lock) {
> -               ret = -ENOMEM;
> -               goto fail;
> +       if (new_fs_root_args && new_fs_root_args->snapshot_lock) {
> +               root->snapshot_lock = new_fs_root_args->snapshot_lock;
> +               new_fs_root_args->snapshot_lock = NULL;
> +       } else {
> +               root->snapshot_lock = kzalloc(sizeof(*root->snapshot_lock), GFP_NOFS);
> +               if (!root->snapshot_lock) {
> +                       ret = -ENOMEM;
> +                       goto fail;
> +               }
> +               /*
> +                * We might be called under a transaction (e.g. indirect backref
> +                * resolution) which could deadlock if it triggers memory reclaim

While here, we could end the sentence with punctuation (.).

Thanks.

> +                */
> +               nofs_flag = memalloc_nofs_save();
> +               ret = btrfs_drew_lock_init(root->snapshot_lock);
> +               memalloc_nofs_restore(nofs_flag);
> +               if (ret)
> +                       goto fail;
>         }
> -       /*
> -        * We might be called under a transaction (e.g. indirect backref
> -        * resolution) which could deadlock if it triggers memory reclaim
> -        */
> -       nofs_flag = memalloc_nofs_save();
> -       ret = btrfs_drew_lock_init(root->snapshot_lock);
> -       memalloc_nofs_restore(nofs_flag);
> -       if (ret)
> -               goto fail;
>
>         if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
>             !btrfs_is_data_reloc_root(root)) {
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index a7c91bfb0c16..0e84927859ce 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -28,6 +28,8 @@ static inline u64 btrfs_sb_offset(int mirror)
>  struct btrfs_new_fs_root_args {
>         /* Preallocated anonymous block device number */
>         dev_t anon_dev;
> +       /* Preallocated snapshot lock */
> +       struct btrfs_drew_lock *snapshot_lock;
>  };
>
>  struct btrfs_device;
> --
> 2.17.1
>
