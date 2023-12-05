Return-Path: <linux-btrfs+bounces-609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19544804B78
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 08:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2A61C20E20
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0002EAF3;
	Tue,  5 Dec 2023 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W2o/b7YH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1347CA
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 23:51:50 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 716AE1FB79
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 07:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701762709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i4sN65e58JTYkvdufduGmKS3cDcd0nkwvxb86tmby1c=;
	b=W2o/b7YHOfaSHu/No+Zz0IllWqBbwncHZ9wn2+/KDQrFZFWhFQ7qosEePR+Zwz0/8useLm
	vuz4ZyjUuhe8itYiydwLE3rh5blOXKIk+1pYEj0oJ1YoNrc/tWIwLgBlaShioPw/V8MU0X
	ilszD32qy0UkFdAt23EKcRaHgFBMZLM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 72C28138FF
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 07:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id irGfCJTWbmUeCQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 05 Dec 2023 07:51:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix mismatching parameter names for btrfs_get_extent()
Date: Tue,  5 Dec 2023 18:21:29 +1030
Message-ID: <4a8d8601602d7ceef622286c259bc4c11d7e3585.1701762681.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 3.90
X-Spamd-Result: default: False [3.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

The definition for btrfs_get_extent() is using "u64 end" as the last
parameter, but in implementation we go "u64 len", and all call sites
follows the implementation.

This can be very confusing during development, as most developers
including me, would just use the snippet returned by LSP (clangd in my
case), which would only check the definition.

Unfortunately this mismatch is introduced from the very beginning of
btrfs.

Fix it to prevent further confusion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 5572ae52444e..9feb7e96d85a 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -487,7 +487,7 @@ struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
 struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_root *root);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct page *page, size_t pg_offset,
-				    u64 start, u64 end);
+				    u64 start, u64 len);
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_inode *inode);
 int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
-- 
2.43.0


