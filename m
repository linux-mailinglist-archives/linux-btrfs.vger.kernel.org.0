Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EFA400D8E
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Sep 2021 01:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhIDXjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Sep 2021 19:39:46 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48610 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhIDXjp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Sep 2021 19:39:45 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id F1B51B6361F; Sat,  4 Sep 2021 19:38:42 -0400 (EDT)
Date:   Sat, 4 Sep 2021 19:38:42 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: It's broke, Jim. BTRFS mounted read only after corruption errors
 on Samsung 980 Pro
Message-ID: <20210904233842.GD27656@hungrycats.org>
References: <9070016.RUGz74dYir@ananda>
 <2069411.iu4ZIu9ccT@ananda>
 <20210830044550.GI29026@hungrycats.org>
 <10160891.dnzDEemO5X@ananda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10160891.dnzDEemO5X@ananda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 04, 2021 at 03:10:25PM +0200, Martin Steigerwald wrote:
> Hi Zygo.
> 
> Thank you for your hints.
> 
> Zygo Blaxell - 30.08.21, 06:45:50 CEST:
> > On Thu, Aug 26, 2021 at 10:17:33AM +0200, Martin Steigerwald wrote:
> […]
> > > Last time suspected XXHASH as the culprit, just a gut feeling. So I
> > > used the standard crc32c. Cause I did not think of it I initially
> > > used space cache
> > > v1. But I switched it to space cache v2 I think yesterday.
> > > 
> > > Anyway it can't be xxhash cause crc32c also causes trouble.
> > 
> > Normally if the drive (or scheduler for that matter) was the problem,
> > you would get mostly parent transid verify failed and csum errors,
> > and every btrfs check error would be preceded by a csum verify
> > failure.
> > 
> > This is not happening here, so the drive is probably fine (unless it's
> > corrupting the hibernation image, but you can verify that by enabling
> > hashes on the hibernation image).
> 
> My bet is also that the drive is fine.
> 
> > > My current theory is this:
> > > 
> > > It happens that after resume from hibernation the kernel stops
> > > working correcly. A few seconds till maybe a minute or two after
> > > hibernation. I captured the backtraces in the log this time. See
> > > below.
> > > 
> > > There is some BTRFS backtrace, but it appears to be related to
> > > obtaining kernel memory, and then also a general protection fault.
> > > I saw general protection faults before already on this machine, but
> > > never anywhere else.
> > 
> > That's a very bad sign.  If there are random GPFs, you'll need to take
> > the machine out of production until they are resolved.  Either
> > something is externally corrupting kernel RAM (like RAM failure or a
> > firmware bug) or there's a bug in the kernel that is corrupting
> > kernel RAM (like a use-after-free or hibernation code bug).
> 
> Yeah. I avoid hibernation for now.
> 
> > > My idea now is if the kernel crashes while BTRFS likes to write
> > > something BTRFS might not be consistent afterwards.
> > 
> > That isn't how btrfs works.  btrfs orders writes so that if the kernel
> > is operating correctly, but simply stops writing to the filesystem at
> > any time, no corruption occurs (the filesystem simply reverts to the
> > previously committed transaction) (assuming no raid5/6).
> 
> Or I think I did not word it clearly enough. I said "crash" but thought 
> about a longer term failure scenario as you outlined below:
> 
> > A _completely different_ scenario is that the kernel's memory is
> > corrupted, but the kernel does not stop immediately--it continues
> > writing to the filesystem, unaware of corruption, persisting bad data
> > on disk. If the kernel doesn't crash immediately, btrfs can complete
> > transactions with bad metadata.  In that case, btrfs (or any
> > filesystem) will be damaged, as will any data that machine touches. 
> > The damage may not be repairable as it will bypass or destroy
> > filesystem data integrity protections.
> 
> That is exactly what I think might have happened.
> 
> So I think there is not much of a point to keep my "homedefect" logical 
> volume around. No developer asked me to do anything to obtain further 
> information on the issue. If it stays like that for say another week, I 
> will return the 300G for the "homedefect" LV to the wear leveling pool 
> of the SSD.
> 
> > > I still think it shall survive
> > > a sudden interruption when writting data even if the cause for that
> > > is a kernel crash, but as Linux is a monolithic kernel, whatever
> > > has caused the kernel mal function may affect BTRFS as well.
> > 
> > It doesn't matter if the kernel is monolithic.  RAM is monolithic.
> > RAM corruption, however caused, can and will break everything in RAM,
> > whether it is kernel, userspace, or firmware.
> 
> I think it could matter in case of a software bug, i.e. another kernel 
> component accidentally writing into memory BTRFS uses. This would be 
> prevented by a micro kernel.

Depends on the bug and the microkernel.  Microkernels are not immune to
corruption bugs, though some specific paths leading to corruption are
blocked.  e.g. instead of memcpy() with a bad pointer, it's a device
driver process calculating the wrong physical address for a DMA write.

Also, regardless of kernel implementation, the hibernation procedure
is extremely _invasive_.  It necessarily transports every process and
significant chunks of kernel state to disk and back to memory, and has
opportunities to corrupt data in transit or at rest.

> > > So what I will try next is to shutdown the machine after each day or
> > > just
> > > keep it in standby and hope the battery will not take damage from
> > > it. In other words I will aim at avoiding hibernation. Its hard for
> > > me. I use it
> > > on all of my laptops and now I have the fastest laptop I ever had so
> > > far,
> > > but I cannot seem to use it reliably anymore. The faster the laptop,
> > > the faster it crashes if it does, so to say.
> > > 
> > > Any other ideas, theories, hints?
> > 
> > Start a memory tester running (e.g. 'memtester' or '7z b 9999 -md=xxM'
> > where xx is large enough to allocate most of the free RAM), do
> > hibernation and resume, and see if the memory tester reports failure
> > after resume.
> 
> I may still do this. However I already run the UEFI Lenovo Diagnostic 
> tool and had it do a memory test. It appears to be fine. I did the quick 
> test but then also ran a good part, but not all of a several hour long 
> test. No issues.

The environment might be different for a stand-alone memory tester
compared to one that can run on Linux alongside a production workload.
e.g. if a bus component is failing due to heat stress, that failure might
not be triggered in the standalone case where the failing bus componenet
is inactive, but will be triggered under a full system load where the
failing component is active.  Similarly bugs in the Linux kernel itself,
or interactions between kernel and firmware, will not be visible with
a standalone test.

On the other hand, if the problem _is_ a RAM component failure, a
standalone test will verify it's that and nothing else.

> > If so, you have firmware data integrity issues, or there is a bug in
> > the hibernation code.
> > 
> > Use suspend-to-RAM as a workaround (unless that corrupts memory too).
> 
> Yeap, that is what I am using at the moment. It does not seem to corrupt 
> memory. So without hibernation and without the USB-C dock which 
> triggered all kinds of issues with network driver for that r8152 card in 
> there and all kind of other strange issues, the laptop appears to finally 
> be stable. Seems for AMD based Gen 1 ThinkPads, I bet Gen 2 as well 
> there is still some R&D needed to get them stable in these situations as 
> well.
> 
> Best,
> -- 
> Martin
> 
> 
> 
