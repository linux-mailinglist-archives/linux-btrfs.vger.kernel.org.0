Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FD23DB959
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 15:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhG3NbF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 09:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhG3NbE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 09:31:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C1BC06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 06:30:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y34so17916557lfa.8
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=d5c2AszF20vMSo5hYoOvN3eoHMJURejhXJ/82Gb6qRI=;
        b=UnR3+7HUKP9S8u1m26GmkvsxYBfHzlkkuQsB8oUdtCx5QMzrChYW/12/rC1+4XtOTl
         bCH2GFbFAbtB7H3aS5PRRXwGWdiWK741V0XSDCwX2xWSGLVt+NOCq+XKl6eHLCETQcu9
         9ievN/MFDcJPIyGawtkTTcjqraSieWqJ9fhiSwTj1OSOCGIPqwoz3Jzsna0/3lXIe46I
         RZ1eaJvhD5zxFqJ0oMSLGNYjVUtHPBp/hHaQp3qFsvYc2KndmI4mcBK+Gzh/5lmkSSEZ
         MvlPiLqoQ1XRLn36ticiftFUkQOJnzk8fRGfhSVlDzrShcLRynsCF8/qW2vYbvu0FiJt
         vxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=d5c2AszF20vMSo5hYoOvN3eoHMJURejhXJ/82Gb6qRI=;
        b=NUabQ/HzB/KZ9Valzj8GE8d3XKR8Z0C4rDazMXH3SXTS4i+oGa9T60dI44GqErA04b
         FAk3FeMl5KBPwL2RktWxC5w3U1MVz+m9OKmFZpI2DziOcsIP0CwB6uoVNhzqSC2/M4Ft
         Y/kL1kfJbBwWDNzitzm7T2l0i7kzavNzXfWbymYFq3cB4b/9GsLeIzNkMT39Y85Og3EN
         3wBIJcdT4esvoyxdSft8fMBInkitwLwTAoTEh4x/rkO8TZ6HXxphMINHuXKj5EpeNLZN
         /Rmpd6BLfAcNIVzPdwsEU2LYnqCa5gjznq59YtiPeON4hXl3/WnV4KP1xyCaBtsvknt/
         s2kQ==
X-Gm-Message-State: AOAM533DlbrkTGnPT7/p+hsT6Bfeg0b2Fyk3AkpRQ7fk3938O9uqXNTZ
        3HC+4ye3yhpYq78SUr5E5r6S12uA/oU=
X-Google-Smtp-Source: ABdhPJys2wnGjWFYExYJ/cb9S3tMXbK913WSVzmEI14HAYLsnUOqXWjNgbof2LXbUg3A/MaulrTuCw==
X-Received: by 2002:a05:6512:33ad:: with SMTP id i13mr2009438lfg.115.1627651857632;
        Fri, 30 Jul 2021 06:30:57 -0700 (PDT)
Received: from [192.168.1.22] ([128.0.141.47])
        by smtp.gmail.com with ESMTPSA id f12sm152479lft.294.2021.07.30.06.30.57
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 06:30:57 -0700 (PDT)
From:   Aleksey Utkin <aleksey.utkin@gmail.com>
Subject: Cannot mount hm-smr drive with btrfs
To:     linux-btrfs@vger.kernel.org
Message-ID: <66714993-3927-8fc7-585b-398b8e4dc655@gmail.com>
Date:   Fri, 30 Jul 2021 16:30:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello.


I had a problem with the mounting of the BTRFS file system.

Test case description:

1. Operation: Creating btrfs: sudo mkfs.btrfs -O zoned -d single -m 
single -f /dev/sdb
Result: The file system was created successfully

2. Operation: Mount new btrfs: sudo mount /dev/sdb /mnt/sdb
Result: Mounted successfully

3. Operation: Filling a file system data system (copy using MC)
Result: Filling a file system data has passed successfully, the data has 
passed integrity control

4. Operation: Umount file system: sudo umount /mnt/sdb/
Result: Umounted successfully

5. Operation: Mount btrfs: sudo mount /dev/sdb /mnt/sdb
Result: Mounted successfully

6. Operation: rebooted the host with mounted file system BTRFS
Result: Reboot successfully

7. Operation: Checking the btrfs file system: sudo btrfs check /dev/sdb
Result: successfully, console output:
Opening filesystem to check...
Checking filesystem on /dev/sdb
UUID: 4312bf2a-376d-4a44-a69a-6bb112b124f6
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 17978056441856 bytes used, no error found
total csum bytes: 17534343280
total tree bytes: 22888923136
total fs tree bytes: 2191491072
total extent tree bytes: 2166554624
btree space waste bytes: 990047274
file data blocks allocated: 17955167518720
  referenced 17955167518720

8. Operation: Attempt to mount 1: sudo mount /dev/sdb /mnt/sdb
Result: Mounted unsuccessful,
Console output: mount: /mnt/sdb: wrong fs type, bad option, bad 
superblock on /dev/sdb, missing codepage or helper program, or other error.

9. Operation: Attempt to mount 2: sudo mount -t btrfs /dev/sdb /mnt/sdb
Result: unsuccessful, no messages, the HDD activity LED is glow, the 
console frozen, ^C does not interrupt the mount operation, the sudo 
reboot is not performed, the restart of Alt+PRTSCR+B is performed.

Version of the kernel:
$ uname -a
Linux x79zd3 5.14.0-051400rc2-generic #202107182230 SMP Sun Jul 18 
22:34:12 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v5.13
from https://github.com/kdave/btrfs-progs

$ btrfs fi show
nothing output

$ btrfs fi df /mnt/sdb
ERROR: not a btrfs filesystem: /mnt/sdb

Device:
$ sudo smartctl -i /dev/sdb
smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.14.0-051400rc2-generic] 
(local build)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     ST18000NM009J-2UW101
Serial Number:    ZL2BH53L
LU WWN Device Id: 5 000c50 0c812bf64
Firmware Version: SE01
User Capacity:    18 000 207 937 536 bytes [18,0 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-4 (minor revision not indicated)
SATA Version is:  SATA 3.3, 6.0 Gb/s (current: 3.0 Gb/s)
Local Time is:    Fri Jul 30 14:47:33 2021 MSK
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

# nc cwillu.com 10101 < /dev/kmsg
after operations 6,7,8,9 - http://cwillu.com:8080/128.0.141.47/2

$ sudo dmesg | nc termbin.com 9999
https://termbin.com/6g54


Best regards,
Aleksey Utkin



