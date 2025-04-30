Return-Path: <linux-btrfs+bounces-13559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F2AA5209
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 18:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDF93AD593
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2506C2641D8;
	Wed, 30 Apr 2025 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mpk+OhwQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mpk+OhwQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E60F1684B4
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031816; cv=none; b=fraeGkAtVx3Bhz8O2hKZz+NsAmavLpyTPrCih6pCOCa25OBKTysefZ9s1rOUMDoc14mbgl4kNb8UHs+5hqTcCtDMGUtTuTton5wTVon2F5hdANik+tFD4XgpJO9Mfgx9Tf3Dt24K6J0Z74pxtkuuziV/9/Pvq7l4AAa5zwwrx5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031816; c=relaxed/simple;
	bh=MSTetQGm1tZdyQfg6Zl+/dd495nIrYPWdKv8fD8KgbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9Af6EX9EIMlp5dRFIUy4lKZLxbDZyXWai/ue56ee32wT+f0JjXtdCYqUSSs5RCPYb2hspnE7SLrfPtWHXM+dJsuh1q4unM48zzDtGZmyTkJZx/Bg27shKi3W39/WDaKZuAyFChwNbRjufC+MKaYtf6ZJjVrvMJ1gK+YqbfXm5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mpk+OhwQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mpk+OhwQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A8EC1F394;
	Wed, 30 Apr 2025 16:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746031812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vm6rGO97D1fDfppkEJNDxj4oHiFXKKTUcIt8VBEptVc=;
	b=mpk+OhwQiZEH3+vDEqnFkgQvlkz+Cd8GG2vTG0xEE2ibqCvGTly8EleTcUXrI/NRP5K35J
	MZY3cX72ru5BjmdfESDgIWTL1IvMXO3bv8e0qJUcCC6J+kGgdAs4wjP/cNezw74gM3vjRq
	AEujHnjK8gKkX529oULwvTZ0p4YHC5o=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mpk+OhwQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746031812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vm6rGO97D1fDfppkEJNDxj4oHiFXKKTUcIt8VBEptVc=;
	b=mpk+OhwQiZEH3+vDEqnFkgQvlkz+Cd8GG2vTG0xEE2ibqCvGTly8EleTcUXrI/NRP5K35J
	MZY3cX72ru5BjmdfESDgIWTL1IvMXO3bv8e0qJUcCC6J+kGgdAs4wjP/cNezw74gM3vjRq
	AEujHnjK8gKkX529oULwvTZ0p4YHC5o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 933D7139E7;
	Wed, 30 Apr 2025 16:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2artI8RUEmgFNAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 30 Apr 2025 16:50:12 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/4] btrfs: move transaction aborts to the error site in convert_free_space_to_extents()
Date: Wed, 30 Apr 2025 18:45:19 +0200
Message-ID: <c4795727d27ca56fd6b353eb5f305e23ce3e38ce.1746031378.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746031378.git.dsterba@suse.com>
References: <cover.1746031378.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9A8EC1F394
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Transaction aborts should be done next to the place the error happens,
which was not done in convert_free_space_to_extents().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index b5458a71f0b3e8..ef39d103443524 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -364,6 +364,7 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	bitmap = alloc_bitmap(bitmap_size);
 	if (!bitmap) {
 		ret = -ENOMEM;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
@@ -376,8 +377,10 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 
 	while (!done) {
 		ret = btrfs_search_prev_slot(trans, root, &key, path, -1, 1);
-		if (ret)
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
+		}
 
 		leaf = path->nodes[0];
 		nr = 0;
@@ -418,14 +421,17 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 		}
 
 		ret = btrfs_del_items(trans, root, path, path->slots[0], nr);
-		if (ret)
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
+		}
 		btrfs_release_path(path);
 	}
 
 	info = search_free_space_info(trans, block_group, path, 1);
 	if (IS_ERR(info)) {
 		ret = PTR_ERR(info);
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 	leaf = path->nodes[0];
@@ -447,8 +453,10 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 		key.offset = (end_bit - start_bit) * block_group->fs_info->sectorsize;
 
 		ret = btrfs_insert_empty_item(trans, root, path, &key, 0);
-		if (ret)
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
+		}
 		btrfs_release_path(path);
 
 		extent_count++;
@@ -461,16 +469,14 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 			  "incorrect extent count for %llu; counted %u, expected %u",
 			  block_group->start, extent_count,
 			  expected_extent_count);
-		DEBUG_WARN();
 		ret = -EIO;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
 	ret = 0;
 out:
 	kvfree(bitmap);
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
 	return ret;
 }
 
-- 
2.49.0


