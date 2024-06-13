Return-Path: <linux-btrfs+bounces-5727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A798907EC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 00:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1850728382D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 22:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523FA14B064;
	Thu, 13 Jun 2024 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k9Q1SkWi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3CD81AB5
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317318; cv=none; b=jwJEcCNOHqq2J7vc3K65dMV+li1aND7OYNB5xQ9LXeCRn9g1VfupdzWQHn8xiCVV0PgEoTSyr24weO0Ht2PATWzIobyW3qYRQEb5OFBX1oPq16s3Ecq6gLl5QUEnS3vIm8xNXustA0ReckqZdYQXcaLqDX36AIdS8KKz0Zl3ZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317318; c=relaxed/simple;
	bh=iXFa4oYvVBQ76Hct9dWfn8R1K+/3oL+NOWKpnGNy9+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VM4dDG1bDETcSvHOxckjIJvdF9wTfnZZzPbi1rwP2T24KHG78U6foeQDhxRVRbSopu3Dv52SPA349YB2JS216GFm+1kVySO3mmUYRWcs/GKXqo0xc8zNYknqhkGX6Jz7tk4eT6/XNKZWJNaYEf94UNxXcjo/Hin1cU0dIao32rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k9Q1SkWi; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718317308; x=1718922108; i=quwenruo.btrfs@gmx.com;
	bh=7tQC7/kynHM9IAOHypcYUWW65u94BXacsUfZBbvn2Bg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k9Q1SkWipMPBbejO2I7mIHoPXbNpis+E5yId1jtMk1w7O+c/5h/1pMDLjxNuj/5+
	 Z5rMD9dZkjj9Q0WMNQQHaMcmVi+tpo8NTfimk4wDJwOiOENkjLnkvdF85f+bMEkOU
	 JELVplap8UvAQt9N4OMvVSeQeH/QsmgGD8BEBtEmWBAwSxAwlSrPvmNJN8hE/Hv7P
	 +D5i4PGlooslkMMjub6ppRphoxpxb48p/IkYWZ7RyY8e2MsUrE70nTWYXqfpmp6j2
	 BfOR95oXOZCiiPpL2+n8e8QMHEMGRrCOvIQHeUrbGZqp63YU1SPM5s+NeIyKIxFKt
	 W9So5V5oF+mBjvVbdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHQh-1sfv1u2X97-00mCe3; Fri, 14
 Jun 2024 00:21:48 +0200
Message-ID: <82aea39f-f895-469c-b973-9556980d7732@gmx.com>
Date: Fri, 14 Jun 2024 07:51:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] btrfs: use NOFS context when getting inodes during
 logging and log replay
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1718276261.git.fdmanana@suse.com>
 <818b41faf6260be972ffa3bd436dda518963384b.1718276261.git.fdmanana@suse.com>
 <04f49180-cdb0-4665-abe4-136dbc85fbb3@gmx.com>
 <CAL3q7H6CPShWF0ik8bgFu42dNySrnq=ZMdg07jUXdgRttHMqiQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAL3q7H6CPShWF0ik8bgFu42dNySrnq=ZMdg07jUXdgRttHMqiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+jKbq0+J4Br/IEkHFfo7XiwPqHmQ0WnxscErzat1O5j8/6NhUEd
 N92n3p4rNgopxnsH59r/osr58Sf1hQBnIsrG7vGM++Xbb+nPBZX9osJe5ouBfAJYs7mvrlW
 fpGEydcPPVFJWweZYkFWDbnoAvOrygxM35oOmbCIiWAJkbTFu/uIXm/3M4g3Wv4Mh904EPo
 29xH3gijCdnmuhhAU7dSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QLl84GCiYH0=;U3YwDkgw37njAVsD2u0VF5FhMu0
 /lfX7NFfMSpxwGvkmW//X6EiKy96fA/Xy14MEQ0YVH25lW8dSOUeYiVKNN/P+hJNlyN5bI24z
 dUjcnvHKhMVcR4/3DI92gJniLWbk0Ynm/9ISfUynULqyecxoYgv/v6Llp72nx7JoNVEN/K7pX
 +JszZH9le43FLDH9KME0FdtHHNB2z0KVb4afncF5P1CqZ+KW6Mo+La9s4Lqr0pVlRpFO1moAF
 CS2jn2eVQizTmBZo5UqpVlpVFtX+H5QLYnu+yLKD8Ur1YXdWRzbsxEA/gawU+OQI/+mNWT6MN
 wW5nwNtKnldswwfmThZAKOrlqTNXJDwWSZAJEfPYfYNpVSzvO6T/cIz2Wm6jdIe7YEjA5db61
 v2LGZOItv/9Qg7qEH59teAyFQGj64gEK+bMv1dnd96NPW6TvMvk8uce2kgcncIigpLeHveTH8
 VDQuCSHSg7UytXj9ANgNjXtbl1d8LANKMx6Bg+1/fF80cTlgbIVSu2WtEIFIyR2wIjby8D2dN
 Lbkq1XMXF9YPgkMshIUGWrcUVu5Y8spe2OZuWvCDEOx38/c1rG5rfd4bbEiPyVgOmnUcW2NmQ
 9kxdI4tcFpzrH9lns4FJ91ZJd685sO7BUOpVrQ8xesoQ/Qy2hfx+30SlbhlOvAXfvBWBiDfIs
 Dxo8vOfJPrXQvbHjUrjaTwXn1T332+3vYbi6p2tYs5mKZSALSqYAODQawxD+UECxJcyDyQae/
 9zbAEPQaGM2Dp7DITNkiz+p/UOsIppGUzwwQ88QR3CMZGlInG9hP+p7ENgd8ipuoU9D/R/vMa
 7GKPydgOkL/bBonysJgNP2AKdoFiAub4e/8t816e5Nxsc=



