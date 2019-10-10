Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76916D2DDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 17:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfJJPg6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 11:36:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34776 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfJJPg5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 11:36:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so9376410qta.1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZGUqxAsfEUBnPhf/HPp5x0WiWvwH7+H8ZvmRDPkGZvo=;
        b=Hk48NuIMkS0+DNmmfvGf/gjXaiesKJ7LqFMfGfAOemwTOvIfgShrdty4lW72YfvwnK
         mdXc762/SxDg2OR+yeI0q+gdG6mpMCO0EO5OKQf6lzCM8+1pGkWEWmvz648XylV7qyFl
         DNJdQIH5ib6CRkIReO7apRPgybxsLtAQLFLrTkjvUXbBktOOppCmI6KF/Yah5scHu8d5
         issipW56imJQ+7kxjnVNsDwnnUvolDHuNM48H59mN42JyE+gGb2LY1nnuLK/i4VS0A1R
         c0k0+v1neUwMn29qPpR+GYllQ++LuMYIuarAD/u3joplesCXmV0xbt1sDn+I+EILKnzA
         b4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZGUqxAsfEUBnPhf/HPp5x0WiWvwH7+H8ZvmRDPkGZvo=;
        b=RQcBSWeUEZ86JfYmc4zRzp0xilvQZuhW+iksEHR6/IDYFTHNx3mVpZ1sH6AEJ8a/QA
         fl3+L9E1bPhkvy0P+1p+yzEkRL7JxuznnmKpoaPPDgt2ubHk9uADrLRJWuP8HkUs7ks0
         i+piz1wYlmNlrAI4+UHBZWHjZAec81yHAdQBFWTSrGqoiXIuSnl/9t4aQ9jz1wY+juaU
         Y+kYCnH5ZR3AyQUmVUBhCPlavnIFmJ1PUv79wQBmCNd9WWtJsluTytTE6E1VAwgcd3Bu
         v3ZR5wmASfy0Fx7G4tWlFkndOHYcR7+zQxhJqunV8UmdA019Qe2qbwsZBj9yDLs9UQqj
         HANw==
X-Gm-Message-State: APjAAAVYBl2u/qCVROLX9QBeT03g+0tU2tcVtnftA4Jg06K7JteHQ7HM
        uh7QvqfumFJiapFJ/GIP97597A==
X-Google-Smtp-Source: APXvYqyiUkLYI3+DFVREFm6mcXv9MmRduPUZZvKNvGCUPXWFhicn/EPuzba2WvWxmhp2jyiRM+w+9w==
X-Received: by 2002:ac8:3724:: with SMTP id o33mr10754465qtb.87.1570721816593;
        Thu, 10 Oct 2019 08:36:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id b26sm2613766qkl.43.2019.10.10.08.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 08:36:55 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:36:54 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/19] btrfs: track discardable extents for asnyc discard
Message-ID: <20191010153653.7b26qpleh64dext3@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <31c4f29228c76df72cc92112e397db648e9b9ab9.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31c4f29228c76df72cc92112e397db648e9b9ab9.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:39PM -0400, Dennis Zhou wrote:
> The number of discardable extents will serve as the rate limiting metric
> for how often we should discard. This keeps track of discardable extents
> in the free space caches by maintaining deltas and propagating them to
> the global count.
> 
> This also setups up a discard directory in btrfs sysfs and exports the
> total discard_extents count.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/ctree.h            |  2 +
>  fs/btrfs/discard.c          |  2 +
>  fs/btrfs/discard.h          | 19 ++++++++
>  fs/btrfs/free-space-cache.c | 93 ++++++++++++++++++++++++++++++++++---
>  fs/btrfs/free-space-cache.h |  2 +
>  fs/btrfs/sysfs.c            | 33 +++++++++++++
>  6 files changed, 144 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index c328d2e85e4d..43e515939b9c 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -447,6 +447,7 @@ struct btrfs_discard_ctl {
>  	spinlock_t lock;
>  	struct btrfs_block_group_cache *cache;
>  	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
> +	atomic_t discard_extents;
>  };
>  
>  /* delayed seq elem */
> @@ -831,6 +832,7 @@ struct btrfs_fs_info {
>  	struct btrfs_workqueue *scrub_wr_completion_workers;
>  	struct btrfs_workqueue *scrub_parity_workers;
>  
> +	struct kobject *discard_kobj;
>  	struct btrfs_discard_ctl discard_ctl;
>  
>  #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 26a1e44b4bfa..0544eb6717d4 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -298,6 +298,8 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
>  
>  	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++)
>  		 INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
> +
> +	atomic_set(&discard_ctl->discard_extents, 0);
>  }
>  
>  void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
> diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> index 22cfa7e401bb..85939d62521e 100644
> --- a/fs/btrfs/discard.h
> +++ b/fs/btrfs/discard.h
> @@ -71,4 +71,23 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
>  		btrfs_discard_schedule_work(discard_ctl, false);
>  }
>  
> +static inline
> +void btrfs_discard_update_discardable(struct btrfs_block_group_cache *cache,
> +				      struct btrfs_free_space_ctl *ctl)
> +{
> +	struct btrfs_discard_ctl *discard_ctl;
> +	s32 extents_delta;
> +
> +	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
> +		return;
> +
> +	discard_ctl = &cache->fs_info->discard_ctl;
> +
> +	extents_delta = ctl->discard_extents[0] - ctl->discard_extents[1];
> +	if (extents_delta) {
> +		atomic_add(extents_delta, &discard_ctl->discard_extents);
> +		ctl->discard_extents[1] = ctl->discard_extents[0];
> +	}

What the actual fuck?  I assume you did this to avoid checking DISCARD_ASYNC on
every update, but man this complexity is not worth it.  We might as well update
the counter every time to avoid doing stuff like this.

If there's a better reason for doing it this way then I'm all ears, but even so
this is not the way to do it.  Just do

atomic_add(ctl->discard_extenst, &discard_ctl->discard_extents);
ctl->discard_extents = 0;

and avoid the two step thing.  And a comment, because it was like 5 minutes
between me seeing this and getting to your reasoning, and in between there was a
lot of swearing.  Thanks,

Josef
