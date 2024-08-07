Return-Path: <linux-btrfs+bounces-7039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CF394B3AA
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 01:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21251F2274E
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 23:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D665B1552ED;
	Wed,  7 Aug 2024 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1Ghw4Ej"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EBA2B9A1
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723073774; cv=none; b=UM6TVhQjAd/ugOko13UZywYv0BXm+JQz9XN26RATK9ENlVC8Xk2XF4vegw/HSJcriAV3f5vASiskZWjSWh8WId694mEK5MvOUzr1Cf56muvS4Kxcrk8wx36JXyjzz75qT0+68uZ59ZW0L3/efllI857cUB/7GwnDghQzRix/XAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723073774; c=relaxed/simple;
	bh=Gt2Ei2mRUKjA6OHMl4Fqg053TiVcE/j8yzwdH8/jveA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HE+zb+4xkgKyPtezLQF0at0enTJnGhB52OMjTSapCpK445wW7dHT/1ZkPXxuZmJf5Q4vsnDS2zUK+qxmsfNa2+EsPkAsd4qQhQi810KeoFRP2G7wxZFZdMaDalfj8SOj2QoxihTjhvELFPLWQ6k82fsTfmg+Kc0KPziL4Eui4bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1Ghw4Ej; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efd8807aaso342374e87.3
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2024 16:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723073769; x=1723678569; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hdxxi8bQWGy9AowGHhVkR1+PNTDBh5V5uEmBqiGrMPs=;
        b=b1Ghw4Ejo1f6ZqOen6giwgShpHeuqL0LUEBprsXuEIooh0mkITIEh/neNcIrDUz/Ik
         0niMnZtshqDyqABlvUEvgig2hEAH6N/ZO4JfvJ2V4tZ5w3NHQ0IWh0ylOaim77/CNR3G
         jaUhFcgrJwJ4185m0mmkkGjHpJijqDVrmIrhDnuskuDwado3+M8DYVu51gQLFJjoVeHb
         OKdv+C3Km0ceaIMYgOMwuCIY7r0gCd/x9ItrDPQDs8pCz9fwEeZnnpBBqaLyRKofKLWp
         //yzw3s+yr02chbhsTZ4+C11y7kG8txlD/CshneOwYPBjHXkzF/2A4Mt4G6wk/UO7jgd
         CJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723073769; x=1723678569;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdxxi8bQWGy9AowGHhVkR1+PNTDBh5V5uEmBqiGrMPs=;
        b=Ad8URXBplOFueq1MmobCjr0hLJ2MIayyJ5vqk2t17dwrysOLEzK/Ust9JQeVdhZ9ZM
         sxGWeiqi7taTmze48OBH3dqJ/4wFhLcjK8QEPufyhWgiaCTrklolRC66Ygk//iClPLpz
         SvTJwixKIjY10sR02Xtc5VrlKlkogFhNeuE12zWf5EHM8y34wbdVKv1F5cWhC9l6fVVq
         9+2NF8szfYBqo92+lcfiKIAu+c0OgTWJYJ9C8WGBOfOy/LWdve96KSNoXbNB5Y5wiy7g
         Xk1cGq+9JdSNjSFrfGqjbYv3ECzT76yyTrHzuf+8jDf6aAzEdqGvHi4AqmaOMTQ4+xMK
         sm9Q==
X-Gm-Message-State: AOJu0YydYQOwAFdce3jmfshn5h0zS64cKzbDJm7Tzgu230dwERvMfnJq
	N+DDSJqpMxxshxLErivY3br26QpX/M5jfZjsfJrvHeJAsVlIFIO0DEYUMq4EBVZx+rPKRR38R98
	VcgZ8kX2rhQVCekzMoR+d5EsO5kHeb71dHI448Q==
X-Google-Smtp-Source: AGHT+IF1lur1C/6McUlpp3twRxqPZmNfppYZ8vq/XanWSUmbPDwGaiSFMb5+wY/zHQfdUdxHQLfKO7du4FQ/PNRMsd0=
X-Received: by 2002:a05:6512:3049:b0:52f:cce4:51f3 with SMTP id
 2adb3069b0e04-530e58b011fmr53190e87.44.1723073768194; Wed, 07 Aug 2024
 16:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Succursale <succursale42@gmail.com>
