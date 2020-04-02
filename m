Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1B519CAAC
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbgDBT5F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 15:57:05 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:39464 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731579AbgDBT5E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Apr 2020 15:57:04 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id K5xSjmCZBMAUpK5xSjCMaR; Thu, 02 Apr 2020 21:56:59 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585857419; bh=xD/3tt0wPiDsNX5uK0Vq0ZlhbG5j7bFmgwUTKcBTpWc=;
        h=From;
        b=O+3KKuNMyhNlNQ4l+07FSdigQu0vkvovKirFJsv5PyYVkAc7LXPoFYrVhZcYfIJhh
         xAYbw1By8poPH/3pt//c8STiwjOC9AABEgyEJajpy+7WzqBGkdrqEj35J9PN+SygZU
         dY8OQ49JNVdcCSDKLbZh6j2cOetSEzZn9cy7D/M2sqXblh9nd31KfGXT536XElFcQm
         N+g6JguBHYuhLCIiNUryvDL2qA5jFtflh1VoiZi5Q7/G62QGrmiWpZfjy5BYqWzLSR
         tlEFWJKSb7OzG8/EDJcqXR8CthwThaJ1W8dSu8d3OxO3J0L0Ey12HW0RtlVmmeBniR
         unmUO9SjXzISw==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=kT-NTsFwAAAA:8 a=ojkvdL5kITeWQHjP64AA:9 a=7cPKlU8j7B8vpa0N:21
 a=eEgWd8QB1iUoWcGA:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=TLwuWKmryFjkTYsgBL5T:22
Reply-To: kreijack@inwind.it
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <75e517d2-7a47-773e-9a3b-9a148203e363@libero.it>
Date:   Thu, 2 Apr 2020 21:56:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDV0XrrAoyi3GD7Mq7ZMUwxgvE6jt6R2eddJ+0q3YPFNrcOWeN5o1UcgwyEmrjYRz8mcljwqRdiC8fdCEvqHsOcCB/W72nbUyiAk+aPVOWXd2440vARz
 A8r/WhdXXdxaGlfFKvZOJJPFXEJafT3hjNzW+HCr5njdf3rSS1sATXBl3cfdCvX7PmgbHuhIH4NI7ydM+HgwX587uAL3AkiFUsqMeIfi8oKX/GrCBRfATrv1
 8IvYYk3fatdivjGmbB4tVUnCi6od9rW6f0jpYE+NAI3t+BN6SSx2q5VxDdgYftAE
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/2/20 1:08 PM, Filipe Manana wrote:
> Hi,
> 
> Recently I was looking at why the test case btrfs/125 from fstests often fails.
> Typically when it fails we have something like the following in dmesg/syslog:
[...]
> 
> So I finally looked into it to figure out why that happens.
> 
> Consider the following scenario and steps that explain how we end up
> with a metadata extent
> permanently corrupt and unrecoverable (when it shouldn't be possible).
> 
> * We have a RAID5 filesystem consisting of three devices, with device
> IDs of 1, 2 and 3;
> 
> * The filesystem's nodesize is 16Kb (the default of mkfs.btrfs);
> 
> * We have a single metadata block group that starts at logical offset
> 38797312 and has a
>    length of 715784192 bytes.
> 
> The following steps lead to a permanent corruption of a metadata extent:
> 
> 1) We make device 3 unavailable and mount the filesystem in degraded
> mode, so only
>     devices 1 and 2 are online;
> 
> 2) We allocate a new extent buffer with logical address of 39043072, this falls
>     within the full stripe that starts at logical address 38928384, which is
>     composed of 3 stripes, each with a size of 64Kb:
> 
>     [ stripe 1, offset 38928384 ] [ stripe 2, offset 38993920 ] [
> stripe 3, offset 39059456 ]
>     (the offsets are logical addresses)
> 
>     stripe 1 is in device 2
>     stripe 2 is in device 3
>     stripe 3 is in device 1  (this is the parity stripe)
> 
>     Our extent buffer 39043072 falls into stripe 2, starting at page
> with index 12
>     of that stripe and ending at page with index 15;
> 
> 3) When writing the new extent buffer at address 39043072 we obviously
> don't write
>     the second stripe since device 3 is missing and we are in degraded
> mode. We write
>     only the stripes for devices 1 and 2, which are enough to recover
> stripe 2 content
>     when it's needed to read it (by XORing stripes 1 and 3, we produce
> the correct
>     content of stripe 2);
> 
> 4) We unmount the filesystem;
> 
> 5) We make device 3 available and then mount the filesystem in
> non-degraded mode;

Why it is possible to do that ? The generation numbers should be different and
this should highlight the problem so btrfs should not allow that.

> 
> 6) Due to some write operation (such as relocation like btrfs/125
> does), we allocate
>     a new extent buffer at logical address 38993920. This belongs to
> the same full
>     stripe as the extent buffer we allocated before in degraded mode (39043072),
>     and it's mapped to stripe 2 of that full stripe as well,
> corresponding to page
>     indexes from 0 to 3 of that stripe;
> 
> 7) When we do the actual write of this stripe, because it's a partial
> stripe write
>     (we aren't writing to all the pages of all the stripes of the full
> stripe), we
>     need to read the remaining pages of stripe 2 (page indexes from 4 to 15) and
>     all the pages of stripe 1 from disk in order to compute the content for the
>     parity stripe. So we submit bios to read those pages from the corresponding
>     devices (we do this at raid56.c:raid56_rmw_stripe()). The problem is that we
>     assume whatever we read from the devices is valid - in this case what we read
>     from device 3, to which stripe 2 is mapped, is invalid since in the degraded
>     mount we haven't written extent buffer 39043072 to it - so we get
> garbage from
>     that device (either a stale extent, a bunch of zeroes due to trim/discard or
>     anything completely random). Then we compute the content for the
> parity stripe
>     based on that invalid content we read from device 3 and write the
> parity stripe
>     (and the other two stripes) to disk;

