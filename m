Return-Path: <linux-btrfs+bounces-18990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E05F4C5BDA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 08:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D938359758
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792642F6939;
	Fri, 14 Nov 2025 07:53:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m3268.qiye.163.com (mail-m3268.qiye.163.com [220.197.32.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4E2F6578
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763106811; cv=none; b=dcqcJBcNJTr4BYQAyLOkzYabFiLP059QDQtRYRnz+MGkXKYEpN1mTE2yN3hp+1ZTKVvU5Q9TwiHCrjINH+d+GsGStZKYGkcncESyer2yokBl9oIgVityv4VV09GgDe27APw35JC1N3HMeeePqCLxrdJyMV2gumLDL8ykATBJ6w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763106811; c=relaxed/simple;
	bh=6CAtTlcDc5w0htpqOa9BWHw405htGJNVuM0oziQ/PPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QD1k86SW8nGnYQVRpy7VMt0wLUTQ9vePXXi1yCZV+zEuSKa377l9Oq8IaxyoZuDdMZgfDaA4LZ6JfYSy9GhlS1WTqXY4n3Kebr9BelufB07KSil41Fb1Tkb45fRJ9aA2dzYtfQgf8gDDlwcHHse1DwjdMy0O1yR22nEyXS5zM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1311b7f6e;
	Fri, 14 Nov 2025 15:53:21 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] btrfs: fix incomplete parameter rename in btrfs_decompress
Date: Fri, 14 Nov 2025 15:53:13 +0800
Message-Id: <20251114075313.1944180-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a815ac8a50229kunm366e54bf210d58
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0waVhhMSBhKSR4eSU1MGFYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1
	VKQktLWQY+

Commit 2c25716dcc25 ("btrfs: zlib: fix and simplify the inline extent
decompression") renamed the 'start_byte' parameter to 'dest_pgoff' in
the btrfs_decompress(). The remaining 'start_byte' references are
inconsistent with the actual implementation and may cause confusion for
developers.

Ensure consistency between function declaration and implementation.

Fixes: 2c25716dcc25 ("btrfs: zlib: fix and simplify the inline extent decompression")
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 fs/btrfs/compression.c | 2 +-
 fs/btrfs/compression.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index bacad18357b3..1a5df3efcb4a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1100,7 +1100,7 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
 /*
  * a less complex decompression routine.  Our compressed data fits in a
  * single page, and we want to read a single page out of it.
- * start_byte tells us the offset into the compressed data we're interested in
+ * dest_pgoff tells us the offset into the destination folio where we write the decompressed data
  */
 int btrfs_decompress(int type, const u8 *data_in, struct folio *dest_folio,
 		     unsigned long dest_pgoff, size_t srclen, size_t destlen)
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index eba188a9e3bb..5726a6e469c3 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -100,7 +100,7 @@ int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inod
 			  u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out);
 int btrfs_decompress(int type, const u8 *data_in, struct folio *dest_folio,
-		     unsigned long start_byte, size_t srclen, size_t destlen);
+		     unsigned long dest_pgoff, size_t srclen, size_t destlen);
 int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 			      struct compressed_bio *cb, u32 decompressed);
 
-- 
2.20.1


