Return-Path: <linux-btrfs+bounces-6168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A8B9258E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 12:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0763A287358
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BDA172777;
	Wed,  3 Jul 2024 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K+wwnt7q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1616B384
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002794; cv=none; b=ur8FN128LoaFSrhU8Qse3Dwu6u+znWVkf3MQAZK4+ubBMAKQW71Ip5GC4Wqvwpr8kJnUYkdLDQjTixFVBANHC+gDNfxIiY84SwUlzo0ywvBScQjBZJ5OaP3MarcehjuZIs6AV55YgD6xwsxjmGHO0166Hm3uSerCvSUvYFV7ZfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002794; c=relaxed/simple;
	bh=z7avOWPP63P1PNvrLIbTrV8TdjTuRXvupxHU8w6tOxw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Ku9B4siQF16tDnpyPYtJFYBOSo+DbNBXY5B3ArzPottRee0we6p8jsiukOz+USFXOBYlDjZYc3hO5QjYy8N2GhACk9EHA0vyrdmZfkKgeQwzxBvgNS8rdR5ZzMR20rs9neNgJR5lmdeZGq/yf7xqlyyHj6x89eisWe+QNeLE++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K+wwnt7q; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdb0d8107so6236927e87.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jul 2024 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720002790; x=1720607590; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42FI2OJ+1IbWPVQjkPD7u8dH2G0qPfKhkYg5yWe4mG4=;
        b=K+wwnt7qUwIYt+9+RY+YLACM3wduTp1ZkL/ycmmEN+FTl2+giS8YpSd+1+TNEgycSQ
         CRifG2fMGJB3a8pyyL7+pxKRNc0ZufDFSfB2o+y201E3oRH+WMUUnQit/5LiJwkNdAmM
         t/GFpDTKztIcoENb2N+tnFH2UlOApKfB1n9fFBsZ1JAVZMvQ1bVmwa4lsDKLyyLKhvaF
         TGmKcQaa8u0XLzZbr8INhr1Hg2a7FO4SSUoPaCGzfsMJiYqx9rR42DlGTKZg6Q/TspIZ
         Ec/19r6/iF44I5h/DB1wAXo9YOxXd6m1ubj5zk24kRxxNWo56+cmxdoa6l1nx4t/5biQ
         XPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720002790; x=1720607590;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42FI2OJ+1IbWPVQjkPD7u8dH2G0qPfKhkYg5yWe4mG4=;
        b=VqT+ocohBuF1ILtvp440Pblx50LPNKuO8KA7KlA53k5tzp4STEnn1vkB5Ir/r0tWeo
         Zbspt2QyzrGKJbD2ekMPVbOwHc7AHT6d51a0gXk4GtlZvK6z3MHlf7IqfsFNAHF61ckt
         YUh8ozIUCI7PVKrX9a3XkqJZD2w+K/918UmK94CMNyJ8XR2IjBN4KFdlrY6woTXMApKW
         1dmlhkcPkVk9CTqQqz89zEQ0jvvlevCg3o9OrFs01sbJsyQwXk6g8DpPDDpxcFnf628F
         UB5p03Mt0eQ9ARBXYUO0ONE5nvzTVokxA9HMKa779NIsI3pE8jytRRSz6SKNJlq5HPFx
         1bJA==
X-Forwarded-Encrypted: i=1; AJvYcCWrbUBc4V/k3vi+5xvrnaylnQ5z4UUTQeZ7ms8OJ0BjtdOQ07ZSy2iCcXxg9Zvh75KXQvc1ccunrpgjSluqZ5ItLEu+OCeyIydo1iM=
X-Gm-Message-State: AOJu0YyJfoOkyTr9wPIj0pD49tqen72QD6KvNpy4d/BHGvFcoRnAW5ZI
	MLA5s6yQo4TSroTtyB+jwu0tBTBnnXtLTdm+wcjXGJ94+dTl0SBnSBzZAId9mGr3B9aiUTcV/D/
	d
X-Google-Smtp-Source: AGHT+IETilU+sfpmBFVVOjUQ+p7zm3Zqaa27cajNfEZCANLcObMnkMmOdbPvX6wCmJoOS11VxEjhUA==
X-Received: by 2002:a05:6512:b1c:b0:52e:7065:88e2 with SMTP id 2adb3069b0e04-52e8264c411mr8138635e87.13.1720002788980;
        Wed, 03 Jul 2024 03:33:08 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ac34fsm10096943b3a.162.2024.07.03.03.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 03:33:08 -0700 (PDT)
