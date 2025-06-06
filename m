Return-Path: <linux-btrfs+bounces-14534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A9AD07BE
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 19:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4A71742CB
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703262882A1;
	Fri,  6 Jun 2025 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fYR+epjR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fYR+epjR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA62BA38
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749232208; cv=none; b=E2KLo1cVvf2/jYohN2x6iLGrJvI8vhgGr9JjvXO+s0CyauyEX4jHu8EGnd+DzpiLS5OV0ZlZ9mVDsmaod2MipPdsKG14RO7mggseV5vhTxqv2poCF5GWrIdH9z7CBPVCHo8fNTNWoGnW+pQkjTJVdYQoTTZvwKx4C1I+T+3cWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749232208; c=relaxed/simple;
	bh=QYTQ2VAeFQHZpH1GhzlV46/Zc9FegCcQgeeI9kvDGJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEyOHTNa+k3Fhc82oPx5PbAggl692rHbxqAecPJTiqeieGEKhNwPYi3r5CV3NzdH3lcNWgPv5bk4JeDZSpo9v9O11VTmOGYiXijhVeadHm5XnDYluqGkkOo40qaepMx928yc4Y9woZ20/AMu5xIqwS9bH9d6F1i+TNHQSDkaRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fYR+epjR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fYR+epjR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CF85336B1;
	Fri,  6 Jun 2025 17:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749232204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=m6Rd4paIlfAttmLXQ572NPQZ30Wze4Cke1U6iVbITVk=;
	b=fYR+epjRJd2TwPA/adWT41xkiC+Ryu5CDyvJwBPoXcDzMcWUGkh/P+9sSyul2o5RdOCFt4
	wJUdcpYat4cJuK01hvIHiabYd6PHu+rBpteHjskoiHDsrVbAz7wUPnb3ygxTDu746bYORY
	DHzOaWVXjVWIySDjy+WCf32eCA1ov/U=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749232204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=m6Rd4paIlfAttmLXQ572NPQZ30Wze4Cke1U6iVbITVk=;
	b=fYR+epjRJd2TwPA/adWT41xkiC+Ryu5CDyvJwBPoXcDzMcWUGkh/P+9sSyul2o5RdOCFt4
	wJUdcpYat4cJuK01hvIHiabYd6PHu+rBpteHjskoiHDsrVbAz7wUPnb3ygxTDu746bYORY
	DHzOaWVXjVWIySDjy+WCf32eCA1ov/U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 959AE1336F;
	Fri,  6 Jun 2025 17:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B1yCJEwqQ2h2VgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 06 Jun 2025 17:50:04 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use btrfs_is_data_reloc_root() where not done yet
Date: Fri,  6 Jun 2025 19:50:01 +0200
Message-ID: <20250606175001.3561736-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
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
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Two remaining cases where we can use the helper.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file-item.c | 2 +-
 fs/btrfs/inode.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 54d523d4f42126..c09fbc257634ab 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -427,7 +427,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 			memset(csum_dst, 0, csum_size);
 			count = 1;
 
-			if (btrfs_root_id(inode->root) == BTRFS_DATA_RELOC_TREE_OBJECTID) {
+			if (btrfs_is_data_reloc_root(inode->root)) {
 				u64 file_offset = bbio->file_offset + bio_offset;
 
 				btrfs_set_extent_bit(&inode->io_tree, file_offset,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 00e7f98d97faaf..28c162174fac6f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -308,7 +308,7 @@ static void __cold btrfs_print_data_csum_error(struct btrfs_inode *inode,
 	const u32 csum_size = root->fs_info->csum_size;
 
 	/* For data reloc tree, it's better to do a backref lookup instead. */
-	if (btrfs_root_id(root) == BTRFS_DATA_RELOC_TREE_OBJECTID)
+	if (btrfs_is_data_reloc_root(root))
 		return print_data_reloc_error(inode, logical_start, csum,
 					      csum_expected, mirror_num);
 
-- 
2.49.0


