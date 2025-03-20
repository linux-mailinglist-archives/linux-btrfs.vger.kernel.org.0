Return-Path: <linux-btrfs+bounces-12447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AD0A69F5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 06:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A09D1895F1E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 05:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A91DD0C7;
	Thu, 20 Mar 2025 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Tvh0nkA0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Tvh0nkA0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAD155753
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448880; cv=none; b=h/yxZIeoyr8MqnIIPVzXE5VWFoprVzpKoLYAEEdH8fX7Vy/Oq4itbg3S8ZvDKDGyMXOdXEXRZ01HFFda4cfhe7zH/Z5iIhspF7BkwfjVSzeYJ3xURTq/1fil6rzxjKWHx7sAcYKK5w5i2xJ0utQ6x44tpiBd4ynY3f2pmsPz9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448880; c=relaxed/simple;
	bh=FV5gvgPNKj7DXmV+iMabSXscV/E/uWadaYGSKvytIPA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqIZt7+IBoS6wyNfTkeEuaAJFHiGw49dV/jy+0KXvC19LqawVqONVqm0+8qanE5C8adU3HRL3DMB1N0c5lCoyWvzfAw4ds/czcdMjvyC8rS5WK66Xi1RftDbWmQPJX4c8Sgp5mAB/XnMMl/tTu2UkTq+7c26DoWiBL3F9dA5I+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Tvh0nkA0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Tvh0nkA0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 965861F7C3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742448876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0bKQqV+MkkHPe7DZIpBz0LFXLdD07HsBuq459cApq8=;
	b=Tvh0nkA0bG+ZHxtdmUbO9xpF7Xscwavom+HMjP+p0X/c3Mww5FfSsiGjzl/OjO9Ym86DeS
	YOmsy+DbwV/o5uD5XDa2K1Ej/tatYGk+AfqBdISmro1szcU0YeuRjovKxY3t6gVkTbzQsJ
	hCzhn4kg17STgFrnsudfONyIMmb9X6w=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742448876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0bKQqV+MkkHPe7DZIpBz0LFXLdD07HsBuq459cApq8=;
	b=Tvh0nkA0bG+ZHxtdmUbO9xpF7Xscwavom+HMjP+p0X/c3Mww5FfSsiGjzl/OjO9Ym86DeS
	YOmsy+DbwV/o5uD5XDa2K1Ej/tatYGk+AfqBdISmro1szcU0YeuRjovKxY3t6gVkTbzQsJ
	hCzhn4kg17STgFrnsudfONyIMmb9X6w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90DB7138A5
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qLSnD+uo22fcMQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: extract the space reservation code from btrfs_buffered_write()
Date: Thu, 20 Mar 2025 16:04:10 +1030
Message-ID: <522bfb923444f08b2c68c51a05cb5ca8b3ac7a77.1742443383.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742443383.git.wqu@suse.com>
References: <cover.1742443383.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Inside the main loop of btrfs_buffered_write(), we have a complex data
and metadata space reservation code, which tries to reserve space for
a COW write, if failed then fallback to check if we can do a NOCOW
write.

Extract that part of code into a dedicated helper, reserve_space(), to
make the main loop a little easier to read.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 108 ++++++++++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f68846c14ed5..99580ef906a6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1095,6 +1095,64 @@ static void release_space(struct btrfs_inode *inode,
 	}
 }
 
+/*
+ * Reserve data and metadata space for the this buffered write range.
+ *
+ * Return >0 for the number of bytes reserved, which is always block aligned.
+ * Return <0 for error.
+ */
+static ssize_t reserve_space(struct btrfs_inode *inode,
+			 struct extent_changeset **data_reserved,
+			 u64 start, size_t *len, bool nowait,
+			 bool *only_release_metadata)
+{
+	const struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	unsigned int block_offset = start & (fs_info->sectorsize - 1);
+	size_t reserve_bytes;
+	int ret;
+
+	ret = btrfs_check_data_free_space(inode, data_reserved, start, *len,
+					  nowait);
+	if (ret < 0) {
+		int can_nocow;
+
+		if (nowait && (ret == -ENOSPC || ret == -EAGAIN))
+			return -EAGAIN;
+
+		/*
+		 * If we don't have to COW at the offset, reserve
+		 * metadata only. write_bytes may get smaller than
+		 * requested here.
+		 */
+		can_nocow = btrfs_check_nocow_lock(inode, start, len, nowait);
+		if (can_nocow < 0)
+			ret = can_nocow;
+		if (can_nocow > 0)
+			ret = 0;
+		if (ret)
+			return ret;
+		*only_release_metadata = true;
+	}
+
+	reserve_bytes = round_up(*len + block_offset,
+				 fs_info->sectorsize);
+	WARN_ON(reserve_bytes == 0);
+	ret = btrfs_delalloc_reserve_metadata(inode, reserve_bytes,
+					      reserve_bytes, nowait);
+	if (ret) {
+		if (!*only_release_metadata)
+			btrfs_free_reserved_data_space(inode,
+					*data_reserved, start, *len);
+		else
+			btrfs_check_nocow_unlock(inode);
+
+		if (nowait && ret == -ENOSPC)
+			ret = -EAGAIN;
+		return ret;
+	}
+	return reserve_bytes;
+}
+
 ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
@@ -1160,52 +1218,12 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		sector_offset = pos & (fs_info->sectorsize - 1);
 
 		extent_changeset_release(data_reserved);
-		ret = btrfs_check_data_free_space(BTRFS_I(inode),
-						  &data_reserved, pos,
-						  write_bytes, nowait);
-		if (ret < 0) {
-			int can_nocow;
-
-			if (nowait && (ret == -ENOSPC || ret == -EAGAIN)) {
-				ret = -EAGAIN;
-				break;
-			}
-
-			/*
-			 * If we don't have to COW at the offset, reserve
-			 * metadata only. write_bytes may get smaller than
-			 * requested here.
-			 */
-			can_nocow = btrfs_check_nocow_lock(BTRFS_I(inode), pos,
-							   &write_bytes, nowait);
-			if (can_nocow < 0)
-				ret = can_nocow;
-			if (can_nocow > 0)
-				ret = 0;
-			if (ret)
-				break;
-			only_release_metadata = true;
-		}
-
-		reserve_bytes = round_up(write_bytes + sector_offset,
-					 fs_info->sectorsize);
-		WARN_ON(reserve_bytes == 0);
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-						      reserve_bytes,
-						      reserve_bytes, nowait);
-		if (ret) {
-			if (!only_release_metadata)
-				btrfs_free_reserved_data_space(BTRFS_I(inode),
-						data_reserved, pos,
-						write_bytes);
-			else
-				btrfs_check_nocow_unlock(BTRFS_I(inode));
-
-			if (nowait && ret == -ENOSPC)
-				ret = -EAGAIN;
+		ret = reserve_space(BTRFS_I(inode), &data_reserved, pos,
+				    &write_bytes, nowait,
+				    &only_release_metadata);
+		if (ret < 0)
 			break;
-		}
-
+		reserve_bytes = ret;
 		release_bytes = reserve_bytes;
 again:
 		ret = balance_dirty_pages_ratelimited_flags(inode->i_mapping, bdp_flags);
-- 
2.49.0


