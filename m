Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1831138358
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2020 20:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbgAKTq4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jan 2020 14:46:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36441 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730947AbgAKTq4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jan 2020 14:46:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so5440551wma.1
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2020 11:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJJr3C5YNjzUVP7BXCsOVXui1OezjVH4sNrQCgnxKyY=;
        b=MugEJm/GPpj9vpyE+5Gu8B/npv9uZCdmWbI3Y8/AuNsoQij8XnOJkKNCUl9CJ06JWs
         0Y/4iHnr3CVw4tjDxJ5UOr2uPYQEqxqpQ55G5oQ4W5p4z2jXo9aXPEyll86gSZyAFYbP
         Is/zFUlYwrMapCE6vr/HdrgSvjjbOE1+7c7OCza36LjyFXMmlTKVbodmoO7ETqam1kJz
         8ZRRkIo+DuzxTsjrqwkJyoqdSeR3TdYG+e1TKe2VnhHj4pKTzqmVgqTbZMtYyhf7c2+s
         A0LVokBTAitHV6KHsFzgmp11Ac+xvOtOkn2DtpzBSY/otNJNSjO1xmS6YSw2CWLnI+AC
         jFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJJr3C5YNjzUVP7BXCsOVXui1OezjVH4sNrQCgnxKyY=;
        b=DWWUJ5CFJaGFZ9DlnZganlswMOuAQHk7ZFSUL56MQ3cfy1HnaWcm2v/DSLS3IFUQDT
         1PbFinqptxTW9Jw57KOerow5aBJiecJ6MJwiJwDL/p6LJnVbLFX5pUmvHJcxizm5DTLs
         yjNCKYH0txc43jyvXW4gCMXJ6D3aPYtB5F+mDKRIeqtvMWMeeotY+mMzuOwJSwv8zzIV
         ZHfASNlmHBg4qhl483dfgz5zV/Ccl0+SbEN8OCOgOW7COuQ8nwILyOZF5ZfAyJe1fTVX
         R4Hwa/5sPoR9AmTHWYxhE4LDgg2H2DeWiRsT6SlJmEq2Tom1RJ8HZDX478M1isSfPrPP
         1LqA==
X-Gm-Message-State: APjAAAUjRvLWd1/sB9hXmDamQJKszLn0i9RCDffyUSZ8GqPVt0QsopBN
        F8ReQED0FaR/hfQR4IZAX9x28DrFzy9VzVgch1eD9g==
X-Google-Smtp-Source: APXvYqwqzWa/Plyrkv1NHCN3yKJWSDkRC83OLe1CWpiHjsOB0UUYhRjiAVriNzXE1bvurfcj9uxnMoUlgW+d3YntEOo=
X-Received: by 2002:a1c:61c1:: with SMTP id v184mr11158163wmb.160.1578772013615;
 Sat, 11 Jan 2020 11:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20191206034406.40167-1-wqu@suse.com> <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com> <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com> <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com> <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com> <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
 <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com> <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
 <3F43DDB8-0372-4CDE-B143-D2727D3447BC@icloud.com> <CAJCQCtRUQ3bz--5B7Gs9aGYdo6ybkJWQFy61ohWEc2y1BJ6XHA@mail.gmail.com>
 <938B37BF-E134-4F24-AC4F-93FECA6047FC@icloud.com> <CAJCQCtROKcVBNuWkyF5kRgJMuQ4g4YSxh5GL6QmuAJL=A-JROw@mail.gmail.com>
 <25D1F99C-F34A-48D6-BF62-42225765FBC1@icloud.com> <CAJCQCtQxN17UL7swO7vU6-ORVmHfQHteUQZ7iS1w7Y5XLHTpVA@mail.gmail.com>
 <86147601-37F0-49C0-B6F8-0F5245750450@icloud.com>
