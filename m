Return-Path: <linux-btrfs+bounces-19560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3F5CACA62
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 10:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92A42305F668
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100DA2E7BAD;
	Mon,  8 Dec 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oJkQLI/j";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oJkQLI/j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E0B30F7E9
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765185973; cv=none; b=mRyg+TAC9DptQEPWf+7aI3eVkqEb3VXhCdqWqvUXjJrSYe2xxbRD+qgltdsvJXPFhwfOH7VLJiC/EXOIC50ZWDzNNjR3Y1jHMttEH24YRF3nkZ3pSk+RiZn6afxElBgOHO3w05J78HoB7hI6bUO42WkFMi+KlAMh8Ax9GAYluhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765185973; c=relaxed/simple;
	bh=hqO9+0Q5ufpwU5gSlaOvwG5XzrVpgsZugu9dJKUkLnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DexsrBIHwLsUkLGu4xOLeMNd7+qzXIcjI0D8BCw/6fh0kqYdtWyGitavsUZDzmtYEjoSybAjMhGEE9gPahoWFDwkp7+u/lirVrx3iJ3weT9ntbsiRdY+P0kbMXFcVdDmeGymYF1JDnbm2TBmzP6EeFaMQCc9vYeQ//4aqZq6oQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oJkQLI/j; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oJkQLI/j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B3565BE9F;
	Mon,  8 Dec 2025 09:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765185967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VWtdnvO9X2GbF6fzyOkfH+BGuUU6dpv0Dkc57uPLiHg=;
	b=oJkQLI/jz9pjCjkJM2CSnoYkaO/fbzUWuwlKQFp+51DvbdDmK0D9jnorupMxhreirf4CKy
	61ipWS4OqFjkTUp5HTOOnFHe/lfI1o3y/Lry8Yof1lm4aQ6P6Bz6lDGlqHovkUQzU2gjlJ
	LWOhtws2imJWkAwYBhDB3R9xAnoxL4o=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="oJkQLI/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765185967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VWtdnvO9X2GbF6fzyOkfH+BGuUU6dpv0Dkc57uPLiHg=;
	b=oJkQLI/jz9pjCjkJM2CSnoYkaO/fbzUWuwlKQFp+51DvbdDmK0D9jnorupMxhreirf4CKy
	61ipWS4OqFjkTUp5HTOOnFHe/lfI1o3y/Lry8Yof1lm4aQ6P6Bz6lDGlqHovkUQzU2gjlJ
	LWOhtws2imJWkAwYBhDB3R9xAnoxL4o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EF573EA63;
	Mon,  8 Dec 2025 09:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p3y2BK6ZNmkKGQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 08 Dec 2025 09:26:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: mssola@mssola.com,
	syzbot+b44d4a4885bc82af2a06@syzkaller.appspotmail.com
Subject: [PATCH] Revert "btrfs: add ASSERTs on prealloc in qgroup functions"
Date: Mon,  8 Dec 2025 19:55:48 +1030
Message-ID: <65fee7dc5c82e194d20be47bb3772949e4ec22c8.1765185918.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,appspotmail.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[b44d4a4885bc82af2a06];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,appspotmail.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 8B3565BE9F
X-Spam-Flag: NO
X-Spam-Score: -4.01

This reverts commit 252877a8701530fde861a4f27710c1e718e97caa.

Commit 252877a87015 ("btrfs: add ASSERTs on prealloc in qgroup
functions") tries to remove the kfree() on preallocated qgroup during
several call sites, but it can not be more wrong:

- btrfs_quota_enable()
- btrfs_create_qgroup()
  If add_qgroup_item() failed, we go out_free_path() and at that time
  @prealloc is not yet utilized and will trigger the new ASSERT().

- btrfs_qgroup_inherit()
  If qgroup_auto_inherit() failed, @prealloc is not yet utilized and
  will trigger the new ASSERT()

Reported-by: syzbot+b44d4a4885bc82af2a06@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/69369331.a70a0220.38f243.009e.GAE@google.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9e2b53e90dcb..d9d8d9968a58 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1243,14 +1243,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 		btrfs_end_transaction(trans);
 	else if (trans)
 		ret = btrfs_end_transaction(trans);
-
-	/*
-	 * At this point we either failed at allocating prealloc, or we
-	 * succeeded and passed the ownership to it to add_qgroup_rb(). In any
-	 * case, this needs to be NULL or there is something wrong.
-	 */
-	ASSERT(prealloc == NULL);
-
+	kfree(prealloc);
 	return ret;
 }
 
@@ -1682,12 +1675,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
 out:
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
-	/*
-	 * At this point we either failed at allocating prealloc, or we
-	 * succeeded and passed the ownership to it to add_qgroup_rb(). In any
-	 * case, this needs to be NULL or there is something wrong.
-	 */
-	ASSERT(prealloc == NULL);
+	kfree(prealloc);
 	return ret;
 }
 
@@ -3279,7 +3267,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *srcgroup;
 	struct btrfs_qgroup *dstgroup;
-	struct btrfs_qgroup *prealloc = NULL;
+	struct btrfs_qgroup *prealloc;
 	struct btrfs_qgroup_list **qlist_prealloc = NULL;
 	bool free_inherit = false;
 	bool need_rescan = false;
@@ -3520,14 +3508,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	}
 	if (free_inherit)
 		kfree(inherit);
-
-	/*
-	 * At this point we either failed at allocating prealloc, or we
-	 * succeeded and passed the ownership to it to add_qgroup_rb(). In any
-	 * case, this needs to be NULL or there is something wrong.
-	 */
-	ASSERT(prealloc == NULL);
-
+	kfree(prealloc);
 	return ret;
 }
 
-- 
2.52.0


