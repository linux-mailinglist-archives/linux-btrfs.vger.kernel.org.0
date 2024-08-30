Return-Path: <linux-btrfs+bounces-7686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA81F96580E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 09:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22171F24CA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D1D15C12D;
	Fri, 30 Aug 2024 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QFkFY4ol";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QFkFY4ol"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D9315C127
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001571; cv=none; b=cj/pyU43HCL/ofOJET07DhWIwCMdtJVSyxFpE6ExMTGh2w6UL/gi4wNTN9CJm88qWsBs0eQsj5Kl2YlW998ptZKDTFOTGPeEcOvbTfh+x4mY/G7IIEgcO83JU7+LjTAxkvZPp13OL6qT2pCms3bs3Rt902SfKun3oZwmw592h6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001571; c=relaxed/simple;
	bh=AGEmTH8r8k97eQfCPKNgUC08X5frKnRKDcv2WvMb13c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ijrABHWCmyggDOWz0hGr4B51+XIB60C+bC2eaNfE/+tut8J2UXYoTZNXaquRlJOl1qqWNMK3CFzL3NjvjDP5l/uiEG8zv0TSD787QNsaWb+YWngN27dihxKwPptPaZ2U9ine5kKnxnUzt8j0WiOmGmdoij59UnlNROWIuydXowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QFkFY4ol; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QFkFY4ol; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C8FA1F7A6
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 07:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725001567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2r9NRFxfMsGTorSUxJRwg8dXGNBPtvuDerHMhTCc+8M=;
	b=QFkFY4olKq4Y59R1qcEOFoMBUm462XopPWyt1ELtQV5JA2dOulbivumMvjLNtyCFPyunk9
	3UvVVgbvRVbWO53jf4coTimxAkrxzFR1jwnaMbYl1MWz9EVn8VWfGlqFHs+NQVh32WBpvb
	DRjrxtrCxGO2gJ08oQmb65CLCtyYN2E=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QFkFY4ol
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725001567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2r9NRFxfMsGTorSUxJRwg8dXGNBPtvuDerHMhTCc+8M=;
	b=QFkFY4olKq4Y59R1qcEOFoMBUm462XopPWyt1ELtQV5JA2dOulbivumMvjLNtyCFPyunk9
	3UvVVgbvRVbWO53jf4coTimxAkrxzFR1jwnaMbYl1MWz9EVn8VWfGlqFHs+NQVh32WBpvb
	DRjrxtrCxGO2gJ08oQmb65CLCtyYN2E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A63EB13A44
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 07:06:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lHqzGV5v0WYPXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 07:06:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: subpage: fix the bitmap dump which can cause bitmap corruption
Date: Fri, 30 Aug 2024 16:35:48 +0930
Message-ID: <b93aac5fb44b46cd5391f3d5d177c0976e7d5ce0.1725001507.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C8FA1F7A6
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

In commit 75258f20fb70 ("btrfs: subpage: dump extra subpage bitmaps for
debug") an internal macro GET_SUBPAGE_BITMAP() is introduced to grab the
bitmap of each attribute.

But that commit is using bitmap_cut() which will do the left shift of
the larger bitmap, causing incorrect values.

Thankfully this bitmap_cut() is only called for debug usage, and so far
it's not yet causing problem.

Fix it to use bitmap_read() to only grab the desired sub-bitmap.

Fixes: 75258f20fb70 ("btrfs: subpage: dump extra subpage bitmaps for debug")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Do not change the parameters of GET_SUBPAGE_BITMAP()
  To minimal the backport needed.
---
 fs/btrfs/subpage.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 663f2f953a65..ca7d2aedfa8d 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -870,9 +870,14 @@ void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info, struct fol
 }
 
 #define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
-	bitmap_cut(dst, subpage->bitmaps, 0,				\
-		   fs_info->sectors_per_page * btrfs_bitmap_nr_##name,	\
-		   fs_info->sectors_per_page)
+{									\
+	const int sectors_per_page = fs_info->sectors_per_page;		\
+									\
+	ASSERT(sectors_per_page < BITS_PER_LONG);			\
+	*dst = bitmap_read(subpage->bitmaps,				\
+			   sectors_per_page * btrfs_bitmap_nr_##name,	\
+			   sectors_per_page);				\
+}
 
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 start, u32 len)
-- 
2.46.0


