Return-Path: <linux-btrfs+bounces-15486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC9B02D68
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jul 2025 00:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE68189CF64
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Jul 2025 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2250226CE6;
	Sat, 12 Jul 2025 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yibo3oEw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB391E0DE8
	for <linux-btrfs@vger.kernel.org>; Sat, 12 Jul 2025 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752357780; cv=none; b=r1y/384T+QSnYDArPppeOZoaReUb1Gwe2Gofm3Q42MzY10Bsf0vC5QO8/IkNmL4lDy9zOu+uEhx2bRPUlaD2+zPXYlVcPtaU2JaIt1QUeVPjRl7jdxoTOyCFv3YupIHGRB2VjlnBdPLhuGyGCJUiKT70KqbSwoEhlWp8u0KrSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752357780; c=relaxed/simple;
	bh=f3mMfDjUzaZdBq5teYTgccBcJecC7eXUse/9KgI9LSg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MrYhpO7tvOcfFojGS9YurNxtGrE/EzG9AgKq2LLeVGIQ2DZBhTyl9EjWKL48XFcZ3MArNnLxkpCiO2/B+0NX5wv8TTd07JPBelI+yYYNsGzO5aniwOWkQBvLMLgAtiok3V+JVvOqKqZR4NB1lJQd7pmc+9fX2l/BcAbeBvqvcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yibo3oEw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c3d06de3so3761827b3a.0
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Jul 2025 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752357777; x=1752962577; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3mMfDjUzaZdBq5teYTgccBcJecC7eXUse/9KgI9LSg=;
        b=Yibo3oEweSd2g9XRfcqMU12m57uqEDi8bOIpAf/0XgXHzCNwtw58LhnBUEXKcw0TI8
         eQ7TURQS+LW8liv7e44qwXrPca7WA7XrdozLnRClP6zs9sblS5mxM7B5Z7tQeX9fu5KB
         LFiCl/y0OnhmxU68sLK4VWmVS/7WbKTI/t9LTdkXsgskmm7yUmNxYSirYP/6cVTIPmqL
         fUpq4DiEWnFkb6/0IpyTutoPKxLprgKBHBWVJYb5DC2TN4frC3olZrO+FB2dPYKg1N8S
         jWuZfxnhjB9JHGTUsAvm9bJmFWee0ba/13cSqaKi8S4NBb/Hzw9PiuTnjmhijxLMJJlA
         lEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752357777; x=1752962577;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f3mMfDjUzaZdBq5teYTgccBcJecC7eXUse/9KgI9LSg=;
        b=jArDOI0sF1Wv6gGc2ONLjouI4tW6WX+mxGVp9iOu32brwwfCuLqda7xcl8l4g7iUAh
         T2PHxTUMkXrD6xYCy/0F4qfb0WerEseOpT5Bgan1X/sC01f5zVMNitR2H+z14C0J1WbS
         WxSzLb30lmLqFY1Jv7RVTD0B9Ju1WLpb5ZBcNTfnfWkAzWlFZmpZ6dqwaj1lC2NPDMaF
         uE9FH2VZ8t/+T6eGPoGb+kJ7tf5aF0rcLj3mdFtmutz3Tzrrtfj5PxgA9Kj5qrS3b3kf
         EF0kzbY4WLpvrEQ0FhiYgZ5gbP+lfRVulmLOxFDL6BACBikDhuAExh9XdNRGf5eV1kXa
         z3gA==
X-Gm-Message-State: AOJu0Yy1FMBkbOlbn/Q7yE5IywVEFs50fOywRJLnQzdI5bui9fc0V7Vc
	GaapLssebanL9SE/VDx3s3b17CL+ADXqfGy0B0hPXL7p4tJCL63JZkRWadr01w==
X-Gm-Gg: ASbGncsOjXluQPEXqeAsIIUlxASBXCEsR+0Kk+kklOCoAeYerhxDxt3PrmmItwUav+P
	K8ktjN2GbJdt4FjVbGEudu8zNFq7S0F3SqjvsMuM8ZloTxR3t81qBAo1VMoNnIylhfKS+eVbCoc
	rld8ZQSxlj6NHN3WVDYILQrcfymOOIwgPL4GW9wh+r4guiSgnl+0k/g3RCPIAFWi5FlIGRzIU92
	nbRUddSPnq8jyl7vq1OU16W3I5QU9DMoc+4jDTZ9lSQ9MogUrswvLTkmaU6VfyAE1Fp/jMJ5DD+
	r5BJtOgNK4tPromnSuWtzB34teLaTDXb4Gpdd0BM8U4B5CDRDiwA5foFPPqnYsnW2LbjglKAanx
	iJTMfww4xekgKEqqlmzaBDMZJppVEi4XrrzMwAEPuBW11OmTraHXfrPr8LbnPwWzI9KlkXw==
