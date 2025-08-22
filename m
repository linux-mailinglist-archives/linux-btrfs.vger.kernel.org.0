Return-Path: <linux-btrfs+bounces-16279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA68B316C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 13:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E531C8650B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB0D2F49E4;
	Fri, 22 Aug 2025 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZJ0vXvGo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZJ0vXvGo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5017B402
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863928; cv=none; b=ZNwBGB1YgDCy9SXmJKTzfynTJe28ZXiMQAQHMQW28czfoW16jnXy+kUYV7IvhNatmjjG4eGjnhik3DcGcw9XfbS5tLVdxeHSWtoYJDGswVAWwmhfocE5gBKCzkam+HoD5/64TqVm5w6vtAB6SOqITegesLe+9Q6yqWJYSLHtRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863928; c=relaxed/simple;
	bh=DV2xnEDwdVCWuMiN0T81IDOclj0Wp4keX+HqPmA68uE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYmYsgQbBvJQP9Wj9fs77nXynWOK8hF6xlmy748gYDMW8oK0s5TQj76Q0zYJGFNIPseaqzEFIM6ZvdNpdecRpocerIunUS1fvkNGiLXJlmZ9FR52QkMCw+Br0V3NC9EtYWyukXCM30VVfar4vwF4Bk+0B5d684FvxDswWDGxj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZJ0vXvGo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZJ0vXvGo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B90BE21A2B;
	Fri, 22 Aug 2025 11:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755863923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f7gi6uTIAbJXxsBFd42XtmibQjWWyauIQUPbXJcUiqU=;
	b=ZJ0vXvGoE12p8piY+WCzr9d4ur3nDK2NZsihvF/UcHIAVB5WRNopAteiWf/mwNiWWat/gE
	QoaOwQ3XZoQMnp5xS0VByfcuebxT9Raw/JJ4y8OlY15VvWBsOKqGBfuKktp3lIy/X/IE5B
	m2M1jVk7KgZ8cGhgBDVNjzek9/CcSMc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755863923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f7gi6uTIAbJXxsBFd42XtmibQjWWyauIQUPbXJcUiqU=;
	b=ZJ0vXvGoE12p8piY+WCzr9d4ur3nDK2NZsihvF/UcHIAVB5WRNopAteiWf/mwNiWWat/gE
	QoaOwQ3XZoQMnp5xS0VByfcuebxT9Raw/JJ4y8OlY15VvWBsOKqGBfuKktp3lIy/X/IE5B
	m2M1jVk7KgZ8cGhgBDVNjzek9/CcSMc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFFC3139B7;
	Fri, 22 Aug 2025 11:58:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ADiZKnNbqGh1XAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 22 Aug 2025 11:58:43 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com,
	David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: factor out fixup worker check and use it in extent_writepage_io()
Date: Fri, 22 Aug 2025 13:57:34 +0200
Message-ID: <20250822115837.1793314-1-dsterba@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

The whole cow fixup machinery is under experimental build but all we
care about is the check that that a folio is properly set up for IO.
This has uncovered some bugs so keep it but make it standalone and
independent of the fixup worker. The detection and report is copied from
btrfs_writepage_cow_fixup() and simplified.

Signed-off-by: David Sterba <dsterba@suse.com>
---

RFC, the fixup worker cleanups can be done on top of that.

 fs/btrfs/extent_io.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 426a6791a0b221..92dc75f051a3ae 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1642,6 +1642,32 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	return 0;
 }
 
+/*
+ * Check that the folio has been set up for IO  and its range has an ordered
+ * extent.
+ *
+ * Historical note: this used to be fixup worker that handled pages/folios
+ * dirtied out-of-band outside of the filesystem and restarted the whole
+ * process again. This cannot happen anymore since 5.8 and get_user_pages()
+ * update. This check is to catch bugs.
+ *
+ * Return: true if the check fails and folio is dirty
+ */
+static bool btrfs_check_folio_for_writepage(struct folio *folio)
+{
+	struct btrfs_inode *inode = folio_to_inode(folio);
+
+	/* This folio has ordered extent covering it already */
+	if (folio_test_ordered(folio))
+		return false;
+
+	DEBUG_WARN();
+	btrfs_err_rl(inode->root->fs_info,
+"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
+		     btrfs_root_id(inode->root), btrfs_ino(inode), folio_pos(folio));
+	return true;
+}
+
 /*
  * Helper for extent_writepage().  This calls the writepage start hooks,
  * and does the loop to map the page into extents and bios.
@@ -1669,18 +1695,12 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	ASSERT(start >= folio_start &&
 	       start + len <= folio_start + folio_size(folio));
 
-	ret = btrfs_writepage_cow_fixup(folio);
-	if (ret == -EAGAIN) {
-		/* Fixup worker will requeue */
-		folio_redirty_for_writepage(bio_ctrl->wbc, folio);
-		folio_unlock(folio);
-		return 1;
-	}
-	if (ret < 0) {
+	ret = btrfs_check_folio_for_writepage(folio);
+	if (ret) {
 		btrfs_folio_clear_dirty(fs_info, folio, start, len);
 		btrfs_folio_set_writeback(fs_info, folio, start, len);
 		btrfs_folio_clear_writeback(fs_info, folio, start, len);
-		return ret;
+		return -EUCLEAN;
 	}
 
 	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
-- 
2.50.1


