Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A0559C999
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiHVUIw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 16:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHVUIv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 16:08:51 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4988491CF
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 13:08:50 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id D058FDEB68; Mon, 22 Aug 2022 16:08:49 -0400 (EDT)
References: <a3fc9d94-4539-429a-b10f-105aa1fd3cf3@www.fastmail.com>
 <87v8qokryt.fsf@vps.thesusis.net>
 <a6b0c534-4f05-4f60-a7fa-f33cfce990d7@www.fastmail.com>
User-agent: mu4e 1.7.12; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     George Shammas <btrfs@shamm.as>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: What exactly is BTRFS Raid 10?
Date:   Mon, 22 Aug 2022 15:51:12 -0400
In-reply-to: <a6b0c534-4f05-4f60-a7fa-f33cfce990d7@www.fastmail.com>
Message-ID: <87k0706nxq.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


"George Shammas" <btrfs@shamm.as> writes:

>> Btrfs raid10 requires an even number of drives with a minimum of 4.
>
> Is this true? I just experimented with 3 drives and `btrfs device
> usage` ends up showing 'RAID10/2' But the data is equally spread
> across all three drives. Even though the stripe is 2, the data is
> still being placed evenly across three drives. See [1] for an actual
> example I just created.

mkfs.btrfs won't let me create a raid10 with only 3 drives: it says you
need at least 4.  You can do that with mdraid but btrfs doesn't seem to
let you and I thought it was because of:

>> It's pretty much raid 1+0.

> Again, is it? raid 1+0 would imply that two drives are mirrored, and
> hence identical, and the blocks are striped over mirrored sets. This
> would also force devices being in multiple of two, which is not the
> case.

Don't forget that it is done at the chunk level rather than the drive
level.  I just tried 5 drives though and that does seem to work,
however, btrfs filesystem usage shows that the chunk is only allocated
on disks 2,3,4,5 and disk 1 is unused.  Over time you are going to end
up with the average usage about the same but no single chunk is striped
across all 5 drives.

> If I am right, and I don't know that I am, that would make raid1 and
> raid10 have the very similar data loss scenarios that are not
> completely obvious.

Yes, in general raid1 and raid10 have similar redundancy: they can only
handle the loss of a single drive.  Any more than that and you are
relying on peculiarities of the layout and which particular drives
failed, and that's never a good idea.

> And the question remains if that is the case, is there ever a reason to choose raid1 over raid, and vice versa. 

The reason to choose raid10 over raid1 is for the better sequential
performance you can get from the striping.  I ran an mdraid raid10 on 3
disks for years for the good throughput and redundancy qualities.

