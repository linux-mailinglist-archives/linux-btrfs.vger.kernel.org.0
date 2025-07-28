Return-Path: <linux-btrfs+bounces-15705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3D6B136AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 10:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50BA3A7551
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E751F24BC09;
	Mon, 28 Jul 2025 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rVgSn/ce";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rVgSn/ce"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC4248F4A
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691315; cv=none; b=CXcxevqDHr0VfduLH6EKVeFte/cBkSwZcgrj5ZIs6fHCSN01uhchdGcbqYeWji+gcVcw/rgPnhhe7kAFcPDxVEc8cMExqFQgFqV17VUOMVzQMwt4VQfB3nvtDoHA/RJa8N9jgDf7Dh/KQkAftiwDJEcejQQuMSOqD1InTiP4Q34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691315; c=relaxed/simple;
	bh=/latIwWFYkWV7JGDRTtJAHh7qg8ucJgR7sJa4nuv9D4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKWD6MhGXN7SyqLkGlninvy89o1avJiXWEQOzoBDiayljciATPgbVadmv+kWDM7asbdcMQo94exMYPgfYWhPg4v7SuubqoTcsfq6HewfPinXFi+IX12IKuQHFWTmqOd3atBR0OuKU2utlWWmapnu+zisUdrGQObBrUB5cMH3El4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rVgSn/ce; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rVgSn/ce; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D842C1F76B
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753691299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE0/jmGd3PcEbQVbSXWte9zq1gITjy+NbpGcr0m72zY=;
	b=rVgSn/cetWgBQOkMXHR4p43kBes7Kf9PzmTrm/eM0rdcFuiB+XCQShBXtf5ykVvpESP3Ln
	2eeHn3zTbjyXqIfwf6wPixvw/Sv8cHd70Mz0n+70OmI0RH0Wspgc5kBjd6VFetQ9nDkwgK
	0gddC3AZVMQQo62jL0Yt4sdbC1AR2po=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="rVgSn/ce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753691299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE0/jmGd3PcEbQVbSXWte9zq1gITjy+NbpGcr0m72zY=;
	b=rVgSn/cetWgBQOkMXHR4p43kBes7Kf9PzmTrm/eM0rdcFuiB+XCQShBXtf5ykVvpESP3Ln
	2eeHn3zTbjyXqIfwf6wPixvw/Sv8cHd70Mz0n+70OmI0RH0Wspgc5kBjd6VFetQ9nDkwgK
	0gddC3AZVMQQo62jL0Yt4sdbC1AR2po=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21487138A5
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2EE9NaI0h2g0GwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: make nocow_one_range() to do cleanup on error
Date: Mon, 28 Jul 2025 17:57:56 +0930
Message-ID: <8eae4df410ba03f4efb047b086f70342a5fd270f.1753687685.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753687685.git.wqu@suse.com>
References: <cover.1753687685.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D842C1F76B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Currently if we hit an error inside nocow_one_range(), we do not clear
the page dirty, and let the caller to handle it.

This is very different compared to fallback_to_cow(), when that function
failed, everything will be cleaned up by cow_file_range().

Enhance the situation by:

- Use a common error handling for nocow_one_range()
  If we failed anything, use the same btrfs_cleanup_ordered_extents()
  and extent_clear_unlock_delalloc().

  btrfs_cleanup_ordered_extents() is safe even if we haven't created new
  ordered extent, in that case there should be no OE and that function
  will do nothing.

  The same applies to extent_clear_unlock_delalloc(), and since we're
  passing PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK, it
  will also clear folio dirty flag during error handling.

- Avoid touching the failed range of nocow_one_range()
  As the failed range will be cleaned up and unlocked by that function.

  Here we introduce a new variable @nocow_end to record the failed range,
  so that we can skip it during the error handling of run_delalloc_nocow().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 59 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e3063a001791..1466f4356826 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1982,8 +1982,8 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 		em = btrfs_create_io_em(inode, file_pos, &nocow_args->file_extent,
 					BTRFS_ORDERED_PREALLOC);
 		if (IS_ERR(em)) {
-			btrfs_unlock_extent(&inode->io_tree, file_pos, end, cached);
-			return PTR_ERR(em);
+			ret = PTR_ERR(em);
+			goto error;
 		}
 		btrfs_free_extent_map(em);
 	}
