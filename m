Return-Path: <linux-btrfs+bounces-16031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB806B239EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 22:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3638A6846DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 20:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508D2D061E;
	Tue, 12 Aug 2025 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dto0vW/j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9F2D0613
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030226; cv=none; b=nrgwegWktPj1a4P76PxTPUyf1+nWGhJ6htYkCpEbP1FgVMiyQSgVdJBYr1+v8a0+3sHIHnO7Wd4Ho/9VvNbxhVKrrQ7bVJ2kTr9IHTTP8G1shhitL3++z/pTf3FADqnab2euGnQiLYGqeNbpqFbK63h8i+NPYMrVGF4PlGHmliY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030226; c=relaxed/simple;
	bh=23O4FDnoGM70MbDRrVPwvwIvDGv1y09OyMgg+tr6qA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gsFYeprdDYWKJB4WmrJ9+FIuR8muCAg7AJyGNRgJiMHSGybvvMlPKdKrjlqDr8IW27CgQ4CxcgEqk6g56oClKu5pYf5EHd1Fgq7QM9JwtUyLd9ue2d8yVa5g1WUUJLI8lo5vGjWRK2SXxYLikKbLH1Nkt7+9V11muCK8V7g2HCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dto0vW/j; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b423b13e2c3so4529686a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755030223; x=1755635023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=23O4FDnoGM70MbDRrVPwvwIvDGv1y09OyMgg+tr6qA4=;
        b=dto0vW/jpMUhI37bgvkXRnH/mNuqcoQXJcM2uvmSnv+w4mfBfS+4UK/PRW9qrYbCQw
         UQkFfRx8HnRYExRiIYW4GORrJb56mhc6wbz16GO6xLl106X6I47GhpU22PejQ7ceib4E
         FnLZStrZ/UvTzv1t3/z/EmxotebhHhtn+Mf5mlKT2dyevhZ7u2d87P0hqSeepVHT0oBg
         txReI7bwSzjC3NiDojgvLnnvdPiMUwezDWqkKJ0Fd63V1ixJmxklHM6fbw8HNPEU+2pl
         MYF0+ThSeP3Yac1D7t7W08Q6z3e/GmsMn45IXYAmARyUl+YmG6k2iogZurZLluNxVJ3g
         ALsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755030223; x=1755635023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23O4FDnoGM70MbDRrVPwvwIvDGv1y09OyMgg+tr6qA4=;
        b=lSw3y1/xXFhpWaaPvdXHQKDkO2MIQ4ZmI8blNzQlNqJJVn+2nAWetpSFTfGimTaKPb
         x8SUW67SDb9teUcuWAST9I33S1Yfj11qFJGgYulkzt5HX6oALvE25oYTsPE4h7sjjaYJ
         0F4jozNuF9wOYK1Qb55DCiI6207TwXxGFN2QvtF+kYIgaVzf62gd9hNUs5Uop+eHirYu
         X2caxKBXG8LKJ10eLNLuYeYX8uQeYGGIu23fgXyhSwzI4nhttDpT6PRSmfCnYjOGBzDu
         WvvcjaNeyNr/cX7n6nlyoaiJujqMKrEG1E22fGNacWKzxrtmY9cB/XnyT24MpAwHqG8a
         xJ4g==
X-Forwarded-Encrypted: i=1; AJvYcCWbEylbfqnTK73H4d91v+lpQQDia6OH8obqrT7ko9/gpo4XKEsmTe+lfQOJ6sQ6fCRfcbNsZEXyPzd4Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYPSDhac1OOQwIB9pqowHV4vX99QsA3ytdYDPIsSC0vg75B0A
	63ylgJCExgk/pFE1qMRBeFKjznas+pE42XuGgkl7qd2wbjXTyvEPWafo
