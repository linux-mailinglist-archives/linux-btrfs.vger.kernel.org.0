Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F5C12E8DB
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgABQqC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:46:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43370 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgABQqC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 11:46:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id t129so31763054qke.10
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 08:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iiqyRUxApX19Ui9kuOhGNxpjioocaGgUbk2e+WSV8hE=;
        b=PPfQ8dkLcgB5s1uIw5s482KYoJ0kfle4CwFAbokQN/faGx281rxxNTK/RwRo/tSqF/
         tN2RciXIfqDICxSKGrt0CAPK46OUW9xqnCjn3k+ECKgdkCqYUK/zoBofAd5TnQDYPpu9
         fcqQJ0exzxFEQn9kfi+oIACMbKwmH1UIoH4X/ZRcP1on9kXCmqSbILoljkQWb5XrNuCA
         zhFt8QEFQmaoAiZp5mFUcjbxJbwVYs/Hd8VexYftvkQ/05iv4/I6/89wxj9IeNaBiz+/
         stSy1dwLXyCT1qRMOaybvUX1bwgPtWuxsCuRPSEUrX+szCzksEyoxg/4OJOoAofHe3hL
         pUGQ==
X-Gm-Message-State: APjAAAXSJl7ILO8lfVAA8AW50bjlzm1pIpxOSnSsMOAa7QCN1N6BckZW
        7gEeKA72MPBiZz8rR5IapCk=
X-Google-Smtp-Source: APXvYqz4FxyKw4nQF5lp/s8Zw4Z5hkl/1Q84Pv2c/GcNCa27nXYbYHv1lrUG4+tnxOkmbjYTlcVTpQ==
X-Received: by 2002:a05:620a:1522:: with SMTP id n2mr66663430qkk.108.1577983560885;
        Thu, 02 Jan 2020 08:46:00 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::1:29bb])
        by smtp.gmail.com with ESMTPSA id s91sm16953837qtd.50.2020.01.02.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 08:46:00 -0800 (PST)
Date:   Thu, 2 Jan 2020 11:45:58 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 13/22] btrfs: calculate discard delay based on number of
 extents
Message-ID: <20200102164558.GA86832@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1576195673.git.dennis@kernel.org>
 <b87145b48a539223abc4611e3c279fb0bc750572.1576195673.git.dennis@kernel.org>
 <20191230165043.GV3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230165043.GV3929@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 05:50:43PM +0100, David Sterba wrote:
> On Fri, Dec 13, 2019 at 04:22:22PM -0800, Dennis Zhou wrote:
> > Use the number of discardable extents to help guide our discard delay
> > interval. This value is reevaluated every transaction commit.
> 
> This is too short compared to the added code, please enhance it eg. by
> briefly describing what values are tracked and how are they related
> together.
> 

Done.

> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/ctree.h       |  2 ++
> >  fs/btrfs/discard.c     | 53 ++++++++++++++++++++++++++++++++++++++----
> >  fs/btrfs/discard.h     |  1 +
> >  fs/btrfs/extent-tree.c |  4 +++-
> >  fs/btrfs/sysfs.c       | 31 ++++++++++++++++++++++++
> >  5 files changed, 86 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 18df0e40a282..98979566e281 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -469,6 +469,8 @@ struct btrfs_discard_ctl {
> >  	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
> >  	atomic_t discardable_extents;
> >  	atomic64_t discardable_bytes;
> 
> There are some type mismatches for the two:
> 
> > +	u32 delay;
> > +	u32 iops_limit;
> 
> unsigned for iops

I switched iops_limit to unsigned and delay to unsigned long.

> 
> >  };
> >  
> >  /* delayed seq elem */
> > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > index e8c2623617fd..160713e04d0c 100644
> > --- a/fs/btrfs/discard.c
> > +++ b/fs/btrfs/discard.c
> > @@ -15,6 +15,11 @@
> >  #define BTRFS_DISCARD_DELAY		(120ULL * NSEC_PER_SEC)
> >  #define BTRFS_DISCARD_UNUSED_DELAY	(10ULL * NSEC_PER_SEC)
> >  
> > +/* Target completion latency of discarding all discardable extents. */
> > +#define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
> > +#define BTRFS_DISCARD_MAX_DELAY		(10000UL)
> > +#define BTRFS_DISCARD_MAX_IOPS		(10UL)
> 
> All unsigned longs
> 

I've switched BTRFS_DISCARD_MAX_IOPS to 10U and lowered the max delay to
be 1s from our previous conversation.

