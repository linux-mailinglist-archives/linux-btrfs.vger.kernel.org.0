Return-Path: <linux-btrfs+bounces-5723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DBC907E3B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 23:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D32B25E7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 21:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6EB14374D;
	Thu, 13 Jun 2024 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Sa8rpZ6L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A1A71747
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314646; cv=none; b=Y563Hokzi9zasM21OObsmaLZ1HRKEJMXWnWYVggId7yN6PQ4utIgAhItcCeBisYZ/aMhZ14mzkmMt5hkgvPFgPQ8n60RnohFrqWi7E4Hb6V8e4Bwwvf5HB9GQGt4YEhzqZguVZmP+KWawj48PIUBnDsJ9y3wG+vIZb2LUln56Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314646; c=relaxed/simple;
	bh=WixtBSs1bQwRKqGS7i0A+iSqo8JspUYrCTCZ+41+yN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m2oCY60HxL3y6KUS5bnYyMQrhrisHK7DBBCczPeRLFEWNEAQ9zOPgy5VqRpMjmLJkElGYW1Hx5qFm1uuH5IHnddEqqrcYPtCqV0YH3a8Mz4+K++KGfYdG6UNFDDxJmVmi8h6anwwrfInoFPPeUBQ62IsoWbA0LWkdNUshMtyFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Sa8rpZ6L; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718314635; x=1718919435; i=quwenruo.btrfs@gmx.com;
	bh=o0O/E8o4lTiWw/C4LnqK9ucXZWbjf0SZIMtREZw39/0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sa8rpZ6LJ5bMWDLYGpJoinv6OEv072wuy/V0WgK4HAm/2T7QUvg15xT4Nl3hZld7
	 l0oT2SYfGapy/K4sR1TULA0WOhY+9MTfTldIEj8/Jq2BwYs3rOaOvBhiM6p63PIOY
	 1n3OycWDv7cgAA+7boGhXfSdf3EUihteqhollZbKxsxQw3LNzBx/De76GiIO+AcyG
	 lHG1GK7jZrBZm2/5V+71V//xj4eGmSqWgIlg3MHqESar1NLC61VwQ9oavVmmVM4If
	 ycvCvOis+LOT0nDR1LuYvwd5kXdPd4KH11gRkYQyPMD+9i0/JWRSEEZpUla00rrOH
	 VIkS3y/1MNwu+cDaWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6sn1-1sTCWj2gcp-015A4F; Thu, 13
 Jun 2024 23:37:15 +0200
