Return-Path: <linux-btrfs+bounces-9573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC159C6913
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 07:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BDD1F255A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 06:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C2F173357;
	Wed, 13 Nov 2024 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mgda8FSv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6EA10F1
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 06:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731478026; cv=none; b=J0+8TEzLYIjS4wCAWtMC9zpEkJ2VaLETqhER9PVmyYcrHHpoAeq9ByjM4CVg54UkdmTbtpYDNirYJtcQ5KvXqpW8r0tC3eM0paoDQcWX0gymlhNWUsZc+eEM7/1fLnUsr8aJrQeXPjAO74jc/mdE4dsdU1kIwf/1nNGW2GkRv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731478026; c=relaxed/simple;
	bh=xua/rXKAd0XObBMZE6795Hn2/nvKOt7jJqa8IosF6UY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Pp7U1OQYxADGZc8hZeg+ccfrd/r1Iz72QxK3QOC6KD4qLw9vFpBmfhY6TA37FmVvL35WU81x7YPZLa8qNW+pGz+7do5/jQ1ksNQaj7OeIOMVteROZ6qpgoeHPvDpy9OQDpVyewa5tAJmY02W7whjgtvSPHfE7FtL28EjLyM/8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mgda8FSv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731478023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=LmH2XmnmTQdBmu74fmP0WyND4Q56XMM2kj2WV1MXUZo=;
	b=Mgda8FSv+2p/oECcc542czOlCAwP+BCBOBeuH9XdJdlG4tFQY+KymN7wPvl7wo9Z3rAY8G
	1e9Nnj3baC2/UQoL/B4L1yR7CcVhrnw50r38Uajgudiqo+kVvpv1tRjgthDhJ+gMNDreUt
	unfFdOpTuWauzkxILf+JIM5DYonsL+w=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-URarMt1IO7miJgKrBSDi9A-1; Wed, 13 Nov 2024 01:07:01 -0500
X-MC-Unique: URarMt1IO7miJgKrBSDi9A-1
X-Mimecast-MFC-AGG-ID: URarMt1IO7miJgKrBSDi9A
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fb58d1da8eso34507541fa.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 22:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731478020; x=1732082820;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmH2XmnmTQdBmu74fmP0WyND4Q56XMM2kj2WV1MXUZo=;
        b=HaDg/9zzUXmaTPFsisS8fdEUOU+66K4mf64k5eSziqZKnyLDVg9iey5/KoIYp9qJ+w
         uqYN4PhFrzY2z3bhLKKCtnF7ycXElOQt+hdDGjefGvqTqaHLMSJ+9ROXDw8otHivSilh
         +skNcml4QGnosddFSZjKrIXVoMyn6rgwPpirM5S+ZStl5ZamvMuKP1qlUCdDvY3k0e6v
         1e9iT2c10tjlPn1RVRkopMMxEdpQYvWRcoWM9XhmD1qqpyHqrcUeEXyrhkPn04P+NUpU
         bQu6FYQYZ8LtsOkSubfr0uujc6ZAQENgeqAkfYJ3fH/IznmVKjm/qMLZJy9xv6Ry1Bsb
         Kdcw==
X-Forwarded-Encrypted: i=1; AJvYcCWT7vLfesH0EHvdJVAs4SgFWhBLGbI9iy+UqoZZedBGyLTG0dGmG+y1j0k2N0xasd66lcJFX0QUpen1Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmrlRWctRhzaeFVIAt1k6xWiF+8J1NOb5HXpI1R91PR/83J+AK
	rrMj6MDtG4koUe+sw5ows1aS5KkEJ6E4mrFO3KQz7IVO+IXqfzptDo4cCTeVT99SV/36lddb8Vf
	wEZ0MLbjbaYc4Gxn79P7JJQkso5BQ7ZFeDzKXNYtdZVHItWUMFAeX8yklH3rY9pXgNZjwd1jlhX
	4dEw8RkUSQizf3vpytsYg9pLnmfOAPXgmCArg=
X-Received: by 2002:a2e:a80e:0:b0:2fa:ddb5:77f9 with SMTP id 38308e7fff4ca-2ff202c4565mr91552341fa.40.1731478018163;
        Tue, 12 Nov 2024 22:06:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFggJvBvxLuMsPdupin+D/YEmZqQM5pqQ7CYSjgley9/AWNeJjDGEmH3lmvCfu2gmBeh0Phqp9p6YkBCtkBTF4=
X-Received: by 2002:a2e:a80e:0:b0:2fa:ddb5:77f9 with SMTP id
 38308e7fff4ca-2ff202c4565mr91552231fa.40.1731478017664; Tue, 12 Nov 2024
 22:06:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 13 Nov 2024 14:06:43 +0800
Message-ID: <CAHj4cs9RsmCdRAeXjEiqcqDrhgws=qkVR1=kkfxn-cCSWOdTSw@mail.gmail.com>
Subject: [bug report] blktests zbd/009 lead kernel panic on latest linux-block/for-next
To: linux-block <linux-block@vger.kernel.org>, linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hello