You made a very detailed description of the event. Let me to summarize (in a more generic way).

A stripe of a 3-disks raid 5 is composed by

A B P

where P=A xor B

Assume a mismatch between data and parity (.e.g B is corrupted), due to an unclean shutdown
and/or a missing/reappearing of a disk. So instead of B you have B* on the platter.

Now you have two possible situation:

1) read
  If you read A everything is OK; if you read B*, the checksum mismatch and you
  can recompute B on the basis of A and P: B = A xor P.

  It seems that everything works perfectly.

2) write
  However if you want to update A to A1 (and you don't have already correct B*), you compute first
  P1 = A1 xor B*, then you write A1 and P1. This happens because in the rebuild phases the B
  checksum are not tested. (however for the metadata it should be easily implemented)

  Now you read B*, checksum mismatch but if you try a rebuild you got A1 xor P1 = B* again,
  due the previous step. So the data is lost forever.

To me it seems like the "write hole" problem which affects the raid5/6 profiles.
You have a mismatched data/parity, you don't solve it, and a subsequent partial write causes a data loss.

In this case (a detectable event) the solution is "quite" easy: if a disk became available again or a unclean
shutdown happens, a scrub must be forced before any writing.

A mismatch between data and parity happens in case of unclean shutdown and or an incomplete
write (due to a missing disk). A scrub (before any writing) is sufficient to avoid further
problem.
Of course it is a bit impractical to force a scrub on all the disk at every unclean shutdown.
However if it would be possible to reduce the area for scrub (with an intent bitmap for example),
the likelihood a data damage will have a big reduction.

The only case which would be not covered is when an unclean shutdown is followed by a missing device.


> 
> 8) We later try to read extent buffer 39043072 (the one we allocated while in
>     degraded mode), but what we get from device 3 is invalid (this extent buffer
>     belongs to a stripe of device 3, remember step 2), so
> btree_read_extent_buffer_pages()
>     triggers a recovery attempt - this happens through:
> 
>     btree_read_extent_buffer_pages() -> read_extent_buffer_pages() ->
>       -> submit_one_bio() -> btree_submit_bio_hook() -> btrfs_map_bio() ->
>         -> raid56_parity_recover()
> 
>     This attempts to rebuild stripe 2 based on stripe 1 and stripe 3 (the parity
>     stripe) by XORing the content of these last two. However the parity
> stripe was
>     recomputed at step 7 using invalid content from device 3 for stripe 2, so the
>     rebuilt stripe 2 still has invalid content for the extent buffer 39043072.
> 
> This results in the impossibility to recover an extent buffer and
> getting permanent
> metadata corruption. If the read of the extent buffer 39043072
> happened before the
> write of extent buffer 38993920, we would have been able to recover it since the
> parity stripe reflected correct content, it matched what was written in degraded
> mode at steps 2 and 3.
> 
> The same type of issue happens for data extents as well.
> 
> Since the stripe size is currently fixed at 64Kb, the issue doesn't happen only
> if the node size and sector size are 64Kb (systems with a 64Kb page size).
> 
> And we don't need to do writes in degraded mode and then mount in non-degraded
> mode with the previously missing device for this to happen (I gave the example
> of degraded mode because that's what btrfs/125 exercises).
> 
> Any scenario where the on disk content for an extent changed (some bit flips for
> example) can result in a permanently unrecoverable metadata or data extent if we
> have the bad luck of having a partial stripe write happen before an attempt to
> read and recover a corrupt extent in the same stripe.
> 
> Zygo had a report some months ago where he experienced this as well:
> 
> https://lore.kernel.org/linux-btrfs/20191119040827.GC22121@hungrycats.org/
> 
> Haven't tried his script to reproduce, but it's very likely it's due to this
> issue caused by partial stripe writes before reads and recovery attempts.
> 
> This is a problem that has been around since raid5/6 support was added, and it
> seems to me it's something that was not thought about in the initial design.
> 
> The validation/check of an extent (both metadata and data) happens at a higher
> layer than the raid5/6 layer, and it's the higher layer that orders the lower
> layer (raid56.{c,h}) to attempt recover/repair after it reads an extent that
> fails validation.
> 
> I'm not seeing a reasonable way to fix this at the moment, initial thoughts all
> imply:
> 
> 1) Attempts to validate all extents of a stripe before doing a partial write,
> which not only would be a performance killer and terribly complex, ut would
> also be very messy to organize this in respect to proper layering of
> responsabilities;
> 
> 2) Maybe changing the allocator to work in a special way for raid5/6 such that
> it never allocates an extent from a stripe that already has extents that were
> allocated by past transactions. However data extent allocation is currently
> done without holding a transaction open (and forgood reasons) during
> writeback. Would need more thought to see how viable it is, but not trivial
> either.
> 
> Any thoughts? Perhaps someone else was already aware of this problem and
> had thought about this before. Josef?

To me the biggest error is the re-adding of a disappeared devices.
However even an unclean shutdown is a potential cause of this problem.

The differences between these two situations is only the size of
the affected area.

If you don't allow a re-adding of the device without a scrub (or a full
rebuilding) you solve the first issue.

If there is the possibility  to track the last updated area (via an intent
bitmap) a scrub process could be activated on this area.

This would be a big reduction of the write hole.

> 
> Thanks.
> 

BR
G.Baroncelli


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
