Return-Path: <linux-btrfs+bounces-11865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FFEA45ACB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C971188BD58
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A89267B1A;
	Wed, 26 Feb 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gp+xbvoJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gp+xbvoJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B725E452
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563544; cv=none; b=c/6wTUj6wjH0ogLzbS0hgpZS1fuoMwOExk//oekCVTTBKjjAqJKIXcA+2vpKjKgthll3GKQAfvJGawwTSpQn5HEUxZpgBmrkZoXxt6SkfR6y71sUnEud8/+KfQCc3/F6HSYaFBRXH068d7ELc+hL08v7b1A+3ETSiNY4SQviHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563544; c=relaxed/simple;
	bh=69hi2PgnnsdBOP/0GxzS8HiwyVUYoXSL/OghUg4KdZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpPqRq6hWr8bykUr8C/f/PyjYTcBRMXtv7gHDQ+a2I4gV4On2d5todJlFdq/VbOnHNvnZ3CTdJDD5L/IP4XnBKnNH+eQSem/HrXzD3PxlwhfJbUkzIdtjSP4a7nCsGAdTH5oAmWHuISsWDbE5crZWg5oCiqRdoZDHErtysDMEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gp+xbvoJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gp+xbvoJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E0F41F387;
	Wed, 26 Feb 2025 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWmzy4hafxyBDIVRHuGDcM/C/4rX2EzXTslkT62bSRE=;
	b=gp+xbvoJMNVC8XIZI7hV5FpnJZznJtP2Z3GgqeBB0yX8WD2Bu/3V6cVp4ize2Z0CrA6ZlC
	374JuKGH7IpHCL3P+OQWH269OOR9GFO2w/kA/Wfu9k0EpDISqRTYLxJmGbiGRxduRGkGVI
	2Zbg97SROxSya0BeN9VGQjQuWX6uzmo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gp+xbvoJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWmzy4hafxyBDIVRHuGDcM/C/4rX2EzXTslkT62bSRE=;
	b=gp+xbvoJMNVC8XIZI7hV5FpnJZznJtP2Z3GgqeBB0yX8WD2Bu/3V6cVp4ize2Z0CrA6ZlC
	374JuKGH7IpHCL3P+OQWH269OOR9GFO2w/kA/Wfu9k0EpDISqRTYLxJmGbiGRxduRGkGVI
	2Zbg97SROxSya0BeN9VGQjQuWX6uzmo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 575FF13A53;
	Wed, 26 Feb 2025 09:51:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YMJSFSvkvmdfYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:39 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 21/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_insert_hole_extent()
Date: Wed, 26 Feb 2025 10:51:39 +0100
Message-ID: <6ed8afba8f90bdbe24fc44e5380186bff3a3594f.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E0F41F387
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
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

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file-item.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 5083025d28b2..2f5e6cad8f55 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -163,7 +163,7 @@ int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	struct btrfs_file_extent_item *item;
 	struct btrfs_key file_key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 
 	path = btrfs_alloc_path();
@@ -177,7 +177,7 @@ int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
 	ret = btrfs_insert_empty_item(trans, root, path, &file_key,
 				      sizeof(*item));
 	if (ret < 0)
-		goto out;
+		return ret;
 	leaf = path->nodes[0];
 	item = btrfs_item_ptr(leaf, path->slots[0],
 			      struct btrfs_file_extent_item);
@@ -191,8 +191,7 @@ int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_file_extent_compression(leaf, item, 0);
 	btrfs_set_file_extent_encryption(leaf, item, 0);
 	btrfs_set_file_extent_other_encoding(leaf, item, 0);
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
-- 
2.47.1


