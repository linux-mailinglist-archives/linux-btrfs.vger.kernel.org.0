Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2ADE288831
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 14:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgJIMBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 08:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388285AbgJIMBj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 08:01:39 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C42C0613D2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 05:01:39 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id j20so1265429uaq.6
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=V+OEJkEyOGvUDcfBXFJJOkHY6OwD1ccPA6ELQZcFbmY=;
        b=flWZzJjB8+mtT1WEpanLtrJbjAwCVX1/4LYMn7NwTqlICu7t9kf2JvI8R2tql3nqJ5
         z1VEyw6DP6wXqyKf0sTAWKmXYcb5aZ01mcNXowJEolyV/OlyK51EV3nzNppfydG/hCCC
         IutzurXDuhF3xFPqBaUEhSA8wVFt2EQv93ThMV7q84WE41Q9D7n+LznobEW8qcV7Pc1V
         /QRKEHpVnlgZRQdhNiBkwzniFTAGpDgiZwrGsyhDan+0d3rEN02qHqPJt8dWZRCZFNAk
         do9WwlbNIJ7qe3ja6Bmo72at4t1lOdwrwXVHQuZy7dgnoV64WqotIo16QIrjfC0BsqgI
         21Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=V+OEJkEyOGvUDcfBXFJJOkHY6OwD1ccPA6ELQZcFbmY=;
        b=oG1OEoGwfWRggLHiue2mMuMIRQrkZAoLZJ9CKycUWXnwiIyKfgIK/MKpZwvvOspgNb
         jpJNYRXqx3GAhsHihBbAYql4Q6K2nMBakjtOvDmFbfwkTGd1VZ/AfZ+8w2m4NyLKAW9r
         Y42TcbIzbOBRGHmDie2IxzMjKFdsYE7xn4aBB2eyMe9iUFF/3nrFBPzSMExCNueehMhK
         KFas7DylfdbzsQo4GLnPNFU/8chNnfvc40vuhFEMQ84q8UyK1nem+OtNlOcJq3+BMCI/
         Mks0s0BRwZQZvTDQX/Li/CNK5K/H8Srcv1+PiW0h/7aOQPOZsYGAjihMhpHUPWltNA6+
         7Q8g==
X-Gm-Message-State: AOAM530M5JEAE9wJpMjuBtEbhjw6ng8EtsTKjs0a8rpuOavvrYf0vPFK
        2vOT+i4b1dicanHzQN2etP4cu5CHh+ILI6fL6Y0ZXVW/Rt4=
X-Google-Smtp-Source: ABdhPJyGFyiKoUd5uPLbPplShNEmgcPyMdOB2VZXWZ+X0S0QUJ4v05fAeP8ry1NgL+hkKxTxAbQE9GsA32iH486qRkA=
X-Received: by 2002:ab0:7490:: with SMTP id n16mr7331536uap.134.1602244897606;
 Fri, 09 Oct 2020 05:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAOsCCbNxQyF+A3e1SnRm97nDSJJ3KqF+s8mUD4S_6xH5qp530Q@mail.gmail.com>
 <CAOsCCbOdwwC3bPOWnHXQynuBD_=NoTAyxR27zmRjj3EnPL_o7Q@mail.gmail.com>
In-Reply-To: <CAOsCCbOdwwC3bPOWnHXQynuBD_=NoTAyxR27zmRjj3EnPL_o7Q@mail.gmail.com>
From:   =?UTF-8?Q?Tobiasz_Karo=C5=84?= <unfa00@gmail.com>
Date:   Fri, 9 Oct 2020 12:01:23 +0000
Message-ID: <CAOsCCbMUPeLfXWAv1ckQ=xrS2Y6dV1krVWzKUMoAbNGZQS6buw@mail.gmail.com>
Subject: Fwd: My root Btrfs filesystem was corrupted after a system freeze
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I'm a happy user of Btrfs for a couple of years, thought today I've
had a very strange thing happen to me.

I was working on a project in Blender using the realtime
rendering-engine Eevee (entirely running on the GPU) when suddenly my
laptop has frozen.
I've rebooted it and realized my autosave was in /tmp/ so it's gone.
I've redone my progress and in the exact same moment, when I connected
two things in Blender - my system froze again. But this time - it
failed to boot up again.
I've investigated what's going on and found that the root filesystem
is damaged and is unmountable.
Here you can read more detail and find a photo of the error message
that greeted me after failed reboot:

