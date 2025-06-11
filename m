Return-Path: <linux-btrfs+bounces-14611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84930AD61E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 23:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EEA3AB57C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 21:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A9224C068;
	Wed, 11 Jun 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WDormXoq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1F24A04A
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678586; cv=none; b=sx7aPgPC+Vg0Chdx1QpD02hhJs+jtkU4CHW12SEUUIcfaaBdoswt3fZzLtDf79WZLvlx3L+hT7EpLDI0/pvpqKe97RXDqRyPaW5zdTh96xZRBcFE8negSJMN9vNZ23jVzIShwKY7Vj5G3L/baof/PTETQ6dy9J3JkOKtU6d9tdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678586; c=relaxed/simple;
	bh=Y7aJ0wc4l1OTsU8JxZKGoHN1ZyR43IXJINUutBqn7rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvvMtHnfmwe0jFTbrpaNje/un02f8708qpzDt+gsD8CxsrjW3P9bR5CkYqFMYSZh2l+LoEM2wKu8XUN+Ragbz52mXrEcOcqxPTpUDFuF7WQ644j5UcV7wVs+FGS2AedFFky9DptFzS8vTRvLnIXstr1TbBV/360WXH/x9ldiakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WDormXoq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a5123c1533so237981f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749678582; x=1750283382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k8kKk81mBNakZPCbUqIzUjHPA4UBFTbYHw/sM+9fEUE=;
        b=WDormXoqZzQqUFJTl9aqPKSqUsdnzgSYXo/7irwaaGW/GIHDCFkJrRqGDvr14QzYpG
         mpcp28OxuLtEclXEpyNlY3QZZ6MD/xPZ5eSX6vM65DUJYLNWb7DmhIoctmSZylnT0Pgg
         9vdszWuJWsfezK7qXhRJ8r+WWV+S1L9G7wfDZffZW/ZPXPqBBfDZRkWH/pULGFW5C+qi
         6PANPL7i2LujtjteIx/0pQg0MargADsR5NZ7BAB+3SmLw5SFTTiAFFGfWkS3Np104vt4
         7SURDZyjtm3krUH0eFaV6atPcnnzKyKhRzn4NlST++ZUzsxUxY3+gHtzVyxUs81Sqrzr
         38OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749678582; x=1750283382;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8kKk81mBNakZPCbUqIzUjHPA4UBFTbYHw/sM+9fEUE=;
        b=w2Z2FiOJSS2WpQgXvbFyhpHUbDpdudg+uKyF+JCGhLOoSPC0weTvaRASYzMRaduKDV
         HzHlSyklhOh9lodiQFWrPpu2ovnBU9WqL3QdPmoT7i9GNi/5s1XUl37ZeIll/rRtyZ2G
         9swLxvcGFWEDBIlxOnD6rrTCDJ0AcvNXInLBx10Wkm8klW2sNzGgK8bnSstfi4X1GP2p
         Irn1Bpofsuqkru42Lh6fCHMSQe5mxtJcRl89vQZe1+FEhafPCp4S5raZDfW6lfb1o1KN
         jd+pchTdy7NEFUIrak0mSkj7ZHxNXZKVUAiAhrSuhHupoI+zmwn6JDGKAKthGlMSyCjV
         hgRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpR2W0GTMzMwTlAMiOm9bllE7Ieghj05+5BVtNGf/WG4Atffd7ji1pJNQ++xKg5BcDqhrMhCfR/oizxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1R1InXnhaktW/GFeI6E7ck1D0P/Sha5NGEd6HjSlipPwte22M
	WtHyatcL0NM1zvtJFrNlwDSZoLQ6FwY+MiOHfIKsSy9VH2BSsDbw45JEWGHPwZIwsDM=
X-Gm-Gg: ASbGncsElcB3EiDMN9mMlOdbeq0G7EjBS3u4HVjywSPcW0lJo1uLSD5NVDY1XuZ8AI4
	9qQIefmlxa3GTaemUFOcGk5FwhFBtfHcKuHaebz2wiO64SD+GJN3Qjv2pimxCiQgi64p8QqLDBX
	UXyl6MT66zKqO7Vxspo1ZEd5ScAR56PbckBXC6B3Z0ohtEWigsrWEk93kUGxRqz0hm7QnZvsAFf
	ZmehS2AdxqV3mqN8fyM5nFydsw6HDOkbvjWcB80qKN+WpNRGMbegVH1BQEx87asvyl6k2/QFf0f
	bCLNG7ZdA/h0tRbfunn99az8CXueeG1mtHgB0zIwK1y+aUoSZIb3H3ulT7fAyQNHL6d2EniYCaa
	zDHJGZnR3k1hQ0A==
