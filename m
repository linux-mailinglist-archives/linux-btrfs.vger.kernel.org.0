Return-Path: <linux-btrfs+bounces-8891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A439299BF2D
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 06:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C05EB2169A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 04:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52D960DCF;
	Mon, 14 Oct 2024 04:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="O12Zj5MY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="O12Zj5MY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BCE231CB1
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728880617; cv=none; b=oGk3b0Ff8ouM0GkBLeirIab0KRiqMj57gCoU7nKj9gD02+VmG7UHCsyQTXL2mtVdJBjhvkQk++DLn7ptnwfkelMJbWmmGU0VsZ2xwnh60Ry1+AnMsXrXDUAPqES6XNqmwSCxkaVfmpr1ZKg2kc2eDlL2+LRB78pfnQF2rrXUeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728880617; c=relaxed/simple;
	bh=UFnh31vF1qmeSeoqsvuO7AurBGjwfc+O7NiVAVVapjk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qKcpRI0NrR7LFka2QIsFIlS2vRRZTCdYOdwnmBUvFCuaU3ILStk+hrA9bO8jWJ0ToXlb+6a1rFt2Cb0GKU3aF10cplxFyQ4V/873aZphiCnj3ymCm/jO4Ykxm9NiUyjMc9DOamr+fumgmxEDxubm6O521s16FaEkcsRkOKhWbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=O12Zj5MY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=O12Zj5MY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91AC521D93
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 04:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728880613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PJ6izFavC2cSwKd/Yd3tL/3FH7Ml1HklK8TqXFVoXyM=;
	b=O12Zj5MYap6133Z0GckyhA6G35r/kmjLo4E6zPGYX8hn0Sc4sVsucuvOOjUUl5V1SwhPJR
	dGsKoKAWAJbX8pc/L77m2azqdh36HuxDD1mYHBY+k+IxyND6MKtlCxuRQvow0kqhd3CUXx
	o1dOJdXGeSGMRvB8AaC2ZgpgGX2OjwE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728880613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PJ6izFavC2cSwKd/Yd3tL/3FH7Ml1HklK8TqXFVoXyM=;
	b=O12Zj5MYap6133Z0GckyhA6G35r/kmjLo4E6zPGYX8hn0Sc4sVsucuvOOjUUl5V1SwhPJR
	dGsKoKAWAJbX8pc/L77m2azqdh36HuxDD1mYHBY+k+IxyND6MKtlCxuRQvow0kqhd3CUXx
	o1dOJdXGeSGMRvB8AaC2ZgpgGX2OjwE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C834D13A42
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 04:36:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zOfBIeSfDGcVMQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 04:36:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use FGP_STABLE to wait for folio writeback
Date: Mon, 14 Oct 2024 15:06:31 +1030
Message-ID: <9b564309ec83dc89ffd90676e593f9d7ce24ae77.1728880585.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
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
X-Spam-Score: -2.80
X-Spam-Flag: NO

__filemap_get_folio() provides the flag FGP_STABLE to wait for
writeback.

There are two call sites doing __filemap_get_folio() then
folio_wait_writeback():

- btrfs_truncate_block()
- defrag_prepare_one_folio()

We can directly utilize that flag instead of manually calling
folio_wait_writeback().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/defrag.c | 4 +---
 fs/btrfs/inode.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index b95ef44c326b..1644470b9df7 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -865,7 +865,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 
 again:
 	folio = __filemap_get_folio(mapping, index,
-				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT | FGP_STABLE, mask);
 	if (IS_ERR(folio))
 		return folio;
 
@@ -1222,8 +1222,6 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 			goto free_folios;
 		}
 	}
-	for (i = 0; i < nr_pages; i++)
-		folio_wait_writeback(folios[i]);
 
 	/* Lock the pages range */
 	lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9ca74e5e7aa6..a21701571cbb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4743,7 +4743,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	}
 again:
 	folio = __filemap_get_folio(mapping, index,
-				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT | FGP_STABLE, mask);
 	if (IS_ERR(folio)) {
 		btrfs_delalloc_release_space(inode, data_reserved, block_start,
 					     blocksize, true);
@@ -4776,8 +4776,6 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	if (ret < 0)
 		goto out_unlock;
 
-	folio_wait_writeback(folio);
-
 	lock_extent(io_tree, block_start, block_end, &cached_state);
 
 	ordered = btrfs_lookup_ordered_extent(inode, block_start);
-- 
2.47.0


