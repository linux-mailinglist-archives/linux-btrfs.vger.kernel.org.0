Return-Path: <linux-btrfs+bounces-14163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D49ABF078
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 11:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004264E46FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00C225A2B7;
	Wed, 21 May 2025 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g+EmX2ip";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g+EmX2ip"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA0259C8B
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821108; cv=none; b=tVmoYHJWKHtDLyv/5gYw/bonjnQmdz+JW2QWUAj5G55ZkMSNZXgwJ4Fp+hNTBHOO/CTzw/85s5d81p6IplU4H3tDvqmXNKr/bYDDl8UPoquWz/FntJPrBYYhKLHXclWjySBboeIs63iw67PniUeslICkYuIUTnGF1RQnBItmZjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821108; c=relaxed/simple;
	bh=TlKEiPNQaoeEupnHW78SGeA6dJY8QilZ0SPgqTW0q1M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tu5PF/FtYxxJYpljhvzBdOYsMSMarQyBKVMHxY63Ln2o9cZGL9RumXy2jPfBWkYKfPC5JC+fg4vgKjEApv+OC32UoD//yd43KEMLfn5np21Qv0XgUd6oUMyuMI+H+XqfPDb5MLZ+LjjSxpXx0mxryMc5NcAkras10lX3Vb75OMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g+EmX2ip; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g+EmX2ip; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BAE7B208F2
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOaGtUErD317HI1muGbqudZNtuv6kdQ8DNKz6+mPrXk=;
	b=g+EmX2ipKUaeam79KOZz85RX0oePRTsiP9DRTNy8Lf70vYDfUTAkvf0Wdni9jgnW/1eS8D
	mY61f3YQnH0AgB4CuHaeJY4AsmvNmXICTFmlfqi/gKJ5Myk6ryTQDxA77SJ+4zaQVa5G+b
	dpgeRa5O0N/c7AusZADfLGhlwZ27Dq0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=g+EmX2ip
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOaGtUErD317HI1muGbqudZNtuv6kdQ8DNKz6+mPrXk=;
	b=g+EmX2ipKUaeam79KOZz85RX0oePRTsiP9DRTNy8Lf70vYDfUTAkvf0Wdni9jgnW/1eS8D
	mY61f3YQnH0AgB4CuHaeJY4AsmvNmXICTFmlfqi/gKJ5Myk6ryTQDxA77SJ+4zaQVa5G+b
	dpgeRa5O0N/c7AusZADfLGhlwZ27Dq0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0932513888
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +Hm4LyKiLWgBRgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs-progs: do not generate checksum nor compress if the inode has NODATACOW or NODATASUM
Date: Wed, 21 May 2025 19:21:08 +0930
Message-ID: <523b56e6bd33b9359bd7219b7047f08cabb653d8.1747820747.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747820747.git.wqu@suse.com>
References: <cover.1747820747.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: BAE7B208F2
X-Spam-Level: 
X-Spam-Flag: NO

Currently mkfs.btrfs --rootdir is implying data checksum, but soon we
will support per-inode NODATACOW|NODATASUM flags.

To support per-inode NODATACOW|NODATASUM flags:

- Avoid compression if the inode has either NODATACOW|NODATASUM flag

- Do not generate data checksum if the inode has either
  NODATACOW|NODATASUM flag.

Both behaviors are the following the kernel ones.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/rootdir.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 5f4cfb93c7c4..eafad426295c 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -716,12 +716,19 @@ static int add_file_item_extent(struct btrfs_trans_handle *trans,
 	u64 buf_size;
 	char *write_buf;
 	bool do_comp = g_compression != BTRFS_COMPRESS_NONE;
+	bool datasum = true;
 	ssize_t comp_ret;
 	u64 flags = btrfs_stack_inode_flags(btrfs_inode);
 
 	if (flags & BTRFS_INODE_NOCOMPRESS)
 		do_comp = false;
 
+	if (flags & BTRFS_INODE_NODATACOW ||
+	    flags & BTRFS_INODE_NODATASUM) {
+		datasum = false;
+		do_comp = false;
+	}
+
 	buf_size = do_comp ? BTRFS_MAX_COMPRESSED : MAX_EXTENT_SIZE;
 	to_read = min(file_pos + buf_size, source->size) - file_pos;
 
@@ -852,13 +859,15 @@ static int add_file_item_extent(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	for (unsigned int i = 0; i < to_write / sectorsize; i++) {
-		ret = btrfs_csum_file_block(trans, first_block + (i * sectorsize),
+	if (datasum) {
+		for (unsigned int i = 0; i < to_write / sectorsize; i++) {
+			ret = btrfs_csum_file_block(trans, first_block + (i * sectorsize),
 					BTRFS_EXTENT_CSUM_OBJECTID,
 					root->fs_info->csum_type,
 					write_buf + (i * sectorsize));
-		if (ret)
-			return ret;
+			if (ret)
+				return ret;
+		}
 	}
 
 	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
-- 
2.49.0


