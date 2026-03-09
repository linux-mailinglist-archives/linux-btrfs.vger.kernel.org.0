Return-Path: <linux-btrfs+bounces-22287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPp4B2ijrmmbHAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-22287-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 11:39:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 877F92373C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 11:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 696CE303501A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2026 10:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B6C3921CB;
	Mon,  9 Mar 2026 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBEG712f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F205937D13F
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Mar 2026 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052610; cv=none; b=NVRybEZziDLDTr87efT/T8Brzp8uIbpy82jZjAZUM3Ke4NKudCuOgrL/3jAFZRLB8iSzFmtW9br+QIU8wnsn+FbEjVprX4GMBeyy8Y0HwqWh7Et1I8Eqf5rmjJCX8yVO8qcS85osfFA946EjRGVsWHHpb6x1MYSnus9m//Ig/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052610; c=relaxed/simple;
	bh=4nj5Md+bH/7O6KXxrnkTKVE1FOcPcbm3kVld80GmTi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HI8GrbOE+oMH/TBI4kY5xJ52pgZykq3X7sCTmcwHOz7vbh+OWLPeJAnrdamErMKkQXbGeBz6cm4qsAPp25Ab3geHQkzWuyglkEYA7AzUhXWpiwEHZ8XkgR2u/5/q0bPbffBJHWZaegdjLXZR925+Pw9UHGsWMYzToUTmtvKo7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBEG712f; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c73ba417c6eso206991a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2026 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773052607; x=1773657407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3FQLEzus73hEHckeZ2hSuCSlybXmlMdL0gTM45TGOIc=;
        b=lBEG712fUmnvyMCUnrrt8jWlOjWDX4cSg8VDqxXxKgTPZuK+f1Fadl4HZVI/M3BNyO
         JrmjYbO0PiQ5RIInKykbjHi+Ho55/8QB2uc+DWy+O1Q4kFk0+ALTvrk+pbGb7R0Hk89J
         O3nraS4bpyy9JNOxeOMHDPlEiyeTRTjNmqNQcVqMF0Hlr3XuppDnj4n/a5lBiH5CrIbS
         eZwLari13pllsIVdX6Np3tRiM5fLAWr24T4T/z0q85oFM36221L/faXiAlquu8WmpmTK
         qAe6tNwa/OFvfkcgO7vwrG+aeG/Llyh2TSQFOZA+k2H5jiDhoWwn2Rw8H6S7P+Vg2wn6
         bb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052607; x=1773657407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FQLEzus73hEHckeZ2hSuCSlybXmlMdL0gTM45TGOIc=;
        b=ZO4G/RCXZt3OFbLbz+8A/uYPZPO3Qf9jMd7ZPEqaCC4kQPwbz3Z34nj62bJmVBrdKc
         HnbNjb1x4//+WdHxeJASg3y0L021gqv5GfSAJ/lQ8naEXFHWn8T3A1FGkHsV/nn8/1DZ
         I4LFK2y6i27xvN2bsbWKvCXHNxVEKeu4Q7Z4ekdA8zeX5xc40z6bYHOhL0sD4d0e/jkn
         Vu7ZlsV9h0pxncY9crOK27dOcl+djWagPgq62tnZkYYFZhKFjl40bCF47BZn2Az2QHaM
         y6d2ALiL8PAtOEKXChMPojiy65iG3SCDHUQxOmLGSO87AuUNpx4vyyrsFN1bhfWKWr5m
         6sAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOM4vWa3dnGygITwh4wFGDGumN2hCiv2zSYRySd6xCTMP//y3OVkFZ0dg/CxI1RYwy+wsE5f1EpB/lwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiI0wA7ii5EiwG3WmBKebhiSvRN11kU/u/7DY6vR7FkuPBNiTq
	fpUmji+w3xRIWxtSMXb/MqV5LKMWGOKEA5HdMuRPAQvrKrPsjtmBUUuu
X-Gm-Gg: ATEYQzyhB3tU9VZFoUiLX7XU5EzX1By8FfnNtcAsu5vUyAE7UApIOaQwaf5c+3Ddgd4
	9FGOM3R04UILuL6iMtJ3IiSdkmiOVzcGdCH1Ac+P+N96mOge7csyWzQfwbyq8NvHSAYrkAUxiXr
	6lw0IFosBPPJydWQe+SRfNv5IVaBr2TbxpwIzlE7Ev/vvOuiaOfnFtCu0SHRpOjVSg+1p7owOCY
	z+s1VP6EgdCodqNr1yBpTX49e/Y0ac4jHCbaledI1re++TwpC2ZEEPn9pQLuKFELt2G0kCWjyIg
	1lYTXzuHSsCVbiCLKIpOXy0ZpUMAUJ7JDu+Ngw7oVd5cW3NRW/Qzn/A4NspFGDC54yIqb61u9bU
	prkZqEfjEpCeDRaAt0P4HlNUG+KQNR/notnaikaBdwV+9s6HcL+F7OFs1GqyEzlnizWR7VM/RlM
	4nXNfMq8DVkDtagBIQhiReL85MOyJ3+XHfC+k3Bt5KuDa8lk0gxI45zcjzd7FKp50Dm1zJkg==