X-Google-Smtp-Source: AGHT+IEvZ1AkAU8K7VIpHgsTnwa8Bd5Eaz8KJWkmKhVQZqpoymfyH3lrHdRPOrWbua6Mrrn6LwH0MQ==
X-Received: by 2002:a05:6a00:391e:b0:748:311a:8aef with SMTP id d2e1a72fcca58-74ee284c6f9mr11173521b3a.12.1752357776648;
        Sat, 12 Jul 2025 15:02:56 -0700 (PDT)
Received: from ?IPV6:2001:569:720d:7800:7805:71ff:feb9:1fb9? ([2001:569:720d:7800:7805:71ff:feb9:1fb9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f90d66sm7477366b3a.173.2025.07.12.15.02.56
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 15:02:56 -0700 (PDT)
Message-ID: <99bc3ec8-8251-4530-ab4c-7b427883853e@gmail.com>
Date: Sat, 12 Jul 2025 15:02:55 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: "johnh1214@gmail.com" <johnh1214@gmail.com>
Subject: BTRFS RAID 5 array ran out of space, switched to R/O mode with errors
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

It was suggested to me, that I contact the btrfs devs group to inform the group of this situation I've encountered.

Any advice on what I should do to try and recover from the situation will be appreciated.

Fortunately I have a good copy of the most important data backed up, however there are a few recent files not yet backed up that I hope to recover. A lot of the data was for temporary archival reasons, while moving systems around, most of it is no longer required, however, I'd like to try and recover from this situation if possible.

The RAID5 array is 5 x 8TB, using RAID 1 for metatdata. I was told I could have instead used RAID1c4 for metatdata, but did not know this beforehand.

I was copying data to the raid array, when btrfs ran out of free space, and went into read-only mode. The main issue is not that it's gone into read-only mode, it's that I can no longer read most of the files on the entire array, despite there being no noticeable issues reading the data before the low space problem was encountered. I never imagined, that running out of space could cause the entire file system to become mostly unreadable.

I have not yet attempted a recovery, and have left things exactly as they are after the error was encountered. The server has not been rebooted, and I've commented out the mounting of the array from fstab in case there's an unplanned reboot. What I want to do first, is copy what I can from the drive "as-is" in read-only mode, before I attempt a rescue. I can list all the directories and files OK, there's no sign of file system structure corruption, but many of the underlying files are either entirely unreadable, or are only partly readable, with maybe 20% that are 100% readable.

The file system reported it was running low on free space, however there was enough listed for the data transfer, about 2x more than I required. I know that when space is low, btrfs will sometimes run out early, despite it claiming there's enough. In the case at hand, I think it claimed to have about 150GB free, and I was copying about 56GB to it. I should have known better than to bother doing the copy, but expected no worse than the copy aborting due to a lack of free space. On single drives BTRFS FS, I've run out of space many times before without issues.

After successfully transferring about 50% of the data, the copy aborted. There's no space left, and the FS encountered an error, switching to read-only mode to prevent further damage.

Here are the vitals:

Kernel: 6.1.0-37-amd64

RAID 5 array is 5 x 8TB, using RAID 1 for metatdata
Note: someone told me I could have used RAID1cx4 for metatdata, is that true?

All 5 Toshiba HDD's appear to be operating normally, and SMART reports all 5 drives are 100% healthy.

btrfs fi show

Label: 'pl.8000.00'  uuid: 5c3747c7-cc6a-45f2-a1e6-860095d0f7cd
     Total devices 5 FS bytes used 29.02TiB
     devid    1 size 7.28TiB used 7.28TiB path /dev/sdb
     devid    2 size 7.28TiB used 7.28TiB path /dev/sdd
     devid    3 size 7.28TiB used 7.28TiB path /dev/sdc
     devid    4 size 7.28TiB used 7.28TiB path /dev/sde
     devid    5 size 7.28TiB used 7.28TiB path /dev/sda

Here is a /kern.log dump showing when the problem first appeared. The dump indicates the array ran out of space, and was re-mounted read-only, however the read-only state appears to be bad, with missing "mirrors".

In the dump below, the line,  "2025-07-07T19:30:28.806270-07:00" reports the array went into read-only mode.
Afterwards, it's complaining about mirror 1 and 2 wanted, which appear to be unavailable.

/var/log/kern.log
2025-07-07T19:30:28.806185-07:00 host kernel: [3777897.708336] ------------[ cut here ]------------
2025-07-07T19:30:28.806200-07:00 host kernel: [3777897.708339] BTRFS: Transaction aborted (error -28)
2025-07-07T19:30:28.806200-07:00 host kernel: [3777897.708366] WARNING: CPU: 8 PID: 3044847 at fs/btrfs/extent-tree.c:3092 __btrfs_free_extent.cold+0x661/0xa0b [btrfs]
2025-07-07T19:30:28.806202-07:00 host kernel: [3777897.708409] Modules linked in: xt_MASQUERADE iptable_nat tcp_diag inet_diag unix_diag nft_nat nft_masq nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 vhost_net vho>
2025-07-07T19:30:28.806204-07:00 host kernel: [3777897.708493] drm_kms_helper ahci libahci xhci_pci libata xhci_hcd nvme ixgbe drm nvme_core xfrm_algo t10_pi usbcore scsi_mod crc32_pclmul mdio_devres igb crc32c_intel i2c_piix4 lib>
2025-07-07T19:30:28.806205-07:00 host kernel: [3777897.708524] CPU: 8 PID: 3044847 Comm: kworker/u64:43 Tainted: G               X 6.1.0-37-amd64 #1  Debian 6.1.140-1
2025-07-07T19:30:28.806205-07:00 host kernel: [3777897.708528] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X570D4U-2L2T, BIOS P1.30 12/04/2020
2025-07-07T19:30:28.806206-07:00 host kernel: [3777897.708530] Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
2025-07-07T19:30:28.806207-07:00 host kernel: [3777897.708565] RIP: 0010:__btrfs_free_extent.cold+0x661/0xa0b [btrfs]
2025-07-07T19:30:28.806208-07:00 host kernel: [3777897.708596] Code: 78 50 e8 65 de ff ff eb 8e 8b 7c 24 20 e8 35 ee ff ff 84 c0 0f 84 fb 01 00 00 8b 74 24 20 48 c7 c7 b8 94 b3 c0 e8 50 61 38 da <0f> 0b c6 44 24 30 01 44 8b 44 24 3>
2025-07-07T19:30:28.806209-07:00 host kernel: [3777897.708598] RSP: 0018:ffff9cbf1df13a80 EFLAGS: 00010286
2025-07-07T19:30:28.806210-07:00 host kernel: [3777897.708600] RAX: 0000000000000000 RBX: 00002f6f91030000 RCX: 0000000000000027
2025-07-07T19:30:28.806210-07:00 host kernel: [3777897.708602] RDX: ffff8b5b8ec203e8 RSI: 0000000000000001 RDI: ffff8b5b8ec203e0
2025-07-07T19:30:28.806210-07:00 host kernel: [3777897.708604] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff9cbf1df138f8
2025-07-07T19:30:28.806211-07:00 host kernel: [3777897.708605] R10: 0000000000000003 R11: ffff8b5c0f25de90 R12: 0000000000000001
2025-07-07T19:30:28.806211-07:00 host kernel: [3777897.708606] R13: 0000000000000000 R14: 000000000000000a R15: ffff8b448dc605b0
2025-07-07T19:30:28.806212-07:00 host kernel: [3777897.708608] FS: 0000000000000000(0000) GS:ffff8b5b8ec00000(0000) knlGS:0000000000000000
2025-07-07T19:30:28.806212-07:00 host kernel: [3777897.708610] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2025-07-07T19:30:28.806213-07:00 host kernel: [3777897.708611] CR2: 0000557ac7d0a438 CR3: 00000001ead0c000 CR4: 0000000000350ee0
2025-07-07T19:30:28.806215-07:00 host kernel: [3777897.708613] Call Trace:
2025-07-07T19:30:28.806215-07:00 host kernel: [3777897.708617] <TASK>
2025-07-07T19:30:28.806216-07:00 host kernel: [3777897.708621]  ? __slab_free+0x11/0x2d0
2025-07-07T19:30:28.806234-07:00 host kernel: [3777897.708629] __btrfs_run_delayed_refs+0x2be/0x10b0 [btrfs]
2025-07-07T19:30:28.806234-07:00 host kernel: [3777897.708660]  ? btrfs_search_slot+0x8a7/0xc90 [btrfs]
2025-07-07T19:30:28.806235-07:00 host kernel: [3777897.708688]  ? srso_return_thunk+0x5/0x10
2025-07-07T19:30:28.806236-07:00 host kernel: [3777897.708693]  ? set_extent_buffer_dirty+0x15/0x130 [btrfs]
2025-07-07T19:30:28.806236-07:00 host kernel: [3777897.708723]  ? srso_return_thunk+0x5/0x10
2025-07-07T19:30:28.806236-07:00 host kernel: [3777897.708725]  ? release_extent_buffer+0x99/0xb0 [btrfs]
2025-07-07T19:30:28.806237-07:00 host kernel: [3777897.708754] btrfs_run_delayed_refs+0x76/0x1a0 [btrfs]
2025-07-07T19:30:28.806237-07:00 host kernel: [3777897.708783] btrfs_start_dirty_block_groups+0x305/0x540 [btrfs]
2025-07-07T19:30:28.806238-07:00 host kernel: [3777897.708817] btrfs_commit_transaction+0xab/0xc50 [btrfs]
2025-07-07T19:30:28.806238-07:00 host kernel: [3777897.708847]  ? srso_return_thunk+0x5/0x10
2025-07-07T19:30:28.806239-07:00 host kernel: [3777897.708849]  ? start_transaction+0xc3/0x5f0 [btrfs]
2025-07-07T19:30:28.806254-07:00 host kernel: [3777897.708878] flush_space+0xfd/0x5f0 [btrfs]
2025-07-07T19:30:28.806254-07:00 host kernel: [3777897.708911] btrfs_async_reclaim_metadata_space+0x1cc/0x2d0 [btrfs]
2025-07-07T19:30:28.806255-07:00 host kernel: [3777897.708940] process_one_work+0x1c7/0x380
2025-07-07T19:30:28.806255-07:00 host kernel: [3777897.708946] worker_thread+0x4d/0x380
2025-07-07T19:30:28.806255-07:00 host kernel: [3777897.708949]  ? rescuer_thread+0x3a0/0x3a0
2025-07-07T19:30:28.806256-07:00 host kernel: [3777897.708950] kthread+0xda/0x100
2025-07-07T19:30:28.806256-07:00 host kernel: [3777897.708954]  ? kthread_complete_and_exit+0x20/0x20
2025-07-07T19:30:28.806257-07:00 host kernel: [3777897.708957] ret_from_fork+0x22/0x30
2025-07-07T19:30:28.806258-07:00 host kernel: [3777897.708964] </TASK>
2025-07-07T19:30:28.806258-07:00 host kernel: [3777897.708965] ---[ end trace 0000000000000000 ]---
2025-07-07T19:30:28.806261-07:00 host kernel: [3777897.708967] BTRFS info (device sdb: state A): dumping space info:
2025-07-07T19:30:28.806262-07:00 host kernel: [3777897.708970] BTRFS info (device sdb: state A): space_info DATA has 60921196544 free, is full
2025-07-07T19:30:28.806262-07:00 host kernel: [3777897.708972] BTRFS info (device sdb: state A): space_info total=31937462009856, used=31873161326592, pinned=4096, reserved=3377864704, may_use=45056, readonly=1572864 zone_unusable=0
2025-07-07T19:30:28.806263-07:00 host kernel: [3777897.708975] BTRFS info (device sdb: state A): space_info METADATA has -2326528 free, is full
2025-07-07T19:30:28.806263-07:00 host kernel: [3777897.708977] BTRFS info (device sdb: state A): space_info total=41875931136, used=39246086144, pinned=926269440, reserved=47579136, may_use=1658191872, readonly=131072 zone_unusable>
2025-07-07T19:30:28.806266-07:00 host kernel: [3777897.708980] BTRFS info (device sdb: state A): space_info SYSTEM has 31686656 free, is not full
2025-07-07T19:30:28.806266-07:00 host kernel: [3777897.708982] BTRFS info (device sdb: state A): space_info total=33554432, used=1867776, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
2025-07-07T19:30:28.806267-07:00 host kernel: [3777897.708985] BTRFS info (device sdb: state A): global_block_rsv: size 536870912 reserved 0
2025-07-07T19:30:28.806268-07:00 host kernel: [3777897.708986] BTRFS info (device sdb: state A): trans_block_rsv: size 0 reserved 0
2025-07-07T19:30:28.806268-07:00 host kernel: [3777897.708988] BTRFS info (device sdb: state A): chunk_block_rsv: size 0 reserved 0
2025-07-07T19:30:28.806269-07:00 host kernel: [3777897.708990] BTRFS info (device sdb: state A): delayed_block_rsv: size 262144 reserved 262144
2025-07-07T19:30:28.806269-07:00 host kernel: [3777897.708992] BTRFS info (device sdb: state A): delayed_refs_rsv: size 2375024640 reserved 0
2025-07-07T19:30:28.806270-07:00 host kernel: [3777897.708994] BTRFS: error (device sdb: state A) in __btrfs_free_extent:3092: errno=-28 No space left
2025-07-07T19:30:28.806270-07:00 host kernel: [3777897.709670] BTRFS info (device sdb: state EA): forced readonly
2025-07-07T19:30:28.806271-07:00 host kernel: [3777897.709672] BTRFS error (device sdb: state EA): failed to run delayed ref for logical 52156220768256 num_bytes 16384 type 176 action 2 ref_mod 1: -28
2025-07-07T19:30:28.806274-07:00 host kernel: [3777897.710683] BTRFS: error (device sdb: state EA) in btrfs_run_delayed_refs:2165: errno=-28 No space left
2025-07-07T19:31:37.922065-07:00 host kernel: [3777966.824892] BTRFS warning (device sdb: state EA): Skipping commit of aborted transaction.
2025-07-07T19:31:37.922082-07:00 host kernel: [3777966.824906] BTRFS: error (device sdb: state EA) in btrfs_sync_log:3161: errno=-5 IO failure
2025-07-07T20:06:21.662072-07:00 host kernel: [3780050.499696] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 2 wanted 4093212 found 4093166
2025-07-07T20:06:21.682076-07:00 host kernel: [3780050.519936] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 1 wanted 4093212 found 4093166
2025-07-07T20:06:21.682100-07:00 host kernel: [3780050.522082] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 2 wanted 4093212 found 4093166
2025-07-07T20:06:21.686053-07:00 host kernel: [3780050.524439] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 1 wanted 4093212 found 4093166
2025-07-07T20:06:21.698380-07:00 host kernel: [3780050.526396] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 2 wanted 4093212 found 4093166
2025-07-07T20:06:21.698408-07:00 host kernel: [3780050.531760] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 1 wanted 4093212 found 4093166
2025-07-07T20:06:21.702623-07:00 host kernel: [3780050.539105] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 2 wanted 4093212 found 4093166
2025-07-07T20:06:21.708871-07:00 host kernel: [3780050.543772] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 1 wanted 4093212 found 4093166
2025-07-07T20:06:21.717935-07:00 host kernel: [3780050.549936] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 2 wanted 4093212 found 4093166
2025-07-07T20:06:21.726076-07:00 host kernel: [3780050.558423] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 1 wanted 4093212 found 4093166
2025-07-07T20:06:31.106118-07:00 host kernel: [3780059.943621] verify_parent_transid: 278 callbacks suppressed

:
NOTE: the parent transit errors, as shown above, repeat forever

There are also checksum verify errors logged, like the one shown below, most of them are mirror 2, with a few mirror 1 logged.

2025-07-07T20:29:14.078068-07:00 host kernel: [3781422.870343] BTRFS warning (device sdb: state EA): checksum verify failed on logical 55129635373056 mirror 2 wanted 0x076ea9a7 found 0xf5e8fb26 level 1

Are the metadata mirrors, 1 and 2, entirely missing, or are two of the 8TB drives involved in the array, no longer available after it went into read-only mode?

I use xfce4 for emergency use on this server, and the file browser Thunar, is now showing 4 or the 5 drives as being available for mounting, whereas before this situation happened, none of the drives were shown as being available.

This is a very confusing situation. Any assistance on how to proceed from here is appreciated.


