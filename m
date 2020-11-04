Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7FE2A68B3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 16:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgKDPzM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 10:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbgKDPzK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 10:55:10 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556EFC0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 07:55:10 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id r12so383932qvq.13
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 07:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vUb5mnDZyUaPB/Te7/z8laR/Nhqi8wKLY7AjT1MD+hk=;
        b=jIDhY/ZVLwyQq7Zv5AmBWmvwCo4+Il1f3X4ydQOs7i4LE12XvwT+FyJhmIme0NjWJR
         lWG3N1CzROJjFfAi1U1G7x/+T299ZE/fhtpuXbrpL2kMSuX5rFfIou6V6NqmYEC2HzmH
         cMGNudcntwNN5YJc4g/Q1oVLSIayAIYez9YAs3Mji56HqZixO2SOdAKc01NO6SmuFC5a
         zG96drhIN5q4IY7bY3I+jU34JWBpTD5t8j9V0kRySOLcy3R85X84OhqQV8ayluWvKER/
         XvYO86i+TVsnlPNnwSNLalWupZx7045AP0vm7dhEDfuW/EYdjaaxvX0PlhFZaL+63D1I
         z5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vUb5mnDZyUaPB/Te7/z8laR/Nhqi8wKLY7AjT1MD+hk=;
        b=D6cBqZb7c52HTVIuvk/MNK2vc8ETLboOBsbc4MJ9C0I4DhR8s0MlWto5IrtoynbZRt
         HJ5wHeeavDRNpNdpSpth/RshTLGzdvxn990n3XqkV1gLXmk+Ana2D3kVOHXetreaB3Ro
         yf8/NRUxLUwuC0eEGR2ehAvK9NNhv4qy1e4ncNthMUybD5MEUoXgSyKDNQGVuoXtzbgd
         upmRFtOZaaA0AykwjdQnWwVabaJ8LRz2IqllpNxJ5YaL/pSHfIJNwVPdjBNz7WNVT7h2
         F2R7QjMi5+bRzsvrqKkifPFjFriws5COV0Ik8c2drJDuEyp5EhkODgluh0PNFpnhzNHY
         q9+w==
X-Gm-Message-State: AOAM530vAIivauBT7GMbn+EHDzGyVsxQpBYjI6xX3peD3Wwe2Xzoyz5P
        oa+q3641qAjoh/yjAjE6kVPVAOOZsgQ/oJ7+J8g=
X-Google-Smtp-Source: ABdhPJxSQuhG7FYHgpCJ6s7QVfWEF69DILvuVESeYHv3STMEPatJI3Br3glspKKfOQcarEIAgXl1h1VS8zOavB6m1/o=
X-Received: by 2002:a0c:f70f:: with SMTP id w15mr32241289qvn.45.1604505309574;
 Wed, 04 Nov 2020 07:55:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603460665.git.josef@toxicpanda.com> <afb3c72b04191707f96001bc3698e14b4d3400a8.1603460665.git.josef@toxicpanda.com>
In-Reply-To: <afb3c72b04191707f96001bc3698e14b4d3400a8.1603460665.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 4 Nov 2020 15:54:58 +0000
Message-ID: <CAL3q7H5ddLEFbisuFmauK9=XX+sEPy-O4R7X1kp67YH4N1hfcw@mail.gmail.com>
Subject: Re: [PATCH 4/8] btrfs: cleanup btrfs_discard_update_discardable usage
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 23, 2020 at 5:12 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> This passes in the block_group and the free_space_ctl, but we can get
> this from the block group itself.  Part of this is because we call it
> from __load_free_space_cache, which can be called for the inode cache as
> well.  Move that call into the block group specific load section, wrap
> it in the right lock that we need, and fix up the arguments to only take
> the block group.  Add a lockdep_assert as well for good measure to make
> sure we don't mess up the locking again.

So this is actually 2 different things in one patch:

1) A cleanup to remove an unnecessary argument to
btrfs_discard_update_discardable();

2) A bug because btrfs_discard_update_discardable() is not being
called with the lock ->tree_lock held in one specific context.

Shouldn't we really have this split in two patches?

Other than that, it looks good. Thanks.

