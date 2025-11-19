Return-Path: <linux-btrfs+bounces-19156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486FC705E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 18:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE919381E06
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D086537031B;
	Wed, 19 Nov 2025 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvuOBHMU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03236CDFF
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571138; cv=none; b=p2OMNh1Rwgwyc9/6wiZVGWShOZ9EYAM8JEmrp4wgu83IVUEkrM/IqFs4wgoVa/iGJZ2Ce6+IFXNnkMJvnTl+jAI8gl03/TUC/bUgIbpptmHfXNoZXWOzoCvTE+R7GZpMqMwf9ZoPe3HxRJ7urUxpgf7L+pbyn2Vzr0jNNbrFRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571138; c=relaxed/simple;
	bh=NFSvjbnciuzlkA99YvDQHkEnPM3HnBzgFRGL2ojDW70=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kMBYW0S4Eghf1q3HAn6UWe09XRRWeWeJR8uJL2ML8K9MpCpOLRa8s90H/Rj5hGnTCYTUO1CqWXrxcmWDbG21EVZD0LRN+NLFjzeTngAHjIv74C1x2sSen378tUiExl6jBz3ucB+Z3sXo2QoN/w2WnREEi1uwAH5cy6BZWhD7ZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvuOBHMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DBBC16AAE
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 16:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763571137;
	bh=NFSvjbnciuzlkA99YvDQHkEnPM3HnBzgFRGL2ojDW70=;
	h=From:To:Subject:Date:From;
	b=GvuOBHMUcT9FuWj5ymylloF2sYOsoS4HxYmfmmdv7ku3JV+DIbjuOVKpKz7RoY0W1
	 9dsh6iLInNHQ9WB4cnRa/pLGYM6NGQ51RXBnTC8qs7V9wWCK11DGu+EqMlsNYVGV8N
	 cbDbKN0DZYTWfmpFDAaKUfz5aMHn3cEGqExSrHPgPpJRi3ZIA13YaMaRMHLuNnlAvW
	 nNp3GcIlHjwgxT8V44000xUL9tu0qgkXGzK3x/1A9pPOv4Y4Lf0OZPAiWbXlyyJARt
	 F2hWi1C2tVoR22MWC4ZO80hKMYUq1nFuqTfXpXkzlivN2QCRjR1QwqyNNDmdJvqI1V
	 Kq3CLs0hKhnAg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: add unlikely to all unexpected overflow checks
Date: Wed, 19 Nov 2025 16:52:14 +0000
Message-ID: <70cee567e5423a6c87196db3ff6622ef9b5c2ccb.1763570949.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There are several checks for unexpected overflows of buffers and path
lengths that makes us fail the send operation with an error if for some
highly unexpected reason they happen. So add the unlikely tag to those
checks to hint the compiler to generate better code, while also making
it more explicit in the source that it's highly unexpected.

With gcc 14.2.0-19 from Debian on x86_64, I also got a small reduction
the text size of the btrfs module.

Before:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1936917	 162723	  15592	2115232	 2046a0	fs/btrfs/btrfs.ko

After:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1936789	 162723	  15592	2115104	 204620	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3d437024e8bc..ebb5a74500f4 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1134,12 +1134,12 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
 
 		if (btrfs_dir_ftype(eb, di) == BTRFS_FT_XATTR) {
-			if (name_len > XATTR_NAME_MAX) {
+			if (unlikely(name_len > XATTR_NAME_MAX)) {
 				ret = -ENAMETOOLONG;
 				goto out;
 			}
-			if (name_len + data_len >
-					BTRFS_MAX_XATTR_SIZE(root->fs_info)) {
+			if (unlikely(name_len + data_len >
+				     BTRFS_MAX_XATTR_SIZE(root->fs_info))) {
 				ret = -E2BIG;
 				goto out;
 			}
@@ -1147,7 +1147,7 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 			/*
 			 * Path too long
 			 */
-			if (name_len + data_len > PATH_MAX) {
+			if (unlikely(name_len + data_len > PATH_MAX)) {
 				ret = -ENAMETOOLONG;
 				goto out;
 			}
@@ -5173,14 +5173,14 @@ static int put_data_header(struct send_ctx *sctx, u32 len)
 		 * Since v2, the data attribute header doesn't include a length,
 		 * it is implicitly to the end of the command.
 		 */
-		if (sctx->send_max_size - sctx->send_size < sizeof(__le16) + len)
+		if (unlikely(sctx->send_max_size - sctx->send_size < sizeof(__le16) + len))
 			return -EOVERFLOW;
 		put_unaligned_le16(BTRFS_SEND_A_DATA, sctx->send_buf + sctx->send_size);
 		sctx->send_size += sizeof(__le16);
 	} else {
 		struct btrfs_tlv_header *hdr;
 
-		if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
+		if (unlikely(sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len))
 			return -EOVERFLOW;
 		hdr = (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size);
 		put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
@@ -5580,8 +5580,8 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	 * between the beginning of the command and the file data.
 	 */
 	data_offset = PAGE_ALIGN(sctx->send_size);
-	if (data_offset > sctx->send_max_size ||
-	    sctx->send_max_size - data_offset < disk_num_bytes) {
+	if (unlikely(data_offset > sctx->send_max_size ||
+		     sctx->send_max_size - data_offset < disk_num_bytes)) {
 		ret = -EOVERFLOW;
 		goto out;
 	}
-- 
2.47.2


