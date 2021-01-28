Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4031530745D
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 12:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhA1LEY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jan 2021 06:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhA1LEK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jan 2021 06:04:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9390C061756
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jan 2021 03:03:26 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w1so7058307ejf.11
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jan 2021 03:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/fSob9qp6I1LvvE+B0L3CatYSbVJUouBMbOjeYyn748=;
        b=cFJEJJjspobCp+oPuuES54VN/vd5HiUFzIHMhQElJRbQoSpzWHvcBtOrqKF2QU62Bs
         6cot3qmNQcMBkpCPzDOY0C5eeeV37Ulx1XSUCbYi+X6isHL2j0qd5KEHqTfGln9r7pI4
         OjbHuhWQHn5ur38H2XHugbHR48fkD/FRlll+v1KIpxcMv/RlMf3LTxzfhYysJX/Yd3cc
         WeIwFHAiBWHCVOdJYHoegiGmtPpLr/KD4rVCbnraZEwgw4nUUrnW2U/cNyK1gJ/CKQfO
         LxzYyMOXvdzVcOVI3Nl7fjxg8IeQXbg1qb/u0a8b5XYW5WNCrIIyjG+hCSUyjUqFP5QJ
         0qWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/fSob9qp6I1LvvE+B0L3CatYSbVJUouBMbOjeYyn748=;
        b=VDySVkaa5ims/VGP39KsRkgV1ijONaIiAamAxdpoq5NNM1RfwjSA+46rZ0HSfMytPA
         s3kHtW6wtRmDeCfwS8X+hnArYBLLIOXvSI0NVGjBN7Ldn5Q16PRsVG5cE1EA/aE+ps61
         hykH71wAD5/F3ty6fViUQyqxg0dsQRpc1n/hr8o8Syvl2EVC7hNn1bHAZ/pmBgpaEhiC
         7gTfqhlL2cnIkOiHDmglkHvuapkXqfV9D9cdrWELUrwp1aoDNIj0+HGXtUgApqGXa/cu
         qadZ1t/ZG3C4N7sforHTHYDqqsn70fak9YUXVRapZMJ500URme9AjB64mw21rmMCOulQ
         T1MQ==
X-Gm-Message-State: AOAM533AEKOLL1sO+tlFkGQQ/pnFsGKnHdmFu7leL5kvVlFZdI9jsuYx
        kDsYfklZzo46zEHeXYYJiPI2sNLaLSGQyVoioCsi5s5c
X-Google-Smtp-Source: ABdhPJwx0Qgswr09/hb4NjlVX07VdeWeJui98hgrgaPb0pQmjUE72PN2cotBqUdJnUdX8faVnraTbiym7Kk1DGXy3Fk=
X-Received: by 2002:a17:906:1712:: with SMTP id c18mr10716828eje.417.1611831805125;
 Thu, 28 Jan 2021 03:03:25 -0800 (PST)
MIME-Version: 1.0
From:   Andrew Vaughan <andrewjvaughan@gmail.com>
Date:   Thu, 28 Jan 2021 22:03:08 +1100
Message-ID: <CALxwgb59wUpyC1dinzYjG05781JesjrEf2WaXcP5bpm85-n52A@mail.gmail.com>
Subject: super_total_bytes mismatch with fs_devices total_rw_bytes
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Please cc me on replies.  I'm not subscribed to the list.]

Hi

I have a 3 device btrfs raid1 filesystem on my home linux system.  The
filesystem is probably over 10 years old at this point, and has had a
number of drives added and removed over it's life.  It currently
contains over 8 TB of data and is mainly used as write once, read
rarely/never.  There are a number of daily/weekly/monthly snapshots
(I'm guessing about 50 total).  Btrfs-progs is from Debian Testing and
currently is version 5.10-1.

I recently used btrfs replace to replace a 4 TB drive with a new 8 TB
drive.  After that completed, I did a scrub to ensure that the new
drive wasn't reporting any read errors.  (The old drive is still
physically installed in the system, but I expect replace should have
wiped the filesystem metadata, so that the kernel doesn't confuse it
with the new drive).