Date: Wed, 7 Aug 2024 19:35:57 -0400
Message-ID: <CANFmVM3BwXEvo2FWQabHVD0+jBGKx5mBvs+Ec_eB7arP3P=xgQ@mail.gmail.com>
Subject: Unable to remove device from raid6 after disk failure
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm having trouble removing a failing device from my raid6.

Sorry that this will be a wall of text, but I figured it'd be better
to provide more information than not enough. Please let me know if
there's a better place / format for a report like this.

Here's what's happening:
# btrfs device remove missing /mnt/btrfs-raid6-4tb/
ERROR: error removing device 'missing': Input/output error

The only thing logged in dmesg is:
BTRFS info (device sdc1): relocating block group 66153101656064 flags data|raid6
at the start of the operation. The remove finally errors about a minute later.

Here's what led up to it:
I recently added a new drive, then did a full rebalance. I then ran a
scrub to make sure all was well.

Aug 02 10:17:41 fedora kernel: BTRFS info (device sdc1): first mount
of filesystem a31e55af-8bbf-4f00-9ad8-1423d492d108
Aug 02 10:17:41 fedora kernel: BTRFS info (device sdc1): using crc32c
(crc32c-intel) checksum algorithm
Aug 02 10:17:41 fedora kernel: BTRFS info (device sdc1): using free-space-tree
Aug 02 10:17:43 fedora kernel: BTRFS info (device sdc1): bdev
/dev/mapper/2024-07-20tb errs: wr 87, rd 0, flush 0, corrupt 0, gen 0
Aug 02 10:17:43 fedora kernel: BTRFS info (device sdc1): bdev
/dev/mapper/2024-06-external-14tb errs: wr 0, rd 0, flush 0, corrupt
13, gen 0
Aug 02 10:18:12 fedora kernel: BTRFS info (device sdc1): scrub:
started on devid 1

I didn't notice this error at the time:

Aug 02 10:24:19 fedora kernel: BTRFS error (device sdc1): level verify
failed on logical 94301984407552 mirror 2 wanted 1 found 0

I zeroed out the stats
Aug 02 16:41:01 fedora kernel: BTRFS info (device sdc1): device stats
zeroed by btrfs (81339)

at 9:28am the next day:
root@fedora:~# btrfs scrub status /dev/sdc1
UUID:             a31e55af-8bbf-4f00-9ad8-1423d492d108
Scrub started:    Fri Aug  2 10:18:12 2024
Status:           running
Duration:         23:10:13
Time left:        296:36:44
ETA:              Thu Aug 15 18:05:09 2024
Total to scrub:   28.03TiB
Bytes scrubbed:   2.03TiB  (7.25%)
Rate:             25.53MiB/s
Error summary:    no errors found


Then things took a turn:

Aug 03 09:43:01 fedora kernel: sd 20:0:0:0: rejecting I/O to offline device
Aug 03 09:43:01 fedora kernel: I/O error, dev sda, sector 11051087104
op 0x1:(WRITE) flags 0x0 phys_seg 2 prio class 2
Aug 03 09:43:01 fedora kernel: I/O error, dev sda, sector 11051087488
op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 2
Aug 03 09:43:01 fedora kernel: I/O error, dev sda, sector 11050966272
op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 2
Aug 03 09:43:01 fedora kernel: I/O error, dev sda, sector 11050966784
op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 2
Aug 03 09:43:01 fedora kernel: I/O error, dev sda, sector 11050967296
op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
Aug 03 09:43:01 fedora kernel: I/O error, dev sda, sector 11050967808
op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 2
Aug 03 09:43:01 fedora kernel: I/O error, dev sda, sector 11051087616
op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
Aug 03 09:43:01 fedora kernel: ata21.00: detaching (SCSI 20:0:0:0)
Aug 03 09:43:01 fedora kernel: device offline error, dev sda, sector
738910088 op 0x0:(READ) flags 0x0 phys_seg 8 prio class 2
Aug 03 09:43:01 fedora kernel: device offline error, dev sda, sector
11050968320 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 2
Aug 03 09:43:01 fedora kernel: device offline error, dev sda, sector
11051087744 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 2
Aug 03 09:43:02 fedora kernel: sd 20:0:0:0: [sda] Synchronizing SCSI cache
Aug 03 09:43:11 fedora kernel: BTRFS info (device sdc1): scrub: not
finished on devid 1 with status: -5
Aug 03 09:43:20 fedora kernel: scsi 20:0:0:0: Direct-Access     ATA
  ST8000DM004-2U91 0001 PQ: 0 ANSI: 5
