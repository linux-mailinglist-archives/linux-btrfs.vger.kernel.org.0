Return-Path: <linux-btrfs+bounces-3946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4F58993DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 05:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFB01C2415C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 03:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C20A1CFBC;
	Fri,  5 Apr 2024 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rkkB71De";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rkkB71De"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC6E1B299
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287659; cv=none; b=n5yPEUL3BBHRaDQKQigDDA776Xr+Aalk1unWLRZ2PPr3Kr6pfN/ziS0/b9FJjlZASdfpyTuK98Z8yMpMBsQhigFEZWcPb3uGKIPhS3EcIG0Rpm/Z8f+q4k38jcKko+UgbSRX4sf5gKQen6Tk1CqinVDAzsav2TB31dnkyEKyxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287659; c=relaxed/simple;
	bh=Rxravlyg3AnGQsxTpX7PzDktCSd8gVRb42wDV9KnrKM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLR0hhtIXGtDlUn/BIdlpDEc0tX3maFycuDqRNSjqsmn2SDS0NURzeIjnVpbtsNYjO+aWE5C48s9YJ58uVNyXw4NmUulVDAElLvWvLq2ytlL16z6PIUX2BO/OaYpWt8tJPOCS17h2WJkcfpyqc+2gQ59UJRyvZ9s3i+Req0mNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rkkB71De; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rkkB71De; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 938FC1F6E6
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 03:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712287655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6A0SvDhNG801d4VkeMVpC1gobXQXoZmUiTDFky5uis=;
	b=rkkB71DewH6yzmWZ2DinYogl0LfiyI38CACRo0fRdKMep6BwhAsdDI1OEF5mQ/f9E+Ea5m
	f1Dr91li0eb0jpHdb4SX6jmwbwJuWYT6motXSMU9sgw6flxgEiBNecCLeFtcGYtFHFjJQu
	n+YGhlN4aZxsVmi4/fRTI2qBwmYsP60=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rkkB71De
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712287655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6A0SvDhNG801d4VkeMVpC1gobXQXoZmUiTDFky5uis=;
	b=rkkB71DewH6yzmWZ2DinYogl0LfiyI38CACRo0fRdKMep6BwhAsdDI1OEF5mQ/f9E+Ea5m
	f1Dr91li0eb0jpHdb4SX6jmwbwJuWYT6motXSMU9sgw6flxgEiBNecCLeFtcGYtFHFjJQu
	n+YGhlN4aZxsVmi4/fRTI2qBwmYsP60=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A080213357
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 03:27:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sI8FFaZvD2a+aQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 03:27:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: simplify the inline extent map creation
Date: Fri,  5 Apr 2024 13:57:12 +1030
Message-ID: <5446ba76bd7fa527447a23fe6e3262b36533d4c7.1712287421.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712287421.git.wqu@suse.com>
References: <cover.1712287421.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 938FC1F6E6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

With the tree-checker ensuring all inline file extents starts at file
offset 0 and has a length no larger than sectorsize, we can simplify the
calculation to assigned those fixes values directly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index e58fb5347e65..844439f19949 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1265,20 +1265,19 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 	struct extent_buffer *leaf = path->nodes[0];
 	const int slot = path->slots[0];
 	struct btrfs_key key;
-	u64 extent_start, extent_end;
+	u64 extent_start;
 	u64 bytenr;
 	u8 type = btrfs_file_extent_type(leaf, fi);
 	int compress_type = btrfs_file_extent_compression(leaf, fi);
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
 	extent_start = key.offset;
-	extent_end = btrfs_file_extent_end(path);
 	em->ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 	em->generation = btrfs_file_extent_generation(leaf, fi);
 	if (type == BTRFS_FILE_EXTENT_REG ||
 	    type == BTRFS_FILE_EXTENT_PREALLOC) {
 		em->start = extent_start;
-		em->len = extent_end - extent_start;
+		em->len = btrfs_file_extent_end(path) - extent_start;
 		em->orig_start = extent_start -
 			btrfs_file_extent_offset(leaf, fi);
 		em->orig_block_len = btrfs_file_extent_disk_num_bytes(leaf, fi);
@@ -1299,9 +1298,12 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				em->flags |= EXTENT_FLAG_PREALLOC;
 		}
 	} else if (type == BTRFS_FILE_EXTENT_INLINE) {
+		/* Tree-checker has ensured this. */
+		ASSERT(extent_start == 0);
+
 		em->block_start = EXTENT_MAP_INLINE;
-		em->start = extent_start;
-		em->len = extent_end - extent_start;
+		em->start = 0;
+		em->len = fs_info->sectorsize;
 		/*
 		 * Initialize orig_start and block_len with the same values
 		 * as in inode.c:btrfs_get_extent().
@@ -1334,12 +1336,10 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path)
 	ASSERT(key.type == BTRFS_EXTENT_DATA_KEY);
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 
-	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
-		end = btrfs_file_extent_ram_bytes(leaf, fi);
-		end = ALIGN(key.offset + end, leaf->fs_info->sectorsize);
-	} else {
+	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE)
+		end = leaf->fs_info->sectorsize;
+	else
 		end = key.offset + btrfs_file_extent_num_bytes(leaf, fi);
-	}
 
 	return end;
 }
-- 
2.44.0