Today I did '# btrfs fi resize 4:max /srv/shared' as preparation for a
balance to make the extra drive space available.  (The old drives are
all fairly full.  About 130 GB free space on each.  I initially tried
btrfs fi resize max /srv/shared as the syntax on the manpage implies
that devid is optional.  Since that command errored, I assume it
didn't change the filesystem).

Also today I updated the kernel to
linux-image-5.10.0-2-amd64_5.10.9-1_amd64.deb, the latest kernel
available in Debian Testing.
linux-image-5.10.0-1-amd64_5.10.4-1_amd64.deb was also installed and I
think that was the running kernel during the replace, scrub and resize
operations.

After installing the new kernel I rebooted.   (# shutdown -r now.  I
wasn't really paying attention, but the shutdown seemed to take longer
than normal.  At one stage I actually thought the system had actually
hung).

After the reboot the btrfs filesystem failed to mount.  dmesg | grep
-i btrfs output

[    5.650300] Btrfs loaded, crc32c=crc32c-generic
[    6.182298] BTRFS: device label samba.btrfs devid 4 transid 1281994
/dev/sdd1 scanned by btrfs (173)
[    6.182887] BTRFS: device label samba.btrfs devid 5 transid 1281994
/dev/sde1 scanned by btrfs (173)
[    6.183711] BTRFS: device label samba.btrfs devid 8 transid 1281994
/dev/sdb1 scanned by btrfs (173)
[   16.492471] BTRFS info (device sdd1): disk space caching is enabled
[   16.547330] BTRFS error (device sdd1): super_total_bytes
22004298366976 mismatch with fs_devices total_rw_bytes 22004298370048
[   16.547561] BTRFS error (device sdd1): failed to read chunk tree: -22
[   16.560975] BTRFS error (device sdd1): open_ctree failed

That filesystem is used for archival storage and I don't need it in
the short term, so I simply commented it out in /etc/fstab and
rebooted to get a functioning system.

# uname -a
Linux nl40 5.10.0-2-amd64 #1 SMP Debian 5.10.9-1 (2021-01-20) x86_64 GNU/Linux

# mount -t btrfs /dev/sdd1 /mnt/sdd-tmp
mount: /mnt/sdd-tmp: wrong fs type, bad option, bad superblock on
/dev/sdd1, missing codepage or helper program, or other error.

# dmesg | grep -i btrfs
[    5.799637] Btrfs loaded, crc32c=crc32c-generic
[    6.428245] BTRFS: device label samba.btrfs devid 8 transid 1281994
/dev/sdb1 scanned by btrfs (172)
[    6.428804] BTRFS: device label samba.btrfs devid 5 transid 1281994
/dev/sdd1 scanned by btrfs (172)
[    6.429473] BTRFS: device label samba.btrfs devid 4 transid 1281994
/dev/sde1 scanned by btrfs (172)
[ 2004.140494] BTRFS info (device sde1): disk space caching is enabled
[ 2004.790843] BTRFS error (device sde1): super_total_bytes
22004298366976 mismatch with fs_devices total_rw_bytes 22004298370048
[ 2004.790854] BTRFS error (device sde1): failed to read chunk tree: -22
[ 2004.805043] BTRFS error (device sde1): open_ctree failed

Note that drive identifiers have changed between reboots.  I haven't
seen that on this system before.


Questions
=========

Is btrfs rescue fix-device-size <device> considered the best way to
recover?  Should I run that once for each device in the filesystem?

Do you want me to run any other commands to help diagnose the cause
before attempting recovery?

Unless I hear otherwise, I will probably attempt to reboot to Debian
kernel linux-image-5.10.0-1-amd64_5.10.4-1_amd64.deb tomorrow, to see
whether this is a kernel regression. (Probably 16-24 hours after I
send this).

Thanks for your work on linux and btrfs.

Best sincerely
Andrew V
