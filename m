Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC38241901
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 11:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgHKJjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 05:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgHKJjy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 05:39:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409F3C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 02:39:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qc22so12381690ejb.4
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EerWVPGAXpJFmryv08EjQx8Fc2IOlzGeGD/cMHQsRRk=;
        b=q5wydyIjBqbymndD2QoNQEr7fQOPTrEd5x5u51D1ClyW9ViRIEnDovishble8xdpGu
         swAwyaompO6zuwKVxvL+325FWTSSvR4Jk2hzk9FWvoq2XdC5pGOHK2F+56l/qu63NSq9
         Un4yU7twhuDi3MHCq78P6u5VFueL8R/HoOGbfgD5md+cF0+/12TYPjZUf4C+Bt66g5PO
         aM9PsBuOefGbSlXtxAdy9cjWU84JY4cOcStUbSlau+xtOyK+TCRwRZenCcPNuRDebIkJ
         aJrOVehp86NJvU8/avyIeSoLFL2Zf0m27wl3BgliybRklJz8ewNg1Rf0NjGqDE9CqwnA
         TYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EerWVPGAXpJFmryv08EjQx8Fc2IOlzGeGD/cMHQsRRk=;
        b=owlmq92cz2qImVWPKhlSh2jbIku+WFpq8RPqT7X0ap0SjhGs6/7Zw/nIRQQWfJg45r
         OQLEWsAcpbWrg9HNTPxpaJBuVbvVd+r0ksfYMZc0DQtquJ43Kfl3JM+kHyv9X5qHJlZo
         kSIjsjKknXBLqA9cYGrimvVTBHRyI/61BKDYqsabpMc0nG0IhZbTgWHnPFiR6lO2Jn+8
         kfojcSr0vdHA12mQUu51zTf6Akr1KupDRn9cbxj0jRnjHreRZEOT/FYXD9g80XHFQh/f
         w2ccFgcWA1jOJTX5vMzmKMhlttKmGrXq1WSehj6VHUTIy7a7KeXISRU+d0QqIVNmUBYL
         g6ZA==
X-Gm-Message-State: AOAM532TSXOJ/HgTfm5WtFMQo71s15gAbR+dbs3SjsfqtJlhALsKvzPI
        2wVO1tMOnwjnJXxG9ulZjEvMatk2ANz17WSF1n6mlsCQ
X-Google-Smtp-Source: ABdhPJxmPull8MmsaPxlBrxo16jaOpFJ+IlDZIj2AP7aDQXBjDQyD/x2zTkjsrXI/EUvhO56EAjHzFj56XWxXeBXH8Y=
X-Received: by 2002:a17:906:46cc:: with SMTP id k12mr25474198ejs.366.1597138790270;
 Tue, 11 Aug 2020 02:39:50 -0700 (PDT)
MIME-Version: 1.0
From:   Thommandra Gowtham <trgowtham123@gmail.com>
Date:   Tue, 11 Aug 2020 15:09:39 +0530
Message-ID: <CA+XNQ=iupWN6ck5M0hUQ-+470F9PKdoKKUUt+tmQOWoC=zterg@mail.gmail.com>
Subject: BTRFS suddenly moving to read-only
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Need some help to understand if there are any issues in BTRFS/Linux Kernel.

Running BTRFS as root filesystem and we see that suddenly the entire
disk is moved to read-only due to errors.

Did the SSD run out of life? If yes, then
- What are the best BTRFS options for frequent small amount of
writes(log files) on low quality SSD? If we want to increase the life
of the Disk.
- How do we determine the Disk health apart from SMART attributes? Can
we do a Disk write/read test to figure it out?

mount options used:
rw,noatime,compress=lzo,ssd,space_cache,commit=60,subvolid=263

#   btrfs --version
btrfs-progs v4.4

Ubuntu 16.04: 4.15.0-36-generic #1 SMP Mon Oct 22 21:20:30 PDT 2018
x86_64 x86_64 x86_64 GNU/Linux

