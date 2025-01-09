Return-Path: <linux-btrfs+bounces-10834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6E5A0731A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198D61640C8
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693A9218EBF;
	Thu,  9 Jan 2025 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QjVedG6I";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QjVedG6I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0621639B
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418295; cv=none; b=GnKPVQU0ZYINsOJRaB2XOPkzvbSkSWOIO8ahVk1atcFegxdc6r0QDj1AmIyIRA5lmrsd8wbxZ9oGVYXeG3LFa6b7GbT8NYdbD/7Z64YPwtCMhYaAUjfBIWGAnlAFxVc2OuxTPlyPLN0MMcfG2AuyTmPjdLy38Vdaa4m4cyozjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418295; c=relaxed/simple;
	bh=B3ky9g2AiHWv+2eOl2uhAacg9xBrKePTgus7UdS9cDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+fbULr1vD4TvEXzaiDJLR/4sHp0NFKhidklcjf7mTl0kgPeOunCERvJTECfHnIksAVkhb2NVaFRAkSTJFGgzg1tCp9X+7itpomhhLbEbvVO0DsCKK4f5sivBFqEGt5eqUqwFkmJATeG5Fz0Kh/SHQekAjazepgPyOmFJiNY9dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QjVedG6I; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QjVedG6I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 372031F385;
	Thu,  9 Jan 2025 10:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEGUihjoFYENI8F3EBo6AmrMg3sapp3DgzdtKJYbFe0=;
	b=QjVedG6IJHv+Rfq5EPI3mrYVLel4C3WaXAJrS09Wa1tg5bEJKrM8VKD+wPsD/elXzlTZ+H
	O8b5B+72bgaZvewMMkFRGyuxgS+i6NE65LzKZqu3KXKVJs3ZsNHBGzBXONpBP27w4dLhtT
	u7wqZU0EgvqVxhVs8848K7CjJrzsNFo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QjVedG6I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEGUihjoFYENI8F3EBo6AmrMg3sapp3DgzdtKJYbFe0=;
	b=QjVedG6IJHv+Rfq5EPI3mrYVLel4C3WaXAJrS09Wa1tg5bEJKrM8VKD+wPsD/elXzlTZ+H
	O8b5B+72bgaZvewMMkFRGyuxgS+i6NE65LzKZqu3KXKVJs3ZsNHBGzBXONpBP27w4dLhtT
	u7wqZU0EgvqVxhVs8848K7CjJrzsNFo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E2FC139AB;
	Thu,  9 Jan 2025 10:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RotTC/Sjf2d9EQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:52 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 18/18] btrfs: async-thread: rename DFT_THRESHOLD to DEFAULT_THRESHOLD
Date: Thu,  9 Jan 2025 11:24:51 +0100
Message-ID: <5051634fcb80e7689f369cee4f22ffe07c08a56b.1736418116.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736418116.git.dsterba@suse.com>
References: <cover.1736418116.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 372031F385
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Rename the macro so it's obvious what it means.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/async-thread.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 361a866c1995..a4c51600a408 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -18,7 +18,7 @@ enum {
 };
 
 #define NO_THRESHOLD (-1)
-#define DFT_THRESHOLD (32)
+#define DEFAULT_THRESHOLD (32)
 
 struct btrfs_workqueue {
 	struct workqueue_struct *normal_wq;
@@ -94,9 +94,9 @@ struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
 
 	ret->limit_active = limit_active;
 	if (thresh == 0)
-		thresh = DFT_THRESHOLD;
+		thresh = DEFAULT_THRESHOLD;
 	/* For low threshold, disabling threshold is a better choice */
-	if (thresh < DFT_THRESHOLD) {
+	if (thresh < DEFAULT_THRESHOLD) {
 		ret->current_active = limit_active;
 		ret->thresh = NO_THRESHOLD;
 	} else {
-- 
2.47.1


