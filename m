Return-Path: <linux-btrfs+bounces-16906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5304CB823E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 01:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138C13BB35C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 23:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DFC30B51D;
	Wed, 17 Sep 2025 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mw+k3SCF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mw+k3SCF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72880306486
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150673; cv=none; b=qlIpTu2l5P31SGHcqMycoIJiXTQWmzpx2lWNyi+jDWkxyvsprbaLwg0djsg4jpIVZuV5eqkfJJdakRpOVlOFWz4paNhUykWBEAG+JvshT9xwmCNQb7xxfO3+30I8NRLAA2bRT1VJ4PsRmvpzYYUd4gMEnnAE0RqRGgngp/q5ZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150673; c=relaxed/simple;
	bh=4vWSdwgLQK5XEn9HT2OlPJPHb/OHOAvoO/DO/sm8f6M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XqtdXiddCbJ/fEy8LtAHxkZmVmFdxxOU7DvZ0FUtxFWYzaiHVzKAG187Dre/GjNHaJLwEUMIbZunruC074JHtqiA+axMtEfokJ4K8StrRdPGrF7GJnjZCayQLn4N/SwTyXa3bJpnBfHxmnnRrdT2CGbqICAi2LPJRvLxUo/HnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mw+k3SCF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mw+k3SCF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B0B75D33C
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 23:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758150668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/l9uZtJFzyXHu5rbJFkZIAMFCYNbVcYJPV8Kn4Gn2LM=;
	b=mw+k3SCFv+0w645JiC52zt/YvfAtF0xIwc11er2oS34D4fjL+gBe3q4wGxXR73HI7ArBxk
	WhW/gscyehXOEuLOhPGIH/Mypgm20AfmdhnAJ7RbUy559JpT3r6omKSgPMRFR/ix0Xd5zj
	xHpnmjuDpdii2dt+rFE27HK1EUSdfpg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758150668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/l9uZtJFzyXHu5rbJFkZIAMFCYNbVcYJPV8Kn4Gn2LM=;
	b=mw+k3SCFv+0w645JiC52zt/YvfAtF0xIwc11er2oS34D4fjL+gBe3q4wGxXR73HI7ArBxk
	WhW/gscyehXOEuLOhPGIH/Mypgm20AfmdhnAJ7RbUy559JpT3r6omKSgPMRFR/ix0Xd5zj
	xHpnmjuDpdii2dt+rFE27HK1EUSdfpg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADAE61368D
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 23:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2szmGgtAy2jgJAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 23:11:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: return any hit error from extent_writepage_io()
Date: Thu, 18 Sep 2025 08:40:45 +0930
Message-ID: <d2cb65804f04fa6cc129af20583e2b2ed939ffca.1758150636.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80

Since the support of bs < ps support, extent_writepage_io() will submit
multiple blocks inside the folio.

But if we hit error submitting one sector, but the next sector can still
be submitted successfully, the function extent_writepage_io() will still
return 0.

This will make btrfs to silently ignore the error without setting error
flag for the filemap.

Fix it by recording the first error hit, and always return that value.

Fixes: 8bf334beb349 ("btrfs: fix double accounting race when extent_writepage_io() failed")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 258658856195..5daeb596e99b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1682,7 +1682,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long range_bitmap = 0;
 	bool submitted_io = false;
-	bool error = false;
+	int found_error = 0;
 	const u64 folio_start = folio_pos(folio);
 	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
 	u64 cur;
@@ -1746,7 +1746,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			 */
 			btrfs_mark_ordered_io_finished(inode, folio, cur,
 						       fs_info->sectorsize, false);
-			error = true;
+			if (!found_error)
+				found_error = ret;
 			continue;
 		}
 		submitted_io = true;
@@ -1763,11 +1764,11 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	 * If we hit any error, the corresponding sector will have its dirty
 	 * flag cleared and writeback finished, thus no need to handle the error case.
 	 */
-	if (!submitted_io && !error) {
+	if (!submitted_io && !found_error) {
 		btrfs_folio_set_writeback(fs_info, folio, start, len);
 		btrfs_folio_clear_writeback(fs_info, folio, start, len);
 	}
-	return ret;
+	return found_error;
 }
 
 /*
-- 
2.50.1


