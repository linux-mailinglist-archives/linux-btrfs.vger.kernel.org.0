Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D6A12352D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 19:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfLQSoh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 13:44:37 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40756 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfLQSoh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 13:44:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id c17so8327276qkg.7
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 10:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=em3ydnYiwFDAO9RTgcHEfhtwAEIdX3KXlxx4yRGRpJk=;
        b=sOKfI3HjKwTYUZ7JfIOxQ6OyigLL6afmW95WZRgDCf+Q4BJJhp40eX0lF9hQsMAnGn
         CNbc5NR7fPxIeQcRakv5XZt7bRHxArxrK1Kahkn/8KDYy6DjWZqxOlDiROcTkOsO+Uba
         wWU7Yi0YjsVN15aom6+llbkTWZwmYembtHXVq4QGil9I77FeCpKRY/ROLDwVJDVkh/WZ
         QdCiGvFb5UD5kNs8kA12Nk/hySFv16q5zZGDqQYbO0h3JymfaMIYD015FMGk7ltvKba4
         HtsIId0Px52ZmCc5YkWkXOgUS/c6sokUMoDntdW3mRU2EcYT04cvW3gFfMOquCRiNcZw
         8wbw==
X-Gm-Message-State: APjAAAUaS6uq/Dbzx393z+2z5DuHc7sPOkZFDBZo27cFuZEkIxv+qgfH
        q3oW+e+P/tF9No+MidEYdsM=
X-Google-Smtp-Source: APXvYqzI+hRnsk2fMPrUebro4r6zWiguvXpLkPhtos335G9uFLX6kZygS4gxBLPhSVaYFnN3ZZNK5w==
X-Received: by 2002:a37:de16:: with SMTP id h22mr6636519qkj.400.1576608276319;
        Tue, 17 Dec 2019 10:44:36 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::1246])
        by smtp.gmail.com with ESMTPSA id o201sm7225355qka.17.2019.12.17.10.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 10:44:35 -0800 (PST)
Date:   Tue, 17 Dec 2019 13:44:33 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: fix compressed write bio attribution
Message-ID: <20191217184433.GA2823@dennisz-mbp>
References: <d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org>
 <b3b4b89e7200237d0407c5f0a1f48d2d3736b5ed.1576109087.git.dennis@kernel.org>
 <20191212181934.GA33645@dennisz-mbp.dhcp.thefacebook.com>
 <20191213122401.GV3929@suse.cz>
 <20191213222149.GA46346@dennisz-mbp.dhcp.thefacebook.com>
 <20191217150548.GF3929@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217150548.GF3929@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 17, 2019 at 04:05:48PM +0100, David Sterba wrote:
> On Fri, Dec 13, 2019 at 02:21:49PM -0800, Dennis Zhou wrote:
> > On Fri, Dec 13, 2019 at 01:24:01PM +0100, David Sterba wrote:
> > > On Thu, Dec 12, 2019 at 10:19:34AM -0800, Dennis Zhou wrote:
> > > > From a0569aebde08e31e994c92d0b70befb84f7f5563 Mon Sep 17 00:00:00 2001
> > > > From: Dennis Zhou <dennis@kernel.org>
> > > > Date: Wed, 11 Dec 2019 15:20:15 -0800
> > > > 
> > > > Bio attribution is handled at bio_set_dev() as once we have a device, we
> > > > have a corresponding request_queue and then can derive the current css.
> > > > In special cases, we want to attribute to bio to someone else. This can
> > > > be done by calling bio_associate_blkg_from_css() or
> > > > kthread_associate_blkcg() depending on the scenario. Btrfs does this for
> > > > compressed writeback as they are handled by kworkers, so the latter can
> > > > be done here.
> > > > 
> > > > Commit 1a41802701ec ("btrfs: drop bio_set_dev where not needed") removes
> > > > early bio_set_dev() calls prior to submit_stripe_bio(). This breaks the
> > > > above assumption that we'll have a request_queue when we are doing
> > > > association. To fix this, switch to using kthread_associate_blkcg().
> > > 
> > > Can be kthread_associate_blkcg used also for submit_extent_page that
> > > calls bio_associate_blkg_from_css indirectly when initializing wbc?
> > > 
> > > 2996                 bio_set_dev(bio, bdev);
> > > 2997                 wbc_init_bio(wbc, bio);
> > > 2998                 wbc_account_cgroup_owner(wbc, page, page_size);
> > > 
> > > wbc_init_bio:
> > > 
> > > 	if (wbc)
> > > 		bio_associate_blkg_from_css();
> > 
> > Correct me if I'm wrong, but I don't think submit_extent_page() is only
> > called from kthread contexts. So, we wouldn't be able to rely on
> > kthread_associate_blkcg().
> 
> Yeah, the kthread is not guaranteed here.
> 
> > I can think about how to make wbc better for association in general, but
> > it's a percpu decrement and increment so it shouldn't really be much in
> > overhead.
> 
> Performance is not my concern here, the addition of bios and blkcg
> association is new and there were some integration bugs where I
> independently removed early bdev association while the blkg relied on
> that. I'm looking for ways to make it less error prone and the kthread
> association looks exactly like that so I was curious if it's possible to
> use it everywhere. If not, the bdev needs to be found from other
> available data.

Yeah. At the time, going through bio_set_dev() was a way to guarantee we
weren't missing an association with a blk-cgroup. This simplified
auditing and prevented newer use cases from missing it. However, I do
agree it's quite error prone.. I'll put it on my list and see if I can
come up with something better.

Thanks,
Dennis
