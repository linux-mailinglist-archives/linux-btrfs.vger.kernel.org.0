Return-Path: <linux-btrfs+bounces-21219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELAmIzJKe2kdDQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21219-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 12:53:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD27AFD29
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 12:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F1ED303A6EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 11:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EF037C0F7;
	Thu, 29 Jan 2026 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWZsIZoV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53081377543
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769687566; cv=none; b=fEW8756zLLtP/CAeggCPJCSH6YjaHJ4cX76jiS/oPcfPdG/4D1tiiIKgXkhcEbXdcVjabXnYkXqTuwZU7+r3dBourJ2oFi6y321Yy8cOIGKSQnieInPHF2SJIGyN7VYiAuB9Q0yOQQlb24BaIxdjAuiwaWVgYRXApMIhoaw7fq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769687566; c=relaxed/simple;
	bh=2qRL+8NlflAtolBmQKWccJdDbW9l8PfZNLP45mSYNIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuG8KPWxeaMnkva9+Ok9Tcmrs2RNsZh5s+H5lypEjohZKFEvXZfiFjTTbt/MQcmoZN7UdnMaTqzH34m1qMfC1QXaHV/OtZ4Ylf8edJ4sB+H0PxpkcwcH+E0tqnODX2e4u7mygxH/o8mfcwIVpwgW8VG/jqkYxb45w47Zgaootuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWZsIZoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD88BC116D0
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769687565;
	bh=2qRL+8NlflAtolBmQKWccJdDbW9l8PfZNLP45mSYNIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fWZsIZoVEAKhFv4nCJqhFryxphKyoe8cDcdlFICdf+cGUmDc4y1u6+VzcgcxC2ytS
	 ecc30i+QmWFdtNl2BrqOvpgQCcdVjUYsrdnM6OPB8cQmLOem5vL4j4W3Mm97lVRg7t
	 P9BT9WC5HWxbu4qhfNGL2IA/eom2PxTDSvqc+J2HTOSKOcWoa7jUzqvvTBpoAmQeso
	 HDhuoxbFL27GTg9Cm5g/wpj+t9XlPgF7JfFf3Z62yXpXQpcreFRYaC+zrh30QI6lKc
	 6SgPjCgiTcQP18HASuWQDDZs64OBzxddogB7EbxHyaJ67LoeXaRGT0P4SoWk6kT0hN
	 D6uUOXSRFM7uw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-658cc45847cso1130001a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 03:52:45 -0800 (PST)
X-Gm-Message-State: AOJu0YzfiP+YGHoE5WWe0zGtAhhn27dhW0wnO5djcSjj0Z01ExofeywZ
	6X7XW2W5BE4eaTLtLhTp/HqVaTsCZ5P31LSX5XfPHyo965/cyy4R/MGVszcnkjIaKp8XT9mHVll
	pxOkWJqMT7l54EO2TMGE8JICzUkR7A3M=
X-Received: by 2002:a17:907:1c0b:b0:b88:4e52:bfb6 with SMTP id
 a640c23a62f3a-b8dab3ab541mr635387566b.56.1769687564189; Thu, 29 Jan 2026
 03:52:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ba53d279b8bb3456f61cb8a4f15d9a4b1e618d0e.1769546089.git.loemra.dev@gmail.com>
