Return-Path: <linux-btrfs+bounces-12079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B533A55F5D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 05:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67711713A9
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 04:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B97190696;
	Fri,  7 Mar 2025 04:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gf2B4npR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gf2B4npR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A918FC83
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741321634; cv=none; b=Ujr89En4lRY63j+DmK/vETBSeqQL/b7Y2uPzdxQxfKkNWhjv1iuZjEQU6C0RQBcnPVD+Xo5MNDYdFdf5jPTMSFl27ygMduaNXcYMRO338bcdvo4565EjZP+Xo0wdozzvKiUFgYBueFc/PbijXmEhxcDPAXE6PNJNEPeKdSeWbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741321634; c=relaxed/simple;
	bh=BKggAZU+/iIzf6e4BvSFgBUShvACcq5O7xy9xRG6LKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpgT9rEAeo+BJOQuYlnyWa8Wh/OaQt7qOYP8S2M9470xlSa6Iz8DsOI3Z7YIQVY3I4GcVGZ3Q+udThuDjp55S75cBKsvywyeuWFxUKFnoCZP6XbAIklxACOiQKbgSHT9SImWneWhozLECYvEjSZo9RBpkWqJo+k72dfp6OzGtSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gf2B4npR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gf2B4npR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFD3F211BF;
	Fri,  7 Mar 2025 04:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741321619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=an5WHL5stly8AJxQIHTJQxJLvNJ239uuxzVZsuDwd/4=;
	b=Gf2B4npRhAvUP2HfXCj1ZzC6iJBPG6ByLYM34aqmBM/DpmqKkH122fMiogInOsrR6jBDy3
	t94zNKtvwOoVz9X0PjA9ML99rZmlMLqxwPY0/zqenXPQE0NA8gLcj2W7wO9iCFv630Pq9L
	lqQLr2dVk5R3Utd8Wbp0Aw7twC2UZ44=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Gf2B4npR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741321619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=an5WHL5stly8AJxQIHTJQxJLvNJ239uuxzVZsuDwd/4=;
	b=Gf2B4npRhAvUP2HfXCj1ZzC6iJBPG6ByLYM34aqmBM/DpmqKkH122fMiogInOsrR6jBDy3
	t94zNKtvwOoVz9X0PjA9ML99rZmlMLqxwPY0/zqenXPQE0NA8gLcj2W7wO9iCFv630Pq9L
	lqQLr2dVk5R3Utd8Wbp0Aw7twC2UZ44=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5DB213939;
	Fri,  7 Mar 2025 04:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OPj/JJJ1ymeZcAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 07 Mar 2025 04:26:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org
Subject: [PATCH 2/2] btrfs: add extra warning if delayed iput is added when it's not allowed
Date: Fri,  7 Mar 2025 14:56:37 +1030
Message-ID: <b74cc16979970a14aae45eba0c8ac792389ed473.1741321288.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741321288.git.wqu@suse.com>
References: <cover.1741321288.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DFD3F211BF
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Since I have triggered the ASSERT() on the delayed iput too many times,
now is the time to add some extra debug warnings for delayed iput.

After all btrfs_commit_super() calls, we should no longer allow any new
delayed iput being added.

So introduce a new BTRFS_FS_STATE_NO_DELAYED_IPUT for debug builds, set
after above mentioned timing.
And all btrfs_add_delayed_iput() will check that flag and give a
WARN_ON_ONCE().

I really hope this warning will never be triggered.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 3 +++
 fs/btrfs/fs.h      | 4 ++++
 fs/btrfs/inode.c   | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 320136a59db2..bb20c015b779 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4417,6 +4417,9 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 		if (ret)
 			btrfs_err(fs_info, "commit super ret %d", ret);
 	}
+#ifdef CONFIG_BTRFS_DEBUG
+	set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
+#endif
 
 	kthread_stop(fs_info->transaction_kthread);
 	kthread_stop(fs_info->cleaner_kthread);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index b8c2e59ffc43..ee298dd0f568 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -117,6 +117,10 @@ enum {
 	/* Indicates there was an error cleaning up a log tree. */
 	BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
 
+#ifdef CONFIG_BTRFS_DEBUG
+	/* No more delayed iput can be queued. */
+	BTRFS_FS_STATE_NO_DELAYED_IPUT,
+#endif
 	BTRFS_FS_STATE_COUNT
 };
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8ac4858b70e7..d2bf81c08f13 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3435,6 +3435,10 @@ void btrfs_add_delayed_iput(struct btrfs_inode *inode)
 	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
 		return;
 
+#ifdef CONFIG_BTRFS_DEBUG
+	WARN_ON_ONCE(test_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state));
+#endif
+
 	atomic_inc(&fs_info->nr_delayed_iputs);
 	/*
 	 * Need to be irq safe here because we can be called from either an irq
-- 
2.48.1


