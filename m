Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21040D6A57
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 21:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfJNTuN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 15:50:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39749 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfJNTuN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 15:50:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so27071776qtb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2019 12:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5/Cax7zfwilpWLORdUxou0o0XXq7wXovLAY6lLW1ass=;
        b=fmBIiLfD/MGstO0FUjKWj2PTqNJzj0hk7Fj0c+svWKXffVD/c0g7y1Zg5THTSEYH/H
         1bVoL2TD2joQS7M/Y0w3Atj4zm4SKjRUliViPxZxfwLG14lfsFl7LKvd7iLr+PaOhYKH
         BOO7otaFeEPjmu4fD6E/TkQ0buC4wBZLvZpBtwISpLxbKvDmGTuQLo/MfQmOKIh1wr8e
         8Mv+/6S9HfrD2Krc28CqjVuoFAdHekK9jQ5vleDwz/WKbx3kNGYSca9e/QFLLbpsmm9/
         +vxrASrllJGaVvuiFKDHx//R3Dt2LrKMOtz2CzDCoq7vAa9tBCVbBIbmPEQU1hjdUJNu
         xIiQ==
X-Gm-Message-State: APjAAAXQrjM6heRLHcFABZlIMXiSyRALm7jotdeWO9yJ4pCNtRBN9ma3
        bjchQBxyRpboMItQg0bHD20=
X-Google-Smtp-Source: APXvYqz85Y+9nzfr+9xlLl26PHfiR4iogIuy3PowisoaggjscZ+xdnoW3EUgAWUcN+V1G9SEso891g==
X-Received: by 2002:ac8:29c8:: with SMTP id 8mr33011558qtt.32.1571082610466;
        Mon, 14 Oct 2019 12:50:10 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::2:b1f8])
        by smtp.gmail.com with ESMTPSA id e4sm8416808qkl.135.2019.10.14.12.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 12:50:09 -0700 (PDT)
Date:   Mon, 14 Oct 2019 15:50:07 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/19] btrfs: track discardable extents for asnyc discard
Message-ID: <20191014195007.GB40077@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <31c4f29228c76df72cc92112e397db648e9b9ab9.1570479299.git.dennis@kernel.org>
 <20191010153653.7b26qpleh64dext3@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010153653.7b26qpleh64dext3@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 11:36:54AM -0400, Josef Bacik wrote:
> On Mon, Oct 07, 2019 at 04:17:39PM -0400, Dennis Zhou wrote:
> > The number of discardable extents will serve as the rate limiting metric
> > for how often we should discard. This keeps track of discardable extents
> > in the free space caches by maintaining deltas and propagating them to
> > the global count.
> > 
> > This also setups up a discard directory in btrfs sysfs and exports the
> > total discard_extents count.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  fs/btrfs/ctree.h            |  2 +
> >  fs/btrfs/discard.c          |  2 +
> >  fs/btrfs/discard.h          | 19 ++++++++
> >  fs/btrfs/free-space-cache.c | 93 ++++++++++++++++++++++++++++++++++---
> >  fs/btrfs/free-space-cache.h |  2 +
> >  fs/btrfs/sysfs.c            | 33 +++++++++++++
> >  6 files changed, 144 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index c328d2e85e4d..43e515939b9c 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -447,6 +447,7 @@ struct btrfs_discard_ctl {
> >  	spinlock_t lock;
> >  	struct btrfs_block_group_cache *cache;
> >  	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
> > +	atomic_t discard_extents;
> >  };
> >  
> >  /* delayed seq elem */
> > @@ -831,6 +832,7 @@ struct btrfs_fs_info {
> >  	struct btrfs_workqueue *scrub_wr_completion_workers;
> >  	struct btrfs_workqueue *scrub_parity_workers;
> >  
> > +	struct kobject *discard_kobj;
> >  	struct btrfs_discard_ctl discard_ctl;
> >  
> >  #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
> > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > index 26a1e44b4bfa..0544eb6717d4 100644
> > --- a/fs/btrfs/discard.c
> > +++ b/fs/btrfs/discard.c
> > @@ -298,6 +298,8 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
> >  
> >  	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++)
> >  		 INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
> > +
> > +	atomic_set(&discard_ctl->discard_extents, 0);
> >  }
> >  
> >  void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
> > diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> > index 22cfa7e401bb..85939d62521e 100644
> > --- a/fs/btrfs/discard.h
> > +++ b/fs/btrfs/discard.h
> > @@ -71,4 +71,23 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
> >  		btrfs_discard_schedule_work(discard_ctl, false);
> >  }
> >  
> > +static inline
> > +void btrfs_discard_update_discardable(struct btrfs_block_group_cache *cache,
> > +				      struct btrfs_free_space_ctl *ctl)
> > +{
> > +	struct btrfs_discard_ctl *discard_ctl;
> > +	s32 extents_delta;
> > +
> > +	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
> > +		return;
> > +
> > +	discard_ctl = &cache->fs_info->discard_ctl;
> > +
> > +	extents_delta = ctl->discard_extents[0] - ctl->discard_extents[1];
> > +	if (extents_delta) {
> > +		atomic_add(extents_delta, &discard_ctl->discard_extents);
> > +		ctl->discard_extents[1] = ctl->discard_extents[0];
> > +	}
> 
> What the actual fuck?  I assume you did this to avoid checking DISCARD_ASYNC on
> every update, but man this complexity is not worth it.  We might as well update
> the counter every time to avoid doing stuff like this.
> 
> If there's a better reason for doing it this way then I'm all ears, but even so
> this is not the way to do it.  Just do
> 
> atomic_add(ctl->discard_extenst, &discard_ctl->discard_extents);
> ctl->discard_extents = 0;
> 
> and avoid the two step thing.  And a comment, because it was like 5 minutes
> between me seeing this and getting to your reasoning, and in between there was a
> lot of swearing.  Thanks,

The nice thing about doing it this way is the update is self-contained
and then each block_group now maintains individual counts which I can
use drgn to get at. A global count was very easy to get wrong as the
total number can look pretty reasonable, but ultimately be very wrong.
I'd much rather keep it this way than switch to purely delta counters as
to be able to get this information from drgn should we want to better
understand any issues with this code.

I added comments and created BTRFS_STAT_CURR and BTRFS_STAT_PREV macros
for this use.

Thanks,
Dennis
