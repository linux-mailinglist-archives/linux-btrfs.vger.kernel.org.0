Return-Path: <linux-btrfs+bounces-1482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E439282F362
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 18:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C831C2374F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 17:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1EB1CD33;
	Tue, 16 Jan 2024 17:43:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B71CD14
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426995; cv=none; b=lVABvmU/YCyrd4XMnkVeXnNV6CJf3Qg3EKbiF34CCp1mAjdr1MVjAgXH3GTYrhgXMnfYVO7KkSivIk3Kx+lzrbN6BdpZeUj45rqd3aEiUfWI1plOxFHDiHgUr2V5c5mxFTOJvuSCbL2lTUYsWn0VLYC5uQBP9Q4FlrKHOK2i9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426995; c=relaxed/simple;
	bh=2LUtgbokTPAaHAzJ9a0dDVnyNI7EODm0YZcWZauG8GM=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Score:X-Spam-Flag; b=DfhKmY2oGuMn0grRjDVKCok3SoeGySnPoyFnagYMWQotzZeN825ICzdIG8CTGgOuBVVUrFjwaius1JvDZefPgQPQoXKuh6VpgtRqrbSgm5OuDDjYGQH5r7PlAD1LtAhfBq9d8gEOQTAvwPI0z3rrRFXCV6k9Lb3NXEKgZ7hGTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0D7722126;
	Tue, 16 Jan 2024 17:43:12 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 99557133CE;
	Tue, 16 Jan 2024 17:43:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9FJqJTDApmUpNAAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 16 Jan 2024 17:43:12 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: make btrfs_error_unpin_extent_range() return void
Date: Tue, 16 Jan 2024 18:42:55 +0100
Message-ID: <ecac0a7502542da3fc15fceee65d828904dfd19f.1705426614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1705426614.git.dsterba@suse.com>
References: <cover.1705426614.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A0D7722126
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

This helper is used in transaction abort or cleanup context and the
callers cannot handle all errors, only do best effort.

btrfs_cleanup_one_transaction
  btrfs_destroy_delayed_refs
    btrfs_error_unpin_extent_range
  btrfs_destroy_pinned_extent
    btrfs_error_unpin_extent_range

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h       |  3 +--
 fs/btrfs/extent-tree.c | 13 ++++++-------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 70e828d33177..eede81288196 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -478,8 +478,7 @@ static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
 	return mapping_gfp_constraint(mapping, ~__GFP_FS);
 }
 
-int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
-				   u64 start, u64 end);
+void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u64 end);
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 num_bytes, u64 *actual_bytes);
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 42293f617f42..4283e3025ab0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6174,14 +6174,13 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
-				   u64 start, u64 end)
+/*
+ * Unpin the extent range in an error context and don't add the space back.
+ * Errors are not propagated further.
+ */
+void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u64 end)
 {
-	int ret;
-
-	ret = unpin_extent_range(fs_info, start, end, false);
-	BUG_ON(ret);
-	return ret;
+	unpin_extent_range(fs_info, start, end, false);
 }
 
 /*
-- 
2.42.1


