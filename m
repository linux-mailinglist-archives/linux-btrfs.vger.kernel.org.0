Return-Path: <linux-btrfs+bounces-14932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D06AE7384
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 01:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0503AA4E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 23:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F2D26B2DB;
	Tue, 24 Jun 2025 23:57:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E61BC9E2
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 23:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750809420; cv=none; b=ZrFJFDDZZYCnnCZHBQT129ahAW+OjVuir41RjbHJznB4b1tzj/2T+dWllWyPFrOZIlMwql+Bs8fSobi8hUpHWqMtLsY7OSbsW4NS+XfzC9yDW1e8seL0DISXhNQBgax3KIWsIRKprYj9NlU+EZ/jpUkwJO3kNS0p2bT4+CXsUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750809420; c=relaxed/simple;
	bh=O5+WlngkGtkcGqP+Q4X3hxjhKwjs2SwcJrPWro8a884=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHWTan1j/+MJURMmDw7rcAncWk2vmDpjfjvLoihh5Z9ha4jq30ukyME31l+RralX7HvEfjVz5JXXtPuAwlGjVMhmFI2oJnOoiZ4btNeYxVW6sRJUfoSv6prsp9K6bv2F+LPQL29C0k3U/sBlo+YDrAR+Q2pr/E30vcRgrGn2IdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 685B3B3D0000772E; Tue, 25 Jun 2025 07:56:47 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 125806292002
X-SMAIL-UIID: A16605F8C65C41F89C8959F9672E0F9D-20250625-075647-1
From: Hillf Danton <hdanton@sina.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH next] btrfs: fix deadlock in btrfs_read_chunk_tree
Date: Wed, 25 Jun 2025 07:56:33 +0800
Message-ID: <20250624235635.1661-1-hdanton@sina.com>
In-Reply-To: <2e81c9bf-64ea-4d6b-a771-1befd4c319c8@gmx.com>
References: <685aa401.050a0220.2303ee.0009.GAE@google.com> <tencent_C857B761776286CB137A836B096C03A34405@qq.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 25 Jun 2025 06:00:09 +0930 Qu Wenruo wrote:
> =E5=9C=A8 2025/6/25 00:00, Edward Adam Davis =E5=86=99=E9=81=93:
> > Remove the lock uuid_mutex outside of sget_fc() to avoid the deadlock
> > reported by [1].
> >=20
> > [1]
> > -> #1 (&type->s_umount_key#41/1){+.+.}-{4:4}:
> >         lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
> >         down_write_nested+0x9d/0x200 kernel/locking/rwsem.c:1693
> >         alloc_super+0x204/0x970 fs/super.c:345

Given kzalloc [3], the syzbot report is false positive (a known lockdep
issue) as nobody else should acquire s->s_umount lock.

[3] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/super.c?id=7aacdf6feed1#n319

> >         sget_fc+0x329/0xa40 fs/super.c:761
> >         btrfs_get_tree_super fs/btrfs/super.c:1867 [inline]
> >         btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
> >         btrfs_get_tree+0x4c6/0x12d0 fs/btrfs/super.c:2093
> >         vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
> >         do_new_mount+0x24a/0xa40 fs/namespace.c:3902
> >         do_mount fs/namespace.c:4239 [inline]
> >         __do_sys_mount fs/namespace.c:4450 [inline]
> >         __se_sys_mount+0x317/0x410 fs/namespace.c:4427
> >         do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >         do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >         entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >=20
> > -> #0 (uuid_mutex){+.+.}-{4:4}:
> >         check_prev_add kernel/locking/lockdep.c:3168 [inline]
> >         check_prevs_add kernel/locking/lockdep.c:3287 [inline]
> >         validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
> >         __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
> >         lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
> >         __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> >         __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
> >         btrfs_read_chunk_tree+0xef/0x2170 fs/btrfs/volumes.c:7462
> >         open_ctree+0x17f2/0x3a10 fs/btrfs/disk-io.c:3458
> >         btrfs_fill_super fs/btrfs/super.c:984 [inline]
> >         btrfs_get_tree_super fs/btrfs/super.c:1922 [inline]
> >         btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
> >         btrfs_get_tree+0xc6f/0x12d0 fs/btrfs/super.c:2093
> >         vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
> >         do_new_mount+0x24a/0xa40 fs/namespace.c:3902
> >         do_mount fs/namespace.c:4239 [inline]
> >         __do_sys_mount fs/namespace.c:4450 [inline]
> >         __se_sys_mount+0x317/0x410 fs/namespace.c:4427
> >         do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >         do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >         entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >=20
> > other info that might help us debug this:
> >=20
> >   Possible unsafe locking scenario:
> >=20
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(&type->s_umount_key#41/1);
> >                                 lock(uuid_mutex);
> >                                 lock(&type->s_umount_key#41/1);
> >    lock(uuid_mutex);
> >=20
> >   *** DEADLOCK ***
> >=20
> > Fixes: 7aacdf6feed1 ("btrfs: delay btrfs_open_devices() until super bloc=
> k is created")
> > Reported-by: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dfa90fcaa28f5cd4b1fc1
> > Tested-by: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >   fs/btrfs/super.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 237e60b53192..c2ce1eb53ad7 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -1864,11 +1864,10 @@ static int btrfs_get_tree_super(struct fs_contex=
> t *fc)
> >   	fs_devices =3D device->fs_devices;
> >   	fs_info->fs_devices =3D fs_devices;
> >  =20
> > +	mutex_unlock(&uuid_mutex);
> 
> No, you can not unlock uuid_mutex without opening the devices.
> 
> Just run the test case generic/604.
> 
> >   	sb =3D sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
> > -	if (IS_ERR(sb)) {
> > -		mutex_unlock(&uuid_mutex);
> > +	if (IS_ERR(sb))
> >   		return PTR_ERR(sb);
> > -	}
> >  =20
> >   	set_device_specific_options(fs_info);
> >  =20
> > @@ -1887,6 +1886,7 @@ static int btrfs_get_tree_super(struct fs_context =
> *fc)
> >   		 * But the fs_info->fs_devices is not opened, we should not let
> >   		 * btrfs_free_fs_context() to close them.
> >   		 */
> > +		mutex_lock(&uuid_mutex);
> >   		fs_info->fs_devices =3D NULL;
> >   		mutex_unlock(&uuid_mutex);
> >  =20
> > @@ -1906,6 +1906,7 @@ static int btrfs_get_tree_super(struct fs_context =
> *fc)
> >   		 */
> >   		ASSERT(fc->s_fs_info =3D=3D NULL);
> >  =20
> > +		mutex_lock(&uuid_mutex);
> >   		ret =3D btrfs_open_devices(fs_devices, mode, sb);
> >   		mutex_unlock(&uuid_mutex);
> >   		if (ret < 0) {