Message-ID: <04f49180-cdb0-4665-abe4-136dbc85fbb3@gmx.com>
Date: Fri, 14 Jun 2024 07:07:10 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] btrfs: use NOFS context when getting inodes during
 logging and log replay
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1718276261.git.fdmanana@suse.com>
 <818b41faf6260be972ffa3bd436dda518963384b.1718276261.git.fdmanana@suse.com>
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
In-Reply-To: <818b41faf6260be972ffa3bd436dda518963384b.1718276261.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ptTwqv5M4VyedIRQhFh61XJVuYR5zwP2O8UCD1mYj1lmaB11GLm
 13LxrED4aWDanrEmU3ZLlxrXI6TMJT8dYdzLhEnpZFbRc8GzFf6TcXCp0dNr4H9YDyPHp1U
 h2sYV5P6NeOOeTQP9R4gdansmWIqfEF7shhmIcXvobU+HkptUTLFzyBqcl6WXUzoNzy7yX7
 k9SZYRStoEXWGFUy0NPrw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3zfEgtk7LY4=;Q1WVcfSqj4jUdpAAPw88PtAgyKB
 u50AJ5o6zq7i1XYIExfxT+2cEhVIC68nkLcEwjzN5tYMLko08HhXkjXrse3scRpMQvMhx4Ex6
 wfEzxO11y8nyE3FxJsOcjLTDmArlT4UEG0mzlE1MI3bobanh3FT1jPNMAWfGjZpW3lLF2lEI/
 7FAA+Q9CU38cF0b7RLZ5H6rnoDLICTuhmk24BDC33dhHjNxcK2HNEuxZt43WiFMrB2GtMdlG5
 FseUrtdKi/zBnHPLuvH5RnhtA1cOxiNnHOaGiE6FPT+PW+JZLbMv9asUn5WicPj3iHtVuwWCW
 tWmsnFwIGsSQpUjVekfB8oM89tYTtWz9D0JAU65mEsXs/0XV6b48ucwh03WsSvF5+ng3Az+G5
 81yYhtfbPFHVibW8/HauXuApdDu+qdf+6D1qRF7WOdXvsJ5sDwNMz3d9V4RLzTBzQ4spLpCoK
 Xsap3ajCcvd7i7qAGSnyDOFD5f1D17d84Tk0ShKPqOTYgQQVpMedp8oekY/OuyHvN/eF6jptt
 agfGXy/9VUBSI7Z7ruSULyEff/39hP2q1XmGyFwsteYJYX32jBjGXheiHG257VQ0vtY1y4QLb
 Bn/Q13u3OfiHlRUHYSrFS9frd674ePbxZELflocHodIOZGVY+OK8QlZJ3jh8jXdnr8jIHS5ad
 VnyPmiP4a3GFBpQVzSUSvjB87AnmC/ISCQdhJQwhQOq+rbmiEva38FvXIAcwYtJnGFK5hZ95V
 7ti9ZAGCWWtPGciM+FSa0Ciu0VYezinL5YG/NDxN5M1wHjbgWH50caJkMNiSyhDoDmJO0swJP
 jPJB+X1Q1F4kcqsI9LzOoq2OsB3PuWB/Q1YJc1l01G+Ng=



