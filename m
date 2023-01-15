Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D6866AFD3
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Jan 2023 09:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjAOIAq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Jan 2023 03:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjAOIAe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Jan 2023 03:00:34 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86608B479
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 00:00:28 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q23-20020a17090a065700b002290913a521so8824968pje.5
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 00:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OZdkF7mjnvovvWTufTeICTRyhy5f9jExt2BzmFxd6A8=;
        b=J0AgtF4+wnHGi//jD5rbQBiJ6glFcR4SpI82/mrUp6691DAEmLV7i3UHJFByPOOdKc
         CS9oYkSap9cl+O7F2LLEU31YQvlUMCNe5WoHtYuz6h9ivtygbvz08+FOnGz9BKsKgUql
         rS0tWThAhZglX9bE3tQUZ5O/XI5MVJcZ2faelvP0/abw3D0j/1kZj1jtnCf8wA+JTxhB
         De7JO++/P7R85LJrTcykhs9VyfvLBLgxcUXPXx7lIsctkVbjC5FekizKyWOBml4yjypX
         WbFx9VgzCHuTz+r1LlAIxniXIPSs1AXx1A5KAikEPWzmHZ84gH6OJz2YSCbr2gfX11a1
         Cv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OZdkF7mjnvovvWTufTeICTRyhy5f9jExt2BzmFxd6A8=;
        b=R2PEgyw0Wcm41tVIKah/vdMha0r7kKnUQiM1HhtySyFxrG8ejVRNFlNnanMsqijMx1
         oqE75k9nJMWED/fiDgo5puIeWSjG1G2aqFN55ZyyDaNVSFvsemMnMRxSyteLAWNQcV9M
         XSF8v60Bz19Vs3Ndwkweau0h/oK+N97Vam17QoVXc24J8rZEtbrVagNnspfE1NiWb3y8
         kDtkdJKDzidvo8I5dyRGpcOIxusdxblBHCrozb8g9Vm6Oz5zS2J/F3fK6G46bfRSCVmO
         ziVwBxJsOjKmzZRKR6k+b5/T6CtN1MSoG25F3VZNvcAqA/6J9juMokzqw92yuk0ANyPY
         nnhQ==
X-Gm-Message-State: AFqh2kpyaXsp807fQbICkCV/+AjWBRe96o8/ckZIIhTWCkitWp9VwC4W
        5q36EWaEcJD961pEP9QWEUh8ycegw5R/xg==
X-Google-Smtp-Source: AMrXdXtATfvV0pnlY8ue98VWYREAAHPzlct/Bbzj+lcLl4hHKmgoHRsz8yQDkDDMVCI9vWG/B8zgrA==
X-Received: by 2002:a05:6a20:b061:b0:af:d295:e2ee with SMTP id dx33-20020a056a20b06100b000afd295e2eemr81118266pzb.37.1673769625996;
        Sun, 15 Jan 2023 00:00:25 -0800 (PST)
Received: from ?IPV6:2601:647:5580:5760:c157:f2a3:3eb8:fb59? ([2601:647:5580:5760:c157:f2a3:3eb8:fb59])
        by smtp.gmail.com with ESMTPSA id g38-20020a635666000000b004768b74f208sm13855997pgm.4.2023.01.15.00.00.23
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 00:00:24 -0800 (PST)
Sender: Ilya Bobir <ilya.bobir@gmail.com>
Message-ID: <d01644ab-8e08-758c-df62-42ee6c539ab4@gmail.com>
Date:   Sun, 15 Jan 2023 00:00:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US
From:   Illia Bobyr <illia.bobyr@gmail.com>
Subject: initramfs: bcache + btrfs: boot failure: race between btrfs and
 bcache
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I'm running Ubuntu 22.10 with bcache and btrfs.

I've been experience an issued during initramfs boot process for about 2 
years now.
At first it was intermittent, probably starting around 20.04, and I 
though it was a hardware issue.
But after a few upgrades it became a consistent behavior, causing my 
system to always fail to boot.

My initramfs boot screenshot is below.

It seems that btrfs is checking for the presence of a filesystem before 
bcache was able to find and load the necessary devices.
In order to boot the system, I boot with "break=premount" flag.
That interrupts initramfs scripts just before the root filesystem is 
mounted.
As you can see below, in a few seconds, bcache attaches corresponding 
devices (3 in my case).
Now I just need to press ^D to exit the shell and continue the boot process.
Root filesystem mounting succeeded and the the boot process continues.

Maybe someone familiar with the initramfs boot process can suggest 
something that would help me restore proper automatic boot?
I've searched for similar issues, but could not find anything useful.
Most error I was able to find were related to absence of proper drivers, 
causing initramfs not to see btrfs or bcache devices at all.
But in my case, it is a race condition.

I was not able to find code that is responsible for ordering these devices.
Should there be any?
Or am I required to specify which devices need to be found for the 
system to boot successfully, somewhere?
I was able to find code that uses currently mounted filesystems and 
baking those in the initramfs scripts.

