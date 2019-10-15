Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE22D8098
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 21:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfJOT5y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 15:57:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44821 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfJOT5x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 15:57:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so32393629qth.11
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 12:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MccmxnMXhkpIhZsTv0dxaGzy5/3ToSgGQFdsq6pGwSM=;
        b=ovU6HA+rKUyWy+POFlCxNc2nxmWaHHY0VWPExSIvqSt1lS8/MIPmrPCtZdaohpOmVt
         x41xVt2kBZCG/LV1f+5ApRbqOlCAjlvSQN/qGSerlrVNyhYnkjDIixnHQPCzq6UpUW7Q
         WXX2sIEMqx/PC8MgcUwwB3/W2RIDmUlvrfM385cKaYkzuAYk7J/GtEBwiVNgiialho5j
         liw5cCORe0yHAA/RyyHEqu/dXwFM/W9bsOtl9Y780f6yfp78o92grisIp/PnI96Y8ft+
         XmPc/KOZK3d1u8D33kXiAKMM2GnIlZ8RGrrDbqEc6x90eb+6hiRIlwNV++h9RAePmVk9
         O/2g==
X-Gm-Message-State: APjAAAXGIJIGnUuSw3VbnG1to/pjbWJu2M9VPPADZ7CI8EI3gR39716u
        rbWNfbODd1TLCDQoqFPKwks=
X-Google-Smtp-Source: APXvYqxwTPjaWzQ0hlcC76KgQH+VdU0wl/dqoZbOvWDIlnC6fGamZ5QoGeuidHCCxKNuXW6IqJPtJg==
X-Received: by 2002:ac8:6782:: with SMTP id b2mr40683368qtp.143.1571169472606;
        Tue, 15 Oct 2019 12:57:52 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::c97c])
        by smtp.gmail.com with ESMTPSA id d133sm12073213qkg.31.2019.10.15.12.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 12:57:51 -0700 (PDT)
Date:   Tue, 15 Oct 2019 15:57:49 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/19] btrfs: add the beginning of async discard, discard
 workqueue
Message-ID: <20191015195749.GC82683@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <b2f59782f8a7b02fee6c3a2994154b01134b09dc.1570479299.git.dennis@kernel.org>
 <20191015124919.GW2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015124919.GW2751@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 15, 2019 at 02:49:19PM +0200, David Sterba wrote:
