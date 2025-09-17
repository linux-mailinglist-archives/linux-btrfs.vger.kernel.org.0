Return-Path: <linux-btrfs+bounces-16887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A63AB7D271
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F0F3BF7A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F57346A0D;
	Wed, 17 Sep 2025 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="sW/61vUw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B0274676;
	Wed, 17 Sep 2025 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102724; cv=none; b=kJiImC8Vy8LCLDW26mAqVLNCN3zTXDfpOA+MyA8tgxfSOvXLi1RjWqu+Ur8AtSfCygUFM32JERFivw+upq9cbw/akqo402sIuTEEJTKACGpkftb2CpOYHAtooM5/Kt5IU69lwefkBQXLgB2rcXwOD9DC/J2olBnW/a+NrBcpCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102724; c=relaxed/simple;
	bh=CqkSmY22reWJwLvbv91mw4eVE3WvCe5UpKSTu3Dy0/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mAod6OCyedqkTl1j5kMxTTuSkbIXhvVr5DKJAFhqRtURFfKZWjFgJKM0IdLb84Qt18ZEL8qkXmuUfwIE5X8cm/QR+ckAAt7a5/yiQLbbrggHKOU8VR7UsjNwaaKtLdMnRvFKnrp+LgfPS7aqfUV0ki2Y54VjZ2dkkltfjH6LzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=sW/61vUw; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1758102308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7I+wQC6r4aGT6IUipkDw6NXltnUcu+fPOmWjt4D3DIA=;
	b=sW/61vUwNpqq9vz6wmonAvMZxUq5uaM/YLhwd+vH4PWhU/3VTkH7gh6B3IVr39hxNDeE9P
	MZ+tMHd4icypTwQUZl1psfs7h3ukDuNAOt+xF1iii8/nOHnSSJaodtrpSTPDQKq0r0yYnd
	vo7fvQq/NmD6+AVvbyo1SFWYbGxdlBs=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 5.10] btrfs: free exchange changeset on failures
Date: Wed, 17 Sep 2025 12:45:06 +0300
Message-ID: <20250917094507.18690-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

commit da5e817d9d75422eaaa05490d0b9a5e328fc1a51 upstream.

Fstests runs on my VMs have show several kmemleak reports like the following.

  unreferenced object 0xffff88811ae59080 (size 64):
    comm "xfs_io", pid 12124, jiffies 4294987392 (age 6.368s)
    hex dump (first 32 bytes):
      00 c0 1c 00 00 00 00 00 ff cf 1c 00 00 00 00 00  ................
      90 97 e5 1a 81 88 ff ff 90 97 e5 1a 81 88 ff ff  ................
    backtrace:
      [<00000000ac0176d2>] ulist_add_merge+0x60/0x150 [btrfs]
      [<0000000076e9f312>] set_state_bits+0x86/0xc0 [btrfs]
      [<0000000014fe73d6>] set_extent_bit+0x270/0x690 [btrfs]
      [<000000004f675208>] set_record_extent_bits+0x19/0x20 [btrfs]
      [<00000000b96137b1>] qgroup_reserve_data+0x274/0x310 [btrfs]
      [<0000000057e9dcbb>] btrfs_check_data_free_space+0x5c/0xa0 [btrfs]
      [<0000000019c4511d>] btrfs_delalloc_reserve_space+0x1b/0xa0 [btrfs]
      [<000000006d37e007>] btrfs_dio_iomap_begin+0x415/0x970 [btrfs]
      [<00000000fb8a74b8>] iomap_iter+0x161/0x1e0
      [<0000000071dff6ff>] __iomap_dio_rw+0x1df/0x700
      [<000000002567ba53>] iomap_dio_rw+0x5/0x20
      [<0000000072e555f8>] btrfs_file_write_iter+0x290/0x530 [btrfs]
      [<000000005eb3d845>] new_sync_write+0x106/0x180
      [<000000003fb505bf>] vfs_write+0x24d/0x2f0
      [<000000009bb57d37>] __x64_sys_pwrite64+0x69/0xa0
      [<000000003eba3fdf>] do_syscall_64+0x43/0x90

In case brtfs_qgroup_reserve_data() or btrfs_delalloc_reserve_metadata()
fail the allocated extent_changeset will not be freed.

So in btrfs_check_data_free_space() and btrfs_delalloc_reserve_space()
free the allocated extent_changeset to get rid of the allocated memory.

The issue currently only happens in the direct IO write path, but only
after 65b3c08606e5 ("btrfs: fix ENOSPC failure when attempting direct IO
write into NOCOW range"), and also at defrag_one_locked_target(). Every
other place is always calling extent_changeset_free() even if its call
to btrfs_delalloc_reserve_space() or btrfs_check_data_free_space() has
failed.

CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Denis Arefev <arefev@swemel.ru>                                    
---
Backport fix for CVE-2021-47508
Link: https://nvd.nist.gov/vuln/detail/cve-2021-47508
---
 fs/btrfs/delalloc-space.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 45b2a5ecd63a..cd12226c3220 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -143,10 +143,13 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
 
 	/* Use new btrfs_qgroup_reserve_data to reserve precious data space. */
 	ret = btrfs_qgroup_reserve_data(inode, reserved, start, len);
-	if (ret < 0)
+	if (ret < 0) {
 		btrfs_free_reserved_data_space_noquota(fs_info, len);
-	else
+		extent_changeset_free(*reserved);
+		*reserved = NULL;
+	} else {
 		ret = 0;
+	}
 	return ret;
 }
 
@@ -446,8 +449,11 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 	if (ret < 0)
 		return ret;
 	ret = btrfs_delalloc_reserve_metadata(inode, len);
-	if (ret < 0)
+	if (ret < 0) {
 		btrfs_free_reserved_data_space(inode, *reserved, start, len);
+		extent_changeset_free(*reserved);
+		*reserved = NULL;
+	}
 	return ret;
 }
 
-- 
2.43.0


