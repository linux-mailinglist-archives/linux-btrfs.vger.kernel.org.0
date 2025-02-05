Return-Path: <linux-btrfs+bounces-11299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FDFA2983B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 19:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80C147A25BC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62B91FCCE2;
	Wed,  5 Feb 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXgB+i6A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E247083A
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778407; cv=none; b=HxEi9U0NsjDKVLsKpmzhcZNq4ubIJfTvVm73gMiqL6Bis4yBIERzp0cDICK1sRn+6Ihc3c4wdzzKkellcqzQ27Fu7LG9C+XhGo1usE+7MFQsJDojfr1wkAv8HEdODD0tZcEl+W1cn3Rz591DZMxhbM7myB+iW/TU15Idw/hBvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778407; c=relaxed/simple;
	bh=8HJ6iKxElLK6z9kjKDjDdzBRgZCladP+oiD7rgboxaw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZCfG15SgAuxwPKyAtm7kxQei9lvxuLLyjXocu0W+zASbT1cS1ptQdkb450ZnOb3qgm/miH4Bx9vNWNubrjgrxK9cujaFN463KbksKz445xvNrx0bywEmV6F6TykOh2Dh1rfZ7VxIoUjBK19yqxPFYSadb2MqiCR/xNoZ1RCn7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXgB+i6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79E8C4CED1
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738778406;
	bh=8HJ6iKxElLK6z9kjKDjDdzBRgZCladP+oiD7rgboxaw=;
	h=From:To:Subject:Date:From;
	b=iXgB+i6AI4L+qZhEIf1UfvzKxhWwp94XPqzZkvRXpVVnxtKXC1imRKHCkMkgR52sZ
	 zY/G+85w5OiQlpgrfqlY/3e2q8RrocVbxdFEcga5lalFhMFpkwgVkwF9jFvSYbb3k5
	 rVUbGdbwhL+RxIq5y4KQkfUr1ZUpOTPH5l6rWlM1iQ3RQjFOOXBvsqZ0JDWE6hrXiy
	 3pDWhoVOlC6vK3hA7PEfa9rawiovDpMN0k1k5Z38Gddjgva236QqJgAKltz0UbO90s
	 qbkyaf80/67LJxEP1ABY1CZp9S0mfMyuL/BJAeEkzkC2NrlmSY3Hd+lh7jSULjW5QO
	 +manKDY5BpKOA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix hole expansion when writing at an offset beyond eof
Date: Wed,  5 Feb 2025 18:00:03 +0000
Message-Id: <974b00afc2e703d5e0085fefbb46a1e495956ae1.1738778225.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_write_check() if our file's i_size is not sector size aligned and
we have a write that starts at an offset larger than the i_size that falls
within the same page of the i_size, then we end up not zeroing the file
range [i_size, write_offset).

The code is this:

    start_pos = round_down(pos, fs_info->sectorsize);
    oldsize = i_size_read(inode);
    if (start_pos > oldsize) {
        /* Expand hole size to cover write data, preventing empty gap */
        loff_t end_pos = round_up(pos + count, fs_info->sectorsize);

        ret = btrfs_cont_expand(BTRFS_I(inode), oldsize, end_pos);
        if (ret)
            return ret;
    }

So if our file's i_size is 90269 bytes and a write at offset 90365 bytes
comes in, we get 'start_pos' set to 90112 bytes, which is less than the
i_size and therefore we don't zero out the range [90269, 90365) by
calling btrfs_cont_expand().

This is an old bug introduced in commit 9036c10208e1 ("Btrfs: update hole
handling v2"), from 2008, and the buggy code got moved around over the
years.

Fix this by discarding 'start_pos' and comparing against the write offset
('pos') without any alignment.

This bug was recently exposed by test case generic/363 which tests this
scenario by polluting ranges beyond eof with a mmap write and than verify
that after a file increases we get zeroes for the range which is supposed
to be a hole and not what we wrote with the previous mmaped write.

We're only seeing this exposed now because generic/363 used to run only
on xfs until last Sunday's fstests update.

The test was failing like this:

   $ ./check generic/363
   FSTYP         -- btrfs
   PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc7-btrfs-next-185+ #17 SMP PREEMPT_DYNAMIC Mon Feb  3 12:28:46 WET 2025
   MKFS_OPTIONS  -- /dev/sdc
   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

   generic/363 0s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/363.out.bad)
       --- tests/generic/363.out	2025-02-05 15:31:14.013646509 +0000
       +++ /home/fdmanana/git/hub/xfstests/results//generic/363.out.bad	2025-02-05 17:25:33.112630781 +0000
       @@ -1 +1,46 @@
        QA output created by 363
       +READ BAD DATA: offset = 0xdcad, size = 0xd921, fname = /home/fdmanana/btrfs-tests/dev/junk
       +OFFSET      GOOD    BAD     RANGE
       +0x1609d     0x0000  0x3104  0x0
       +operation# (mod 256) for the bad data may be 4
       +0x1609e     0x0000  0x0472  0x1
       +operation# (mod 256) for the bad data may be 4
       ...
       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/363.out /home/fdmanana/git/hub/xfstests/results//generic/363.out.bad'  to see the entire diff)
   Ran: generic/363
   Failures: generic/363
   Failed 1 of 1 tests

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 36f51c311bb1..ed3c0d6546c5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1039,7 +1039,6 @@ int btrfs_write_check(struct kiocb *iocb, size_t count)
 	loff_t pos = iocb->ki_pos;
 	int ret;
 	loff_t oldsize;
-	loff_t start_pos;
 
 	/*
 	 * Quickly bail out on NOWAIT writes if we don't have the nodatacow or
@@ -1066,9 +1065,8 @@ int btrfs_write_check(struct kiocb *iocb, size_t count)
 		inode_inc_iversion(inode);
 	}
 
-	start_pos = round_down(pos, fs_info->sectorsize);
 	oldsize = i_size_read(inode);
-	if (start_pos > oldsize) {
+	if (pos > oldsize) {
 		/* Expand hole size to cover write data, preventing empty gap */
 		loff_t end_pos = round_up(pos + count, fs_info->sectorsize);
 
-- 
2.45.2


