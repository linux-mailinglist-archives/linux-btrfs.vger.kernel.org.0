Return-Path: <linux-btrfs+bounces-12970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DA1A87200
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Apr 2025 14:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9472F3A905F
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Apr 2025 12:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD4F1B0F31;
	Sun, 13 Apr 2025 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCycmwh2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215B3C1F
	for <linux-btrfs@vger.kernel.org>; Sun, 13 Apr 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744548846; cv=none; b=oGZzFHM0JjAK52cip6LN3cLPipskseGFEHlXpO6WBqYEdXwI6DrblY1IpuEogLsUiGtHhPcU1SZm+9Oh9sbCKk5jv2V+7qIVeFBQh1DstEGMbI/AzX2bZF0p72ydpj8Rbyy9LVpCU1Yo+UZ1REbH3FZoAEwVXye67jIO4RQWlhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744548846; c=relaxed/simple;
	bh=YZmI9HY6LXDrQzLbxvvXTdEwM5GLA709zv+ZPUwv2w0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qp+8iDZ3ox+Mu8hEyspyT3HdVY9FV3Rf0XdHruPhzgoQEK21eTQ7jgFPwJ0QN/ORMi+6spcTkmdDVQgtaBymyEmr9T4tUP6gih681kM1Fz9tJsPg8J6ljzMtRAiRaQoxneZblse6SbZRPPEVRZNInHt5cHrSxcN/6aSsdWbyI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCycmwh2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744548841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=BSPHR2Vgdapr/qzaLBOCTBsJ5euRJW1xI4caWEap0PA=;
	b=JCycmwh2eDfyQb9Lhb6I7rcY5fT6y6tSjR0LS4UQfUFaEspQW2NEj3JP7ZVZ8o2zipM6Kf
	1o14MRLRAHYnwVA7Lx9odaK4zCcqfKG5t9qCxql0aBzhnXhvPLbhTvpo/W9lxh9SVg5MBp
	pBcMIf02oxk+WJPCQ1eQ73JSjS63A50=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-Uv4q21UvMS2XPIwPVUkMCQ-1; Sun, 13 Apr 2025 08:53:57 -0400
X-MC-Unique: Uv4q21UvMS2XPIwPVUkMCQ-1
X-Mimecast-MFC-AGG-ID: Uv4q21UvMS2XPIwPVUkMCQ_1744548837
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff8340d547so3060286a91.2
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Apr 2025 05:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744548836; x=1745153636;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSPHR2Vgdapr/qzaLBOCTBsJ5euRJW1xI4caWEap0PA=;
        b=pJgNMVhQDCdRYjAtMK48VI8D8nWPGsPoy/kZIAR7Y7ELxad24cV6EhgJrxNrImN2l3
         pvVzv2k80ikSWPtTgx5eCVgn1o9n2OH81pJdGUaAP2JKkbeus/1P+mjUvEea28rhUOE9
         KSoihJ7eeUFKTmWZH8h+Ru/RNf7sJxTNzJBO+vk2D8n9z8ScJWoQofvKUazwZ6L/8CNa
         5JM9WvQ71v8eiFKWcWGnuADEYk9EHoXtMIXdaJ2H10+w+JxctxzZhffmIzvpaGSjM6Xz
         PulrOs/0F9KD+ucrZF6n47jnovesGqRasKl/R3suLVf4dydpn0o3aO3+DPgt9nB3/GTr
         tvwg==
X-Gm-Message-State: AOJu0YyQJoN7fzuH+9MBA7pczu8UDtmrxrIJ+scaynpj7RhxTj73OxBW
	dBT9pAQwvrA1E8Obt1G2Zt9HIVe79psBJaWZJS8tZxxJ39hhJJTdLqmOSO5hgjTFURgXUPv0HBb
	8QgiRxtvQfGzJdm5kEMR5nhHhTWPlZp/VVRKd4ni0JDTKIozvc8SMpMMKg6RscR0p1QzTYZ0e9J
	WP21ximta5kNtk+WbKaKBWVJpeGLVcnpp2l+RHO5sE
X-Gm-Gg: ASbGncs69LUfw8ZJo2vzCRCClGK7QBqamR2AHSRmuFkBAmhwMAA+Du3ZUioEUoq0SlJ
	eU26Qq0RUlo7/zE5EjOovciKWoWvIZglGiSX2XK1/dch87r6/i9mOL7lH0HL+r51Oz6OX33Ehj8
	jDg5pT1LiNWLIqRyUA08+2/NVxXgvNupDi6wQxNbuo+c2YFBPx18Bol1HbrSSYlw7zAnviehOXH
	Q5jvRWtjxIydDuPU7/jB5cRfhYKoXa7vC0VEkhYkRlG3quR8O2cML8vLUs5Ef4drzjWrIcI8IYO
	eQSGOlDAIpPkg29EFmPS2LMxoYc6bNJDrSeSuiMUhBr6UBfXGTf3
X-Received: by 2002:a17:90a:d64e:b0:301:1bce:c252 with SMTP id 98e67ed59e1d1-30823672e78mr12834852a91.27.1744548835336;
        Sun, 13 Apr 2025 05:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETjUyNrU+u4nM3ak6IPWsSn83h10xuZQaOKgeBmGe3rj36pSCkVPgtqo+VxKo0ztyvJYtvzQ==