mkstemp: Read-only file system
[35816007.175210] print_req_error: I/O error, dev sda, sector 4472632
[35816007.182192] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
66, rd 725, flush 0, corrupt 0, gen 0
[35816007.192913] print_req_error: I/O error, dev sda, sector 4472632
[35816007.199855] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
66, rd 726, flush 0, corrupt 0, gen 0
[35816007.210675] print_req_error: I/O error, dev sda, sector 10180680
[35816007.217748] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
66, rd 727, flush 0, corrupt 0, gen 0
[35816007.461941] print_req_error: I/O error, dev sda, sector 4472048
[35816007.468903] BTRFS error (device sda4): bdev /dev/sda4 errs: wr
66, rd 728, flush 0, corrupt 0, gen 0
[35816007.479611] systemd[7035]: serial-getty@ttyS0.service: Failed at
step EXEC spawning /sbin/agetty: Input/output error
[35816007.712006] print_req_error: I/O error, dev sda, sector 4472048

# dmesg | tail
bash: /bin/dmesg: Input/output error

Doesn't Input/output error mean the disk is inaccessible?

# btrfs fi show
Label: 'rpool'  uuid: 42d39990-e4eb-414b-8b17-0c4a2f76cc76
    Total devices 1 FS bytes used 11.80GiB
    devid    1 size 27.20GiB used 19.01GiB path /dev/sda4

# smartctl -a /dev/sda
smartctl 6.5 2016-01-24 r4214 [x86_64-linux-4.15.0-36-generic] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

Short INQUIRY response, skip product id
A mandatory SMART command failed: exiting. To continue, add one or
more '-T permissive' options.


We were able to get smartctl o/p after a power-cycle

# smartctl -a /dev/sda
smartctl 6.5 2016-01-24 r4214 [x86_64-linux-4.15.0-36-generic] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     FS032GM242I-AC
Serial Number:    AA010520170000000489
Firmware Version: O1026A
User Capacity:    31,488,000,000 bytes [31.4 GB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    Solid State Device
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2 (minor revision not indicated)
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Aug  9 04:26:10 2020 EDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
...
SMART Attributes Data Structure revision number: 1
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x0000   100   100   000    Old_age
Offline      -       0
  5 Reallocated_Sector_Ct   0x0000   100   100   000    Old_age
Offline      -       0
  9 Power_On_Hours          0x0000   100   100   000    Old_age
Offline      -       735
 12 Power_Cycle_Count       0x0000   100   100   000    Old_age
Offline      -       20
160 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       0
161 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       58
163 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       2
164 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       1045371
165 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       1075
166 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       972
167 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       1030
168 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       3000
169 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       66
175 Program_Fail_Count_Chip 0x0000   100   100   000    Old_age
Offline      -       0
176 Erase_Fail_Count_Chip   0x0000   100   100   000    Old_age
Offline      -       0
177 Wear_Leveling_Count     0x0000   100   100   050    Old_age
Offline      -       3733
178 Used_Rsvd_Blk_Cnt_Chip  0x0000   100   100   000    Old_age
Offline      -       0
181 Program_Fail_Cnt_Total  0x0000   100   100   000    Old_age
Offline      -       0
182 Erase_Fail_Count_Total  0x0000   100   100   000    Old_age
Offline      -       0
192 Power-Off_Retract_Count 0x0000   100   100   000    Old_age
Offline      -       5
194 Temperature_Celsius     0x0000   100   100   000    Old_age
Offline      -       40
195 Hardware_ECC_Recovered  0x0000   100   100   000    Old_age
Offline      -       0
196 Reallocated_Event_Count 0x0000   100   100   016    Old_age
Offline      -       0
197 Current_Pending_Sector  0x0000   100   100   000    Old_age
Offline      -       0
198 Offline_Uncorrectable   0x0000   100   100   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x0000   100   100   050    Old_age
Offline      -       0
232 Available_Reservd_Space 0x0000   100   100   000    Old_age
Offline      -       100
241 Total_LBAs_Written      0x0000   100   100   000    Old_age
Offline      -       766189
242 Total_LBAs_Read         0x0000   100   100   000    Old_age
Offline      -       11847
245 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       1045371

Regards,
Gowtham