In-Reply-To: <86147601-37F0-49C0-B6F8-0F5245750450@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 11 Jan 2020 12:46:37 -0700
Message-ID: <CAJCQCtRkZPq-k6pX3bCJmj25HY4eDdAEUcgLwGSh_Mi6VEqdiQ@mail.gmail.com>
Subject: Re: 12 TB btrfs file system on virtual machine broke again (third time)
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 11, 2020 at 10:23 AM Christian Wimmer
<telefonchris@icloud.com> wrote:
>
> Hi guys,
>
> here the last lines before the suspend and after it:
>
>
> 66939.439945] Buffer I/O error on dev loop1, logical block 0, async page read
> [66939.621686] print_req_error: I/O error, dev loop1, sector 83885952
> [66939.621738] print_req_error: I/O error, dev loop1, sector 83885952
> [66939.621740] Buffer I/O error on dev loop1, logical block 10485744, async page read

I don't know what /dev/loop1 is or the origin of the i/o error, but
I'm gonna guess it's a problem with the underlying device, or a bug
related to either the VM or the host or guest kernels or some
interaction of the three.

> [509652.385601] sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [509652.385623] sd 6:0:0:0: [sdb] tag#0 Sense Key : Illegal Request [current]
> [509652.385628] sd 6:0:0:0: [sdb] tag#0 Add. Sense: Invalid command operation code
> [509652.385631] sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 00 00 16 b2 c0 00 00 00 20 00 00
> [509652.385634] print_req_error: critical target error, dev sdb, sector 1487552
> [509652.385642] BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 0, rd 1, flush 0, corrupt 0, gen 0
> [509652.386117] xhci_hcd 0000:00:1d.6: Mismatch between completed Set TR Deq Ptr command & xHCI internal state.
> [509652.386120] xhci_hcd 0000:00:1d.6: ep deq seg = ffff880bd3fbab40, deq ptr = ffff880bd3b65150
> [509652.386132] sd 6:0:0:0: [sdb] tag#1 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [509652.386135] sd 6:0:0:0: [sdb] tag#1 Sense Key : Illegal Request [current]
> [509652.386137] sd 6:0:0:0: [sdb] tag#1 Add. Sense: Invalid command operation code
> [509652.386139] sd 6:0:0:0: [sdb] tag#1 CDB: Write(16) 8a 00 00 00 00 00 01 1d 9a 18 00 00 02 00 00 00
> [509652.386141] print_req_error: critical target error, dev sdb, sector 18717208
> [509652.386158] BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 1, rd 1, flush 0, corrupt 0, gen 0
> [509682.560535] xhci_hcd 0000:00:1d.6: Mismatch between completed Set TR Deq Ptr command & xHCI internal state.
> [509682.560537] xhci_hcd 0000:00:1d.6: ep deq seg = ffff880bd3fbab40, deq ptr = ffff880bd3b65190
> [509682.560566] sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [509682.560567] sd 6:0:0:0: [sdb] tag#0 Sense Key : Illegal Request [current]
> [509682.560569] sd 6:0:0:0: [sdb] tag#0 Add. Sense: Invalid command operation code
> [509682.560571] sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 00 00 36 b2 c0 00 00 00 20 00 00
> [509682.560572] print_req_error: critical target error, dev sdb, sector 3584704
> [509682.560579] BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 1, rd 2, flush 0, corrupt 0, gen 0
> [509682.560667] BTRFS: error (device sdb1) in btrfs_start_dirty_block_groups:3716: errno=-5 IO failure
> [509682.560669] BTRFS info (device sdb1): forced readonly
> [509712.672325] xhci_hcd 0000:00:1d.6: Mismatch between completed Set TR Deq Ptr command & xHCI internal state.
> [509712.672330] xhci_hcd 0000:00:1d.6: ep deq seg = ffff880bd3fbab40, deq ptr = ffff880bd3b651d0
> [509712.672373] sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [509712.672377] sd 6:0:0:0: [sdb] tag#0 Sense Key : Illegal Request [current]
> [509712.672379] sd 6:0:0:0: [sdb] tag#0 Add. Sense: Invalid command operation code
> [509712.672382] sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 00 00 16 b2 c0 00 00 00 20 00 00
> [509712.672384] print_req_error: critical target error, dev sdb, sector 1487552
> [509712.672388] BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 1, rd 3, flush 0, corrupt 0, gen 0
> [509742.783978] xhci_hcd 0000:00:1d.6: Mismatch between completed Set TR Deq Ptr command & xHCI internal state.
> [509742.783982] xhci_hcd 0000:00:1d.6: ep deq seg = ffff880bd3fbab40, deq ptr = ffff880bd3b65210
> [509742.784016] sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [509742.784019] sd 6:0:0:0: [sdb] tag#0 Sense Key : Illegal Request [current]
> [509742.784021] sd 6:0:0:0: [sdb] tag#0 Add. Sense: Invalid command operation code
> [509742.784024] sd 6:0:0:0: [sdb] tag#0 CDB: Read(16) 88 00 00 00 00 00 00 36 b2 c0 00 00 00 20 00 00
> [509742.784026] print_req_error: critical target error, dev sdb, sector 3584704
> [509742.784031] BTRFS error (device sdb1): bdev /dev/sdb1 errs: wr 1, rd 4, flush 0, corrupt 0, gen 0
> [509742.784079] BTRFS: error (device sdb1) in btrfs_start_dirty_block_groups:3716: errno=-5 IO failure
> [509742.784082] BTRFS warning (device sdb1): Skipping commit of aborted transaction.
> [509742.784084] BTRFS: error (device sdb1) in cleanup_transaction:1881: errno=-5 IO failure
> [509742.784084] BTRFS info (device sdb1): delayed_refs has NO entry
> [512066.481724] usb 4-1: USB disconnect, device number 2
> [512066.484604] sd 6:0:0:0: [sdb] Synchronizing SCSI cache
> [512066.661516] usb 2-1: USB disconnect, device number 2
> [512066.661725] usblp0: removed

