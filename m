Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B24201CD4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 23:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391431AbgFSVDN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 19 Jun 2020 17:03:13 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38062 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389872AbgFSVDM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 17:03:12 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A54B37231E9; Fri, 19 Jun 2020 17:03:04 -0400 (EDT)
Date:   Fri, 19 Jun 2020 17:03:04 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Daniel Smedegaard Buus <danielbuus@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Behavior after encountering bad block
Message-ID: <20200619210302.GO10769@hungrycats.org>
References: <CAHnuAezOHbwpuVM6=bJRRtORpdHy=rVPFD+jeAQVz3xUTEsUpQ@mail.gmail.com>
 <20200619124505.586f2b63@natsu>
 <CAHnuAez0+4LR=Z=+z-bFFj2Z=Jf24YCHZ3CjHGwgsSn8mZU1eA@mail.gmail.com>
 <20200619143148.1ec669e9@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200619143148.1ec669e9@natsu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 19, 2020 at 02:31:48PM +0500, Roman Mamedov wrote:
> On Fri, 19 Jun 2020 10:08:43 +0200
> Daniel Smedegaard Buus <danielbuus@gmail.com> wrote:
> 
> > Well, that's why I wrote having the *data* go bad, not the drive
> 
> But data going bad wouldn't pass unnoticed like that (with reads resulting in
> bad data), since drives have end-to-end CRC checking, including on-disk and
> through the SATA interface. 

Some bespoke SAN drives have proprietary firmware and wire protocols that
pass the CRC data in-band from the platter to the host for verification
(the READ and WRITE commands carry extra bytes for the CRC, so a disk
sector is 520 or 4104 bytes long).  This is a true end-to-end CRC check,
but this is not a complete data integrity solution because it only
contributes protection against data corruption while the data is inside
the disk controller.  It has no impact on any of the other silent data
corruption failure modes.

If your drive just passes 512 or 4096-byte sectors to the host, then
there is no end-to-end checking.  It is only piecemeal, partial coverage
of individual segments in the data path, with no way to detect corruption
at points in between.

> If data on-disk is somehow corrupted, that will be
> a CRC failure on read, and still an I/O error for the host.

In my data set, about 1 in 20 failing disks silently corrupt some data
without indicating the data is bad.  No disk is immune to this kind
of failure, from cheap consumer SSDs to enterprise HDDs with bespoke
firmware for proprietary SAN boxes.  Failing drives do not respect the
boundaries of expected non-failing drive behavior.

About a third of silent data corruptions in spinning disks were DRAM
failures.  SSDs and HDDs use DRAM in their embedded controller boards, and
that DRAM fails at the same rate as any other commercially available DRAM.
ECC RAM in disk controllers is the most expensive and least effective way
to improve data integrity in the storage stack, so no rational vendor
offers it.

Another third of the data errors are failures related to write caching.
In these failures the contents of the write cache will be discarded after
the data was reported flushed, and later reads to discarded sectors will
return old data.  This event can be triggered by several different causes,
depending on what faults the firmware can detect and recover from and
what bugs are present in the firmware.  These failures share a defining
characteristic: they can be prevented by disabling write cache.

The remaining third are assorted bugs (botched UNC sector remappings,
write to wrong track, "magic" LBA bugs, firmware recalls, bad SSDs,
bad cables, bad power, misconfigured bus timeout/SCTERC settings,
and mishandled bus resets) or some uncategorizable mix of multiple
simultaneous failure modes.  Some of these are coincident with other
indicators of failure (e.g. unexpected SATA bus timeouts or resets), but
not IO errors during read or write operations to the specific sectors
that are corrupted.  Some of these are not drive failures per se, but
failures in adjacent parts of the system that cause the drive to 
operate improperly, corrupting data and suppressing error reports.

The other 19 out of 20 failing drives report IO errors as expected, or
fail to spin up at all.  Those failure cases are trivial.  Even mdadm
handles them easily.

> I only heard of some bad SSDs (SiliconMotion-based) returning corrupted data
> as if nothing happened, and only when their flash lifespan is close to
> depletion.

Kingston and Sandisk SSDs silently corrupt data starting as early as 20%
of rated TBW.  After some experimenting with them, I don't believe their
firmware is capable of detecting data integrity errors at any point in
their lifespan.

You can put a btrfs on one of these SSDs with DUP data and DUP metadata,
and watch it play whack-a-mole as it self-repairs the csum errors
that pop up all over the filesystem, until eventually the SSD dies.

> > even though either scenario should still effectively end up yielding the
> > same behavior from btrfs
> 
> I believe that's also an assumption you'd want to test, if you want to be
> through in verifying its behavior on failures or corruptions. And anyways it's
> better to set up a scenario which is as close as possible to ones you'd get in
> real-life.
> 
> > But check out my retraction reply from earlier — it was just me being stupid
> > and forgetting to use conv=notrunc on my dd command used to damage the
> > loopback file :)
> 
> Sure, I only commented on the part where it still made sense. :)
> 
> -- 
> With respect,
> Roman