Message-ID: <5a083f16-cdbc-4d60-8890-58de8d80eaa1@suse.com>
Date: Wed, 3 Jul 2024 20:03:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Memory Management List <linux-mm@kvack.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <wqu@suse.com>
Subject: Soft lockup for cgroup charge?
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Recently I'm hitting the following soft lockup related to cgroup charge 
on aarch64:

  watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [btrfs:698546]
  Modules linked in: dm_log_writes dm_flakey nls_ascii nls_cp437 vfat 
crct10dif_ce polyval_ce polyval_generic ghash_ce rtc_efi fat processor 
btrfs xor xor_neon raid6_pq zstd_compress fuse loop nfnetlink 
qemu_fw_cfg ext4 mbcache jbd2 dm_mod xhci_pci virtio_net 
xhci_pci_renesas net_failover xhci_hcd virtio_balloon virtio_scsi 
failover dimlib virtio_blk virtio_console virtio_mmio
  irq event stamp: 47291484
  hardirqs last  enabled at (47291483): [<ffffabe6d1a5d294>] 
try_charge_memcg+0x3ac/0x780
  hardirqs last disabled at (47291484): [<ffffabe6d2401244>] 
el1_interrupt+0x24/0x80
  softirqs last  enabled at (47282714): [<ffffabe6d168e7a4>] 
handle_softirqs+0x2bc/0x310
  softirqs last disabled at (47282709): [<ffffabe6d16301e4>] 
__do_softirq+0x1c/0x28
  CPU: 3 PID: 698546 Comm: btrfs Not tainted 6.10.0-rc6-custom+ #34
  Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : try_charge_memcg+0x154/0x780
  lr : try_charge_memcg+0x3ac/0x780
  sp : ffff800089b83430
  x29: ffff800089b834a0 x28: 0000000000000002 x27: ffffabe6d2b515e8
  x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000008c40
  x23: ffffabe6d2b515e8 x22: 0000000000000000 x21: 0000000000000040
  x20: ffff4854c6b32000 x19: 0000000000000004 x18: 0000000000000000
  x17: 0000000000000000 x16: ffffabe6d19474a8 x15: ffff4854d24b6f88
  x14: 0000000000000000 x13: 0000000000000000 x12: ffff4854ff1cdfd0
  x11: ffffabe6d4330370 x10: ffffabe6d46442ec x9 : ffffabe6d2b3f6e4
  x8 : ffff800089b83340 x7 : ffff800089b84000 x6 : ffff800089b80000
  x5 : 0000000000000000 x4 : 0000000000000006 x3 : 000000ffffffffff
  x2 : 0000000000000001 x1 : ffffabe6d2b3f6e0 x0 : 0000000002d19c5b
  Call trace:
   try_charge_memcg+0x154/0x780
   __mem_cgroup_charge+0x5c/0xc0
   filemap_add_folio+0x5c/0x118
   attach_eb_folio_to_filemap+0x84/0x4e0 [btrfs]
   alloc_extent_buffer+0x1d4/0x730 [btrfs]
   btrfs_find_create_tree_block+0x20/0x48 [btrfs]
   btrfs_readahead_tree_block+0x4c/0xd8 [btrfs]
   relocate_tree_blocks+0x1d8/0x3a0 [btrfs]
   relocate_block_group+0x37c/0x508 [btrfs]
   btrfs_relocate_block_group+0x274/0x458 [btrfs]
   btrfs_relocate_chunk+0x54/0x1b8 [btrfs]
   __btrfs_balance+0x2dc/0x4e0 [btrfs]
   btrfs_balance+0x3b4/0x730 [btrfs]
   btrfs_ioctl_balance+0x12c/0x300 [btrfs]
   btrfs_ioctl+0xf90/0x1380 [btrfs]
   __arm64_sys_ioctl+0xb4/0x100
   invoke_syscall+0x74/0x100
   el0_svc_common.constprop.0+0x48/0xf0
   do_el0_svc+0x24/0x38
   el0_svc+0x54/0x1c0
   el0t_64_sync_handler+0x120/0x130
   el0t_64_sync+0x194/0x198

I can hit that somewhat reliably (around 2/3)

The code is modified btrfs code 
(https://github.com/adam900710/linux/tree/larger_meta_folio), which does 
something like:

- Allocate an order 2 folio using GFP_NOFS | __GFP_NOFAIL
- Attach that order 2 folio to filemap using GFP_NOFS | __GFP_NOFAIL
   With extra handling for EEXIST.

Meanwhile for the original btrfs code, the only difference is in the 
folio order (order 2 vs 0).

Considering the gfp flag is the same and only order is different, I'm 
wondering if it's memory cgroup doing something weird, or it's not the 
correct way to add a higher order folio to page cache?

Thanks,
Qu

