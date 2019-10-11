Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A9D472D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 20:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfJKSHH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 14:07:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45217 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfJKSHH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 14:07:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id z67so9670105qkb.12
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 11:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mjPoNDuAkBgQRwqHbGG+LxSoYMA5VcKa0vExBnpHuOM=;
        b=UqNT1lmayJ5VYDnwvrUIVh540CMaoPKSxwr9+ULBUExRCIoPy3v9Pxg9GKwTNftm12
         eNeuHp0qd1ytaWix3GtM6Qq2P5qliV8Hz/Ov/RSZr2TfeXr11SoWOB65eM7Edch1qX3V
         6CMUzWdtqaXYpGKwa8XDZDmxQKdV/9XNruuf0/UzxJOML2QD3vUKWqBRWKqXrVZSSfI6
         JD+3tQ8TsfuGPgrXAzi1vN53rGjBQmNEA3XN9+wzW7sOEb+6XPaznSAXxiRuSQY5AaaM
         e/gN0+QpQI9hinh9QDhLTGFETik11qpwDFhpigiwfVRp25HAUe/6FfkaLZf/cVDZkykC
         QX8Q==
X-Gm-Message-State: APjAAAWOWwmUBXfej1i/mLA8xkbRvNx333RM4NnPVYy69p76dZfeGaOk
        gwNGB543hNMpcBLG3cFPDw4=
X-Google-Smtp-Source: APXvYqwoX2wiooCfaoptOB+s/pnF28VjN5k4cSqG64JPlioYA3lJAdqscsQmYZsuY6qO4rbhiKxIyQ==
X-Received: by 2002:a37:f61d:: with SMTP id y29mr1610790qkj.338.1570817226196;
        Fri, 11 Oct 2019 11:07:06 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c091:500::2:985b])
        by smtp.gmail.com with ESMTPSA id q47sm6920249qtq.95.2019.10.11.11.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 11:07:05 -0700 (PDT)
Date:   Fri, 11 Oct 2019 14:07:03 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/19] btrfs: calculate discard delay based on number of
 extents
Message-ID: <20191011180703.GE29672@dennisz-mbp>
References: <cover.1570479299.git.dennis@kernel.org>
 <37690bf17c3b3c9f20137fb186c7af4021bb664b.1570479299.git.dennis@kernel.org>
 <20191010154133.pk62hvu6pgac3mne@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010154133.pk62hvu6pgac3mne@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 11:41:33AM -0400, Josef Bacik wrote:
> On Mon, Oct 07, 2019 at 04:17:41PM -0400, Dennis Zhou wrote:
> > Use the number of discardable extents to help guide our discard delay
> > interval. This value is reevaluated every transaction commit.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  fs/btrfs/ctree.h       |  2 ++
> >  fs/btrfs/discard.c     | 31 +++++++++++++++++++++++++++++--
> >  fs/btrfs/discard.h     |  3 +++
> >  fs/btrfs/extent-tree.c |  4 +++-
> >  fs/btrfs/sysfs.c       | 30 ++++++++++++++++++++++++++++++
> >  5 files changed, 67 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 8479ab037812..b0823961d049 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -449,6 +449,8 @@ struct btrfs_discard_ctl {
> >  	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
> >  	atomic_t discard_extents;
> >  	atomic64_t discardable_bytes;
> > +	atomic_t delay;
> > +	atomic_t iops_limit;
> >  };
> >  
> >  /* delayed seq elem */
> > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > index 75a2ff14b3c0..c7afb5f8240d 100644
> > --- a/fs/btrfs/discard.c
> > +++ b/fs/btrfs/discard.c
> > @@ -15,6 +15,11 @@
> >  
> >  #define BTRFS_DISCARD_DELAY		(300ULL * NSEC_PER_SEC)
> >  
> > +/* target discard delay in milliseconds */
> > +#define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60ULL * MSEC_PER_SEC)
> > +#define BTRFS_DISCARD_MAX_DELAY		(10000UL)
> > +#define BTRFS_DISCARD_MAX_IOPS		(10UL)
> > +
> >  static struct list_head *
> >  btrfs_get_discard_list(struct btrfs_discard_ctl *discard_ctl,
> >  		       struct btrfs_block_group_cache *cache)
> > @@ -170,10 +175,12 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
> >  
> >  	cache = find_next_cache(discard_ctl, now);
> >  	if (cache) {
> > -		u64 delay = 0;
> > +		u64 delay = atomic_read(&discard_ctl->delay);
> >  
> >  		if (now < cache->discard_delay)
> > -			delay = nsecs_to_jiffies(cache->discard_delay - now);
> > +			delay = max_t(u64, delay,
> > +				      nsecs_to_jiffies(cache->discard_delay -
> > +						       now));
> 
> Small nit, instead
> 
> 			delay = nsecs_to_jiffies(cache->discard_delay - now);
> 			delay = max_t(u64, delay,
> 				      atomic_read(&discard_ctl->delay);
> 
> Looks a little cleaner.  Otherwise

Hmmm. Does that work if now > cache->discard_delay? I'm just worried
about the max_t with type u64.

> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks,
> 
> Josef

Thanks,
Dennis