=E5=9C=A8 2024/6/14 07:24, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Jun 13, 2024 at 10:37=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/6/13 20:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> During inode logging (and log replay too), we are holding a transactio=
n
>>> handle and we often need to call btrfs_iget(), which will read an inod=
e
>>> from its subvolume btree if it's not loaded in memory and that results=
 in
>>> allocating an inode with GFP_KERNEL semantics at the btrfs_alloc_inode=
()
>>> callback - and this may recurse into the filesystem in case we are und=
er
>>> memory pressure and attempt to commit the current transaction, resulti=
ng
>>> in a deadlock since the logging (or log replay) task is holding a
>>> transaction handle open.
>>>
>>> Syzbot reported this with the following stack traces:
>>>
>>>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>      WARNING: possible circular locking dependency detected
>>>      6.10.0-rc2-syzkaller-00361-g061d1af7b030 #0 Not tainted
>>>      ------------------------------------------------------
>>>      syz-executor.1/9919 is trying to acquire lock:
>>>      ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc includ=
e/linux/sched/mm.h:334 [inline]
>>>      ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hoo=
k mm/slub.c:3891 [inline]
>>>      ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm=
/slub.c:3981 [inline]
>>>      ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_l=
ru_noprof+0x58/0x2f0 mm/slub.c:4020
>>>
>>>      but task is already holding lock:
>>>      ffff88804b569358 (&ei->log_mutex){+.+.}-{3:3}, at: btrfs_log_inod=
e+0x39c/0x4660 fs/btrfs/tree-log.c:6481
>>>
>>>      which lock already depends on the new lock.
>>>
>>>      the existing dependency chain (in reverse order) is:
>>>
>>>      -> #3 (&ei->log_mutex){+.+.}-{3:3}:
>>>             __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>>>             __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
>>>             btrfs_log_inode+0x39c/0x4660 fs/btrfs/tree-log.c:6481
>>>             btrfs_log_inode_parent+0x8cb/0x2a90 fs/btrfs/tree-log.c:70=
79
>>>             btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7180
>>>             btrfs_sync_file+0x9c1/0xe10 fs/btrfs/file.c:1959
>>>             vfs_fsync_range+0x141/0x230 fs/sync.c:188
>>>             generic_write_sync include/linux/fs.h:2794 [inline]
>>>             btrfs_do_write_iter+0x584/0x10c0 fs/btrfs/file.c:1705
>>>             new_sync_write fs/read_write.c:497 [inline]
>>>             vfs_write+0x6b6/0x1140 fs/read_write.c:590
>>>             ksys_write+0x12f/0x260 fs/read_write.c:643
>>>             do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>>>             __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:38=
6
>>>             do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>>>             entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>>>
>>>      -> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
>>>             join_transaction+0x164/0xf40 fs/btrfs/transaction.c:315
>>>             start_transaction+0x427/0x1a70 fs/btrfs/transaction.c:700
>>>             btrfs_commit_super+0xa1/0x110 fs/btrfs/disk-io.c:4170
>>>             close_ctree+0xcb0/0xf90 fs/btrfs/disk-io.c:4324
>>>             generic_shutdown_super+0x159/0x3d0 fs/super.c:642
>>>             kill_anon_super+0x3a/0x60 fs/super.c:1226
>>>             btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2096
>>>             deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
>>>             deactivate_super+0xde/0x100 fs/super.c:506
>>>             cleanup_mnt+0x222/0x450 fs/namespace.c:1267
>>>             task_work_run+0x14e/0x250 kernel/task_work.c:180
>>>             resume_user_mode_work include/linux/resume_user_mode.h:50 =
[inline]
>>>             exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>>>             exit_to_user_mode_prepare include/linux/entry-common.h:328=
 [inline]
