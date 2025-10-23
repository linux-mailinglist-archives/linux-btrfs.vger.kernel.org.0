Return-Path: <linux-btrfs+bounces-18201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BF4C02486
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679813A768E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B452882A6;
	Thu, 23 Oct 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZYK5xPy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0539C286887
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235219; cv=none; b=nB1AaOEDaEnjZyS400sg+jzQhjoMLXTnvyK8p3CjiLnc1CW7lSXfM2XUMiMabo5XnQsWPBrhlfjyOJRVHVoHnr5oiEjbAwDV/6MzqoYJqvkf2yvvkwtewWRKWEN+euNFXFE+2VnRtGxqtq11tnAMNTcGMSwMlTMojUAFKgu4gJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235219; c=relaxed/simple;
	bh=HbP4tfBfgKDXdynQosfxYMnmtg6Km3Nv9VGT21L/zTw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/zu7WslLZYjRD9jhATT2qzRJsOns1geUp+5HmL/m1469MF/oxz/RKbHhe6nZRY8P/JQ9Luc6d9KYLCGSne8KTbljYcLl5VIg9MTRHNdz9E3HaRgwiGzKKGmh9hewKFAdiEuOvUX21UHseRqjDC7owocPYPiQNLi/DbantELj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZYK5xPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3C5C113D0
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235218;
	bh=HbP4tfBfgKDXdynQosfxYMnmtg6Km3Nv9VGT21L/zTw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aZYK5xPyN0/ZjEtm8V4uov8U0Pa4ZMRMc3G3kLB5Mro1+8dFJjqO5pPVWjIQCARSm
	 PPKvbuwTiKVhcoGov3bmnicQL/cwbkJLt0+PiGvww6u6J3PRNK6nDMQpSoz4YRwqSU
	 dXOOYftzszXPQJmwULOXYLeqqI2/3nnppyI4jsbm/8+wNp+1+csARwm2s2RhCEJwwp
	 64tHdMZA26RIC+VjzxTHeYu4eqQaFnuWVuq8LBvBTD8w8XbU4SVPXcrXEKvL1kkzOP
	 itnlFiPfCTglE1A2I53T0zgYD2GuJcue42t71D/kb/R2TdxxJ3SW7bC8/KvjaI5uvJ
	 wvKekDXbZmJaA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/28] btrfs: remove double underscore prefix from __reserve_bytes()
Date: Thu, 23 Oct 2025 16:59:47 +0100
Message-ID: <799f7d42e91be263668688ee16a1d4c554230887.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The use of a double underscore prefix is discouraged and we have no
justification at all for it all since there's no reserved_bytes() counter
part. So remove the prefix.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 957477e5f01f..edeb46f1aa33 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -67,7 +67,7 @@
  *   Assume we are unable to simply make the reservation because we do not have
  *   enough space
  *
- *   -> __reserve_bytes
+ *   -> reserve_bytes
  *     create a reserve_ticket with ->bytes set to our reservation, add it to
  *     the tail of space_info->tickets, kick async flush thread
  *
@@ -1728,8 +1728,8 @@ static inline bool can_ticket(enum btrfs_reserve_flush_enum flush)
  * regain reservations will be made and this will fail if there is not enough
  * space already.
  */
-static int __reserve_bytes(struct btrfs_space_info *space_info, u64 orig_bytes,
-			   enum btrfs_reserve_flush_enum flush)
+static int reserve_bytes(struct btrfs_space_info *space_info, u64 orig_bytes,
+			 enum btrfs_reserve_flush_enum flush)
 {
 	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	struct work_struct *async_work;
@@ -1879,7 +1879,7 @@ int btrfs_reserve_metadata_bytes(struct btrfs_space_info *space_info,
 {
 	int ret;
 
-	ret = __reserve_bytes(space_info, orig_bytes, flush);
+	ret = reserve_bytes(space_info, orig_bytes, flush);
 	if (ret == -ENOSPC) {
 		struct btrfs_fs_info *fs_info = space_info->fs_info;
 
@@ -1913,7 +1913,7 @@ int btrfs_reserve_data_bytes(struct btrfs_space_info *space_info, u64 bytes,
 	       flush == BTRFS_RESERVE_NO_FLUSH);
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
-	ret = __reserve_bytes(space_info, bytes, flush);
+	ret = reserve_bytes(space_info, bytes, flush);
 	if (ret == -ENOSPC) {
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
 					      space_info->flags, bytes, 1);
-- 
2.47.2


