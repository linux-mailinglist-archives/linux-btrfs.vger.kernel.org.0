Return-Path: <linux-btrfs+bounces-20075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD83CEE03E
	for <lists+linux-btrfs@lfdr.de>; Fri, 02 Jan 2026 09:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D113007FF8
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jan 2026 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492A2D594A;
	Fri,  2 Jan 2026 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ji43rNkX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ji43rNkX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA811D6BB
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Jan 2026 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767342512; cv=none; b=gw9877T3qQYSKvmln8QU+d8pXJfqGyHykHusxI1pHaHR9e6DIll9GL9hFfquBoJJPCNbioOwkqB4rMQLr7QSdVEp7QTV/3P6gCqvMODrEBdWYzuvLVc/spAVeBSDgvGTa4gsOZHs0EGSGHWBnX7aJfa3Wi6pwzeqrT35vTGScCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767342512; c=relaxed/simple;
	bh=XOPAxwBgWwLQdt/1jfKi9SUX5iWs3JaeCtwbpCU0PUU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a1kjH1iaZ0dv9xloNX1HZCGzo7/XAueABISWtiKmKvM0mvwUTCBt0r6Ij13e4bkoba4tUERdmiaeHtvjZR6WZXJv5CL5k48Fl48UJy/KHWOg3aiTcSRYSAGm7ryn2q7ZNi/PJ4+tsrYEzoi5Fj6O0wuBUnX6yAtJyWamu4iivVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ji43rNkX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ji43rNkX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 874FF5BD11
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Jan 2026 08:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767342503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JwXs0TWTvQyru/1FJnT7PceUZ5PM1i44sl3H0M6R59k=;
	b=ji43rNkXXG2hRA9ZMRxA+zoORN8JUoVdJw6FYDxE302ZH5YCmMK3sa/m8XwavZe1M5aS6D
	dKSUuj4+tnI8kDuj+rhkS4kZS8GgYXWnONI39yzx8f+LLGlrZ8EctZ+iEev1XSaXVpiDef
	jU5daNtizXE8wuxbiQb+970iMDTKfdA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767342503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JwXs0TWTvQyru/1FJnT7PceUZ5PM1i44sl3H0M6R59k=;
	b=ji43rNkXXG2hRA9ZMRxA+zoORN8JUoVdJw6FYDxE302ZH5YCmMK3sa/m8XwavZe1M5aS6D
	dKSUuj4+tnI8kDuj+rhkS4kZS8GgYXWnONI39yzx8f+LLGlrZ8EctZ+iEev1XSaXVpiDef
	jU5daNtizXE8wuxbiQb+970iMDTKfdA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6DE1139DE
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Jan 2026 08:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XdrgHaaBV2nBdQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 02 Jan 2026 08:28:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reject single block sized compression early
Date: Fri,  2 Jan 2026 18:57:56 +1030
Message-ID: <f2aef6ca0a6ec4d339a7a0ad3b197b2628c99100.1767342454.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.69
X-Spam-Level: 
X-Spamd-Result: default: False [-2.69 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.09)[-0.433];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Currently for an inode that needs compression, even if there is a delalloc
range that is single fs block sized and can not be inlined, we will
still go through the compression path.

Then inside compress_file_range(), we have one extra check to reject
single block sized range, and fall back to regular uncompressed write.

This rejection is in fact a little too late, we have already allocated
memory to async_chunk, delayed the submission, just to fallback to the
same uncompressed write.

Change the behavior to reject such cases earlier at
inode_need_compress(), so for such single block sized range we won't
even bother trying to go through compress path.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 370dfb13d6f3..a45734d62b47 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -816,6 +816,13 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 		return 0;
 	}
 
+	/*
+	 * If the delalloc range is only one fs block and can not be inlined,
+	 * do not even bother try compression, as there will be no space saving
+	 * and will always fallback to regular write later.
+	 */
+	if (start != 0 && end + 1 - start <= fs_info->sectorsize)
+		return 0;
 	/* Defrag ioctl takes precedence over mount options and properties. */
 	if (inode->defrag_compress == BTRFS_DEFRAG_DONT_COMPRESS)
 		return 0;
-- 
2.52.0


