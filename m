Return-Path: <linux-btrfs+bounces-14206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504FCAC2D0A
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0625F4E1B51
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6F318C933;
	Sat, 24 May 2025 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GRkBbmnQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GRkBbmnQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551B191F74
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052550; cv=none; b=SJvwXTLpZLJTmJqmbc/AzEr4yFAqHEmo0LMmRsqGaEj/pxQlFt3RAGVhOq3kgApYwZMSK3B7upl4oJqNWNx4Kj3nxZQSAczUS2j7rNtff6ukosykPP/Zv4WVEPeISkG0NqZSVIM1h2zSBzAP7A0Zed8tjU9bhNEmq4Isminn/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052550; c=relaxed/simple;
	bh=i1nEaL1QEZ/xibP1oWDutfDFqw8fe6Lmmlzf0oFcVEQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqmWheWhUyO7U2iaNJicmgzpqBG7jLllpyN0yYz8vp3OFA2x3NVEVRXF59ZF+1VWRvgAEpqmQxVdueZjp58e97NQge2ZqC4SCOw8vKZzGFIdkiTsjkVqRhzWVmGbvPzPaKsfL8v+aSzwWhJp6WW9RBnenC20uuF0ty/WfKG4EWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GRkBbmnQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GRkBbmnQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7EAA11F896
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtRwwsKn1MnUb9/dt/zSLih+Q38ogNioSROPGQ3pLB4=;
	b=GRkBbmnQhVmc+4ZCiSrza7a/xcTJQRGjXFNnHZ02qm+h2+lkJ0gHXVTXOMG6M3k8B1/LUi
	ndCLdrJSa03/zCOXeBQ+wY051RcxP4iL3yPU0nDVDJVzPIHegoKbii3B9KU62kgxKzqrbo
	UmhbSCnAkvuykPvydcxqScoPheNjzXA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GRkBbmnQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtRwwsKn1MnUb9/dt/zSLih+Q38ogNioSROPGQ3pLB4=;
	b=GRkBbmnQhVmc+4ZCiSrza7a/xcTJQRGjXFNnHZ02qm+h2+lkJ0gHXVTXOMG6M3k8B1/LUi
	ndCLdrJSa03/zCOXeBQ+wY051RcxP4iL3yPU0nDVDJVzPIHegoKbii3B9KU62kgxKzqrbo
	UmhbSCnAkvuykPvydcxqScoPheNjzXA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B47601373E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GBLvHSoqMWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/9] btrfs-progs: convert: merge setup_temp_fs_tree() and setup_temp_csum_tree()
Date: Sat, 24 May 2025 11:38:13 +0930
Message-ID: <eef131fa57da29ae07c7322e96c7968047a2e418.1748049973.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748049973.git.wqu@suse.com>
References: <cover.1748049973.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 7EAA11F896
X-Spam-Level: 
X-Spam-Flag: NO

Both fs and csum trees are empty at make_convert_btrfs(), no need to use
two different functions to do that.

Merge them into a common setup_temp_empty_tree() instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/common.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index d062a1306c9e..b00d69cedd68 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -514,8 +514,8 @@ out:
 	return ret;
 }
 
-static int setup_temp_fs_tree(int fd, struct btrfs_mkfs_config *cfg,
-			      u64 fs_bytenr)
+static int setup_temp_empty_tree(int fd, struct btrfs_mkfs_config *cfg,
+				 u64 root_bytenr, u64 owner)
 {
 	struct extent_buffer *buf = NULL;
 	int ret;
@@ -523,36 +523,13 @@ static int setup_temp_fs_tree(int fd, struct btrfs_mkfs_config *cfg,
 	buf = malloc(sizeof(*buf) + cfg->nodesize);
 	if (!buf)
 		return -ENOMEM;
-	ret = setup_temp_extent_buffer(buf, cfg, fs_bytenr,
-				       BTRFS_FS_TREE_OBJECTID);
+	ret = setup_temp_extent_buffer(buf, cfg, root_bytenr, owner);
 	if (ret < 0)
 		goto out;
 	/*
 	 * Temporary fs tree is completely empty.
 	 */
-	ret = write_temp_extent_buffer(fd, buf, fs_bytenr, cfg);
-out:
-	free(buf);
-	return ret;
-}
-
-static int setup_temp_csum_tree(int fd, struct btrfs_mkfs_config *cfg,
-				u64 csum_bytenr)
-{
-	struct extent_buffer *buf = NULL;
-	int ret;
-
-	buf = malloc(sizeof(*buf) + cfg->nodesize);
-	if (!buf)
-		return -ENOMEM;
-	ret = setup_temp_extent_buffer(buf, cfg, csum_bytenr,
-				       BTRFS_CSUM_TREE_OBJECTID);
-	if (ret < 0)
-		goto out;
-	/*
-	 * Temporary csum tree is completely empty.
-	 */
-	ret = write_temp_extent_buffer(fd, buf, csum_bytenr, cfg);
+	ret = write_temp_extent_buffer(fd, buf, root_bytenr, cfg);
 out:
 	free(buf);
 	return ret;
@@ -867,10 +844,10 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_config *cfg,
 				  dev_bytenr);
 	if (ret < 0)
 		goto out;
-	ret = setup_temp_fs_tree(fd, cfg, fs_bytenr);
+	ret = setup_temp_empty_tree(fd, cfg, fs_bytenr, BTRFS_FS_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
-	ret = setup_temp_csum_tree(fd, cfg, csum_bytenr);
+	ret = setup_temp_empty_tree(fd, cfg, csum_bytenr, BTRFS_CSUM_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
 	/*
-- 
2.49.0