X-Gm-Gg: ASbGncsZ3mNGai+f/f0G05a4f6e7HE7GdwL/0K74IXUQL225MgHpXwC7DJ8Twh5M5d/
	afJBDLyEGC9nv+7XlzRuZqUWuKPxvGSooDy17/0sffbWKXda9drxm9LgB75Xgq5H/MpmH3N58qK
	chs4Ey9vVJiN9i4+gslH6UQqwXTvuZgfLbWO5Q6dooYXVa9ELIVJYYdh13m34Rf8lyexYJjrJTJ
	YMU1RfIHm0Av3HHPubBDYfqc0vjY1bSsQx9upYaJkvYlGfkl5DDwidQjJZm9yFYa/4Gq/cyXHGd
	DbiMkvWEfOFOvfqX9h2saTL5zGEuaJNIYxcjL6TQYB7/dEgzSu5nsG5xUOW8f4VXryOqtj6Gb+U
	rxJj9AEhPZDMZMxWvnP8kAjK13cs6e2sWB+ziTVdklpn5nIxnKayt8EmHqQ9g+4/ebHObNw==
X-Google-Smtp-Source: AGHT+IFfk4GufMKl6PPeTHQXojkFb2FvV93fqFgJg7LXVIIfIC5k6IqYktaSOE1ixJl647J34kdp0w==
X-Received: by 2002:a17:902:d2d2:b0:224:23be:c569 with SMTP id d9443c01a7336-2430d0d502dmr8490415ad.22.1755030222169;
        Tue, 12 Aug 2025 13:23:42 -0700 (PDT)
