Return-Path: <linux-btrfs+bounces-14320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA1EAC934B
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA2C1C014ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A51A83F7;
	Fri, 30 May 2025 16:17:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055FC2E401
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621842; cv=none; b=RGyPbDbyurp0ZKgV4jk04mZLIdR08QRFMxJUShLAca+iaxsKq+rKRQlpDGw6vwP+9RBygvUNVZBaDlKpZA7nc6WTzx4kdKetlJne2x74MRHnp5ghISgL40PEYMdLW/+TvqRfBFCslfn9w4rwzsYW+K+3yzlRGE6L7pRu1RD9Bio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621842; c=relaxed/simple;
	bh=ukCGbnqCjJ7Nx3hP9C3bx+d4qmgbjjH0FCMrpb//oN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjYjwaIU7gEkTlp+tzfe1Mg0NY/tYF+v8vTrvG95SsbFnRSQ/V8gUYe83cK2SztworhsB+iikiubKl/Km9DU64T/rIgz6ZkdqwvRYDGd8elfQI6CsBXSBDSNcRzGUGzecvFdJzRxpZeh3H7lRviKUkPq211SPZCb4+08GaYRdAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2AEC021A20;
	Fri, 30 May 2025 16:17:12 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24DF813889;
	Fri, 30 May 2025 16:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oDD+CAjaOWhuZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:17:12 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/22] btrfs: rename err to ret2 in read_block_for_search()
Date: Fri, 30 May 2025 18:17:11 +0200
Message-ID: <fd07822afb8560366462a025f3c075959e45f6f4.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2AEC021A20
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a5ee6ce312cf..06dc7731c54a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1457,8 +1457,8 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	u64 blocknr;
 	struct extent_buffer *tmp = NULL;
 	int ret = 0;
+	int ret2;
 	int parent_level;
-	int err;
 	bool read_tmp = false;
 	bool tmp_locked = false;
 	bool path_released = false;
@@ -1516,9 +1516,9 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 		}
 
 		/* Now we're allowed to do a blocking uptodate check. */
-		err = btrfs_read_extent_buffer(tmp, &check);
-		if (err) {
-			ret = err;
+		ret2 = btrfs_read_extent_buffer(tmp, &check);
+		if (ret2) {
+			ret = ret2;
 			goto out;
 		}
 
@@ -1559,9 +1559,9 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	}
 
 	/* Now we're allowed to do a blocking uptodate check. */
-	err = btrfs_read_extent_buffer(tmp, &check);
-	if (err) {
-		ret = err;
+	ret2 = btrfs_read_extent_buffer(tmp, &check);
+	if (ret2) {
+		ret = ret2;
 		goto out;
 	}
 
-- 
2.47.1


