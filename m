Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7366D400B71
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Sep 2021 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhIDNL3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 4 Sep 2021 09:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhIDNL3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Sep 2021 09:11:29 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5871C061575
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Sep 2021 06:10:27 -0700 (PDT)
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a07:2600:4496:b139:ff3b:5dc0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 1727A2B45B4;
        Sat,  4 Sep 2021 15:10:26 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: It's broke, Jim. BTRFS mounted read only after corruption errors on Samsung 980 Pro
Date:   Sat, 04 Sep 2021 15:10:25 +0200
Message-ID: <10160891.dnzDEemO5X@ananda>
In-Reply-To: <20210830044550.GI29026@hungrycats.org>
References: <9070016.RUGz74dYir@ananda> <2069411.iu4ZIu9ccT@ananda> <20210830044550.GI29026@hungrycats.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Zygo.

Thank you for your hints.

Zygo Blaxell - 30.08.21, 06:45:50 CEST:
> On Thu, Aug 26, 2021 at 10:17:33AM +0200, Martin Steigerwald wrote:
[…]
> > Last time suspected XXHASH as the culprit, just a gut feeling. So I
> > used the standard crc32c. Cause I did not think of it I initially
> > used space cache
> > v1. But I switched it to space cache v2 I think yesterday.
> > 
> > Anyway it can't be xxhash cause crc32c also causes trouble.
> 
> Normally if the drive (or scheduler for that matter) was the problem,
> you would get mostly parent transid verify failed and csum errors,
> and every btrfs check error would be preceded by a csum verify
> failure.
> 
> This is not happening here, so the drive is probably fine (unless it's
> corrupting the hibernation image, but you can verify that by enabling
> hashes on the hibernation image).

My bet is also that the drive is fine.

> > My current theory is this:
> > 
> > It happens that after resume from hibernation the kernel stops
> > working correcly. A few seconds till maybe a minute or two after
> > hibernation. I captured the backtraces in the log this time. See
> > below.
> > 
> > There is some BTRFS backtrace, but it appears to be related to
> > obtaining kernel memory, and then also a general protection fault.
> > I saw general protection faults before already on this machine, but
> > never anywhere else.
> 
> That's a very bad sign.  If there are random GPFs, you'll need to take
> the machine out of production until they are resolved.  Either
> something is externally corrupting kernel RAM (like RAM failure or a
> firmware bug) or there's a bug in the kernel that is corrupting
> kernel RAM (like a use-after-free or hibernation code bug).

Yeah. I avoid hibernation for now.

> > My idea now is if the kernel crashes while BTRFS likes to write
> > something BTRFS might not be consistent afterwards.
> 
> That isn't how btrfs works.  btrfs orders writes so that if the kernel
> is operating correctly, but simply stops writing to the filesystem at
> any time, no corruption occurs (the filesystem simply reverts to the
> previously committed transaction) (assuming no raid5/6).

Or I think I did not word it clearly enough. I said "crash" but thought 
about a longer term failure scenario as you outlined below:

> A _completely different_ scenario is that the kernel's memory is
> corrupted, but the kernel does not stop immediately--it continues
> writing to the filesystem, unaware of corruption, persisting bad data
> on disk. If the kernel doesn't crash immediately, btrfs can complete
> transactions with bad metadata.  In that case, btrfs (or any
> filesystem) will be damaged, as will any data that machine touches. 
> The damage may not be repairable as it will bypass or destroy
> filesystem data integrity protections.

That is exactly what I think might have happened.

So I think there is not much of a point to keep my "homedefect" logical 
volume around. No developer asked me to do anything to obtain further 
information on the issue. If it stays like that for say another week, I 
will return the 300G for the "homedefect" LV to the wear leveling pool 
of the SSD.

> > I still think it shall survive
> > a sudden interruption when writting data even if the cause for that
> > is a kernel crash, but as Linux is a monolithic kernel, whatever
> > has caused the kernel mal function may affect BTRFS as well.
> 
> It doesn't matter if the kernel is monolithic.  RAM is monolithic.
> RAM corruption, however caused, can and will break everything in RAM,
> whether it is kernel, userspace, or firmware.

I think it could matter in case of a software bug, i.e. another kernel 
component accidentally writing into memory BTRFS uses. This would be 
prevented by a micro kernel.

> > So what I will try next is to shutdown the machine after each day or
> > just
> > keep it in standby and hope the battery will not take damage from
> > it. In other words I will aim at avoiding hibernation. Its hard for
> > me. I use it
> > on all of my laptops and now I have the fastest laptop I ever had so
> > far,
> > but I cannot seem to use it reliably anymore. The faster the laptop,
> > the faster it crashes if it does, so to say.
> > 
> > Any other ideas, theories, hints?
> 
> Start a memory tester running (e.g. 'memtester' or '7z b 9999 -md=xxM'
> where xx is large enough to allocate most of the free RAM), do
> hibernation and resume, and see if the memory tester reports failure
> after resume.

I may still do this. However I already run the UEFI Lenovo Diagnostic 
tool and had it do a memory test. It appears to be fine. I did the quick 
test but then also ran a good part, but not all of a several hour long 
test. No issues.

> If so, you have firmware data integrity issues, or there is a bug in
> the hibernation code.
> 
> Use suspend-to-RAM as a workaround (unless that corrupts memory too).

Yeap, that is what I am using at the moment. It does not seem to corrupt 
memory. So without hibernation and without the USB-C dock which 
triggered all kinds of issues with network driver for that r8152 card in 
there and all kind of other strange issues, the laptop appears to finally 
be stable. Seems for AMD based Gen 1 ThinkPads, I bet Gen 2 as well 
there is still some R&D needed to get them stable in these situations as 
well.

Best,
-- 
Martin


