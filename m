Return-Path: <linux-btrfs+bounces-10120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244959E833D
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 03:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966461656CA
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 02:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ACF73451;
	Sun,  8 Dec 2024 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jlXI1SKl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jlXI1SKl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4E4EB45
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733626296; cv=none; b=eJ9I17pgJOqJNZKRRLhhiympmC5F1jktakfFq9s5eGsRP6+KcrPsCEDzc2Yi3TKC++KJgUyhSMu+BxD0ET5Wd87ygoFg1CeaDmxZKJCwSYJYQNvhOA9V+IEWP/6jSCgvXZ+AXo2eo452elcSJhvV4znv9FwiJIaRwz0070wjAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733626296; c=relaxed/simple;
	bh=ZiEBxhZw8sN+7Ip7QT8ql8JrGi/bNM6PZOoo8hVaTyc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2ZQuhtESDBmo8sckZk8obOYViCSU1NUycw8GThWWwuIRtIUZfLjz4BCR38xsSoHxDyah0ZHhoJ7CumZhD9TSliKN8vGaTqCWxzS6K/UqB1LZQqE5QRjuf4R2JDFpo4emxrOD86AsswclCmhtwopHVLIkQ6scDm0qDjLk10c/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jlXI1SKl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jlXI1SKl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A7802117E
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 02:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733626292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZkH4wMOBy5BBqA+lrivu/lJPJgVj0EsmErgCPYJKWg=;
	b=jlXI1SKl28kDhYoUQvLXo9QgTQghGCRlDQ9UKKvm2pFdPYm7OjdX/5RbkJsLbP6FKGw0xs
	Rwxi4RizeFc9+Ig+3iSL0kxLDLUHuwBY3yl/jk7aeV3N9wfK8KQGrGvka7p7F5GPqxzCvy
	LYg4pId5dzki8+WUZuwZDZ20lazHaDU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733626292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZkH4wMOBy5BBqA+lrivu/lJPJgVj0EsmErgCPYJKWg=;
	b=jlXI1SKl28kDhYoUQvLXo9QgTQghGCRlDQ9UKKvm2pFdPYm7OjdX/5RbkJsLbP6FKGw0xs
	Rwxi4RizeFc9+Ig+3iSL0kxLDLUHuwBY3yl/jk7aeV3N9wfK8KQGrGvka7p7F5GPqxzCvy
	LYg4pId5dzki8+WUZuwZDZ20lazHaDU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7C31133D1
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 02:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OBiQGrMJVWcXcQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 02:51:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: subpage: fix the bitmap dump for the locked flags
Date: Sun,  8 Dec 2024 13:21:03 +1030
Message-ID: <418c824fe3bb4135f412224359187e392d1e7edd.1733624454.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733624454.git.wqu@suse.com>
References: <cover.1733624454.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

We're dumping the locked bitmap into the @checked_bitmap variable,
causing incorrect values during debug.

Thankfuklly even during my development I haven't hit a case where I need
to dump the locked bitmap.
But for the sake of consistency, fix it by dumpping the locked bitmap
into @locked_bitmap variable for output.

Fixes: 75258f20fb70 ("btrfs: subpage: dump extra subpage bitmaps for debug")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 8c68059ac1b0..03d7bfc042e2 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -716,6 +716,7 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	unsigned long writeback_bitmap;
 	unsigned long ordered_bitmap;
 	unsigned long checked_bitmap;
+	unsigned long locked_bitmap;
 	unsigned long flags;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
@@ -728,15 +729,16 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	GET_SUBPAGE_BITMAP(subpage, fs_info, writeback, &writeback_bitmap);
 	GET_SUBPAGE_BITMAP(subpage, fs_info, ordered, &ordered_bitmap);
 	GET_SUBPAGE_BITMAP(subpage, fs_info, checked, &checked_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, locked, &checked_bitmap);
+	GET_SUBPAGE_BITMAP(subpage, fs_info, locked, &locked_bitmap);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 
 	dump_page(folio_page(folio, 0), "btrfs subpage dump");
 	btrfs_warn(fs_info,
-"start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl dirty=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
+"start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl dirty=%*pbl locked=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
 		    start, len, folio_pos(folio),
 		    sectors_per_page, &uptodate_bitmap,
 		    sectors_per_page, &dirty_bitmap,
+		    sectors_per_page, &locked_bitmap,
 		    sectors_per_page, &writeback_bitmap,
 		    sectors_per_page, &ordered_bitmap,
 		    sectors_per_page, &checked_bitmap);
-- 
2.47.1


