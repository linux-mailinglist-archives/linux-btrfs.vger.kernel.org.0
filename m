Return-Path: <linux-btrfs+bounces-8716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A21996DFB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00957B22267
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACEC17555;
	Wed,  9 Oct 2024 14:32:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9B45948
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484339; cv=none; b=UGJBhE4Q0suSdgWQeo8PmY3i3/pxJvn+TkpnVWR20Eq6Jpprz2Zf2S+dTNk+n9jPU4+xbr95gHMiqKVCkPlRoBwlLTTwFNjGge7trTT9PBLt2Qq8OMs1ERVDlNP8dvgWWchb0QxuvE8obrBMEeqGz0lhq2/7RKBFHjX1J/aJlnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484339; c=relaxed/simple;
	bh=HDtyMQvQdieQs/Hpp9LJqI8YCrk6XT8S/wC9ERsMkdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+kYKjCyzV3zqnOnP5USivMOkuNfH3RBk6yxHddv4TpcPcOENP/nYl89OwwCq6Qwswtk+dgBle49S/NYY8aAILINE2lnfEXQVSa5eMwPdX3PhS401MWixg4821qVKrUWfUfuTVShjhdVP1RzmX/Z8VVErdshXBxuF0GEm2MeFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D731821EB2;
	Wed,  9 Oct 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C518F136BA;
	Wed,  9 Oct 2024 14:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BMYcMO+TBmeGRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:32:15 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 21/25] btrfs: drop unused parameter options from open_ctree()
Date: Wed,  9 Oct 2024 16:32:07 +0200
Message-ID: <5054362780a8a49ce97a238c5be8882c68df4d78.1728484021.git.dsterba@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D731821EB2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Since the new mount option parser in commit ad21f15b0f79 ("btrfs:
switch to the new mount API") we don't pass the options like that
anymore.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 3 +--
 fs/btrfs/disk-io.h | 3 +--
 fs/btrfs/super.c   | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4ad5db619b00..92c7dbeade1c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3202,8 +3202,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 	return 0;
 }
 
-int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
-		      const char *options)
+int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices)
 {
 	u32 sectorsize;
 	u32 nodesize;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 99af64d3f277..127e31e08347 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -52,8 +52,7 @@ struct extent_buffer *btrfs_find_create_tree_block(
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
 int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 			   const struct btrfs_super_block *disk_sb);
-int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
-		      const char *options);
+int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices);
 void __cold close_ctree(struct btrfs_fs_info *fs_info);
 int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 			 const struct btrfs_super_block *sb, int mirror_num);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e8a5bf4af918..a86fe54cd615 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -962,7 +962,7 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
-	err = open_ctree(sb, fs_devices, (char *)data);
+	err = open_ctree(sb, fs_devices);
 	if (err) {
 		btrfs_err(fs_info, "open_ctree failed");
 		return err;
-- 
2.45.0


