Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0986C11ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 13:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCTMbH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 08:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjCTMbG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 08:31:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A64BDD3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 05:31:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 175BF68AFE; Mon, 20 Mar 2023 13:31:00 +0100 (CET)
Date:   Mon, 20 Mar 2023 13:30:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Message-ID: <20230320123059.GB9008@lst.de>
References: <20230314165910.373347-1-hch@lst.de> <20230314165910.373347-4-hch@lst.de> <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 20, 2023 at 07:29:38PM +0800, Qu Wenruo wrote:
> Sure, they are called in very strict context, thus we should keep them 
> short.
> But on the other hand, we're already having too many workqueues, and I'm 
> always wondering under what situation they can lead to deadlock.
> (e.g. why we need to queue endios for free space and regular data inodes 
> into different workqueues?)

In general the reason for separate workqueues is if one workqueue depends
on the execution of another.  It seems like this is Josef's area, but
my impression is that finishing and ordered extent can cause writeback
and a possible wait for data in the freespace inode.  Normally such
workqueue splits should have comments in the code to explain them, but
so far I haven't found one.

> My current method is always consider the workqueue has only 1 max_active, 
> but I'm still not sure for such case, what would happen if one work slept?

That's my understanding of the workqueue mechanisms, yes.

> Would the workqueue being able to choose the next work item? Or that 
> workqueue is stalled until the only active got woken?

I think it is stalled.  That's why the workqueue heavily discourages
limiting max_active unless you have a good reason to, and most callers
follow that advise.

> Personally speaking, I'd like to keep the btrfs bio endio function calls in 
> the old soft/hard irq context, and let the higher layer to queue the work.

Can you explain why?

> However we have already loosen the endio context for btrfs bio, from the 
> old soft/hard irq to the current workqueue context already...

read I/O are executed in a workqueue.  For write completions there also
are various offloads, but none that is consistent and dependable so far.
