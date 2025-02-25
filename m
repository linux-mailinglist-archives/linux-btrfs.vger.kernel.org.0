Return-Path: <linux-btrfs+bounces-11783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B81EA44813
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 18:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3921711FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6442E1A38F9;
	Tue, 25 Feb 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r5IbWKGr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r5IbWKGr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3619922F
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504293; cv=none; b=j142gq/c1LUcq9rAj7uB/0Kn0EGIOLiGkEjZtKWDV6iwPrMK2XWE+RQaK45jDiUEOK5QpdEh9Q3+Y3qsoX073mdr3SICb34NpyDBUnTCMuY138AbU2S775TfxxS2I2mQ1DG2nGki0UNckEccBo0sZRoH1RB/zs857E0hGNuWYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504293; c=relaxed/simple;
	bh=FTy8FwF52SMeqjG9SkPfkKa5cAxIcK+3Tn0yYkvciLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtmvJvdkakcyhQB1tw5LxrXS1TQIRphFUQcOaYKQC7XhdLil+/A6MyijmHql/soCMo4Mcvq9R1ABDGFkpsgvAK1GcFTz1yhYa1DheXME7yNB3Qgg6gz6Z/sKTJ/w5TQXG8n1JR+X3hyFRAzvAZqLn/S1oscAhZS4FqjheVBBsas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r5IbWKGr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r5IbWKGr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07BF42116A;
	Tue, 25 Feb 2025 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740504284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajuuPpq2b+R30/U+mEC2lLEuw9vfWgZD5mlTpnaxp64=;
	b=r5IbWKGr8hhsQFnuRuzUfKzzCmRpU/Hj7LVt2hnlLyQTGVDiR5xRyczKFJBs/ykcq3rXLn
	WugTfLyNv/7zQ5nWUJaZQLYSHMp8BUIe58Ftd1J9z32BT6nUg6B238WdQu5MkLZTplTDO/
	ROg8o1yyvjQsUhuTcW4FODmh1Oyy/pc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740504284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajuuPpq2b+R30/U+mEC2lLEuw9vfWgZD5mlTpnaxp64=;
	b=r5IbWKGr8hhsQFnuRuzUfKzzCmRpU/Hj7LVt2hnlLyQTGVDiR5xRyczKFJBs/ykcq3rXLn
	WugTfLyNv/7zQ5nWUJaZQLYSHMp8BUIe58Ftd1J9z32BT6nUg6B238WdQu5MkLZTplTDO/
	ROg8o1yyvjQsUhuTcW4FODmh1Oyy/pc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0093313332;
	Tue, 25 Feb 2025 17:24:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 06ggANz8vWcHTwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 25 Feb 2025 17:24:44 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: add __pure attribute to eb page and folio counters
Date: Tue, 25 Feb 2025 18:24:43 +0100
Message-ID: <b7a6e707f2ca61a5bdac9e9b44197276ad2e19dc.1740503982.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740503982.git.dsterba@suse.com>
References: <cover.1740503982.git.dsterba@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The functions qualify for the pure attribute as they always return the
same value for the same argument (in the given scope). This allows to
optimize the calls and cache the value.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 6c5328bfabc2..6440ba7cf35e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -276,7 +276,8 @@ void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
 				u64 bytenr, u64 owner_root, u64 gen, int level);
 void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
 
-static inline int num_extent_pages(const struct extent_buffer *eb)
+/* Note: this can be used in for loops without caching the value in a variable. */
+static inline int __pure num_extent_pages(const struct extent_buffer *eb)
 {
 	/*
 	 * For sectorsize == PAGE_SIZE case, since nodesize is always aligned to
@@ -294,8 +295,10 @@ static inline int num_extent_pages(const struct extent_buffer *eb)
  * As we can have either one large folio covering the whole eb
  * (either nodesize <= PAGE_SIZE, or high order folio), or multiple
  * single-paged folios.
+ *
+ * Note: this can be used in for loops without caching the value in a variable.
  */
-static inline int num_extent_folios(const struct extent_buffer *eb)
+static inline int __pure num_extent_folios(const struct extent_buffer *eb)
 {
 	if (folio_order(eb->folios[0]))
 		return 1;
-- 
2.47.1