>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/discard.c          |  7 ++++---
>  fs/btrfs/discard.h          |  3 +--
>  fs/btrfs/free-space-cache.c | 14 ++++++++------
>  3 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 741c7e19c32f..5a88b584276f 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -563,15 +563,14 @@ void btrfs_discard_calc_delay(struct btrfs_discard_=
ctl *discard_ctl)
>  /**
>   * btrfs_discard_update_discardable - propagate discard counters
>   * @block_group: block_group of interest
> - * @ctl: free_space_ctl of @block_group
>   *
>   * This propagates deltas of counters up to the discard_ctl.  It maintai=
ns a
>   * current counter and a previous counter passing the delta up to the gl=
obal
>   * stat.  Then the current counter value becomes the previous counter va=
lue.
>   */
> -void btrfs_discard_update_discardable(struct btrfs_block_group *block_gr=
oup,
> -                                     struct btrfs_free_space_ctl *ctl)
> +void btrfs_discard_update_discardable(struct btrfs_block_group *block_gr=
oup)
>  {
> +       struct btrfs_free_space_ctl *ctl;
>         struct btrfs_discard_ctl *discard_ctl;
>         s32 extents_delta;
>         s64 bytes_delta;
> @@ -581,8 +580,10 @@ void btrfs_discard_update_discardable(struct btrfs_b=
lock_group *block_group,
>             !btrfs_is_block_group_data_only(block_group))
>                 return;
>
> +       ctl =3D block_group->free_space_ctl;
>         discard_ctl =3D &block_group->fs_info->discard_ctl;
>
> +       lockdep_assert_held(&ctl->tree_lock);
>         extents_delta =3D ctl->discardable_extents[BTRFS_STAT_CURR] -
>                         ctl->discardable_extents[BTRFS_STAT_PREV];
>         if (extents_delta) {
> diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> index 353228d62f5a..57b9202f427f 100644
> --- a/fs/btrfs/discard.h
> +++ b/fs/btrfs/discard.h
> @@ -28,8 +28,7 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *d=
iscard_ctl);
>
>  /* Update operations */
>  void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl);
> -void btrfs_discard_update_discardable(struct btrfs_block_group *block_gr=
oup,
> -                                     struct btrfs_free_space_ctl *ctl);
> +void btrfs_discard_update_discardable(struct btrfs_block_group *block_gr=
oup);
>
>  /* Setup/cleanup operations */
>  void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info);
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 5ea36a06e514..0787339c7b93 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -828,7 +828,6 @@ static int __load_free_space_cache(struct btrfs_root =
*root, struct inode *inode,
>         merge_space_tree(ctl);
>         ret =3D 1;
>  out:
> -       btrfs_discard_update_discardable(ctl->private, ctl);
>         io_ctl_free(&io_ctl);
>         return ret;
>  free_cache:
> @@ -929,6 +928,9 @@ int load_free_space_cache(struct btrfs_block_group *b=
lock_group)
>                            block_group->start);
>         }
>
> +       spin_lock(&ctl->tree_lock);
> +       btrfs_discard_update_discardable(block_group);
> +       spin_unlock(&ctl->tree_lock);
>         iput(inode);
>         return ret;
>  }
> @@ -2508,7 +2510,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs=
_info,
>         if (ret)
>                 kmem_cache_free(btrfs_free_space_cachep, info);
>  out:
> -       btrfs_discard_update_discardable(block_group, ctl);
> +       btrfs_discard_update_discardable(block_group);
>         spin_unlock(&ctl->tree_lock);
>
>         if (ret) {
> @@ -2643,7 +2645,7 @@ int btrfs_remove_free_space(struct btrfs_block_grou=
p *block_group,
>                 goto again;
>         }
>  out_lock:
> -       btrfs_discard_update_discardable(block_group, ctl);
> +       btrfs_discard_update_discardable(block_group);
>         spin_unlock(&ctl->tree_lock);
>  out:
>         return ret;
> @@ -2779,7 +2781,7 @@ void __btrfs_remove_free_space_cache(struct btrfs_f=
ree_space_ctl *ctl)
>         spin_lock(&ctl->tree_lock);
>         __btrfs_remove_free_space_cache_locked(ctl);
>         if (ctl->private)
> -               btrfs_discard_update_discardable(ctl->private, ctl);
> +               btrfs_discard_update_discardable(ctl->private);
>         spin_unlock(&ctl->tree_lock);
>  }
>
> @@ -2801,7 +2803,7 @@ void btrfs_remove_free_space_cache(struct btrfs_blo=
ck_group *block_group)
>                 cond_resched_lock(&ctl->tree_lock);
>         }
>         __btrfs_remove_free_space_cache_locked(ctl);
> -       btrfs_discard_update_discardable(block_group, ctl);
> +       btrfs_discard_update_discardable(block_group);
>         spin_unlock(&ctl->tree_lock);
>
>  }
> @@ -2885,7 +2887,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_g=
roup *block_group,
>                         link_free_space(ctl, entry);
>         }
>  out:
> -       btrfs_discard_update_discardable(block_group, ctl);
> +       btrfs_discard_update_discardable(block_group);
>         spin_unlock(&ctl->tree_lock);
>
>         if (align_gap_len)
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