X-Google-Smtp-Source: AGHT+IHoeB3BnKqk7kg4l9DHCjey1kXwIGtHWK6+VzLfDLo4hRds1QwGjFbjGPC1xg2negwvkZXvog==
X-Received: by 2002:a05:6000:2c0f:b0:3a4:f936:7882 with SMTP id ffacd0b85a97d-3a560761a96mr774938f8f.55.1749678581955;
        Wed, 11 Jun 2025 14:49:41 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748809eb987sm36534b3a.129.2025.06.11.14.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 14:49:41 -0700 (PDT)
Message-ID: <9093e0d6-d33e-4c4b-814f-9134d568f395@suse.com>
Date: Thu, 12 Jun 2025 07:19:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] btrfs: use the super_block as bdev holder
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>, Christoph Hellwig <hch@lst.de>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250611100303.110311-1-jth@kernel.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250611100303.110311-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/11 19:32, Johannes Thumshirn 写道:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> This is a series I've picked up from Christoph, it changes the
> block_device's bdev holder from fs_type to the super block.
> 
> As the re-base was non trivial, I opted to drop Boris' Reviewed-by tags.
> 
> Here's the original cover letter:
> Hi all,
> 
> this series contains the btrfs parts of the "remove get_super" from June
> that managed to get lost.
> 
> I've dropped all the reviews from back then as the rebase against the new
> mount API conversion led to a lot of non-trivial conflicts.
> 
> Josef kindly ran it through the CI farm and provided a fixup based on that.

Unfortunately it crashed immediately on btrfs/001:

