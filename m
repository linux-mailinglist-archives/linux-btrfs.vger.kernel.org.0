Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FFA2D5935
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 12:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbgLJL3s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 06:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731999AbgLJL3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 06:29:48 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2E4C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 03:29:08 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id x15so4940711ilq.1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 03:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UiaEE4TwkR4Y8f96z4GLLxYgReQsDNtYNoIoIVTFwKo=;
        b=oB1oRtqnRKXYAMoArMwmGobKIVidkJ7Ms15bECc1PEeHUkAdr/nr767aIYV8LMJ/Ru
         NSkmMTwNDCTw8rGTqK0MYmhyqsBBK2yOGubtvbCmbu+pRqJV4f1Hd8G2PjngdCv4+Tj8
         PNtoEYoeRCUNf3KHVznN4JE2Ni4SbWRBEdtUVgltK9wgY3ZGGavs6cBfJb8BppqCMOVs
         /kXzghqODZXdXvd9A0jfUf6mQE65ODzK0PVJlbFZAGgtBpbuUQobBGMdEP0buDaPHHcB
         /6w4GaX4acoyvYtyStBIizdDJ71GGT6dnCCcTR2A+zQPdrXjiEa/U+jqqOIi+uhCr+xf
         +yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UiaEE4TwkR4Y8f96z4GLLxYgReQsDNtYNoIoIVTFwKo=;
        b=SXvtQ481zocXyC6yN6ZLERXXiyA5HdPP5yjSBs8SJdmpyd5MrPzixSjvu7ZtVVydDv
         E2K7m/THCkLFyk3FjKfIT87j7L28KarkDFIJIjwLqtnUwFFhEhecW2lThyxB7mLWHIDd
         l2Fo4l1EecH8LMLyqrYhzxjQOGr1LJ5mpIl8jRjuTfdV2eL8gV0Uy8L+n8mj+C4eBcNy
         UIFAhXahpk5r97wJoolMPjskaG99p0PDEZZBlEs9Bzmp/tlvxyZZgxtqaqIjdT47IhzJ
         DV6WNkGss2mz3Zzn6uV7Xvni8g67CZwlTamIBXZm69KLGNqOG/ZpX7kFFFVY4Qv1rUBO
         rcrg==
X-Gm-Message-State: AOAM531qda4VdOXuxkfZM0xvLSmZche+xV3IDuU6XW9uqXUEHEUEWkBP
        RRLK7fF33X8CVYUx2y8t6QCdRtuq2qVVo8xSQuCVrbUzQ5jM1g==
X-Google-Smtp-Source: ABdhPJz/DDuu21fr9x+EBDH1aryHlUIILtO7iD3zi/AYdhbRBH8u57+r5PqdALeg00iuozRarpG56DAe9A/xawN/yuM=
X-Received: by 2002:a92:c0cc:: with SMTP id t12mr8404012ilf.299.1607599747188;
 Thu, 10 Dec 2020 03:29:07 -0800 (PST)
MIME-Version: 1.0
From:   Sreyan Chakravarty <sreyan32@gmail.com>
Date:   Thu, 10 Dec 2020 16:58:52 +0530
Message-ID: <CAMaziXsqG-z029cCTd1BBn6HTm2EDLxsSocSOVs1s5RoK_Q0aQ@mail.gmail.com>
Subject: btrfs swapfile - Not enough swap space for hibernation.
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a swapfile in a swap subvolume, I have used the
btrfs_map_physical script to get the resume_offset, and the swap file
was created with the +C attribute.

But when I try to do a `systemctl hibernate`
                 Not enough swap space for hibernation.

This usually happens if the resume_offset parameter is not right. But
I don't know what I am doing wrong. I have followed all the correct
steps.

My swap file is 10GB and my RAM is 8GB.

'swapon' on gives the following output:

                       NAME                  TYPE      SIZE USED PRIO
                       /dev/zram0            partition 3.8G   0B  100
                      /var/swap/fedora.swap file       10G   0B   -2

$ lsattr /var/swap/fedora.swap
---------------C---- /var/swap/fedora.swap

My layout is as follows:

toplevel (level 5)
|
|--->root
|--->swap

$ btrfs subvolume list -p /
ID 425 gen 17482 parent 5 top level 5 path root
ID 426 gen 16880 parent 5 top level 5 path swap

My kernel command line is as follows:

root=UUID=7d9dbe1b-dea6-4141-807b-026325123ad8 ro
rootflags=subvol=root
rd.luks.uuid=luks-1136a62b-955b-4391-b9a4-b48ab11a862d
resume=/dev/disk/by-uuid/7d9dbe1b-dea6-4141-807b-026325123ad8
resume_offset=3599978


I got the resume_offset via the btrfs_map_physical.c which I got from
here : https://github.com/osandov/osandov-linux/blob/master/scripts/btrfs_map_physical.c

and then dividing the physical offset via my disk block size which is
4096, which equals the resume offset.

My fstab is as follows:

UUID=7d9dbe1b-dea6-4141-807b-026325123ad8 /
btrfs   subvol=root,x-systemd.device-timeout=0 0 0
UUID=7d9dbe1b-dea6-4141-807b-026325123ad8 /var/swap
   btrfs   subvol=swap,rw,nodatacow,noattime,nosuid,x-systemd.device-timeout=0
0 0
UUID=0e9cf655-eaef-44d6-8b5d-3f84e7449c0e /boot                   ext4
   defaults        1 2
UUID=CACC-9508          /boot/efi               vfat
umask=0077,shortname=winnt 0 2
/var/swap/fedora.swap none swap
defaults,x-systemd.requires-mounts-for=/var/swap 0 2

Other diagnostic information:

$ uname -a
Linux localhost.HPNotebook 5.8.15-301.fc33.x86_64 #1 SMP Thu Oct 15
16:58:06 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v5.7

$ btrfs fi show
Label: 'fedora'  uuid: 7d9dbe1b-dea6-4141-807b-026325123ad8
Total devices 1 FS bytes used 100.81GiB
devid    1 size 930.00GiB used 120.02GiB path
/dev/mapper/luks-1136a62b-955b-4391-b9a4-b48ab11a862d

$ btrfs fi df /
Data, single: total=116.01GiB, used=100.38GiB
System, DUP: total=8.00MiB, used=16.00KiB
Metadata, DUP: total=2.00GiB, used=443.69MiB
GlobalReserve, single: total=112.12MiB, used=0.00B

$dmesg > dmesg.log
https://pastebin.com/raw/3Dw1JkDP


Please let me know if any further information is required.

Where am I going wrong ?
--
Regards,
Sreyan Chakravarty