Aug 03 09:43:20 fedora kernel: sd 20:0:0:0: [sdl] 15628053168 512-byte
logical blocks: (8.00 TB/7.28 TiB)
Aug 03 09:43:47 fedora kernel: sd 20:0:0:0: [sdl] 4096-byte physical blocks
Aug 03 09:43:47 fedora kernel: sd 20:0:0:0: [sdl] Write Protect is off
Aug 03 09:43:47 fedora kernel: sd 20:0:0:0: [sdl] Mode Sense: 00 3a 00 00
Aug 03 09:43:47 fedora kernel: sd 20:0:0:0: [sdl] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
Aug 03 09:43:47 fedora kernel: sd 20:0:0:0: Attached scsi generic sg0 type 0
Aug 03 09:43:47 fedora kernel: sd 20:0:0:0: [sdl] Preferred minimum
I/O size 4096 bytes
Aug 03 09:43:47 fedora kernel:  sdl: sdl1
Aug 03 09:43:47 fedora kernel: sd 20:0:0:0: [sdl] Attached SCSI disk
Aug 03 09:44:06 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 0, rd 0, flush 1, corrupt 0, gen 0
Aug 03 09:44:06 fedora kernel: BTRFS warning (device sdc1): lost page
write due to IO error on /dev/mapper/2024-06-8tb-b (-5)
Aug 03 09:44:06 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 1, rd 0, flush 1, corrupt 0, gen 0
Aug 03 09:44:15 fedora kernel: BTRFS error (device sdc1): error
writing primary super block to device 6
Aug 03 09:44:25 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 1, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:25 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 2, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:25 fedora kernel: BTRFS warning (device sdc1): lost page
write due to IO error on /dev/mapper/2024-06-8tb-b (-5)
Aug 03 09:44:25 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 3, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:25 fedora kernel: BTRFS warning (device sdc1): lost page
write due to IO error on /dev/mapper/2024-06-8tb-b (-5)
Aug 03 09:44:25 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 4, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:25 fedora kernel: BTRFS warning (device sdc1): lost page
write due to IO error on /dev/mapper/2024-06-8tb-b (-5)
Aug 03 09:44:25 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 5, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:33 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 6, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:33 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 7, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:33 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 8, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:33 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 9, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:33 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 10, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:33 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 11, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:42 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 12, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:42 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 13, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:42 fedora kernel: BTRFS error (device sdc1): error
writing primary super block to device 6
Aug 03 09:44:42 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 14, rd 0, flush 2, corrupt 0, gen 0
Aug 03 09:44:42 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 15, rd 0, flush 2, corrupt 0, gen 0

Those " errs: wr 8, rd 0, flush 2, corrupt 0, gen 0" errors continued,
interspersed with "lost page write due to IO error" on for a long
time, with the wr part incrementing.

The scrub stopped, but didn't report errors:
# btrfs scrub status /mnt/btrfs-raid6-4tb/
UUID:             a31e55af-8bbf-4f00-9ad8-1423d492d108
Scrub started:    Fri Aug  2 10:18:12 2024
Status:           aborted
Duration:         23:24:59
Total to scrub:   28.06TiB
Rate:             25.26MiB/s
Error summary:    no errors found