Any help greatly appreciated.

Thank you,
Illia Bobyr


[    5.438837] ata5.00: configured for UDMA/133
[    5.439010] scsi 4:0:0:0: Direct-Access ATA ST16000NM001G-2K SNO3 PQ: 
0 ANSI: S
[    5.439442] sd 4:0:0:0: Attached scsi generic sg3 type 0
[    5.439484] sd 4:0:0:0: [sdd] 31251759104 512-byte logical blocks: 
(16.0 TB/14.6TiB)
[    5.439487] sd 4:0:0:0: [sdd] 4096-byte physical blocks
[    5.439526] sd 4:0:0:0: [sdd] Write Protect is off
[    5.439629] sd 4:0:0:0: [sdd] Write cache: disabled, read cache: 
enabled, does't suppor DPO or FUA
[    5.581018] usb 3-2: New USB device found, idVendor=0bc2, 
idProduct=ab44, bcdDevice=48.85
[    5.581022] usb 3-2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[    5.581024] usb 3-2: Product: Backup+ Hub
[    5.581026] usb 3-2: Manufacturer: Seagate
[    5.581027] usb 3-2: SerialNumber: 00AA0000AAAA
[    5.583278] hub 3-2:1.0: USB hub found
[    5.583574] hub 3-2:1.0: 3 ports detected
[    5.590359] nouveau 0000:01:00.0: DRM: allocated 3840x2160 fb: 
0xa0000, bo 00000000652c9a1e
[    5.590511] fbcon: nouveaudrmfb (fb0) is primary device
[    5.596417] sd 1:0:0:0: [sdb] Attached SCSI disk
[    5.656148]  sdd: sdd1
[    5.680487] sd 4:0:0:0: [sdd] Attached SCSI disk
[    5.681250] e1000e 0000:04:00.0 enp4s0f0: renamed from etho
[    5.686826] usbcore: registered new interface driver usbhid
[    5.686827] usbhid: USB HID core driver
[    5.688520] hid-generic 0003:1D50:6122.0001: hiddevO,hidraw0: USB HID 
v1.10 Device [Ultimate Gadget Laboratories Ultimate Hacking Keyboard] on 
usb-0000:00:14.0-2/input0
[    S.688619] input: Ultimate Gadget Laboratories Ultimate Hacking 
Keyboard as 
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:1D50:6122.0002/input/input3
[    5.708502] usb 4-2: new SuperSpeed USB device number 2 using xhci_hcd
[    5.736000] usb 4-2: New USB device found, idVendor=0bc2, 
idProduct=db45, bcdDevice=48.85
[    5.736003] usb 4-2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[    5.736005] usb 4-2: Product: Backup+ Hub
[    5.736007] usb 4-2: Manufacturer: Seagate
[    5.736008] usb 4-2: SerialNumber: 00AA0000AAAA
[    5.738538] hub 4-2:1.0: USB hub found
[    5.739265] hub 4-2:1.0: 3 ports detected
[    5.752268] hid-generic 0003:1D50:6122.0002: input,hidraw1: USB HID 
v1.10 Keyboard [Ultimate Gadget Laboratories Ultimate Hacking Keyboard] 
on usb-0000:00:14.0-2/input1
[    5.752464] input: Ultimate Gadget Laboratories Ultimate Hacking 
Keyboard as 
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:1D50:6122.0003/input/input4
[    S.816257] hid-generic 0003:1D50:6122.0003: input,hidraw2: USB HID 
v1.10 Device [Ultimate Gadget Laboratories Ultimate Hacking Keyboard] on 
usb-0000:00:14.0-2/input2
[    5.816330] input: Ultimate Gadget Laboratories Ultimate Hacking 
Keyboard as 
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:1D50:6122.0004/input/input5
[    $.876425] hid-generic 0003:1D50:6122.0004: input,hidraw3: USB HID 
v1.10 Device [Ultimate Gadget Laboratories Ultimate Hacking Keyboard] on 
usb-0000:00:14.0-2/input3
[    5.877023] input: Ultimate Gadget Laboratories Ultimate Hacking 
Keyboard as 
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:1D50:6122.0005/input/input6
[    5.877227] hid-generic 0003:1D50:6122.0005: input,hidraw4: USB HID 
v1.10 Mouse [Ultimate Gadget Laboratories Ultimate Hacking Keyboard] on 
usb-0000:00:14.0-2/input4
[    5.983801] Console: switching to colour frame buffer device 240x67
[    6.032426] usb 4-2.1: new SuperSpeed USB device number 3 using xhci_hcd
[    6.067094] usb 4-2.1: New USB device found, idVendor=0bc2, 
idProduct=ab38, bedDevice= 1.00
[    6.067097] usb 4-2.1: New USB device strings: Mfr=2, Product=3, 
SerialNumber=1
[    6.067098] usb 4-2.1: Product: Backup+ Hub BK
[    6.067099] usb 4-2.1: Manufacturer: Seagate
[    6.067100] usb 4-2.1: SerialNumber: AAAA0AAA
[    6.074066] usbcore: registered new interface driver usb-storage
[    6.081321] scsi host6: uas
[    6.081418] usbcore: registered new interface driver uas
[    6.082053] scsi 6:0:0:0: Direct-Access Seagate Backup+ Hub BK D781 
PQ: 0 ANSI: 6
[    6.083739] sd 6:0:0:0: Attached scsi generic sg4 type 0
[    6.084665] sd 6:0:0:0: [sde] 15628053167 512-byte logical blocks: 
(8.00 TB/7.28 TiB)
[    6.084666] sd 6:0:0:0: [sde] 4096-byte physical blocks
[    6.084806] sd 6:0:0:0: [sde] Write Protect is off
[    6.084958] sd 6:0:0:0: [sde] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    6.086614] sd 6:0:0:0: [sde] Optimal transfer size 33553920 bytes 
not a multiple of physical block size (4096 bytes)
[    6.095134]  sde: sde1
[    6.095967] sd 6:0:0:0: [sde] Attached SCSI disk
[    6.323915] nouveau 0000:01:00.0: [drm] fb0: nouveaudrmfb frame 
buffer device
[    6.344815] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 
on minor 0
[    6.345394] nouveau 0000:01:00.0: DRM: Disabling PCI power management 
to avoid bug
Begin: Loading essential drivers ... [    6.484104] raid6: avx2x4   
gen() 38907 MB/s
[    6.552128] raid6: avx2x4   xor() 16553 MB/s
[    6.620104] raid6: avx2x2   gen() 41005 MB/s
[    6.688104] raid6: avx2x2   xor() 24071 MB/s
[    6.756105] raid6: avx2x1   gen() 27571 MB/s
[    6.824126] raid6: avx2x1   xor() 17551 MB/s
[    6.892112] raid6: sse2x4   gen() 16487 MB/s
[    6.960104] raid6: sse2x4   xor()  9959 MB/s
[    7.028105] raid6: sse2x2   gen() 16806 MB/s
[    7.096104] raid6: sse2x2   xor() 10134 MB/s
[    7.164127] raid6: sse2x1   gen() 14178 MB/s
[    7.232128] raid6: sse2xi   xor()  7022 MB/s
[    7.232135] raid6: using algorithm avx2x2 gen() 41005 MB/s
[    7.232138] raid6: .... xor() 24071 MB/s, rmw enabled
[    7.232142] raid6: using avx2x2 recovery algorithm
[    7.232983] xor: automatically using best checksumming function avx
[    7.233710] async_tx: api initialized (async)
done.