=E5=9C=A8 2024/6/13 20:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> During inode logging (and log replay too), we are holding a transaction
> handle and we often need to call btrfs_iget(), which will read an inode
> from its subvolume btree if it's not loaded in memory and that results i=
n
> allocating an inode with GFP_KERNEL semantics at the btrfs_alloc_inode()
> callback - and this may recurse into the filesystem in case we are under
> memory pressure and attempt to commit the current transaction, resulting
> in a deadlock since the logging (or log replay) task is holding a
> transaction handle open.
>
> Syzbot reported this with the following stack traces:
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>     WARNING: possible circular locking dependency detected
>     6.10.0-rc2-syzkaller-00361-g061d1af7b030 #0 Not tainted
>     ------------------------------------------------------
>     syz-executor.1/9919 is trying to acquire lock:
>     ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/l=
inux/sched/mm.h:334 [inline]
>     ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook m=
m/slub.c:3891 [inline]
>     ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/sl=
ub.c:3981 [inline]
>     ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_lru_=
noprof+0x58/0x2f0 mm/slub.c:4020
>
>     but task is already holding lock:
>     ffff88804b569358 (&ei->log_mutex){+.+.}-{3:3}, at: btrfs_log_inode+0=
x39c/0x4660 fs/btrfs/tree-log.c:6481
>
>     which lock already depends on the new lock.
>
>     the existing dependency chain (in reverse order) is:
>
>     -> #3 (&ei->log_mutex){+.+.}-{3:3}:
>            __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>            __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
>            btrfs_log_inode+0x39c/0x4660 fs/btrfs/tree-log.c:6481
>            btrfs_log_inode_parent+0x8cb/0x2a90 fs/btrfs/tree-log.c:7079
>            btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7180
>            btrfs_sync_file+0x9c1/0xe10 fs/btrfs/file.c:1959
>            vfs_fsync_range+0x141/0x230 fs/sync.c:188
>            generic_write_sync include/linux/fs.h:2794 [inline]
>            btrfs_do_write_iter+0x584/0x10c0 fs/btrfs/file.c:1705
>            new_sync_write fs/read_write.c:497 [inline]
>            vfs_write+0x6b6/0x1140 fs/read_write.c:590
>            ksys_write+0x12f/0x260 fs/read_write.c:643
>            do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>            __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>            do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>            entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>
>     -> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
>            join_transaction+0x164/0xf40 fs/btrfs/transaction.c:315
>            start_transaction+0x427/0x1a70 fs/btrfs/transaction.c:700
>            btrfs_commit_super+0xa1/0x110 fs/btrfs/disk-io.c:4170
>            close_ctree+0xcb0/0xf90 fs/btrfs/disk-io.c:4324
>            generic_shutdown_super+0x159/0x3d0 fs/super.c:642
>            kill_anon_super+0x3a/0x60 fs/super.c:1226
>            btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2096
>            deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
>            deactivate_super+0xde/0x100 fs/super.c:506
>            cleanup_mnt+0x222/0x450 fs/namespace.c:1267
>            task_work_run+0x14e/0x250 kernel/task_work.c:180
>            resume_user_mode_work include/linux/resume_user_mode.h:50 [in=
line]
>            exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>            exit_to_user_mode_prepare include/linux/entry-common.h:328 [i=
nline]
>            __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [i=
nline]
>            syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:2=
18
>            __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
>            do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>            entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>
>     -> #1 (btrfs_trans_num_writers){++++}-{0:0}:
>            __lock_release kernel/locking/lockdep.c:5468 [inline]
>            lock_release+0x33e/0x6c0 kernel/locking/lockdep.c:5774
>            percpu_up_read include/linux/percpu-rwsem.h:99 [inline]
>            __sb_end_write include/linux/fs.h:1650 [inline]
>            sb_end_intwrite include/linux/fs.h:1767 [inline]
>            __btrfs_end_transaction+0x5ca/0x920 fs/btrfs/transaction.c:10=
71
>            btrfs_commit_inode_delayed_inode+0x228/0x330 fs/btrfs/delayed=
-inode.c:1301
>            btrfs_evict_inode+0x960/0xe80 fs/btrfs/inode.c:5291
>            evict+0x2ed/0x6c0 fs/inode.c:667
>            iput_final fs/inode.c:1741 [inline]
>            iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
>            iput+0x5c/0x80 fs/inode.c:1757
>            dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
>            __dentry_kill+0x1d0/0x600 fs/dcache.c:603
>            dput.part.0+0x4b1/0x9b0 fs/dcache.c:845
>            dput+0x1f/0x30 fs/dcache.c:835
>            ovl_stack_put+0x60/0x90 fs/overlayfs/util.c:132
>            ovl_destroy_inode+0xc6/0x190 fs/overlayfs/super.c:182
>            destroy_inode+0xc4/0x1b0 fs/inode.c:311
>            iput_final fs/inode.c:1741 [inline]
>            iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
>            iput+0x5c/0x80 fs/inode.c:1757
>            dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
>            __dentry_kill+0x1d0/0x600 fs/dcache.c:603
>            shrink_kill fs/dcache.c:1048 [inline]
>            shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
>            prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
>            super_cache_scan+0x32a/0x550 fs/super.c:221
>            do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
>            shrink_slab_memcg mm/shrinker.c:548 [inline]
>            shrink_slab+0xa87/0x1310 mm/shrinker.c:626
>            shrink_one+0x493/0x7c0 mm/vmscan.c:4790
>            shrink_many mm/vmscan.c:4851 [inline]
>            lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
>            shrink_node mm/vmscan.c:5910 [inline]
>            kswapd_shrink_node mm/vmscan.c:6720 [inline]
>            balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
>            kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
>            kthread+0x2c1/0x3a0 kernel/kthread.c:389
>            ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>            ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
>     -> #0 (fs_reclaim){+.+.}-{0:0}:
>            check_prev_add kernel/locking/lockdep.c:3134 [inline]
>            check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>            validate_chain kernel/locking/lockdep.c:3869 [inline]
>            __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>            lock_acquire kernel/locking/lockdep.c:5754 [inline]
>            lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>            __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
>            fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
>            might_alloc include/linux/sched/mm.h:334 [inline]
>            slab_pre_alloc_hook mm/slub.c:3891 [inline]
>            slab_alloc_node mm/slub.c:3981 [inline]
>            kmem_cache_alloc_lru_noprof+0x58/0x2f0 mm/slub.c:4020
>            btrfs_alloc_inode+0x118/0xb20 fs/btrfs/inode.c:8411
>            alloc_inode+0x5d/0x230 fs/inode.c:261
>            iget5_locked fs/inode.c:1235 [inline]
>            iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
>            btrfs_iget_locked fs/btrfs/inode.c:5590 [inline]
>            btrfs_iget_path fs/btrfs/inode.c:5607 [inline]
>            btrfs_iget+0xfb/0x230 fs/btrfs/inode.c:5636
>            add_conflicting_inode fs/btrfs/tree-log.c:5657 [inline]
>            copy_inode_items_to_log+0x1039/0x1e30 fs/btrfs/tree-log.c:592=
8
>            btrfs_log_inode+0xa48/0x4660 fs/btrfs/tree-log.c:6592
>            log_new_delayed_dentries fs/btrfs/tree-log.c:6363 [inline]
>            btrfs_log_inode+0x27dd/0x4660 fs/btrfs/tree-log.c:6718
>            btrfs_log_all_parents fs/btrfs/tree-log.c:6833 [inline]
>            btrfs_log_inode_parent+0x22ba/0x2a90 fs/btrfs/tree-log.c:7141
>            btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7180
>            btrfs_sync_file+0x9c1/0xe10 fs/btrfs/file.c:1959
>            vfs_fsync_range+0x141/0x230 fs/sync.c:188
>            generic_write_sync include/linux/fs.h:2794 [inline]
>            btrfs_do_write_iter+0x584/0x10c0 fs/btrfs/file.c:1705
>            do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
>            vfs_writev+0x36f/0xde0 fs/read_write.c:971
>            do_pwritev+0x1b2/0x260 fs/read_write.c:1072
>            __do_compat_sys_pwritev2 fs/read_write.c:1218 [inline]
>            __se_compat_sys_pwritev2 fs/read_write.c:1210 [inline]
>            __ia32_compat_sys_pwritev2+0x121/0x1b0 fs/read_write.c:1210
>            do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>            __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>            do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>            entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>
>     other info that might help us debug this:
>
>     Chain exists of:
>       fs_reclaim --> btrfs_trans_num_extwriters --> &ei->log_mutex
>
>      Possible unsafe locking scenario:
>
>            CPU0                    CPU1
>            ----                    ----
>       lock(&ei->log_mutex);
>                                    lock(btrfs_trans_num_extwriters);
>                                    lock(&ei->log_mutex);
>       lock(fs_reclaim);
>
>      *** DEADLOCK ***
>
>     7 locks held by syz-executor.1/9919:
>      #0: ffff88802be20420 (sb_writers#23){.+.+}-{0:0}, at: do_pwritev+0x=
1b2/0x260 fs/read_write.c:1072
>      #1: ffff888065c0f8f0 (&sb->s_type->i_mutex_key#33){++++}-{3:3}, at:=
 inode_lock include/linux/fs.h:791 [inline]