>>>             __syscall_exit_to_user_mode_work kernel/entry/common.c:207=
 [inline]
>>>             syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.=
c:218
>>>             __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:38=
9
>>>             do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>>>             entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>>>
>>>      -> #1 (btrfs_trans_num_writers){++++}-{0:0}:
>>>             __lock_release kernel/locking/lockdep.c:5468 [inline]
>>>             lock_release+0x33e/0x6c0 kernel/locking/lockdep.c:5774
>>>             percpu_up_read include/linux/percpu-rwsem.h:99 [inline]
>>>             __sb_end_write include/linux/fs.h:1650 [inline]
>>>             sb_end_intwrite include/linux/fs.h:1767 [inline]
>>>             __btrfs_end_transaction+0x5ca/0x920 fs/btrfs/transaction.c=
:1071
>>>             btrfs_commit_inode_delayed_inode+0x228/0x330 fs/btrfs/dela=
yed-inode.c:1301
>>>             btrfs_evict_inode+0x960/0xe80 fs/btrfs/inode.c:5291
>>>             evict+0x2ed/0x6c0 fs/inode.c:667
>>>             iput_final fs/inode.c:1741 [inline]
>>>             iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
>>>             iput+0x5c/0x80 fs/inode.c:1757
>>>             dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
>>>             __dentry_kill+0x1d0/0x600 fs/dcache.c:603
>>>             dput.part.0+0x4b1/0x9b0 fs/dcache.c:845
>>>             dput+0x1f/0x30 fs/dcache.c:835
>>>             ovl_stack_put+0x60/0x90 fs/overlayfs/util.c:132
>>>             ovl_destroy_inode+0xc6/0x190 fs/overlayfs/super.c:182
>>>             destroy_inode+0xc4/0x1b0 fs/inode.c:311
>>>             iput_final fs/inode.c:1741 [inline]
>>>             iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
>>>             iput+0x5c/0x80 fs/inode.c:1757
>>>             dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
>>>             __dentry_kill+0x1d0/0x600 fs/dcache.c:603
>>>             shrink_kill fs/dcache.c:1048 [inline]
>>>             shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
>>>             prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
>>>             super_cache_scan+0x32a/0x550 fs/super.c:221
>>>             do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
>>>             shrink_slab_memcg mm/shrinker.c:548 [inline]
>>>             shrink_slab+0xa87/0x1310 mm/shrinker.c:626
>>>             shrink_one+0x493/0x7c0 mm/vmscan.c:4790
>>>             shrink_many mm/vmscan.c:4851 [inline]
>>>             lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
>>>             shrink_node mm/vmscan.c:5910 [inline]
>>>             kswapd_shrink_node mm/vmscan.c:6720 [inline]
>>>             balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
>>>             kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
>>>             kthread+0x2c1/0x3a0 kernel/kthread.c:389
>>>             ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>>>             ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>>
>>>      -> #0 (fs_reclaim){+.+.}-{0:0}:
>>>             check_prev_add kernel/locking/lockdep.c:3134 [inline]
>>>             check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>>>             validate_chain kernel/locking/lockdep.c:3869 [inline]
>>>             __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>>>             lock_acquire kernel/locking/lockdep.c:5754 [inline]
>>>             lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>>>             __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
>>>             fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
>>>             might_alloc include/linux/sched/mm.h:334 [inline]
>>>             slab_pre_alloc_hook mm/slub.c:3891 [inline]
>>>             slab_alloc_node mm/slub.c:3981 [inline]
>>>             kmem_cache_alloc_lru_noprof+0x58/0x2f0 mm/slub.c:4020
>>>             btrfs_alloc_inode+0x118/0xb20 fs/btrfs/inode.c:8411
>>>             alloc_inode+0x5d/0x230 fs/inode.c:261
>>>             iget5_locked fs/inode.c:1235 [inline]
>>>             iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
>>>             btrfs_iget_locked fs/btrfs/inode.c:5590 [inline]
>>>             btrfs_iget_path fs/btrfs/inode.c:5607 [inline]
>>>             btrfs_iget+0xfb/0x230 fs/btrfs/inode.c:5636
>>>             add_conflicting_inode fs/btrfs/tree-log.c:5657 [inline]
>>>             copy_inode_items_to_log+0x1039/0x1e30 fs/btrfs/tree-log.c:=
5928
>>>             btrfs_log_inode+0xa48/0x4660 fs/btrfs/tree-log.c:6592
>>>             log_new_delayed_dentries fs/btrfs/tree-log.c:6363 [inline]
>>>             btrfs_log_inode+0x27dd/0x4660 fs/btrfs/tree-log.c:6718
>>>             btrfs_log_all_parents fs/btrfs/tree-log.c:6833 [inline]
>>>             btrfs_log_inode_parent+0x22ba/0x2a90 fs/btrfs/tree-log.c:7=
141
>>>             btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7180
>>>             btrfs_sync_file+0x9c1/0xe10 fs/btrfs/file.c:1959
>>>             vfs_fsync_range+0x141/0x230 fs/sync.c:188
>>>             generic_write_sync include/linux/fs.h:2794 [inline]
>>>             btrfs_do_write_iter+0x584/0x10c0 fs/btrfs/file.c:1705
>>>             do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
>>>             vfs_writev+0x36f/0xde0 fs/read_write.c:971
>>>             do_pwritev+0x1b2/0x260 fs/read_write.c:1072
>>>             __do_compat_sys_pwritev2 fs/read_write.c:1218 [inline]
>>>             __se_compat_sys_pwritev2 fs/read_write.c:1210 [inline]
>>>             __ia32_compat_sys_pwritev2+0x121/0x1b0 fs/read_write.c:121=
0
>>>             do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>>>             __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:38=
6
>>>             do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>>>             entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>>>
>>>      other info that might help us debug this:
>>>
>>>      Chain exists of:
>>>        fs_reclaim --> btrfs_trans_num_extwriters --> &ei->log_mutex
>>>
>>>       Possible unsafe locking scenario:
>>>
>>>             CPU0                    CPU1
>>>             ----                    ----
>>>        lock(&ei->log_mutex);
>>>                                     lock(btrfs_trans_num_extwriters);
>>>                                     lock(&ei->log_mutex);
>>>        lock(fs_reclaim);
>>>
>>>       *** DEADLOCK ***
>>>
>>>      7 locks held by syz-executor.1/9919:
>>>       #0: ffff88802be20420 (sb_writers#23){.+.+}-{0:0}, at: do_pwritev=
+0x1b2/0x260 fs/read_write.c:1072
>>>       #1: ffff888065c0f8f0 (&sb->s_type->i_mutex_key#33){++++}-{3:3}, =
at: inode_lock include/linux/fs.h:791 [inline]
>>>       #1: ffff888065c0f8f0 (&sb->s_type->i_mutex_key#33){++++}-{3:3}, =
at: btrfs_inode_lock+0xc8/0x110 fs/btrfs/inode.c:385
>>>       #2: ffff888065c0f778 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_i=
node_lock+0xee/0x110 fs/btrfs/inode.c:388
>>>       #3: ffff88802be20610 (sb_internal#4){.+.+}-{0:0}, at: btrfs_sync=
_file+0x95b/0xe10 fs/btrfs/file.c:1952
>>>       #4: ffff8880546323f0 (btrfs_trans_num_writers){++++}-{0:0}, at: =
join_transaction+0x430/0xf40 fs/btrfs/transaction.c:290
>>>       #5: ffff888054632418 (btrfs_trans_num_extwriters){++++}-{0:0}, a=
t: join_transaction+0x430/0xf40 fs/btrfs/transaction.c:290
>>>       #6: ffff88804b569358 (&ei->log_mutex){+.+.}-{3:3}, at: btrfs_log=
_inode+0x39c/0x4660 fs/btrfs/tree-log.c:6481
>>>
>>>      stack backtrace:
>>>      CPU: 2 PID: 9919 Comm: syz-executor.1 Not tainted 6.10.0-rc2-syzk=
aller-00361-g061d1af7b030 #0
>>>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-d=
ebian-1.16.2-1 04/01/2014
>>>      Call Trace:
>>>       <TASK>
>>>       __dump_stack lib/dump_stack.c:88 [inline]
>>>       dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
>>>       check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
>>>       check_prev_add kernel/locking/lockdep.c:3134 [inline]
>>>       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>>>       validate_chain kernel/locking/lockdep.c:3869 [inline]
>>>       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>>>       lock_acquire kernel/locking/lockdep.c:5754 [inline]
>>>       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>>>       __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
>>>       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
>>>       might_alloc include/linux/sched/mm.h:334 [inline]
>>>       slab_pre_alloc_hook mm/slub.c:3891 [inline]
>>>       slab_alloc_node mm/slub.c:3981 [inline]
>>>       kmem_cache_alloc_lru_noprof+0x58/0x2f0 mm/slub.c:4020
>>>       btrfs_alloc_inode+0x118/0xb20 fs/btrfs/inode.c:8411
>>>       alloc_inode+0x5d/0x230 fs/inode.c:261
>>>       iget5_locked fs/inode.c:1235 [inline]
>>>       iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
>>>       btrfs_iget_locked fs/btrfs/inode.c:5590 [inline]
>>>       btrfs_iget_path fs/btrfs/inode.c:5607 [inline]
>>>       btrfs_iget+0xfb/0x230 fs/btrfs/inode.c:5636
>>>       add_conflicting_inode fs/btrfs/tree-log.c:5657 [inline]
>>>       copy_inode_items_to_log+0x1039/0x1e30 fs/btrfs/tree-log.c:5928
>>>       btrfs_log_inode+0xa48/0x4660 fs/btrfs/tree-log.c:6592
>>>       log_new_delayed_dentries fs/btrfs/tree-log.c:6363 [inline]
>>>       btrfs_log_inode+0x27dd/0x4660 fs/btrfs/tree-log.c:6718
>>>       btrfs_log_all_parents fs/btrfs/tree-log.c:6833 [inline]
>>>       btrfs_log_inode_parent+0x22ba/0x2a90 fs/btrfs/tree-log.c:7141
>>>       btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7180
>>>       btrfs_sync_file+0x9c1/0xe10 fs/btrfs/file.c:1959
>>>       vfs_fsync_range+0x141/0x230 fs/sync.c:188
>>>       generic_write_sync include/linux/fs.h:2794 [inline]
>>>       btrfs_do_write_iter+0x584/0x10c0 fs/btrfs/file.c:1705
>>>       do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
>>>       vfs_writev+0x36f/0xde0 fs/read_write.c:971
>>>       do_pwritev+0x1b2/0x260 fs/read_write.c:1072
>>>       __do_compat_sys_pwritev2 fs/read_write.c:1218 [inline]
>>>       __se_compat_sys_pwritev2 fs/read_write.c:1210 [inline]
>>>       __ia32_compat_sys_pwritev2+0x121/0x1b0 fs/read_write.c:1210
>>>       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>>>       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>>>       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>>>       entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>>>      RIP: 0023:0xf7334579
>>>      Code: b8 01 10 06 03 (...)
>>>      RSP: 002b:00000000f5f265ac EFLAGS: 00000292 ORIG_RAX: 00000000000=
0017b
>>>      RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000200002c0
>>>      RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
>>>      RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>>>      R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
>>>      R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>>       </TASK>
>>>
>>> Fix this by ensuring we are under a NOFS scope whenever we call
>>> btrfs_iget() during inode logging and log replay.
>>>
>>> Reported-by: syzbot+8576cfa84070dce4d59b@syzkaller.appspotmail.com
>>> Link: https://lore.kernel.org/linux-btrfs/000000000000274a3a061abbd928=
@google.com/
>>> Fixes: 712e36c5f2a7 ("btrfs: use GFP_KERNEL in btrfs_alloc_inode")
>>
>> I'm wondering if logging is the only location where we can trigger the
>> deadlock.
>>
>> Would regular inode_get() causing such deadlock?
>
> What is inode_get()? I can't find anything with that exact name.

My bad, I mean iget().

>
> If it's some path with a transaction handle open that can trigger
> btrfs_alloc_inode() then yes, otherwise it depends on what locks are
> held if any.
>

Then would it be safer to revert the offending commit, aka make
btrfs_alloc_inode() to use the old GFP_NOFS?

I just checked ext4_alloc_inode() and f2fs_alloc_inode(), both are still
using NOFS instead.

Thus I'm wondering if it's really a good idea to go GFP_KERNEL in the
first place.

Thanks,
Qu

