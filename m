Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4275339A63D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jun 2021 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhFCQxM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Jun 2021 12:53:12 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:33634 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFCQxM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Jun 2021 12:53:12 -0400
Received: by mail-ej1-f43.google.com with SMTP id g20so10321038ejt.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Jun 2021 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fE3OeXpGf/w2pM3GbRSZFdZnvXyobwabDyCJL5cpRTs=;
        b=Dkyh0iNUKB/+qgg/eBpdf90AAGuwZlquR3b7ryjhmPRYX3GdCqY3drUPcKnPMh4zcM
         1w29/HrQxni8mdoJ9oY2YCvEKVBrcLxZQV9YeaVanak3cKhTKwUcB25zEgqQAcn+TFLM
         arVyzThf4n/LJ0qbDhNSr2trfJZYVrAtyilHLpBwyTCO/JmCoQRqD5I+lAGJ6TFGQdg4
         jgfh51N6U9g4RNoIQ9Jx409xKtnKvK6yfbOod/7qMUQ43Y6FdtEJc/ddyy/fuMHYpKyS
         lxfWeJAxjyFYyc5GsVtewghkB0mw/0YRxVE0dte0Azei7JymslsOFbGmvMoamETt230S
         e4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fE3OeXpGf/w2pM3GbRSZFdZnvXyobwabDyCJL5cpRTs=;
        b=O9RMVUQuwBEH1jX/eotGD247N25P9bJWZxUseeGw15H/uhlWqoCPhy5Fm2iTciVZMf
         gFFYLv5QIf1394eZTM/Ya55mBps5kMofIFdtbHRtWezm36Kwq6utYBJa57y6VH/pso5e
         uAHfgHkrqPEJAQQBNTKY2RzSHRBfKC9nTI25MML21AWIJxINQdxgpNT3yl6uvh0yE6Lp
         Amx7a3a1X/dZGrJ2Ds/5EbPd5SF21VKRusm0U6BU7NQG6R8WXg3lUuJGtxAX/Whxqfmc
         Sc4xVllq5iIa3QdZFyhxfLwwHhJarLOsKlTeIhtgXPOTTwss88gB75gkCne9bjtKzjCw
         +Hew==
X-Gm-Message-State: AOAM533FsxrScjcgnmr5Lsz8wqyTIVbWkDTC/E5GW81na3Zp3l5aX7Kt
        q/tWK+Oez5jExlRCO1RkmeVDx2hm7ENHoQ==
X-Google-Smtp-Source: ABdhPJwzA+3VajuHxVYIQOjRI+1mfCDV1UVQ1Wj0bmB0IZGDCfVwef7p7c1/YPBIAK4gbkvTOo/QFw==
X-Received: by 2002:a17:907:1112:: with SMTP id qu18mr253197ejb.511.1622739026587;
        Thu, 03 Jun 2021 09:50:26 -0700 (PDT)
Received: from ?IPv6:2001:984:3171:0:e9c3:434a:4798:3f72? ([2001:984:3171:0:e9c3:434a:4798:3f72])
        by smtp.gmail.com with ESMTPSA id ga3sm1798822ejb.34.2021.06.03.09.50.26
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 09:50:26 -0700 (PDT)
From:   Gaardiolor <gaardiolor@gmail.com>
Subject: Corrupted data, failed drive(s)
To:     linux-btrfs@vger.kernel.org
Message-ID: <cf633d62-73ab-1ce2-f31c-a4a8407a38b4@gmail.com>
Date:   Thu, 3 Jun 2021 18:50:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I could use some help with some issues I'm having with my drives.

I've got 4 disks in raid1.
--
[17:59:07]root@kiwi:/storage/samba/storage# btrfs filesystem df /storage/
Data, RAID1: total=4.39TiB, used=4.38TiB
System, RAID1: total=32.00MiB, used=720.00KiB
Metadata, RAID1: total=6.00GiB, used=4.66GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

[17:59:10]root@kiwi:/storage/samba/storage# btrfs filesystem show
Label: none  uuid: 8ce9e167-57ea-4cf8-8678-3049ba028c12
         Total devices 4 FS bytes used 4.38TiB
         devid    1 size 3.64TiB used 3.10TiB path /dev/sdc
         devid    2 size 3.64TiB used 3.14TiB path /dev/sdb
         devid    3 size 1.82TiB used 1.32TiB path /dev/sda
         devid    4 size 1.82TiB used 1.21TiB path /dev/sdd