In-Reply-To: <ba53d279b8bb3456f61cb8a4f15d9a4b1e618d0e.1769546089.git.loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 29 Jan 2026 11:52:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6P_jJL98Z+ZC6agmcXq1DbK7XXJDGG5WpzrCZtzNsfUg@mail.gmail.com>
X-Gm-Features: AZwV_Qh_-VzEnjkRvzAkwN1_YhU4NXQqjIOgQuRGqso818COwIwkb06mFHhIPNI
Message-ID: <CAL3q7H6P_jJL98Z+ZC6agmcXq1DbK7XXJDGG5WpzrCZtzNsfUg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21219-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FD27AFD29
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 8:43=E2=80=AFPM Leo Martins <loemra.dev@gmail.com> =
wrote:
>
> I've been investigating enospcs at Meta and have observed a strange
> pattern where filesystems are enospcing with lots of unallocated space
> (> 100G). Sample dmesg dump at bottom of message.
>
> btrfs_insert_delayed_dir_index is attempting to migrate some reservation
> from the transaction block reserve and finding it exhausted leading to a
> warning and enospc. This is a bug as the reservations are meant to be
> worst case. It should be impossible to exhaust the transaction block
> reserve.
>
> Some tracing of affected hosts revealed that there were single
> btrfs_search_slot calls that were COWing 100s of times. I was able to
> reproduce this behavior locally by creating a very constrained cgroup
> and producing a lot of concurrent filesystem operations. Here's the
> pattern:
>
>  1. btrfs_search_slot() begins tree traversal with cow=3D1
>  2. Node at level N needs COW (old generation or WRITTEN flag set)
>  3. btrfs_cow_block() allocates new node, updates parent pointer
>  4. Traversal continues, but hits a condition requiring restart (e.g., no=
de
>     not cached, lock contention, need higher write_lock_level)
>  5. btrfs_release_path() releases all locks and references
>  6. Memory pressure triggers writeback on the COW'd node
>  7. lock_extent_buffer_for_io() clears EXTENT_BUFFER_DIRTY and sets
>     BTRFS_HEADER_FLAG_WRITTEN
>  8. goto again - traversal restarts from root
>  9. Traversal reaches the freshly COW'd node
>  10. should_cow_block() sees WRITTEN flag set, returns true
>  11. btrfs_cow_block() allocates another new node - same logical position=
,
>      new physical location, new reservation consumed
>  12. Steps 4-11 repeat indefinitely under sustained memory pressure
>
> Note this behavior should be much harder to trigger since Boris's
> AS_KERNEL_FILE changes that make it so that extent_buffer pages aren't
> accounted for in user cgroups. However, I believe it
> would still be an issue under global memory pressure.
> Link: https://lore.kernel.org/linux-btrfs/cover.1755812945.git.boris@bur.=
io/
>
> This COW amplification breaks the idea that transaction reservations are
> worst case as any search slot call could find itself in this COW loop and
> exhaust its reservation.
>
> My proposed solution is to temporarily pin extent buffers for the
> lifetime of btrfs_search_slot. This prevents the massive COW
> amplification that can be seen during high memory pressure.
>
> The implementation uses a local xarray to track COW'd buffers for the
> duration of the search. The xarray stores extent_buffer pointers without
> taking additional references; this is safe because tracked buffers remain
> dirty (writeback_blockers prevents the dirty bit from being cleared) and
> dirty buffers cannot be reclaimed by memory pressure.
>
> Synchronization is provided by eb->lock: increments in
> btrfs_search_slot_track_cow() occur while holding the write lock, and
> the check in lock_extent_buffer_for_io() also holds the write lock via
> btrfs_tree_lock(). Decrements don't require eb->lock because
> writeback_blockers is atomic and merely indicates "don't write yet".
> Once we decrement, we're done and don't care if writeback proceeds
> immediately.

This seems too complex to me.

So this problem is very similar to some idea I had a few years ago but
never managed to implement.
It was about avoiding unnecessary COW, not for this space reservation
exhaustion due to sustained memory pressure, but it would solve it
too.

The idea was that we do unnecessary COW in cases like this:

1) We COW a path in some tree and we are at transaction N;

2) Writeback happened for the extent buffers in that path while we are
in the same transaction, because we reached the 32M limit and some
task called btrfs_btree_balance_dirty() or something else triggered
writeback of the btree inode;

3) While still at transaction N, we visit the same path to add an item
to a leaf, or modify an item, whatever. Because the extent buffers
have BTRFS_HEADER_FLAG_WRITTEN, we COW them again (should_cow_block()
returns true).