X-Received: by 2002:a17:903:19ce:b0:2ad:e975:4735 with SMTP id d9443c01a7336-2ae8239798emr100153435ad.20.1773052607096;
        Mon, 09 Mar 2026 03:36:47 -0700 (PDT)
Received: from kernel-fuzz.. ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57b14sm145078525ad.19.2026.03.09.03.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 03:36:46 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: dsterba@suse.com,
	clm@fb.com
Cc: osandov@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: validate free space bitmap size before testing bits
Date: Mon,  9 Mar 2026 18:36:38 +0800
Message-ID: <20260309103638.1500791-1-gality369@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 877F92373C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-22287-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

A corrupt free-space-tree leaf can contain a FREE_SPACE_BITMAP item
whose on-disk item size does not match the bitmap size implied by
key.offset.

The free-space-tree loading path currently uses key.offset to iterate
bitmap coverage, but does not verify that the item size matches
free_space_bitmap_size(fs_info, key.offset). This allows a zero-sized
or otherwise truncated bitmap item to be consumed as if it contained
valid bitmap data.

Once bit access runs past the valid extent buffer range, the computed
folio index can reach an unpopulated eb->folios[] slot and trigger a
NULL dereference in assert_eb_folio_uptodate().

Fix this by validating FREE_SPACE_BITMAP item sizes in
load_free_space_bitmaps() before testing any bits. If the on-disk item
size does not match the expected bitmap size, treat the free-space-tree
leaf as corrupt and fail loading it with -EUCLEAN.

Also add a defensive range check in extent_buffer_test_bit() so that
corrupt metadata cannot drive bitmap bit access beyond the extent
buffer even if a bad caller reaches that helper.

The bug is reproducible on 7.0.0-rc2-next-20260306 with a dynamic
metadata fuzzing tool that injects single-bit corruptions into btrfs
leaf blocks at runtime. After this change, the corrupt bitmap item is
rejected and the filesystem reports corruption instead of crashing.

Fixes: a5ed91828518 ("Btrfs: implement the free space B-tree")
Cc: stable@vger.kernel.org # 4.5+
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
Root cause
==========
The direct fault is a NULL dereference in assert_eb_folio_uptodate(),
reached from the free-space-tree bitmap loading path:

  caching_thread()
    -> btrfs_load_free_space_tree()
    -> load_free_space_bitmaps()
    -> btrfs_free_space_test_bit()
    -> extent_buffer_test_bit()
    -> assert_eb_folio_uptodate()

The corrupted metadata pattern is a FREE_SPACE_BITMAP item whose
item_size is smaller than the bitmap size described by key.offset. In the
reproducer, multiple bitmap items had item_size == 0 while key.offset
still described non-empty bitmap ranges.

For one failing item, the instrumented run showed:

  leaf_len = 16384
  ptr = 16312
  item_size = 0
  expected = 402
  key.type = BTRFS_FREE_SPACE_BITMAP_KEY

So only 72 bytes remained in the leaf data area, while the bitmap range
described by key.offset required 402 bytes of bitmap data. The existing
code did not validate that mismatch before iterating over bitmap bits.

btrfs_free_space_test_bit() uses btrfs_item_ptr_offset() as the bitmap
start, and extent_buffer_test_bit() then translates the bit access into
a folio index. Without a range check, once start + BIT_BYTE(nr) goes past
eb->len, the computed folio index can exceed the populated folio range of
the extent buffer.

extent_buffer objects are zero-initialized and only the first
num_extent_folios(eb) entries in eb->folios[] are populated. An access
past that range can therefore hit a NULL eb->folios[] slot, which is then
dereferenced by assert_eb_folio_uptodate() via folio_test_uptodate().

Reproduction (v6.18, x86_64, KASAN)
===================================
The PoC is relatively large, so it is provided separately through google drive:
https://drive.google.com/drive/folders/1eB6QzkGViZhlq8xouE5WSVRU0fovu0qw

To reproduce the issue:
  1. Build the PoC program: gcc poc.c -o poc
  2. Build the ublk helper program from the ublk codebase, which is
	 used to provide the runtime corruption capability:
	  g++ -std=c++20 -fcoroutines -O2 -o standalone_replay \
      standalone_replay_btrfs.cpp targets/ublksrv_tgt.cpp \
      -I. -Iinclude -Itargets/include \
      -L./lib/.libs -lublksrv -luring -lpthread
  3. Attach the crafted image through ublk:
      ./standalone_replay add -t loop -f /path/to/image
  4. Run the PoC: ./poc
