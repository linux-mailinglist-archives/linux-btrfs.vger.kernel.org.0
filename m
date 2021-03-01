Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2224F327D7A
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 12:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhCALpq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 06:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhCALpo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Mar 2021 06:45:44 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DEAC061756
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Mar 2021 03:45:04 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1lGgyx-0007o3-UY; Mon, 01 Mar 2021 11:44:59 +0000
Date:   Mon, 1 Mar 2021 11:44:59 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Christian =?iso-8859-1?Q?V=F6lker?= <cvoelker@knebb.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Adding Device Fails - Why?
Message-ID: <20210301114459.GC23670@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Christian =?iso-8859-1?Q?V=F6lker?= <cvoelker@knebb.de>,
        linux-btrfs@vger.kernel.org
References: <36a13b99-7003-d114-568d-6c03b66190b2@knebb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36a13b99-7003-d114-568d-6c03b66190b2@knebb.de>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 01, 2021 at 12:19:12PM +0100, Christian Völker wrote:
> I am using BTRS on a Debian10 system. I am trying to extend my existing
> filesystem with another device but adding it fails for no reason.
> 
> This is my setup of existing btrfs:
> 
>  2x DRBD Devices (Network RAID1)
>  top of each a luks encrypted device (crypt_drbd1 and crypt_drbd3):
> 
> vdb                         254:16   0  1,1T  0 disk
> └─drbd1                     147:1    0  1,1T  0 disk
>   └─crypt_drbd1             253:3    0  1,1T  0 crypt
> vdc                         254:32   0  900G  0 disk
> └─drbd2                     147:2    0  900G  0 disk
>   └─crypt2                  253:4    0  900G  0 crypt
> vdd                         254:48   0  800G  0 disk
> └─drbd3                     147:3    0  800G  0 disk
>   └─crypt_drbd3             253:5    0  800G  0 crypt /var/lib/backuppc
> 
> 
> 
> I have now a third drbd device (drbd2) which I encrypted, too (crypt2). And
> tried to add to existing fi.
> Here further system information:
> 
> Linux backuppc41 5.10.0-3-amd64 #1 SMP Debian 5.10.13-1 (2021-02-06) x86_64
> GNU/Linux
> btrfs-progs v5.10.1
> 
> root@backuppc41:~# btrfs fi sh
> Label: 'backcuppc'  uuid: 73b98c7b-832a-437a-a15b-6cb00734e5db
>         Total devices 2 FS bytes used 1.83TiB
>         devid    3 size 799.96GiB used 789.96GiB path dm-5
>         devid    4 size 1.07TiB used 1.06TiB path dm-3
> 
> 
> I can create an additional btrfs filesystem with mkfs.btrfs on the new
> device without any issues:
> 
> root@backuppc41:~# btrfs fi sh
> Label: 'backcuppc'  uuid: 73b98c7b-832a-437a-a15b-6cb00734e5db
>         Total devices 2 FS bytes used 1.83TiB
>         devid    3 size 799.96GiB used 789.96GiB path dm-5
>         devid    4 size 1.07TiB used 1.06TiB path dm-3
> 
> Label: none  uuid: b111a08e-2969-457a-b9f1-551ff65451d1
>         Total devices 1 FS bytes used 128.00KiB
>         devid    1 size 899.96GiB used 2.02GiB path /dev/mapper/crypt2
> 
> But I can not add this device to the existing btrfs fi:
> root@backuppc41:~# wipefs /dev/mapper/crypt2 -a
> /dev/mapper/crypt2: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42
> 48 52 66 53 5f 4d
> 
> root@backuppc41:~# btrfs device add /dev/mapper/crypt2 /var/lib/backuppc/
> ERROR: error adding device 'dm-4': No such file or directory
> 
> This is what I see in dmesg:
> [43827.535383] BTRFS info (device dm-5): disk added /dev/drbd2
> [43868.910994] BTRFS info (device dm-5): device deleted: /dev/drbd2
> [48125.323995] BTRFS: device fsid 2b4b631c-b500-4f8d-909c-e88b012eba1e devid
> 1 transid 5 /dev/mapper/crypt2 scanned by mkfs.btrfs (4937)
> [57799.499249] BTRFS: device fsid b111a08e-2969-457a-b9f1-551ff65451d1 devid
> 1 transid 5 /dev/mapper/crypt2 scanned by mkfs.btrfs (5178)

   We had someone on IRC a couple of days ago with exactly the same
kind of problem. I don't think I have a record of the solution in my
IRC logs, though, and I don't think we got to the bottom of it. From
memory, a reboot helped.

   Hugo.

> And these are the mapping in dm:
> 
> root@backuppc41:~# ll /dev/mapper/
> insgesamt 0
> lrwxrwxrwx 1 root root       7 28. Feb 21:08 backuppc41--vg-root -> ../dm-1
> lrwxrwxrwx 1 root root       7 28. Feb 21:08 backuppc41--vg-swap_1 ->
> ../dm-2
> crw------- 1 root root 10, 236 28. Feb 21:08 control
> lrwxrwxrwx 1 root root       7  1. Mär 12:12 crypt2 -> ../dm-4
> lrwxrwxrwx 1 root root       7 28. Feb 20:21 crypt_drbd1 -> ../dm-3
> lrwxrwxrwx 1 root root       7 28. Feb 20:21 crypt_drbd3 -> ../dm-5
> lrwxrwxrwx 1 root root       7 28. Feb 21:08 vda5_crypt -> ../dm-0
> 
> 
> Anyone having an idea why I can not add the device to the existing
> filesystem? The error message is not really helpful...
> 
> Thanks a lot!
> 
> /KNEBB

-- 
Hugo Mills             | Releasing out of hours. A Haiku:
hugo@... carfax.org.uk | Simply merge PR
http://carfax.org.uk/  | It is wrong. Buildkite, cancel!
PGP: E2AB1DE4          | gitops now corrupt
