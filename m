Return-Path: <linux-btrfs+bounces-20174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD7DCF95A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C8B73020CF3
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B9A27B50F;
	Tue,  6 Jan 2026 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gTfHRcee";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gTfHRcee"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89104238C3B
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716500; cv=none; b=pRK9p7wVlI3n+pKxX5tJDFiTYijSAHqDS2yxqX5NkwqaiFjrPNc7ym3jESqUz/lz+RApWpeOCC7afyHXcR9FzAEl6dzsR1xa0h8c77BeyF9eTvpBfLMaXW+IkcfwULhA51zvWoGq8x5YMuNYnFEaxbQTrrsaBRNKdjK23N+WiYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716500; c=relaxed/simple;
	bh=u18h7i0zrkWOK56nSXeuzzwK9BC6q7mGsenGCCmcsno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDcqKtp1Dlx9Yi2UxmScngv6GBueOBdbahQjlKSKtirc/4M5tjjZgMmioHkPVEWC8wG0nEecNPqO/8uZSF+PvkXTPmZ/KexLDjpyOkgV0Q6BvVR0u5+3W5q0EogRk9scV4CY1yrMJy9W5bGP1N2585ZJroexgxu00/vmImiLejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gTfHRcee; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gTfHRcee; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8AF5E336C2;
	Tue,  6 Jan 2026 16:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ndU9CBFiDzKRAT/8UV2v7NDFyXdr3nDdxE41naxutng=;
	b=gTfHRceevQBNN1TBiMwxTJgytr3TLaQ0/531mYwtezeyQg39oLVOHeqccWW9dqzucjX1eU
	GPUrObMLhKdgzHJJmpXot0OoQ2BYvbod7uJBuNly6tg0J63QN1+20FiLWH2ya28UD9r8fD
	KXRT1kQieeg0k2trLyrN+yq3Y/knM0E=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ndU9CBFiDzKRAT/8UV2v7NDFyXdr3nDdxE41naxutng=;
	b=gTfHRceevQBNN1TBiMwxTJgytr3TLaQ0/531mYwtezeyQg39oLVOHeqccWW9dqzucjX1eU
	GPUrObMLhKdgzHJJmpXot0OoQ2BYvbod7uJBuNly6tg0J63QN1+20FiLWH2ya28UD9r8fD
	KXRT1kQieeg0k2trLyrN+yq3Y/knM0E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A01A3EA63;
	Tue,  6 Jan 2026 16:21:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6pfHHXk2XWnDWQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:21:13 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/12] btrfs: zstd: reuse total in and out parameters for calculations
Date: Tue,  6 Jan 2026 17:20:33 +0100
Message-ID: <1e419f75980c1014c0fa860ba7ba650f5d51da3c.1767716314.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767716314.git.dsterba@suse.com>
References: <cover.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.980];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

Reduce the stack consumption which is 240 bytes on release config by 16
bytes. The local variables are not adding anything on top of the
parameters. As a calling convention if the compression helper returns an
error the parameters are considered invalid.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zstd.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index c9cddcfa337b91..4edc5f6f63a110 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -408,8 +408,6 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	int nr_folios = 0;
 	struct folio *in_folio = NULL;  /* The current folio to read. */
 	struct folio *out_folio = NULL; /* The current folio to write to. */
-	unsigned long tot_in = 0;
-	unsigned long tot_out = 0;
 	unsigned long len = *total_out;
 	const unsigned long nr_dest_folios = *out_folios;
 	const u64 orig_end = start + len;
@@ -471,23 +469,23 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 		}
 
 		/* Check to see if we are making it bigger */
-		if (tot_in + workspace->in_buf.pos > blocksize * 2 &&
-				tot_in + workspace->in_buf.pos <
-				tot_out + workspace->out_buf.pos) {
+		if (*total_in + workspace->in_buf.pos > blocksize * 2 &&
+				*total_in + workspace->in_buf.pos <
+				*total_out + workspace->out_buf.pos) {
 			ret = -E2BIG;
 			goto out;
 		}
 
 		/* We've reached the end of our output range */
 		if (workspace->out_buf.pos >= max_out) {
-			tot_out += workspace->out_buf.pos;
+			*total_out += workspace->out_buf.pos;
 			ret = -E2BIG;
 			goto out;
 		}
 
 		/* Check if we need more output space */
 		if (workspace->out_buf.pos == workspace->out_buf.size) {
-			tot_out += min_folio_size;
+			*total_out += min_folio_size;
 			max_out -= min_folio_size;
 			if (nr_folios == nr_dest_folios) {
 				ret = -E2BIG;
@@ -506,13 +504,13 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 
 		/* We've reached the end of the input */
 		if (workspace->in_buf.pos >= len) {
-			tot_in += workspace->in_buf.pos;
+			*total_in += workspace->in_buf.pos;
 			break;
 		}
 
 		/* Check if we need more input */
 		if (workspace->in_buf.pos == workspace->in_buf.size) {
-			tot_in += workspace->in_buf.size;
+			*total_in += workspace->in_buf.size;
 			kunmap_local(workspace->in_buf.src);
 			workspace->in_buf.src = NULL;
 			folio_put(in_folio);
@@ -542,16 +540,16 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			goto out;
 		}
 		if (ret2 == 0) {
-			tot_out += workspace->out_buf.pos;
+			*total_out += workspace->out_buf.pos;
 			break;
 		}
 		if (workspace->out_buf.pos >= max_out) {
-			tot_out += workspace->out_buf.pos;
+			*total_out += workspace->out_buf.pos;
 			ret = -E2BIG;
 			goto out;
 		}
 
-		tot_out += min_folio_size;
+		*total_out += min_folio_size;
 		max_out -= min_folio_size;
 		if (nr_folios == nr_dest_folios) {
 			ret = -E2BIG;
@@ -568,14 +566,12 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 		workspace->out_buf.size = min_t(size_t, max_out, min_folio_size);
 	}
 
-	if (tot_out >= tot_in) {
+	if (*total_out >= *total_in) {
 		ret = -E2BIG;
 		goto out;
 	}
 
 	ret = 0;
-	*total_in = tot_in;
-	*total_out = tot_out;
 out:
 	*out_folios = nr_folios;
 	if (workspace->in_buf.src) {
-- 
2.51.1