So during the lifetime of a transaction we can have a lot of
unnecessary COW - we spend more time allocating extents, allocating
memory, copying extent buffer data, use more space per transaction,
etc.

The idea was to not COW when an extent buffer has
BTRFS_HEADER_FLAG_WRITTEN set, but only if its generation
(btrfs_header_generation(eb)) matches the current transaction.
That is safe because there's no committed tree that points to an
extent buffer created in the current transaction.

Any further modification to the extent buffer must be sure that the
EXTENT_BUFFER_DIRTY flag is set, that the eb range is still in the
transaction's dirty_pages io tree, etc, so that we don't miss writing
the extent buffer to the same location again before the transaction
commits the superblocks.

Have you considered an approach like this?

It would solve this space reservation exhaustion problem, as well as
unnecessary COW for general optimization, without the need to for a
local xarray, which besides being very specific for the
btrfs_search_slot() case (we COW in other places), also requires a
memory allocation which can fail.

Thanks.


>
> Here is pahole output of extent_buffer showing that the new atomic_t
> member can slot into an existing 6 byte hole.
>
> Before:
> struct extent_buffer {
>         u64                        start;                /*     0     8 *=
/
>         u32                        len;                  /*     8     4 *=
/
>         u32                        folio_size;           /*    12     4 *=
/
>         unsigned long              bflags;               /*    16     8 *=
/
>         struct btrfs_fs_info *     fs_info;              /*    24     8 *=
/
>         void *                     addr;                 /*    32     8 *=
/
>         spinlock_t                 refs_lock;            /*    40     0 *=
/
>         refcount_t                 refs;                 /*    40     4 *=
/
>         int                        read_mirror;          /*    44     4 *=
/
>         s8                         log_index;            /*    48     1 *=
/
>         u8                         folio_shift;          /*    49     1 *=
/
>
>         /* XXX 6 bytes hole, try to pack */
>
>         struct callback_head       callback_head __attribute__((__aligned=
__(8))); /*    56    16 */
>         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>         struct rw_semaphore        lock;                 /*    72    32 *=
/
>         struct folio *             folios[16];           /*   104   128 *=
/
>
>         /* size: 232, cachelines: 4, members: 14 */
>         /* sum members: 226, holes: 1, sum holes: 6 */
>         /* forced alignments: 1, forced holes: 1, sum forced holes: 6 */
>         /* last cacheline: 40 bytes */
> };
>
> After:
> struct extent_buffer {
>         u64                        start;                /*     0     8 *=
/
>         u32                        len;                  /*     8     4 *=
/
>         u32                        folio_size;           /*    12     4 *=
/
>         unsigned long              bflags;               /*    16     8 *=
/
>         struct btrfs_fs_info *     fs_info;              /*    24     8 *=
/
>         void *                     addr;                 /*    32     8 *=
/
>         spinlock_t                 refs_lock;            /*    40     0 *=
/
>         refcount_t                 refs;                 /*    40     4 *=
/
>         int                        read_mirror;          /*    44     4 *=
/
>         s8                         log_index;            /*    48     1 *=
/
>         u8                         folio_shift;          /*    49     1 *=
/
>
>         /* XXX 2 bytes hole, try to pack */
>
>         atomic_t                   writeback_blockers;   /*    52     4 *=
/
>         struct callback_head       callback_head __attribute__((__aligned=
__(8))); /*    56    16 */
>         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>         struct rw_semaphore        lock;                 /*    72    32 *=
/
>         struct folio *             folios[16];           /*   104   128 *=
/
>
>         /* size: 232, cachelines: 4, members: 15 */
>         /* sum members: 230, holes: 1, sum holes: 2 */
>         /* forced alignments: 1 */
>         /* last cacheline: 40 bytes */
> };
>
> ------------[ cut here ]------------
> WARNING: CPU: 28 PID: 930807 at fs/btrfs/delayed-inode.c:1547 btrfs_inser=
t_delayed_dir_index+0x346/0x3a0
> Modules linked in: ip_tables(E) ip6_tables(E) vhost_net(E) tun(E) vhost(E=
) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) =
bpf_preload(E) act_gact(E) cls_bpf(E) tcp_diag(E) inet_diag(E) sch_fq(E) tl=
s(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E)=
 skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powe=
