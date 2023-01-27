Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D1867F08F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 22:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjA0Vn1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 16:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjA0Vn0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 16:43:26 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2836559B7F
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 13:43:25 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0312F5C0342;
        Fri, 27 Jan 2023 16:43:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 27 Jan 2023 16:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674855801; x=1674942201; bh=wZj7VTm32e
        PCsVxHCz6mVV7ht2wxtAE6KdTSYtB08jQ=; b=HvcvoUjV8mIDZ1IMiPl97FjFw2
        HIVzviaDhpylvAsQ9OPcPI/U/e1I+nfWLWzklpjF4l9tZYwWj11wZtIO6+uUftOe
        KtSMGza7tulCRPqs5h+p1LhIqCvxxZiw0n696EsOElPnL7k+oBGBj76Mu0ZscWTy
        r6HjLgFg1/g2vVWeUUcVD2q+NzbqNdipdB5M/M3aXYHKeqwBlmQyqI1i324s9W7b
        tytQw0rc+RRaHEJHPgz9Ai8gaCaJRo1jCrDHS+MtPc0kCmV/qlmdNz0+YSsGfAlD
        WfPkUSBgUlQVk+16G6YMKEQPR6UAqbn/Nr0It3S0lDI5RxbKPECRC98CzrBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674855801; x=1674942201; bh=wZj7VTm32ePCsVxHCz6mVV7ht2wx
        tAE6KdTSYtB08jQ=; b=Y8HkCWhT5vjdi/H5MkvCu3IyIWnyxTGYeMX+g541Voit
        mA2Yl+CReXNROB+oaa2TOo5TjTJOWRBNECldDqTwJxuBjNWa/OUxhvevmWHTIlL3
        HfINNsermM0rzbV+hF1x+fEkksJJwjiqqPW4CQV/TL/Weeb7h7xXrw/ws9eiPRTt
        2aiGvHmCdFR7IEe2aVxUXX7CuvlVmBc51FTHWlKUJJ4wlrKyIHIUhtRJGWQQwDr5
        LKpCwCHn8wEZRRRCyXM9ryEjPGWhzcbJhKzgb0eBCfEaHE9OY9EdgcAp891XQh+G
        /zUku+lefxjC6UZBdmRr8FrFlpyn6t3nJuGgNRX7zw==
X-ME-Sender: <xms:eUXUY1rXw25YoMwhosFa5GshnQxPQPiQ69FsvzbdjWwNDIUVmyAgDQ>
    <xme:eUXUY3qpy_fn3wgcibHtRHF7WHdGQg2i_HxpnFh9ZeDPenBt_-VKEGFwce8iteVWx
    K2N2OMm4owP8djZGPc>
X-ME-Received: <xmr:eUXUYyMd03tpsOe6g0zsUT2Ml0ABnJLk6hyLZ-7_gMBPf5caZbL9291q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:eUXUYw5GOOBjIHYbMjq3NbCtKcmdLyBnmYfsZt4Ic_tQZEEqfRBd1g>
    <xmx:eUXUY04sEvy59jRM6ZyrM8fH2nVNtgBB6oMIoHJ4vgQasCkiSQhmYw>
    <xmx:eUXUY4iNWaTStpa4mcEtVAkAWqAbGnEFukNvcZJT7RSQu6m0OG852A>
    <xmx:eUXUYyTFIMijmiuUKsZzsLFBa1V_ND11vQn4j-7TuK9E4C1VBD_C-w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jan 2023 16:43:21 -0500 (EST)
Date:   Fri, 27 Jan 2023 13:43:19 -0800
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: add size class stats to sysfs
Message-ID: <Y9RFd5e/zusf5MCm@zen>
References: <cover.1674679476.git.boris@bur.io>
 <3e95d7d8a42fa8969f415fc03ad999de3d29a196.1674679476.git.boris@bur.io>
 <20230127132345.GA11562@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127132345.GA11562@twin.jikos.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 27, 2023 at 02:23:45PM +0100, David Sterba wrote:
> On Wed, Jan 25, 2023 at 12:50:33PM -0800, Boris Burkov wrote:
> > Make it possible to see the distribution of size classes for block
> > groups. Helpful for testing and debugging the allocator w.r.t. to size
> > classes.
> 
> Please note the sysfs file path.
> 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/sysfs.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> > 
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index 108aa3876186..e1ae4d2323d6 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/completion.h>
> >  #include <linux/bug.h>
> > +#include <linux/list.h>
> >  #include <crypto/hash.h>
> >  #include "messages.h"
> >  #include "ctree.h"
> > @@ -778,6 +779,42 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
> >  	return len;
> >  }
> >  
> > +static ssize_t btrfs_size_classes_show(struct kobject *kobj,
> > +				       struct kobj_attribute *a, char *buf)
> > +{
> > +	struct btrfs_space_info *sinfo = to_space_info(kobj);
> > +	struct btrfs_block_group *bg;
> > +	int none = 0;
> > +	int small = 0;
> > +	int medium = 0;
> > +	int large = 0;
> 
> For simple counters please use unsigned types.
> 
> > +	int i;
> > +
> > +	down_read(&sinfo->groups_sem);
> 
> This is a big lock and reading the sysfs repeatedly could block space
> reservations. I think RCU works for the block group list and the
> size_class is a simple read so the synchronization can be lightweight.

I believe space reservations only hold the read lock. The write lock is
needed only to remove or add block groups, so this shouldn't slow down
reservations. Also, FWIW, raid_bytes_show() uses the same
locking/iteration pattern.

I am not sure how to definitely safely concurrently iterate the block
groups without taking the lock. Are you suggesting I should just drop
the locking, and it won't crash but might be inaccurate? Or is there
some other RCU trick I am missing? I don't believe we use any RCU
specific methods when deleting from the list.

Sending a v3 with the rest of your review changes.

Thanks,
Boris

> 
> > +	for (i = 0; i < BTRFS_NR_RAID_TYPES; ++i) {
> 
> 	for (int = 0; ...)
> 
> > +		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
> > +			if (!btrfs_block_group_should_use_size_class(bg))
> > +				continue;
> > +			switch (bg->size_class) {
> > +			case BTRFS_BG_SZ_NONE:
> > +				none++;
> > +				break;
> > +			case BTRFS_BG_SZ_SMALL:
> > +				small++;
> > +				break;
> > +			case BTRFS_BG_SZ_MEDIUM:
> > +				medium++;
> > +				break;
> > +			case BTRFS_BG_SZ_LARGE:
> > +				large++;
> > +				break;
> > +			}
> > +		}
> > +	}
> > +	up_read(&sinfo->groups_sem);
> > +	return sysfs_emit(buf, "%d %d %d %d\n", none, small, medium, large);
> 
> This is lacks the types in the output, so this should be like
> 
> 	"none %u\n"
> 	"small %u\n"
> 	...
> 
> For stats we can group the values in one file.
> 
> > +}
> > +
> >  #ifdef CONFIG_BTRFS_DEBUG
> >  /*
> >   * Request chunk allocation with current chunk size.
> > @@ -835,6 +872,7 @@ SPACE_INFO_ATTR(bytes_zone_unusable);
> >  SPACE_INFO_ATTR(disk_used);
> >  SPACE_INFO_ATTR(disk_total);
> >  BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show, btrfs_chunk_size_store);
> > +BTRFS_ATTR(space_info, size_classes, btrfs_size_classes_show);
> >  
> >  static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
> >  						     struct kobj_attribute *a,
> > @@ -887,6 +925,7 @@ static struct attribute *space_info_attrs[] = {
> >  	BTRFS_ATTR_PTR(space_info, disk_total),
> >  	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
> >  	BTRFS_ATTR_PTR(space_info, chunk_size),
> > +	BTRFS_ATTR_PTR(space_info, size_classes),
> >  #ifdef CONFIG_BTRFS_DEBUG
> >  	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
> >  #endif
> > -- 
> > 2.38.1