CKI reported the below panic[2] on the latest linux-block/for-next[1],
please help check it, thanks.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
for-next  c6cf70b437c1
[2]
[  572.949811] run blktests zbd/009 at 2024-11-12 23:45:01
[  573.177818] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[  573.187936] scsi host11: scsi_debug: version 0191 [20210520]
[  573.187936]   dev_size_mb=1024, opts=0x0, submit_queues=1, statistics=0
[  573.201936] scsi 11:0:0:0: Direct-Access-ZBC Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[  573.211280] scsi 11:0:0:0: Power-on or device reset occurred
[  573.217950] sd 11:0:0:0: [sdc] Host-managed zoned block device
[  573.217958] sd 11:0:0:0: Attached scsi generic sg2 type 20
[  573.224520] sd 11:0:0:0: [sdc] 262144 4096-byte logical blocks:
(1.07 GB/1.00 GiB)
[  573.239087]  sd 11:0:0:0: [sd] Write Protect is off
[  573.244551] sd 11:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  573.254195] sd 11:0:0:0: [sdc] permanent stream count = 5
[  573.260237] sd 11:0:0:0: [sdc] Preferred minimum I/O size 4096 bytes
[  573.267333] sd 11:0:0:0: [sdc] Optimal transfer size 4194304 bytes
[  573.274399] sd 11:0:0:0: [sdc] 256 zones of 1024 logical blocks
[  573.291189] sd 11:0:0:0: [sdc] Attached SCSI disk
[  573.397332] BTRFS: device fsid 54f69d0d-8db8-48dc-a795-e10674802549
devid 1 transid 8 /dev/sdc (8:32) scanned by mount (26263)
[  573.429647] BTRFS info (device sdc): first mount of filesystem
54f69d0d-8db8-48dc-a795-e10674802549
[  573.439770] BTRFS info (device sdc): using crc32c (crc32c-intel)
checksum algorithm
[  573.448330] BTRFS info (device sdc): using free-space-tree
[  573.492028] BTRFS info (device sdc): host-managed zoned block
device /dev/sdc, 256 zones of 4194304 bytes
[  573.502746] BTRFS info (device sdc): zoned mode enabled with zone
size 4194304
[  573.511164] BTRFS info (device sdc): checking UUID tree
[  573.804544] Oops: divide error: 0000 [#1] PREEMPT SMP PTI
[  573.810576] CPU: 7 UID: 0 PID: 26335 Comm: fio Not tainted 6.12.0-rc7 #1
[  573.818056] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS
2.10.5 07/25/2019
[  573.826503] RIP: 0010:btrfs_delalloc_reserve_metadata+0x77/0x310
[  573.833212] Code: 8d 6c 30 ff 48 8d 44 10 ff 31 d2 48 f7 d9 4d 89
de 49 21 cd 48 21 c1 48 89 4c 24 10 49 8b 8f d8 0c 00 00 49 8d 44 0d
ff 89 c9 <48> f7 f1 41 89 c4 48 89 c5 4c 89 64 24 08 f6 83 00 01 00 00
01 0f
[  573.854169] RSP: 0018:ffffade260caf6f8 EFLAGS: 00010206
[  573.860000] RAX: 0000000000000fff RBX: ffff98e911aacc98 RCX: 0000000000000000
[  573.867962] RDX: 0000000000000000 RSI: 0000000000001000 RDI: ffff98e911aacc98
[  573.875923] RBP: 00000000000fafff R08: 0000000000000000 R09: 0000000000000000
[  573.883886] R10: 0000000000000000 R11: 0000000000004000 R12: ffff98e911aaccc8
[  573.891849] R13: 0000000000001000 R14: 0000000000004000 R15: ffff98c988607000
[  573.899810] FS:  00007fad64a360c0(0000) GS:ffff99087f380000(0000)
knlGS:0000000000000000
[  573.908839] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  573.915249] CR2: 00007fad5c616000 CR3: 00000020d271e003 CR4: 00000000001726f0
[  573.923211] Call Trace:
[  573.925937]  <TASK>
[  573.928276]  ? __die_body.cold+0x19/0x27
[  573.932654]  ? die+0x2e/0x50
[  573.935859]  ? do_trap+0xca/0x110
[  573.939558]  ? do_error_trap+0x6a/0x90
[  573.943738]  ? btrfs_delalloc_reserve_metadata+0x77/0x310
[  573.949763]  ? exc_divide_error+0x38/0x50
[  573.954235]  ? btrfs_delalloc_reserve_metadata+0x77/0x310
[  573.960257]  ? asm_exc_divide_error+0x1a/0x20
[  573.965123]  ? btrfs_delalloc_reserve_metadata+0x77/0x310
[  573.971148]  ? filemap_range_has_page+0xbc/0xe0
[  573.976207]  btrfs_dio_iomap_begin+0x6a0/0xb80
[  573.981167]  iomap_iter+0x180/0x350
[  573.985062]  __iomap_dio_rw+0x20a/0x830
[  573.989347]  btrfs_direct_write+0x23a/0x470
[  573.994014]  btrfs_do_write_iter+0x168/0x1f0
[  573.998778]  aio_write+0x15e/0x290
[  574.002576]  ? io_submit_one+0x484/0x8c0
[  574.006942]  io_submit_one+0x484/0x8c0
[  574.011126]  __x64_sys_io_submit+0x8c/0x1a0
[  574.015788]  do_syscall_64+0x82/0x160
[  574.019878]  ? file_update_time+0x1b/0x80
[  574.024353]  ? fault_dirty_shared_page+0x88/0x1a0
[  574.029602]  ? do_fault+0x189/0x4c0
[  574.033493]  ? __handle_mm_fault+0x7cb/0xfb0
[  574.038257]  ? getrusage+0x225/0x490
[  574.042248]  ? syscall_exit_to_user_mode_prepare+0x149/0x170
[  574.048565]  ? mt_find+0x213/0x560
[  574.052362]  ? __count_memcg_events+0x77/0x130
[  574.057313]  ? count_memcg_events.constprop.0+0x1a/0x30
[  574.063144]  ? handle_mm_fault+0x21b/0x330
[  574.067715]  ? do_user_addr_fault+0x1ec/0x7b0
[  574.072578]  ? exc_page_fault+0x7e/0x180
[  574.076947]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  574.082584] RIP: 0033:0x7fad64b27cad
[  574.086584] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 33 61 0f 00 f7 d8 64 89
01 48
[  574.107539] RSP: 002b:00007ffcdfd26fb8 EFLAGS: 00000246 ORIG_RAX:
00000000000000d1
[  574.115986] RAX: ffffffffffffffda RBX: 00007fad64a36038 RCX: 00007fad64b27cad
[  574.123949] RDX: 0000563976366770 RSI: 0000000000000001 RDI: 00007fad5c616000
[  574.131912] RBP: 00007ffcdfd26ff0 R08: 00007fad64c1eb20 R09: 00007ffcdfd27020
[  574.139874] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fad5c616000
[  574.147836] R13: 0000000000000000 R14: 0000000000000001 R15: 0000563976366770
[  574.155800]  </TASK>
[  574.158234] Modules linked in: scsi_debug null_blk pktcdvd sunrpc
dell_pc platform_profile intel_rapl_msr intel_rapl_common dell_wmi
sb_edac dell_smbios x86_pkg_temp_thermal intel_powerclamp coretemp
kvm_intel dell_wmi_descriptor kvm sparse_keymap acpi_power_meter
ipmi_ssif rfkill iTCO_wdt cdc_ether rapl intel_cstate intel_pmc_bxt
intel_uncore ixgbe video ipmi_si usbnet mei_me ioatdma pcspkr
acpi_ipmi iTCO_vendor_support mii ipmi_devintf tg3 lpc_ich mei dcdbas
mxm_wmi mdio ipmi_msghandler dca fuse loop nfnetlink zram xfs
crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3
sha1_ssse3 mgag200 i2c_algo_bit megaraid_sas wmi [last unloaded:
scsi_debug]
[  574.229012] ---[ end trace 0000000000000000 ]---
[  574.247457] RIP: 0010:btrfs_delalloc_reserve_metadata+0x77/0x310
[  574.254171] Code: 8d 6c 30 ff 48 8d 44 10 ff 31 d2 48 f7 d9 4d 89
de 49 21 cd 48 21 c1 48 89 4c 24 10 49 8b 8f d8 0c 00 00 49 8d 44 0d
ff 89 c9 <48> f7 f1 41 89 c4 48 89 c5 4c 89 64 24 08 f6 83 00 01 00 00
01 0f
[  574.275131] RSP: 0018:ffffade260caf6f8 EFLAGS: 00010206
[  574.280964] RAX: 0000000000000fff RBX: ffff98e911aacc98 RCX: 0000000000000000
[  574.288928] RDX: 0000000000000000 RSI: 0000000000001000 RDI: ffff98e911aacc98
[  574.296898] RBP: 00000000000fafff R08: 0000000000000000 R09: 0000000000000000
[  574.304864] R10: 0000000000000000 R11: 0000000000004000 R12: ffff98e911aaccc8
[  574.312830] R13: 0000000000001000 R14: 0000000000004000 R15: ffff98c988607000
[  574.320795] FS:  00007fad64a360c0(0000) GS:ffff99087f380000(0000)
knlGS:0000000000000000
[  574.329819] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  574.336232] CR2: 00007fad5c616000 CR3: 00000020d271e003 CR4: 00000000001726f0
[  574.344200] Kernel panic - not syncing: Fatal exception
[  574.350049] Kernel Offset: 0xe000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  574.376847] ---[ end Kernel panic - not syncing: Fatal exception ]---



-- 
Best Regards,
  Yi Zhang


