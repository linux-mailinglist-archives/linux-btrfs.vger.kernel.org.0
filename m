Return-Path: <linux-btrfs+bounces-19203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD21C72AA3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 08:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1ED804E68E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B98C2F6922;
	Thu, 20 Nov 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lRL/lhGQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lRL/lhGQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CF3016EF
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625136; cv=none; b=ZCN4vw2Fd0WWMj3OPfU7rYbOAGp0Bi8gkjMvl++opvEqJiZwkGMEjvyWDTfD5P0xGNHfZKoXj9y43DBntc5QGcFwdQxf4ngqxeSkfWkVii8teoQ7q2A8J21Y4k/pdp1qZ8pwvnMwTDyNWe+/+JvwLHSyIcng8bM39abTcCNcyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625136; c=relaxed/simple;
	bh=upR/I0vz1YBuC4h9BeaVWGylQBI3CDHVXYZBdy1cgg0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xl+mmz3kTiBP7craTV4Jf1x9wL8IQcZ2RTdghw7D/KdQS/1HohBNLNW+spzLBZLcYFT4oNS6N7ingCp+W+nd98Jk9V+MqbCR2/dO0PzQzKHgP5wMNaKnAaMBUsrNH+qpXZGw3GU30xZK0baZO2bUYQq8YoYuT660bE/dJun6iAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lRL/lhGQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lRL/lhGQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A065A208F5
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763625124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PtVNXnsB30auFS+Nk48PK9hEpEjQV5Q+BLSh/ddfuM=;
	b=lRL/lhGQQzy75YWaXCSI0EYnlNRhkT6LVXUSO65os7IxlrUEvAtcH+h4ZpagSdSigVGztd
	cKHm9xqLlEs/gjF9d/rknuWKh0p0i+Zmtq0LiHfG4UCObx7b0eI6lXOTipPSrMiTFJF7Bd
	rZKuAmEZQr4Jzz1gHvf/1Eu36W7Pa2A=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="lRL/lhGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763625124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PtVNXnsB30auFS+Nk48PK9hEpEjQV5Q+BLSh/ddfuM=;
	b=lRL/lhGQQzy75YWaXCSI0EYnlNRhkT6LVXUSO65os7IxlrUEvAtcH+h4ZpagSdSigVGztd
	cKHm9xqLlEs/gjF9d/rknuWKh0p0i+Zmtq0LiHfG4UCObx7b0eI6lXOTipPSrMiTFJF7Bd
	rZKuAmEZQr4Jzz1gHvf/1Eu36W7Pa2A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAA263EA61
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AHESJ6PIHmmAQwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: integrate the error handling of submit_one_sector()
Date: Thu, 20 Nov 2025 18:21:41 +1030
Message-ID: <0820ae8e54e15aee7def8421f33a71ca3af536c0.1763620860.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763620860.git.wqu@suse.com>
References: <cover.1763620860.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A065A208F5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

Currently submit_one_sector() has only one failure pattern from
btrfs_get_extent().

However the error handling is split into two part, one inside
submit_one_sector(), which clear the dirty flag and finish the writeback
for the fs block.

The other part of the error handling is to submit any remaining bio
inside bio_ctrl and mark the ordered extent for the fs block as
finished.

There is no special reason that we must split the error handling, let's
just concentrace all the error handling inside submit_one_sector().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2044b889c887..0f1bf9a4f0ae 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1598,7 +1598,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 /*
  * Return 0 if we have submitted or queued the sector for submission.
- * Return <0 for critical errors, and the sector will have its dirty flag cleared.
+ * Return <0 for critical errors, and the involved sector will be cleaned up.
  *
  * Caller should make sure filepos < i_size and handle filepos >= i_size case.
  */
@@ -1622,6 +1622,13 @@ static int submit_one_sector(struct btrfs_inode *inode,
 
 	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
 	if (IS_ERR(em)) {
+		/*
+		 * bio_ctrl may contain a bio crossing several folios.
+		 * Submit it immediately so that the bio has a chance
+		 * to finish normally, other than marked as error.
+		 */
+		submit_one_bio(bio_ctrl);
+
 		/*
 		 * When submission failed, we should still clear the folio dirty.
 		 * Or the folio will be written back again but without any
@@ -1630,6 +1637,13 @@ static int submit_one_sector(struct btrfs_inode *inode,
 		btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
 		btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
 		btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
+
+		/*
+		 * Since there is no bio submitted to finish the ordered
+		 * extent, we have to manually finish this sector.
+		 */
+		btrfs_mark_ordered_io_finished(inode, folio, filepos,
+					       fs_info->sectorsize, false);
 		return PTR_ERR(em);
 	}
 
@@ -1739,19 +1753,6 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		}
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
 		if (unlikely(ret < 0)) {
-			/*
-			 * bio_ctrl may contain a bio crossing several folios.
-			 * Submit it immediately so that the bio has a chance
-			 * to finish normally, other than marked as error.
-			 */
-			submit_one_bio(bio_ctrl);
-			/*
-			 * Failed to grab the extent map which should be very rare.
-			 * Since there is no bio submitted to finish the ordered
-			 * extent, we have to manually finish this sector.
-			 */
-			btrfs_mark_ordered_io_finished(inode, folio, cur,
-						       fs_info->sectorsize, false);
 			if (!found_error)
 				found_error = ret;
 			continue;
-- 
2.52.0