>      #1: ffff888065c0f8f0 (&sb->s_type->i_mutex_key#33){++++}-{3:3}, at:=
 btrfs_inode_lock+0xc8/0x110 fs/btrfs/inode.c:385
>      #2: ffff888065c0f778 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_inod=
e_lock+0xee/0x110 fs/btrfs/inode.c:388
>      #3: ffff88802be20610 (sb_internal#4){.+.+}-{0:0}, at: btrfs_sync_fi=
le+0x95b/0xe10 fs/btrfs/file.c:1952
>      #4: ffff8880546323f0 (btrfs_trans_num_writers){++++}-{0:0}, at: joi=
n_transaction+0x430/0xf40 fs/btrfs/transaction.c:290
>      #5: ffff888054632418 (btrfs_trans_num_extwriters){++++}-{0:0}, at: =
join_transaction+0x430/0xf40 fs/btrfs/transaction.c:290
>      #6: ffff88804b569358 (&ei->log_mutex){+.+.}-{3:3}, at: btrfs_log_in=
ode+0x39c/0x4660 fs/btrfs/tree-log.c:6481
>
>     stack backtrace:
>     CPU: 2 PID: 9919 Comm: syz-executor.1 Not tainted 6.10.0-rc2-syzkall=
er-00361-g061d1af7b030 #0
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debi=
an-1.16.2-1 04/01/2014
>     Call Trace:
>      <TASK>
>      __dump_stack lib/dump_stack.c:88 [inline]
>      dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
>      check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
>      check_prev_add kernel/locking/lockdep.c:3134 [inline]
>      check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>      validate_chain kernel/locking/lockdep.c:3869 [inline]
>      __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>      lock_acquire kernel/locking/lockdep.c:5754 [inline]
>      lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>      __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
>      fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
>      might_alloc include/linux/sched/mm.h:334 [inline]
>      slab_pre_alloc_hook mm/slub.c:3891 [inline]
>      slab_alloc_node mm/slub.c:3981 [inline]
>      kmem_cache_alloc_lru_noprof+0x58/0x2f0 mm/slub.c:4020
>      btrfs_alloc_inode+0x118/0xb20 fs/btrfs/inode.c:8411
>      alloc_inode+0x5d/0x230 fs/inode.c:261
>      iget5_locked fs/inode.c:1235 [inline]
>      iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
>      btrfs_iget_locked fs/btrfs/inode.c:5590 [inline]
>      btrfs_iget_path fs/btrfs/inode.c:5607 [inline]
>      btrfs_iget+0xfb/0x230 fs/btrfs/inode.c:5636
>      add_conflicting_inode fs/btrfs/tree-log.c:5657 [inline]
>      copy_inode_items_to_log+0x1039/0x1e30 fs/btrfs/tree-log.c:5928
>      btrfs_log_inode+0xa48/0x4660 fs/btrfs/tree-log.c:6592
>      log_new_delayed_dentries fs/btrfs/tree-log.c:6363 [inline]
>      btrfs_log_inode+0x27dd/0x4660 fs/btrfs/tree-log.c:6718
>      btrfs_log_all_parents fs/btrfs/tree-log.c:6833 [inline]
>      btrfs_log_inode_parent+0x22ba/0x2a90 fs/btrfs/tree-log.c:7141
>      btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7180
>      btrfs_sync_file+0x9c1/0xe10 fs/btrfs/file.c:1959
>      vfs_fsync_range+0x141/0x230 fs/sync.c:188
>      generic_write_sync include/linux/fs.h:2794 [inline]
>      btrfs_do_write_iter+0x584/0x10c0 fs/btrfs/file.c:1705
>      do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
>      vfs_writev+0x36f/0xde0 fs/read_write.c:971
>      do_pwritev+0x1b2/0x260 fs/read_write.c:1072
>      __do_compat_sys_pwritev2 fs/read_write.c:1218 [inline]
>      __se_compat_sys_pwritev2 fs/read_write.c:1210 [inline]
>      __ia32_compat_sys_pwritev2+0x121/0x1b0 fs/read_write.c:1210
>      do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>      __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>      do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>      entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>     RIP: 0023:0xf7334579
>     Code: b8 01 10 06 03 (...)
>     RSP: 002b:00000000f5f265ac EFLAGS: 00000292 ORIG_RAX: 00000000000001=
7b
>     RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000200002c0
>     RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
>     RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>     R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
>     R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>      </TASK>
>
> Fix this by ensuring we are under a NOFS scope whenever we call
> btrfs_iget() during inode logging and log replay.
>
> Reported-by: syzbot+8576cfa84070dce4d59b@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/000000000000274a3a061abbd928@g=
oogle.com/
> Fixes: 712e36c5f2a7 ("btrfs: use GFP_KERNEL in btrfs_alloc_inode")

