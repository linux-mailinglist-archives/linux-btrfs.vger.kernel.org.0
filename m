Return-Path: <linux-btrfs+bounces-14105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BEDABABFA
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 21:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2509C7A7DD0
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 19:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BF61624F7;
	Sat, 17 May 2025 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kIDOGE6f";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kIDOGE6f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819542D052
	for <linux-btrfs@vger.kernel.org>; Sat, 17 May 2025 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747508662; cv=none; b=oi0GuqhFt0+ytXSK7rBZAvu/bQAbO5FCc+WbVcE2wqkws6BFmGiqZzDAUlEEwDPBGKH3E0EbNxIrm5wJfj9EIE7n3pzK78o/u9omwx022sISwtaYWsm40txLg9OfqQQ7ujlxXNtqPd9g0oZ9CBuvSCqSpoC43qHUc+QAai6cCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747508662; c=relaxed/simple;
	bh=H/849dGhT/86VMmkIKxCe0z8foWbz20NmeEAsZ3P7xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJx3G3zN3N69Tx2PGyh0DGvGcwKpI9JfCm0sCZtrH5tsgHEKO6VBMpY5SM3Yv0hBUD3aNg2zK4HzsHRBzzqToNrHvjpVZcOxhiFFoa9I+rgp8IZZu9jUDPrO917J1rWiiU1Bd7tvTJvrgYskFhCTFMkaXP5/lB+8+30mdCcB3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kIDOGE6f; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kIDOGE6f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 06CEA1FF2D;
	Sat, 17 May 2025 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747508653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YHB+YpMk71Bnhb418iKAaqik6BjS6z+DPJ75FL0ZhPU=;
	b=kIDOGE6fVLRoP+YBtvGQtLGwdiJIUhA/5HUdHZZ87pVZ3KEtsgDO9SrW2GM5kjM/XxJDS0
	18TLKmuqfx/xLnHtpdpAtvm1/WpBpbE+zF2iREpS/kg2yNgzKFOI4bzFQBYV1HnejPW/FH
	I/AB0uV2Ndpe1JIaGpbd8IOUNWoa/7Q=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747508653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YHB+YpMk71Bnhb418iKAaqik6BjS6z+DPJ75FL0ZhPU=;
	b=kIDOGE6fVLRoP+YBtvGQtLGwdiJIUhA/5HUdHZZ87pVZ3KEtsgDO9SrW2GM5kjM/XxJDS0
	18TLKmuqfx/xLnHtpdpAtvm1/WpBpbE+zF2iREpS/kg2yNgzKFOI4bzFQBYV1HnejPW/FH
	I/AB0uV2Ndpe1JIaGpbd8IOUNWoa/7Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0044013991;
	Sat, 17 May 2025 19:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 924OAK3dKGiSbwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Sat, 17 May 2025 19:04:13 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: move transaction aborts to the error site in remove_block_group_free_space()
Date: Sat, 17 May 2025 21:04:10 +0200
Message-ID: <20250517190410.3027963-1-dsterba@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Transaction aborts should be done next to the place the error happens,
which was not done in remove_block_group_free_space().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 6cbdb578e66c1f..af51cf784a5bd7 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1444,6 +1444,7 @@ int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
@@ -1456,8 +1457,10 @@ int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 
 	while (!done) {
 		ret = btrfs_search_prev_slot(trans, root, &key, path, -1, 1);
-		if (ret)
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
+		}
 
 		leaf = path->nodes[0];
 		nr = 0;
@@ -1485,16 +1488,16 @@ int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 		}
 
 		ret = btrfs_del_items(trans, root, path, path->slots[0], nr);
-		if (ret)
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
+		}
 		btrfs_release_path(path);
 	}
 
 	ret = 0;
 out:
 	btrfs_free_path(path);
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
 	return ret;
 }
 
-- 
2.49.0


