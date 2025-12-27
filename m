Return-Path: <linux-btrfs+bounces-20028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0F3CE0271
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Dec 2025 22:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C7930173A6
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Dec 2025 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69EE238150;
	Sat, 27 Dec 2025 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FwpyZsqY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564E1A08A3
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Dec 2025 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766871977; cv=none; b=TcpU0BxmIYN2uB/nMrGHIZDFUZs6OA6nDwyMW0DukBxNy23VuYuK0o+RnPN5LMFnat6hvsbMc6OboYFh9E007Hqg4AwHbC9rWpZdEuWQ46N6b1+3ITdM6A+23y382L2V6LNAaykW12cBa7uxn8Gmdf0iqWOEXgflu5un727S7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766871977; c=relaxed/simple;
	bh=HbHuaTDkPz6dJ8vB7CvgD5T4RH+AYAe7QThJRQzB8qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SawS3GDLmPh2rRE312EcdETOCCCT05nQ1vkfuHqo1FaeMcKwCCqt23eRr+XctJRkneaQL/ITh1Zrf2JG68R3wlTEcxgkmuEsY4Dg5qKcm9WCPfaacHKtn0OW+ihntR6y9ZeWGXVpHgQoLr5MQXExZRYUW7kC/dWwPrAZqSW7T5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FwpyZsqY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1766871968; x=1767476768; i=quwenruo.btrfs@gmx.com;
	bh=1NxZvIsrBK6fZguAtf6bUF9kyBnRXAs1EUpVOZ2WDLk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FwpyZsqYnAPMBuBSqeOjqd06m78sMugwH1tYjsXMXa8WdtmxB1mgZQ/Yh/612plk
	 wE2u7Wk2bf25NOUVZbBoXjfo+AtnMbKfGg8FF0KsPosInHaiTxZWkh4fDD8B4oH7X
	 2/ZLo1SoYMsNdNePltBsktJRTg2EFpkJmQM85eoQfSGjflNZdgPTJRH6xQHkhG4oL
	 ni6NeD5N0tAEf77nlY81q3fRoJS0XtK6b5q8vlff7pOB893bxIreUWNeH9s1I6DG2
	 FCEolqkrua2dMBZxMl3nQ1sYkxGv69J/MjMFHTI5OtBn+/J7E3epeRFVG9Me5fVMH
	 2Uy5Danl9RAtFhmqYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvrB-1w87NK2S57-00cDE8; Sat, 27
 Dec 2025 22:46:08 +0100
Message-ID: <99e8bc26-8533-49e7-b3bb-783d6fd95f07@gmx.com>
Date: Sun, 28 Dec 2025 08:16:02 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] lockdep: possible circular locking dependency between
 mm->mmap_lock and kernfs_rwsem via btrfs qgroup path
To: Alen Frank <gality369@gmail.com>, clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com,
 zzzccc427@gmail.com
References: <CAOmEq9XdTN64=oE7na3J+vCG+fV2bFHSpprHswcE_wEfk_edNg@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CAOmEq9XdTN64=oE7na3J+vCG+fV2bFHSpprHswcE_wEfk_edNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XLnoG/AkarLIQ3zMzTuEvk3gvE/QOezmKuPYtoE6PSc+38woNKU
 38/2+YPmh/lsIvDdpGoI4jIsY6SVbU3QlOGj77TOTut+Z5WbRDj7W4tuaiRvmWwUQudQwuy
 ozxA7rarvoCjuIYLOGXVD1cPXK/dsAZv0Y7FdIkf85u4f6PUA28bLRjh4ZTCA5Fw3GOjoZm
 Z4VnrluT3RCZ9KeCgyL+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0P80acFx9cE=;3Qs1ot+llLa+3m2KGnSeqpXEOR+
 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