Received: from ?IPV6:2001:569:720d:7800:7805:71ff:feb9:1fb9? ([2001:569:720d:7800:7805:71ff:feb9:1fb9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aac4b5sm305665785ad.169.2025.08.12.13.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 13:23:41 -0700 (PDT)
Message-ID: <b4efb68d-28d9-44cd-8190-6870d0dce098@gmail.com>
Date: Tue, 12 Aug 2025 13:23:41 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS RAID 5 array ran out of space, switched to R/O mode with
 errors
To: DanglingPointer <danglingpointerexception@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <99bc3ec8-8251-4530-ab4c-7b427883853e@gmail.com>
 <eeec436c-fa53-4644-aec6-5e4381da34ab@gmail.com>
 <89786d48-cdca-4e53-8646-09860a6f5482@gmail.com>
 <b1a7a056-2d0f-40c0-9899-8ecbfc29dfa5@gmail.com>
Content-Language: en-US
From: "johnh1214@gmail.com" <johnh1214@gmail.com>
In-Reply-To: <b1a7a056-2d0f-40c0-9899-8ecbfc29dfa5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

When I added an extra 8TB drive to the array, and upgraded from space cache v1 to v2, I had enough backup storage space to make a full copy (unfortunately, most of the full backup has been replaced with other data). The addition of an extra drive and space cache upgrade went smoothly, but it was only with a full backup available, that I was willing to give it a try. If I were you, I'd make sure I had a full backup of everything important, before adding on extra storage space.

I knew better than to copy more data over to the RAID array running low, but that day, I was impatient, and thought it improbable something would go so horribly wrong.

It's so ridiculous, I want to take a look at the source code to figure out how running low on storage space, can mess up an entire RAID array. I was hoping a dev already in the know, could shed some light on it, and what will be the best set of steps to take to try and recover.

On 2025-08-10 19:02, DanglingPointer wrote:
> > Are you in a similar position with a corrupted RAID 5 array?
>
> No I'm not, but I am close to 75% full on one of my arrays of 30TB. (8TBx3, + 6TB x1) with RAID5 data and RAID1 metadata/system.
>
> I'm not sure when I'll have a window to swap out the 6TB for an 8TB.   Just curious on what could go wrong if Murphy's law happens.  And how to recover.
>
>
> On 11/8/25 06:16, johnh1214@gmail.com wrote:
>> I did not get any help from the devs mailing list yet.
>>
>> For now, I've left things as-is (auto-mounted in RO degraded mode) and I'm securing a new NAS server, with sufficient drive space to backup whatever is still readable and error free, then I'll attempt a recovery using whatever best practice is advised, which currently is uncertain. I'll also upgrade the kernel to a more recent version which may have improved BTRFS recovery tools.
>>
>> Are you in a similar position with a corrupted RAID 5 array?
>>
>> In my case, it's not a HW failure, all the drives checkout fine, there are no SMART errors, the SATA cables are secured properly, etc. The problem was entirely due to running low on drive space, which of course, should not result in a corruption like I'm experiencing. I had another BTRFS RAID 5 array that ran out of space before this event, it had no issue, that's why I wasn't concerned with the low storage space.
>>
>> It's possible there was a problem somewhere due to an unclean shutdown, which became a bigger problem when the drive ran low on space. My mistake for not running scrubs more regularly.
>>
>> I read that a degraded RO mounted array, may cause random read errors, however the read errors in my case are not random, they are very specific to certain files.
>>
>> The best advice so far, was to copy all the data as is before performing a recovery. After that, if you can duplicate each drive exactly, then you can attempt multiple recovery's, however the array is too big for that much effort, so I have only one shot at it. The idea is to try mounting in "recovery" mode, if it tries to auto repair, cancel it, then add extra temporary storage space, because it was low on data. A balance operation is needed to free up space, but that seems dangerous given there's corruption, however a scrub may fail if there's not enough space. The temp storage should be large enough, very reliable (eg not a plugged in USB), and should have two partitions for duplicating the metadata.
>>
>> One mistake I made, was using RAID 1 for the metadata, when I had enough drives to use RAID 1C4. Maybe if I had more metadata redundancy, I'd be able to read everything.
>>
>> There are a few possible different steps to take when recovering, as I said, I'm compiling a list, securing sufficient storage for a full backup of what's still readable, and trying to determine the best order of steps to take before giving it a try.
>>
>> On 2025-08-10 01:10, DanglingPointer wrote:
>>> Did anyone help you Johnh1214?
>>>
>>> Were you able to recover and get it readable?
>>>
>>>
>>> On 13/7/25 08:02, johnh1214@gmail.com wrote:
>>>> It was suggested to me, that I contact the btrfs devs group to inform the group of this situation I've encountered.
>>>>
>>>> Any advice on what I should do to try and recover from the situation will be appreciated.
>>>>
>>>> Fortunately I have a good copy of the most important data backed up, however there are a few recent files not yet backed up that I hope to recover. A lot of the data was for temporary archival reasons, while moving systems around, most of it is no longer required, however, I'd like to try and recover from this situation if possible.
>>>>
>>>> The RAID5 array is 5 x 8TB, using RAID 1 for metatdata. I was told I could have instead used RAID1c4 for metatdata, but did not know this beforehand.
>>>>
>>>> I was copying data to the raid array, when btrfs ran out of free space, and went into read-only mode. The main issue is not that it's gone into read-only mode, it's that I can no longer read most of the files on the entire array, despite there being no noticeable issues reading the data before the low space problem was encountered. I never imagined, that running out of space could cause the entire file system to become mostly unreadable.
>>>>
>>>> I have not yet attempted a recovery, and have left things exactly as they are after the error was encountered. The server has not been rebooted, and I've commented out the mounting of the array from fstab in case there's an unplanned reboot. What I want to do first, is copy what I can from the drive "as-is" in read-only mode, before I attempt a rescue. I can list all the directories and files OK, there's no sign of file system structure corruption, but many of the underlying files are either entirely unreadable, or are only partly readable, with maybe 20% that are 100% readable.
>>>>
>>>> The file system reported it was running low on free space, however there was enough listed for the data transfer, about 2x more than I required. I know that when space is low, btrfs will sometimes run out early, despite it claiming there's enough. In the case at hand, I think it claimed to have about 150GB free, and I was copying about 56GB to it. I should have known better than to bother doing the copy, but expected no worse than the copy aborting due to a lack of free space. On single drives BTRFS FS, I've run out of space many times before without issues.
>>>>
>>>> After successfully transferring about 50% of the data, the copy aborted. There's no space left, and the FS encountered an error, switching to read-only mode to prevent further damage.
>>>>
>>>> Here are the vitals:
>>>>
>>>> Kernel: 6.1.0-37-amd64
>>>>
>>>> RAID 5 array is 5 x 8TB, using RAID 1 for metatdata
>>>> Note: someone told me I could have used RAID1cx4 for metatdata, is that true?
>>>>
>>>> All 5 Toshiba HDD's appear to be operating normally, and SMART reports all 5 drives are 100% healthy.
>>>>
>>>> btrfs fi show
>>>>
>>>> Label: 'pl.8000.00'  uuid: 5c3747c7-cc6a-45f2-a1e6-860095d0f7cd
>>>>     Total devices 5 FS bytes used 29.02TiB
>>>>     devid    1 size 7.28TiB used 7.28TiB path /dev/sdb
>>>>     devid    2 size 7.28TiB used 7.28TiB path /dev/sdd
>>>>     devid    3 size 7.28TiB used 7.28TiB path /dev/sdc
>>>>     devid    4 size 7.28TiB used 7.28TiB path /dev/sde
>>>>     devid    5 size 7.28TiB used 7.28TiB path /dev/sda
>>>>
>>>> Here is a /kern.log dump showing when the problem first appeared. The dump indicates the array ran out of space, and was re-mounted read-only, however the read-only state appears to be bad, with missing "mirrors".
>>>>
>>>> In the dump below, the line, "2025-07-07T19:30:28.806270-07:00" reports the array went into read-only mode.
>>>> Afterwards, it's complaining about mirror 1 and 2 wanted, which appear to be unavailable.
>>>>
>>>> /var/log/kern.log
>>>> 2025-07-07T19:30:28.806185-07:00 host kernel: [3777897.708336] ------------[ cut here ]------------
>>>> 2025-07-07T19:30:28.806200-07:00 host kernel: [3777897.708339] BTRFS: Transaction aborted (error -28)
>>>> 2025-07-07T19:30:28.806200-07:00 host kernel: [3777897.708366] WARNING: CPU: 8 PID: 3044847 at fs/btrfs/extent-tree.c:3092 __btrfs_free_extent.cold+0x661/0xa0b [btrfs]
>>>> 2025-07-07T19:30:28.806202-07:00 host kernel: [3777897.708409] Modules linked in: xt_MASQUERADE iptable_nat tcp_diag inet_diag unix_diag nft_nat nft_masq nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 vhost_net vho>
>>>> 2025-07-07T19:30:28.806204-07:00 host kernel: [3777897.708493] drm_kms_helper ahci libahci xhci_pci libata xhci_hcd nvme ixgbe drm nvme_core xfrm_algo t10_pi usbcore scsi_mod crc32_pclmul mdio_devres igb crc32c_intel i2c_piix4 lib>
>>>> 2025-07-07T19:30:28.806205-07:00 host kernel: [3777897.708524] CPU: 8 PID: 3044847 Comm: kworker/u64:43 Tainted: G X 6.1.0-37-amd64 #1  Debian 6.1.140-1
>>>> 2025-07-07T19:30:28.806205-07:00 host kernel: [3777897.708528] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X570D4U-2L2T, BIOS P1.30 12/04/2020
>>>> 2025-07-07T19:30:28.806206-07:00 host kernel: [3777897.708530] Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
>>>> 2025-07-07T19:30:28.806207-07:00 host kernel: [3777897.708565] RIP: 0010:__btrfs_free_extent.cold+0x661/0xa0b [btrfs]
>>>> 2025-07-07T19:30:28.806208-07:00 host kernel: [3777897.708596] Code: 78 50 e8 65 de ff ff eb 8e 8b 7c 24 20 e8 35 ee ff ff 84 c0 0f 84 fb 01 00 00 8b 74 24 20 48 c7 c7 b8 94 b3 c0 e8 50 61 38 da <0f> 0b c6 44 24 30 01 44 8b 44 24 3>
>>>> 2025-07-07T19:30:28.806209-07:00 host kernel: [3777897.708598] RSP: 0018:ffff9cbf1df13a80 EFLAGS: 00010286
>>>> 2025-07-07T19:30:28.806210-07:00 host kernel: [3777897.708600] RAX: 0000000000000000 RBX: 00002f6f91030000 RCX: 0000000000000027
>>>> 2025-07-07T19:30:28.806210-07:00 host kernel: [3777897.708602] RDX: ffff8b5b8ec203e8 RSI: 0000000000000001 RDI: ffff8b5b8ec203e0
>>>> 2025-07-07T19:30:28.806210-07:00 host kernel: [3777897.708604] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff9cbf1df138f8
>>>> 2025-07-07T19:30:28.806211-07:00 host kernel: [3777897.708605] R10: 0000000000000003 R11: ffff8b5c0f25de90 R12: 0000000000000001
>>>> 2025-07-07T19:30:28.806211-07:00 host kernel: [3777897.708606] R13: 0000000000000000 R14: 000000000000000a R15: ffff8b448dc605b0
>>>> 2025-07-07T19:30:28.806212-07:00 host kernel: [3777897.708608] FS: 0000000000000000(0000) GS:ffff8b5b8ec00000(0000) knlGS:0000000000000000
>>>> 2025-07-07T19:30:28.806212-07:00 host kernel: [3777897.708610] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> 2025-07-07T19:30:28.806213-07:00 host kernel: [3777897.708611] CR2: 0000557ac7d0a438 CR3: 00000001ead0c000 CR4: 0000000000350ee0
>>>> 2025-07-07T19:30:28.806215-07:00 host kernel: [3777897.708613] Call Trace:
>>>> 2025-07-07T19:30:28.806215-07:00 host kernel: [3777897.708617] <TASK>
>>>> 2025-07-07T19:30:28.806216-07:00 host kernel: [3777897.708621] ? __slab_free+0x11/0x2d0
>>>> 2025-07-07T19:30:28.806234-07:00 host kernel: [3777897.708629] __btrfs_run_delayed_refs+0x2be/0x10b0 [btrfs]
>>>> 2025-07-07T19:30:28.806234-07:00 host kernel: [3777897.708660] ? btrfs_search_slot+0x8a7/0xc90 [btrfs]
>>>> 2025-07-07T19:30:28.806235-07:00 host kernel: [3777897.708688] ? srso_return_thunk+0x5/0x10
>>>> 2025-07-07T19:30:28.806236-07:00 host kernel: [3777897.708693] ? set_extent_buffer_dirty+0x15/0x130 [btrfs]
>>>> 2025-07-07T19:30:28.806236-07:00 host kernel: [3777897.708723] ? srso_return_thunk+0x5/0x10
>>>> 2025-07-07T19:30:28.806236-07:00 host kernel: [3777897.708725] ? release_extent_buffer+0x99/0xb0 [btrfs]
>>>> 2025-07-07T19:30:28.806237-07:00 host kernel: [3777897.708754] btrfs_run_delayed_refs+0x76/0x1a0 [btrfs]
>>>> 2025-07-07T19:30:28.806237-07:00 host kernel: [3777897.708783] btrfs_start_dirty_block_groups+0x305/0x540 [btrfs]
>>>> 2025-07-07T19:30:28.806238-07:00 host kernel: [3777897.708817] btrfs_commit_transaction+0xab/0xc50 [btrfs]
>>>> 2025-07-07T19:30:28.806238-07:00 host kernel: [3777897.708847] ? srso_return_thunk+0x5/0x10
>>>> 2025-07-07T19:30:28.806239-07:00 host kernel: [3777897.708849] ? start_transaction+0xc3/0x5f0 [btrfs]
>>>> 2025-07-07T19:30:28.806254-07:00 host kernel: [3777897.708878] flush_space+0xfd/0x5f0 [btrfs]
>>>> 2025-07-07T19:30:28.806254-07:00 host kernel: [3777897.708911] btrfs_async_reclaim_metadata_space+0x1cc/0x2d0 [btrfs]
>>>> 2025-07-07T19:30:28.806255-07:00 host kernel: [3777897.708940] process_one_work+0x1c7/0x380
>>>> 2025-07-07T19:30:28.806255-07:00 host kernel: [3777897.708946] worker_thread+0x4d/0x380
>>>> 2025-07-07T19:30:28.806255-07:00 host kernel: [3777897.708949] ? rescuer_thread+0x3a0/0x3a0
>>>> 2025-07-07T19:30:28.806256-07:00 host kernel: [3777897.708950] kthread+0xda/0x100
>>>> 2025-07-07T19:30:28.806256-07:00 host kernel: [3777897.708954] ? kthread_complete_and_exit+0x20/0x20
>>>> 2025-07-07T19:30:28.806257-07:00 host kernel: [3777897.708957] ret_from_fork+0x22/0x30
>>>> 2025-07-07T19:30:28.806258-07:00 host kernel: [3777897.708964] </TASK>
>>>> 2025-07-07T19:30:28.806258-07:00 host kernel: [3777897.708965] ---[ end trace 0000000000000000 ]---
>>>> 2025-07-07T19:30:28.806261-07:00 host kernel: [3777897.708967] BTRFS info (device sdb: state A): dumping space info:
>>>> 2025-07-07T19:30:28.806262-07:00 host kernel: [3777897.708970] BTRFS info (device sdb: state A): space_info DATA has 60921196544 free, is full
>>>> 2025-07-07T19:30:28.806262-07:00 host kernel: [3777897.708972] BTRFS info (device sdb: state A): space_info total=31937462009856, used=31873161326592, pinned=4096, reserved=3377864704, may_use=45056, readonly=1572864 zone_unusable=0
>>>> 2025-07-07T19:30:28.806263-07:00 host kernel: [3777897.708975] BTRFS info (device sdb: state A): space_info METADATA has -2326528 free, is full
>>>> 2025-07-07T19:30:28.806263-07:00 host kernel: [3777897.708977] BTRFS info (device sdb: state A): space_info total=41875931136, used=39246086144, pinned=926269440, reserved=47579136, may_use=1658191872, readonly=131072 zone_unusable>
>>>> 2025-07-07T19:30:28.806266-07:00 host kernel: [3777897.708980] BTRFS info (device sdb: state A): space_info SYSTEM has 31686656 free, is not full
>>>> 2025-07-07T19:30:28.806266-07:00 host kernel: [3777897.708982] BTRFS info (device sdb: state A): space_info total=33554432, used=1867776, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
>>>> 2025-07-07T19:30:28.806267-07:00 host kernel: [3777897.708985] BTRFS info (device sdb: state A): global_block_rsv: size 536870912 reserved 0
>>>> 2025-07-07T19:30:28.806268-07:00 host kernel: [3777897.708986] BTRFS info (device sdb: state A): trans_block_rsv: size 0 reserved 0
>>>> 2025-07-07T19:30:28.806268-07:00 host kernel: [3777897.708988] BTRFS info (device sdb: state A): chunk_block_rsv: size 0 reserved 0
>>>> 2025-07-07T19:30:28.806269-07:00 host kernel: [3777897.708990] BTRFS info (device sdb: state A): delayed_block_rsv: size 262144 reserved 262144
>>>> 2025-07-07T19:30:28.806269-07:00 host kernel: [3777897.708992] BTRFS info (device sdb: state A): delayed_refs_rsv: size 2375024640 reserved 0
>>>> 2025-07-07T19:30:28.806270-07:00 host kernel: [3777897.708994] BTRFS: error (device sdb: state A) in __btrfs_free_extent:3092: errno=-28 No space left
>>>> 2025-07-07T19:30:28.806270-07:00 host kernel: [3777897.709670] BTRFS info (device sdb: state EA): forced readonly
>>>> 2025-07-07T19:30:28.806271-07:00 host kernel: [3777897.709672] BTRFS error (device sdb: state EA): failed to run delayed ref for logical 52156220768256 num_bytes 16384 type 176 action 2 ref_mod 1: -28
>>>> 2025-07-07T19:30:28.806274-07:00 host kernel: [3777897.710683] BTRFS: error (device sdb: state EA) in btrfs_run_delayed_refs:2165: errno=-28 No space left
>>>> 2025-07-07T19:31:37.922065-07:00 host kernel: [3777966.824892] BTRFS warning (device sdb: state EA): Skipping commit of aborted transaction.
>>>> 2025-07-07T19:31:37.922082-07:00 host kernel: [3777966.824906] BTRFS: error (device sdb: state EA) in btrfs_sync_log:3161: errno=-5 IO failure
>>>> 2025-07-07T20:06:21.662072-07:00 host kernel: [3780050.499696] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 2 wanted 4093212 found 4093166
>>>> 2025-07-07T20:06:21.682076-07:00 host kernel: [3780050.519936] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 1 wanted 4093212 found 4093166
>>>> 2025-07-07T20:06:21.682100-07:00 host kernel: [3780050.522082] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 2 wanted 4093212 found 4093166
>>>> 2025-07-07T20:06:21.686053-07:00 host kernel: [3780050.524439] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 1 wanted 4093212 found 4093166
>>>> 2025-07-07T20:06:21.698380-07:00 host kernel: [3780050.526396] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 2 wanted 4093212 found 4093166
>>>> 2025-07-07T20:06:21.698408-07:00 host kernel: [3780050.531760] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 1 wanted 4093212 found 4093166
>>>> 2025-07-07T20:06:21.702623-07:00 host kernel: [3780050.539105] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 2 wanted 4093212 found 4093166
>>>> 2025-07-07T20:06:21.708871-07:00 host kernel: [3780050.543772] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 1 wanted 4093212 found 4093166
>>>> 2025-07-07T20:06:21.717935-07:00 host kernel: [3780050.549936] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 2 wanted 4093212 found 4093166
>>>> 2025-07-07T20:06:21.726076-07:00 host kernel: [3780050.558423] BTRFS error (device sdb: state EA): parent transid verify failed on logical 54213629362176 mirror 1 wanted 4093212 found 4093166
>>>> 2025-07-07T20:06:31.106118-07:00 host kernel: [3780059.943621] verify_parent_transid: 278 callbacks suppressed
>>>>
>>>> :
>>>> NOTE: the parent transit errors, as shown above, repeat forever
>>>>
>>>> There are also checksum verify errors logged, like the one shown below, most of them are mirror 2, with a few mirror 1 logged.
>>>>
>>>> 2025-07-07T20:29:14.078068-07:00 host kernel: [3781422.870343] BTRFS warning (device sdb: state EA): checksum verify failed on logical 55129635373056 mirror 2 wanted 0x076ea9a7 found 0xf5e8fb26 level 1
>>>>
>>>> Are the metadata mirrors, 1 and 2, entirely missing, or are two of the 8TB drives involved in the array, no longer available after it went into read-only mode?
>>>>
>>>> I use xfce4 for emergency use on this server, and the file browser Thunar, is now showing 4 or the 5 drives as being available for mounting, whereas before this situation happened, none of the drives were shown as being available.
>>>>
>>>> This is a very confusing situation. Any assistance on how to proceed from here is appreciated.
>>>>
>>>>
>>