rclamp(E) coretemp(E) iTCO_wdt(E) kvm_intel(E) mlx5_ib(E) iTCO_vendor_suppo=
rt(E) xhci_pci(E) mlx5_fwctl(E) i2c_i801(E) kvm(E) xhci_hcd(E) ib_uverbs(E)=
 acpi_cpufreq(E) fwctl(E) i2c_smbus(E) wmi(E) ipmi_si(E) ipmi_devintf(E) ev=
dev(E) ipmi_msghandler(E) button(E) sch_fq_codel(E) loop(E) drm(E) backligh=
t(E) drm_panel_orientation_quirks(E) autofs4(E) raid0(E) efivarfs(E) dm_cry=
pt(E)
> CPU: 28 UID: 34126 PID: 930807 Comm: CPUThreadPool0 Kdump: loaded Tainted=
: G S          E       6.13.2-0_fbk9_0_gb487e362c3df #1
> Tainted: [S]=3DCPU_OUT_OF_SPEC, [E]=3DUNSIGNED_MODULE
> Hardware name: Wiwynn Delta Lake MP/Delta Lake-Class1, BIOS Y3DL403 06/20=
/2025
> RIP: 0010:btrfs_insert_delayed_dir_index+0x346/0x3a0
> Code: 08 48 89 de 48 c7 c2 e8 09 61 82 4d 89 e0 45 31 c9 e8 2e da 73 ff 4=
8 89 df 48 8b 6c 24 08 4c 8b 74 24 10 e9 57 fe ff ff 89 c3 <0f> 0b 4c 89 e7=
 e8 b0 fb ff ff e9 5a fe ff ff 65 8b 05 50 d9 2b 7e
> RSP: 0000:ffffc900047b79f8 EFLAGS: 00010286
> RAX: 00000000ffffffe4 RBX: 00000000ffffffe4 RCX: 0000000000000000
> RDX: fffffffffffc0000 RSI: ffff8882aaeb7170 RDI: ffff8882aaeb7128
> RBP: ffff888348114d68 R08: 000000006f684265 R09: 5f79636e6574616c
> R10: 5f726f74696e6f6d R11: 617461646174656d R12: ffff8882d49c4180
> R13: ffff8882aaeb7000 R14: 0000000000000045 R15: 0000000000040000
> FS:  00007fb5563fd640(0000) GS:ffff889036600000(0000) knlGS:0000000000000=
000
> CR2: 000000000ba8bffd CR3: 0000000906d1b002 CR4: 00000000007726f0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __warn+0xa4/0x140
>  ? btrfs_insert_delayed_dir_index+0x346/0x3a0
>  ? report_bug+0xe1/0x140
>  ? handle_bug+0x5e/0x90
>  ? exc_invalid_op+0x16/0x40
>  ? asm_exc_invalid_op+0x16/0x20
>  ? btrfs_insert_delayed_dir_index+0x346/0x3a0
>  ? btrfs_insert_delayed_dir_index+0x20c/0x3a0
>  btrfs_insert_dir_item+0x1b0/0x210
>  ? setup_items_for_insert+0x250/0x480
>  btrfs_add_link+0x94/0x3e0
>  btrfs_create_new_inode+0x60a/0xb90
>  ? start_transaction.llvm.5573957049853623343+0x2e4/0x7a0
>  btrfs_create_common+0x16c/0x1f0
>  path_openat+0x20ff/0x4140
>  do_filp_open+0xa2/0x130
>  ? _raw_spin_lock+0x10/0x20
>  __x64_sys_openat+0x114/0x1b0
>  do_syscall_64+0x68/0x130
>  ? exc_page_fault+0x69/0x130
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fb55a51b592
> Code: 8b 55 d0 eb b0 0f 1f 00 44 89 55 9c e8 b7 b6 f7 ff 41 89 c0 44 8b 5=
5 9c 44 89 e2 4c 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 46 44 89 c7 89 45 9c e8 eb b6 f7 ff 8b 45 9c
> RSP: 002b:00007fb5563f70a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: f49998db0aa753ff RCX: 00007fb55a51b592
> RDX: 00000000000000c2 RSI: 00007fb557509cc0 RDI: 00000000ffffff9c
> RBP: 00007fb5563f7110 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
> R13: 00007fb557509cc0 R14: 000000000f595b0b R15: 00007fb55a5e0ca0
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -28)
> WARNING: CPU: 28 PID: 930807 at fs/btrfs/inode.c:6606 btrfs_add_link+0x3a=
e/0x3e0
> Modules linked in: ip_tables(E) ip6_tables(E) vhost_net(E) tun(E) vhost(E=
) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) =
bpf_preload(E) act_gact(E) cls_bpf(E) tcp_diag(E) inet_diag(E) sch_fq(E) tl=
s(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E)=
 skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powe=
