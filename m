Return-Path: <linux-btrfs+bounces-14169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2D3ABF09C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 11:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5173BCE78
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B11248F6C;
	Wed, 21 May 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s4gRL8O3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s4gRL8O3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36CF25A2BC
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821538; cv=none; b=Pdwp3JydOpExCxsdNvTNJmAvdUsAdHgJunahtZ6fSw+WbDhDjOxNXr3lUnq7hsOezaRdXakCMLry5EQ6gi33kFzey01Svm11ghg5WA4OzMqfe2qvlyPGHDwxKxs6veD9eNWYWIyHTs0cWFZxSaEb7xXuJOFiilvo3wiLLdhxetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821538; c=relaxed/simple;
	bh=TlKEiPNQaoeEupnHW78SGeA6dJY8QilZ0SPgqTW0q1M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6wh1FLMzVEGKhgMszcbkcRvxgs8MjODE9/blFJnPqOjxpMTaG/M6I6BrJveTvkPcboYe203i5Y+c16mhYK/5fyNAcyUSq75uON1te91QGEcSQnFTk0v+gfgZvlBNKumBS7i76cAQx7tfl3Mrwf2QGD0pfh67oYHI7J63YfvdkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s4gRL8O3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s4gRL8O3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B736120908
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOaGtUErD317HI1muGbqudZNtuv6kdQ8DNKz6+mPrXk=;
	b=s4gRL8O31FmaWyoMS5G0cWG2uYj4+rMAsD6MKhe+bMQH4nzBIVvXQ41yxr09oMkDQ6PLAy
	/it6f1qa93DX/XIx1C23b0Ki3hW0Wg6O7UNuQj+VhSXObJPoUY9oi2VTSi9l6wUloWqGVj
	mLBGSDKleMd4zorpxigGjSy5mHnLqho=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=s4gRL8O3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOaGtUErD317HI1muGbqudZNtuv6kdQ8DNKz6+mPrXk=;
	b=s4gRL8O31FmaWyoMS5G0cWG2uYj4+rMAsD6MKhe+bMQH4nzBIVvXQ41yxr09oMkDQ6PLAy
	/it6f1qa93DX/XIx1C23b0Ki3hW0Wg6O7UNuQj+VhSXObJPoUY9oi2VTSi9l6wUloWqGVj
	mLBGSDKleMd4zorpxigGjSy5mHnLqho=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8C3B13888
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UCNyKdGjLWj6RwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs-progs: do not generate checksum nor compress if the inode has NODATACOW or NODATASUM
Date: Wed, 21 May 2025 19:28:19 +0930
Message-ID: <bbff65c7540e779e9e8d45fa67e64df99fad8a32.1747821454.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747821454.git.wqu@suse.com>
References: <cover.1747821454.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B736120908
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.com:dkim]

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


