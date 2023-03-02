Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4A06A85D7
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 17:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCBQHc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 11:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCBQHc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 11:07:32 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE37E4A1D3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 08:07:30 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w23so18534789qtn.6
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Mar 2023 08:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1677773250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jXVq9fWJul7OpcdOg/UDVhGE+H37vZH9sknF5e7dHY=;
        b=UyjXg1L1Hr+dU14j3rt2oOnFdGGlfLxTLA9vLlb1W+D6z4C9b5wFiXoNg9UImUmBi/
         YnPqEagrS3xFyrzs63Iip+zGcRqi6+mowPEo6Zhd2ElTPrghBIClrT3wMQLCpBdJx4Dv
         siNy2rpkOpEXJDXKn3QbyBidbjtsewc2klDzxWto0j4KL7+0NMHWleRs9YNmMi+dyqMJ
         rW99B8HYTgZiiZIzSfcoZQoakeyx5Px7seSMaAKKvJcusjCXp7pca8l/GP4GbgKRCaKV
         BI0hsSgzeZpx02bRF71PSgtZhD5UEGeEtegl0bspU7MyrdtArtlm3ep2rtC4+CED+tUC
         WiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677773250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jXVq9fWJul7OpcdOg/UDVhGE+H37vZH9sknF5e7dHY=;
        b=miauc7BnDYQwqE1QwpZbohEswJgiLeUUPmFJV627HEnx2Bqb1VbCD8aNfjBYWQOzDO
         OPCT5G20jcE2uByq0RnuMQ/wSuWQccujd7t8aDMklsiCm07Gn53yv3Ej3T3RxD0Cpjb1
         5YqexnWE9vicT+eWEMNbUXtLE7qwz/0pMtaTjrIZppSmrDRhp/ruOq/JxULnyOa12SxH
         UD1R/nLQAb9HFkiUaCwwfZik0A5RJgvQqsbZvuqd3vZFAmYId3GHAronUiMkHx3TAnEx
         ckHfWiFDiBPra+56wFcSdomWiyKWYW21CvURYgWrLjz1HjMRuyY+WclvETAW9KIpjviA
         LBlg==
X-Gm-Message-State: AO0yUKXHG5Z2GqS6pijZ5FiViHqi1P2/rtW///mg/badvS0RulczXx3R
        y5/bpQpR7N1BiZnTidlLy5HA4Q==
X-Google-Smtp-Source: AK7set8ZwFQy0hXZR+qzLBWQZj1PRvjwJqgrYLS8dra2GiH4LR1nEhnWsh6Vb1bxpXceEexat1la9Q==
X-Received: by 2002:a05:622a:1a8c:b0:3b9:bc8c:c1fb with SMTP id s12-20020a05622a1a8c00b003b9bc8cc1fbmr4303966qtc.6.1677773249769;
        Thu, 02 Mar 2023 08:07:29 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bj31-20020a05620a191f00b007423dad060bsm11354273qkb.87.2023.03.02.08.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:07:29 -0800 (PST)
Date:   Thu, 2 Mar 2023 11:07:24 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 3/3] btrfs: handle active zone accounting properly
Message-ID: <ZADJvIYBD3K9Efkl@localhost.localdomain>
References: <cover.1677705092.git.josef@toxicpanda.com>
 <ed93f2d59affd91bf2d0582b70c16d93341600e4.1677705092.git.josef@toxicpanda.com>
 <20230302065600.iu4idhfddygxczkk@naota-xeon>
 <20230302144512.cc7ofuvud5dodvxi@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302144512.cc7ofuvud5dodvxi@naota-xeon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 02:45:13PM +0000, Naohiro Aota wrote:
> On Thu, Mar 02, 2023 at 04:01:07PM +0900, Naohiro Aota wrote:
> > On Wed, Mar 01, 2023 at 04:14:44PM -0500, Josef Bacik wrote:
> > > Running xfstests on my ZNS drives uncovered a problem where I was
> > > allocating the entire device with metadata block groups.  The root cause
> > > of this was we would get ENOSPC on mount, and while trying to satisfy
> > > tickets we'd allocate more block groups.
> > > 
> > > The reason we were getting ENOSPC was because ->bytes_zone_unusable was
> > > set to 40gib, but ->active_total_bytes was set to 8gib, which was the
> > > maximum number of active block groups we're allowed to have at one time.
> > > This was because we always update ->bytes_zone_unusable with the
> > > unusable amount from every block group, but we only update
> > > ->active_total_bytes with the active block groups.
> > >
> > > This is actually much worse however, because we could potentially have
> > > other counters potentially well above the ->active_total_bytes, which
> > > would lead to this early enospc situation.
> > > 
> > > Fix this by mirroring the counters for active block groups into their
> > > own counters.  This allows us to keep the full space_info counters
> > > consistent, which is needed for things like sysfs and the space info
> > > ioctl, and then track the actual usage for ENOSPC reasons for only the
> > > active block groups.
> > 
> > I think the mirroring the counters approach duplicates the code and
> > variables and makes them complex. Instead, we can fix the
> > "active_total_bytes" accounting maybe like this:
> > 
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index d4dd73c9a701..bf4d96d74efe 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -319,7 +319,8 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
> >  	ASSERT(found);
> >  	spin_lock(&found->lock);
> >  	found->total_bytes += block_group->length;
> > -	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags))
> > +	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags) ||
> > +	    btrfs_zoned_bg_is_full(block_group))
> >  		found->active_total_bytes += block_group->length;
> >  	found->disk_total += block_group->length * factor;
> >  	found->bytes_used += block_group->used;
> > 
> > Or, we can remove "active_total_bytes" and introduce something like
> > "preactivated_bytes" to count the bytes of BGs never get activated (BGs #1 below).
> 
> I got a new idea. How about counting all the region in a new block group as
> zone_unusable? Then, region [0 .. zone_capacity] will be freed for use once
> it gets activated. With this, we can drop "active_total_bytes" so the code
> will become similar between the regular and the zoned mode.
> 
> We also need to care not to reclaim the fresh BGs but it's trivial
> (alloc_offset == 0).
> 

I like this idea better than mine for sure.  Will you write it up and send it
and I'll run it through my test-rig?  Thanks,

Josef