rclamp(E) coretemp(E) iTCO_wdt(E) kvm_intel(E) mlx5_ib(E) iTCO_vendor_suppo=
rt(E) xhci_pci(E) mlx5_fwctl(E) i2c_i801(E) kvm(E) xhci_hcd(E) ib_uverbs(E)=
 acpi_cpufreq(E) fwctl(E) i2c_smbus(E) wmi(E) ipmi_si(E) ipmi_devintf(E) ev=
dev(E) ipmi_msghandler(E) button(E) sch_fq_codel(E) loop(E) drm(E) backligh=
t(E) drm_panel_orientation_quirks(E) autofs4(E) raid0(E) efivarfs(E) dm_cry=
pt(E)
> CPU: 28 UID: 34126 PID: 930807 Comm: CPUThreadPool0 Kdump: loaded Tainted=
: G S      W   E       6.13.2-0_fbk9_0_gb487e362c3df #1
> Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN, [E]=3DUNSIGNED_MODULE
> Hardware name: Wiwynn Delta Lake MP/Delta Lake-Class1, BIOS Y3DL403 06/20=
/2025
> RIP: 0010:btrfs_add_link+0x3ae/0x3e0
> Code: 00 e9 75 ff ff ff 48 c7 c7 9b 10 6a 82 89 de e8 28 c1 36 ff 0f 0b e=
9 81 fe ff ff 48 c7 c7 9b 10 6a 82 44 89 e6 e8 12 c1 36 ff <0f> 0b e9 cf fe=
 ff ff 48 c7 c7 9b 10 6a 82 89 de e8 fd c0 36 ff 0f
