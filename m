Return-Path: <linux-btrfs+bounces-12634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4F2A740E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 23:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB1E188B9DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 22:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F531EF379;
	Thu, 27 Mar 2025 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NInpTuA8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NInpTuA8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589611DDA0E
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114699; cv=none; b=qrOR2/RocneIN/eD/fBFdRKF/2uZFmDYxN0qicxTd8HRvwtRjcRJ/WWxMAKI/DSf9bzLhjTpwqb1Ht4ao2dKqiEfIilvP5Ii4Y48mFhmRMCi/MtkiNKBczYCezIRNJJ9Whh/ThVEQQBzj6Oj3UnBBOcr6C9GEmcqSgihooiDiAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114699; c=relaxed/simple;
	bh=gj/r7fzl4OxNxnURl9/HDbo0Y7XhebwKBS+AVKTbY/A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeGNYFH70eT3SIqBcXkrGsNP15mSY6dOIBdUSTKTj3WSRqZJ7q+EhDB6+eyOJp6ROJjU9lejLbz9fJmhSNPin4hVqy7oiPqwrmhn8qJ64QCntmY8dOOqAxSDZGkTcfyAGNt6y2IQyt2Ki6YXWGjIjZCnrZX67u+FaQFZMX4fPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NInpTuA8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NInpTuA8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AF5F1F38A
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743114689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84YbaJCSLoFSiw8NY4WN16+six+y+O/qvtMGiMpsQxg=;
	b=NInpTuA8khVtymX5IsR+5shaFVtbn1pHt0LzBreAOkEazR4h2uqXPtXa95xx8Qf5bcjApw
	QluMYj4R/28jZJMvf/+iFobXxoQbnw886t9W8N9ygmAQIkq+heSmqkhMIt7mllwMXDtdvI
	CNlj3gKPtJuN9aiLW687eKqXzbrW8bM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NInpTuA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743114689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84YbaJCSLoFSiw8NY4WN16+six+y+O/qvtMGiMpsQxg=;
	b=NInpTuA8khVtymX5IsR+5shaFVtbn1pHt0LzBreAOkEazR4h2uqXPtXa95xx8Qf5bcjApw
	QluMYj4R/28jZJMvf/+iFobXxoQbnw886t9W8N9ygmAQIkq+heSmqkhMIt7mllwMXDtdvI
	CNlj3gKPtJuN9aiLW687eKqXzbrW8bM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5F95139D4
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GNHkHcDR5WfMagAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: subpage: fix a bug that blocks large folios
Date: Fri, 28 Mar 2025 09:01:02 +1030
Message-ID: <428b3c09f6df2820865640e2cf91a7cc0c1b4119.1743113694.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743113694.git.wqu@suse.com>
References: <cover.1743113694.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7AF5F1F38A
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Inside the macro, subpage_calc_start_bit(), we needs to calculate the
offset to the beginning of the folio.

But we're using offset_in_page(), on systems with 4K page size and 4K fs
block size, this means we will always return offset 0 for a large folio,
causing all kinds of errors.

Fix it by using offset_in_folio() instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 5b69c447fec9..5fbdd977121e 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -202,7 +202,7 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 			   btrfs_blocks_per_folio(fs_info, folio);	\
 									\
 	btrfs_subpage_assert(fs_info, folio, start, len);		\
-	__start_bit = offset_in_page(start) >> fs_info->sectorsize_bits; \
+	__start_bit = offset_in_folio(folio, start) >> fs_info->sectorsize_bits; \
 	__start_bit += blocks_per_folio * btrfs_bitmap_nr_##name;	\
 	__start_bit;							\
 })
-- 
2.49.0


