Return-Path: <linux-btrfs+bounces-11421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8153EA330B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 21:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C3F3A99C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 20:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8073720127F;
	Wed, 12 Feb 2025 20:22:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6FF200B99
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391738; cv=none; b=Nj5mL557H2b1QpBQhno4D01wEc7TxaKppQak1xFejOXgt3suxsgjcfUyjTCwmVr60P6hsY8EVzYRmUiFUJGfo48+nDPf1BhPG1QFjWEO8HS8OPCKGR4DA+36becxs4cvjNDGOievxfaJaUoIL0vylDFjHHmC7tqj/OK7R5Mk9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391738; c=relaxed/simple;
	bh=vJzexGH2063nshzdHgHuFi8MPnqB5WdeM+9XQ70BwUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3yS4qiRiGULiYh+kAMIux+cdWPXyf9q3YXjGmUJcVfdmbKaKjmLd1QQ0Q5QBHfERQdpy+JiSuEzvP5P5d1jsdz42MFrluCcxFSOmZkT8CcMNEoKYw76YuhzX5X2GVo3J57QBIzOEmRjK9HsG4m0HGADjDWZs+DpNJil5pbiVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E5D91F893;
	Wed, 12 Feb 2025 20:22:14 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AF2613AEF;
	Wed, 12 Feb 2025 20:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GXQCHvYCrWetJgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Feb 2025 20:22:14 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 6/7] btrfs: simplify returns and labels in btrfs_init_fs_root()
Date: Wed, 12 Feb 2025 21:22:14 +0100
Message-ID: <9808c56678ec3400b828e8ae4690c68560c161bc.1739391605.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739391605.git.dsterba@suse.com>
References: <cover.1739391605.git.dsterba@suse.com>
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
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 8E5D91F893
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

There's a label that does nothing else than return, so remove it and
also change other gotos to immediate returns as the function is short
enough for this pattern.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8c31ba1b061e..a799216aa264 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1101,9 +1101,11 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 }
 
 /*
- * Initialize subvolume root in-memory structure
+ * Initialize subvolume root in-memory structure.
  *
  * @anon_dev:	anonymous device to attach to the root, if zero, allocate new
+ *
+ * In case of failure the caller is responsible to call btrfs_free_fs_root()
  */
 static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 {
@@ -1127,7 +1129,7 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 		if (!anon_dev) {
 			ret = get_anon_bdev(&root->anon_dev);
 			if (ret)
-				goto fail;
+				return ret;
 		} else {
 			root->anon_dev = anon_dev;
 		}
@@ -1137,7 +1139,7 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 	ret = btrfs_init_root_free_objectid(root);
 	if (ret) {
 		mutex_unlock(&root->objectid_mutex);
-		goto fail;
+		return ret;
 	}
 
 	ASSERT(root->free_objectid <= BTRFS_LAST_FREE_OBJECTID);
@@ -1145,9 +1147,6 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 	mutex_unlock(&root->objectid_mutex);
 
 	return 0;
-fail:
-	/* The caller is responsible to call btrfs_free_fs_root */
-	return ret;
 }
 
 static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
-- 
2.47.1


