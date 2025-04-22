Return-Path: <linux-btrfs+bounces-13224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3971A96B2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 14:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0301189E3E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7843D27F743;
	Tue, 22 Apr 2025 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uiTtboiP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tEwojO2e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0C27CCF2
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326644; cv=none; b=qcGMX6tv9yoP5JK6n/L3w2vRdwenKXXmjAfXaJ78uTnroHFiKIPjaii5FVz7tOrdreuyGbehucMQ2enuW/fkqkDnijHivi176ymdrtnpriC9jiTwJdI6BfLtCeUSPU+ZTQ7MdCR1ncpPX0SZyEWIFlg6+QbfkW3L7ITa0HJjs3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326644; c=relaxed/simple;
	bh=oN5upolC/ceBz754tfv5Nj07/x/XIvPYM/BzIlZip9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWvWVWW8iLFFLW6VApyyUO/UlA9jjbLm2VpGqpWVo19eSO0S5EIPfvPsL2R09HVQ0L6C6mUW8r9k4xLf4ms/8hOkE133jxNfHy7hl3GYo0/z0G1M4l3YwpV0falbBPKXSMCruW0FRb0sFTor6+xQKQBOIhr1Nnl4kA1fSS5ISwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uiTtboiP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tEwojO2e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00DEC211A9;
	Tue, 22 Apr 2025 12:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745326641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E3z0Jj21j5lclYtEBuALwky9xTMKZLiJUfK/o8doT9Y=;
	b=uiTtboiPXwtzbj63gadgpV9xbhYPGJfnLmMnTon8KEytZLglQ64MRxReWkPzpYZarr5WoI
	+oEz1C4WGkWFA4hK9lKvRd6KCme3bO/nCPFooRL7Dlqoe1tpdn/aIm2OGFRkpD+d/V2DRq
	5t6MSDHdmVcGtGmp3A6iJ+gXa48nQ1I=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tEwojO2e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745326640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E3z0Jj21j5lclYtEBuALwky9xTMKZLiJUfK/o8doT9Y=;
	b=tEwojO2eI+QybX9lNv03NlZNrolK63lolBnT5IK6KpALH/+sX6WZbga2Gq3LT33antJj0Q
	QVGTZXFseX6fO/Qm86pxguXxDJd71H2lU3RUSuCngHDfewxUSZcPZJ+SYCyt7iOP+/abV+
	8BaLy8KE3m868bgoO1gwtWNnhFkqWuQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAC3C137CF;
	Tue, 22 Apr 2025 12:57:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /yfVNC+SB2inLQAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 22 Apr 2025 12:57:19 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: unlock all extent buffer folios in failure case
Date: Tue, 22 Apr 2025 14:57:01 +0200
Message-ID: <20250422125701.3939257-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00DEC211A9
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

When attaching a folio fails, for example if another one is already mapped,
we need to unlock all newly allocated folios before putting them. And as a
consequence we do not need to flag the eb UNMAPPED anymore.

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
+	for (int i = 0; i < num_extent_folios(eb); i++) {
+		struct folio *folio = eb->folios[i];
+
+		if (i < attached) {
+			ASSERT(folio);
+			detach_extent_buffer_folio(eb, folio);
+		} else if (!folio)
+			continue;
+
+		ASSERT(!folio_test_private(folio));
+		folio_unlock(folio);
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


