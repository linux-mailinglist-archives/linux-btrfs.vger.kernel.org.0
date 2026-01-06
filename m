Return-Path: <linux-btrfs+bounces-20158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8D8CF851E
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 13:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA4813013C29
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E070F4C81;
	Tue,  6 Jan 2026 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YFJ2v9tW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jC50l8v3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26BE1A3179
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702634; cv=none; b=cVcOZVnYDi8rI4gjtSfnTv04CM55luhzLZKwkfhklUGMtXxxs26I3Zi7Yu44cssbjoy0pNsB3PMmHUwJYW3m5GszGt0+mCW27v/iHZzKXsqZOShD/XmGRWbLokcZnaTnGk5kFy1xohSUd0c2RvhGgd3J15VId+IeoPnsSq/CmLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702634; c=relaxed/simple;
	bh=ODMZwvGNXiZJZgPNfd8usIhnaYUXWMOYriNR2EZ34ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5hCR1gVi00/YOQKxFEyPHy07tgNYWcQlQXtjuzq2U8zdVrD62MCOI1i5auX9h0h7CXZIyrxSlLQI76Ewub7jyVNS6z9X2aUrHq1XZhefaFKTNP7ol6AjYmGONC4ZhtXiAMvnF52f7UgvZC11jusKxoS7ixiFHmmMFVAiaaLEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YFJ2v9tW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jC50l8v3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 974445BCC3;
	Tue,  6 Jan 2026 12:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767702630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y8i/0Iu5iGp4LUOK7bVFfNFP/FaWeVj7qiF1qHIllgc=;
	b=YFJ2v9tW1dFShAbtow15pUzFCDCKgcAeMn6sOpg2oso3KLz9WUlwgSlpZmnda7gNMRPCtq
	Tb+MKL9s6ptlR3qRFjJovwdl+hyPlzH2n3k8VP5/s8+BDWE1GY+FmSRDXCOKUmFwrXGS4R
	zk+jtTz2oEacKdbQZSRXAfErYyN8xtI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767702629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y8i/0Iu5iGp4LUOK7bVFfNFP/FaWeVj7qiF1qHIllgc=;
	b=jC50l8v3M6pqNqxXZI/X/D1crxhn78klzQklUShYt4sw7d0jq9zWYLUlHMZGhLN4X4RF5S
	jzqHNBr/cXNuPdKrt0TvwvfJovWGPeQY16NL78UkyYqPggTNMDwR53M5pYLiGyJ8nG/WQo
	U2lMip339mCi21+OYF/Xii/nVvlCt7A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 909163EA63;
	Tue,  6 Jan 2026 12:30:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z0tAI2UAXWlYCgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 12:30:29 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: split btrfs_fs_closing() and change return type to bool
Date: Tue,  6 Jan 2026 13:30:28 +0100
Message-ID: <20260106123028.3105367-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.976];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

There are two tests in btrfs_fs_closing() but checking the
BTRFS_FS_CLOSING_DONE bit is done only in one place
load_extent_tree_free(). As this is an inline we can reduce size of the
generated code. The types can be also changed to bool as this becomes a
simple condition.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/fs.h          | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e417aba4c4c7a0..a1119f06b6d106 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -761,7 +761,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 	nritems = btrfs_header_nritems(leaf);
 
 	while (1) {
-		if (btrfs_fs_closing(fs_info) > 1) {
+		if (btrfs_fs_closing_done(fs_info)) {
 			last = (u64)-1;
 			break;
 		}
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 0dc851b9c51bc2..e220202e6a10c3 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -1110,15 +1110,20 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 #define btrfs_test_opt(fs_info, opt)	((fs_info)->mount_opt & \
 					 BTRFS_MOUNT_##opt)
 
-static inline int btrfs_fs_closing(const struct btrfs_fs_info *fs_info)
+static inline bool btrfs_fs_closing(const struct btrfs_fs_info *fs_info)
 {
-	/* Do it this way so we only ever do one test_bit in the normal case. */
-	if (test_bit(BTRFS_FS_CLOSING_START, &fs_info->flags)) {
-		if (test_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags))
-			return 2;
-		return 1;
-	}
-	return 0;
+	if (unlikely(test_bit(BTRFS_FS_CLOSING_START, &fs_info->flags)))
+		return true;
+
+	return false;
+}
+
+static inline bool btrfs_fs_closing_done(const struct btrfs_fs_info *fs_info)
+{
+	if (btrfs_fs_closing(fs_info) && test_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags))
+		return true;
+
+	return false;
 }
 
 /*
-- 
2.51.1


