Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500822CDE88
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 20:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgLCTOD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 14:14:03 -0500
Received: from multitrading.dk ([92.246.25.51]:59829 "EHLO multitrading.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgLCTOD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 14:14:03 -0500
Received: (qmail 68428 invoked from network); 3 Dec 2020 19:13:21 -0000
Received: from multitrading.dk (HELO ?10.0.3.10?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 3 Dec 2020 19:13:21 -0000
Date:   Thu, 3 Dec 2020 20:13:16 +0100
From:   Jens Bauer <jens-lists@gpio.dk>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <20201203201316503558.f535264b@gpio.dk>
In-Reply-To: <f51b636b-0e5f-c3d9-916f-f8196dae4ef0@suse.com>
References: <20201203035311997396.38ae743f@gpio.dk>
 <f51b636b-0e5f-c3d9-916f-f8196dae4ef0@suse.com>
Subject: Re: How robust is BTRFS?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: GyazMail version 1.5.21
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu.

On Thu, 3 Dec 2020 18:59:35 +0800, Qu Wenruo wrote:
>> The BTRFS developers deserves some credit!
>> 
>> My setup was several RAID-10 partitions.
> 
> You should be proud for not using RAID5/6. :)

Yes, I did investigate the status before I decided which RAID type to use.
I prioritize high throughput and stability over space.

>> After correcting the problem, I got curious and listed the 
>> statistics for each partition.
>> I had more than 100000 read/write errors PER DAY for 6 months.
>> That's around 18 million read/write-errors, caused by drives turning 
>> on/off "randomly".

(I remember some of the 'more than 100000 per day' to be 119xxx, so it may easily have been more than 20 million errors).

>> AND ALL MY FILES WERE INTACT.
>> 
>> This is on the border to being impossible.
> 
> I would say, yeah, really impressive, even to a btrfs developer.

I actually expected it would be. ;)
There are still things I forgot to mention in my first post:
A few of the RAID-partitions were in RAID0 configuration and files there were also intact.
(Had it been any other RAID0, I'd have lost every file on those partitions, no doubt!)
-Another thing I forgot to mention is the total usage was around 1.5TB out of a total of 2TB, and verifying that my files were intact took days, as I did a byte-by-byte comparison.
The drives mainly store: More than 170 Web-sites, mail for 4 domains, a lot of video files on a NAS and archives containing source-code (like GCC) for local caching.

> Btrfs RAID10/RAID1 by design is really good, since it has the extra
> checksum to make everything under check, thus unlike regular RAID10
> which can only handle missing device once, it knows which data is
> incorrect and will then just retry the good copy, and recovery the bad one.

That's something I really sensed when I saw what my files survived. =)

> Which means, btrfs can even handle extreme cases like 4 devices raid10,
> and each disk disappear for a while, but never 2 disks disappear together.

I had the impression that it would be able to handle two disappearances at the same time, but not 3 - but if it's limited by the design, I won't argue - you know the inner workings better than I. ;)

> But in your case, you really put btrfs failover to limit.

Completely unintended, but now you know how to make an extreme test-setup: Just make sure the drives don't get enough current. ;)

> Anyway, feel great that btrfs really helped you.

My experience with BTRFS made me want to use it in every possible place I can.
I'm even thinking of doing silly things like iSCSI for Mac, hosting HFS+ images on a BTRFS (I'm convinced it would even speed up HFS+).

> Thanks,
> Qu

I'm really the one who need to thank you. ;)
-May everyone on this list have a wonderful Christmas. =)


Love
Jens
