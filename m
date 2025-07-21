Return-Path: <linux-btrfs+bounces-15598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0CDB0C966
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3CC3A9DA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96172E2F0C;
	Mon, 21 Jul 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrniWpJU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262922E0922
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118207; cv=none; b=Y/VgFeCZ6Ov0SFRivIYB+s/zc4EGY6SXR8tf5Pftf9uanmhkIml0TaFb1WGvwcod24oP27Vk3/vjIj9LTE8ouRtvqIErNxzNPgFXdxDntFAo2AiyFaTfNtbfTd7WxQzc7vJ+3qfe/iJamDzC0zNvibeWEdCjGbuSq2smnGRSAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118207; c=relaxed/simple;
	bh=u8PeDPkaXzEg6j4F50yqtHsv1NLFiKaE/5OWg98n2yg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnq4czJ41pWPNMrNNl7W1+ntXbn2KxNh8koTSwl7Ed3vDgVAcaBbKo7QUQmhBM3ZzPXN9oEznxzKgjfluohfNoou4CnxaexP5lIubZI1eju6swfu3igLOhrTWzeT22LUpw/bPiw5hEswHx303QrS3tfK7ZjnUtbvsk7KF05x3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrniWpJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D61C4CEF6
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753118205;
	bh=u8PeDPkaXzEg6j4F50yqtHsv1NLFiKaE/5OWg98n2yg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YrniWpJUK5KAn5n8vAxFI+6OsS88CnCQGvtUotW1T/TbIvAuI23sIM2Tp+HiyOp9o
	 zwgWyI5LoeUrKJRw+Q54bMGVuLmQyUFyWqq8g841oRnO7mLWbNcmIA+qeIUXlPYGYM
	 zP4A5ccE3YFgDyOGb6mX4FlqWw9Kpq9Mn1/ESBGvJntA7D2hQoBTTxF6mwqxhjpl84
	 U2+18PJCsl3YAyekbfnXDCc6Ezq8v1gNXbL2ejNFjQa1FC0ABFOAdDGq2p4/rSSsKy
	 ISiRCHBJYPYGhpm0rO2MFjOkrOUrWAn38jPQe2hSO+ukXUppmJVJ8Xxo0BS8Zipppw
	 e5GMSMQxHLujg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/10] btrfs: abort transaction on specific error places when walking log tree
Date: Mon, 21 Jul 2025 18:16:29 +0100
Message-ID: <2c9bf3d5128a66e99f36c72d5f19f80f07a6d9ed.1753117707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1753117707.git.fdmanana@suse.com>
References: <cover.1753117707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We do several things while walking a log tree (for replaying and for
freeing a log tree) like reading extent buffers and cleaning them up,
but we don't immediately abort the transaction, or turn the fs into an
error state, when one of these things fails. Instead we the transaction
abort or turn the fs into error state in the caller of the entry point
function that walks a log tree - walk_log_tree() - which means we don't
get to know exactly where an error came from.

Improve on this by doing a transaction abort / turn fs into error state
after each such failure so that when it happens we have a better
understanding where the failure comes from. This deliberately leaves
the transaction abort / turn fs into error state in the callers of
walk_log_tree() as to ensure we don't get into an inconsitent state in
case we forget to do it deeper in call chain. It also deliberately does
not do it after errors from the calls to the callback defined in
struct walk_control::process_func(), as we will do it later on another
patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 45f2e13f5018..b5b1f38c03a6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2618,15 +2618,24 @@ static int unaccount_log_buffer(struct btrfs_fs_info *fs_info, u64 start)
 static int clean_log_buffer(struct btrfs_trans_handle *trans,
 			    struct extent_buffer *eb)
 {
+	int ret;
+
 	btrfs_tree_lock(eb);
 	btrfs_clear_buffer_dirty(trans, eb);
 	wait_on_extent_buffer_writeback(eb);
 	btrfs_tree_unlock(eb);
 
-	if (trans)
-		return btrfs_pin_reserved_extent(trans, eb);
+	if (trans) {
+		ret = btrfs_pin_reserved_extent(trans, eb);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 
-	return unaccount_log_buffer(eb->fs_info, eb->start);
+	ret = unaccount_log_buffer(eb->fs_info, eb->start);
+	if (ret)
+		btrfs_handle_fs_error(eb->fs_info, ret, NULL);
+	return ret;
 }
 
 static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
@@ -2662,8 +2671,14 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 		next = btrfs_find_create_tree_block(fs_info, bytenr,
 						    btrfs_header_owner(cur),
 						    *level - 1);
-		if (IS_ERR(next))
-			return PTR_ERR(next);
+		if (IS_ERR(next)) {
+			ret = PTR_ERR(next);
+			if (trans)
+				btrfs_abort_transaction(trans, ret);
+			else
+				btrfs_handle_fs_error(fs_info, ret, NULL);
+			return ret;
+		}
 
 		if (*level == 1) {
 			ret = wc->process_func(root, next, wc, ptr_gen,
@@ -2678,6 +2693,10 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 				ret = btrfs_read_extent_buffer(next, &check);
 				if (ret) {
 					free_extent_buffer(next);
+					if (trans)
+						btrfs_abort_transaction(trans, ret);
+					else
+						btrfs_handle_fs_error(fs_info, ret, NULL);
 					return ret;
 				}
 
@@ -2693,6 +2712,10 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 		ret = btrfs_read_extent_buffer(next, &check);
 		if (ret) {
 			free_extent_buffer(next);
+			if (trans)
+				btrfs_abort_transaction(trans, ret);
+			else
+				btrfs_handle_fs_error(fs_info, ret, NULL);
 			return ret;
 		}
 
-- 
2.47.2


