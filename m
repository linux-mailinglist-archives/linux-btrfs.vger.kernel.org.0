Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC9455628
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 19:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfFYRqg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 13:46:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:37186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729493AbfFYRqf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 13:46:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB517AD8A
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2019 17:46:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DD02DDA8F6; Tue, 25 Jun 2019 19:47:15 +0200 (CEST)
Date:   Tue, 25 Jun 2019 19:47:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] RAID1 with 3- and 4- copies
Message-ID: <20190625174712.GV8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1559917235.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559917235.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 10, 2019 at 02:29:40PM +0200, David Sterba wrote:
> Hi,
> 
> this patchset brings the RAID1 with 3 and 4 copies as a separate
> feature as outlined in V1
> (https://lore.kernel.org/linux-btrfs/cover.1531503452.git.dsterba@suse.com/).
> 
> This should help a bit in the raid56 situation, where the write hole
> hurts most for metadata, without a block group profile that offers 2
> device loss resistance.
> 
> I've gathered some feedback from knowlegeable poeople on IRC and the
> following setup is considered good enough (certainly better than what we
> have now):
> 
> - data: RAID6
> - metadata: RAID1C3
> 
> The RAID1C3 vs RAID6 have different characteristics in terms of space
> consumption and repair.
> 
> 
> Space consumption
> ~~~~~~~~~~~~~~~~~
> 
> * RAID6 reduces overall metadata by N/(N-2), so with more devices the
>   parity overhead ratio is small
> 
> * RAID1C3 will allways consume 67% of metadata chunks for redundancy
> 
> The overall size of metadata is typically in range of gigabytes to
> hundreds of gigabytes (depends on usecase), rough estimate is from
> 1%-10%. With larger filesystem the percentage is usually smaller.
> 
> So, for the 3-copy raid1 the cost of redundancy is better expressed in
> the absolute value of gigabytes "wasted" on redundancy than as the
> ratio that does look scary compared to raid6.
> 
> 
> Repair
> ~~~~~~
> 
> RAID6 needs to access all available devices to calculate the P and Q,
> either 1 or 2 missing devices.
> 
> RAID1C3 can utilize the independence of each copy and also the way the
> RAID1 works in btrfs. In the scenario with 1 missing device, one of the
> 2 correct copies is read and written to the repaired devices.
> 
> Given how the 2-copy RAID1 works on btrfs, the block groups could be
> spread over several devices so the load during repair would be spread as
> well.
> 
> Additionally, device replace works sequentially and in big chunks so on
> a lightly used system the read pattern is seek-friendly.
> 
> 
> Compatibility
> ~~~~~~~~~~~~~
> 
> The new block group types cost an incompatibility bit, so old kernel
> will refuse to mount filesystem with RAID1C3 feature, ie. any chunk on
> the filesystem with the new type.
> 
> To upgrade existing filesystems use the balance filters eg. from RAID6
> 
>   $ btrfs balance start -mconvert=raid1c3 /path
> 
> 
> Merge target
> ~~~~~~~~~~~~
> 
> I'd like to push that to misc-next for wider testing and merge to 5.3,
> unless something bad pops up. Given that the code changes are small and
> just a new types with the constraints, the rest is done by the generic
> code, I'm not expecting problems that can't be fixed before full
> release.
> 
> 
> Testing so far
> ~~~~~~~~~~~~~~
> 
> * mkfs with the profiles
> * fstests (no specific tests, only check that it does not break)
> * profile conversions between single/raid1/raid5/raid1c3/raid6/raid1c4/raid1c4
>   with added devices where needed
> * scrub
> 
> TODO:
> 
> * 1 missing device followed by repair
> * 2 missing devices followed by repair

Unfortunatelly neither of the two cases works as expected and I don't have time
to fix it for the 5.3 deadline. As the 3-copy is supposed to be a replacement
for raid6, I consider the lack of repair capability to be a show stopper so the
main part of the patchset is postponed.

The test I did was something like this:

- create fs with 3 devices, raid1c3
- fill with some data
- unmount
- wipe 2nd device
- mount degraded
- replace missing
- remount read-write, write data to verify that it works
- unmount
- mount as usual   <-- here it fails and the device is still reported missing

The same happens for the 2 missing devices.
