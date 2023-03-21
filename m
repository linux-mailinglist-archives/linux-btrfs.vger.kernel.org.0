Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502FA6C3208
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 13:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjCUMtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 08:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCUMs6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 08:48:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C86CC31
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:48:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D24F68CFE; Tue, 21 Mar 2023 13:48:46 +0100 (CET)
Date:   Tue, 21 Mar 2023 13:48:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/10] btrfs: use a plain workqueue for ordered_extent
 processing
Message-ID: <20230321124844.GA10470@lst.de>
References: <20230314165910.373347-1-hch@lst.de> <20230314165910.373347-2-hch@lst.de> <c797c695-cd20-9ab6-7b12-19e43ab1069c@gmx.com> <65e3dc23-6e86-dc4d-0a1b-2ec69060dd44@gmx.com> <20230320122420.GA9008@lst.de> <675712c0-ac72-f923-247c-31f0b22a8657@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675712c0-ac72-f923-247c-31f0b22a8657@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 21, 2023 at 07:19:30AM +0800, Qu Wenruo wrote:
>> I'm also really curious (and I might have to do some digging) what
>> the intended use case is, and if it actually works as-is.  I know
>> one of your workloads mentioned a higher concurrency for some HDD
>> workloads, do you still remember what the workloads are?
>
> In fact, recently we had a patchset trying to adding a new mount option to 
> pin workqueue loads to certain CPUs.
>
> The idea of that patchset is to limit the CPU usage for compression/csum 
> generation.
>
> This can also apply to scrub workload.

... and is totally unrelated to using either a core workqueue max_active
value or reimplementing that in btrfs.

> The other thing is, I also want to test if we could really have certain 
> deadlock related to workqueue.
> Currently thread_pool= mount option only changes the btrfs workqueues, not 
> the new plain ones.

What kind of deadlock testing do you want, and why does it apply
to all workqueues in btrfs and not other workqueues?  Note that you'd
also need to change the btrfs_workqueue code to actually apply literally
everywhere.

Maybe we can start by going back to me request, and can actually come
up with a definition for what thread_pool= is supposed to affect, and
how users should pick values for it?  There is a definition in the
btrfs(5) man page, but that one has been wrong at least since 2014
and the switch to use workqueues.