> On Mon, Oct 07, 2019 at 04:17:36PM -0400, Dennis Zhou wrote:
> > --- a/fs/btrfs/block-group.h
> > +++ b/fs/btrfs/block-group.h
> > @@ -115,7 +115,11 @@ struct btrfs_block_group_cache {
> >  	/* For read-only block groups */
> >  	struct list_head ro_list;
> >  
> > +	/* For discard operations */
> >  	atomic_t trimming;
> > +	struct list_head discard_list;
> > +	int discard_index;
> > +	u64 discard_delay;
> >  
> >  	/* For dirty block groups */
> >  	struct list_head dirty_list;
> > @@ -157,6 +161,12 @@ struct btrfs_block_group_cache {
> >  	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
> >  };
> >  
> > +static inline
> > +u64 btrfs_block_group_end(struct btrfs_block_group_cache *cache)
> > +{
> > +	return (cache->key.objectid + cache->key.offset);
> > +}
> > +
> >  #ifdef CONFIG_BTRFS_DEBUG
> >  static inline int btrfs_should_fragment_free_space(
> >  		struct btrfs_block_group_cache *block_group)
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 1877586576aa..419445868909 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -438,6 +438,17 @@ struct btrfs_full_stripe_locks_tree {
> >  	struct mutex lock;
> >  };
> >  
> > +/* discard control */
> 
> This is going to be 'fix everywhere too' comment, please start comments
> with capital letter.

I've done a pass at uppercasing everything. I think I've caught most of
them.

> 
> > +#define BTRFS_NR_DISCARD_LISTS		1
> 
> Constants and defines should be documented
> 

Yeah sounds good. I've added comments. A few may not have comments until
later, but I think by the end of the series everything has the right
comments.

> > --- /dev/null
> > +++ b/fs/btrfs/discard.c
> > @@ -0,0 +1,200 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019 Facebook.  All rights reserved.
> > + */
> 
> With the SPDX in place and immutable git history, the copyright notices
> are not necessary and we don't add them to new files anymore.
> 

Ah okay. I wasn't exactly sure why those got added when they did.

> > +void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
> > +			       struct btrfs_block_group_cache *cache)
> > +{
> > +	u64 now = ktime_get_ns();
> 
> Variable used only once, can be removed and ktime_get_ns called
> directly.
> 

Done.

> > +	spin_lock(&discard_ctl->lock);
> > +
> > +	if (list_empty(&cache->discard_list))
> > +		cache->discard_delay = now + BTRFS_DISCARD_DELAY;
> 
> ->discard_delay does not seem to be a delay but an expiration time, so
> this is a bit confusing. BTRFS_DISCARD_DELAY is the delay time, that's
> clear.
> 

I added a comment explaining the premise. I just didn't want a block
group to start discarding immediately if we just created it, so give
some chance for the lba to be reused. So, discard_delay holds the
time to begin discarding. I'll try and figure out a better name.
Maybe discard_eligible_time (idk it seems long)?

> > +	list_move_tail(&cache->discard_list,
> > +		       btrfs_get_discard_list(discard_ctl, cache));
> > +
> > +	spin_unlock(&discard_ctl->lock);
> > +}
> 
> > --- /dev/null
> > +++ b/fs/btrfs/discard.h
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019 Facebook.  All rights reserved.
> > + */
> > +
> > +#ifndef BTRFS_DISCARD_H
> > +#define BTRFS_DISCARD_H
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/workqueue.h>
> > +
> > +#include "ctree.h"
> 
> Is it possible to avoid including ctree.h here? Like adding forward
> declarations and defining the helpers in .c (that will have to include
> ctree.h anyway). The includes have become very cluttered and untangling
> the dependencies is ongoing work so it would be good to avoid adding
> extra work.
> 

I moved the two inline's to the .c file and then just struct
declarations was enough.

> > +void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
> > +			       struct btrfs_block_group_cache *cache);
> > +
> > +void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
> > +			       struct btrfs_block_group_cache *cache);
> > +void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
> > +				 bool override);
> > +void btrfs_discard_resume(struct btrfs_fs_info *fs_info);
> > +void btrfs_discard_stop(struct btrfs_fs_info *fs_info);
> > +void btrfs_discard_init(struct btrfs_fs_info *fs_info);
> > +void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info);
> > +
> > +static inline
> > +bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
> > +{
> > +	struct btrfs_fs_info *fs_info = container_of(discard_ctl,
> > +						     struct btrfs_fs_info,
> > +						     discard_ctl);
> > +
> > +	return (!(fs_info->sb->s_flags & SB_RDONLY) &&
> > +		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
> > +}
> > +
> > +static inline
> > +void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
> > +			      struct btrfs_block_group_cache *cache)
> > +{
> > +	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
> > +		return;
> > +
> > +	btrfs_add_to_discard_list(discard_ctl, cache);
> > +	if (!delayed_work_pending(&discard_ctl->work))
> > +		btrfs_discard_schedule_work(discard_ctl, false);
> > +}
> 
> These two would need full fs_info definition but they don't seem to be
> called in performance sensitive code so a full function call is ok here.
> 

Done.

> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -313,6 +316,7 @@ enum {
> >  	Opt_datasum, Opt_nodatasum,
> >  	Opt_defrag, Opt_nodefrag,
> >  	Opt_discard, Opt_nodiscard,
> > +	Opt_discard_version,
> 
> This is probably copied from space_cache options, 'version' does not
> fit discard, it could be 'mode'
> 

So the initial version I actually named them discard v1 and v2, Omar
mentioned I should probably give them separate flags and why it's now
sync and async. I renamed it to mode.

> >  	Opt_nologreplay,
> >  	Opt_norecovery,
> >  	Opt_ratio,
> >  		case Opt_space_cache_version:

Thanks, 
Dennis
