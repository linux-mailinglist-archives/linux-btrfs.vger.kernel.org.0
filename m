Return-Path: <linux-btrfs+bounces-8717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F49996DFC
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D3E282F47
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB9318BBB0;
	Wed,  9 Oct 2024 14:32:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103BB45948
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484341; cv=none; b=qIj9BczPd4sSFFuoIJl+BHKNwp1c4njCxMf+VdE5Idf+7O9ZkWOli21iF3HOJ9SykcFZ4Iw5rxAOBDsneCKOmE3mo8Q1m6V+WU+C87k8r1o+68pikJ3F+qwmhevrHdvDgpAG5EknjxKkqTtL9AMfGqcWjhul3qZ13Nz5WK5zN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484341; c=relaxed/simple;
	bh=YY18nlBk6PasiVeYXr1J+K1zZAfKHMU3vEFpHv9WK4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LV5bQa7RBQyuKuREQFaCyJ73LX1yc0yQ7RCoRMF+LIUcUl3vlQnX1o8f/QDkG/6bH6QPBr3tXpLCfwIpFtPf+r/ueeBXZ1DFCn38NsHYBM/xpDed63x/u2qVGrT3PdbsxBUKq9UCp+8FzkKDnES6JyTYs6RCubv0kj/FomF9QOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57FC321F7F;
	Wed,  9 Oct 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 510A9136BA;
	Wed,  9 Oct 2024 14:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gCXHE/KTBmeJRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:32:18 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 22/25] btrfs: drop unused parameter data from btrfs_fill_super()
Date: Wed,  9 Oct 2024 16:32:17 +0200
Message-ID: <1b11c0621f4e11aaaa5f46b930f7bcda977080f0.1728484021.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 57FC321F7F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

The only caller passes NULL, we can drop the parameter. This is since
the new mount option parser done in 3bb17a25bcb09a ("btrfs: add get_tree
callback for new mount API").

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a86fe54cd615..a0b463d17c29 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -937,8 +937,7 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 }
 
 static int btrfs_fill_super(struct super_block *sb,
-			    struct btrfs_fs_devices *fs_devices,
-			    void *data)
+			    struct btrfs_fs_devices *fs_devices)
 {
 	struct inode *inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
@@ -1885,7 +1884,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
 		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
-		ret = btrfs_fill_super(sb, fs_devices, NULL);
+		ret = btrfs_fill_super(sb, fs_devices);
 	}
 
 	if (ret) {
-- 
2.45.0


