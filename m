Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAFE196F10
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Mar 2020 19:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgC2R6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Mar 2020 13:58:15 -0400
Received: from 4brad.ctyme.com ([184.105.182.90]:47868 "EHLO 4brad.ctyme.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgC2R6O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Mar 2020 13:58:14 -0400
Received: from [192.168.123.14] (c-76-102-119-11.hsd1.ca.comcast.net [76.102.119.11])
        by 4brad.ctyme.com (Postfix) with ESMTPSA id 5EBD96340A35;
        Sun, 29 Mar 2020 13:58:10 -0400 (EDT)
Subject: Re: btrfs-transacti hangs system for several seconds every few
 minutes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <c8513b49-1408-3d99-b1ff-95c36de2ef67@templetons.com>
 <38a47c1a-d5b1-43c5-e026-10c2d4a9c039@gmx.com>
From:   Brad Templeton <4brad@templetons.com>
Organization: http://www.templetons.com/brad
Message-ID: <162a3eaf-dfdb-9ce6-b6fd-1204836b7c31@templetons.com>
Date:   Sun, 29 Mar 2020 10:58:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <38a47c1a-d5b1-43c5-e026-10c2d4a9c039@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It started doing what it claims is a "disk checK", where it says it is
doing 4 tasks and gives it 90 seconds to do it.  (It does this every
time I boot.)  However, this time it timed out, and went to 3 minutes,
then 4 minutes 30 seconds and then the boot aborted on the timeout.

However, the filesystems mounted.   I was unable to do the test " btrfs
ins dump-tree -t 10 /dev/vgwaya/root |
                 grep 'owner FREE_SPACE_TREE' | wc -l"
Because I have no device named anything like vgwaya.

My guess was this was the cache clearance taking a very long time, and I
should not have done it at reboot?  My perhaps wrong instinct was that
this would be cleanest but perhaps not.

Normally it takes exactly 90 seconds every time.  It is annoying.  Most
systems have gotten their boot times down very low these days.  While I
often go many months without booting, whenever I am trying to debug
things I end up rebooting frequently and with everything but the RAID on
flash (as I expect most people do these days) every other aspect of the
boot is quick, except the btrfs filesystem mount.  It reminds me of the
days when you had to do fsck too much.

Yes, I need more ram.   Tools have bloated so much that 16gb is no
longer nearly enough for an ordinary desktop with lots of web browser
tabs.   Sadly, to get more ram I will need to get a new
motherboard/cpu/etc.) which is frankly a lot of work.

The v2 cache has done something.  In the past, there were not only the
hangs, but just a lot more activity on the disk (you can hear it.) The
computer is a lot quieter now.    Rebooting, as we know, can fix many
things, and right now I'm not needing any swap. As I use the system more
memory sucks will arrive and I'll start using the swap and I will track it.

On 3/29/20 6:14 AM, Qu Wenruo wrote:
> 
> 
> On 2020/3/29 下午12:03, Brad Templeton wrote:
>> Not using qgroups.  Not doing snapshots.    Did a reboot with the
>> options to upgrade to v2 -- it failed,
> 
> What did you mean about "it failed"
> 
> It failed to mount or something else showed up?
> 
> If failed to mount, would you like to shared the dmesg of that mount
> failure?
> 
>> in that the disk check took more
>> than 6 minutes,
> 
> Please be aware that, btrfs check, unlike e2fsck, will always check all
> metadata of the fs, no matter if the fs is clean unmounted or not.
> 
> In fact, btrfs unlike other journal based fs, has no clear way to
> determine if an fs is unmounted cleanly or not.
> (Log tree is one method, but not a reliable one).
> 
> 6 min looks completely valid to me.
> 
>> but it worked, and the second time I was able to boot,
>> and -- knock on wood -- so far it has not hung.
> 
> If you hit the hang, you could try to use 'perf' command to try to probe
> the runtime of btrfs_commit_transaction() and its major components.
> 
> It would be super helpful if we could determine which is the major cause.

> 
>>
>> I wonder why they put 5.3.0 as the standard advanced Kernel in Ubuntu
>> LTS if it has a data corruption bug.   I don't know if I've seen any
>> release of 5.4.14 in a PPA yet -- manual kernel install is such a pain
>> the few times I have done it.  I could revert, but the reason I switched
>> to 5.3, not long ago, was another problem with sound drivers.
>>
>> BTW, even though it now works, it still takes 90 seconds every boot
>> doing a disk check, even after what I think is a clean shutdown.   I
>> presume that is not normal, any clues on what may cause that?
>>
> Another thing I found is, in your initial report, your swap is heavily used.
> 
> I guess it may be related to the memory pressure, where every metadata
> write needs to do a lot of metadata read before it can do anything.
> 
> If that's the case, it would be good to keep an eye on the memory
> pressure to make sure fs can still have enough metadata cache without
> triggering too much IO in its critical section.
> 
> Thanks,
> Qu
> 