I'm wondering if logging is the only location where we can trigger the
deadlock.

Would regular inode_get() causing such deadlock?

Otherwise the patch looks good to me.

Thanks,
Qu

> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/tree-log.c | 43 ++++++++++++++++++++++++++++---------------
>   1 file changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 6d892d76d4fb..4c9cc8eecb30 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -138,6 +138,25 @@ static void wait_log_commit(struct btrfs_root *root=
, int transid);
>    * and once to do all the other items.
>    */
>
> +static struct inode *btrfs_iget_logging(u64 objectid, struct btrfs_root=
 *root)
> +{
> +	unsigned int nofs_flag;
> +	struct inode *inode;
> +
> +	/*
> +	 * We're holding a transaction handle whether we are logging or
> +	 * replaying a log tree, so we must make sure NOFS semantics apply
> +	 * because btrfs_alloc_inode() may be triggered and it uses GFP_KERNEL
> +	 * to allocate an inode, which can recurse back into the filesystem an=
d
> +	 * attempt a transaction commit, resulting in a deadlock.
> +	 */
> +	nofs_flag =3D memalloc_nofs_save();
> +	inode =3D btrfs_iget(root->fs_info->sb, objectid, root);
> +	memalloc_nofs_restore(nofs_flag);
> +
> +	return inode;
> +}
> +
>   /*
>    * start a sub transaction and setup the log tree
>    * this increments the log tree writer count to make the people
> @@ -600,7 +619,7 @@ static noinline struct inode *read_one_inode(struct =
btrfs_root *root,
>   {
>   	struct inode *inode;
>
> -	inode =3D btrfs_iget(root->fs_info->sb, objectid, root);
> +	inode =3D btrfs_iget_logging(objectid, root);
>   	if (IS_ERR(inode))
>   		inode =3D NULL;
>   	return inode;
> @@ -5443,7 +5462,6 @@ static int log_new_dir_dentries(struct btrfs_trans=
_handle *trans,
>   				struct btrfs_log_ctx *ctx)
>   {
>   	struct btrfs_root *root =3D start_inode->root;
> -	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	struct btrfs_path *path;
>   	LIST_HEAD(dir_list);
>   	struct btrfs_dir_list *dir_elem;
> @@ -5504,7 +5522,7 @@ static int log_new_dir_dentries(struct btrfs_trans=
_handle *trans,
>   				continue;
>
>   			btrfs_release_path(path);
> -			di_inode =3D btrfs_iget(fs_info->sb, di_key.objectid, root);
> +			di_inode =3D btrfs_iget_logging(di_key.objectid, root);
>   			if (IS_ERR(di_inode)) {
>   				ret =3D PTR_ERR(di_inode);
>   				goto out;
> @@ -5564,7 +5582,7 @@ static int log_new_dir_dentries(struct btrfs_trans=
_handle *trans,
>   		btrfs_add_delayed_iput(curr_inode);
>   		curr_inode =3D NULL;
>
> -		vfs_inode =3D btrfs_iget(fs_info->sb, ino, root);
> +		vfs_inode =3D btrfs_iget_logging(ino, root);
>   		if (IS_ERR(vfs_inode)) {
>   			ret =3D PTR_ERR(vfs_inode);
>   			break;
> @@ -5659,7 +5677,7 @@ static int add_conflicting_inode(struct btrfs_tran=
s_handle *trans,
>   	if (ctx->num_conflict_inodes >=3D MAX_CONFLICT_INODES)
>   		return BTRFS_LOG_FORCE_COMMIT;
>
> -	inode =3D btrfs_iget(root->fs_info->sb, ino, root);
> +	inode =3D btrfs_iget_logging(ino, root);
>   	/*
>   	 * If the other inode that had a conflicting dir entry was deleted in
>   	 * the current transaction then we either:
> @@ -5760,7 +5778,6 @@ static int log_conflicting_inodes(struct btrfs_tra=
ns_handle *trans,
>   				  struct btrfs_root *root,
>   				  struct btrfs_log_ctx *ctx)
>   {
> -	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	int ret =3D 0;
>
>   	/*
> @@ -5791,7 +5808,7 @@ static int log_conflicting_inodes(struct btrfs_tra=
ns_handle *trans,
>   		list_del(&curr->list);
>   		kfree(curr);
>
> -		inode =3D btrfs_iget(fs_info->sb, ino, root);
> +		inode =3D btrfs_iget_logging(ino, root);
>   		/*
>   		 * If the other inode that had a conflicting dir entry was
>   		 * deleted in the current transaction, we need to log its parent
> @@ -5802,7 +5819,7 @@ static int log_conflicting_inodes(struct btrfs_tra=
ns_handle *trans,
>   			if (ret !=3D -ENOENT)
>   				break;
>
> -			inode =3D btrfs_iget(fs_info->sb, parent, root);
> +			inode =3D btrfs_iget_logging(parent, root);
>   			if (IS_ERR(inode)) {
>   				ret =3D PTR_ERR(inode);
>   				break;
> @@ -6324,7 +6341,6 @@ static int log_new_delayed_dentries(struct btrfs_t=
rans_handle *trans,
>   				    struct btrfs_log_ctx *ctx)
>   {
>   	const bool orig_log_new_dentries =3D ctx->log_new_dentries;
> -	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>   	struct btrfs_delayed_item *item;
>   	int ret =3D 0;
>
> @@ -6350,7 +6366,7 @@ static int log_new_delayed_dentries(struct btrfs_t=
rans_handle *trans,
>   		if (key.type =3D=3D BTRFS_ROOT_ITEM_KEY)
>   			continue;
>
> -		di_inode =3D btrfs_iget(fs_info->sb, key.objectid, inode->root);
> +		di_inode =3D btrfs_iget_logging(key.objectid, inode->root);
>   		if (IS_ERR(di_inode)) {
>   			ret =3D PTR_ERR(di_inode);
>   			break;
> @@ -6734,7 +6750,6 @@ static int btrfs_log_all_parents(struct btrfs_tran=
s_handle *trans,
>   				 struct btrfs_inode *inode,
>   				 struct btrfs_log_ctx *ctx)
>   {
> -	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>   	int ret;
>   	struct btrfs_path *path;
>   	struct btrfs_key key;
> @@ -6799,8 +6814,7 @@ static int btrfs_log_all_parents(struct btrfs_tran=
s_handle *trans,
>   				cur_offset =3D item_size;
>   			}
>
> -			dir_inode =3D btrfs_iget(fs_info->sb, inode_key.objectid,
> -					       root);
> +			dir_inode =3D btrfs_iget_logging(inode_key.objectid, root);
>   			/*
>   			 * If the parent inode was deleted, return an error to
>   			 * fallback to a transaction commit. This is to prevent
> @@ -6862,7 +6876,6 @@ static int log_new_ancestors(struct btrfs_trans_ha=
ndle *trans,
>   	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
>
>   	while (true) {
> -		struct btrfs_fs_info *fs_info =3D root->fs_info;
>   		struct extent_buffer *leaf;
>   		int slot;
>   		struct btrfs_key search_key;
> @@ -6877,7 +6890,7 @@ static int log_new_ancestors(struct btrfs_trans_ha=
ndle *trans,
>   		search_key.objectid =3D found_key.offset;
>   		search_key.type =3D BTRFS_INODE_ITEM_KEY;
>   		search_key.offset =3D 0;
> -		inode =3D btrfs_iget(fs_info->sb, ino, root);
> +		inode =3D btrfs_iget_logging(ino, root);
>   		if (IS_ERR(inode))
>   			return PTR_ERR(inode);
>

