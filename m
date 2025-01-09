Return-Path: <linux-btrfs+bounces-10822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC67A07317
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBAF3A97EB
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05E4218ADA;
	Thu,  9 Jan 2025 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ujxbIChE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ujxbIChE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F8D2165FB
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418258; cv=none; b=T4cpdqCjElBMp90pUab+asLiDAeV0NDnbKQaJvj/Pf1XgoFsUSVJ8gUjDaWPr+Q6XOdrs9DB/VjuroxjEbe+OPA7qxVxGmyIspUFYAvT06C+QN0gZstgq2bZb6Gf4P/sMS3hXJ3VIdezx7jVUovams5LaBB2BFQtpVENRjzm1x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418258; c=relaxed/simple;
	bh=9U9wD9lRcp5CqwVKTxPQJY9n01Lm07SMSW3FkrD1CLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoLfVIW0wkMetN6K1bAdmxLo4YkyCY89claXMCeP5fxsXCR+e/eXV2cGVPYWPMvF1j8km7DGUDpqa5YBC3Wf1prsJgMxl9QC0H2aeMjHUmzsKNnbjngOigxfLg22uODvbV5KIBrqFI9l3mOBDX872Q5oRKqIrV6Sof8iZqbXB+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ujxbIChE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ujxbIChE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AE5A1F385;
	Thu,  9 Jan 2025 10:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2Z1oUOSiahU46pbxR39GLsIfqyI99KLD78q5Sco5nE=;
	b=ujxbIChEvTAhm4CvrWDxVN88iPsQGVFblwx8MP21Lxsr1te9oKGdBNzTsn0QJWYT4UqA2v
	DUl2pcOYlv9FpQNA19SoS2iyx0+5OGt9biOCJFkxVARp3cVMGgrLUIjopupyz5MG6CchUu
	gR5KT+Mnn6SwzsqKynJyyUaF6eMKOXA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2Z1oUOSiahU46pbxR39GLsIfqyI99KLD78q5Sco5nE=;
	b=ujxbIChEvTAhm4CvrWDxVN88iPsQGVFblwx8MP21Lxsr1te9oKGdBNzTsn0QJWYT4UqA2v
	DUl2pcOYlv9FpQNA19SoS2iyx0+5OGt9biOCJFkxVARp3cVMGgrLUIjopupyz5MG6CchUu
	gR5KT+Mnn6SwzsqKynJyyUaF6eMKOXA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73DAC139AB;
	Thu,  9 Jan 2025 10:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 81dHHM+jf2cxEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:15 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 06/18] btrfs: rename __get_extent_map() and pass btrfs_inode
Date: Thu,  9 Jan 2025 11:24:15 +0100
Message-ID: <4e3082660246c416f1c71b639b1c295ec5b4098f.1736418116.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736418116.git.dsterba@suse.com>
References: <cover.1736418116.git.dsterba@suse.com>
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
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The double underscore naming scheme does not apply here, there's only
only get_extent_map(). As the definition is changed also pass the struct
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 39113772241b..f503735c302c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -895,9 +895,9 @@ void clear_folio_extent_mapped(struct folio *folio)
 	folio_detach_private(folio);
 }
 
-static struct extent_map *__get_extent_map(struct inode *inode,
-					   struct folio *folio, u64 start,
-					   u64 len, struct extent_map **em_cached)
+static struct extent_map *get_extent_map(struct btrfs_inode *inode,
+					 struct folio *folio, u64 start,
+					 u64 len, struct extent_map **em_cached)
 {
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
@@ -916,14 +916,14 @@ static struct extent_map *__get_extent_map(struct inode *inode,
 		*em_cached = NULL;
 	}
 
-	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start, start + len - 1, &cached_state);
-	em = btrfs_get_extent(BTRFS_I(inode), folio, start, len);
+	btrfs_lock_and_flush_ordered_range(inode, start, start + len - 1, &cached_state);
+	em = btrfs_get_extent(inode, folio, start, len);
 	if (!IS_ERR(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
 		*em_cached = em;
 	}
-	unlock_extent(&BTRFS_I(inode)->io_tree, start, start + len - 1, &cached_state);
+	unlock_extent(&inode->io_tree, start, start + len - 1, &cached_state);
 
 	return em;
 }
@@ -979,8 +979,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 			end_folio_read(folio, true, cur, iosize);
 			break;
 		}
-		em = __get_extent_map(inode, folio, cur, end - cur + 1,
-				      em_cached);
+		em = get_extent_map(BTRFS_I(inode), folio, cur, end - cur + 1, em_cached);
 		if (IS_ERR(em)) {
 			end_folio_read(folio, false, cur, end + 1 - cur);
 			return PTR_ERR(em);
-- 
2.47.1


