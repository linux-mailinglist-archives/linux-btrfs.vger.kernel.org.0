Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7EEBD76D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 14:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfJOMtt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 08:49:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:53486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728607AbfJOMtK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 08:49:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0D94B4B7;
        Tue, 15 Oct 2019 12:49:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F2081DA7E3; Tue, 15 Oct 2019 14:49:19 +0200 (CEST)
Date:   Tue, 15 Oct 2019 14:49:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/19] btrfs: add the beginning of async discard, discard
 workqueue
Message-ID: <20191015124919.GW2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1570479299.git.dennis@kernel.org>
 <b2f59782f8a7b02fee6c3a2994154b01134b09dc.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2f59782f8a7b02fee6c3a2994154b01134b09dc.1570479299.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:36PM -0400, Dennis Zhou wrote:
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -115,7 +115,11 @@ struct btrfs_block_group_cache {
>  	/* For read-only block groups */
>  	struct list_head ro_list;
>  
> +	/* For discard operations */
>  	atomic_t trimming;
> +	struct list_head discard_list;
> +	int discard_index;
> +	u64 discard_delay;
>  
>  	/* For dirty block groups */
>  	struct list_head dirty_list;
> @@ -157,6 +161,12 @@ struct btrfs_block_group_cache {
>  	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
>  };
>  
> +static inline
> +u64 btrfs_block_group_end(struct btrfs_block_group_cache *cache)
> +{
> +	return (cache->key.objectid + cache->key.offset);
> +}
> +
>  #ifdef CONFIG_BTRFS_DEBUG
>  static inline int btrfs_should_fragment_free_space(
>  		struct btrfs_block_group_cache *block_group)
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 1877586576aa..419445868909 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -438,6 +438,17 @@ struct btrfs_full_stripe_locks_tree {
>  	struct mutex lock;
>  };
>  
> +/* discard control */

This is going to be 'fix everywhere too' comment, please start comments
with capital letter.

> +#define BTRFS_NR_DISCARD_LISTS		1

Constants and defines should be documented

> --- /dev/null
> +++ b/fs/btrfs/discard.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Facebook.  All rights reserved.
> + */

With the SPDX in place and immutable git history, the copyright notices
are not necessary and we don't add them to new files anymore.

> +void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
> +			       struct btrfs_block_group_cache *cache)
> +{
> +	u64 now = ktime_get_ns();

Variable used only once, can be removed and ktime_get_ns called
directly.

> +	spin_lock(&discard_ctl->lock);
> +
> +	if (list_empty(&cache->discard_list))
> +		cache->discard_delay = now + BTRFS_DISCARD_DELAY;

->discard_delay does not seem to be a delay but an expiration time, so
this is a bit confusing. BTRFS_DISCARD_DELAY is the delay time, that's
clear.

> +	list_move_tail(&cache->discard_list,
> +		       btrfs_get_discard_list(discard_ctl, cache));
> +
> +	spin_unlock(&discard_ctl->lock);
> +}

> --- /dev/null
> +++ b/fs/btrfs/discard.h
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Facebook.  All rights reserved.
> + */
> +
> +#ifndef BTRFS_DISCARD_H
> +#define BTRFS_DISCARD_H
> +
> +#include <linux/kernel.h>
> +#include <linux/workqueue.h>
> +
> +#include "ctree.h"

Is it possible to avoid including ctree.h here? Like adding forward
declarations and defining the helpers in .c (that will have to include
ctree.h anyway). The includes have become very cluttered and untangling
the dependencies is ongoing work so it would be good to avoid adding
extra work.

> +void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
> +			       struct btrfs_block_group_cache *cache);
> +
> +void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
> +			       struct btrfs_block_group_cache *cache);
> +void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
> +				 bool override);
> +void btrfs_discard_resume(struct btrfs_fs_info *fs_info);
> +void btrfs_discard_stop(struct btrfs_fs_info *fs_info);
> +void btrfs_discard_init(struct btrfs_fs_info *fs_info);
> +void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info);
> +
> +static inline
> +bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
> +{
> +	struct btrfs_fs_info *fs_info = container_of(discard_ctl,
> +						     struct btrfs_fs_info,
> +						     discard_ctl);
> +
> +	return (!(fs_info->sb->s_flags & SB_RDONLY) &&
> +		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
> +}
> +
> +static inline
> +void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
> +			      struct btrfs_block_group_cache *cache)
> +{
> +	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
> +		return;
> +
> +	btrfs_add_to_discard_list(discard_ctl, cache);
> +	if (!delayed_work_pending(&discard_ctl->work))
> +		btrfs_discard_schedule_work(discard_ctl, false);
> +}

These two would need full fs_info definition but they don't seem to be
called in performance sensitive code so a full function call is ok here.

> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -313,6 +316,7 @@ enum {
>  	Opt_datasum, Opt_nodatasum,
>  	Opt_defrag, Opt_nodefrag,
>  	Opt_discard, Opt_nodiscard,
> +	Opt_discard_version,

This is probably copied from space_cache options, 'version' does not
fit discard, it could be 'mode'

>  	Opt_nologreplay,
>  	Opt_norecovery,
>  	Opt_ratio,
>  		case Opt_space_cache_version:
