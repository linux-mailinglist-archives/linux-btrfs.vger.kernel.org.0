Return-Path: <linux-btrfs+bounces-9880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DCF9D7947
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 00:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA34EB246BE
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 23:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB9E18C03F;
	Sun, 24 Nov 2024 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MdulkvLr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aQXotmp4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315E6F06D
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492676; cv=none; b=pwPDKUGbt2N416Ajv3lfY+9mb1p8gxfgxDzzSCqQLOyAtN9Qdg57CQhmY9EM0VrHLDtTb0M5SRxbncv/RndboLNWi8iCCbecUpb6ny5SCB+zrrYk2ahyhllDihKKJ0NKdK1zkzfXTvZOsOFiDEicoXZ3Y8tr8qy4Nj1tu32EoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492676; c=relaxed/simple;
	bh=Vm4d13l0CvAR50OVqhFblQ1yg8lcF2qUoxyscmkpLlk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqXGKgdZeWJXJSqYlXaV4V6AE7GFXa1DsfJ/nDnwK4AVoc5KcHSkFaujPMaGxaXHwgE890bcQIrOmngQaFBmM2/+ELLVD/bBVLywOFrD4yq/Z3XHrOZYs9raFS0DjLSv1hiTCZtdlEmk9W6ZYynYem+lPV6pjXTCpkv/nMXf408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MdulkvLr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aQXotmp4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECB421F393
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732492673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=so7/6GOxeSpbQNjQboq6R+3Z6R/ExJ2IA1K0ZFLXALA=;
	b=MdulkvLrEi8jluL96UfDqJvhJ4wIDIjGaj0AEYMtb8AKDq9tkcyAhwULUW5hlTrkftSAC/
	Z3xin86GnaCw9vXaulA/cb9w+AIv73u9UnfgulqhKeblbNWzJTW6x94o7/2yYQnjRn5n0g
	aYDGeh0s0L5ZKOm2bT42SEoyC5YBnIo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=aQXotmp4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732492672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=so7/6GOxeSpbQNjQboq6R+3Z6R/ExJ2IA1K0ZFLXALA=;
	b=aQXotmp4XHM3kBUqArxidmEC+clx4kOSoP/0n1uMEP8LPHVydCwJ8tYn2HIrMZNAjmMAqp
	io3of/NZquMqRjEerhs4tyFeWv6MG7tRl+YOAapY6gSe9lC+lkLLr9Y7l6FAZ+1MdvniF4
	gVmfV2y4MOvUVBTul14EYmEiPoF/j2U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D94E132CF
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GJQgLn+9Q2emSQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/7] btrfs: use FGP_STABLE to wait for folio writeback
Date: Mon, 25 Nov 2024 10:27:24 +1030
Message-ID: <70c6b105c5aab0336c1c491b0c1158cc6b8e3fd4.1732492421.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732492421.git.wqu@suse.com>
References: <cover.1732492421.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECB421F393
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
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
index 968dae953948..c7fef49bbec8 100644
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
index f9b1d78eb7ff..09dbf5f22304 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4775,7 +4775,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	}
 again:
 	folio = __filemap_get_folio(mapping, index,
-				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT | FGP_STABLE, mask);
 	if (IS_ERR(folio)) {
 		btrfs_delalloc_release_space(inode, data_reserved, block_start,
 					     blocksize, true);
@@ -4808,8 +4808,6 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	if (ret < 0)
 		goto out_unlock;
 
-	folio_wait_writeback(folio);
-
 	lock_extent(io_tree, block_start, block_end, &cached_state);
 
 	ordered = btrfs_lookup_ordered_extent(inode, block_start);
-- 
2.47.0


