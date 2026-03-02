Return-Path: <linux-btrfs+bounces-22147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIaaE2SPpWmoDgYAu9opvQ
	(envelope-from <linux-btrfs+bounces-22147-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 14:23:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E92E01D9B01
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 14:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D27D30066A0
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16E73E5577;
	Mon,  2 Mar 2026 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLl8Jwbh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5EE3876C5
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457819; cv=none; b=fPUFrmQS7nwsA6kfvBsIi6ET6CtFIOjpazpekjr0qxXfidbJrqY/UMspPzbS5czovMvCRgByD8eVL1IDYRoil7LkFst2hUiDpCqYa49j10GhZktGKdCURMxdny7U3a7U8dPGwVv37imA0jsxVkiYACVuE1T54KX+oDZSZCUBNSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457819; c=relaxed/simple;
	bh=i6kS87qUnZ6mbCIR/lWF042B2JkLiPFC6Xd85F77Ur8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xo+CdEiZxeM1X+OMasMLPQ1ib0nV1+VL7ejcyh1wc+bdD5dOKaNuiMoN95RUVGazW5P+2WxdoobsicrtVyibEQgjyV4UkSo3bUd534wgtNQxnFt+IuG70CLiZyNjgZuZu/KR4DvMRpGDR/McfnI/+sGZXcz+tFrhq5c3JEED0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLl8Jwbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8BBC2BC87
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772457819;
	bh=i6kS87qUnZ6mbCIR/lWF042B2JkLiPFC6Xd85F77Ur8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qLl8Jwbh1f3JGoHnGUaxIUCKyx6rLdXSQ0w4ZbmKt6OcB2GISud/HJmNKnYG4PReT
	 3DkYExGKaX7D6F8m7/HU9Jm/0uWbmT4zRZJwDcWBbAjh8VkYVshz61x+e+W/prNWhJ
	 kj8K1pAItuA2czQ8aEWyoXttfTTwJsZbSThMCjxducprbz0hUexK1l+FxNJyFQzuNz
	 MoNgEUgcYz0C9FO0RkZTo7oPh5tf3OxXO7w+IeCy5jz/XXxI2jYtSJSVeIFJtxie9d
	 nCeM5EM7kNUBRJEFxAF0VwHxDV6nQ6aof2ZzBsPEEJZQlyxBE62KTe3xvSUdiYyTMA
	 7iuoZO6XRqfvA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b886fc047d5so720453466b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2026 05:23:38 -0800 (PST)
X-Gm-Message-State: AOJu0Yw0rAbcVb/KvJRohYyGts46/LlcTDsJcbyzvy9nQ7RjWZCV4drz
	DovWR79KYraoc2I5m4+xOt/nO9XdPMMn+1VqP73mp1SaPBn4w/i3kh6682vHdxMod6ZlUXJI6KP
	ygEo3U7HIOG/82B7Lf7eLkVeR8HNEZiY=
X-Received: by 2002:a17:907:7b8c:b0:b8f:abff:9cf2 with SMTP id
 a640c23a62f3a-b9376378cadmr770535666b.4.1772457817202; Mon, 02 Mar 2026
 05:23:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302110202.790279-1-gality369@gmail.com>
In-Reply-To: <20260302110202.790279-1-gality369@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Mar 2026 13:23:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5rGH11B7+2r6DG9N60W5X97KthYniHKPdFAXidoTaZUQ@mail.gmail.com>
X-Gm-Features: AaiRm53fZPfnnr3g8kqNWKcnwLjXEOrRTrViwwXceKkXfayIXF4jyrQ_3DsLlpE
Message-ID: <CAL3q7H5rGH11B7+2r6DG9N60W5X97KthYniHKPdFAXidoTaZUQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reject global extent/csum roots without offset 0
 when extent_tree_v2 is off
To: ZhengYuan Huang <gality369@gmail.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com, 
	josef@toxicpanda.com, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	r33s3n6@gmail.com, zzzccc427@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,suse.com,toxicpanda.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-22147-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E92E01D9B01
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 11:03=E2=80=AFAM ZhengYuan Huang <gality369@gmail.co=
m> wrote:
>
> Without EXTENT_TREE_V2, btrfs_extent_root() and btrfs_csum_root() always
> look up the global roots at offset 0. A crafted image can provide only
> non-zero offsets for the extent/csum global roots, so the offset 0 lookup
> returns NULL and later leads to a NULL dereference
> (e.g. in backup_super_roots()).
>
> Fix this by detecting this at mount time: when loading extent/csum
> global roots without EXTENT_TREE_V2, require that an offset 0 root item
> exists, otherwise fail the mount with -EUCLEAN.
>
> Tested with a crafted image that has only non-zero offset global roots,
> which triggers the KASAN null-ptr-deref in backup_super_roots() before
> the fix, and fails the mount with -EUCLEAN after the fix.
>
> Fixes: f7238e509404 ("btrfs: add support for multiple global roots")
> Cc: stable@vger.kernel.org # v5.18+
> Signed-off-by: ZhengYuan Huang <gality369@gmail.com>

This was already fixed in for-next:

https://lore.kernel.org/linux-btrfs/cover.1770580436.git.fdmanana@suse.com/

Always check the github for-next branch before sending patches:

https://github.com/btrfs/linux/commits/for-next/

Thanks.

> ---
> A KASAN null-ptr-deref was triggered when mounting a crafted btrfs
> image and then doing a simple write/rename workload (e.g. moving any
> file into the mountpoint). The crash happens later during a transaction
> commit, in the super backup roots path.
>
> Root cause
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> backup_super_roots() looks up both the extent and csum roots through
> the "global roots" rb-tree:
>
> extent_root =3D btrfs_extent_root(fs_info, 0);
> csum_root =3D btrfs_csum_root(fs_info, 0);
>
> and then unconditionally dereferences extent_root->node and
> csum_root->node.
>
> Both btrfs_extent_root() and btrfs_csum_root() build a key with:
>
> .offset =3D btrfs_global_root_id(fs_info, bytenr)
>
> and btrfs_global_root_id() returns 0 when the filesystem does not have
> the EXTENT_TREE_V2 incompat feature. This means that for
> non-extent_tree_v2 filesystems, the implementation assumes that there is
> always a global root item for:
>
> (BTRFS_EXTENT_TREE_OBJECTID, BTRFS_ROOT_ITEM_KEY, offset=3D0)
> (BTRFS_CSUM_TREE_OBJECTID, BTRFS_ROOT_ITEM_KEY, offset=3D0)
>
> However, an image without an offset =3D 0 root item can still be
> successfully mounted. The mount-time validation logic for the csum tree
> resides in load_global_roots_objectid(). Currently,
> load_global_roots_objectid() loads whatever root items exist for
> a given objectid, but it does not validate that offset =3D 0
> exists when EXTENT_TREE_V2 is not enabled. With a crafted image,
> the first (and only) root item for the csum tree (and similarly for
> extent) can have a large non-zero offset (e.g. 0x10000000000).
> load_global_roots_objectid() inserts that root into the rb-tree, but
> there is no entry for offset 0. Later, btrfs_csum_root(..., 0) looks up
> offset 0, returns NULL, and backup_super_roots() dereferences it,
> causing the crash.
>
> So the bug is an invariant mismatch:
>
> - lookup side (btrfs_{extent,csum}_root) assumes offset=3D0 exists when
> extent_tree_v2 is off
>
> - load side (load_global_roots_objectid) does not enforce that assumption
>
> Fix
> =3D=3D=3D
> Teach load_global_roots_objectid() to enforce the "offset 0 must exist"
> invariant for the extent and csum trees when EXTENT_TREE_V2 is not enable=
d.
> If at least one root item is found but none has offset 0, fail the mount
> with -EUCLEAN and emit an explicit error message. This prevents later
> NULL dereferences and also avoids propagating a corrupted/unsupported
> global-root layout into runtime.
>
> Note: extent_root is subject to the same assumption and is fixed by the
> same check (backup_super_roots dereferences extent_root->node as well).
>
> KASAN report
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000003: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> CPU: 0 UID: 0 PID: 34 Comm: kworker/u8:1 Tainted: G           OE       6.=
18.0 #1 PREEMPT(voluntary)
> Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-de=
bian-1.16.3-2 04/01/2014
> Workqueue: events_unbound btrfs_async_reclaim_data_space
> RIP: 0010:backup_super_roots fs/btrfs/disk-io.c:1680 [inline]
> RIP: 0010:write_all_supers+0x2d56/0x4980 fs/btrfs/disk-io.c:4022
> Code: 40 38 f2 7f 08 84 d2 0f 85 72 19 00 00 49 8d 7c 24 18 41 88 9e 9a 0=
0 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 fe 48 c1 ee 03 <80> 3c 16 00 0f=
 85 33 19 00 00 48 ba 00 00 00 00 00 fc ff df 49 8b
> RSP: 0018:ffff88800a617758 EFLAGS: 00010216
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: dffffc0000000000 RSI: 0000000000000003 RDI: 0000000000000018
> RBP: ffff88800a617898 R08: 1ffff110023f53a8 R09: 0000000000000000
> R10: ffff8880173a8000 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff888000000000 R14: ffff88800b676d23 R15: ffffea0000000000
> FS:  0000000000000000(0000) GS:ffff8880e4d3e000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005baa3c26f678 CR3: 000000000e9b8000 CR4: 00000000000006f0
> Call Trace:
> <TASK>
> ? __pfx_write_all_supers+0x10/0x10 fs/btrfs/disk-io.c:3980
> ? btrfs_commit_transaction+0x2818/0x3d90 fs/btrfs/transaction.c:2526
> ? __lock_release kernel/locking/lockdep.c:5574 [inline]
> ? lock_release+0x122/0x2a0 kernel/locking/lockdep.c:5889
> btrfs_commit_transaction+0x28cc/0x3d90 fs/btrfs/transaction.c:2541
> ? __pfx_btrfs_commit_transaction+0x10/0x10 fs/btrfs/transaction.c:1919
> ? start_transaction+0x244/0x1740 fs/btrfs/transaction.c:780
> btrfs_commit_current_transaction+0x55/0xf0 fs/btrfs/transaction.c:2010
> flush_space+0x7d1/0xc40 fs/btrfs/space-info.c:888
> ? mark_usage kernel/locking/lockdep.c:4674 [inline]
> ? __lock_acquire+0x43e/0x21e0 kernel/locking/lockdep.c:5191
> ? __pfx_flush_space+0x10/0x10 include/trace/events/btrfs.h:2362
> ? instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
> ? atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1=
301 [inline]
> ? queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
> ? do_raw_spin_lock+0x133/0x290 kernel/locking/spinlock_debug.c:116
> ? find_held_lock+0x31/0x90 kernel/locking/lockdep.c:5350
> ? spin_unlock include/linux/spinlock.h:391 [inline]
> ? do_async_reclaim_data_space+0x369/0x5e0 fs/btrfs/space-info.c:1441
> ? __kasan_check_read+0x11/0x20 mm/kasan/shadow.c:31
> ? instrument_atomic_read include/linux/instrumented.h:68 [inline]
> ? atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> ? queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
> ? debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
> ? do_raw_spin_unlock+0x59/0x200 kernel/locking/spinlock_debug.c:141
> do_async_reclaim_data_space+0x3c1/0x5e0 fs/btrfs/space-info.c:1410
> btrfs_async_reclaim_data_space+0x3f/0xb0 fs/btrfs/space-info.c:1458
> process_one_work+0x8e0/0x1980 kernel/workqueue.c:3263
> ? __pfx_process_one_work+0x10/0x10 include/linux/list.h:226
> ? move_linked_works+0x1a8/0x2c0 kernel/workqueue.c:1165
> ? assign_work+0x19d/0x240 kernel/workqueue.c:1206
> ? __lock_is_held kernel/locking/lockdep.c:5601 [inline]
> ? lock_is_held_type+0xa3/0x130 kernel/locking/lockdep.c:5940
> process_scheduled_works kernel/workqueue.c:3346 [inline]
> worker_thread+0x683/0xf80 kernel/workqueue.c:3427
> ? __pfx_worker_thread+0x10/0x10 kernel/workqueue.c:3570
> kthread+0x3f0/0x850 kernel/kthread.c:463
> ? __pfx_kthread+0x10/0x10 arch/x86/include/asm/bitops.h:202
> ? trace_hardirqs_on+0x53/0x60 kernel/trace/trace_preemptirq.c:79
> ? __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
> ? _raw_spin_unlock_irq+0x27/0x70 kernel/locking/spinlock.c:202
> ? spin_unlock_irq include/linux/spinlock.h:401 [inline]
> ? calculate_sigpending+0x7c/0xb0 kernel/signal.c:194
> ? __pfx_kthread+0x10/0x10 arch/x86/include/asm/bitops.h:202
> ret_from_fork+0x50f/0x610 arch/x86/kernel/process.c:158
> ? __pfx_kthread+0x10/0x10 arch/x86/include/asm/bitops.h:202
> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:backup_super_roots fs/btrfs/disk-io.c:1680 [inline]
> RIP: 0010:write_all_supers+0x2d56/0x4980 fs/btrfs/disk-io.c:4022
> Code: 40 38 f2 7f 08 84 d2 0f 85 72 19 00 00 49 8d 7c 24 18 41 88 9e 9a 0=
0 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 fe 48 c1 ee 03 <80> 3c 16 00 0f=
 85 33 19 00 00 48 ba 00 00 00 00 00 fc ff df 49 8b
> RSP: 0018:ffff88800a617758 EFLAGS: 00010216
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: dffffc0000000000 RSI: 0000000000000003 RDI: 0000000000000018
> RBP: ffff88800a617898 R08: 1ffff110023f53a8 R09: 0000000000000000
> R10: ffff8880173a8000 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff888000000000 R14: ffff88800b676d23 R15: ffffea0000000000
> FS:  0000000000000000(0000) GS:ffff8880e4d3e000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005baa3c26f678 CR3: 000000000e9b8000 CR4: 00000000000006f0
> ----------------
> Code disassembly (best guess):
>    0:   40 38 f2                cmp    %sil,%dl
>    3:   7f 08                   jg     0xd
>    5:   84 d2                   test   %dl,%dl
>    7:   0f 85 72 19 00 00       jne    0x197f
>    d:   49 8d 7c 24 18          lea    0x18(%r12),%rdi
>   12:   41 88 9e 9a 00 00 00    mov    %bl,0x9a(%r14)
>   19:   48 ba 00 00 00 00 00    movabs $0xdffffc0000000000,%rdx
>   20:   fc ff df
>   23:   48 89 fe                mov    %rdi,%rsi
>   26:   48 c1 ee 03             shr    $0x3,%rsi
> * 2a:   80 3c 16 00             cmpb   $0x0,(%rsi,%rdx,1) <-- trapping in=
struction
>   2e:   0f 85 33 19 00 00       jne    0x1967
>   34:   48 ba 00 00 00 00 00    movabs $0xdffffc0000000000,%rdx
>   3b:   fc ff df
>   3e:   49                      rex.WB
>   3f:   8b                      .byte 0x8b
>
> Reproduction (v6.18, x86_64, KASAN)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Download the crafted image (tested with Linux v6.18 + KASAN):
>   https://drive.google.com/file/d/1xV0pjI3N-D83IzH62dphWCAD0RR-sV4U/view
> 2. Attach it as a block device (example assumes it shows up as /dev/vda),
> then mount it read-write:
>   mkdir -p /mnt/btrfs
>   mount /dev/vda /mnt/btrfs
> 3. Trigger any metadata update, e.g. move a file into the mountpoint:
>   echo test > /tmp/1.txt
>   mv /tmp/1.txt /mnt/btrfs/
> 4. Result:
> The system hits a NULL pointer dereference in the commit path, with KASAN
> reporting the fault at backup_super_roots() (fs/btrfs/disk-io.c).
>
> Thanks,
> ZhengYuan Huang
> ---
>  fs/btrfs/disk-io.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0aa7e5d1b05f..900e462d8ea1 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2119,6 +2119,18 @@ static int load_global_roots_objectid(struct btrfs=
_root *tree_root,
>         };
>         bool found =3D false;
>
> +       /*
> +        * Without EXTENT_TREE_V2 we only have a single global extent/csu=
m root.
> +        * btrfs_extent_root() and btrfs_csum_root() always look it up wi=
th offset
> +        * 0 (btrfs_global_root_id() returns 0). If we load only non-zero=
 offsets
> +        * here, later users will see NULL and can crash (e.g. when backi=
ng up
> +        * super roots during a commit).
> +        */
> +       bool need_offset0 =3D !btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)=
 &&