> > +
> >  static struct list_head *get_discard_list(struct btrfs_discard_ctl *discard_ctl,
> >  					  struct btrfs_block_group *block_group)
> >  {
> > @@ -239,11 +244,18 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
> >  
> >  	block_group = find_next_block_group(discard_ctl, now);
> >  	if (block_group) {
> > -		u64 delay = 0;
> > +		u32 delay = discard_ctl->delay;
> > +
> > +		/*
> > +		 * This timeout is to hopefully prevent immediate discarding
> > +		 * in a recently allocated block group.
> > +		 */
> > +		if (now < block_group->discard_eligible_time) {
> > +			u64 bg_timeout = (block_group->discard_eligible_time -
> > +					  now);
> >  
> > -		if (now < block_group->discard_eligible_time)
> > -			delay = nsecs_to_jiffies(
> > -				block_group->discard_eligible_time - now);
> > +			delay = max_t(u64, delay, nsecs_to_jiffies(bg_timeout));
> 
> delay is u32, nsecs_to_jiffies returns unsigned long, so delay should be
> also unsigned long everywhere.
> 
> > +		}
> >  
> >  		mod_delayed_work(discard_ctl->discard_workers,
> >  				 &discard_ctl->work,
> > @@ -348,6 +360,37 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
> >  		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
> >  }
> >  
> > +/**
> > + * btrfs_discard_calc_delay - recalculate the base delay
> > + * @discard_ctl: discard control
> > + *
> > + * Recalculate the base delay which is based off the total number of
> > + * discardable_extents.  Clamp this with the iops_limit and
> > + * BTRFS_DISCARD_MAX_DELAY.
> > + */
> > +void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
> > +{
> > +	s32 discardable_extents =
> > +		atomic_read(&discard_ctl->discardable_extents);
> > +	s32 iops_limit;
> 
> signed for iops
> 
> > +	unsigned long delay;
> > +
> > +	if (!discardable_extents)
> > +		return;
> > +
> > +	spin_lock(&discard_ctl->lock);
> > +
> > +	iops_limit = READ_ONCE(discard_ctl->iops_limit);
> 
> unsigned -> signed
> 
> > +	if (iops_limit)
> > +		iops_limit = MSEC_PER_SEC / iops_limit;
> > +
> > +	delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
> > +	delay = clamp_t(s32, delay, iops_limit, BTRFS_DISCARD_MAX_DELAY);
> > +	discard_ctl->delay = msecs_to_jiffies(delay);
> 
> unsigned long -> u32
> 
> > +
> > +	spin_unlock(&discard_ctl->lock);
> > +}
> > +
> >  /**
> >   * btrfs_discard_update_discardable - propagate discard counters
> >   * @block_group: block_group of interest
> > @@ -476,6 +519,8 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
> >  
> >  	atomic_set(&discard_ctl->discardable_extents, 0);
> >  	atomic64_set(&discard_ctl->discardable_bytes, 0);
> > +	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY;
> > +	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
> >  }
> >  
> >  void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
> > diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> > index 7e3680dd82ce..3ed6855e24da 100644
> > --- a/fs/btrfs/discard.h
> > +++ b/fs/btrfs/discard.h
> > @@ -17,6 +17,7 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
> >  bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
> >  
> >  /* Update operations. */
> > +void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl);
> >  void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
> >  				      struct btrfs_free_space_ctl *ctl);
> >  
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 2c12366cfde5..0163fdd59f8f 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -2935,8 +2935,10 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
> >  		cond_resched();
> >  	}
> >  
> > -	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
> > +	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
> > +		btrfs_discard_calc_delay(&fs_info->discard_ctl);
> >  		btrfs_discard_schedule_work(&fs_info->discard_ctl, true);
> > +	}
> >  
> >  	/*
> >  	 * Transaction is finished.  We don't need the lock anymore.  We
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index e799d4488d72..79139b4b4f0a 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -344,6 +344,36 @@ static const struct attribute_group btrfs_static_feature_attr_group = {
> >   */
> >  #define discard_to_fs_info(_kobj)	to_fs_info((_kobj)->parent->parent)
> >  
> > +static ssize_t btrfs_discard_iops_limit_show(struct kobject *kobj,
> > +					     struct kobj_attribute *a,
> > +					     char *buf)
> > +{
> > +	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
> > +
> > +	return snprintf(buf, PAGE_SIZE, "%u\n",
> > +			READ_ONCE(fs_info->discard_ctl.iops_limit));
> > +}
> > +
> > +static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
> > +					      struct kobj_attribute *a,
> > +					      const char *buf, size_t len)
> > +{
> > +	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
> > +	struct btrfs_discard_ctl *discard_ctl = &fs_info->discard_ctl;
> > +	u32 iops_limit;
> > +	int ret;
> > +
> > +	ret = kstrtou32(buf, 10, &iops_limit);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	WRITE_ONCE(discard_ctl->iops_limit, iops_limit);
> > +
> > +	return len;
> > +}
> > +BTRFS_ATTR_RW(discard, iops_limit, btrfs_discard_iops_limit_show,
> > +	      btrfs_discard_iops_limit_store);
> > +
> >  static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
> >  					      struct kobj_attribute *a,
> >  					      char *buf)
> > @@ -367,6 +397,7 @@ static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
> >  BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
> >  
> >  static const struct attribute *discard_debug_attrs[] = {
> > +	BTRFS_ATTR_PTR(discard, iops_limit),
> >  	BTRFS_ATTR_PTR(discard, discardable_extents),
> >  	BTRFS_ATTR_PTR(discard, discardable_bytes),
> >  	NULL,
> > -- 
> > 2.17.1