This reliably reproduces the bug.

Test notes
==========
The reproducer was verified on 7.0.0-rc2-next-20260306 with runtime
single-bit corruption injected into btrfs leaf blocks. I have not yet
retested it on the latest stable kernel, but I can do so if needed.

Fix
===
Two complementary defences are added:

1. In load_free_space_bitmaps() (free-space-tree.c), validate that the
   on-disk item_size equals free_space_bitmap_size(fs_info, key.offset)
   before entering the per-sector bit-reading loop.  A mismatch is a
   clear sign of on-disk corruption; log a specific error message and
   return -EUCLEAN so the caller can handle it gracefully instead of
   walking off the end of the leaf.

2. In extent_buffer_test_bit() (extent_io.c), call check_eb_range()
   before eb_bitmap_offset(), mirroring the pattern already used by
   read_extent_buffer() and extent_buffer_get_byte().  This makes the
   function safe against any caller that passes an out-of-range (start,
   nr) pair, regardless of how the corruption reached this point.

Defence (1) catches the specific free-space-tree path at the semantic
layer and produces a meaningful log entry. Defence (2) is a generic
safety net for the low-level helper that prevents the NULL-folio crash
for any future caller that might bypass the upper-layer check.

KASAN reports
=============
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in folio_test_uptodate include/linux/page-flags.h:787 [inline]
BUG: KASAN: null-ptr-deref in assert_eb_folio_uptodate+0x198/0x2b0 fs/btrfs/extent_io.c:4071
Read of size 8 at addr 0000000000000000 by task kworker/u8:0/12

CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 6.18.0+ #12 PREEMPT(voluntary) 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: btrfs-cache btrfs_work_helper
Call Trace:
<TASK>
dump_stack_lvl+0xbe/0x130
print_report+0x437/0x650
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? early_section include/linux/mmzone.h:2184 [inline]
? pfn_valid include/linux/mmzone.h:2196 [inline]
? __virt_addr_valid+0xca/0x4c0 arch/x86/mm/physaddr.c:65
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? kasan_addr_to_slab+0xd/0xb0 mm/kasan/common.c:46
kasan_report+0xfb/0x140
? instrument_atomic_read include/linux/instrumented.h:68 [inline]
? _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
? folio_test_uptodate include/linux/page-flags.h:787 [inline]
? assert_eb_folio_uptodate+0x198/0x2b0 fs/btrfs/extent_io.c:4071
? instrument_atomic_read include/linux/instrumented.h:68 [inline]
? _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
? folio_test_uptodate include/linux/page-flags.h:787 [inline]
? assert_eb_folio_uptodate+0x198/0x2b0 fs/btrfs/extent_io.c:4071
kasan_check_range+0x11c/0x200
__kasan_check_read+0x11/0x20
assert_eb_folio_uptodate+0x198/0x2b0
extent_buffer_test_bit+0xce/0x200
btrfs_free_space_test_bit+0x1b3/0x270
? __pfx_btrfs_free_space_test_bit+0x10/0x10 include/linux/sched/mm.h:332
? __asan_memmove+0x30/0x80 mm/kasan/shadow.c:95
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? read_extent_buffer+0x114/0x3d0 fs/btrfs/extent_io.c:3946
btrfs_load_free_space_tree+0x57a/0xe40
? __pfx_btrfs_load_free_space_tree+0x10/0x10 fs/btrfs/free-space-tree.c:1492
? __entry_text_end+0x1025b9/0x1025bd
? __kasan_check_write+0x14/0x30 mm/kasan/shadow.c:37
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? instrument_atomic_write include/linux/instrumented.h:82 [inline]
? atomic_long_set include/linux/atomic/atomic-instrumented.h:3223 [inline]
? __rwsem_set_reader_owned kernel/locking/rwsem.c:177 [inline]
? rwsem_set_reader_owned kernel/locking/rwsem.c:182 [inline]
? rwsem_read_trylock kernel/locking/rwsem.c:257 [inline]
? rwsem_read_trylock kernel/locking/rwsem.c:249 [inline]
? __down_read_common kernel/locking/rwsem.c:1260 [inline]
? __down_read kernel/locking/rwsem.c:1274 [inline]
? down_read+0x1c5/0x4a0 kernel/locking/rwsem.c:1539
? hung_task_set_blocker include/linux/hung_task.h:55 [inline]
? rwsem_down_read_slowpath+0xbd0/0xca0 kernel/locking/rwsem.c:1070
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? trace_hardirqs_on+0x53/0x60 kernel/trace/trace_preemptirq.c:79
caching_thread+0x3d5/0x1f20
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? save_trace+0x54/0x390 kernel/locking/lockdep.c:587
? __pfx_caching_thread+0x10/0x10 fs/btrfs/block-group.c:533
? __entry_text_end+0x1025b9/0x1025bd
? instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
? atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1301 [inline]
? queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
? do_raw_spin_lock+0x133/0x290 kernel/locking/spinlock_debug.c:116
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? find_held_lock+0x31/0x90 kernel/locking/lockdep.c:5350
? spin_unlock include/linux/spinlock.h:391 [inline]
? thresh_exec_hook fs/btrfs/async-thread.c:203 [inline]
? btrfs_work_helper+0x1a2/0xa50 fs/btrfs/async-thread.c:311
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:562 [inline]
? queued_spin_unlock arch/x86/include/asm/qspinlock.h:57 [inline]
? do_raw_spin_unlock+0x14b/0x200 kernel/locking/spinlock_debug.c:142
btrfs_work_helper+0x1d4/0xa50
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
process_one_work+0x8e0/0x1980
? __pfx_process_one_work+0x10/0x10 include/linux/list.h:226
? move_linked_works+0x1a8/0x2c0 kernel/workqueue.c:1165
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? assign_work+0x19d/0x240 kernel/workqueue.c:1206
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? __lock_is_held kernel/locking/lockdep.c:5601 [inline]
? lock_is_held_type+0xa3/0x130 kernel/locking/lockdep.c:5940
worker_thread+0x683/0xf80
? __pfx_worker_thread+0x10/0x10 kernel/workqueue.c:3570
kthread+0x3f0/0x850
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? __pfx_kthread+0x10/0x10 arch/x86/include/asm/bitops.h:202
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? trace_hardirqs_on+0x53/0x60 kernel/trace/trace_preemptirq.c:79
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
? _raw_spin_unlock_irq+0x27/0x70 kernel/locking/spinlock.c:202
? srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
? spin_unlock_irq include/linux/spinlock.h:401 [inline]
? calculate_sigpending+0x7c/0xb0 kernel/signal.c:194
? __pfx_kthread+0x10/0x10 arch/x86/include/asm/bitops.h:202
ret_from_fork+0x50f/0x610
? __pfx_kthread+0x10/0x10 arch/x86/include/asm/bitops.h:202
ret_from_fork_asm+0x1a/0x30
</TASK>
---
 fs/btrfs/extent_io.c       | 10 ++++++++++
 fs/btrfs/free-space-tree.c | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 23273d0e6f22..14da72a9a950 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4254,6 +4254,16 @@ bool extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 	size_t offset;
 	u8 *kaddr;
 