One disk in particular stood out:
# btrfs device stats -T /mnt/btrfs-raid6-4tb/
Id Path                              Write errors Read errors Flush
errors Corruption errors Generation errors
-- --------------------------------- ------------ -----------
------------ ----------------- -----------------
 1                         /dev/sdc1            0           0
  0                 0                 0
 2          /dev/mapper/2024-07-24tb            0           0
  0                 0                 0
 3          /dev/mapper/2024-07-20tb            0           0
  0                 0                 0
 4 /dev/mapper/2024-06-external-14tb            0           0
  0                 0                 0
 5         /dev/mapper/2024-06-8tb-a            0           0
  0                 0                 0
 6         /dev/mapper/2024-06-8tb-b     33854197           0
4778                 0                 0
 7          /dev/mapper/2024-06-20tb            0           0
  0                 0                 0

I saw the scrub had failed and the messages in the log, so I tried
removing the device:

# btrfs device remove 6 /mnt/btrfs-raid6

but the error messages continued in the kernel log, so I detached it with

# echo 1 > /sys/block/sr0/device/delete

then realized I should've unmounted

# umount /mnt/btrfs-raid6-4tb
# cryptsetup luksClose 2024-06-8tb-b

then I tried mounting the raid

# mount /mnt/btrfs-raid6-4tb

That failed, and there was a stacktrace in the kernel log:

Aug 07 09:09:27 fedora kernel: BTRFS error (device sdc1): bdev
/dev/mapper/2024-06-8tb-b errs: wr 168588727, rd 0, flush 15292,
corrupt 0, gen 0
Aug 07 09:09:28 fedora kernel: BTRFS error (device sdc1): error
writing primary super block to device 6
Aug 07 09:09:35 fedora kernel: BTRFS info (device sdc1): first mount
of filesystem a31e55af-8bbf-4f00-9ad8-1423d492d108
Aug 07 09:09:35 fedora kernel: BTRFS info (device sdc1): using crc32c
(crc32c-intel) checksum algorithm
Aug 07 09:09:35 fedora kernel: BTRFS info (device sdc1): using free-space-tree
Aug 07 09:09:35 fedora kernel: BTRFS error (device sdc1): devid 6 uuid
7fbf1832-9a2a-4b7c-93cd-e8d3dea84587 is missing
Aug 07 09:09:35 fedora kernel: BTRFS error (device sdc1): failed to
read chunk tree: -2
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147705765888
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147705769984
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147705774080
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147705778176
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147709779968
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147709784064
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147709788160
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147709792256
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147709878272
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147709882368
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147709886464
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147709890560
Aug 07 09:09:35 fedora kernel: ------------[ cut here ]------------
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147709927424
Aug 07 09:09:35 fedora kernel: WARNING: CPU: 4 PID: 1518763 at
kernel/workqueue.c:2336 __queue_work+0x4e/0x70
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147709931520
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147709935616
Aug 07 09:09:35 fedora kernel: Modules linked in: garmin_gps
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147709939712
Aug 07 09:09:35 fedora kernel:  xt_nat veth uinput uhid
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147716513792
Aug 07 09:09:35 fedora kernel:  rfcomm snd_seq_dummy
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147716517888
Aug 07 09:09:35 fedora kernel:  snd_hrtimer xt_conntrack
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147716521984
Aug 07 09:09:35 fedora kernel:  xt_MASQUERADE nf_conntrack_netlink
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147716526080
Aug 07 09:09:35 fedora kernel:  xt_addrtype nft_compat br_netfilter
bridge stp llc overlay nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722035200
Aug 07 09:09:35 fedora kernel:  nft_chain_nat nf_nat
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722039296
Aug 07 09:09:35 fedora kernel:  nf_conntrack nf_defrag_ipv6
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722043392
Aug 07 09:09:35 fedora kernel:  nf_defrag_ipv4 ip_set
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722047488
Aug 07 09:09:35 fedora kernel:  nf_tables qrtr
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722100736
Aug 07 09:09:35 fedora kernel:  bnep sunrpc
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722104832
Aug 07 09:09:35 fedora kernel:  binfmt_misc
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722108928
Aug 07 09:09:35 fedora kernel:  vfat fat
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722113024
Aug 07 09:09:35 fedora kernel:  r8153_ecm
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722149888
Aug 07 09:09:35 fedora kernel:  cdc_ether
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722153984
Aug 07 09:09:35 fedora kernel:  usbnet
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722158080
Aug 07 09:09:35 fedora kernel:  iwlmvm
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722162176
Aug 07 09:09:35 fedora kernel:  snd_hda_codec_realtek snd_hda_codec_generic
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722166272
Aug 07 09:09:35 fedora kernel:  snd_hda_scodec_component
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722170368
Aug 07 09:09:35 fedora kernel:  mac80211
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722174464
Aug 07 09:09:35 fedora kernel:  pktcdvd snd_hda_codec_hdmi
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722178560
Aug 07 09:09:35 fedora kernel:  intel_rapl_msr
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722231808
Aug 07 09:09:35 fedora kernel:  it87
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722235904
Aug 07 09:09:35 fedora kernel:  snd_hda_intel uvcvideo
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722240000
Aug 07 09:09:35 fedora kernel:  hwmon_vid
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722244096
Aug 07 09:09:35 fedora kernel:  snd_usb_audio
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722280960
Aug 07 09:09:35 fedora kernel:  libarc4
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722285056
Aug 07 09:09:35 fedora kernel:  snd_intel_dspcfg snd_intel_sdw_acpi
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722289152
Aug 07 09:09:35 fedora kernel:  uvc snd_hda_codec
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722293248
Aug 07 09:09:35 fedora kernel:  videobuf2_vmalloc snd_usbmidi_lib
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722346496
Aug 07 09:09:35 fedora kernel:  amd_atl snd_hda_core
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722350592
Aug 07 09:09:35 fedora kernel:  videobuf2_memops snd_ump
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722354688
Aug 07 09:09:35 fedora kernel:  btusb intel_rapl_common
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722358784
Aug 07 09:09:35 fedora kernel:  snd_rawmidi snd_hwdep
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722412032
Aug 07 09:09:35 fedora kernel:  videobuf2_v4l2 btrtl
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722416128
Aug 07 09:09:35 fedora kernel:  iwlwifi btintel snd_seq
videobuf2_common edac_mce_amd btbcm btmtk r8152 snd_seq_device ses
videodev gigabyte_wmi rapl wmi_bmof
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722420224
Aug 07 09:09:35 fedora kernel:  mxm_wmi acpi_cpufreq
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722424320
Aug 07 09:09:35 fedora kernel:  pcspkr
Aug 07 09:09:35 fedora kernel:  k10temp
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722428416
Aug 07 09:09:35 fedora kernel:  i2c_piix4
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722432512
Aug 07 09:09:35 fedora kernel:  mii bluetooth
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722436608
Aug 07 09:09:35 fedora kernel:  enclosure snd_pcm
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722440704
Aug 07 09:09:35 fedora kernel:  mc cfg80211
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722510336
Aug 07 09:09:35 fedora kernel:  scsi_transport_sas snd_timer
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722514432
Aug 07 09:09:35 fedora kernel:  snd igb
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722518528
Aug 07 09:09:35 fedora kernel:  r8169
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722522624
Aug 07 09:09:35 fedora kernel:  rfkill
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722575872
Aug 07 09:09:35 fedora kernel:  soundcore realtek
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722579968
Aug 07 09:09:35 fedora kernel:  dca
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722584064
Aug 07 09:09:35 fedora kernel:  joydev apple_mfi_fastcharge
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722588160
Aug 07 09:09:35 fedora kernel:  loop
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722641408
Aug 07 09:09:35 fedora kernel:  nfnetlink
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722645504
Aug 07 09:09:35 fedora kernel:  zram dm_crypt
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722649600
Aug 07 09:09:35 fedora kernel:  amdgpu video
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722653696
Aug 07 09:09:35 fedora kernel:  amdxcp
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722772480
Aug 07 09:09:35 fedora kernel:  i2c_algo_bit drm_ttm_helper
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722776576
Aug 07 09:09:35 fedora kernel:  ttm
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722780672
Aug 07 09:09:35 fedora kernel:  drm_exec crct10dif_pclmul
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147722784768
Aug 07 09:09:35 fedora kernel:  crc32_pclmul gpu_sched
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147723624448
Aug 07 09:09:35 fedora kernel:  crc32c_intel drm_suballoc_helper
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147723628544
Aug 07 09:09:35 fedora kernel:  polyval_clmulni drm_buddy
polyval_generic drm_display_helper ghash_clmulni_intel sha512_ssse3
uas cec sha256_ssse3
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147723632640
Aug 07 09:09:35 fedora kernel:  nvme
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147723636736
Aug 07 09:09:35 fedora kernel:  ccp sha1_ssse3 sp5100_tco
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147723837440
Aug 07 09:09:35 fedora kernel:  usb_storage nvme_core
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147723841536
Aug 07 09:09:35 fedora kernel:  nvme_auth
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147723845632
Aug 07 09:09:35 fedora kernel:  wmi hid_apple
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147723849728
Aug 07 09:09:35 fedora kernel:  ip6_tables ip_tables
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147723902976
Aug 07 09:09:35 fedora kernel:  fuse i2c_dev
Aug 07 09:09:35 fedora kernel: CPU: 4 PID: 1518763 Comm: kworker/u98:3
Not tainted 6.9.12-200.fc40.x86_64 #1
Aug 07 09:09:35 fedora kernel: Hardware name: Gigabyte Technology Co.,
Ltd. X570 AORUS MASTER/X570 AORUS MASTER, BIOS F38 03/22/2024
Aug 07 09:09:35 fedora kernel: Workqueue: kcryptd/253:5 kcryptd_crypt [dm_crypt]
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147723907072
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147723911168
Aug 07 09:09:35 fedora kernel:
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147723915264
Aug 07 09:09:35 fedora kernel: RIP: 0010:__queue_work+0x4e/0x70
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729391616
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729395712
Aug 07 09:09:35 fedora kernel: Code: ea 48 89 de 44 89 e7 5b 5d 41 5c
e9 dc fb ff ff 65 66 f7 05 bb 93 ee 5c 01 ff 75 0e 65 48 8b 3d a8 93
ee 5c f6 47 2c 20 75 0b <0f> 0b 5b 5d 41 5c e9 77 c5 05 01 e8 32 9f 00
00 48 85 c0 74 eb 48
Aug 07 09:09:35 fedora kernel: RSP: 0018:ffffa8075a98fe08 EFLAGS: 00010006
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729399808
Aug 07 09:09:35 fedora kernel:
Aug 07 09:09:35 fedora kernel: RAX: ffff9010b1587200 RBX:
ffff9010625ebc00 RCX: 0000000fffffffe0
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729403904
Aug 07 09:09:35 fedora kernel: RDX: ffff901704521b88 RSI:
ffff9010625ebc00 RDI: ffff901060e45180
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729489920
Aug 07 09:09:35 fedora kernel: RBP: ffff901704521b88 R08:
ffff90172b88a200 R09: 00000000001e0009
Aug 07 09:09:35 fedora kernel: R10: 00000000001e0009 R11:
ffff900f40000000 R12: 0000000000002000
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729494016
Aug 07 09:09:35 fedora kernel: R13: ffff90172b88a528 R14:
ffff9010cf0cc840 R15: 0000000000000000
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729498112
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729502208
Aug 07 09:09:35 fedora kernel: FS:  0000000000000000(0000)
GS:ffff90232e800000(0000) knlGS:0000000000000000
Aug 07 09:09:35 fedora kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729506304
Aug 07 09:09:35 fedora kernel: CR2: 000055d985480f10 CR3:
000000049b6d0000 CR4: 0000000000350ef0
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729510400
Aug 07 09:09:35 fedora kernel: Call Trace:
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729514496
Aug 07 09:09:35 fedora kernel:  <TASK>
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729518592
Aug 07 09:09:35 fedora kernel:  ? __queue_work+0x4e/0x70
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729522688
Aug 07 09:09:35 fedora kernel:  ? __warn.cold+0x8e/0xe8
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729526784
Aug 07 09:09:35 fedora kernel:  ? __queue_work+0x4e/0x70
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729530880
Aug 07 09:09:35 fedora kernel: BTRFS warning (device sdc1): folio
private not zero on folio 66147729534976
Aug 07 09:09:35 fedora kernel:  ? report_bug+0xff/0x140
Aug 07 09:09:35 fedora kernel:  ? handle_bug+0x3c/0x80
Aug 07 09:09:35 fedora kernel:  ? exc_invalid_op+0x17/0x70
Aug 07 09:09:35 fedora kernel:  ? asm_exc_invalid_op+0x1a/0x20
Aug 07 09:09:35 fedora kernel:  ? __queue_work+0x4e/0x70
Aug 07 09:09:35 fedora kernel:  ? __queue_work+0x5e/0x70
Aug 07 09:09:35 fedora kernel:  queue_work_on+0x3b/0x50
Aug 07 09:09:35 fedora kernel:  clone_endio+0x115/0x1d0
Aug 07 09:09:35 fedora kernel:  process_one_work+0x17e/0x340
Aug 07 09:09:35 fedora kernel:  worker_thread+0x266/0x3a0
Aug 07 09:09:35 fedora kernel:  ? __pfx_worker_thread+0x10/0x10
Aug 07 09:09:35 fedora kernel:  kthread+0xd2/0x100
Aug 07 09:09:35 fedora kernel:  ? __pfx_kthread+0x10/0x10
Aug 07 09:09:35 fedora kernel:  ret_from_fork+0x34/0x50
Aug 07 09:09:35 fedora kernel:  ? __pfx_kthread+0x10/0x10
Aug 07 09:09:35 fedora kernel:  ret_from_fork_asm+0x1a/0x30
Aug 07 09:09:35 fedora kernel:  </TASK>
Aug 07 09:09:35 fedora kernel: ---[ end trace 0000000000000000 ]---
Aug 07 09:09:35 fedora kernel: BTRFS error (device sdc1): open_ctree failed
Aug 07 09:13:41 fedora kernel: BTRFS info (device sdc1): first mount
of filesystem a31e55af-8bbf-4f00-9ad8-1423d492d108
Aug 07 09:13:41 fedora kernel: BTRFS info (device sdc1): using crc32c
(crc32c-intel) checksum algorithm
Aug 07 09:13:41 fedora kernel: BTRFS info (device sdc1): using free-space-tree
Aug 07 09:13:41 fedora kernel: BTRFS error (device sdc1): devid 6 uuid
7fbf1832-9a2a-4b7c-93cd-e8d3dea84587 is missing
Aug 07 09:13:41 fedora kernel: BTRFS error (device sdc1): failed to
read chunk tree: -2
Aug 07 09:13:41 fedora kernel: BTRFS error (device sdc1): open_ctree failed
Aug 07 09:13:47 fedora kernel: BTRFS info (device sdc1): first mount
of filesystem a31e55af-8bbf-4f00-9ad8-1423d492d108
Aug 07 09:13:47 fedora kernel: BTRFS info (device sdc1): using crc32c
(crc32c-intel) checksum algorithm
Aug 07 09:13:47 fedora kernel: BTRFS info (device sdc1): using free-space-tree
Aug 07 09:13:47 fedora kernel: _btrfs_printk: 48 callbacks suppressed
Aug 07 09:13:47 fedora kernel: BTRFS warning (device sdc1): devid 6
uuid 7fbf1832-9a2a-4b7c-93cd-e8d3dea84587 is missing
Aug 07 09:13:49 fedora kernel: BTRFS info (device sdc1): bdev <missing
disk> errs: wr 168588724, rd 0, flush 15291, corrupt 0, gen 0
Aug 07 09:14:30 fedora kernel: BTRFS info (device sdc1): relocating
block group 66153101656064 flags data|raid6


Then I mounted it degraded

# mount -o degraded /dev/mapper/2024-07-24tb /mnt/btrfs-raid6-4tb/

and tried removing the missing device

# btrfs device remove missing /mnt/btrfs-raid6-4tb
ERROR: error removing device 'missing': Input/output error

...and that's where I'm at now. I can't remove the disk, but the
volume is mounted (degraded) and I can read files.

Thanks for reading this far!

