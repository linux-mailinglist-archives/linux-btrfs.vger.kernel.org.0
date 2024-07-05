Return-Path: <linux-btrfs+bounces-6215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A0927F37
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 02:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD191F23AFA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 00:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F6438D;
	Fri,  5 Jul 2024 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BYBP93c+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BYBP93c+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21618D
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720137747; cv=none; b=hGOHm9kMZ8lVHuWKEgoL8Y1CxvWBBsxMpQKsbEaRyy9N+qWOAAkRiEV8ooiGoWbXNp02/jG9ncpdPE1dQmJjLWXf6JYqKXsT3Wd78Gq74F5xV45cwy0VF4dNA1J+Gd43AzoLmuPkxDFQAKXzHwIEkEkEJ+kWS2w6/1kgIDig2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720137747; c=relaxed/simple;
	bh=l46Jsoh5LkvTqYdHKRp1lHs0Tyb51BmZpCpbGzsrMZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMkmB7tzDyHEA6W8SQulTr61jtrisOtyM3W5RBzrPEM7s3KCigEAd8cStjYI5pSY9Aio4Pu7AdX1WSufxzPZQ4SYsIwoi2eNEdcgdpqsyrBJg+njCFmQsKmPAiZb4RnaIhRfZOfastaLIFfvtNZXexpZYNEq57OzQ9BwqJVO9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BYBP93c+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BYBP93c+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1ABB921993;
	Fri,  5 Jul 2024 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720137742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ThLgff32k2uKTQIjT4E2UUc3rElcKyk0Fu7uFyxHcLM=;
	b=BYBP93c+F66ZnvbSTokn9vlxoh+PXCMIhu44gQMlZas5U7tjYj97/MEJgFB0c0sxK6hc0v
	snW9U3vI+ytDwEHaOJJnWjPKsuBxEimI9t50L/l+nLjayckOfAQUReh3kwy2/0YlBcxaqm
	hBAtXot7hZukYT82FKHMmbQnYDS7vCw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720137742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ThLgff32k2uKTQIjT4E2UUc3rElcKyk0Fu7uFyxHcLM=;
	b=BYBP93c+F66ZnvbSTokn9vlxoh+PXCMIhu44gQMlZas5U7tjYj97/MEJgFB0c0sxK6hc0v
	snW9U3vI+ytDwEHaOJJnWjPKsuBxEimI9t50L/l+nLjayckOfAQUReh3kwy2/0YlBcxaqm
	hBAtXot7hZukYT82FKHMmbQnYDS7vCw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E81451368F;
	Fri,  5 Jul 2024 00:02:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ey+cJww4h2YuPQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 05 Jul 2024 00:02:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>
Subject: [PATCH] btrfs: tree-checker: skip name hash check for image dump
Date: Fri,  5 Jul 2024 09:32:02 +0930
Message-ID: <0163b37d7cdb31ed39e0eff2f61cdb4f3cd90272.1720137702.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[BUG]
For an image dumpped with "btrfs-image -s", the restored filesystem will
not pass tree-checker:

 BTRFS critical (device dm-5): corrupt leaf: root=1 block=32522240 slot=6 ino=6, name hash mismatch with key, have 0x0000000019e196de expect 0x000000008dbfc2d2
 BTRFS error (device dm-5): read time tree block corruption detected on logical 32522240 mirror 1

[CAUSE]
Btrfs-image with "-s" option would sanitize the filenames, thus it's
ensured to cause file names to mismatch their hash.

[FIX]
Since btrfs-image is mostly for debug purposes, we can afford it to be
an exception for tree-checker.

Just allow image dump to skip the name hash mismatch.

There will be a little more risk, as image dump can still be mounted RW,
but the existing error handling is good enough to handle the mismatched
hash.

Reported-by: Andrea Gelmini <andrea.gelmini@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 6388786fd8b5..6fd7ed46812a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -630,10 +630,14 @@ static int check_dir_item(struct extent_buffer *leaf,
 
 		/*
 		 * Special check for XATTR/DIR_ITEM, as key->offset is name
-		 * hash, should match its name
+		 * hash, should match its name.
+		 * But if it's METADUMP (btrfs-image dump) then we allow hash
+		 * mismatch since "-s" can generaete different names.
 		 */
-		if (key->type == BTRFS_DIR_ITEM_KEY ||
-		    key->type == BTRFS_XATTR_ITEM_KEY) {
+		if ((key->type == BTRFS_DIR_ITEM_KEY ||
+		     key->type == BTRFS_XATTR_ITEM_KEY) &&
+		    !(btrfs_super_flags(leaf->fs_info->super_copy) &
+		      (BTRFS_SUPER_FLAG_METADUMP | BTRFS_SUPER_FLAG_METADUMP_V2))) {
 			char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
 
 			read_extent_buffer(leaf, namebuf,
-- 
2.45.2


