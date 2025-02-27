Return-Path: <linux-btrfs+bounces-11890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DFDA47592
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 06:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E03188EB99
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 05:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C0D20B80D;
	Thu, 27 Feb 2025 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PDsx7ezm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PDsx7ezm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45F1EB5F2
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635723; cv=none; b=tvXw/CI+R5fK8JqmbcrKB/qq8Llg7xuZA+tupKrneiPzhepEmO/py1mgLdtFZFiT2tbH7Pa7NVR77tYITE3rMKEyOV8nuyeYjTyURaRfzSDtNEzkuzoXkcI5lMOqKA1CF7fja0FvcUqFWUjRxfmWIMho7T2QPQAofbLoK9MPW4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635723; c=relaxed/simple;
	bh=2Cun2yjMUEixdoKgzcsBPyZzWzHSDn8gXYFr2q12B5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNpayAMI8und1ywnxyldwXf6NRtVPkoObR+lLRJSx2ZG5ndGE6lCYDKQyeQr4rjIQQW3UNQO6qDpPgQFY1ncQKPEfxp8e2w3ZxBnLTRpEV7ZvknAaKaTS+95OTecMajsBOitaTXIh7If2FxTR45kza6CYQnWPA6bQZlffwn+agA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PDsx7ezm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PDsx7ezm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF3C21F44F;
	Thu, 27 Feb 2025 05:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6meds3fS2t/+FKOMd0ARIuLt7nZ4Swq6RkY0SCyUPM=;
	b=PDsx7ezmOksxspx2eiBSZRucMSRFcu7v9S/jEWCxygk9+O746mYT9oGWHB29wf+pXkPZ2S
	ElSn/MfexiumyA0Y7cfKjfC8MU3qn5vwv8p3nCZDwVbyMMI7jhpFSiUMTR9SGMD/KkiFfK
	E4nv/e4djXyJF2iHqlCLSgWx/AgNloo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6meds3fS2t/+FKOMd0ARIuLt7nZ4Swq6RkY0SCyUPM=;
	b=PDsx7ezmOksxspx2eiBSZRucMSRFcu7v9S/jEWCxygk9+O746mYT9oGWHB29wf+pXkPZ2S
	ElSn/MfexiumyA0Y7cfKjfC8MU3qn5vwv8p3nCZDwVbyMMI7jhpFSiUMTR9SGMD/KkiFfK
	E4nv/e4djXyJF2iHqlCLSgWx/AgNloo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD7651376A;
	Thu, 27 Feb 2025 05:55:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MJqiHzz+v2ebUgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 27 Feb 2025 05:55:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 3/8] btrfs: fix the qgroup data free range for inline data extents
Date: Thu, 27 Feb 2025 16:24:41 +1030
Message-ID: <af080b0e36f2958bca87b76439f3c00586714ab9.1740635497.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740635497.git.wqu@suse.com>
References: <cover.1740635497.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Inside function __cow_file_range_inline() since the inlined data no
longer takes any data space, we need to free up the reserved space.

However the code is still using the old page size == sector size
assumption, and will not handle subpage case well.

Thankfully it is not going to cause any problems because we have two extra
safe nets:

- Inline data extents creation is disable for sector size < page size
  cases for now
  But it won't stay that for long.

- btrfs_qgroup_free_data() will only clear ranges which are already
  reserved
  So even if we pass a range larger than what we need, it should still
  be fine, especially there is only reserved space for a single block at
  file offset 0 for an inline data extent.

But just for the sake of consistentcy, fix the call site to use
sectorsize instead of page size.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f06b1c78c399..52802a3a078c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -672,7 +672,7 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	 * And at reserve time, it's always aligned to page size, so
 	 * just free one page here.
 	 */
-	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE, NULL);
+	btrfs_qgroup_free_data(inode, NULL, 0, fs_info->sectorsize, NULL);
 	btrfs_free_path(path);
 	btrfs_end_transaction(trans);
 	return ret;
-- 
2.48.1


