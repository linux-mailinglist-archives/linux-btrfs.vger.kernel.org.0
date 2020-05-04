Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54841C4A09
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 01:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgEDXJF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 4 May 2020 19:09:05 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46680 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgEDXJF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 May 2020 19:09:05 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 596E36A5FAA; Mon,  4 May 2020 19:08:58 -0400 (EDT)
Date:   Mon, 4 May 2020 19:08:58 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Rich Rauenzahn <rrauenza@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Western Digital Red's SMR and btrfs?
Message-ID: <20200504230857.GQ10769@hungrycats.org>
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 01, 2020 at 10:24:57PM -0700, Rich Rauenzahn wrote:
> Has there been any btrfs discussion off the list (I haven't seen any
> SMR/shingled mails in the archive since 2016 or so) regarding the news
> that WD's Red drives are actually SMR?
> 
> I'm using these reds in my btrfs setup (which is 2-3 drives in RAID1
> configuration, not parity based RAIDs.)   I had noticed that adding a
> new drive took a long time, but other than than, I haven't had any
> issues that I know of.  They've lasted quite a long time, although I
> think my NAS would be considered more of a cold storage/archival.
> Photos and Videos.

The basic problem with DM-SMR drives is that they cache writes in CMR
zones for a while, but they need significant idle periods (no read or
write commands from the host) to move the data back to SMR zones, or
they run out of CMR space and throttle writes from the host.

Some kinds of RAID rebuild don't provide sufficient idle time to complete
the CMR-to-SMR writeback, so the host gets throttled.  If the drive slows
down too much, the kernel times out on IO, and reports that the drive
has failed.  The RAID system running on top thinks the drive is faulty
(a false positive failure) and the fun begins (hope you don't have two
of these drives in the same array!).

NAS CMR drives in redundant RAID arrays should be configured to fail
fast--complete iops within 7 seconds.  This is the smartctl scterc command
that you may have seen on various RAID admin guides.  The default idle
timeout for the Linux kernel is 30 seconds, so NAS drives work fine.

Desktop CMR drives (which are not good in RAID arrays but people use
them anyway) have firmware hardcoded to retry reads for about 120
seconds before giving up.  To use desktop CMR drives in RAID arrays,
you must increase the Linux kernel IO timeout to 180 seconds or risk
false positive rejections (i.e. multi-disk failures) from RAID arrays.

Note that both desktop and NAS CMR drives have similar expected write
latencies in non-error cases, both on the order of a few milliseconds.
We only see the multi-minute latencies in error cases, e.g. if there's
a bad sector or similar drive failure, and those are rare events.

Now here is the problem:  DM-SMR drives have write latencies of up to 300
seconds in *non-error* cases.  They are up to 10,000 times slower than
CMR in the worst case.  Assume that there's an additional 120 seconds
for error recovery on top of the non-error write latency, and add the
extra 50% for safety, and the SMR drive should be configured with a
630 second timeout (10.5 minutes) in the Linux kernel to avoid false
positive failures.

Similarly, if you're serving network clients, their timeouts have to be
increased as well, usually many times larger because there's going to
be full host IO queues to these very slow drives.  It means a desktop
client user on your file server could be presented with an hourglass
for an hour when they click on a folder, or, more likely, just an error.

> Is btrfs raid1 going to be the sweet spot on these drives?

It depends.  You can probably use it normally and run scrubs on it.
Replace probably works OK if the drive firmware is sane.  You may have
problems with remove, resize and balance operations especially on metadata
block groups.  Definitely set the timeouts to nice high values (I'd use
15 minutes just to be sure) and be prepared to ride out some epic delays.
The array may be theoretically working, but unusable in practice.

> If I start swapping these out -- is there a recommended low power
> drive?  I'd buy the red pro's, but they spin faster and produce more
> heat and noise.

I've tested several low-power drives but can't recommend any of them
for NAS use (no SCTERC, short warranty, firmware bugs, and/or high
failure rate).  Red Pro, Gold, Ultrastar, and Ironwolf have been OK so
far, but as you point out, they're all 7200 rpm class drives.

> Rich