X-Received: by 2002:a17:90a:d64e:b0:301:1bce:c252 with SMTP id 98e67ed59e1d1-30823672e78mr12834791a91.27.1744548833937;
        Sun, 13 Apr 2025 05:53:53 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e666sm9449758a91.15.2025.04.13.05.53.52
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 05:53:53 -0700 (PDT)
Date: Sun, 13 Apr 2025 20:53:49 +0800
From: Zorro Lang <zlang@redhat.com>
To: linux-btrfs@vger.kernel.org
Subject: [xfstests generic/619] hang on aarch64 with btrfs
Message-ID: <20250413125349.w5jxnnphr7wliib5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Recently I ran fstests on aarch64 with btrfs (default options), then I the test
was always blocked on generic/619:
  FSTYP         -- btrfs
  PLATFORM      -- Linux/aarch64 nvidia-grace-hopper-02 6.15.0-rc1+ #1 SMP PREEMPT_DYNAMIC Sun Apr 13 01:44:03 EDT 2025
  MKFS_OPTIONS  -- /dev/sda6
  MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda6 /mnt/xfstests/scratch

  generic/619
  (can't be end even 2 days)

The console log as [1], .full output as [2], Show Blocked State as [3]. This
test is good on x86_64. Currently I reproduced this issue on aarch64 5 times
on linux v6.14 and v6.15-rc1+(current latest).

Thanks,
Zorro

[1]
[  561.542894] run fstests generic/619 at 2025-04-13 02:04:25 
[  562.559987] BTRFS: device fsid d47723ad-8c22-4fda-bc03-e4b066d65949 devid 1 transid 8 /dev/sda6 (8:6) scanned by mount (59370) 
[  562.565411] BTRFS info (device sda6): first mount of filesystem d47723ad-8c22-4fda-bc03-e4b066d65949 
[  562.565439] BTRFS info (device sda6): using crc32c (crc32c-arm64) checksum algorithm 
[  562.565450] BTRFS info (device sda6): using free-space-tree 
[  562.571357] BTRFS info (device sda6): checking UUID tree 
[  566.551331] BTRFS info (device sda6): last unmount of filesystem d47723ad-8c22-4fda-bc03-e4b066d65949 
[  566.659412] BTRFS: device fsid 6fe59e99-2b74-4a40-8b59-4a1bb3dfcf91 devid 1 transid 8 /dev/sda6 (8:6) scanned by mount (59751) 
[  566.665223] BTRFS info (device sda6): first mount of filesystem 6fe59e99-2b74-4a40-8b59-4a1bb3dfcf91 
[  566.665253] BTRFS info (device sda6): using crc32c (crc32c-arm64) checksum algorithm 
[  566.665264] BTRFS info (device sda6): using free-space-tree 
[  566.681944] BTRFS info (device sda6): checking UUID tree 
[  570.187145] BTRFS info (device sda6): last unmount of filesystem 6fe59e99-2b74-4a40-8b59-4a1bb3dfcf91 
[  570.294361] BTRFS: device fsid 2c6fe48c-7446-47cb-a56e-6519fffd557b devid 1 transid 8 /dev/sda6 (8:6) scanned by mount (60130) 
[  570.299144] BTRFS info (device sda6): first mount of filesystem 2c6fe48c-7446-47cb-a56e-6519fffd557b 
[  570.299172] BTRFS info (device sda6): using crc32c (crc32c-arm64) checksum algorithm 
[  570.299183] BTRFS info (device sda6): using free-space-tree 
[  570.307208] BTRFS info (device sda6): checking UUID tree 
[  574.078872] BTRFS info (device sda6): last unmount of filesystem 2c6fe48c-7446-47cb-a56e-6519fffd557b 
[  574.194933] BTRFS: device fsid 0d34b451-c95c-4ad0-902b-da96d702c113 devid 1 transid 8 /dev/sda6 (8:6) scanned by mount (60510) 
[  574.205513] BTRFS info (device sda6): first mount of filesystem 0d34b451-c95c-4ad0-902b-da96d702c113 
[  574.205542] BTRFS info (device sda6): using crc32c (crc32c-arm64) checksum algorithm 
[  574.205552] BTRFS info (device sda6): using free-space-tree 
[  574.212221] BTRFS info (device sda6): checking UUID tree 
[  578.181579] BTRFS info (device sda6): last unmount of filesystem 0d34b451-c95c-4ad0-902b-da96d702c113 
[  578.294765] BTRFS: device fsid e75a70cf-0435-4af4-8056-98b18bf74947 devid 1 transid 8 /dev/sda6 (8:6) scanned by mount (60674) 
[  578.305043] BTRFS info (device sda6): first mount of filesystem e75a70cf-0435-4af4-8056-98b18bf74947 
[  578.305072] BTRFS info (device sda6): using crc32c (crc32c-arm64) checksum algorithm 
[  578.305083] BTRFS info (device sda6): using free-space-tree 
[  578.311568] BTRFS info (device sda6): checking UUID tree 
[  582.807913] BTRFS info (device sda6): last unmount of filesystem e75a70cf-0435-4af4-8056-98b18bf74947 
[  582.917363] BTRFS: device fsid 21440567-bf83-4bc1-b6c5-f591c1eec812 devid 1 transid 8 /dev/sda6 (8:6) scanned by mount (60839) 
[  582.921938] BTRFS info (device sda6): first mount of filesystem 21440567-bf83-4bc1-b6c5-f591c1eec812 
[  582.921968] BTRFS info (device sda6): using crc32c (crc32c-arm64) checksum algorithm 
[  582.921978] BTRFS info (device sda6): using free-space-tree 
[  582.928020] BTRFS info (device sda6): checking UUID tree 
[  587.641264] BTRFS info (device sda6): last unmount of filesystem 21440567-bf83-4bc1-b6c5-f591c1eec812 
[  587.756124] BTRFS: device fsid 15ba9b83-977d-40f4-829f-326c03943c77 devid 1 transid 8 /dev/sda6 (8:6) scanned by mount (60999) 
[  587.761213] BTRFS info (device sda6): first mount of filesystem 15ba9b83-977d-40f4-829f-326c03943c77 
[  587.761242] BTRFS info (device sda6): using crc32c (crc32c-arm64) checksum algorithm 
[  587.761252] BTRFS info (device sda6): using free-space-tree 
[  587.767305] BTRFS info (device sda6): checking UUID tree 
[  591.396386] BTRFS info (device sda6): last unmount of filesystem 15ba9b83-977d-40f4-829f-326c03943c77 
[  591.504509] BTRFS: device fsid 7af670c0-7e58-4f66-9ab3-9a7c4a401d74 devid 1 transid 8 /dev/sda6 (8:6) scanned by mount (61216) 
[  591.510204] BTRFS info (device sda6): first mount of filesystem 7af670c0-7e58-4f66-9ab3-9a7c4a401d74 
[  591.510234] BTRFS info (device sda6): using crc32c (crc32c-arm64) checksum algorithm 
[  591.510245] BTRFS info (device sda6): using free-space-tree 
[  591.516369] BTRFS info (device sda6): checking UUID tree 
[-- MARK -- Sun Apr 13 06:05:00 2025] 
[  596.221636] BTRFS info (device sda6): last unmount of filesystem 7af670c0-7e58-4f66-9ab3-9a7c4a401d74 
[  596.332763] BTRFS: device fsid 2ed66aa7-d26b-4621-86db-74a8ee72a7eb devid 1 transid 8 /dev/sda6 (8:6) scanned by mount (61431) 
[  596.345112] BTRFS info (device sda6): first mount of filesystem 2ed66aa7-d26b-4621-86db-74a8ee72a7eb 
[  596.345150] BTRFS info (device sda6): using crc32c (crc32c-arm64) checksum algorithm 
[  596.345161] BTRFS info (device sda6): using free-space-tree 
[  596.350868] BTRFS info (device sda6): checking UUID tree 
[  600.047444] BTRFS info (device sda6): last unmount of filesystem 2ed66aa7-d26b-4621-86db-74a8ee72a7eb 
[  600.162231] BTRFS: device fsid aea1ca61-f15a-4bb0-bc8d-47c1236c9df2 devid 1 transid 8 /dev/sda6 (8:6) scanned by mount (61649) 
[  600.167621] BTRFS info (device sda6): first mount of filesystem aea1ca61-f15a-4bb0-bc8d-47c1236c9df2 
[  600.167650] BTRFS info (device sda6): using crc32c (crc32c-arm64) checksum algorithm 
[  600.167660] BTRFS info (device sda6): using free-space-tree 
[  600.174453] BTRFS info (device sda6): checking UUID tree 
[-- MARK -- Sun Apr 13 06:10:00 2025] 
[-- MARK -- Sun Apr 13 06:15:00 2025] 
[-- MARK -- Sun Apr 13 06:20:00 2025] 
[ 1512.501008] nvme nvme0: using unchecked data buffer 
[ 1512.524807] block nvme0n1: No UUID available providing old NGUID 
[-- MARK -- Sun Apr 13 06:25:00 2025] 
[-- MARK -- Sun Apr 13 06:30:00 2025] 
[-- MARK -- Sun Apr 13 06:35:00 2025] 
...
...
[-- MARK -- Sun Apr 13 12:25:00 2025] 
[-- MARK -- Sun Apr 13 12:30:00 2025]
...
...

[2]
============ Test details start ============
Test name: Small-file-fallocate-test
File ratio unit: 524288
File ratio: 1
Disk saturation 0.7
Disk alloc method 1
Test iteration count: 3
Extra arg:  -f -v
btrfs-progs v6.14
See https://btrfs.readthedocs.io for more information.

Performing full device TRIM /dev/sda6 (240.00MiB) ...
NOTE: several default settings have changed in version 5.15, please make sure
      this does not affect your deployments:
      - DUP for metadata (-m dup)
      - enabled no-holes (-O no-holes)
      - enabled free-space-tree (-R free-space-tree)

Label:              (null)
UUID:               d47723ad-8c22-4fda-bc03-e4b066d65949
Node size:          4096
Sector size:        4096        (CPU page size: 4096)
Filesystem size:    240.00MiB
Block group profiles:
  Data+Metadata:    single            8.00MiB
  System:           single            4.00MiB
SSD detected:       yes
Zoned device:       no
Features:           mixed-bg, extref, skinny-metadata, no-holes, free-space-tree
Checksum:           crc32c
Number of devices:  1
Devices:
   ID        SIZE  PATH     
    1   240.00MiB  /dev/sda6

===== Test: Small-file-fallocate-test iteration: 1 starts =====
Total available size: 246382592
Available size: 172467814.4
Thread count: 328
Testing with (328) threads
size: 524288 Bytes
Test write phase starting file /mnt/xfstests/scratch/mmap-file-1 fsize 524288, id 1
Test write phase starting file /mnt/xfstests/scratch/mmap-file-0 fsize 524288, id 0
Test write phase starting file /mnt/xfstests/scratch/mmap-file-3 fsize 524288, id 3
...
...
Test write phase starting file /mnt/xfstests/scratch/mmap-file-241 fsize 524288, id 241
Test write phase starting file /mnt/xfstests/scratch/mmap-file-185 fsize 524288, id 185
Test write phase starting file /mnt/xfstests/scratch/mmap-file-244 fsize 524288, id 244
Test write phase starting file /mnt/xfstests/scratch/mmap-file-246 fsize 524288, id 246
Test write phase starting file /mnt/xfstests/scratch/mmap-file-243 fsize 524288, id 243
Test write phase starting file /mnt/xfstests/scratch/mmap-file-248 fsize 524288, id 248
Test write phase starting file /mnt/xfstests/scratch/mmap-file-247 fsize 524288, id 247
Test write phase starting file /mnt/xfstests/scratch/mmap-file-74 fsize 524288, id 74
Test write phase starting file /mnt/xfstests/scratch/mmap-file-277 fsize 524288, id 277
Test write phase starting file /mnt/xfstests/scratch/mmap-file-72 fsize 524288, id 72
Test write phase starting file /mnt/xfstests/scratch/mmap-file-131 fsize 524288, id 131
Test write phase starting file /mnt/xfstests/scratch/mmap-file-281 fsize 524288, id 281
Test write phase starting file /mnt/xfstests/scratch/mmap-file-282 fsize 524288, id 282
Test write phase starting file /mnt/xfstests/scratch/mmap-file-278 fsize 524288, id 278
Test write phase starting file /mnt/xfstests/scratch/mmap-file-101 fsi
(no more)


[3]
# ps aux|grep enospc
root       61679 20.1  0.0 2873604 17524 ?       Sl   02:05  78:36 /var/lib/xfstests/src/t_enospc -t 328 -s 524288 -r 1 -p /mnt/xfstests/scratch -v
root       71571  0.0  0.0   6192  1788 pts/0    S+   08:34   0:00 grep --color=auto enospc
[root@nvidia-grace-hopper-02 ~]# cat /proc/
Display all 921 possibilities? (y or n)
[root@nvidia-grace-hopper-02 ~]# cat /proc/61679/stack 
[<0>] futex_wait_queue+0x104/0x210
[<0>] __futex_wait+0x184/0x268
[<0>] futex_wait+0xf4/0x2c8
[<0>] do_futex+0x17c/0x240
[<0>] __arm64_sys_futex+0x1d8/0x308
[<0>] invoke_syscall.constprop.0+0xdc/0x1e8
[<0>] do_el0_svc+0x154/0x1d0
[<0>] el0_svc+0x54/0x140
[<0>] el0t_64_sync_handler+0x10c/0x138
[<0>] el0t_64_sync+0x1ac/0x1b0
# echo w > /proc/sysrq-trigger
# dmesg
[23843.226599] sysrq: Show Blocked State
[23843.227353] task:t_enospc        state:D stack:24272 pid:61684 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.227368] Call trace:
[23843.227371]  __switch_to+0x1f8/0x328 (T)
[23843.227381]  __schedule+0x734/0x1428
[23843.227384]  schedule+0xd0/0x240
[23843.227386]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.227474]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.227536]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.227593]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.227650]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.227705]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.227767]  do_page_mkwrite+0x13c/0x2a8
[23843.227774]  do_wp_page+0x2c4/0x10e0
[23843.227778]  handle_pte_fault+0x578/0x7c0
[23843.227780]  __handle_mm_fault+0x2e8/0xa70
[23843.227783]  handle_mm_fault+0x20c/0x8a8
[23843.227785]  do_page_fault+0x26c/0x1050
[23843.227790]  do_mem_abort+0x70/0x1c0
[23843.227794]  el0_da+0x5c/0x150
[23843.227797]  el0t_64_sync_handler+0xc4/0x138
[23843.227800]  el0t_64_sync+0x1ac/0x1b0
[23843.227805] task:t_enospc        state:D stack:25616 pid:61687 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.227813] Call trace:
[23843.227815]  __switch_to+0x1f8/0x328 (T)
[23843.227817]  __schedule+0x734/0x1428
[23843.227819]  schedule+0xd0/0x240
[23843.227821]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.227877]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.227932]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.227987]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.228045]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.228101]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.228157]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.228212]  file_update_time+0x10c/0x178
[23843.228217]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.228273]  do_page_mkwrite+0x13c/0x2a8
[23843.228276]  do_wp_page+0x2c4/0x10e0
[23843.228279]  handle_pte_fault+0x578/0x7c0
[23843.228282]  __handle_mm_fault+0x2e8/0xa70
[23843.228284]  handle_mm_fault+0x20c/0x8a8
[23843.228286]  do_page_fault+0x26c/0x1050
[23843.228290]  do_mem_abort+0x70/0x1c0
[23843.228293]  el0_da+0x5c/0x150
[23843.228296]  el0t_64_sync_handler+0xc4/0x138
[23843.228298]  el0t_64_sync+0x1ac/0x1b0
[23843.228302] task:t_enospc        state:D stack:25856 pid:61690 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.228311] Call trace:
[23843.228312]  __switch_to+0x1f8/0x328 (T)
[23843.228314]  __schedule+0x734/0x1428
[23843.228316]  schedule+0xd0/0x240
[23843.228319]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.228373]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.228428]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.228483]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.228538]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.228592]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.228648]  do_page_mkwrite+0x13c/0x2a8
[23843.228651]  do_wp_page+0x2c4/0x10e0
[23843.228654]  handle_pte_fault+0x578/0x7c0
[23843.228657]  __handle_mm_fault+0x2e8/0xa70
[23843.228659]  handle_mm_fault+0x20c/0x8a8
[23843.228661]  do_page_fault+0x26c/0x1050
[23843.228664]  do_mem_abort+0x70/0x1c0
[23843.228667]  el0_da+0x5c/0x150
[23843.228670]  el0t_64_sync_handler+0xc4/0x138
[23843.228673]  el0t_64_sync+0x1ac/0x1b0
[23843.228677] task:t_enospc        state:D stack:24224 pid:61691 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.228685] Call trace:
[23843.228686]  __switch_to+0x1f8/0x328 (T)
[23843.228688]  __schedule+0x734/0x1428
[23843.228690]  schedule+0xd0/0x240
[23843.228692]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.228747]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.228801]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.228856]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.228911]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.228965]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.229020]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.229075]  file_update_time+0x10c/0x178
[23843.229078]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.229132]  do_page_mkwrite+0x13c/0x2a8
[23843.229136]  do_wp_page+0x2c4/0x10e0
[23843.229139]  handle_pte_fault+0x578/0x7c0
[23843.229141]  __handle_mm_fault+0x2e8/0xa70
[23843.229143]  handle_mm_fault+0x20c/0x8a8
[23843.229145]  do_page_fault+0x26c/0x1050
[23843.229148]  do_mem_abort+0x70/0x1c0
[23843.229151]  el0_da+0x5c/0x150
[23843.229153]  el0t_64_sync_handler+0xc4/0x138
[23843.229156]  el0t_64_sync+0x1ac/0x1b0
[23843.229160] task:t_enospc        state:D stack:25488 pid:61692 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.229169] Call trace:
[23843.229170]  __switch_to+0x1f8/0x328 (T)
[23843.229172]  __schedule+0x734/0x1428
[23843.229174]  schedule+0xd0/0x240
[23843.229176]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.229230]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.229284]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.229338]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.229433]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.229490]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.229545]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.229600]  file_update_time+0x10c/0x178
[23843.229604]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.229658]  do_page_mkwrite+0x13c/0x2a8
[23843.229662]  do_wp_page+0x2c4/0x10e0
[23843.229665]  handle_pte_fault+0x578/0x7c0
[23843.229667]  __handle_mm_fault+0x2e8/0xa70
[23843.229670]  handle_mm_fault+0x20c/0x8a8
[23843.229672]  do_page_fault+0x26c/0x1050
[23843.229675]  do_mem_abort+0x70/0x1c0
[23843.229678]  el0_da+0x5c/0x150
[23843.229681]  el0t_64_sync_handler+0xc4/0x138
[23843.229684]  el0t_64_sync+0x1ac/0x1b0
[23843.229688] task:t_enospc        state:D stack:25488 pid:61693 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.229697] Call trace:
[23843.229698]  __switch_to+0x1f8/0x328 (T)
[23843.229700]  __schedule+0x734/0x1428
[23843.229702]  schedule+0xd0/0x240
[23843.229704]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.229759]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.229813]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.229867]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.229921]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.229975]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.230030]  do_page_mkwrite+0x13c/0x2a8
[23843.230033]  do_wp_page+0x2c4/0x10e0
[23843.230036]  handle_pte_fault+0x578/0x7c0
[23843.230038]  __handle_mm_fault+0x2e8/0xa70
[23843.230040]  handle_mm_fault+0x20c/0x8a8
[23843.230043]  do_page_fault+0x26c/0x1050
[23843.230046]  do_mem_abort+0x70/0x1c0
[23843.230048]  el0_da+0x5c/0x150
[23843.230051]  el0t_64_sync_handler+0xc4/0x138
[23843.230053]  el0t_64_sync+0x1ac/0x1b0
[23843.230057] task:t_enospc        state:D stack:25856 pid:61694 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.230065] Call trace:
[23843.230066]  __switch_to+0x1f8/0x328 (T)
[23843.230068]  __schedule+0x734/0x1428
[23843.230070]  schedule+0xd0/0x240
[23843.230072]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.230126]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.230180]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.230234]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.230289]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.230343]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.230398]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.230452]  file_update_time+0x10c/0x178
[23843.230456]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.230510]  do_page_mkwrite+0x13c/0x2a8
[23843.230513]  do_wp_page+0x2c4/0x10e0
[23843.230517]  handle_pte_fault+0x578/0x7c0
[23843.230519]  __handle_mm_fault+0x2e8/0xa70
[23843.230521]  handle_mm_fault+0x20c/0x8a8
[23843.230524]  do_page_fault+0x26c/0x1050
[23843.230527]  do_mem_abort+0x70/0x1c0
[23843.230530]  el0_da+0x5c/0x150
[23843.230533]  el0t_64_sync_handler+0xc4/0x138
[23843.230536]  el0t_64_sync+0x1ac/0x1b0
[23843.230540] task:t_enospc        state:D stack:25856 pid:61695 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.230548] Call trace:
[23843.230549]  __switch_to+0x1f8/0x328 (T)
[23843.230552]  __schedule+0x734/0x1428
[23843.230554]  schedule+0xd0/0x240
[23843.230557]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.230620]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.230679]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.230737]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.230795]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.230853]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.230912]  do_page_mkwrite+0x13c/0x2a8
[23843.230917]  do_wp_page+0x2c4/0x10e0
[23843.230921]  handle_pte_fault+0x578/0x7c0
[23843.230923]  __handle_mm_fault+0x2e8/0xa70
[23843.230926]  handle_mm_fault+0x20c/0x8a8
[23843.230934]  do_page_fault+0x26c/0x1050
[23843.230940]  do_mem_abort+0x70/0x1c0
[23843.230945]  el0_da+0x5c/0x150
[23843.230948]  el0t_64_sync_handler+0xc4/0x138
[23843.230951]  el0t_64_sync+0x1ac/0x1b0
[23843.230957] task:t_enospc        state:D stack:25856 pid:61696 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.230974] Call trace:
[23843.230977]  __switch_to+0x1f8/0x328 (T)
[23843.230981]  __schedule+0x734/0x1428
[23843.230983]  schedule+0xd0/0x240
[23843.230987]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.231045]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.231103]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.231161]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.231219]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.231277]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.231335]  do_page_mkwrite+0x13c/0x2a8
[23843.231340]  do_wp_page+0x2c4/0x10e0
[23843.231343]  handle_pte_fault+0x578/0x7c0
[23843.231348]  __handle_mm_fault+0x2e8/0xa70
[23843.231351]  handle_mm_fault+0x20c/0x8a8
[23843.231358]  do_page_fault+0x26c/0x1050
[23843.231362]  do_mem_abort+0x70/0x1c0
[23843.231366]  el0_da+0x5c/0x150
[23843.231377]  el0t_64_sync_handler+0xc4/0x138
[23843.231382]  el0t_64_sync+0x1ac/0x1b0
[23843.231388] task:t_enospc        state:D stack:25296 pid:61697 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.231401] Call trace:
[23843.231404]  __switch_to+0x1f8/0x328 (T)
[23843.231408]  __schedule+0x734/0x1428
[23843.231413]  schedule+0xd0/0x240
[23843.231415]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.231474]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.231531]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.231589]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.231646]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.231704]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.231762]  do_page_mkwrite+0x13c/0x2a8
[23843.231767]  do_wp_page+0x2c4/0x10e0
[23843.231771]  handle_pte_fault+0x578/0x7c0
[23843.231774]  __handle_mm_fault+0x2e8/0xa70
[23843.231776]  handle_mm_fault+0x20c/0x8a8
[23843.231784]  do_page_fault+0x26c/0x1050
[23843.231790]  do_mem_abort+0x70/0x1c0
[23843.231793]  el0_da+0x5c/0x150
[23843.231797]  el0t_64_sync_handler+0xc4/0x138
[23843.231800]  el0t_64_sync+0x1ac/0x1b0
[23843.231804] task:t_enospc        state:D stack:24560 pid:61698 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.231822] Call trace:
[23843.231824]  __switch_to+0x1f8/0x328 (T)
[23843.231826]  __schedule+0x734/0x1428
[23843.231829]  schedule+0xd0/0x240
[23843.231833]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.231890]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.231948]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.232006]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.232064]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.232121]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.232180]  do_page_mkwrite+0x13c/0x2a8
[23843.232183]  do_wp_page+0x2c4/0x10e0
[23843.232189]  handle_pte_fault+0x578/0x7c0
[23843.232192]  __handle_mm_fault+0x2e8/0xa70
[23843.232194]  handle_mm_fault+0x20c/0x8a8
[23843.232199]  do_page_fault+0x26c/0x1050
[23843.232204]  do_mem_abort+0x70/0x1c0
[23843.232210]  el0_da+0x5c/0x150
[23843.232213]  el0t_64_sync_handler+0xc4/0x138
[23843.232216]  el0t_64_sync+0x1ac/0x1b0
[23843.232224] task:t_enospc        state:D stack:25424 pid:61699 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.232237] Call trace:
[23843.232240]  __switch_to+0x1f8/0x328 (T)
[23843.232244]  __schedule+0x734/0x1428
[23843.232248]  schedule+0xd0/0x240
[23843.232251]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.232309]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.232366]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.232424]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.232481]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.232539]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.232597]  do_page_mkwrite+0x13c/0x2a8
[23843.232602]  do_wp_page+0x2c4/0x10e0
[23843.232606]  handle_pte_fault+0x578/0x7c0
[23843.232608]  __handle_mm_fault+0x2e8/0xa70
[23843.232611]  handle_mm_fault+0x20c/0x8a8
[23843.232613]  do_page_fault+0x26c/0x1050
[23843.232617]  do_mem_abort+0x70/0x1c0
[23843.232622]  el0_da+0x5c/0x150
[23843.232628]  el0t_64_sync_handler+0xc4/0x138
[23843.232633]  el0t_64_sync+0x1ac/0x1b0
[23843.232637] task:t_enospc        state:D stack:25856 pid:61700 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.232649] Call trace:
[23843.232652]  __switch_to+0x1f8/0x328 (T)
[23843.232656]  __schedule+0x734/0x1428
[23843.232661]  schedule+0xd0/0x240
[23843.232664]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.232722]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.232780]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.232837]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.232895]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.232953]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.233011]  do_page_mkwrite+0x13c/0x2a8
[23843.233016]  do_wp_page+0x2c4/0x10e0
[23843.233019]  handle_pte_fault+0x578/0x7c0
[23843.233022]  __handle_mm_fault+0x2e8/0xa70
[23843.233024]  handle_mm_fault+0x20c/0x8a8
[23843.233029]  do_page_fault+0x26c/0x1050
[23843.233032]  do_mem_abort+0x70/0x1c0
[23843.233039]  el0_da+0x5c/0x150
[23843.233044]  el0t_64_sync_handler+0xc4/0x138
[23843.233047]  el0t_64_sync+0x1ac/0x1b0
[23843.233052] task:t_enospc        state:D stack:25856 pid:61701 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.233063] Call trace:
[23843.233066]  __switch_to+0x1f8/0x328 (T)
[23843.233070]  __schedule+0x734/0x1428
[23843.233075]  schedule+0xd0/0x240
[23843.233078]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.233136]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.233193]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.233251]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.233310]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.233368]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.233426]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.233484]  file_update_time+0x10c/0x178
[23843.233489]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.233548]  do_page_mkwrite+0x13c/0x2a8
[23843.233551]  do_wp_page+0x2c4/0x10e0
[23843.233556]  handle_pte_fault+0x578/0x7c0
[23843.233558]  __handle_mm_fault+0x2e8/0xa70
[23843.233561]  handle_mm_fault+0x20c/0x8a8
[23843.233566]  do_page_fault+0x26c/0x1050
[23843.233569]  do_mem_abort+0x70/0x1c0
[23843.233576]  el0_da+0x5c/0x150
[23843.233580]  el0t_64_sync_handler+0xc4/0x138
[23843.233583]  el0t_64_sync+0x1ac/0x1b0
[23843.233590] task:t_enospc        state:D stack:23936 pid:61702 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.233601] Call trace:
[23843.233604]  __switch_to+0x1f8/0x328 (T)
[23843.233608]  __schedule+0x734/0x1428
[23843.233613]  schedule+0xd0/0x240
[23843.233616]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.233673]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.233731]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.233788]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.233847]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.233905]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.233963]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.234022]  file_update_time+0x10c/0x178
[23843.234027]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.234084]  do_page_mkwrite+0x13c/0x2a8
[23843.234088]  do_wp_page+0x2c4/0x10e0
[23843.234095]  handle_pte_fault+0x578/0x7c0
[23843.234097]  __handle_mm_fault+0x2e8/0xa70
[23843.234100]  handle_mm_fault+0x20c/0x8a8
[23843.234103]  do_page_fault+0x26c/0x1050
[23843.234112]  do_mem_abort+0x70/0x1c0
[23843.234116]  el0_da+0x5c/0x150
[23843.234121]  el0t_64_sync_handler+0xc4/0x138
[23843.234125]  el0t_64_sync+0x1ac/0x1b0
[23843.234129] task:t_enospc        state:D stack:24400 pid:61703 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.234142] Call trace:
[23843.234145]  __switch_to+0x1f8/0x328 (T)
[23843.234148]  __schedule+0x734/0x1428
[23843.234152]  schedule+0xd0/0x240
[23843.234155]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.234213]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.234270]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.234328]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.234386]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.234444]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.234502]  do_page_mkwrite+0x13c/0x2a8
[23843.234508]  do_wp_page+0x2c4/0x10e0
[23843.234511]  handle_pte_fault+0x578/0x7c0
[23843.234514]  __handle_mm_fault+0x2e8/0xa70
[23843.234516]  handle_mm_fault+0x20c/0x8a8
[23843.234521]  do_page_fault+0x26c/0x1050
[23843.234524]  do_mem_abort+0x70/0x1c0
[23843.234531]  el0_da+0x5c/0x150
[23843.234536]  el0t_64_sync_handler+0xc4/0x138
[23843.234539]  el0t_64_sync+0x1ac/0x1b0
[23843.234545] task:t_enospc        state:D stack:24496 pid:61704 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.234556] Call trace:
[23843.234560]  __switch_to+0x1f8/0x328 (T)
[23843.234564]  __schedule+0x734/0x1428
[23843.234568]  schedule+0xd0/0x240
[23843.234571]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.234628]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.234686]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.234744]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.234802]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.234860]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.234918]  do_page_mkwrite+0x13c/0x2a8
[23843.234923]  do_wp_page+0x2c4/0x10e0
[23843.234927]  handle_pte_fault+0x578/0x7c0
[23843.234929]  __handle_mm_fault+0x2e8/0xa70
[23843.234932]  handle_mm_fault+0x20c/0x8a8
[23843.234936]  do_page_fault+0x26c/0x1050
[23843.234942]  do_mem_abort+0x70/0x1c0
[23843.234947]  el0_da+0x5c/0x150
[23843.234950]  el0t_64_sync_handler+0xc4/0x138
[23843.234953]  el0t_64_sync+0x1ac/0x1b0
[23843.234957] task:t_enospc        state:D stack:24400 pid:61705 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.234972] Call trace:
[23843.234975]  __switch_to+0x1f8/0x328 (T)
[23843.234978]  __schedule+0x734/0x1428
[23843.234980]  schedule+0xd0/0x240
[23843.234983]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.235041]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.235098]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.235156]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.235214]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.235271]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.235330]  do_page_mkwrite+0x13c/0x2a8
[23843.235336]  do_wp_page+0x2c4/0x10e0
[23843.235339]  handle_pte_fault+0x578/0x7c0
[23843.235342]  __handle_mm_fault+0x2e8/0xa70
[23843.235344]  handle_mm_fault+0x20c/0x8a8
[23843.235353]  do_page_fault+0x26c/0x1050
[23843.235356]  do_mem_abort+0x70/0x1c0
[23843.235363]  el0_da+0x5c/0x150
[23843.235366]  el0t_64_sync_handler+0xc4/0x138
[23843.235369]  el0t_64_sync+0x1ac/0x1b0
[23843.235373] task:t_enospc        state:D stack:24208 pid:61706 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.235389] Call trace:
[23843.235392]  __switch_to+0x1f8/0x328 (T)
[23843.235394]  __schedule+0x734/0x1428
[23843.235397]  schedule+0xd0/0x240
[23843.235400]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.235457]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.235515]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.235573]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.235631]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.235689]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.235748]  do_page_mkwrite+0x13c/0x2a8
[23843.235753]  do_wp_page+0x2c4/0x10e0
[23843.235756]  handle_pte_fault+0x578/0x7c0
[23843.235758]  __handle_mm_fault+0x2e8/0xa70
[23843.235761]  handle_mm_fault+0x20c/0x8a8
[23843.235765]  do_page_fault+0x26c/0x1050
[23843.235771]  do_mem_abort+0x70/0x1c0
[23843.235774]  el0_da+0x5c/0x150
[23843.235779]  el0t_64_sync_handler+0xc4/0x138
[23843.235782]  el0t_64_sync+0x1ac/0x1b0
[23843.235788] task:t_enospc        state:D stack:23888 pid:61707 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.235803] Call trace:
[23843.235806]  __switch_to+0x1f8/0x328 (T)
[23843.235810]  __schedule+0x734/0x1428
[23843.235814]  schedule+0xd0/0x240
[23843.235816]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.235874]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.235932]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.235989]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.236047]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.236105]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.236163]  do_page_mkwrite+0x13c/0x2a8
[23843.236168]  do_wp_page+0x2c4/0x10e0
[23843.236172]  handle_pte_fault+0x578/0x7c0
[23843.236175]  __handle_mm_fault+0x2e8/0xa70
[23843.236177]  handle_mm_fault+0x20c/0x8a8
[23843.236181]  do_page_fault+0x26c/0x1050
[23843.236187]  do_mem_abort+0x70/0x1c0
[23843.236192]  el0_da+0x5c/0x150
[23843.236195]  el0t_64_sync_handler+0xc4/0x138
[23843.236199]  el0t_64_sync+0x1ac/0x1b0
[23843.236206] task:t_enospc        state:D stack:23824 pid:61708 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.236220] Call trace:
[23843.236223]  __switch_to+0x1f8/0x328 (T)
[23843.236227]  __schedule+0x734/0x1428
[23843.236231]  schedule+0xd0/0x240
[23843.236234]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.236288]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.236347]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.236405]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.236463]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.236521]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.236579]  do_page_mkwrite+0x13c/0x2a8
[23843.236582]  do_wp_page+0x2c4/0x10e0
[23843.236587]  handle_pte_fault+0x578/0x7c0
[23843.236591]  __handle_mm_fault+0x2e8/0xa70
[23843.236594]  handle_mm_fault+0x20c/0x8a8
[23843.236604]  do_page_fault+0x26c/0x1050
[23843.236608]  do_mem_abort+0x70/0x1c0
[23843.236614]  el0_da+0x5c/0x150
[23843.236618]  el0t_64_sync_handler+0xc4/0x138
[23843.236621]  el0t_64_sync+0x1ac/0x1b0
[23843.236631] task:t_enospc        state:D stack:23744 pid:61709 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.236642] Call trace:
[23843.236643]  __switch_to+0x1f8/0x328 (T)
[23843.236646]  __schedule+0x734/0x1428
[23843.236648]  schedule+0xd0/0x240
[23843.236651]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.236711]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.236768]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.236826]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.236884]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.236942]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.237001]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.237058]  file_update_time+0x10c/0x178
[23843.237064]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.237121]  do_page_mkwrite+0x13c/0x2a8
[23843.237126]  do_wp_page+0x2c4/0x10e0
[23843.237132]  handle_pte_fault+0x578/0x7c0
[23843.237134]  __handle_mm_fault+0x2e8/0xa70
[23843.237137]  handle_mm_fault+0x20c/0x8a8
[23843.237141]  do_page_fault+0x26c/0x1050
[23843.237147]  do_mem_abort+0x70/0x1c0
[23843.237152]  el0_da+0x5c/0x150
[23843.237155]  el0t_64_sync_handler+0xc4/0x138
[23843.237158]  el0t_64_sync+0x1ac/0x1b0
[23843.237164] task:t_enospc        state:D stack:24112 pid:61710 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.237174] Call trace:
[23843.237175]  __switch_to+0x1f8/0x328 (T)
[23843.237180]  __schedule+0x734/0x1428
[23843.237184]  schedule+0xd0/0x240
[23843.237189]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.237247]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.237305]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.237362]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.237420]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.237478]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.237536]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.237594]  file_update_time+0x10c/0x178
[23843.237599]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.237657]  do_page_mkwrite+0x13c/0x2a8
[23843.237663]  do_wp_page+0x2c4/0x10e0
[23843.237666]  handle_pte_fault+0x578/0x7c0
[23843.237670]  __handle_mm_fault+0x2e8/0xa70
[23843.237673]  handle_mm_fault+0x20c/0x8a8
[23843.237679]  do_page_fault+0x26c/0x1050
[23843.237683]  do_mem_abort+0x70/0x1c0
[23843.237686]  el0_da+0x5c/0x150
[23843.237691]  el0t_64_sync_handler+0xc4/0x138
[23843.237696]  el0t_64_sync+0x1ac/0x1b0
[23843.237702] task:t_enospc        state:D stack:23728 pid:61711 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.237712] Call trace:
[23843.237715]  __switch_to+0x1f8/0x328 (T)
[23843.237719]  __schedule+0x734/0x1428
[23843.237724]  schedule+0xd0/0x240
[23843.237726]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.237784]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.237841]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.237899]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.237956]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.238014]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.238072]  do_page_mkwrite+0x13c/0x2a8
[23843.238077]  do_wp_page+0x2c4/0x10e0
[23843.238082]  handle_pte_fault+0x578/0x7c0
[23843.238084]  __handle_mm_fault+0x2e8/0xa70
[23843.238087]  handle_mm_fault+0x20c/0x8a8
[23843.238091]  do_page_fault+0x26c/0x1050
[23843.238097]  do_mem_abort+0x70/0x1c0
[23843.238100]  el0_da+0x5c/0x150
[23843.238104]  el0t_64_sync_handler+0xc4/0x138
[23843.238107]  el0t_64_sync+0x1ac/0x1b0
[23843.238117] task:t_enospc        state:D stack:23920 pid:61712 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.238128] Call trace:
[23843.238129]  __switch_to+0x1f8/0x328 (T)
[23843.238132]  __schedule+0x734/0x1428
[23843.238136]  schedule+0xd0/0x240
[23843.238139]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.238198]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.238256]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.238313]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.238371]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.238429]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.238487]  do_page_mkwrite+0x13c/0x2a8
[23843.238492]  do_wp_page+0x2c4/0x10e0
[23843.238497]  handle_pte_fault+0x578/0x7c0
[23843.238499]  __handle_mm_fault+0x2e8/0xa70
[23843.238502]  handle_mm_fault+0x20c/0x8a8
[23843.238507]  do_page_fault+0x26c/0x1050
[23843.238514]  do_mem_abort+0x70/0x1c0
[23843.238519]  el0_da+0x5c/0x150
[23843.238523]  el0t_64_sync_handler+0xc4/0x138
[23843.238528]  el0t_64_sync+0x1ac/0x1b0
[23843.238532] task:t_enospc        state:D stack:24176 pid:61713 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.238543] Call trace:
[23843.238546]  __switch_to+0x1f8/0x328 (T)
[23843.238550]  __schedule+0x734/0x1428
[23843.238552]  schedule+0xd0/0x240
[23843.238558]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.238615]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.238673]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.238731]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.238789]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.238847]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.238905]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.238963]  file_update_time+0x10c/0x178
[23843.238968]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.239026]  do_page_mkwrite+0x13c/0x2a8
[23843.239032]  do_wp_page+0x2c4/0x10e0
[23843.239035]  handle_pte_fault+0x578/0x7c0
[23843.239038]  __handle_mm_fault+0x2e8/0xa70
[23843.239040]  handle_mm_fault+0x20c/0x8a8
[23843.239045]  do_page_fault+0x26c/0x1050
[23843.239048]  do_mem_abort+0x70/0x1c0
[23843.239055]  el0_da+0x5c/0x150
[23843.239060]  el0t_64_sync_handler+0xc4/0x138
[23843.239065]  el0t_64_sync+0x1ac/0x1b0
[23843.239069] task:t_enospc        state:D stack:24560 pid:61714 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.239085] Call trace:
[23843.239088]  __switch_to+0x1f8/0x328 (T)
[23843.239091]  __schedule+0x734/0x1428
[23843.239093]  schedule+0xd0/0x240
[23843.239096]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.239156]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.239214]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.239272]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.239330]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.239408]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.239468]  do_page_mkwrite+0x13c/0x2a8
[23843.239473]  do_wp_page+0x2c4/0x10e0
[23843.239477]  handle_pte_fault+0x578/0x7c0
[23843.239479]  __handle_mm_fault+0x2e8/0xa70
[23843.239482]  handle_mm_fault+0x20c/0x8a8
[23843.239484]  do_page_fault+0x26c/0x1050
[23843.239488]  do_mem_abort+0x70/0x1c0
[23843.239495]  el0_da+0x5c/0x150
[23843.239500]  el0t_64_sync_handler+0xc4/0x138
[23843.239504]  el0t_64_sync+0x1ac/0x1b0
[23843.239509] task:t_enospc        state:D stack:23952 pid:61715 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.239520] Call trace:
[23843.239523]  __switch_to+0x1f8/0x328 (T)
[23843.239527]  __schedule+0x734/0x1428
[23843.239530]  schedule+0xd0/0x240
[23843.239534]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.239591]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.239649]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.239706]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.239764]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.239821]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.239879]  do_page_mkwrite+0x13c/0x2a8
[23843.239884]  do_wp_page+0x2c4/0x10e0
[23843.239888]  handle_pte_fault+0x578/0x7c0
[23843.239890]  __handle_mm_fault+0x2e8/0xa70
[23843.239893]  handle_mm_fault+0x20c/0x8a8
[23843.239896]  do_page_fault+0x26c/0x1050
[23843.239901]  do_mem_abort+0x70/0x1c0
[23843.239908]  el0_da+0x5c/0x150
[23843.239910]  el0t_64_sync_handler+0xc4/0x138
[23843.239915]  el0t_64_sync+0x1ac/0x1b0
[23843.239919] task:t_enospc        state:D stack:24240 pid:61716 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.239929] Call trace:
[23843.239932]  __switch_to+0x1f8/0x328 (T)
[23843.239938]  __schedule+0x734/0x1428
[23843.239941]  schedule+0xd0/0x240
[23843.239945]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.240003]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.240060]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.240118]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.240176]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.240234]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.240292]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.240349]  file_update_time+0x10c/0x178
[23843.240354]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.240412]  do_page_mkwrite+0x13c/0x2a8
[23843.240417]  do_wp_page+0x2c4/0x10e0
[23843.240423]  handle_pte_fault+0x578/0x7c0
[23843.240426]  __handle_mm_fault+0x2e8/0xa70
[23843.240429]  handle_mm_fault+0x20c/0x8a8
[23843.240431]  do_page_fault+0x26c/0x1050
[23843.240435]  do_mem_abort+0x70/0x1c0
[23843.240442]  el0_da+0x5c/0x150
[23843.240446]  el0t_64_sync_handler+0xc4/0x138
[23843.240449]  el0t_64_sync+0x1ac/0x1b0
[23843.240453] task:t_enospc        state:D stack:25856 pid:61717 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.240467] Call trace:
[23843.240469]  __switch_to+0x1f8/0x328 (T)
[23843.240476]  __schedule+0x734/0x1428
[23843.240479]  schedule+0xd0/0x240
[23843.240483]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.240545]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.240603]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.240660]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.240717]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.240775]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.240833]  do_page_mkwrite+0x13c/0x2a8
[23843.240838]  do_wp_page+0x2c4/0x10e0
[23843.240842]  handle_pte_fault+0x578/0x7c0
[23843.240844]  __handle_mm_fault+0x2e8/0xa70
[23843.240847]  handle_mm_fault+0x20c/0x8a8
[23843.240849]  do_page_fault+0x26c/0x1050
[23843.240853]  do_mem_abort+0x70/0x1c0
[23843.240860]  el0_da+0x5c/0x150
[23843.240862]  el0t_64_sync_handler+0xc4/0x138
[23843.240867]  el0t_64_sync+0x1ac/0x1b0
[23843.240873] task:t_enospc        state:D stack:25856 pid:61718 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.240885] Call trace:
[23843.240887]  __switch_to+0x1f8/0x328 (T)
[23843.240894]  __schedule+0x734/0x1428
[23843.240898]  schedule+0xd0/0x240
[23843.240900]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.240958]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.241015]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.241073]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.241130]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.241188]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.241246]  do_page_mkwrite+0x13c/0x2a8
[23843.241249]  do_wp_page+0x2c4/0x10e0
[23843.241254]  handle_pte_fault+0x578/0x7c0
[23843.241257]  __handle_mm_fault+0x2e8/0xa70
[23843.241260]  handle_mm_fault+0x20c/0x8a8
[23843.241266]  do_page_fault+0x26c/0x1050
[23843.241271]  do_mem_abort+0x70/0x1c0
[23843.241274]  el0_da+0x5c/0x150
[23843.241277]  el0t_64_sync_handler+0xc4/0x138
[23843.241280]  el0t_64_sync+0x1ac/0x1b0
[23843.241288] task:t_enospc        state:D stack:25856 pid:61719 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.241300] Call trace:
[23843.241301]  __switch_to+0x1f8/0x328 (T)
[23843.241307]  __schedule+0x734/0x1428
[23843.241309]  schedule+0xd0/0x240
[23843.241312]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.241371]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.241428]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.241486]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.241544]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.241602]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.241660]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.241718]  file_update_time+0x10c/0x178
[23843.241721]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.241780]  do_page_mkwrite+0x13c/0x2a8
[23843.241786]  do_wp_page+0x2c4/0x10e0
[23843.241794]  handle_pte_fault+0x578/0x7c0
[23843.241798]  __handle_mm_fault+0x2e8/0xa70
[23843.241800]  handle_mm_fault+0x20c/0x8a8
[23843.241803]  do_page_fault+0x26c/0x1050
[23843.241807]  do_mem_abort+0x70/0x1c0
[23843.241813]  el0_da+0x5c/0x150
[23843.241816]  el0t_64_sync_handler+0xc4/0x138
[23843.241821]  el0t_64_sync+0x1ac/0x1b0
[23843.241825] task:t_enospc        state:D stack:23792 pid:61720 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.241840] Call trace:
[23843.241843]  __switch_to+0x1f8/0x328 (T)
[23843.241846]  __schedule+0x734/0x1428
[23843.241848]  schedule+0xd0/0x240
[23843.241851]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.241909]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.241967]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.242024]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.242082]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.242140]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.242198]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.242256]  file_update_time+0x10c/0x178
[23843.242259]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.242319]  do_page_mkwrite+0x13c/0x2a8
[23843.242325]  do_wp_page+0x2c4/0x10e0
[23843.242328]  handle_pte_fault+0x578/0x7c0
[23843.242334]  __handle_mm_fault+0x2e8/0xa70
[23843.242339]  handle_mm_fault+0x20c/0x8a8
[23843.242341]  do_page_fault+0x26c/0x1050
[23843.242345]  do_mem_abort+0x70/0x1c0
[23843.242348]  el0_da+0x5c/0x150
[23843.242355]  el0t_64_sync_handler+0xc4/0x138
[23843.242359]  el0t_64_sync+0x1ac/0x1b0
[23843.242363] task:t_enospc        state:D stack:25856 pid:61721 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.242374] Call trace:
[23843.242377]  __switch_to+0x1f8/0x328 (T)
[23843.242380]  __schedule+0x734/0x1428
[23843.242382]  schedule+0xd0/0x240
[23843.242385]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.242443]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.242500]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.242557]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.242614]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.242672]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.242730]  do_page_mkwrite+0x13c/0x2a8
[23843.242735]  do_wp_page+0x2c4/0x10e0
[23843.242738]  handle_pte_fault+0x578/0x7c0
[23843.242741]  __handle_mm_fault+0x2e8/0xa70
[23843.242748]  handle_mm_fault+0x20c/0x8a8
[23843.242752]  do_page_fault+0x26c/0x1050
[23843.242756]  do_mem_abort+0x70/0x1c0
[23843.242759]  el0_da+0x5c/0x150
[23843.242765]  el0t_64_sync_handler+0xc4/0x138
[23843.242770]  el0t_64_sync+0x1ac/0x1b0
[23843.242774] task:t_enospc        state:D stack:25856 pid:61722 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.242784] Call trace:
[23843.242787]  __switch_to+0x1f8/0x328 (T)
[23843.242791]  __schedule+0x734/0x1428
[23843.242794]  schedule+0xd0/0x240
[23843.242796]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.242854]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.242911]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.242968]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.243026]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.243083]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.243141]  do_page_mkwrite+0x13c/0x2a8
[23843.243146]  do_wp_page+0x2c4/0x10e0
[23843.243150]  handle_pte_fault+0x578/0x7c0
[23843.243152]  __handle_mm_fault+0x2e8/0xa70
[23843.243155]  handle_mm_fault+0x20c/0x8a8
[23843.243161]  do_page_fault+0x26c/0x1050
[23843.243166]  do_mem_abort+0x70/0x1c0
[23843.243169]  el0_da+0x5c/0x150
[23843.243172]  el0t_64_sync_handler+0xc4/0x138
[23843.243179]  el0t_64_sync+0x1ac/0x1b0
[23843.243187] task:t_enospc        state:D stack:25856 pid:61723 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.243201] Call trace:
[23843.243205]  __switch_to+0x1f8/0x328 (T)
[23843.243208]  __schedule+0x734/0x1428
[23843.243211]  schedule+0xd0/0x240
[23843.243214]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.243273]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.243330]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.243388]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.243446]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.243504]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.243562]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.243621]  file_update_time+0x10c/0x178
[23843.243624]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.243684]  do_page_mkwrite+0x13c/0x2a8
[23843.243687]  do_wp_page+0x2c4/0x10e0
[23843.243692]  handle_pte_fault+0x578/0x7c0
[23843.243695]  __handle_mm_fault+0x2e8/0xa70
[23843.243701]  handle_mm_fault+0x20c/0x8a8
[23843.243705]  do_page_fault+0x26c/0x1050
[23843.243709]  do_mem_abort+0x70/0x1c0
[23843.243712]  el0_da+0x5c/0x150
[23843.243719]  el0t_64_sync_handler+0xc4/0x138
[23843.243724]  el0t_64_sync+0x1ac/0x1b0
[23843.243730] task:t_enospc        state:D stack:25856 pid:61724 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
...
...
[23843.372692] task:t_enospc        state:D stack:23312 pid:62001 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.372704] Call trace:
[23843.372709]  __switch_to+0x1f8/0x328 (T)
[23843.372713]  __schedule+0x734/0x1428
[23843.372716]  schedule+0xd0/0x240
[23843.372718]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.372776]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.372833]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.372891]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.372949]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.373006]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.373064]  do_page_mkwrite+0x13c/0x2a8
[23843.373069]  do_wp_page+0x2c4/0x10e0
[23843.373072]  handle_pte_fault+0x578/0x7c0
[23843.373075]  __handle_mm_fault+0x2e8/0xa70
[23843.373077]  handle_mm_fault+0x20c/0x8a8
[23843.373084]  do_page_fault+0x26c/0x1050
[23843.373087]  do_mem_abort+0x70/0x1c0
[23843.373091]  el0_da+0x5c/0x150
[23843.373094]  el0t_64_sync_handler+0xc4/0x138
[23843.373098]  el0t_64_sync+0x1ac/0x1b0
[23843.373105] task:t_enospc        state:D stack:23584 pid:62002 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.373116] Call trace:
[23843.373119]  __switch_to+0x1f8/0x328 (T)
[23843.373124]  __schedule+0x734/0x1428
[23843.373127]  schedule+0xd0/0x240
[23843.373130]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.373189]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.373246]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.373304]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.373361]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.373419]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.373477]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.373535]  file_update_time+0x10c/0x178
[23843.373540]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.373597]  do_page_mkwrite+0x13c/0x2a8
[23843.373601]  do_wp_page+0x2c4/0x10e0
[23843.373607]  handle_pte_fault+0x578/0x7c0
[23843.373610]  __handle_mm_fault+0x2e8/0xa70
[23843.373612]  handle_mm_fault+0x20c/0x8a8
[23843.373615]  do_page_fault+0x26c/0x1050
[23843.373622]  do_mem_abort+0x70/0x1c0
[23843.373625]  el0_da+0x5c/0x150
[23843.373629]  el0t_64_sync_handler+0xc4/0x138
[23843.373633]  el0t_64_sync+0x1ac/0x1b0
[23843.373641] task:t_enospc        state:D stack:23824 pid:62003 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.373652] Call trace:
[23843.373655]  __switch_to+0x1f8/0x328 (T)
[23843.373659]  __schedule+0x734/0x1428
[23843.373662]  schedule+0xd0/0x240
[23843.373664]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.373722]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.373779]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.373837]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.373895]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.373953]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.374011]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.374068]  file_update_time+0x10c/0x178
[23843.374071]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.374131]  do_page_mkwrite+0x13c/0x2a8
[23843.374137]  do_wp_page+0x2c4/0x10e0
[23843.374142]  handle_pte_fault+0x578/0x7c0
[23843.374147]  __handle_mm_fault+0x2e8/0xa70
[23843.374149]  handle_mm_fault+0x20c/0x8a8
[23843.374152]  do_page_fault+0x26c/0x1050
[23843.374158]  do_mem_abort+0x70/0x1c0
[23843.374162]  el0_da+0x5c/0x150
[23843.374165]  el0t_64_sync_handler+0xc4/0x138
[23843.374169]  el0t_64_sync+0x1ac/0x1b0
[23843.374176] task:t_enospc        state:D stack:23968 pid:62004 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.374188] Call trace:
[23843.374191]  __switch_to+0x1f8/0x328 (T)
[23843.374193]  __schedule+0x734/0x1428
[23843.374196]  schedule+0xd0/0x240
[23843.374198]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.374256]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.374313]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.374370]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.374428]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.374485]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.374543]  do_page_mkwrite+0x13c/0x2a8
[23843.374548]  do_wp_page+0x2c4/0x10e0
[23843.374552]  handle_pte_fault+0x578/0x7c0
[23843.374554]  __handle_mm_fault+0x2e8/0xa70
[23843.374563]  handle_mm_fault+0x20c/0x8a8
[23843.374567]  do_page_fault+0x26c/0x1050
[23843.374572]  do_mem_abort+0x70/0x1c0
[23843.374575]  el0_da+0x5c/0x150
[23843.374578]  el0t_64_sync_handler+0xc4/0x138
[23843.374581]  el0t_64_sync+0x1ac/0x1b0
[23843.374589] task:t_enospc        state:D stack:24032 pid:62005 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.374600] Call trace:
[23843.374603]  __switch_to+0x1f8/0x328 (T)
[23843.374607]  __schedule+0x734/0x1428
[23843.374610]  schedule+0xd0/0x240
[23843.374613]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.374672]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.374729]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.374786]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.374844]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.374900]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.374959]  do_page_mkwrite+0x13c/0x2a8
[23843.374964]  do_wp_page+0x2c4/0x10e0
[23843.374967]  handle_pte_fault+0x578/0x7c0
[23843.374970]  __handle_mm_fault+0x2e8/0xa70
[23843.374976]  handle_mm_fault+0x20c/0x8a8
[23843.374980]  do_page_fault+0x26c/0x1050
[23843.374983]  do_mem_abort+0x70/0x1c0
[23843.374990]  el0_da+0x5c/0x150
[23843.374993]  el0t_64_sync_handler+0xc4/0x138
[23843.374997]  el0t_64_sync+0x1ac/0x1b0
[23843.375003] task:t_enospc        state:D stack:23184 pid:62006 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.375014] Call trace:
[23843.375016]  __switch_to+0x1f8/0x328 (T)
[23843.375020]  __schedule+0x734/0x1428
[23843.375022]  schedule+0xd0/0x240
[23843.375028]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.375086]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.375143]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.375200]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.375258]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.375315]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.375374]  do_page_mkwrite+0x13c/0x2a8
[23843.375378]  do_wp_page+0x2c4/0x10e0
[23843.375382]  handle_pte_fault+0x578/0x7c0
[23843.375384]  __handle_mm_fault+0x2e8/0xa70
[23843.375387]  handle_mm_fault+0x20c/0x8a8
[23843.375389]  do_page_fault+0x26c/0x1050
[23843.375393]  do_mem_abort+0x70/0x1c0
[23843.375398]  el0_da+0x5c/0x150
[23843.375404]  el0t_64_sync_handler+0xc4/0x138
[23843.375407]  el0t_64_sync+0x1ac/0x1b0
[23843.375412] task:t_enospc        state:D stack:24272 pid:62007 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
[23843.375425] Call trace:
[23843.375428]  __switch_to+0x1f8/0x328 (T)
[23843.375431]  __schedule+0x734/0x1428
[23843.375433]  schedule+0xd0/0x240
[23843.375436]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.375494]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.375551]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.375608]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
[23843.375665]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
[23843.375722]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
[23843.375780]  do_page_mkwrite+0x13c/0x2a8
[23843.375784]  do_wp_page+0x2c4/0x10e0
[23843.375788]  handle_pte_fault+0x578/0x7c0
[23843.375791]  __handle_mm_fault+0x2e8/0xa70
[23843.375794]  handle_mm_fault+0x20c/0x8a8
[23843.375800]  do_page_fault+0x26c/0x1050
[23843.375805]  do_mem_abort+0x70/0x1c0
[23843.375808]  el0_da+0x5c/0x150
[23843.375811]  el0t_64_sync_handler+0xc4/0x138
[23843.375818]  el0t_64_sync+0x1ac/0x1b0
[23843.375826] task:t_enospc        state:D stack:24256 pid:62008 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x0000020c
[23843.375840] Call trace:
[23843.375843]  __switch_to+0x1f8/0x328 (T)
[23843.375846]  __schedule+0x734/0x1428
[23843.375849]  schedule+0xd0/0x240
[23843.375853]  handle_reserve_ticket+0x470/0x820 [btrfs]
[23843.375911]  __reserve_bytes+0x54c/0xb40 [btrfs]
[23843.375968]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
[23843.376025]  start_transaction+0x3f4/0x10e8 [btrfs]
[23843.376083]  btrfs_start_transaction+0x24/0x38 [btrfs]
[23843.376141]  btrfs_dirty_inode+0xd0/0x190 [btrfs]
[23843.376199]  btrfs_update_time+0x84/0xd0 [btrfs]
[23843.376256]  file_update_time+0x10c/0x178
[23843.376261]  btrfs_page_mkwrite+0x538/0xcb0 [btrfs]
[23843.376319]  do_page_mkwrite+0x13c/0x2a8
[23843.376325]  do_wp_page+0x2c4/0x10e0
[23843.376328]  handle_pte_fault+0x578/0x7c0
[23843.376331]  __handle_mm_fault+0x2e8/0xa70
[23843.376333]  handle_mm_fault+0x20c/0x8a8
[23843.376338]  do_page_fault+0x26c/0x1050
[23843.376344]  do_mem_abort+0x70/0x1c0
[23843.376348]  el0_da+0x5c/0x150
[23843.376351]  el0t_64_sync_handler+0xc4/0x138
[23843.376361]  el0t_64_sync+0x1ac/0x1b0


