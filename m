Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7653B80BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 12:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhF3KTO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 06:19:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45422 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhF3KTO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 06:19:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C75141FE63;
        Wed, 30 Jun 2021 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625048204;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rovTXdRIxSpipxBdQK8Wz477ldmJKgdStqsJxIUGUI=;
        b=13WkhDqNzw18bjfaVQ8gAguni3w3hswiNaWvt9aBNS65wtA1xUW5aXpiTX22XNiGY9Z+IQ
        OMECpAHA6pa010y2v0Zcq7DR0584vmoh8HtPxHLPlzMl9nyrEnMyXLTDKLuI1+Fy9+rcts
        46CKet4YtFL4+vxGBCWcRJzVOVDqGrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625048204;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rovTXdRIxSpipxBdQK8Wz477ldmJKgdStqsJxIUGUI=;
        b=HnwaTxXz+OxKEGY+QWlj2UUBbp+Tk0FBC3B9cxkPA9jcsHtNeLUaaBvlMzWkJxfMKouwU0
        HaHUE8G+w2AxI0Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BFE13A3B9E;
        Wed, 30 Jun 2021 10:16:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1E09DA7A2; Wed, 30 Jun 2021 12:14:14 +0200 (CEST)
Date:   Wed, 30 Jun 2021 12:14:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Stop kmalloc'ing btrfs_path in
 btrfs_lookup_bio_sums
Message-ID: <20210630101414.GJ2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210628150609.2833435-1-nborisov@suse.com>
 <06554f93-68e1-b706-07be-62f6cdbf150e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06554f93-68e1-b706-07be-62f6cdbf150e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 29, 2021 at 07:56:34PM +0800, Qu Wenruo wrote:
> On 2021/6/28 下午11:06, Nikolay Borisov wrote:
> > While doing some performance characterization of a workoad reading ~80g
> > split among 4mb files via DIO I observed that btrfs_lookup_bio_sums was
> > using rather excessive cpu cycles:
> >
> > 95.97%--ksys_pread64
> > 95.96%--new_sync_read
> > 95.95%--iomap_dio_rw
> > 95.89%--iomap_apply
> > 72.25%--iomap_dio_bio_actor
> > 55.19%--iomap_dio_submit_bio
> > 55.13%--btrfs_submit_direct
> > 20.72%--btrfs_lookup_bio_sums
> > 7.44%-- kmem_cache_alloc
> >
> > Timing the workload yielded:
> > real 4m41.825s
> > user 0m14.321s
> > sys 10m38.419s
> >
> > Turns out this kmem_cache_alloc corresponds to the btrfs_path allocation
> > that happens in btrfs_lookup_bio_sums. Nothing in btrfs_lookup_bio_sums
> > warrants having the path be heap allocated. Just turn this allocation
> > into a stack based one. After the change performance changes
> > accordingly:
> >
> > real 4m21.742s
> > user 0m13.679s
> > sys 9m8.889s
> >
> > All in all there's a 20 seconds (~7%) reductino in real run time as well
> > as the time spent in the kernel is reduced by 1:30 minutes (~14%). And
> > btrfs_lookup_bio_sums ends up accounting for only 7.91% of cycles rather
> > than 20% before.
> >
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> I'm surprised that btrfs_path in kernel no longer needs any initialization.
> 
> I guess we can do a lot of more such conversion to use stack btrfs_path,
> just like what we did in btrfs-progs.
> 
> But I'm not that sure if 112 bytes stack memory usage increase is OK or
> not for other locations.

In justified cases 112 on-stack instead of allocation could be
considered but not in general. That progs to that is because it's in
userspace where handling memory is way easier and stack sizes are
megabytes, not a few kilobytes like in kernel.

The btrfs_path is allocated from slab and the performance hit is
negligible on the release build, as Nikolay found out.

> But since this one get a pretty good performance increase, and this
> function itself doesn't have much stack memory usage anyway, it looks ok
> to me.

The stack size needs to take into account the whole call chain that
could end up in this function, and in the IO paths we need to be
conservative in case there are other layers on top or under btrfs that
could need the stack space too.