+	/*
+	 * Defend against a corrupt bitmap item whose item_size is smaller
+	 * than what key.offset implies: if start + BIT_BYTE(nr) would fall
+	 * outside this extent buffer, eb_bitmap_offset() would compute an
+	 * out-of-bounds folio index, and assert_eb_folio_uptodate() would
+	 * then dereference a NULL eb->folios[] slot.
+	 */
+	if (check_eb_range(eb, start, BIT_BYTE(nr) + 1))
+		return false;
+
 	eb_bitmap_offset(eb, start, nr, &i, &offset);
 	assert_eb_folio_uptodate(eb, i);
 	kaddr = folio_address(eb->folios[i]);
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index d86541073d42..04fde74c35e5 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1555,6 +1555,8 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 	u64 end, offset;
 	u64 total_found = 0;
 	u32 extent_count = 0;
+	u32 expected_bitmap_size;
+	u32 actual_bitmap_size;
 	int ret;
 
 	block_group = caching_ctl->block_group;
@@ -1578,6 +1580,23 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 		ASSERT(key.type == BTRFS_FREE_SPACE_BITMAP_KEY);
 		ASSERT(key.objectid < end && key.objectid + key.offset <= end);
 
+		/*
+		 * Validate the on-disk item size matches what we compute
+		 * from key.offset.  A zero-sized (or otherwise wrong-sized)
+		 * bitmap item would cause extent_buffer_test_bit() to walk
+		 * past the end of the leaf, ultimately dereferencing a NULL
+		 * folio pointer in assert_eb_folio_uptodate().
+		 */
+		expected_bitmap_size = free_space_bitmap_size(fs_info, key.offset);
+		actual_bitmap_size = btrfs_item_size(path->nodes[0], path->slots[0]);
+		if (unlikely(actual_bitmap_size != expected_bitmap_size)) {
+			btrfs_err(fs_info,
+				  "corrupt free space bitmap for block group %llu: objectid=%llu expected item size %u got %u",
+				  block_group->start, key.objectid,
+				  expected_bitmap_size, actual_bitmap_size);
+			return -EUCLEAN;
+		}
+
 		offset = key.objectid;
 		while (offset < key.objectid + key.offset) {
 			bool bit_set;
-- 
2.43.0