> RSP: 0000:ffffc900047b7b00 EFLAGS: 00010282
> RAX: 0000000000000026 RBX: 00000000000acc00 RCX: 0000000000000000
> RDX: ffff889036630158 RSI: ffff889036621c60 RDI: ffff889036621c60
> RBP: 00000000001569d0 R08: ffffffff832692a0 R09: 000000000002fffd
> R10: 0000000000000000 R11: ffffffffffffffff R12: 00000000ffffffe4
> R13: 0000000000000000 R14: ffff8882a6707400 R15: ffffc900047b7ca8
> FS:  00007fb5563fd640(0000) GS:ffff889036600000(0000) knlGS:0000000000000=
000
> CR2: 000000000ba8bffd CR3: 0000000906d1b002 CR4: 00000000007726f0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __warn+0xa4/0x140
>  ? btrfs_add_link+0x3ae/0x3e0
>  ? report_bug+0xe1/0x140
>  ? btrfs_add_link+0x3ae/0x3e0
>  ? handle_bug+0x5e/0x90
>  ? exc_invalid_op+0x16/0x40
>  ? asm_exc_invalid_op+0x16/0x20
>  ? btrfs_add_link+0x3ae/0x3e0
>  btrfs_create_new_inode+0x60a/0xb90
>  ? start_transaction.llvm.5573957049853623343+0x2e4/0x7a0
>  btrfs_create_common+0x16c/0x1f0
>  path_openat+0x20ff/0x4140
>  do_filp_open+0xa2/0x130
>  ? _raw_spin_lock+0x10/0x20
>  __x64_sys_openat+0x114/0x1b0
>  do_syscall_64+0x68/0x130
>  ? exc_page_fault+0x69/0x130
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fb55a51b592
> Code: 8b 55 d0 eb b0 0f 1f 00 44 89 55 9c e8 b7 b6 f7 ff 41 89 c0 44 8b 5=
5 9c 44 89 e2 4c 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 46 44 89 c7 89 45 9c e8 eb b6 f7 ff 8b 45 9c
> RSP: 002b:00007fb5563f70a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: f49998db0aa753ff RCX: 00007fb55a51b592
> RDX: 00000000000000c2 RSI: 00007fb557509cc0 RDI: 00000000ffffff9c
> RBP: 00007fb5563f7110 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
> R13: 00007fb557509cc0 R14: 000000000f595b0b R15: 00007fb55a5e0ca0
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> BTRFS info (device nvme0n1p2 state A): dumping space info:
> BTRFS info (device nvme0n1p2 state A): space_info DATA has 11715895296 fr=
ee, is not full
> BTRFS info (device nvme0n1p2 state A): space_info total=3D92350185472, us=
ed=3D80633892864, pinned=3D0, reserved=3D241664, may_use=3D155648, readonly=
=3D0 zone_unusable=3D0 delalloc=3D151552 ordered=3D8192
> BTRFS info (device nvme0n1p2 state A): space_info METADATA has 880836608 =
free, is not full
> BTRFS info (device nvme0n1p2 state A): space_info total=3D2181038080, use=
d=3D912293888, pinned=3D3784704, reserved=3D557056, may_use=3D383500288, re=
adonly=3D65536 zone_unusable=3D0 delalloc=3D151552 ordered=3D8192
> BTRFS info (device nvme0n1p2 state A): space_info SYSTEM has 8372224 free=
, is not full
> BTRFS info (device nvme0n1p2 state A): space_info total=3D8388608, used=
=3D16384, pinned=3D0, reserved=3D0, may_use=3D0, readonly=3D0 zone_unusable=
=3D0 delalloc=3D151552 ordered=3D8192
> BTRFS info (device nvme0n1p2 state A): global_block_rsv: size 306905088 r=
eserved 306905088
> BTRFS info (device nvme0n1p2 state A): trans_block_rsv: size 1310720 rese=
rved 0
> BTRFS info (device nvme0n1p2 state A): chunk_block_rsv: size 0 reserved 0
> BTRFS info (device nvme0n1p2 state A): delayed_block_rsv: size 4980736 re=
served 4980736
> BTRFS info (device nvme0n1p2 state A): delayed_refs_rsv: size 47841280 re=
served 46858240
> BTRFS: error (device nvme0n1p2 state A) in btrfs_add_link:6606: errno=3D-=
28 No space left
> BTRFS info (device nvme0n1p2 state EA): forced readonly
>
>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/ctree.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/extent_io.c |  4 +++-
>  fs/btrfs/extent_io.h |  8 ++++++++
>  3 files changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 7267b2502665..473e78f398b4 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1972,6 +1972,40 @@ static int search_leaf(struct btrfs_trans_handle *=
trans,
>         return ret;
>  }
>
> +/*
> + * Track an extent buffer that was COW'd during btrfs_search_slot.
> + * Prevents the flusher from writing this buffer until the search comple=
tes.
> + * This avoids COW amplification where a restart would force an unnecess=
ary
> + * re-COW of the same block.
> + */
> +static inline int btrfs_search_slot_track_cow(struct xarray *cowed_buffe=
rs,
> +                                              struct extent_buffer *eb)
> +{
> +       u32 tmp;
> +       int ret =3D 0;
> +
> +       lockdep_assert_held_write(&eb->lock);
> +
> +       ret =3D xa_alloc(cowed_buffers, &tmp, eb, xa_limit_32b, GFP_NOFS)=
;
> +       if (!ret)
> +               atomic_inc(&eb->writeback_blockers);
> +       return ret;
> +}
> +
> +/*
> + * Clear COW protection from all extent buffers tracked during this sear=
ch.
> + * Called at the end of btrfs_search_slot to allow normal writeback beha=
vior.
> + */
> +static inline void btrfs_search_slot_clear_cow_protection(struct xarray =
*cowed_buffers)
> +{
> +       struct extent_buffer *eb;
> +       unsigned long index;
> +
> +       xa_for_each(cowed_buffers, index, eb)
> +               atomic_dec(&eb->writeback_blockers);
> +       xa_destroy(cowed_buffers);
> +}
> +
>  /*
>   * Look for a key in a tree and perform necessary modifications to prese=
rve
>   * tree invariants.
> @@ -2009,6 +2043,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>  {
>         struct btrfs_fs_info *fs_info;
>         struct extent_buffer *b;
> +       DEFINE_XARRAY_ALLOC(cowed_buffers);
>         int slot;
>         int ret;
>         int level;
> @@ -2121,6 +2156,11 @@ int btrfs_search_slot(struct btrfs_trans_handle *t=
rans, struct btrfs_root *root,
>                                 ret =3D ret2;
>                                 goto done;
>                         }
> +                       ret2 =3D btrfs_search_slot_track_cow(&cowed_buffe=
rs, b);
> +                       if (ret2) {
> +                               ret =3D ret2;
> +                               goto done;
> +                       }
>                 }
>  cow_done:
>                 p->nodes[level] =3D b;
> @@ -2242,6 +2282,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>                         ret =3D ret2;
>         }
>
> +       btrfs_search_slot_clear_cow_protection(&cowed_buffers);
> +
>         return ret;
>  }
>  ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index dfc17c292217..5dd7fcaec5a5 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1940,7 +1940,8 @@ static noinline_for_stack bool lock_extent_buffer_f=
or_io(struct extent_buffer *e
>          * of time.
>          */
>         spin_lock(&eb->refs_lock);
> -       if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> +       if (!atomic_read(&eb->writeback_blockers) &&
> +           test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
>                 XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info=
->nodesize_bits);
>                 unsigned long flags;
>
> @@ -3009,6 +3010,7 @@ static struct extent_buffer *__alloc_extent_buffer(=
struct btrfs_fs_info *fs_info
>         eb->len =3D fs_info->nodesize;
>         eb->fs_info =3D fs_info;
>         init_rwsem(&eb->lock);
> +       atomic_set(&eb->writeback_blockers, 0);
>
>         btrfs_leak_debug_add_eb(eb);
>
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 73571d5d3d5a..da77c4eb9a43 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -102,6 +102,14 @@ struct extent_buffer {
>         /* >=3D 0 if eb belongs to a log tree, -1 otherwise */
>         s8 log_index;
>         u8 folio_shift;
> +
> +       /*
> +        * Active btrfs_search_slot() operations blocking writeback.
> +        * Prevents COW amplification when searches restart under memory
> +        * pressure. Checked under eb->lock in lock_extent_buffer_for_io(=
).
> +        */
> +       atomic_t writeback_blockers;
> +
>         struct rcu_head rcu_head;
>
>         struct rw_semaphore lock;
> --
> 2.47.3
>
>

