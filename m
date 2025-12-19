Return-Path: <linux-btrfs+bounces-19885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F17CCCE981
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 06:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3BED300EA2F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 05:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833A72D59FA;
	Fri, 19 Dec 2025 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b3Dwd27o";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dXpA1QTp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743788248B
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766123666; cv=none; b=NmnHP+wXVeQjXkoRHyFLcQwoNzcdBhV0SSnxvZQMSlY0w8wBJQUqGcpdmrWHHmNOK9G2RWo9w7hOJdArMUQwbhZke9RksDKW8aEftNGgkcYpRNaF/6zDJcmJ1nZdCIjj+9+YS9CIoUs4Iwde3UeUnzWF8OPR4nxyXgGwzUzWIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766123666; c=relaxed/simple;
	bh=K+AbIfQjkhCvySkgqwwn9o9yqOP41/jnGKjgD2fYF1o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aa/9Huwx8XIeNWvHCa4byDaZpR+xaV60EKfRQ6p99VZkoiYwna9aWwK2a0G+9npWR5MYqdYW/cZkzD3LH4wQ6i1DZ/2jLQcVcfhMluZ4jG4z9HEgp3hhKdJ69QPeP1kDAKC5D7aNUHb6nMR4/c6eS68eGuti/oeTLH0RiuOSgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b3Dwd27o; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dXpA1QTp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 354E25BD14
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 05:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766123662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Va0liQrjbR9LbaypDzv+r4o+ZSGprr4aqEy1rGndH3I=;
	b=b3Dwd27ok78xITHFS7MJu3xX8GIkMndctSGXFg99fqaUXkG07sgXcs7MY5dIh7BF4jHX81
	en2ivc251Kd0TZlWr1fqOFphSX/Ydzm/B2w6TtKBRuwHAr4IY+1/z/THwH/7yw0Vp/fmWA
	VJ3xIx3gDt+geeCNPG3Tq/oLCdJ0pjU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dXpA1QTp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766123661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Va0liQrjbR9LbaypDzv+r4o+ZSGprr4aqEy1rGndH3I=;
	b=dXpA1QTpinR+9cPEwHnpGFNWiOeWgRWEggwBeCGbWE4SWRqk2g2xmVhT0abYb6lAocqiH0
	KIAYiMftmqcmsnWNg+VM9xDKE3zV1ZXOafdH7mtueOYxQsYwlcEcvbTx9QflkxmXzOaY1w
	y0/2mPgO+akds4WwjCEsQiYHTiKTK6I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F0BB3EA63
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 05:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZHAyDIzoRGlbXgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 05:54:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: mark qgroup inconsistent if dropping a large subvolume
Date: Fri, 19 Dec 2025 16:23:58 +1030
Message-ID: <9cd4f22eb48de2ebca28146f6db26548a8a207e7.1766123622.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 354E25BD14
X-Spam-Flag: NO
X-Spam-Score: -3.01

Commit 011b46c30476 ("btrfs: skip subtree scan if it's too high to avoid
low stall in btrfs_commit_transaction()") tries to solves the problem of
long transaction hang caused by large qgroup workload triggered by
dropping a large subtree.

But there is another situation where dropping a subvolume without any
snapshot can lead to the same problem.

The only difference is that non-shared subvolume dropping triggers a lot
of leaf rescan in one transaction. In theory btrfs_end_transaction()
should be able to commit a transaction due to various limits, but qgroup
workload is never part of the threshold.

So for now just follow the same drop_subtree_threshold for any subvolume
drop, so that we can avoid long transaction hang.

Unfortunately this means any slightly large subvolume deletion will mark
qgroup inconsistent and needs a rescan.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c | 10 ++++++++++
 fs/btrfs/qgroup.c      | 14 ++++++++++++++
 fs/btrfs/qgroup.h      |  1 +
 3 files changed, 25 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1dcd69fe97ed..59fe3d89e910 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6151,6 +6151,16 @@ int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc
 		}
 	}
 
+	/*
+	 * Not only high subtree can cause long qgroup workload,
+	 * a lot of level 0 drop in a single transaction can also lead
+	 * to a lot of qgroup load and freeze a transaction.
+	 *
+	 * So check the level and if it's too high just mark qgroup
+	 * inconsistent instead of a possible long transaction freeze.
+	 */
+	btrfs_qgroup_check_subvol_drop(fs_info, level);
+
 	wc->restarted = test_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
 	wc->level = level;
 	wc->shared_level = -1;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 14d393a5853d..4dfeed998c54 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4953,3 +4953,17 @@ int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->qgroup_lock);
 	return ret;
 }
+
+void btrfs_qgroup_check_subvol_drop(struct btrfs_fs_info *fs_info, u8 level)
+{
+	u8 drop_subtree_thres;
+
+	if (!btrfs_qgroup_full_accounting(fs_info))
+		return;
+	spin_lock(&fs_info->qgroup_lock);
+	drop_subtree_thres = fs_info->qgroup_drop_subtree_thres;
+	spin_unlock(&fs_info->qgroup_lock);
+
+	if (level >= drop_subtree_thres)
+		qgroup_mark_inconsistent(fs_info, "subvolume level reached threshold");
+}
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index a979fd59a4da..785ed16f5cc4 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -453,5 +453,6 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
 bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info);
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			      const struct btrfs_squota_delta *delta);
+void btrfs_qgroup_check_subvol_drop(struct btrfs_fs_info *fs_info, u8 level);
 
 #endif
-- 
2.52.0


