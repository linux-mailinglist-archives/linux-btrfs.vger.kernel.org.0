Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878864CE8A8
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 05:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiCFEHB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 23:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiCFEG7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 23:06:59 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77582673DA
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 20:06:08 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id BCA30236432; Sat,  5 Mar 2022 23:06:07 -0500 (EST)
Date:   Sat, 5 Mar 2022 23:06:07 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Remi Gauvin <remi@georgianit.com>,
        Jan Kanis <jan.code@jankanis.nl>, linux-btrfs@vger.kernel.org
Subject: Re: Is this error fixable or do I need to rebuild the drive?
Message-ID: <YiQzL1evWiPvz59Y@hungrycats.org>
References: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
 <2e9ee21e-65aa-9fb5-1d1c-1d6dea93eb12@gmx.com>
 <d3ad10fc-0e4a-a8b3-28d7-bc1957bf03ca@georgianit.com>
 <7c16b26a-e477-d6fd-d3bb-2ed7d086b1f0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c16b26a-e477-d6fd-d3bb-2ed7d086b1f0@gmx.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 05, 2022 at 02:47:31PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/5 11:11, Remi Gauvin wrote:
> > On 2022-03-04 6:39 p.m., Qu Wenruo wrote:
> > 
> > >   So by now I'm thinking that btrfs
> > > > apparently does not fix this error by itself. What's happening here,
> > > > and why isn't btrfs fixing it, it has two copies of everything?
> > > > What's the best way to fix it manually? Rebalance the data? scrub it?
> > > 
> > > Scrub it would be the correct thing to do.
> > > 
> > 
> > Correct me if I'm wrong, the statistical math is a little above my head.
> > 
> > Since the failed drive was disconnected for some time while the
> > filesystem was read write, there is potentially hundreds of thousands of
> > sectors with incorrect data.
> 
> Mostly correct.
> 
> >  That will not only make scrub slow, but
> > due to CRC collision, has a 'significant' chance of leaving some data on
> > the failed drive corrupt.
> 
> I doubt, 2^32 is not a small number, not to mention your data may not be
>  that random.
> 
> Thus I'm not that concerned about hash conflicts.

It becomes an issue after about 16 TB of unique data has been
written--then the collision probability approaches 100%.  Not much of
a problem yet, but individual disks already passed 16 TB a while ago.

> > If I understand this correctly, the safest way to fix this filesystem
> > without unnecessary chance of corrupt data is to do a dev replace of the
> > failed drive to a hot spare with the -r switch, so it is only reading
> > from the drive with the most consistent data.  This strategy requires a
> > 3rd drive, at least temporarily.
> 
> That also would be a solution.
> 
> And better, you don't need to bother a third device, just wipe the
> out-of-data device, and replace missing device with that new one.
> 
> But please note that, if your good device has any data corruption, there
> is no chance to recover that data using the out-of-date device.
> 
> Thus I prefer a scrub, as it still has a chance (maybe low) to recover.

Ideally, 'btrfs replace' would be able to replace a device with itself,
i.e. remove the restriction that the replacing device and the replaced
device can't be the same device.  This is one of the more important
management features that mdadm has which btrfs is still missing.

This form of replace should read from other disks if possible (like -r),
otherwise don't write anything on the replaced disk since we'd just be
reading the data that is already there and rewriting it in the same block.

The "run a scrub" approach doesn't work with nodatacow files, so they
end up corrupted because there's no way to tell btrfs that one drive is
definitely missing some writes and its content should not be trusted.
"Replace with same device" enables btrfs to know that nodatacow blocks on
the device are not trustworthy and should be reconstructed from mirrors,
without losing the ability to recover any other data should another device
in the filesystem fail during the replacement operation.

If it's easier to implement, some way to force an online btrfs device
offline with a mounted btrfs would be sufficient in the short term
(i.e. transition from all drives online to degraded mode with a
device removed from the filesystem).  The wipefs approach requires a
device-specific sysfs delete operation which makes it unusable with
block devices that don't provide one.

> But if you have already scrub the good device, mounted degradely without
> the bad one, and no corruption reported, then you are fine to go ahead
> with replace.
> 
> Thanks,
> Qu
> 
> > 
> > So, if /dev/sda1 is the drive that was always good, and /dev/sdb1 is the
> > drive that had taken a vacation....
> > 
> > And /dev/sdc1 is a new hot spare
> > 
> > btrfs replace start -r /dev/sdb1 /dev/sdc1
> > 
> > (On some kernel versions you might have to reboot for the replace
> > operation to finish.  But once /dev/sdb1 is completely removed, if you
> > wanted to use it again, you could
> > 
> > btrfs replace start /dev/sdc1 /dev/sdb1
> > 