[   23.878153] BTRFS info (device dm-0): using free-space-tree
[   23.891318] BUG: kernel NULL pointer dereference, address: 
00000000000006f0
[   23.894047] #PF: supervisor read access in kernel mode
[   23.896010] #PF: error_code(0x0000) - not-present page
[   23.897982] PGD 0 P4D 0
[   23.899016] Oops: Oops: 0000 [#1] SMP NOPTI
[   23.900738] CPU: 9 UID: 0 PID: 768 Comm: mount Not tainted 
6.16.0-rc1-custom+ #253 PREEMPT(full)
[   23.904288] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
unknown 02/02/2022
[   23.907696] RIP: 0010:btrfs_get_tree+0x29c/0x670 [btrfs]
[   23.910090] Code: 89 83 50 02 00 00 e9 b0 fe ff ff 48 c7 c7 a0 4c 6f 
a0 48 89 04 24 e8 63 6d 67 e1 8b 2c 24 e9 e9 fe ff ff 49 8b ae 80 00 00 
00 <48> 8b bd f0 06 00 00 48 85 ff 74 10 e8 03 c6 05 00 48 c7 85 f0 06
[   23.917698] RSP: 0018:ffffc90002663e00 EFLAGS: 00010246
[   23.919769] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[   23.922817] RDX: 7fffffffffffffff RSI: 0000000000000000 RDI: 
ffffffff835d9d80
[   23.925869] RBP: 0000000000000000 R08: 0000000000000005 R09: 
ffff888101ba6000
[   23.928916] R10: 00000000000000c8 R11: ffff88810a8fe280 R12: 
ffff888109932d80
[   23.932083] R13: ffff8881061ef640 R14: ffff888104dab840 R15: 
ffff888109932d80
[   23.935160] FS:  00007f9aa721ab80(0000) GS:ffff8882f4762000(0000) 
knlGS:0000000000000000
[   23.938582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.941060] CR2: 00000000000006f0 CR3: 0000000128bc2000 CR4: 
00000000000006f0
[   23.944122] Call Trace:
[   23.945228]  <TASK>
[   23.946189]  ? fscontext_read+0x118/0x130
[   23.947947]  vfs_get_tree+0x29/0xd0
[   23.949507]  vfs_cmd_create+0x57/0xd0
[   23.951131]  __do_sys_fsconfig+0x4b6/0x650
[   23.952891]  do_syscall_64+0x54/0x1d0
[   23.954522]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   23.956703] RIP: 0033:0x7f9aa736fefe
[   23.958313] Code: 73 01 c3 48 8b 0d 12 be 0c 00 f7 d8 64 89 01 48 83 
c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e2 bd 0c 00 f7 d8 64 89 01 48
[   23.966225] RSP: 002b:00007ffe79405e18 EFLAGS: 00000246 ORIG_RAX: 
00000000000001af
[   23.969431] RAX: ffffffffffffffda RBX: 000055f970791430 RCX: 
00007f9aa736fefe
[   23.972466] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 
0000000000000003
[   23.975485] RBP: 00007ffe79405e50 R08: 0000000000000000 R09: 
0000000000000000
[   23.978527] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007f9aa7499980
[   23.981535] R13: 0000000000000000 R14: 000055f970792720 R15: 
00007f9aa748e8e0
[   23.984548]  </TASK>
[   23.985537] Modules linked in: crc32c_cryptoapi vfat fat btrfs 
blake2b_generic xor zstd_compress iTCO_wdt iTCO_vendor_support psmouse 
pcspkr lpc_ich i2c_i801 i2c_smbus joydev intel_agp intel_gtt mousedev 
agpgart raid6_pq drm fuse loop qemu_fw_cfg ext4 crc16 mbcache jbd2 
dm_mod virtio_net net_failover virtio_rng failover virtio_balloon 
virtio_console virtio_blk rng_core virtio_scsi virtio_pci serio_raw 
usbhid virtio_pci_legacy_dev virtio_pci_modern_dev
[   24.002094] Dumping ftrace buffer:
[   24.003601]    (ftrace buffer empty)
[   24.005188] CR2: 00000000000006f0
[   24.006735] ---[ end trace 0000000000000000 ]---
[   25.685915] RIP: 0010:btrfs_get_tree+0x29c/0x670 [btrfs]
[   25.688118] Code: 89 83 50 02 00 00 e9 b0 fe ff ff 48 c7 c7 a0 4c 6f 
a0 48 89 04 24 e8 63 6d 67 e1 8b 2c 24 e9 e9 fe ff ff 49 8b ae 80 00 00 
00 <48> 8b bd f0 06 00 00 48 85 ff 74 10 e8 03 c6 05 00 48 c7 85 f0 06
[   25.695103] RSP: 0018:ffffc90002663e00 EFLAGS: 00010246
[   25.697125] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[   25.699813] RDX: 7fffffffffffffff RSI: 0000000000000000 RDI: 
ffffffff835d9d80
[   25.702464] RBP: 0000000000000000 R08: 0000000000000005 R09: 
ffff888101ba6000
[   25.705185] R10: 00000000000000c8 R11: ffff88810a8fe280 R12: 
ffff888109932d80
[   25.708000] R13: ffff8881061ef640 R14: ffff888104dab840 R15: 
ffff888109932d80
[   25.710720] FS:  00007f9aa721ab80(0000) GS:ffff8882f4762000(0000) 
knlGS:0000000000000000
[   25.713772] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.716003] CR2: 00000000000006f0 CR3: 0000000128bc2000 CR4: 
00000000000006f0
[   25.718657] Kernel panic - not syncing: Fatal exception
[   25.721077] Dumping ftrace buffer:
[   25.722398]    (ftrace buffer empty)
[   25.723775] Kernel Offset: disabled
[   27.228888] Rebooting in 5 seconds..>
> 
> 
> Link to rebase v1:
> https://lore.kernel.org/linux-btrfs/20240214-hch-device-open-v1-0-b153428b4f72@wdc.com/
> 
> Link to original posting:
> https://lore.kernel.org/linux-btrfs/b083ae24-2273-479f-8c9e-96cb9ef083b8@wdc.com/
> 
> Christoph Hellwig (5):
>    btrfs: always open the device read-only in btrfs_scan_one_device
>    btrfs: call btrfs_close_devices from ->kill_sb
>    btrfs: split btrfs_fs_devices.opened
>    btrfs: open block devices after superblock creation
>    btrfs: use the super_block as holder when mounting file systems
> 
>   fs/btrfs/disk-io.c |  4 +--
>   fs/btrfs/super.c   | 70 +++++++++++++++++++++++++++-------------------
>   fs/btrfs/volumes.c | 62 ++++++++++++++++++++--------------------
>   fs/btrfs/volumes.h |  8 ++++--
>   4 files changed, 80 insertions(+), 64 deletions(-)
> 


