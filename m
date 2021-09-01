Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325623FD299
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 06:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbhIAEzB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 00:55:01 -0400
Received: from omta012.uswest2.a.cloudfilter.net ([35.164.127.235]:45494 "EHLO
        omta012.uswest2.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230483AbhIAEzA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Sep 2021 00:55:00 -0400
Received: from cxr.smtp.a.cloudfilter.net ([10.0.17.148])
        by cmsmtp with ESMTP
        id L7OQmW5LHeXrBLIGBms807; Wed, 01 Sep 2021 04:54:03 +0000
Received: from ws ([24.255.45.226])
        by cmsmtp with ESMTPSA
        id LIGAmSNd2KYuOLIGAmcRTO; Wed, 01 Sep 2021 04:54:03 +0000
Authentication-Results: cox.net; auth=pass (LOGIN)
 smtp.auth=1i5t5.duncan@cox.net
X-Authority-Analysis: v=2.4 cv=b63RXvKx c=1 sm=1 tr=0 ts=612f076b
 a=rsvNbDP3XdDalhZof1p64w==:117 a=rsvNbDP3XdDalhZof1p64w==:17
 a=kj9zAlcOel0A:10 a=1SD6Td3LhPHhN1caRMoA:9 a=CjuIK1q_8ugA:10
Date:   Tue, 31 Aug 2021 21:54:01 -0700
From:   Duncan <1i5t5.duncan@cox.net>
To:     Andrej Friesen <andre.friesen@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Questions about BTRFS balance and scrub on non-RAID setup
Message-ID: <20210831215401.6928aeef@ws>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfD0uRw8gLpQH1c4hE6Z2Y3eHO3oCvc0LZwC7xqER2qWGrNSi1LvlPu4lcQlh00IcQ6dHhPsgQLT/2UMEEPWgPP9sVeJLaxQf+XXhDhxw9gvzACwPwbtu
 133UkE2GBirMt0zDGOeuXlRXdeIYtjnbjwKw1MTGOjckozUr0O/y8E5N/ZtDFUmBl+XwsADHIAh/8draBxeXHep5plJsYx6sR5R/9hkr8vdTfwilzImvjNgK
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Andrej Friesen posted on Tue, 31 Aug 2021 10:17:07 +0200 as excerpted:

>> You probably want to use autodefrag or a custom defragmentation
>> solution too. We weren't satisfied with autodefrag in some situations
>> (were clearly fragmentation crept in and IO performance suffered
>> until a manual defrag) and developed our own scheduler for triggering
>> defragmentation based on file writes and slow full filesystem scans,
> 
> The ceph cluster only uses SSDs therefore I guess we do not suffer
> from fragmentation problem as with HDDs. As far as I understood SSDs.

Since I saw mention of btrfs snapshots as well...

It's worth mentioning that defrag (of course) triggers a write-out of
the new defragmented data, which because btrfs snapshots are cow-based
(copy- on-write), duplicates blocks still locked into place by existing 
snapshots.  With rewrite-in-place write patterns (typical
write-patterns for database or VM image usage), defrag and repeated
snapshots this can eat up space rather fast.

(They tried snapshot-aware defrag at one point but due to the exploded 
complexity of dealing with all the COW-references the performance just 
wasn't within the realm of practical as the defrag ended up making
little forward progress, so that was dropped in favor of a defrag that
would break the cow-references and thus use extra space, but at least
/worked/ for its labeled purpose.)

So I'd suggest choosing either one or the other, either snapshotting or 
defrag, don't try to use both in combination, or at least limit their 
usage in combination and keep an eye on space usage, deleting snapshots 
and/or reducing defrag frequency to some fraction of the snapshot 
frequency as necessary.

For ssds, autodefrag without manual defrag may be a reasonable
compromise (it's one I like personally but my use-case isn't
commercial), tho it is said that autodefrag may be a performance
bottleneck for some database (and I suspect VM-image as well)
use-cases, but I suspect autodefrag on ssds should both mitigate the
performance issue and likely eliminate the need for more intensive
manual/scheduled defrag runs.

The other thing to consider with below-btrfs-level snapshotting, and
I'm out-of-league for ceph/rdb but know it's definitely a problem with
lvm, is that btrfs due to its multi-device functionality cannot be
allowed to see other snapshots of the filesystem with the same btrfs
UUID.  (Btrfs- scan is what would make btrfs aware of them, but udev
typically triggers btrfs-scan when it detects new devices, and with lvm
at least, udev device detection can trigger somewhat unexpectedly.)
Because when btrfs sees these other devices with the same btrfs UUID,
it considers them additional devices of a multi-device btrfs and can
attempt to write to them instead of the original target device,
potentially creating all sorts of mayhem!

Like I said I'm out-of-league with ceph, etc, and have no idea if this 
even applies with it, but when I saw rdb snapshots mentioned I thought
of the lvm snapshots problem and thought it was worth a heads-up, in
case further investigation is necessary.

Likewise I saw the mention of quotas and balance.  Balance with quotas 
running similarly explodes due to constant recalculation of the quota
as the balance does its thing, increasing balance time dramatically and 
often out of the realm of the practical.  So if quotas are needed, 
minimize the use of balance, and if a balance is necessary, turning off 
quotas temporarily may be the only way to make reasonable forward 
progress on the balance.

But it sounds like btrfs quotas may not be necessary, thus avoiding
that problem entirely. =:^)

-- 
Duncan - List replies preferred.   No HTML msgs.
"Every nonfree program has a lord, a master --
and if you use the program, he is your master."  Richard Stallman
