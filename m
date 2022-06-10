Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01EF545F72
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347429AbiFJIkI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 04:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347377AbiFJIjy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 04:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8050D3D1CB
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 01:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CC1A61697
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 08:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B7DC34114;
        Fri, 10 Jun 2022 08:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654850372;
        bh=eVj3uoaDluudBttrzZZ6l/LE/KtUI4qKcOtq9gMucIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9By7VoK24adoAMIlV3o8NMdw2WoxZx85NsixYu0t0zOrL+SgHb6QgN7IQDdv+mv6
         +68sR9Z4rQwP2sZyz4cWK4xl0jMXtYBMQ+7R1hoxZUN1LhvAd1fZbqWmg4H7w5iGUg
         JyhFFtDfBsLkmbnGsgo/S2DyuSbp/yq5eY/LrK0PImZSS7dZoqtgqpSlOvat6ekfEG
         G9ebYTZc6FWkmx+FAFVh5A6+FtIqntFSKKNE+j8vNT2VVatQJN3rB/mm4Pze7h5h+Q
         ynAtbCGk0A2swkiQu253xRYRKJokFk+Ahlsh90ZIYoDuPoqx1n3paEqvRPXIKeJhdW
         0VvT7P4nbhI6A==
Date:   Fri, 10 Jun 2022 09:39:29 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Message-ID: <20220610083929.GA3742796@falcondesktop>
References: <20220609164629.30316-1-dsterba@suse.com>
 <ed4f2880-b4f3-cf16-00c9-b107141a7421@gmx.com>
 <d1957ade-a9be-c1e4-1356-89d3e73bb121@suse.com>
 <51502090-6278-ae62-8084-b995cf04caa5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51502090-6278-ae62-8084-b995cf04caa5@gmx.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 10, 2022 at 03:33:47PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/6/10 15:23, Nikolay Borisov wrote:
> > 
> > 
> > On 10.06.22 г. 3:07 ч., Qu Wenruo wrote:
> > > 
> > > 
> > > On 2022/6/10 00:46, David Sterba wrote:
> > > > Currently the super block page is from the mapping of the block device,
> > > > this is result of direct conversion from the previous buffer_head to bio
> > > > API.  We don't use the page cache or the mapping anywhere else, the page
> > > > is a temporary space for the associated bio.
> > > > 
> > > > Allocate pages for all super block copies at device allocation time,
> > > > also to avoid any later allocation problems when writing the super
> > > > block. This simplifies the page reference tracking, but the page lock is
> > > > still used as waiting mechanism for the write and write error is tracked
> > > > in the page.
> > > > 
> > > > As there is a separate page for each super block copy all can be
> > > > submitted in parallel, as before.
> > > 
> > > Is there any history on why we want parallel super block submission?
> > 
> > Because it's in the transaction critical path so it affects latency of
> > operations.
> 
> Not exactly.
> 
> Super block writeback happens with TRANS_STATE_UNBLOCKED status, which
> means new transaction can already be started.
> 
> Thus even if we don't do any parallel submission, there is no
> performance impact on transaction path.

Hell, no. There's more than transaction states to consider.

Taking longer to write super blocks can have a performance impact on fsync
for example. And fsync always has to write super blocks and wait for them
to complete. In fact, a large part of time spent on fsync is precisely on
writing super blocks.

In some cases fsync has to fallback to a transaction commit and wait for
it to complete before returning to user space - which again requires writing
super blocks and waiting for their completion.

Similarly, there are ioctls like snapshot and subvolume creation which
commit a transaction, and any changes to the way super blocks are written
can also affect their latency and impact applications.

> 
> Thanks,
> Qu
> > 
> > > 
> > > In fact, for the 3 super blocks, the primary one has FUA flag, while the
> > > other backup ones doesn't.
> > > 
> > > This means, even we wait for the super block write, only the first one
> > > would take some real time, while the other two can return almost
> > > immediate for devices with write cache.
> > > 
> > > In fact, waiting for the super block write back can tell us if our
> > > primary super block did really reach disk, allowing us to do better
> > > error handling, other than the almost non-exist check in endio.
> > > 
> > > And such synchronous submission allows us to have only one copy of the
> > > sb.
> > > 
> > > 
> > > Furthermore, if we really go parallel, I don't think the current way is
> > > the correct way.
> > > 
> > > One device can have at most 3 superblocks, but a btrfs can easily have
> > > more than 4 devices.
> > > 
> > > Shouldn't we parallel based on device, other than each superblock?
> > 
> > I agree that instead of having 3 pages per-device we can go the 1 page
> > per device, and parallelize based on the device, rather than the super
> > block copies.
> > 
> > <snip>
