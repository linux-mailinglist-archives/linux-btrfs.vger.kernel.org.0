Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B218D6A72
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 21:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfJNT5E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 15:57:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36930 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfJNT5E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 15:57:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id u184so17029755qkd.4
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2019 12:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vXBY1o8FKWHnkGQagIo6LcpAk0eAmSng/TO7X/6RLBw=;
        b=chXdnf5IXCUJJXkwOuKcx5dXQCDG7JR3vAVZdjC9pfvIxekILnxTeZ5viSUcRBOLPE
         +Dvv0wbmTwdF43j/GAvluTDQ8DJw/MaAvBd5HxGJUu3Zp9k41vZ3bQm9IO8ss/JSaFoA
         odCpcJU+R9l+yNkOT9D/ipQ9sjbE5cIV24jojOLkDr5xQZDLCHvbEVDyRYoYCCtsKtp8
         Vqw3w14XZtsmk+Jl0UAVYtb+XgDpTTsX3acQg6oSVbOYLa3uNH/q63EW7euCb0TsbI7F
         yry8RaXRTcH8wS2MSgu1EpUyKOAhCIuHywKpAZushbVA7bU3WITyvdihhr3X9h32uSaO
         dbYA==
X-Gm-Message-State: APjAAAVfrIlsjxE7QZUfdS8wXSgc+LFaJZV7wLJb9A+BPFW0bluAdWT7
        Dla8+yggNsfhXybtbz/eT3U=
X-Google-Smtp-Source: APXvYqwvxQf0EZU2ONrUGwPnXoxcLmcmfV/A548gLe6sHpXfWwphcWWXakf3KfswARNdR5b1nLqZDg==
X-Received: by 2002:a37:9f83:: with SMTP id i125mr32358879qke.370.1571083023411;
        Mon, 14 Oct 2019 12:57:03 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::2:b1f8])
        by smtp.gmail.com with ESMTPSA id t32sm11994104qtb.64.2019.10.14.12.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 12:57:02 -0700 (PDT)
Date:   Mon, 14 Oct 2019 15:56:59 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/19] btrfs: add bps discard rate limit
Message-ID: <20191014195659.GC40077@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <17152a4b1f9a0719623af4ef98e5e8670dd70799.1570479299.git.dennis@kernel.org>
 <20191010154718.hdtiwd2eh4ai7zn4@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010154718.hdtiwd2eh4ai7zn4@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 11:47:19AM -0400, Josef Bacik wrote:
> On Mon, Oct 07, 2019 at 04:17:42PM -0400, Dennis Zhou wrote:
> > Provide an ability to rate limit based on mbps in addition to the iops
> > delay calculated from number of discardable extents.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  fs/btrfs/ctree.h   |  2 ++
> >  fs/btrfs/discard.c | 11 +++++++++++
> >  fs/btrfs/sysfs.c   | 30 ++++++++++++++++++++++++++++++
> >  3 files changed, 43 insertions(+)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index b0823961d049..e81f699347e0 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -447,10 +447,12 @@ struct btrfs_discard_ctl {
> >  	spinlock_t lock;
> >  	struct btrfs_block_group_cache *cache;
> >  	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
> > +	u64 prev_discard;
> >  	atomic_t discard_extents;
> >  	atomic64_t discardable_bytes;
> >  	atomic_t delay;
> >  	atomic_t iops_limit;
> > +	atomic64_t bps_limit;
> >  };
> >  
> >  /* delayed seq elem */
> > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > index c7afb5f8240d..072c73f48297 100644
> > --- a/fs/btrfs/discard.c
> > +++ b/fs/btrfs/discard.c
> > @@ -176,6 +176,13 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
> >  	cache = find_next_cache(discard_ctl, now);
> >  	if (cache) {
> >  		u64 delay = atomic_read(&discard_ctl->delay);
> > +		s64 bps_limit = atomic64_read(&discard_ctl->bps_limit);
> > +
> > +		if (bps_limit)
> > +			delay = max_t(u64, delay,
> > +				      msecs_to_jiffies(MSEC_PER_SEC *
> > +						discard_ctl->prev_discard /
> > +						bps_limit));
> 
> I forget, are we allowed to do 0 / some value?  I feel like I did this at some
> point with io.latency and it panic'ed and was very confused.  Maybe I'm just
> misremembering.
> 

I don't remember there being an issue there, but I'd rather not find
out. I added discard_ctl->prev_discard to the if statement.

> And a similar nit, maybe we just do
> 
> u64 delay = atomic_read(&discard_ctl->delay);
> u64 bps_delay = atomic64_read(&discard_ctl->bps_limit);
> if (bps_delay)
> 	bps_delay = msecs_to_jiffies(MSEC_PER_SEC * blah)
> 
> delay = max(delay, bps_delay);
> 

/*
 * A single delayed workqueue item is responsible for
 * discarding, so we can manage the bytes rate limit by keeping
 * track of the previous discard.
 */
if (bps_limit && discard_ctl->prev_discard) {
	u64 bps_delay = (MSEC_PER_SEC *
	 	 discard_ctl->prev_discard / bps_limit);

	delay = max_t(u64, delay, msecs_to_jiffies(bps_delay));
}

This is what I changed it to. I'm not sure I quite grasped what you're
getting at from above.

Thanks,
Dennis
