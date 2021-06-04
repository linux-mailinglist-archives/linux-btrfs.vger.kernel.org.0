Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A2E39BADA
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 16:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhFDOZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 10:25:55 -0400
Received: from vps.thesusis.net ([34.202.238.73]:39630 "EHLO vps3.thesusis.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230124AbhFDOZz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Jun 2021 10:25:55 -0400
Received: by vps3.thesusis.net (Postfix, from userid 1000)
        id CF3632C7ED; Fri,  4 Jun 2021 10:23:38 -0400 (EDT)
References: <2440004.yYTOSnB24Y@shanti>
 <CAJCQCtQLYHb7G4YTmsY_cHsBHDzXM6-qQ39YNGHp2mk0mLkLEw@mail.gmail.com>
User-agent: mu4e 1.5.13; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Scrub: Uncorrectable error due to SSD read error
Date:   Fri, 04 Jun 2021 10:00:31 -0400
In-reply-to: <CAJCQCtQLYHb7G4YTmsY_cHsBHDzXM6-qQ39YNGHp2mk0mLkLEw@mail.gmail.com>
Message-ID: <874kedg13p.fsf@vps3.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Chris Murphy <lists@colorremedies.com> writes:

> Yeah here's a pretty good bet that discard is included in the btrfs
> mount option for this file system. I don't think discards happen
> without the file system issuing them, and dm-crypt and device-mapper
> for the LVM layer each have discard pass down enabled. It's frequently
> the default for LVM these days, but not dm-crypt (it is the default on
> Fedora though, for example).
>
> So the drive is not handling queued discard properly is what I
> suspect. It gets confused. Face plants. Libata then does a hard reset
> to try to get the drive to come back to reality. And then another
> discard gets issued and the drive wigs out again.

This is an interesting theory, but I was going to ask what gave you the
idea since I didn't see anything about trim or discard on my first read
through the log.  Now that I look at it again, I see some interesting
things.

[15784.497016] ata1.00: READ LOG DMA EXT failed, trying PIO
[15784.497903] ata1: failed to read log page 10h (errno=-5)

Some googling indicates that log page 10h contains detailed error
information for NCQ.  IIRC, without that, when an error happens there is
no way to know which queued command had the error, so all of them have
to assume to have failed and be retried.  Then several READ commands
with different tags are listed, indicating that they were all marked as
failed.  There is no TRIM command listed.  The drive indeed has gone out
to lunch as attempting to re-read its IDENTIFY page also fails twice,
and so a hard reset is performed to attempt to recover.  After that we
see this:

ata1.00: Enabling discard_zeroes_data

I believe that means not that a TRIM is being issued, but only that
libata noticed that the drive has the flag set in its IDENTIFY page that
means it claims that reading from a block after TRIMming it will return
zeros.

This repeats a few times before finally we see:

[15785.887214] sd 0:0:0:0: [sda] tag#25 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
[15785.887225] sd 0:0:0:0: [sda] tag#25 Sense Key : Illegal Request [current] 
[15785.887232] sd 0:0:0:0: [sda] tag#25 Add. Sense: Unaligned write command
[15785.887241] sd 0:0:0:0: [sda] tag#25 CDB: Write same(16) 93 08 00 00 00 00 1c 39 a6 30 00 00 00 40 00 00
[15785.887251] blk_update_request: I/O error, dev sda, sector
473540144 op 0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 0

One of the previously failed commands at the ATA layer was a "SEND FPDMA
QUEUED".  I'm guessing that is the discard.  I believe the scsi layer
tried to fall back to using WRITE SAME at this point to zero the
discarded blocks, but I am not sure if that previous SEND FPDMA was the
attempted WRITE SAME, or if that was the TRIM and then after that
failed, scsi tried WRITE SAME.  I think it was the former.  In that
case, I don't see where an actual TRIM was ever issued or failed to
cause scsi to call back to WRITE SAME.  Or maybe it was that at the scsi
layer, a discard is translated to a WRITE SAME command with some flag
bit set that indicates that it is really a TRIM request.  In that case,
then this was simply a discard that happened to occur this time and fail
along with the other reads.  The previous cycles all failed without the
need of a TRIM, so I think it is just happenstance that there was one
here.

Finally after another round of hard reset, the drive starts giving
normal uncorrectable read errors ( media error ).

Something else that might be worth a try is disabling NCQ.
