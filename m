Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10813204E63
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 11:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbgFWJsb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 05:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731921AbgFWJsb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 05:48:31 -0400
Received: from smtp.sws.net.au (smtp.sws.net.au [IPv6:2a01:4f8:140:71f5::dada:cafe])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F1FC061573
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jun 2020 02:48:31 -0700 (PDT)
Received: from liv.localnet (unknown [103.75.204.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: russell@coker.com.au)
        by smtp.sws.net.au (Postfix) with ESMTPSA id 6FDCC156AD;
        Tue, 23 Jun 2020 19:48:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1592905709;
        bh=+p87W1uTRQ0YWurjTngyM30bauX5FnrNoh8wPdZc1ic=; l=5999;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgMrkH923RCVi1YpNFVpU0llCIF0lV5NFKUgWxkcRU9hxkKJTwkAtX3q16o0E+tGn
         u8XJUjKRHcyO6AjZmjNAkRdIPC1dRnc1sv1RF+8KHFDA+IrxYzK1EA/U8YR6KRZEBt
         B9oyacWOJt/xfGhGnN4vgPZ+fmklk9Q/2N5K1CCM=
From:   Russell Coker <russell@coker.com.au>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs dev sta not updating
Date:   Tue, 23 Jun 2020 19:48:24 +1000
Message-ID: <6248217.VoG1EAXHid@liv>
In-Reply-To: <d4c28f49-f6fc-0fc7-0c4d-4fe8b3ce32a9@suse.com>
References: <4857863.FCrPRfMyHP@liv> <5752066.y3qnG1rHMR@liv> <d4c28f49-f6fc-0fc7-0c4d-4fe8b3ce32a9@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tuesday, 23 June 2020 6:17:00 PM AEST Nikolay Borisov wrote:
> > In this case I'm getting application IO errors and lost data, so if the
> > error count is designed to not count recovered errors then it's still not
> > doing the right thing.
> 
> In this case yes, however this was utterly not clear from your initial
> email. In fact it seems you have omitted quite a lot of information. So
> let's step back and start afresh. So first give information about your
> current btrfs setup by giving the output of:
> 
> btrfs fi usage /path/to/btrfs

# btrfs fi usa .
Overall:
    Device size:                  62.50GiB
    Device allocated:             19.02GiB
    Device unallocated:           43.48GiB
    Device missing:                  0.00B
    Used:                         16.26GiB
    Free (estimated):             44.25GiB      (min: 22.51GiB)
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:               17.06MiB      (used: 0.00B)

Data,single: Size:17.01GiB, Used:16.23GiB (95.43%)
   /dev/sdc1      17.01GiB

Metadata,DUP: Size:1.00GiB, Used:17.19MiB (1.68%)
   /dev/sdc1       2.00GiB

System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
   /dev/sdc1      16.00MiB

Unallocated:
   /dev/sdc1      43.48GiB

> From the output provided it seems the affected mirror is '1', which to
> me implies you have at least another disk containing the same data. So
> unless you have errors in mirror 0 as well those errors should be
> recovered from by simply reading from that mirror.
> 
> > # md5sum *
> > md5sum: 'Rise of the Machines S1 Ep6 - Mega Digger-qcOpMtIWsrgN.mp4':
> > Input/ output error
> > md5sum: 'Rise of the Machines S1 Ep7 - Ultimate
> > Dragster-Ke9hMplfQAWF.mp4':
> > Input/output error
> > md5sum: 'Rise of the Machines S1 Ep8 - Aircraft Carrier-Qxht6qMEwMKr.mp4':
> > Input/output error
> > ^C
> 
> You are trying to md5sum 3 distinct files....

There's more files, some of the files were read correctly.

> > # btrfs dev sta .
> > [/dev/sdc1].write_io_errs    0
> > [/dev/sdc1].read_io_errs     0
> > [/dev/sdc1].flush_io_errs    0
> > [/dev/sdc1].corruption_errs  0
> > [/dev/sdc1].generation_errs  0
> > # tail /var/log/kern.log
> > Jun 23 17:48:40 xev kernel: [417603.547748] BTRFS warning (device sdc1):
> > csum failed root 5 ino 275 off 59580416 csum 0x8941f998 expected csum
> > 0xb5b581fc mirror 1
> > Jun 23 17:48:40 xev kernel: [417603.609861] BTRFS warning (device sdc1):
> > csum failed root 5 ino 275 off 60628992 csum 0x8941f998 expected csum
> > 0x4b6c9883 mirror 1
> > Jun 23 17:48:40 xev kernel: [417603.672251] BTRFS warning (device sdc1):
> > csum failed root 5 ino 275 off 61677568 csum 0x8941f998 expected csum
> > 0x89f5fb68 mirror 1
> 
> Yet here all the errors happen in one inode, namely 275. So the md5sum
> commands do not correspond to those errors specifically. Also provide
> the name of inode 275. And for good measure also provide the output of
> "btrfs check /dev/sdc1" - this is a read only command so if there is
> some metadata corruption it will at least not make it any worse.

# ls -li /mnt/tmp|grep 275
275 -rw-r--r--. 1 root root  507979219 Jun  3 11:05 Rise of the Machines S1 
Ep8 - Aircraft Carrier-Qxht6qMEwMKr.mp4
# umount /mnt/tmp
# btrfs check /dev/sdc1
Opening filesystem to check...
Checking filesystem on /dev/sdc1
UUID: 841b569f-63ab-477f-b603-64e4e4339146
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 17446019072 bytes used, no error found
total csum bytes: 17014904
total tree bytes: 18038784
total fs tree bytes: 81920
total extent tree bytes: 114688
btree space waste bytes: 669647
file data blocks allocated: 17427980288
 referenced 17427980288

I don't mind about making problems worse, there is no precious data on that 
device, just downloads of some TV shows which are also stored elsewhere.  But 
I don't want to have such problems happen to more important data.

> > On Tuesday, 23 June 2020 5:11:05 PM AEST Nikolay Borisov wrote:
> >> read_io_errs. But this leads to a different can of worms - if a user
> >> sees read_io_errs should they be worried because potentially some data
> >> is stale or not (give we won't be distinguishing between unrepairable vs
> >> transient ones).
> > 
> > If a user sees errors reported their degree of worry should be based on
> > the
> > degree to which they use RAID and have decent backups.  If you have RAID-1
> > and only 1 device has errors then you are OK.  If you have 2 devices with
> > errors then you have a problem.
> > 
> > Below is an example of a zpool having errors that were corrected.  The
> > DEVICE had an unrecoverable error, but the RAID-Z pool recovered it from
> > other devices.  It states that "Applications are unaffected" so the user
> > knows the degree of worry that should be involved.
> 
> BTRFS' internal structure is very different from ZFS' so we don't have
> this notion of vdev, consisting of multiple child devices. And so each
> physical + vdev can be considered a separate device. So again, without
> extending the on-disk format i.e introducing new items or changing the
> format of existing ones we can't accommodate the exact same reports. And
> while the on-disk format can be changed (which of course comes with
> added complexity) there should be a very good reason to do so. Clearly
> something is amiss in your case, but I would like to first properly root
> cause it before jumping to conclusions.

ZFS gives fewer numbers when asking for device status, but the numbers provide 
more useful information.

Also it is possible to have numbers stored only in RAM that get lost when the 
filesystem is umounted.  That would still be very useful for monitoring 
systems.  I want to know about problems and replace disks before the problems 
become significant enough to lose data.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



