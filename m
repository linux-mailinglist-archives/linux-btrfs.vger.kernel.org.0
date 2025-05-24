Return-Path: <linux-btrfs+bounces-14204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC87EAC2D0C
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F2F7AE097
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFED8191F95;
	Sat, 24 May 2025 02:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c94vqsUf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c94vqsUf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E914885B
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052544; cv=none; b=WRbzYlAztfkXkbBU0rKTJXFp1en+/frdnqT6ru1FC9hqWQ5WOOX80gUZiK9EAV5u92WJkQiyToUPUTRYD7hpWvihaY/8EMlN5OhEn5KKAMgxyEQrSOh5WZr+fJkSybmc9WZMoJ+5pcE15p7XIDJflz3W85QpfVe73RbSa+ZVYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052544; c=relaxed/simple;
	bh=i1nEaL1QEZ/xibP1oWDutfDFqw8fe6Lmmlzf0oFcVEQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgbr+nwaYLAakGSXuSDV33RxFzyIYB2KpWlAlaGqbibt0jo2AGTTwPKhCKo3LWuDf2Px1CpvNBXfYa1VONAG4O+rzNniwWVOuR62ptGRcfCBfFBftYtOkFvIxSsx1q83KupYjfEWERIpHxwdpvo+v1ESmB84cIhs4V9dQrWz3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c94vqsUf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c94vqsUf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4FF6F1FCEA
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtRwwsKn1MnUb9/dt/zSLih+Q38ogNioSROPGQ3pLB4=;
	b=c94vqsUfg+Iq3FCjSQKsfcsG+SplaUjT7fcQDWkmeh7s2KMkR7GuTshRAwZTR5zDbcMkgP
	dc3Hvh+hvN3FEdbdiw3pF2i8VFc5p8Rtsf7B/SylPV45QYRz2DNYjwnQH5TmVDter9k0rS
	NF0ZZoOLkRgrmv5NgBm05Cx1V/O0R/8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtRwwsKn1MnUb9/dt/zSLih+Q38ogNioSROPGQ3pLB4=;
	b=c94vqsUfg+Iq3FCjSQKsfcsG+SplaUjT7fcQDWkmeh7s2KMkR7GuTshRAwZTR5zDbcMkgP
	dc3Hvh+hvN3FEdbdiw3pF2i8VFc5p8Rtsf7B/SylPV45QYRz2DNYjwnQH5TmVDter9k0rS
	NF0ZZoOLkRgrmv5NgBm05Cx1V/O0R/8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 868101373E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UJe/EikqMWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs-progs: convert: merge setup_temp_fs_tree() and setup_temp_csum_tree()
Date: Sat, 24 May 2025 11:38:12 +0930
Message-ID: <3c8e4d9e240e440f02b701c053e34117a502f8fe.1748047388.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748047388.git.wqu@suse.com>
References: <cover.1748047388.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

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


