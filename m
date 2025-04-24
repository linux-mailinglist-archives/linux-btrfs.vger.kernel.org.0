Return-Path: <linux-btrfs+bounces-13390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C917AA9B1C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 17:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CAB9A04A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8FC27CCCD;
	Thu, 24 Apr 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nfLW2lSB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nfLW2lSB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BAF27A926
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507321; cv=none; b=M1qdiir8g7Sf6PPfbydmHcW6l6uYWtxmkAkMvGZ5Yf4i3OPRMPPYH9mfH51l5m3z3aKYEMQJgbRuYQzNN+jzZ1bWU/S0hj65qn+oSVlvtM2SuPney7WJSZJafhGpEWOhaFhALvNuquR/Wy8gVNHm2WBjNfBawBkWwB712JYM6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507321; c=relaxed/simple;
	bh=9NytHyLqIfxIvx6lZdFMYugLXYuMBXHPHYAR+msjyJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQjZzSXwsPPWeVpKAnf6lvg0ohdCtpJre+9swvngcW/C0R7P+sEKqe1zrkyXW2uF/DNpOrzYYWabAsUoZsm245NAwkcGfqVcvfK30wdVbDb4N9d1Ih0Lyw7v/SiiDba2AuA1cnkAVK4C1frG6zQj1hFB+90MefZvevWeiWuQo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nfLW2lSB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nfLW2lSB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F9721F44E;
	Thu, 24 Apr 2025 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745507316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Exg5EiogDAfrxAUX7DKa9Dpbvs5eJ+o3L1bhSjAeGx8=;
	b=nfLW2lSB/NzpKCFbm+2QDGoyfWdnkXTG9WEGJOxGEue1ZVNulOb18A5SCAYIOgKoyno5uW
	z8VhxRdLtT4vOq885cFBivq3aJsw/f25ey/KQ2Hy40qmaKJfz7YPmNUxBscUOQc9LKFo4o
	nalcyzyJPc/5KkfWhtfQwkqrLbp/BL4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nfLW2lSB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745507316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Exg5EiogDAfrxAUX7DKa9Dpbvs5eJ+o3L1bhSjAeGx8=;
	b=nfLW2lSB/NzpKCFbm+2QDGoyfWdnkXTG9WEGJOxGEue1ZVNulOb18A5SCAYIOgKoyno5uW
	z8VhxRdLtT4vOq885cFBivq3aJsw/f25ey/KQ2Hy40qmaKJfz7YPmNUxBscUOQc9LKFo4o
	nalcyzyJPc/5KkfWhtfQwkqrLbp/BL4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86D74139D0;
	Thu, 24 Apr 2025 15:08:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y+5eIPRTCmg5fgAAD6G6ig
	(envelope-from <neelx@suse.com>); Thu, 24 Apr 2025 15:08:36 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs: put all allocated extent buffer folios in failure case
Date: Thu, 24 Apr 2025 17:08:08 +0200
Message-ID: <20250424150809.4170099-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250422125701.3939257-1-neelx@suse.com>
References: <20250422125701.3939257-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F9721F44E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

When attaching a folio fails, for example if another one is already mapped,
we need to put all newly allocated folios. And as a consequence we do not
need to flag the eb UNMAPPED anymore.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/extent_io.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 197f5e51c4744..7023dd527d3e7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3385,30 +3385,26 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * we'll lookup the folio for that index, and grab that EB.  We do not
 	 * want that to grab this eb, as we're getting ready to free it.  So we
 	 * have to detach it first and then unlock it.
-	 *
-	 * We have to drop our reference and NULL it out here because in the
-	 * subpage case detaching does a btrfs_folio_dec_eb_refs() for our eb.
-	 * Below when we call btrfs_release_extent_buffer() we will call
-	 * detach_extent_buffer_folio() on our remaining pages in the !subpage
-	 * case.  If we left eb->folios[i] populated in the subpage case we'd
-	 * double put our reference and be super sad.
 	 */
-	for (int i = 0; i < attached; i++) {
-		ASSERT(eb->folios[i]);
-		detach_extent_buffer_folio(eb, eb->folios[i]);
-		folio_unlock(eb->folios[i]);
-		folio_put(eb->folios[i]);
+	for (int i = 0; i < num_extent_pages(eb); i++) {
+		struct folio *folio = eb->folios[i];
+
+		if (i < attached) {
+			ASSERT(folio);
+			detach_extent_buffer_folio(eb, folio);
+			folio_unlock(folio);
+		} else if (!folio)
+			continue;
+
+		ASSERT(!folio_test_private(folio));
+		folio_put(folio);
 		eb->folios[i] = NULL;
 	}
-	/*
-	 * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
-	 * so it can be cleaned up without utilizing folio->mapping.
-	 */
-	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
-
 	btrfs_release_extent_buffer(eb);
+
 	if (ret < 0)
 		return ERR_PTR(ret);
+
 	ASSERT(existing_eb);
 	return existing_eb;
 }
-- 
2.47.2


