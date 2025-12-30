Return-Path: <linux-btrfs+bounces-20039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27050CE8E68
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 08:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E63C0300DBB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 07:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B132DE717;
	Tue, 30 Dec 2025 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="iNW/YqV1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69972236F0
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767079973; cv=none; b=CT1PD7R++hGziksEgu6OU4gjVyM2Lv2DBmNxj0vRxdFkm7fLPUfw2ykUfNVgXjx9ufedPsJmcv6C8pCRWXUKZmhcXGlFYLw9z5kw7jFfWhRMQRZnBWvNMScjJlx3lat9N9eiinaIVrdn8dX2eUtIDK11K2k2R3Qpmm+bkwriNfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767079973; c=relaxed/simple;
	bh=PMKKvUea0kfyrhbIk4q/v1rBSxtKehQKLlnj4y8Z/aU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HvwJo7tuoGO2Ne3YSN8E4S2N4SMWkgmx/BwDbTH09QS57MOjtiCONKv3DllY6IKmEu/lKFtV2Tfzvf39IayTPFBNg452npuCHvVcnW1bsNYDmqgRHGusocMJSNo2rbM8fYC+LTxA12RbcBcJmwciHXb2h65GWjDXTsC5/NrJ9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=iNW/YqV1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c718c5481so9380880a91.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Dec 2025 23:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1767079971; x=1767684771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uUlwbZW0uW61EHDljdHe2pJ1CLNsAKPuwyaTtJu+Xxg=;
        b=iNW/YqV1r4VsnmNzonrL61YmhEtbccjVufo+MN16uaTJ1OVv+7T+a36XTuioKDzZS/
         FnSjdSqmhOp4CggvkMyiGktSClvN9MvAIMjcfTx3dyWzabpamjt4/BiQrti+wf4UjWm1
         gjDYV4oWm6a2NSBiDYF15OPQbIjtADEajum/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767079971; x=1767684771;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUlwbZW0uW61EHDljdHe2pJ1CLNsAKPuwyaTtJu+Xxg=;
        b=Fg995QFyoXUycn+5igOI3F/rX21UrsJpNA58S7VdAr9g7uIMSP5nivJcuteSLmnLH2
         UKw31TdxmD5W1wdPQSI6H2Hlydcf96gx72lhy9VKFYodd2hLbLfuWOypNWJGJAKU3rBE
         E3j8ES03qGDePM8+vHqakQg6XsyVcOO24ovV2a8Vg6VTMm78xK/eLl6X8KB4V1mS1yT7
         a4nJKO0cMgAtMxCLluXCSjU7xnhqYz11aSrzE2/UBCYmB6Bp2oxYnfWIfU2l9l+sT+Ot
         mKbszciIlzPE6lF7pmW4tT62WWWWmB3D6QuIgap/GW49K8J1EWdxe1blFOt28H22XBpM
         zZBg==
X-Forwarded-Encrypted: i=1; AJvYcCV/ONHZMmdhtH7pmApbzk6lxYeQROc6l3mT61cZdEd/ZiGL0/CHLwrfJmlS08xjfOoF1sDktMhLFaUisQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSv5OOrxdQShsBhLCu/sk8vpjvoPlsu97t4i72qYKResMXY4o
	sBiTE5NhyKV0OGCsCkD5H8igro/AwGj+T9ZzLV1ww8HtVkNt25MiAL6le28DEikQe5oojR6TFG8
	n0a0s4/1fx0ICIdkcao8o1dtR5z8FI004HimKkulEdQ==
X-Gm-Gg: AY/fxX6YQRAuqCMdSvLlGgmSttLlQSn8fQAUs/x+EQhmFqolErWQVWcomhmZ04Btt8S
	81OyEqEu/GefLAwWVod2ItcX29FaFuee8HS1WDNe5X5RYRnuacDFL6OBhUVNkp2Iw8EovzfT6fg
	3qBFLXQ/BZ3UqvdaCxj4uXBppENXjN7o7FtObbaf1PqUq6/IdrpZIbVsmSZTxGPOqvl/O6Yy9mu
	fQ1pGE7UXjrbsdAH4heOG4iKgDmHkWOb8gwpqaCxTwIuEpdzzKqQJKw/9jyASfYElOJOgE56p5E
	C5+VzRBOkc08/XN5DZVwN6oDLHxCUz+5DwJnxS5s3NpiMhpgpPhN5RpRv7R41gsn9ESx0eGBLji
	tur/qO+RG+Pa3bh2Axx7sAQYRbuTGwSmc5XQOrJ8FIIWtcj3cL2Pzt6l8tulou/UzP5JMn6oj8o
	Bs6/ivkEO6wKiHLhAtXenAOpvJLv9ln2s54O/J
