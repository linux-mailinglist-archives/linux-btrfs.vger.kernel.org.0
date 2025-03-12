Return-Path: <linux-btrfs+bounces-12230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B40EA5DB20
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 12:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E4D3B893F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 11:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DF923F28B;
	Wed, 12 Mar 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tlMSOuv9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tlMSOuv9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741ED4207F
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777966; cv=none; b=g864pDLSr+lQh+M/skpJHSUOCONyIFCookv/WCsu7j9yUp12l1su7y+NfPyBcLhMjhTnzR+ZM8+dPxSIuW1F5pOH+G2sbiZYmUXg1/PBqDrdR9jM2senb2rr9/OMkCffqPSTvLaqevVitxo3xvT+1xx4ZlN1epUxRRooB9PbN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777966; c=relaxed/simple;
	bh=s0dW5nUBT91sHXZesTTTCQH/gvwhk3R2VFjInWTWPSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJUAsGUEkPBJkrUq4YOYmBMyPMDSacJUtHAd5sXGPsTTBLE5xfXU3lh2E+cfjikXdMsOMLMkMBg4sFsMMoOwmIQrJBYpPWvSzj4x0oxENwOhU3BzGL+jWMN9xexKzF0XT3BgzgL/ygRIoFw0h7pvnecLro1Q618Sr1Xjztx4Jms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tlMSOuv9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tlMSOuv9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96BCE1F385;
	Wed, 12 Mar 2025 11:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741777962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWor71mLXLT8AE0MNHs3VKizKq5sg/fL3sTN8CjQI0E=;
	b=tlMSOuv9Oi7hRdwqKusfkd39aukS9K0zF6iofS2nxLoKpl94C+XYYbypyUEqnyHmmRVRds
	nKjn8ygb9/j+/a6NjYS9806TzUxqv7+yNP/aMUXFKe9bSyl35JTQlTW4TfbYPHU4rnLM0C
	jG5KbscZYmZyvUoSjKpizOd3S08ci14=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741777962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWor71mLXLT8AE0MNHs3VKizKq5sg/fL3sTN8CjQI0E=;
	b=tlMSOuv9Oi7hRdwqKusfkd39aukS9K0zF6iofS2nxLoKpl94C+XYYbypyUEqnyHmmRVRds
	nKjn8ygb9/j+/a6NjYS9806TzUxqv7+yNP/aMUXFKe9bSyl35JTQlTW4TfbYPHU4rnLM0C
	jG5KbscZYmZyvUoSjKpizOd3S08ci14=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F978132CB;
	Wed, 12 Mar 2025 11:12:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5x8MIyps0WdLNgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Mar 2025 11:12:42 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 6/6] btrfs: add mode to clear chunk map status to CLEAR_FREE ioctl
Date: Wed, 12 Mar 2025 12:12:42 +0100
Message-ID: <4208ea4c7e515fe38fd5e3d451180a349a595cf1.1741777050.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1741777050.git.dsterba@suse.com>
References: <cover.1741777050.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The trim status is tracked for each chunk in the fs_info::mapping_tree
and updated as trim is called either manually by 'fstrim' or
automatically when discard=async is enabled.

With the new modes it's necessary to allow clearing the cache otherwise
on a fully or partially trimmed filesystem the ioctl won't work as
expected.

Add separate clear free operation to reset just the trim status bits
from all chunks. This should be called namely when the clearing
operation is *not* trim (e.g. zeroout or secure erase).

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c           | 13 +++++++++++++
 fs/btrfs/volumes.c         |  5 +++++
 fs/btrfs/volumes.h         |  1 +
 include/uapi/linux/btrfs.h |  7 +++++++
 4 files changed, 26 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e84db3929763..f965f7fc1fa8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5235,6 +5235,19 @@ static int btrfs_ioctl_clear_free(struct file *file, void __user *arg)
 	if (args.type >= BTRFS_NR_CLEAR_OP_TYPES)
 		return -EOPNOTSUPP;
 
+	if (args.type == BTRFS_CLEAR_OP_RESET_CHUNK_STATUS_CACHE) {
+		write_lock(&fs_info->mapping_tree_lock);
+		for (struct rb_node *node = rb_first_cached(&fs_info->mapping_tree);
+		     node; node = rb_next(node)) {
+			struct btrfs_chunk_map *map;
+
+			map = rb_entry(node, struct btrfs_chunk_map, rb_node);
+			btrfs_chunk_map_clear_bits(map, CHUNK_TRIMMED);
+		}
+		write_unlock(&fs_info->mapping_tree_lock);
+		return 0;
+	}
+
 	ret = mnt_want_write_file(file);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f1b1d7446b20..786b93c18a22 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8079,6 +8079,11 @@ static int verify_chunk_dev_extent_mapping(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+void btrfs_chunk_map_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
+{
+	chunk_map_device_clear_bits(map, bits);
+}
+
 /*
  * Ensure that all dev extents are mapped to correct chunk, otherwise
  * later chunk allocation/free would cause unexpected behavior.
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index e247d551da67..0e793b9776d6 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -785,6 +785,7 @@ struct btrfs_chunk_map *btrfs_find_chunk_map_nolock(struct btrfs_fs_info *fs_inf
 						    u64 logical, u64 length);
 struct btrfs_chunk_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 					    u64 logical, u64 length);
+void btrfs_chunk_map_clear_bits(struct btrfs_chunk_map *map, unsigned int bits);
 void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map);
 void btrfs_release_disk_super(struct btrfs_super_block *super);
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index e2f16733c53f..605108ab21f3 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1119,6 +1119,13 @@ enum btrfs_clear_op_type {
 	BTRFS_CLEAR_OP_ZERO_NOUNMAP,
 	/* Request unmapping the blocks and don't fall back to writing zeros. */
 	BTRFS_CLEAR_OP_ZERO_NOFALLBACK,
+
+	/*
+	 * Only reset status of previously cleared (by any operation) chunks,
+	 * tracked in memory since the last mount. Without that repeated calls
+	 * to clear will skip already processed chunks.
+	 */
+	BTRFS_CLEAR_OP_RESET_CHUNK_STATUS_CACHE,
 	BTRFS_NR_CLEAR_OP_TYPES,
 };
 
-- 
2.47.1