> +                     (objectid =3D=3D BTRFS_EXTENT_TREE_OBJECTID ||
> +                      objectid =3D=3D BTRFS_CSUM_TREE_OBJECTID);
> +       bool found_offset0 =3D false;
> +
>         /* If we have IGNOREDATACSUMS skip loading these roots. */
>         if (objectid =3D=3D BTRFS_CSUM_TREE_OBJECTID &&
>             btrfs_test_opt(fs_info, IGNOREDATACSUMS)) {
> @@ -2144,6 +2156,8 @@ static int load_global_roots_objectid(struct btrfs_=
root *tree_root,
>                 btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0=
]);
>                 if (key.objectid !=3D objectid)
>                         break;
> +               if (need_offset0 && key.offset =3D=3D 0)
> +                       found_offset0 =3D true;
>                 btrfs_release_path(path);
>
>                 /*
> @@ -2169,6 +2183,13 @@ static int load_global_roots_objectid(struct btrfs=
_root *tree_root,
>         }
>         btrfs_release_path(path);
>
> +       if (need_offset0 && found && !found_offset0) {
> +               btrfs_err(fs_info,
> +                         "missing global %s root item with offset 0 (ext=
ent_tree_v2 not enabled)",
> +                         name);
> +               return -EUCLEAN;
> +       }
> +
>         if (objectid =3D=3D BTRFS_EXTENT_TREE_OBJECTID)
>                 fs_info->nr_global_roots =3D max_global_id + 1;
>
> --
> 2.43.0
>
>