https://developer.blender.org/T81547

I suspect AMD GPU driver has a bug that was triggered by Blender's GPU
renderer, but how could that corrupt my root filesystem?
Note that I also had another Btrs filesystem mounted (for data) and
that one is fine (thankfully).
I'm currently imaging the system drive (dual booting with Windows) and
can't mount it so I can't provide any logs.
I am running Manjaro Linux KDE edition on Kernel 5.8 (AFAIK).
I'm afraid to try anything on the damaged filesystem before I have a
complete disk image to restore in case of a failure. Fortunately I do
have a full system disk image created some time ago, but this is a
major catastrophe nonetheless.

--- UPDATE

Right now I am running Manajro Linux 20.1.1 from a live USB, and I can
provide some hardware information:

```
$ inxi -b
System:    Host: manjaro Kernel: 5.8.11-1-MANJARO x86_64 bits: 64
Desktop: KDE Plasma 5.19.5 Distro: Manjaro Linux
Machine:   Type: Laptop System: Micro-Star product: Alpha 15 A3DD v:
REV:1.0 serial: <superuser/root required>
          Mobo: Micro-Star model: MS-16U6 v: REV:1.0 serial:
<superuser/root required> UEFI: American Megatrends
          v: E16U6AMS.10F date: 03/04/2020
Battery:   ID-1: BAT1 charge: 49.2 Wh condition: 49.8/53.4 Wh (93%)
CPU:       Quad Core: AMD Ryzen 7 3750H with Radeon Vega Mobile Gfx
type: MT MCP speed: 3240 MHz min/max: 1400/2300 MHz
Graphics:  Device-1: Advanced Micro Devices [AMD/ATI] Navi 14 [Radeon
RX 5500/5500M / Pro 5500M] driver: amdgpu v: kernel
          Device-2: Advanced Micro Devices [AMD/ATI] Picasso driver:
amdgpu v: kernel
          Device-3: Acer HD Webcam type: USB driver: uvcvideo
          Display: x11 server: X.Org 1.20.9 driver: amdgpu FAILED: ati
unloaded: modesetting,radeon resolution:
          1: 1920x1080~120Hz 2: 1920x1080~60Hz
          OpenGL: renderer: AMD RAVEN (DRM 3.38.0 5.8.11-1-MANJARO
LLVM 10.0.1) v: 4.6 Mesa 20.1.8
Network:   Device-1: Realtek RTL8822CE 802.11ac PCIe Wireless Network
Adapter driver: rtw_8822ce
          Device-2: Realtek driver: r8169
Drives:    Local Storage: total: 5.95 TiB used: 2.20 TiB (36.9%)
Info:      Processes: 352 Uptime: 39m Memory: 29.37 GiB used: 4.85 GiB
(16.5%) Shell: Bash inxi: 3.1.05

$ inxi -d
Drives:    Local Storage: total: 5.95 TiB used: 2.20 TiB (36.9%)
          ID-1: /dev/nvme0n1 vendor: Samsung model: MZVLB512HAJQ-00000
size: 476.94 GiB
          ID-2: /dev/sda vendor: Seagate model: ST2000LM015-2E8174
size: 1.82 TiB
          ID-3: /dev/sdb type: USB vendor: SanDisk model: Ultra USB
3.0 size: 28.65 GiB
          ID-4: /dev/sdc type: USB vendor: Seagate model:
ST4000DM004-2CV104 size: 3.64 TiB
          Message: No Optical or Floppy data was found.
```

I've been searching around and it seems possible that what happend was
a GPU driver bug triggered by BLender's Eevee rendered caused memory
corruption and made Btrfs break the filesystem.

I've tried these steps:
- restoring superblock (was deemed fine, no need torestore)
- clearing fs log - completed ok
- scrub - reported unrecoverable errors and finidhes pretty quickly
- clearing csum tree - i/o error
- clearing extent tree - i/o error

I've eneded up overwriting the whole disk from backup and it booted,
but since I have made the backup image while the system was running,
my csums were wrong and I couldn't log into a graphical session.
I've deleted all snapshots and files on that filesystem and I am now
trying to rsync all the files anew to recover from the csum errors. I
wanted to avoid having to create an entirely new filesystem, though
maybe it would have been faster...

--=20
- Tobiasz 'unfa' Karo=C5=84

www.youtube.com/unfa000
