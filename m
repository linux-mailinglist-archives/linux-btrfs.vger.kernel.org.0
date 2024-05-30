Return-Path: <linux-btrfs+bounces-5365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81448D4D4F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 15:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4121C22B87
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CC9186E39;
	Thu, 30 May 2024 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwB01mVZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA50186E2C
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077387; cv=none; b=KdVsEAYx3DlCf9VZt8eQ1CX8MGNvw7xdGjHEY2NNJGSMMglJHNJBQOWXarf9xyyLFJicqjJowURfogsJGihxYx/ZxHLGlLIxNZkH0TIoQ0ehpFXcfV/0rWSBZij/q4aHSwrFQtrrnDZYwqiyCDSb3ToWme41WCgXTRrxCUtFyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077387; c=relaxed/simple;
	bh=FGBSQOuAb0NlB6ZQthzXYAirwmMW8u3SD2gpZJepyxc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZZmrl5DVVoOU/lmg+T6+SbisGVzNzIh7VQ+4FV0UCeaNtFHmV9GQAErtUJnrL/6ZLD2jZFceX9YGqM90SLPbnKfGiil1Jb223aePNu2kld8Mmr5dGFzQUAKJucVFmbEQhoCmowkMZczd3n1uHWgFIPtaDDuhgLnrKwhI3VKLUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gwB01mVZ; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4e4f004bd17so188696e0c.3
        for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 06:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717077384; x=1717682184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EXUCNy99zkbik9zLqKW1CEH6iQfLDGzfWLNIvH5uY+0=;
        b=gwB01mVZcr7JkwK/+Cu5gtOt+gyDgQ6wQUvNEaL1//euAn58VwbBmF4cKoCTRBCmBz
         IiGapOLjJPNyvU+sp+qCIuoX0x4obuxy+fiXL78DZlhcTE+wTQV2SPS9zowxxdFsYc0F
         n5WKgXTv+yT0fYufXs7PxG2EvqNdIbPWEggbIqPeeBI4KICBKoLgsxqk2aphzHZm3oSX
         2z7v+Cq9QvLPHjEtKel6Hi0ZkTAZu8SDJhIYpGeiShG7ZdBlscDFtwCmF/W1j39K6akT
         r1qif0zJIC/uj3Od9e2Ut1zuExIUfSXLBE+QMXMQZEHVE+RZ5QsR9SA0QozOYWlypQWl
         cbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717077384; x=1717682184;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXUCNy99zkbik9zLqKW1CEH6iQfLDGzfWLNIvH5uY+0=;
        b=J/2188NUo1UC6vcIwUUW4BqVRof2ct4YKwDKBENJnA3FORTPr6O8cGiiKRkzSVYePm
         /etCuoNpR1Jf5eKxFtqxBvjB4i5q9r8HQ1CNRV9pJVURytl72qFD++iqgLjbL8bp17x/
         HTmYhAy2LVsDcR7tz9xbI3N4Tv1FIiBu9k/12mpboZ3P73v2J7Z4WBHPf72tbdUk8gWE
         Ol6Lv3reNpnySn5sx93RBkal6S6FmmfKhHOuyvlskLIQzvuqtme0LKIB8jsGunaQBcVt
         kTHTg6+Cnx/ijV/MeOrV7TaVBWECoRysu8TSqLk0pJI90LR5ayhXn2dd2ZBFoslw2cXb
         PSOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE1STB2ieOyWRur0islnvqXsJifJBOgaNkaLunpT/sXXF9RyF1w0i78f4ozBCgXzvAeLBW4/aT5OLMWUZ/rIOr4jXSsBIoMGQqUDY=
X-Gm-Message-State: AOJu0YwJrJlRVanym6kRlD9Y5ySjNHX6pBxa97y1+C9ttG6dgXXCIg3y
	NczrRPgYiC/WizMntWEYQHdgHOaidraN/o2iwrZRPh/9owVZJjb1hNhlHj+Zj1cLdRlhWkD324d
	1n8Hdvm4FK9NSbpOtqJEprv4DZv/1EdPMnelicQ==
X-Google-Smtp-Source: AGHT+IHtMCQyGfRZVl+J4B/Ueb8+BlAQuJC8en+4dH/bryuo8aki4OV0HUSb9FEfVVIkSlPkZD7ersSE7iRVsS8Zn9A=
X-Received: by 2002:a05:6122:319c:b0:4d4:1ec7:76e5 with SMTP id
 71dfb90a1353d-4eaf248dd21mr2295414e0c.16.1717077384478; Thu, 30 May 2024
 06:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 30 May 2024 19:26:12 +0530
Message-ID: <CA+G9fYvJjAqf1pxMZpsm6rO_UVqhKOpB=0SUpBec8UhQBOXSrA@mail.gmail.com>
Subject: BUG: kernel NULL pointer dereference, address: 000000000000002c -
 RIP: 0010:alloc_extent_buffer
