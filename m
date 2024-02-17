Return-Path: <linux-btrfs+bounces-2468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9315858D80
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 07:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC019B21DB1
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 06:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE6A1CD0C;
	Sat, 17 Feb 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GuuTh6lt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GuuTh6lt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D331C6B9
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708151399; cv=none; b=bTypJetm8nzs+iE5kRAiixWPiu8UWxGKGkkmQpEFSGHX72W2xC6ISyT3yVS1405Y14E5X14ciKrqiKDl5Qg0As8LUAJSrm+qs0jGCrzoTiQPiym7blLi8YrysI+0n0PlvKy5N3wlE8ww7HagWKoCTmqYQohyX+fSDC7Mr/p3j1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708151399; c=relaxed/simple;
	bh=ykvJx2gvC4wyHped6ejTnTBtgeqPyolwns/56+dJ6Sk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y35jBQ5dKoNhT0AR/y/kxakMWAMAbg5Fa9bL/YYgWIXuq3s6kyjbBRSXh6HafATmwBoayirQHd0AvRy1uidro+4z+7pIUGRCEgKR+NR/15DLyGjcGvP0uhdHWnguLRjTue2YjlfdQr5lX3JLPMeAnN6Bse/JRAQr0gQZyI4GJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GuuTh6lt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GuuTh6lt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A165D1FB9A
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708151395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBNvps2s8XWEkP3TXEzkkv9LjnXIsPghG4eXbM1KEqg=;
	b=GuuTh6lt5wTzX92gKNtt98LQUvEVd1AD5ZBM3HU9zD+gfnG4TygtGQ+HnHjkza47beHhJI
	ZvJO1bGKw2ELLviA/zG2a1lqEB1TiO0baMc8UjSnhkCxO4KbX8UOke7cIRsd7/hiVmlVwf
	8KGCiZ+3YnJfyEqKymye2fF4ky5V2dE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708151395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBNvps2s8XWEkP3TXEzkkv9LjnXIsPghG4eXbM1KEqg=;
	b=GuuTh6lt5wTzX92gKNtt98LQUvEVd1AD5ZBM3HU9zD+gfnG4TygtGQ+HnHjkza47beHhJI
	ZvJO1bGKw2ELLviA/zG2a1lqEB1TiO0baMc8UjSnhkCxO4KbX8UOke7cIRsd7/hiVmlVwf
	8KGCiZ+3YnJfyEqKymye2fF4ky5V2dE=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A49A6134CD
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IE/kFWJS0GUyZQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: unexport btrfs_subpage_start_writer() and btrfs_subpage_end_and_test_writer()
Date: Sat, 17 Feb 2024 16:59:48 +1030
Message-ID: <b5c3c451748d8d92b3d08c537d7c4d5fd716076f.1708151123.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <cover.1708151123.git.wqu@suse.com>
References: <cover.1708151123.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

Both functions are introduced in commit 1e1de38792e0 ("btrfs: make
process_one_page() to handle subpage locking"), but they are never
utilized out of subpage code.

So just unexport them.

Fixes: 1e1de38792e0 ("btrfs: make process_one_page() to handle subpage locking")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 8 ++++----
 fs/btrfs/subpage.h | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 0e49dab8dad2..24f8be565a61 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -290,8 +290,8 @@ static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 			     orig_start + orig_len) - *start;
 }
 
-void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
-				struct folio *folio, u64 start, u32 len)
+static void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
+				       struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int nbits = (len >> fs_info->sectorsize_bits);
@@ -304,8 +304,8 @@ void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
 	ASSERT(ret == nbits);
 }
 
-bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
-				       struct folio *folio, u64 start, u32 len)
+static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
+					      struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int nbits = (len >> fs_info->sectorsize_bits);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 55fc42db707e..97ba2c100b0b 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -98,10 +98,6 @@ void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
 void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
 			      struct folio *folio, u64 start, u32 len);
 
-void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
-				struct folio *folio, u64 start, u32 len);
-bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
-				       struct folio *folio, u64 start, u32 len);
 int btrfs_folio_start_writer_lock(const struct btrfs_fs_info *fs_info,
 				  struct folio *folio, u64 start, u32 len);
 void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
-- 
2.43.1


