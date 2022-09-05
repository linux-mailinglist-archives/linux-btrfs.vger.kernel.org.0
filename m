Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3DD5ACB2C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 08:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiIEGed (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 02:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiIEGeP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 02:34:15 -0400
Received: from straasha.imrryr.org (straasha.imrryr.org [100.2.39.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F130D3336A
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Sep 2022 23:33:43 -0700 (PDT)
Received: by straasha.imrryr.org (Postfix, from userid 1001)
        id B2C941067C4; Mon,  5 Sep 2022 02:33:15 -0400 (EDT)
Date:   Mon, 5 Sep 2022 02:33:15 -0400
From:   Viktor Dukhovni <btrfs@dukhovni.org>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Fedora 36, grub2, UEFI: booting after adding 2nd disk to root?
Message-ID: <YxWYK1cc7oKKwHvi@straasha.imrryr.org>
Reply-To: linux-btrfs@vger.kernel.org
References: <YxTZ0VCbkFkuoHzd@straasha.imrryr.org>
 <5929d570-f387-4fa3-a246-bb7dabefdfb3@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5929d570-f387-4fa3-a246-bb7dabefdfb3@www.fastmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 04, 2022 at 04:59:12PM -0400, Chris Murphy wrote:

> > After installation I naively added nvme1n1p2 to the root btrfs hoping to
> > extend the root fsit over both disks (not RAID1, just concat or stripe).
> >
> >     # btrfs device nvme1n1p2 /
> 
> 
> # btrfs device add /dev/nvme1n1p2 /

Yes, sorry, of course "add".

> > expecting this to be handled trasparently.  After a bit more
> > housekeeping I attempted to reboot the system, and it failed to boot.
> 
> What does happen? What's the last moment of normal boot and the first
> unexpected messages of the failure?

It turns out (once hands-on help arrived) that the machine did boot, but
for some mysterious reason failed to detect the network cards.  Which is
not a btrfs issue, so as you note the "UUID" is sufficient to find all
the devices.

> > * Is it possible/best to create such a multi-device btrfs rootfs at Fedora 36
> >   install time?  Will the installer manage to set up grub2 correctly in
> >   that case?
> 
> You can do it at installation time if you choose both drives for
> installation. Using the default "automatic" partitioning option, the
> installer will do a default mkfs.btrfs on the two NVMe partitions,
> resulting in single profile data, and raid1 profile for metadata.
> You'd need to use Custom partitioning to choose raid1 for data, but it
> sounds like you don't want that anyway so you can just do an automatic
> installation with both drives selected.

I went with "raid0" for data, manually after the install.

> > * A secondary question: To split off /home, /var/log and /var/spool into
> >   separate subvoluments, should these be nested or top-level?  
> 
> Anaconda creates subvolumes in the top-level of the file system
> anytime you create explicit mount-points in the Custom or
> Advanced-Custom partitioning UI. And they follow a simple / becomes _
> naming system so it'll be var_log and var_spool for the subvolume
> names.

Thanks.

> >   Naive attempts to create the subvolumes makes them nested,
> >   perhaps because I don't have an empty unmounted top-level volume?
> 
> To do this manually, you need to mount the btrfs file system, e.g. at
> /mnt, without any mount options. It'll have its top-level mounted, and
> you'll see the subvolumes in /mnt, looking like they're directories.

Thanks for the confirmation, eventually also figured it out.

> > * And finally, the free space is intended for a Postgres database
> >   using most of the space on the two disks.  Would a suitably tuned
> >   subvolme be a good choice, or would ext4 or xfs be more prudent
> >   (and performant?).
> 
> It really depends on the workload of the database. How big is it, how
> busy is it, is it compressible? Etc. You might find the performance is
> OK if you enable WAL, and the workload isn't significant.

The database is presently ~200GB and growing gradually, but could grow
roughly 5x over the next year if anticipated external events take place.
I'll see how btrfs works out.  I did disable datacow and compression.

-- 
    Viktor.