There are multiple hardware related errors here. Timing wise, it looks
like some kind of USB bus related error "xhci_hcd 0000:00:1d.6:
Mismatch between..." and maybe in the course of that error is what
causes the drive, /dev/sdb, to think a command it received is invalid,
hence "sd 6:0:0:0: [sdb] tag#0 Add. Sense: Invalid command operation
code" and the subsequent sector error, and the subsequent Btrfs error.

So Btrfs is getting confused because lower layers it has no control
over are doing the wrong thing; resulting in either dropped reads or
writes. Dropped writes can cause permanent corruption, depending on
what the writes are.

And then it looks like a USB device is disconnected.

Is /dev/sdb a USB stick or  drive in a USB enclosure? That's not
working out well, whatever it is.


> [512066.716156] usb 1-1: USB disconnect, device number 2
> [512066.751428] sd 6:0:0:0: [sdb] Synchronize Cache(10) failed: Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK
> [512066.811207] usb 2-2: USB disconnect, device number 3
> [512066.811350] usblp1: removed
> [512066.963131] usb 2-3: USB disconnect, device number 4
> [512066.963296] usblp2: removed
> [512067.091114] usb 4-1: new SuperSpeed USB device number 3 using xhci_hcd
> [512067.107446] usb 1-1: new full-speed USB device number 3 using uhci_hcd
> [512067.113881] usb 2-4: USB disconnect, device number 5
> [512067.114143] usblp3: removed
> [512067.126193] usb 4-1: New USB device found, idVendor=2109, idProduct=0711
> [512067.126195] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [512067.126196] usb 4-1: Product: 20231
> [512067.126196] usb 4-1: Manufacturer: Ugreen
> [512067.126197] usb 4-1: SerialNumber: 000000128DA4
> [512067.140176] scsi host9: uas
> [512067.141472] scsi 9:0:0:0: Direct-Access     ST6000DM 004-2EH11C       DN02 PQ: 0 ANSI: 6
> [512067.142615] sd 9:0:0:0:


The problem with snippets is that they're over too small of a time
period, and after problems already started, to determine the sequence
of what went wrong, and what else is involved in the confusion. The
problem with getting the entire dmesg is that it's tedious to read
through to try and find the problem.

The gist though is the setup is flawed and now you've had three
failures it's telling you something is wrong.

Any hardware errors inside a VM guest, can be either hardware or
software errors in the host. It could be the hypervisor. It could be
the host kernel. Have you checked the host kernel messages while these
errors are happening inside the VM? What about the hypervisor logs?





-- 
Chris Murphy