=E5=9C=A8 2025/12/27 15:26, Alen Frank =E5=86=99=E9=81=93:
> Hello maintainers,
>=20
> I would like to report a lockdep warning indicating a possible circular =
locking
> dependency involving mm->mmap_lock, root->kernfs_rwsem, and btrfs qgroup=
-related
> locks.
>=20
> This issue was found using a custom fuzzing tool. The kernel is marked
> as -dirty only
> because I locally added some debug code to print additional call
> stacks; no locking logic
> or control flow related to this issue was modified.
>=20
> This warning can be understood as a triggering lock ordering observed in=
 the
> current context combined with an existing dependency chain recorded by l=
ockdep.
>=20
> Chain A (triggering ordering in the current context):
> root->kernfs_rwsem -> mm->mmap_lock.
>=20
> It arises when getdents64() on a kernfs directory calls
> kernfs_fop_readdir(). While holding root->kernfs_rwsem, filldir64() trig=
gers a
> user page fault while accessing the userspace buffer, and the fault path
> (lock_mm_and_find_vma()) attempts to take mm->mmap_lock.
>=20
> Chain B (dependency chain reported by lockdep):
> mm->mmap_lock -> sb_pagefaults-> btrfs_trans_num_writers
> -> btrfs_trans_num_extwriters -> fs_info->reloc_mutex
> -> btrfs-quota-00 -> root->kernfs_rwsem.
>=20
> This is a dependency chain in the
> lockdep graph; individual edges may originate from different runtime con=
texts.
> Below I analyze this chain in detail (for convenience, =E2=80=9C#N=E2=80=
=9D labels refer to the
> same lock numbering as in the full lockdep report):
>=20
> Lock ordering between mm->mmap_lock and sb_pagefaults (#0 -> #2):
> Both paths enter do_user_addr_fault(). mm->mmap_lock is first acquired v=
ia
> lock_mm_and_find_vma() at arch/x86/mm/fault.c:1359. While holding this l=
ock,
> handle_mm_fault() (at arch/x86/mm/fault.c:1387) eventually acquires
> sb_pagefaults.
>=20
> lock A:
> do_user_addr_fault()
> -> lock_mm_and_find_vma()
>     -> get_mmap_lock_carefully()
>        -> mmap_read_lock_killable()
>           -> down_read_killable(&mm->mmap_lock)
>=20
> lock B:
> do_user_addr_fault()
> -> handle_mm_fault()
>     -> __handle_mm_fault()
>        -> handle_pte_fault()
>           -> do_pte_missing()
>              -> do_fault()
>                 -> do_shared_fault()
>                    -> do_page_mkwrite()
>                       -> btrfs_page_mkwrite()
>                          -> sb_start_pagefault()
>=20
> Lock ordering between sb_pagefaults and btrfs_trans_num_writers (#2 -> #=
3):
> Both paths enter btrfs_page_mkwrite(). sb_pagefaults is first held via
> sb_start_pagefault() at fs/btrfs/file.c:1874. Then btrfs_trans_num_write=
rs is
> acquired via file_update_time() at fs/btrfs/file.c:1915.
>=20
> lock B:
> btrfs_page_mkwrite()
> -> sb_start_pagefault()
>=20
> lock C:
> btrfs_page_mkwrite()
> -> file_update_time()
>     -> __file_update_time()
>        -> inode_update_time()
>           -> btrfs_update_time()
>              -> btrfs_dirty_inode()
>                 -> btrfs_start_transaction()
>                    -> start_transaction()
>                       -> sb_start_intwrite()
>=20
> Lock ordering between btrfs_trans_num_writers and
> btrfs_trans_num_extwriters (#3 -> #4):
> Both paths enter btrfs_dirty_inode(). btrfs_trans_num_writers is first
> held via btrfs_start_transaction() at fs/btrfs/inode.c:6279. Then
> btrfs_trans_num_extwriters is acquired via btrfs_start_transaction() at
> fs/btrfs/inode.c:6280.
>=20
> lock C:
> btrfs_dirty_inode()
> -> btrfs_start_transaction()
>     -> start_transaction()
>        -> sb_start_intwrite()
>=20
> lock D:
> btrfs_dirty_inode()
> -> btrfs_start_transaction()
>     -> join_transaction()
>        -> btrfs_lockdep_acquire()
>=20
> Lock ordering between btrfs_trans_num_extwriters and
> fs_info->reloc_mutex (#4 ->#5):
> Both paths enter btrfs_start_transaction(). btrfs_trans_num_extwriters i=
s
> first held via join_transaction() at fs/btrfs/transaction.c:705. Then
> fs_info->reloc_mutex is acquired via btrfs_record_root_in_trans() at
> fs/btrfs/transaction.c:779.
>=20
> lock D:
> btrfs_start_transaction()
> -> join_transaction()
>     -> btrfs_lockdep_acquire()
>=20
> lock E:
> btrfs_start_transaction()
> -> btrfs_record_root_in_trans()
>     -> mutex_lock_nested()
>        -> mutex_lock()
>=20
> Lock ordering between fs_info->reloc_mutex and btrfs-quota-00 (#5 -> #6)=
:
> Both paths enter btrfs_commit_transaction(). fs_info->reloc_mutex is
> first acquired
> via mutex_lock(&fs_info->reloc_mutex) at fs/btrfs/transaction.c:2405. Th=
en
> btrfs-quota-00 is acquired via commit_cowonly_roots() at
> fs/btrfs/transaction.c:1354.
>=20
> lock E:
> btrfs_commit_transaction()
> -> mutex_lock()
>=20
> lock F:
> btrfs_commit_transaction()
> -> commit_cowonly_roots()
>     -> btrfs_run_qgroups()
>        -> update_qgroup_info_item()
>           -> btrfs_search_slot()
>              -> btrfs_search_slot_get_root()
>                 -> btrfs_read_lock_root_node()
>                    -> btrfs_tree_read_lock()
>=20
> Lock ordering between btrfs-quota-00 and root->kernfs_rwsem (#6 -> #7):
> Both paths enter btrfs_read_qgroup_config().The qgroup tree is first
> accessed via
> btrfs_search_slot_for_read() at fs/btrfs/qgroup.c:418.Then root->kernfs_=
rwsem is
> acquired via btrfs_sysfs_add_one_qgroup() at fs/btrfs/qgroup.c:488.
>=20
> lock F:
> btrfs_read_qgroup_config()
> -> btrfs_search_slot_for_read()
>     -> btrfs_search_slot()
>        -> btrfs_search_slot_get_root()
>           -> btrfs_read_lock_root_node()
>              -> btrfs_tree_read_lock()
>=20
> lock G:
> btrfs_read_qgroup_config()
> -> btrfs_sysfs_add_one_qgroup()
>     -> kobject_init_and_add()
>        -> kobject_add_varg()
>           -> kobject_add_internal()
>              -> create_dir()
>                 -> sysfs_create_dir_ns()
>                    -> kernfs_create_dir_ns()
>                       -> kernfs_add_one()
>                          -> down_write(&root->kernfs_rwsem)
>=20
> After reviewing the code paths involved, I could not find a clear execut=
ion path
> corresponding to the #0 -> #1 and #1 -> #2 edges reported by lockdep. I =
was,
> however, able to identify a concrete path establishing the ordering betw=
een #0
> and #2, and therefore focused on that relationship in the analysis above=
.
>=20
> Overall, this may result in a circular locking dependency, as reported
> by lockdep.
>=20
> My understanding of some of the paths may be incomplete, as I'm still le=
arning
> the kernel internals. If there are mistakes or alternative interpretatio=
ns,
> please let me know =E2=80=94 any guidance would be appreciated.
>=20
> Full lockdep report is attached below:
>=20
> WARNING: possible circular locking dependency detected
> 6.18.0-dirty #1 Tainted: G           OE
> ------------------------------------------------------
> syz.0.279/4686 is trying to acquire lock:
> ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> mmap_read_lock_killable include/linux/mmap_lock.h:377 [inline]
> ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> get_mmap_lock_carefully mm/mmap_lock.c:378 [inline]
> ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> lock_mm_and_find_vma+0x146/0x630 mm/mmap_lock.c:429
>=20
> but task is already holding lock:
> ffff88800aa8c188 (&root->kernfs_rwsem){++++}-{4:4}, at:
> kernfs_fop_readdir+0x146/0x860 fs/kernfs/dir.c:1893
>=20
> which lock already depends on the new lock.
>=20
>=20
> the existing dependency chain (in reverse order) is:
>=20
> -> #7 (&root->kernfs_rwsem){++++}-{4:4}:
>        down_write+0x91/0x210 kernel/locking/rwsem.c:1590
>        kernfs_add_one+0x39/0x700 fs/kernfs/dir.c:791
>        kernfs_create_dir_ns+0x103/0x1a0 fs/kernfs/dir.c:1093
>        sysfs_create_dir_ns+0x143/0x2b0 fs/sysfs/dir.c:59
>        create_dir lib/kobject.c:73 [inline]
>        kobject_add_internal+0x24d/0xad0 lib/kobject.c:240
>        kobject_add_varg lib/kobject.c:374 [inline]
>        kobject_init_and_add+0x114/0x1a0 lib/kobject.c:457
>        btrfs_sysfs_add_one_qgroup+0xe2/0x170 fs/btrfs/sysfs.c:2599
>        btrfs_read_qgroup_config+0x86f/0x1310 fs/btrfs/qgroup.c:488
>        open_ctree+0x3bda/0x6d60 fs/btrfs/disk-io.c:3592

At this stage the fs is still being mounted.

>        btrfs_fill_super fs/btrfs/super.c:987 [inline]
>        btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
>        btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
>        btrfs_get_tree+0x114c/0x22e0 fs/btrfs/super.c:2128
>        vfs_get_tree+0x9a/0x370 fs/super.c:1758
>        fc_mount fs/namespace.c:1199 [inline]
>        do_new_mount_fc fs/namespace.c:3642 [inline]
>        do_new_mount fs/namespace.c:3718 [inline]
>        path_mount+0x5aa/0x1e90 fs/namespace.c:4028
>        do_mount fs/namespace.c:4041 [inline]
>        __do_sys_mount fs/namespace.c:4229 [inline]
>        __se_sys_mount fs/namespace.c:4206 [inline]
>        __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
>        x64_sys_call+0x1a7d/0x26a0
> arch/x86/include/generated/asm/syscalls_64.h:166
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x91/0xa90 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> -> #6 (btrfs-quota-00){++++}-{4:4}:
>        down_read_nested+0xa0/0x4d0 kernel/locking/rwsem.c:1662
>        btrfs_tree_read_lock_nested+0x32/0x1d0 fs/btrfs/locking.c:145
>        btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
>        btrfs_read_lock_root_node+0x73/0xb0 fs/btrfs/locking.c:266
>        btrfs_search_slot_get_root fs/btrfs/ctree.c:1742 [inline]
>        btrfs_search_slot+0x3e0/0x3580 fs/btrfs/ctree.c:2066
>        update_qgroup_info_item fs/btrfs/qgroup.c:882 [inline]
>        btrfs_run_qgroups+0x4f3/0x870 fs/btrfs/qgroup.c:3112
>        commit_cowonly_roots+0x1f3/0x8f0 fs/btrfs/transaction.c:1354
>        btrfs_commit_transaction+0x1c64/0x3f70 fs/btrfs/transaction.c:245=
9
>        btrfs_sync_fs+0xf2/0x660 fs/btrfs/super.c:1057
>        sync_filesystem fs/sync.c:66 [inline]
>        sync_filesystem+0x1ba/0x260 fs/sync.c:30
>        generic_shutdown_super+0x88/0x520 fs/super.c:621

And the same fs is being unmounted.

Something looks wrong that one is unmounting a fs that is still under=20
mounting process.


> Best regards,
> ZhengYuan Huang
>=20

So many sock puppets BTW.

Thanks,
Qu

