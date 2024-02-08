Return-Path: <linux-btrfs+bounces-2231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EC884DC36
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D7E1F239BE
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F99C6BB51;
	Thu,  8 Feb 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ByBcxR3i";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ByBcxR3i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C56BB43
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382824; cv=none; b=XPHK5RYZmOgBE0sF1u+hpy7G+T96zVNR8Yg/iYVh4JZPwfzE4aM6FTL5YdGwljtj09uPO+feCcKIAIIbFvdGR6+ATz36aV4ZlEbkaxtSfWpWhlrJdNRohn96bEDqcQSkKcmLPzm2Hl36gOshXc1bXbknCtScl5QI495i9UjfyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382824; c=relaxed/simple;
	bh=t5Rew0KgMAWJQQMa/j+/uTowJI6KBir7v1ZjKg3wrCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMPJRPf5yn6r/4wQr+zul9LvECmcnjT8bh7lT73jiqNrQ9PiOD+3GUCzqa43zJbF7e7VlCTJbP9HmAMDBG0fcYvWANpiVkkR6YZpLQ2w6EKej6si/2+CwnlHMKjXOlYTHD2DTOSDRpDQP4d0yywlDRdHPvEIrrddfTCq92shwfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ByBcxR3i; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ByBcxR3i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73A2A21E6F;
	Thu,  8 Feb 2024 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrRuhIx9KB22j+ieuDI+ZtvxzBHp7f17r4pLGRJRUvg=;
	b=ByBcxR3i4ghLLlhdbTAN8/REcJWqW/24/tk4YcV/h9RvjFd4b0wsTlxbZ25/bQVOCvMBTB
	+ldecmrFYMWD1Zbj0vpzv2EtqVtq67nsWCcvEA+AgII4hBSm0Tw4ZEQ2jJC0XfUT7CCWAU
	GGAc8lGKMT7Z1odk9fWSIbW8YS3M1M8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrRuhIx9KB22j+ieuDI+ZtvxzBHp7f17r4pLGRJRUvg=;
	b=ByBcxR3i4ghLLlhdbTAN8/REcJWqW/24/tk4YcV/h9RvjFd4b0wsTlxbZ25/bQVOCvMBTB
	+ldecmrFYMWD1Zbj0vpzv2EtqVtq67nsWCcvEA+AgII4hBSm0Tw4ZEQ2jJC0XfUT7CCWAU
	GGAc8lGKMT7Z1odk9fWSIbW8YS3M1M8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DE3C13984;
	Thu,  8 Feb 2024 09:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6wTRGiWYxGWGDgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 08 Feb 2024 09:00:21 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/14] btrfs: send: handle unexpected inode in header process_recorded_refs()
Date: Thu,  8 Feb 2024 09:59:52 +0100
Message-ID: <d2dbc5d3a569388632e60a375d0cb58a2ca50274.1707382595.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707382595.git.dsterba@suse.com>
References: <cover.1707382595.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[42.88%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

Change BUG_ON to proper error handling when an unexpected inode number
is encountered. As the comment says this should never happen.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 1bff7b3008ac..778c2da1c9dd 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4186,7 +4186,13 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	 * This should never happen as the root dir always has the same ref
 	 * which is always '..'
 	 */
-	BUG_ON(sctx->cur_ino <= BTRFS_FIRST_FREE_OBJECTID);
+	if (unlikely(sctx->cur_ino <= BTRFS_FIRST_FREE_OBJECTID)) {
+		btrfs_err(fs_info,
+			  "send: unexpected inode %llu in process_recorded_refs()",
+			  sctx->cur_ino);
+		ret = -EINVAL;
+		goto out;
+	}
 
 	valid_path = fs_path_alloc();
 	if (!valid_path) {
-- 
2.42.1


