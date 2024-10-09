Return-Path: <linux-btrfs+bounces-8706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF3996DDE
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7831F22E16
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B585F1A00D2;
	Wed,  9 Oct 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rB8d78mP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rB8d78mP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81519F471
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484286; cv=none; b=iM82zYJnEoeISmHR1PX/sAtmJeX4FHStomJFVDk1uQYmJ9aW+k+67rfsW3mGLXt2ZnuYNjUvZ6DHlkXVIG0R37f+T8pVlYrUGdAK4WIrLiXwlfVEeJ1FNwHTTOBeM9XD17fAfcGRJdO/DKuPS38G9G55Q9i29n4YIhcBYkpiCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484286; c=relaxed/simple;
	bh=0KWcCVQ3xFTwhLn1uO1bdBVjFoAV4IMa8o5++RHhKUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT7+wUQNs9ENXx5jXYADi1m8sPCevtkU3ZRNPloMZhlYNdxpDbftoCWRP24VBmCAAxDIPuZG1NxE6SzCdetO053EtVyrgOqMYJy1Uv/tSvtek/v0WONDsGfqlFKPbCzPNO8lLC2Iv2bmOXOxR0y2jzNWW4OY1l0qGDlFkzjn7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rB8d78mP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rB8d78mP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 787C521EB2;
	Wed,  9 Oct 2024 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJGDrVHxErk0SbQ44vJQYDy1Iz7spI8cFXTZBgR4GMk=;
	b=rB8d78mPN30piEXmAWb2tgPGN5QjpZw7Ph+9sYfpi0+s4sK9qacRsuJ0byKYaBrdpmADvQ
	bITUgsR5FwRjYTk1GX2b+VMDPvfBlSWuU2510FSY4nAL1blG02PWDSrFS/LpEIR8wOymoq
	nz1dPmF17ct2NL8CN9DidxPogP5KSa0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJGDrVHxErk0SbQ44vJQYDy1Iz7spI8cFXTZBgR4GMk=;
	b=rB8d78mPN30piEXmAWb2tgPGN5QjpZw7Ph+9sYfpi0+s4sK9qacRsuJ0byKYaBrdpmADvQ
	bITUgsR5FwRjYTk1GX2b+VMDPvfBlSWuU2510FSY4nAL1blG02PWDSrFS/LpEIR8wOymoq
	nz1dPmF17ct2NL8CN9DidxPogP5KSa0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71C06136BA;
	Wed,  9 Oct 2024 14:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vQnDG7uTBmciRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:23 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 11/25] btrfs: drop unused transaction parameter from btrfs_qgroup_add_swapped_blocks()
Date: Wed,  9 Oct 2024 16:31:23 +0200
Message-ID: <e3a95049bd2667cf566eea4b4354e1e4584ff0e0.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

The caller replace_path() runs under transaction but we don't need it in
btrfs_qgroup_add_swapped_blocks().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/qgroup.c     | 3 +--
 fs/btrfs/qgroup.h     | 3 +--
 fs/btrfs/relocation.c | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b2d421b4cd5a..0fcf6e91616e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4692,8 +4692,7 @@ void btrfs_qgroup_clean_swapped_blocks(struct btrfs_root *root)
  *			BOTH POINTERS ARE BEFORE TREE SWAP
  * @last_snapshot:	last snapshot generation of the subvolume tree
  */
-int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
-		struct btrfs_root *subvol_root,
+int btrfs_qgroup_add_swapped_blocks(struct btrfs_root *subvol_root,
 		struct btrfs_block_group *bg,
 		struct extent_buffer *subvol_parent, int subvol_slot,
 		struct extent_buffer *reloc_parent, int reloc_slot,
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 5ba2b181636b..9fbd008749fa 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -437,8 +437,7 @@ void btrfs_qgroup_init_swapped_blocks(
 	struct btrfs_qgroup_swapped_blocks *swapped_blocks);
 
 void btrfs_qgroup_clean_swapped_blocks(struct btrfs_root *root);
-int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
-		struct btrfs_root *subvol_root,
+int btrfs_qgroup_add_swapped_blocks(struct btrfs_root *subvol_root,
 		struct btrfs_block_group *bg,
 		struct extent_buffer *subvol_parent, int subvol_slot,
 		struct extent_buffer *reloc_parent, int reloc_slot,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f3834f8d26b4..bf267bdfa8f8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1244,7 +1244,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		 * The real subtree rescan is delayed until we have new
 		 * CoW on the subtree root node before transaction commit.
 		 */
-		ret = btrfs_qgroup_add_swapped_blocks(trans, dest,
+		ret = btrfs_qgroup_add_swapped_blocks(dest,
 				rc->block_group, parent, slot,
 				path->nodes[level], path->slots[level],
 				last_snapshot);
-- 
2.45.0