--

I'm having some issues with faulty disk(s). /dev/sdd is bad for sure, 
SMART is complaining.
--
# smartctl -aq errorsonly /dev/sdd
ATA Error Count: 108 (device log contains only the most recent five errors)
Error 108 occurred at disk power-on lifetime: 47563 hours (1981 days + 
19 hours)
Error 107 occurred at disk power-on lifetime: 47563 hours (1981 days + 
19 hours)
Error 106 occurred at disk power-on lifetime: 47563 hours (1981 days + 
19 hours)
Error 105 occurred at disk power-on lifetime: 47563 hours (1981 days + 
19 hours)
Error 104 occurred at disk power-on lifetime: 47563 hours (1981 days + 
19 hours)
--

Also in /var/log/messages:
--
Jun  3 17:47:21 kiwi smartd[1112]: Device: /dev/sdd [SAT], 3088 
Currently unreadable (pending) sectors
Jun  3 17:47:21 kiwi smartd[1112]: Device: /dev/sdd [SAT], 3088 Offline 
uncorrectable sectors
--

However, the other disks also generate errors.
--
[18:00:35]root@kiwi:/storage/samba/storage# btrfs device stats /dev/sda
[/dev/sda].write_io_errs    0
[/dev/sda].read_io_errs     0
[/dev/sda].flush_io_errs    0
[/dev/sda].corruption_errs  408
[/dev/sda].generation_errs  0
[18:00:39]root@kiwi:/storage/samba/storage# btrfs device stats /dev/sdb
[/dev/sdb].write_io_errs    0
[/dev/sdb].read_io_errs     0
[/dev/sdb].flush_io_errs    0
[/dev/sdb].corruption_errs  322
[/dev/sdb].generation_errs  0
[18:00:42]root@kiwi:/storage/samba/storage# btrfs device stats /dev/sdc
[/dev/sdc].write_io_errs    0
[/dev/sdc].read_io_errs     0
[/dev/sdc].flush_io_errs    0
[/dev/sdc].corruption_errs  1283
[/dev/sdc].generation_errs  0
[18:00:43]root@kiwi:/storage/samba/storage# btrfs device stats /dev/sdd
[/dev/sdd].write_io_errs    0
[/dev/sdd].read_io_errs     1582
[/dev/sdd].flush_io_errs    0
[/dev/sdd].corruption_errs  1310
[/dev/sdd].generation_errs  0
-

/dev/sdd is the only one with read_io_errs.

I've tried unpacking a .tar.gz from /storage to another filesystem, but 
the tar.gz was obviously corrupt. Very strange filenames which were, 
because of the name, pretty difficult to remove. I will not post the 
filenames here, it'd probably crash the internet. I'm also getting:
--
gzip: stdin: invalid compressed data--crc error
tar: Child returned status 1
tar: Error is not recoverable: exiting now
--

I can't btrfs remove /dev/sdd . The command below ran for a while (I 
could see the allocated space of /dev/sdd decrease with btrfs fi us 
/storage/), but then errored:
--
root@kiwi:~# btrfs device remove /dev/sdd /storage/
  ERROR: error removing device '/dev/sdd': Input/output error
--


I have a couple of questions:

1) Unpacking some .tar.gz files from /storage resulted in files with 
weird names, data was unusable. But, it's raid1. Why is my data corrupt, 
I've read that BTRFS checks the checksum on read ?
2) Are all my 4 drives faulty because of the corruption_errs ? If so, 4 
faulty drives is somewhat unusual. Any other possibilities ?
3) Given that
- I can't 'btrfs device remove' the device
- I do not have a free SATA port
- I'd prefer a method that doesn't unnecessarily take a very long time

What's the best way to migrate to a different device ? I'm guessing, 
after doing some reading:
- shutdown
- physically remove faulty disk
- boot
- verify /dev/sdd is missing, and that I've removed the correct disk
- shutdown
- connect new disk, it will also be /dev/sdd, because I have no other 
free SATA port
- boot
- check that the new disk is /dev/sdd
- mount -o degraded /dev/sda /storage
- btrfs replace start 4 /dev/sdd /storage
- btrfs balance /storage

Is this correct, should this also check / fix errors, if not, what's the 
best approach.. Thanks!

Gaardiolor