X-Google-Smtp-Source: AGHT+IGvvN8950IcxWSAGFszSo61RThFiea1HZ/e8OEQ8iDZeLrg5FZril2MJ6rC900uvnTRwWQJjqP7J5SU9YNlQD0=
X-Received: by 2002:a17:90b:46:b0:349:3fe8:e7de with SMTP id
 98e67ed59e1d1-34e921e64efmr26816988a91.28.1767079970865; Mon, 29 Dec 2025
 23:32:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel J Blueman <daniel@quora.org>
Date: Tue, 30 Dec 2025 15:32:39 +0800
X-Gm-Features: AQt7F2qQuHOLaSvJRm8YddNridShG0vgGiBNRUOEwwhrLLjlLwgis4V9k5MPrVI
Message-ID: <CAMVG2svM0G-=OZidTONdP6V7AjKiLLLYgwjZZC_fU7_pWa=zXQ@mail.gmail.com>
Subject: [6.19-rc3] xxhash invalid access during BTRFS mount
To: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Linux BTRFS <linux-btrfs@vger.kernel.org>
Cc: linux-crypto@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Dave, Chris et al,

When mounting a BTRFS filesystem on 6.19-rc3 on ARM64 using xxhash
checksumming and KASAN, I see invalid access:

BTRFS info (device nvme0n1p5): first mount of filesystem
f99f2753-0283-4f93-8f5d-7a9f59f148cc
BTRFS info (device nvme0n1p5): using xxhash64 (xxhash64-generic)
checksum algorithm
==================================================================
BUG: KASAN: invalid-access in xxh64_update (lib/xxhash.c:143 lib/xxhash.c:283)
Read of size 8 at addr 21ff000802247000 by task kworker/u48:3/48
Pointer tag: [21], memory tag: [c0]

CPU: 1 UID: 0 PID: 48 Comm: kworker/u48:3 Tainted: G      E
6.19.0-rc3 #19 PREEMPTLAZY
Tainted: [E]=UNSIGNED_MODULE
Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN60WW 09/11/2025
Workqueue: btrfs-endio-meta simple_end_io_work
Call trace:
show_stack (arch/arm64/kernel/stacktrace.c:501) (C)
dump_stack_lvl (lib/dump_stack.c:122)
print_address_description.isra.0 (mm/kasan/report.c:379)
print_report (mm/kasan/report.c:450 (discriminator 1)
mm/kasan/report.c:483 (discriminator 1))
kasan_report (mm/kasan/report.c:597)
kasan_check_range (mm/kasan/sw_tags.c:86 (discriminator 1))
__hwasan_loadN_noabort (mm/kasan/sw_tags.c:158)
xxh64_update (lib/xxhash.c:143 lib/xxhash.c:283)
xxhash64_update (crypto/xxhash_generic.c:49)
crypto_shash_finup (crypto/shash.c:123 (discriminator 1))
csum_tree_block (fs/btrfs/disk-io.c:110 (discriminator 3))
btrfs_validate_extent_buffer (fs/btrfs/disk-io.c:404)
end_bbio_meta_read (fs/btrfs/extent_io.c:3822 (discriminator 1))
btrfs_bio_end_io (fs/btrfs/bio.c:146)
simple_end_io_work (fs/btrfs/bio.c:382)
process_one_work (./arch/arm64/include/asm/jump_label.h:36
./include/trace/events/workqueue.h:110 kernel/workqueue.c:3262)
worker_thread (kernel/workqueue.c:3334 (discriminator 2)
kernel/workqueue.c:3421 (discriminator 2))
kthread (kernel/kthread.c:463)
ret_from_fork (arch/arm64/kernel/entry.S:861)

The buggy address belongs to the physical page:
page: refcount:2 mapcount:0 mapping:00000000973bd0ac index:0x9731 pfn:0x882247
memcg:aaff000800ae1b00
aops:btree_aops ino:1
flags: 0x47e400000004020(lru|private|node=0|zone=2|kasantag=0x3f)
raw: 047e400000004020 fffffdffe0089188 fffffdffe0089208 ccff000814148300
raw: 0000000000009731 10ff0008493322d0 00000002ffffffff aaff000800ae1b00
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff000802246e00: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21
ffff000802246f00: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21
>ffff000802247000: c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0
^
ffff000802247100: c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0
ffff000802247200: c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0

Let me know for any further testing or debug.

Thanks,
  Dan
--
Daniel J Blueman