@@ -1995,8 +1995,8 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 	if (IS_ERR(ordered)) {
 		if (is_prealloc)
 			btrfs_drop_extent_map_range(inode, file_pos, end, false);
-		btrfs_unlock_extent(&inode->io_tree, file_pos, end, cached);
-		return PTR_ERR(ordered);
+		ret = PTR_ERR(ordered);
+		goto error;
 	}
 
 	if (btrfs_is_data_reloc_root(inode->root))
@@ -2008,23 +2008,24 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 		ret = btrfs_reloc_clone_csums(ordered);
 	btrfs_put_ordered_extent(ordered);
 
+	if (ret < 0)
+		goto error;
 	extent_clear_unlock_delalloc(inode, file_pos, end, locked_folio, cached,
 				     EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_CLEAR_DATA_RESV,
 				     PAGE_UNLOCK | PAGE_SET_ORDERED);
-	/*
-	 * On error, we need to cleanup the ordered extents we created.
-	 *
-	 * We do not clear the folio Dirty flags because they are set and
-	 * cleaered by the caller.
-	 */
-	if (ret < 0) {
-		btrfs_cleanup_ordered_extents(inode, file_pos, len);
-		btrfs_err(inode->root->fs_info,
-			  "%s failed, root=%lld inode=%llu start=%llu len=%llu: %d",
-			  __func__, btrfs_root_id(inode->root), btrfs_ino(inode),
-			  file_pos, len, ret);
-	}
+	return ret;
+error:
+	btrfs_cleanup_ordered_extents(inode, file_pos, len);
+	extent_clear_unlock_delalloc(inode, file_pos, end, locked_folio, cached,
+				     EXTENT_LOCKED | EXTENT_DELALLOC |
+				     EXTENT_CLEAR_DATA_RESV,
+				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
+				     PAGE_END_WRITEBACK);
+	btrfs_err(inode->root->fs_info,
+		  "%s failed, root=%lld inode=%llu start=%llu len=%llu: %d",
+		  __func__, btrfs_root_id(inode->root), btrfs_ino(inode),
+		  file_pos, len, ret);
 	return ret;
 }
 
@@ -2046,8 +2047,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	/*
 	 * If not 0, represents the inclusive end of the last fallback_to_cow()
 	 * range. Only for error handling.
+	 *
+	 * The same for nocow_end, it's to avoid double cleaning up the range
+	 * already cleaned by nocow_one_range().
 	 */
 	u64 cow_end = 0;
+	u64 nocow_end = 0;
 	u64 cur_offset = start;
 	int ret;
 	bool check_prev = true;
@@ -2222,8 +2227,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				      &nocow_args, cur_offset,
 				      extent_type == BTRFS_FILE_EXTENT_PREALLOC);
 		btrfs_dec_nocow_writers(nocow_bg);
-		if (ret < 0)
+		if (ret < 0) {
+			nocow_end = cur_offset + nocow_args.file_extent.num_bytes - 1;
 			goto error;
+		}
 		cur_offset = extent_end;
 	}
 	btrfs_release_path(path);
@@ -2250,12 +2257,22 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		 *    start           cur_offset               end
 		 *    |   OE cleanup  |       Untouched        |
 		 *
-		 * We finished a fallback_to_cow() or nocow_one_range() call, but
-		 * failed to check the next range.
+		 * We finished a fallback_to_cow() or nocow_one_range() call,
+		 * but failed to check the next range.
+		 *
+		 * or
+		 *    start           cur_offset   nocow_end   end
+		 *    |   OE cleanup  |   Skip     | Untouched |
+		 *
+		 * nocow_one_range() failed, the range [cur_offset, nocow_end] is
+		 * alread cleaned up.
 		 */
 		oe_cleanup_start = start;
 		oe_cleanup_len = cur_offset - start;
-		untouched_start = cur_offset;
+		if (nocow_end)
+			untouched_start = nocow_end + 1;
+		else
+			untouched_start = cur_offset;
 		untouched_len = end + 1 - untouched_start;
 	} else if (cow_start != (u64)-1 && cow_end == 0) {
 		/*
-- 
2.50.1


