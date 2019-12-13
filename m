Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0DB11EDA7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 23:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLMWVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 17:21:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38950 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLMWVw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 17:21:52 -0500
Received: by mail-pg1-f194.google.com with SMTP id b137so160581pga.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 14:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KRrQGd9xx2Icjanj98lrTo1/sFZTs404zO5Bc0VMKMc=;
        b=pWbZl0fCiQWq2Ed0nTq/NDdq/0acDQThHTGa6oNsXQ7eZ6DUAPItdTISzndcA/zgyG
         UxRiIeu15Gnof3yucUOz/g9B7b8p2aNNY2H/tESh+JDkzBqj5sk3k3vCou1OB82iSjY9
         iE08aEybFMJLxNNWaflOcPWxTHH79t6N1sX/jwLnZZb4UAr+riy9Eh/R1IUPfbtBS3k4
         RhbxIbaU5p5HHlaD1HEHe3JmBk7n62jZR72Et4Oy1eWZ85KIkuC9pRvrGmjotbwClnan
         jIbUnUdO6s+JbJj1WwFv9O86yxgoAUCt9Z+Lds/ywFLktpTVcrD32F1VX+0ZoGz55Rq2
         NDVA==
X-Gm-Message-State: APjAAAV2fWE6ad0Eu0KffjJA23omG30BgTgivjbpFdZGbXOY5wb7YN0u
        5Xj3M23Ferp55oGHzyMn1rk=
X-Google-Smtp-Source: APXvYqyeKBG5gLe12/fRO3O8Dfv7mckEKjkf2jf7NbJa2ei1U7G1ggge6u5kSss6LtUftDKnCg0f4Q==
X-Received: by 2002:a62:e210:: with SMTP id a16mr2034334pfi.123.1576275712145;
        Fri, 13 Dec 2019 14:21:52 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:2b4c])
        by smtp.gmail.com with ESMTPSA id i11sm9905861pjg.0.2019.12.13.14.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 14:21:51 -0800 (PST)
Date:   Fri, 13 Dec 2019 14:21:49 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: fix compressed write bio attribution
Message-ID: <20191213222149.GA46346@dennisz-mbp.dhcp.thefacebook.com>
References: <d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org>
 <b3b4b89e7200237d0407c5f0a1f48d2d3736b5ed.1576109087.git.dennis@kernel.org>
 <20191212181934.GA33645@dennisz-mbp.dhcp.thefacebook.com>
 <20191213122401.GV3929@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213122401.GV3929@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 13, 2019 at 01:24:01PM +0100, David Sterba wrote:
> On Thu, Dec 12, 2019 at 10:19:34AM -0800, Dennis Zhou wrote:
> > From a0569aebde08e31e994c92d0b70befb84f7f5563 Mon Sep 17 00:00:00 2001
> > From: Dennis Zhou <dennis@kernel.org>
> > Date: Wed, 11 Dec 2019 15:20:15 -0800
> > 
> > Bio attribution is handled at bio_set_dev() as once we have a device, we
> > have a corresponding request_queue and then can derive the current css.
> > In special cases, we want to attribute to bio to someone else. This can
> > be done by calling bio_associate_blkg_from_css() or
> > kthread_associate_blkcg() depending on the scenario. Btrfs does this for
> > compressed writeback as they are handled by kworkers, so the latter can
> > be done here.
> > 
> > Commit 1a41802701ec ("btrfs: drop bio_set_dev where not needed") removes
> > early bio_set_dev() calls prior to submit_stripe_bio(). This breaks the
> > above assumption that we'll have a request_queue when we are doing
> > association. To fix this, switch to using kthread_associate_blkcg().
> 
> Can be kthread_associate_blkcg used also for submit_extent_page that
> calls bio_associate_blkg_from_css indirectly when initializing wbc?
> 
> 2996                 bio_set_dev(bio, bdev);
> 2997                 wbc_init_bio(wbc, bio);
> 2998                 wbc_account_cgroup_owner(wbc, page, page_size);
> 
> wbc_init_bio:
> 
> 	if (wbc)
> 		bio_associate_blkg_from_css();

Correct me if I'm wrong, but I don't think submit_extent_page() is only
called from kthread contexts. So, we wouldn't be able to rely on
kthread_associate_blkcg().

I can think about how to make wbc better for association in general, but
it's a percpu decrement and increment so it shouldn't really be much in
overhead.

Thanks,
Dennis