To: open list <linux-kernel@vger.kernel.org>, Linux btrfs <linux-btrfs@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

The following kernel BUG: and kernel crash noticed while running xfstests btfs
filesystem testing on qemu-x86_64 with loop back.

Steps to reproduce link provided.

Test details:
----
  Tests:  xfstests-btrfs  btrfs/232
  SKIP_INSTALL='true'
  TEST_DEV='/dev/loop0'
  SCRATCH_DEV='/dev/loop1'
  TEST_DIR='/mnt/test'
  SCRATCH_DIR='/mnt/scratch'
  FILESYSTEM='btrfs'
  T_SIZE='5G'
  S_SIZE='8G'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
-------
 <12>[ 6457.571628] run fstests btrfs/232 at 2024-05-29 16:31:29

<6>[ 6464.685165] BTRFS: device fsid
50147eec-0761-4d75-8e77-df9c50ac385e devid 1 transid 6 /dev/loop1
(7:1) scanned by mount (152729)
<6>[ 6464.715051] BTRFS info (device loop1): first mount of filesystem
50147eec-0761-4d75-8e77-df9c50ac385e
<6>[ 6464.719266] BTRFS info (device loop1): using crc32c
(crc32c-generic) checksum algorithm
<6>[ 6464.724996] BTRFS info (device loop1): using free-space-tree
<6>[ 6464.789867] BTRFS info (device loop1): checking UUID tree
<6>[ 6499.694309] BTRFS info (device loop1): qgroup scan completed
(inconsistency flag cleared)
<6>[ 6499.766172] BTRFS info (device loop1): qgroup scan completed
(inconsistency flag cleared)
<1>[ 6572.421678] BUG: kernel NULL pointer dereference, address:
000000000000002c
<1>[ 6572.423036] #PF: supervisor read access in kernel mode
<1>[ 6572.423070] #PF: error_code(0x0000) - not-present page
<6>[ 6572.423143] PGD 0 P4D 0
<4>[ 6572.424555] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
<4>[ 6572.424814] CPU: 0 PID: 152772 Comm: fsstress Not tainted
6.10.0-rc1-next-20240529 #1
<4>[ 6572.424946] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
<4>[ 6572.425062] RIP: 0010:alloc_extent_buffer+0x253/0x820
<4>[ 6572.427387] Code: 00 49 8b 7d 08 4c 89 e9 40 f6 c7 01 0f 85 dc
03 00 00 0f 1f 44 00 00 4c 89 ef 48 8b 07 f6 c4 40 0f 84 f7 00 00 00
48 8b 57 28 <8b> 42 2c 85 c0 0f 84 ac 00 00 00 8d 70 01 f0 0f b1 72 2c
75 ee 48
<4>[ 6572.427577] RSP: 0018:ffffae9403eaf700 EFLAGS: 00000202
<4>[ 6572.427613] RAX: 010000000000412d RBX: ffff9eb00d8c5000 RCX:
ffffec4001110700
<4>[ 6572.427663] RDX: 0000000000000000 RSI: ffff9eaf3ad5b918 RDI:
ffffec4001110700
<4>[ 6572.427705] RBP: 000000000000dec8 R08: ffff9eaf3ad5b918 R09:
0000000000000001
<4>[ 6572.427730] R10: 0000000000000001 R11: 0000000000000001 R12:
ffff9eaf0c92b318
<4>[ 6572.427752] R13: ffffec4001110700 R14: 0000000000000000 R15:
ffff9eb00f1f82e8
<4>[ 6572.428675] FS:  00007f6ad5d8f740(0000)
GS:ffff9eb07bc00000(0000) knlGS:0000000000000000
<4>[ 6572.428756] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 6572.428772] CR2: 000000000000002c CR3: 00000001013ba000 CR4:
00000000000006f0
<4>[ 6572.428905] Call Trace:
<4>[ 6572.430288]  <TASK>
<4>[ 6572.430561]  ? __die+0x1e/0x60
<4>[ 6572.433138]  ? page_fault_oops+0x17b/0x4b0
<4>[ 6572.433156]  ? search_extable+0x26/0x30
<4>[ 6572.434025]  ? alloc_extent_buffer+0x253/0x820
<4>[ 6572.434035]  ? search_module_extables+0x14/0x50
<4>[ 6572.435608]  ? exc_page_fault+0x6b/0x150
<4>[ 6572.436133]  ? asm_exc_page_fault+0x26/0x30
<4>[ 6572.436889]  ? alloc_extent_buffer+0x253/0x820
<4>[ 6572.436917]  read_tree_block+0x1a/0x80
<4>[ 6572.438475]  read_block_for_search+0x211/0x320
<4>[ 6572.439418]  btrfs_search_slot+0x2db/0xe20
<4>[ 6572.439905]  ? kmem_cache_alloc_noprof+0x1cb/0x240
<4>[ 6572.439928]  find_parent_nodes+0xee/0x1f20
<4>[ 6572.441382]  btrfs_find_all_roots_safe+0x97/0x170
<4>[ 6572.441397]  btrfs_qgroup_trace_extent_post+0x70/0xf0
<4>[ 6572.441881]  add_delayed_ref+0x514/0x750
<4>[ 6572.442757]  btrfs_free_tree_block+0xcd/0x290
<4>[ 6572.442783]  btrfs_force_cow_block+0x329/0x7e0
<4>[ 6572.442800]  btrfs_cow_block+0xd7/0x280
<4>[ 6572.442814]  btrfs_search_slot+0x523/0xe20
<4>[ 6572.442832]  btrfs_insert_empty_items+0x35/0x70
<4>[ 6572.442845]  btrfs_insert_orphan_item+0x7a/0xb0
<4>[ 6572.443343]  btrfs_orphan_add+0x18/0xa0
<4>[ 6572.443863]  btrfs_unlink+0x166/0x180
<4>[ 6572.443887]  vfs_unlink+0x10d/0x2a0
<4>[ 6572.444369]  do_unlinkat+0x28c/0x310
<4>[ 6572.444390]  __x64_sys_unlink+0x3c/0x70
<4>[ 6572.444433]  do_syscall_64+0x9e/0x1a0
<4>[ 6572.444924]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
<4>[ 6572.447843] RIP: 0033:0x7f6ad5e8ba07
<4>[ 6572.448529] Code: f0 ff ff 73 01 c3 48 8b 0d f6 83 0d 00 f7 d8
64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 83 0d 00 f7 d8 64
89 01 48
<4>[ 6572.448541] RSP: 002b:00007ffd8a455818 EFLAGS: 00000202
ORIG_RAX: 0000000000000057
<4>[ 6572.448693] RAX: ffffffffffffffda RBX: 00000000000003ae RCX:
00007f6ad5e8ba07
<4>[ 6572.448723] RDX: 0000000000353166 RSI: 0000000000000000 RDI:
0000558cb0972bf0
<4>[ 6572.448735] RBP: 00007ffd8a455970 R08: 00007f6ad5f64c60 R09:
00007ffd8a45595c
<4>[ 6572.448744] R10: 00007ffd8a455586 R11: 0000000000000202 R12:
0000558c873925c0
<4>[ 6572.448750] R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15:
0000558c87388cc0
<4>[ 6572.448797]  </TASK>
<4>[ 6572.448863] Modules linked in:
<4>[ 6572.449908] CR2: 000000000000002c
<4>[ 6572.450833] ---[ end trace 0000000000000000 ]---
<4>[ 6572.485615] RIP: 0010:alloc_extent_buffer+0x253/0x820
<4>[ 6572.488121] Code: 00 49 8b 7d 08 4c 89 e9 40 f6 c7 01 0f 85 dc
03 00 00 0f 1f 44 00 00 4c 89 ef 48 8b 7 f6 c4 40 0f 84 f7 00 00 00 48
8b 57 28 <8b> 42 2c 85 c0 0f 84 ac 00 00 00 8d 70 01 f0 0f b1 72 2c 75
ee 48
<4>[ 6572.489657] RSP: 0018:ffffae9403eaf700 EFLAGS: 00000202
<4>[ 6572.490176] RAX: 010000000000412d RBX: ffff9eb00d8c5000 RCX:
ffffec4001110700
<4>[ 6572.490823] RDX: 0000000000000000 RSI: ffff9eaf3ad5b918 RDI:
ffffec4001110700
<4>[ 6572.491363] RBP: 000000000000dec8 R08: ffff9eaf3ad5b918 R09:
0000000000000001
<4>[ 6572.491951] R10: 0000000000000001 R11: 0000000000000001 R12:
ffff9eaf0c92b318
<4>[ 6572.492404] R13: ffffec4001110700 R14: 0000000000000000 R15:
ffff9eb00f1f82e8
<4>[ 6572.493249] FS:  00007f6ad5d8f740(0000)
GS:ffff9eb07bc00000(0000) knlGS:0000000000000000
<4>[ 6572.493710] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 6572.494410] CR2: 000000000000002c CR3: 00000001013ba000 CR4:
00000000000006f0

metadata:
----
  git_describe: next-20240529
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_short_log: 9d99040b1bc8 ("Add linux-next specific files for 20240529")

Steps to reproduce:
-------
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2h94944uxKleGblX7rjXwtV0PBv/reproducer

Links:
-----
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240529/testrun/24131454/suite/log-parser-test/test/check-kernel-bug/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240529/testrun/24131454/suite/log-parser-test/tests/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2h945RbifdV6peYDNNBeBffjQtu/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2h94944uxKleGblX7rjXwtV0PBv

--
Linaro LKFT
https://lkft.linaro.org

