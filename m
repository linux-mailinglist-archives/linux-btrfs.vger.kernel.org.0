Return-Path: <linux-btrfs+bounces-20171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B504DCF952D
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB57E3069001
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAF833345A;
	Tue,  6 Jan 2026 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aHEKr6ye";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aHEKr6ye"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B33242BE
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716484; cv=none; b=t/lD6SMESIQWp8+UQaQkaU6VNlP0Wh3TdHucVKS9P01wqSt+FAB/G+J84ArvW40mPPC1LNxq2EjmFf3MCyye8xQ8+wyGdAZWNF1taVLwTPvr8aK1JlRy+/9x8KuBmI80AlxM3mc7U+O0QHNnHpRosAPbo0b763sVlmofvINH58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716484; c=relaxed/simple;
	bh=Bt/KsIORdklksa5VuNZlPUMeI7+KswwEnJtVgObXDtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+hvC1QOT4sxACpDbLJmhLGlJEAQPZGmj753BxUtoJb0rGhVT6SxIzhWe+/OeuY3Q6jS+PYe33eJKSLwJ/NhMhZiMyAV+N40sUj0gkVkzJlhpzL5dLSA5mLb4DWkOrEF8jjCcqNLpxUqx4N4+1STdSMCN7ghsV4cc7Kr1GdPmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aHEKr6ye; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aHEKr6ye; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E23C933692;
	Tue,  6 Jan 2026 16:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmejmnyTiiVFtzTkyUdp86H4kp13PfR8qwih45/39I8=;
	b=aHEKr6yeilyeyZIWimY5Da4ftGRF0VjHkBVYG1hWEgYmwpTxa183Syyf+gLcxmJ9zKknXO
	QqI6V5BncbuvApGX+mcb+tLEj4MsIEMQXNsAV/ABMMB7VZi5oDj+YrrMHfkSIxZkCvdD7t
	xYjojnAowGvasqQqxZxkAqSYFST+GJA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmejmnyTiiVFtzTkyUdp86H4kp13PfR8qwih45/39I8=;
	b=aHEKr6yeilyeyZIWimY5Da4ftGRF0VjHkBVYG1hWEgYmwpTxa183Syyf+gLcxmJ9zKknXO
	QqI6V5BncbuvApGX+mcb+tLEj4MsIEMQXNsAV/ABMMB7VZi5oDj+YrrMHfkSIxZkCvdD7t
	xYjojnAowGvasqQqxZxkAqSYFST+GJA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCE573EA63;
	Tue,  6 Jan 2026 16:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AjTuNW42XWm5WQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:21:02 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/12] btrfs: zlib: drop redundant folio address variable
Date: Tue,  6 Jan 2026 17:20:30 +0100
Message-ID: <546496bce96abc395014b9d95b645b7948e40389.1767716314.git.dsterba@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

We're caching the current output folio address but it's not really
necessary as we store it in the variable and then pass it to the stream
context. We can read the folio address directly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zlib.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 6caba8be7c845c..d1a680da26ba53 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -155,7 +155,6 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
 	int ret;
 	char *data_in = NULL;
-	char *cfolio_out;
 	int nr_folios = 0;
 	struct folio *in_folio = NULL;
 	struct folio *out_folio = NULL;
@@ -186,13 +185,12 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 		ret = -ENOMEM;
 		goto out;
 	}
-	cfolio_out = folio_address(out_folio);
 	folios[0] = out_folio;
 	nr_folios = 1;
 
 	workspace->strm.next_in = workspace->buf;
 	workspace->strm.avail_in = 0;
-	workspace->strm.next_out = cfolio_out;
+	workspace->strm.next_out = folio_address(out_folio);
 	workspace->strm.avail_out = min_folio_size;
 
 	while (workspace->strm.total_in < len) {
@@ -270,11 +268,10 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cfolio_out = folio_address(out_folio);
 			folios[nr_folios] = out_folio;
 			nr_folios++;
 			workspace->strm.avail_out = min_folio_size;
-			workspace->strm.next_out = cfolio_out;
+			workspace->strm.next_out = folio_address(out_folio);
 		}
 		/* we're all done */
 		if (workspace->strm.total_in >= len)
@@ -306,11 +303,10 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cfolio_out = folio_address(out_folio);
 			folios[nr_folios] = out_folio;
 			nr_folios++;
 			workspace->strm.avail_out = min_folio_size;
-			workspace->strm.next_out = cfolio_out;
+			workspace->strm.next_out = folio_address(out_folio);
 		}
 	}
 	zlib_deflateEnd(&workspace->strm);
-- 
2.51.1