Spawning shell within the initramfs

BusyBox v1.30.1 (Ubuntu 1:1.30.1-7ubuntu3) built-in shell (ash)
Enter 'help' for a list of built-in commands.

(initramfs) [   10.442821] bcache: bch_journal_replay() journal replay 
done, 9936 keys in 102 entries, seq 10412438
[   10.442968] bcache: register_cache() registered cache device sdc4
[   10.443229] beache: register_bdev() registered backing device sdb1
[   10.742434] beache: bch_cached_dev_attach() Caching sdb1 as bcache0 
on set 79ae7b91-0a8f-4375-a27e-be73fcOfccde
[   10.742913] beache: register_bdev() registered backing device sdd1
[   10.820078] beache: bch_cached_dev_attach() Caching sdd1 as beache1 
on set 79ae7b91-0a8f-4375-a27e-be73fcOfccde
[   10.820275] beache: register_bdev() registered backing device sda1
[   11.259044] beache: bch_cached_dev_attach() Caching sda1 as beache2 
on set 79ae7b91-0a8f-4375-a27e-be73fcOfccde
<<< Here I press ^D >>>
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top 
... done.
Begin: Running /scripts/local-premount ... [   35.729513] Btrfs loaded, 
crce32c=crc32c-intel, zoned=yes, fsverity=yes
Scanning for Btrfs filesystems
[   35.833033] BTRFS: device label backup devid 1 transid 17455 
/dev/sde1 scanned by btrfs (448)
[   35.833164] BTRFS: device label root devid 2 transid 389266 
/dev/bcache1 scanned by btrfs (448)
[   35.833295] BTRFS: device label root devid 1 transid 389266 
/dev/bcacheO scanned by btrfs (448)
[   35.833684] BTRFS: device label root devid 3 transid 389266 
/dev/bcache2 scanned by btrfs (448)
Scanning for Btrfs filesystems
done.
Begin: Will now check root file system ... fsck from util-linux 2.37.2
[/usr/sbin/fsck.btrfs (1) -- /dev/bcache2] fsck.btrfs -a /dev/bcache2
done.
[   35.867756] BTRFS info (device bcacheO): flagging fs with big 
metadata feature
[   35.867776] BTRFS info (device bcacheO): disk space caching is enabled
[   35.867785] BTRFS info (device beached): has skinny extents

