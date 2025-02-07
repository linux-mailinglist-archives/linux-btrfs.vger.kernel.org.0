Return-Path: <linux-btrfs+bounces-11337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BD6A2BA36
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 05:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C773A7A3401
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 04:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4FF233149;
	Fri,  7 Feb 2025 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CD6Kt9vs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CD6Kt9vs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7E233134
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738902394; cv=none; b=hhkGZvTOdLUddTjuBuZSFCSY2CMgbrohE92IYNbHRBzF8zyW6c0RxueXnybFIJ15I+Sipjoc0tqGgJuec+WYQV/Ex74SY5Sb6lUOeYNuNFWLSGT1IvKl8p/236z1hjadzYpZxlROshKUj5RFhzQCo7WDsuUyoJH1Tg+VgDxZOJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738902394; c=relaxed/simple;
	bh=/PG3V8HED8CdjFji7/11dorgkB3NwuwvecD6of+L14c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJvCnyusMKthIYotIvHBnoV3vrSAvgrwQ81A5WzUryAHfRJC37ZFrolZcImAIF3sLhG/fC0k3MD2/+Zg8I5MeBq/dRP1TYNgBr/EnylDB8wCjGzG0ejM8/LYyQvoBF6kK0PCf0oHDhClM6GAhMNxpbh0NITYcEsG/iGxpVBCIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CD6Kt9vs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CD6Kt9vs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C33D71F443
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738902390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6wnDHZrviQ9C/zGs7Xt9ZDmXodcPLzEtsOEUplDLl8=;
	b=CD6Kt9vs+EcrtlzENasDBzBrJZXLGJLVW4dfxmyuAgQGr/zjk4us/UGYrkWcK2aH0RdM5P
	IoO4+j25QIXCP0oGErsrWFcln85McnoSAemGfKzpPISscs2ZaPAcBwysOf0rBmAxQm9IjL
	AE6JH57MPBICNO/pveMyK1ssLPnGu8Y=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CD6Kt9vs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738902390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6wnDHZrviQ9C/zGs7Xt9ZDmXodcPLzEtsOEUplDLl8=;
	b=CD6Kt9vs+EcrtlzENasDBzBrJZXLGJLVW4dfxmyuAgQGr/zjk4us/UGYrkWcK2aH0RdM5P
	IoO4+j25QIXCP0oGErsrWFcln85McnoSAemGfKzpPISscs2ZaPAcBwysOf0rBmAxQm9IjL
	AE6JH57MPBICNO/pveMyK1ssLPnGu8Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED1EE13806
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sE/lKXWLpWezCgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2025 04:26:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/8] btrfs: make subpage attach and detach to handle metadata properly
Date: Fri,  7 Feb 2025 14:56:02 +1030
Message-ID: <d5bee2fa2f60e7550ca908148ba7e41b285f32de.1738902149.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738902149.git.wqu@suse.com>
References: <cover.1738902149.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C33D71F443
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Currently subpage attach/detach is not doing proper dummy extent buffer
subpage check, as btrfs_is_subpage() is not reliable for dummy extent
buffer folios.

Since we have a metadata specific check now, use that for
btrfs_attach_subpage() first.

Then enhance btrfs_detach_subpage() to accept a type parameter, so that
we can do extra checks for dummy extent buffers properly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c |  6 +++---
 fs/btrfs/subpage.c   | 15 ++++++++++++---
 fs/btrfs/subpage.h   |  3 ++-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c1afd8aab77c..089fb6cecbba 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -888,7 +888,7 @@ void clear_folio_extent_mapped(struct folio *folio)
 
 	fs_info = folio_to_fs_info(folio);
 	if (btrfs_is_subpage(fs_info, folio->mapping))
-		return btrfs_detach_subpage(fs_info, folio);
+		return btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
 
 	folio_detach_private(folio);
 }
@@ -2622,7 +2622,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 	 * attached to one dummy eb, no sharing.
 	 */
 	if (!mapped) {
-		btrfs_detach_subpage(fs_info, folio);
+		btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADATA);
 		return;
 	}
 
@@ -2633,7 +2633,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 	 * page range and no unfinished IO.
 	 */
 	if (!folio_range_has_eb(folio))
-		btrfs_detach_subpage(fs_info, folio);
+		btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADATA);
 
 	spin_unlock(&folio->mapping->i_private_lock);
 }
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index bff4c8a80205..2119bf2e67ac 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -104,7 +104,11 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 		ASSERT(folio_test_locked(folio));
 
 	/* Either not subpage, or the folio already has private attached. */
-	if (!btrfs_is_subpage(fs_info, folio->mapping) || folio_test_private(folio))
+	if (folio_test_private(folio))
+		return 0;
+	if (type == BTRFS_SUBPAGE_METADATA && !btrfs_meta_is_subpage(fs_info))
+		return 0;
+	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio->mapping))
 		return 0;
 
 	subpage = btrfs_alloc_subpage(fs_info, type);
@@ -115,12 +119,17 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *folio)
+void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *folio,
+			  enum btrfs_subpage_type type)
 {
 	struct btrfs_subpage *subpage;
 
 	/* Either not subpage, or the folio already has private attached. */
-	if (!btrfs_is_subpage(fs_info, folio->mapping) || !folio_test_private(folio))
+	if (!folio_test_private(folio))
+		return;
+	if (type == BTRFS_SUBPAGE_METADATA && !btrfs_meta_is_subpage(fs_info))
+		return;
+	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio->mapping))
 		return;
 
 	subpage = folio_detach_private(folio);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 8093baf69636..0046403774f2 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -98,7 +98,8 @@ static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
 
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 			 struct folio *folio, enum btrfs_subpage_type type);
-void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *folio);
+void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *folio,
+			  enum btrfs_subpage_type type);
 
 /* Allocate additional data where page represents more than one sector */
 struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
-- 
2.48.1


