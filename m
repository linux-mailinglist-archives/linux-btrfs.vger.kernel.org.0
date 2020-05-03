Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E81C2E67
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 May 2020 19:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgECRlq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 May 2020 13:41:46 -0400
Received: from relay-2.mailobj.net ([213.182.54.5]:45695 "EHLO
        relay-2.mailobj.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgECRlp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 May 2020 13:41:45 -0400
Received: from v-2c.localdomain (unknown [192.168.90.162])
        by relay-2.mailobj.net (Postfix) with SMTP id BCD7C1375;
        Sun,  3 May 2020 19:41:42 +0200 (CEST)
Received: by mail-2.net-c.com [213.182.54.29] with ESMTP
        Sun,  3 May 2020 19:41:42 +0200 (CEST)
X-EA-Auth: UyPzXLy0W4P4lPZv+dt4UaMIIse5zicRvA2XULi+46c5mQbkw3Tm1JKymr7KurjrUmYp/W85cbPchmC8fH9iu4CrtMn0N9vIOs433oSKILs=
Subject: Re: RAID1C3 across 3 devices but with only 2 online simultaneously
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <d54b6655-db2d-ff35-8c73-92f282dc252e@netc.fr>
 <20200429002525.GC10769@hungrycats.org>
From:   =?UTF-8?Q?Timoth=c3=a9e_Jourde?= <timjrd@netc.fr>
Message-ID: <4d33d702-0b40-5784-46aa-3099a0dad3a8@netc.fr>
Date:   Sun, 3 May 2020 19:41:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200429002525.GC10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for your very detailed answer, it was very informative about 
some of the internals of Btrfs.

Maybe a dedicated backup system is more suited to my use case.

I know it's easy to suggest a feature, but it would be awesome if Btrfs 
could scrub a filesystem without de-duplication and still be able to 
auto-repair from another Btrfs filesystem (which was the main reason I 
wanted to use RAID).

Thanks again!
Timothée


Zygo Blaxell:
> On Wed, Apr 29, 2020 at 12:49:39AM +0200, Timothée Jourde wrote:
>> Hi everyone! I would like to use Btrfs' RAID in a somewhat unorthodox way,
>> but if it's possible then it would be perfect for my use case.
>>
>> Suppose I have a RAID1C3 filesystem spanning 3 hard drives A, B and C, each
>> of the same size. A and B are at different physical locations after the
>> initial mkfs.
>>
>> When I want to make a backup, I would plug in drives C and A, and send them
>> a snapshot. Once in a while, I would go to drive B's location carrying drive
>> C with me, then I would plug in drives C and B, waiting for Btrfs to
>> replicate the missing data on drive B.
> 
> If the host is attached to drive C (e.g. host C is a laptop), and it
> connects to both drive A and B (e.g. A and B are USB external drives),
> then this is not a backup system because it does not isolate the
> backup and original disks from failures in host C (e.g. RAM failure).
> This configuration has all the (lack of) fault isolation of degraded
> raid1, you'll need a separate host for some drives to protect against
> host failures.
> 
> If drives A and B have their own hosts, and you are detaching drive C
> and carrying only the drive C between them, then read on...
> 
>> It would be easier than sending the snapshots across 3 different
>> filesystems, and most importantly, I could run a scrub with auto-repair on
>> C+A or C+B.
>>
>> I did some quick tests with 3 USB keys, and it *seems* to work. But I don't
>> know how to be notified when the replication is done (which seems to run
>> automatically/silently in the background).
> 
> The replication is done by scrub, so you can do a scrub status, or start
> the scrub with -B so that it doesn't exit until it's done.
> 
>> I also don't know whether it's a
>> reliable method or not.
> 
> Doing this with scrub is not reliable with the crc32c csum method--every
> ~16TB of updates, you'll get a crc32c collision, so you'll have the
> wrong data on disk and no csum failure to detect it with.  Any of the
> other csum options will solve this.  Use SHA256 if (and only if) you
> are worried about crypto collision attacks in your data; otherwise,
> xxhash64 is fine.  Any nodatasum files will most likely be trashed,
> as there are no csum failures to detect that an update is required,
> so scrub won't update them (or it will update them, but it will keep
> the old copy and overwrite the new one).
> 
> Doing this with btrfs replace is more reliable (in the sense that
> everything will be updated properly), but you need to be careful to avoid
> having btrfs become aware of the C drive before the replace is started
> (i.e. wipefs the target drive B or C, before it becomes visible to btrfs).
> You don't need raid1c3 for this, there will never be more than two drives
> connected at a time.  Replace will also not spam your kernel logs with
> millions of errors, so if anything does go wrong, you'll be able to spot
> it in the kernel log.
> 
> If something goes wrong during the resync between two drives, it is
> likely that both drives will be unrecoverable (if the source drive is
> damaged, it may be unrecoverable, and the target drive contents will
> be destroyed if either drive has a problem).
> 
> If the host A RAM is bad during the copy from A to C, and this is not
> noticed until after the copy from C to B starts, then all 3 filesystem
> copies may be damaged or destroyed.  If the host B RAM goes bad, it
> only bothers host B, assuming that drive C is overwritten by drive
> A when C goes back to A.
> 
> Depending on how you connect A and C, there's a risk that host A will
> choose C over A, wiping out updates that occurred on A during the
> time that C was disconnected (e.g. if C has a higher transid than A).
> 
> There will be no metadata redundancy on A while drive B is away, so a
> single UNC sector or bit flip error (both very common occurrences!) may
> destroy the filesystem on drive A.  Drive B and C can be 'btrfs replace'd,
> but if you want to keep the data on A then this is a problem.
> 
>> Any thoughts about this?
> 
> I'd try harder to make snapshot-based updates work on 3 separate
> filesystems (either btrfs send, or just make a snapshot on A and rsync
> it to a snapshot on C if that's easier to manage).  This removes the
> requirement to keep umounting the filesystem at host B whenever C arrives.
> 
> With 3 separate filesystems you have much better fault isolation, and
> the whole point of backups is to have redundant copies _in isolated
> failure domains_.  It's also much harder to accidentally destroy the
> whole thing with a btrfs uuid collision gotcha.
> 
> With separate filesystems, when host RAM goes bad on host A, it can
> destroy A and C at the same time, but host B (whose host RAM hopefully
> has not gone bad at the same time) will not be destroyed by the update
> from C to B.  Host B can detect the error and abort the update instead,
> leaving whatever data was previously on B intact.
> 
> Also with 3 filesystems you can have dup metadata on each disk, so you
> can repair single bit errors and UNC sectors instead of going all the
> way back to mkfs.
> 
> Another alternative is to swap B and C instead of overwriting one with
> the other, so you always have 2 complete copies.
> 
>> Thanks!
>> Timothée
>>

