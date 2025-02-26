Return-Path: <linux-btrfs+bounces-11846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B15A45A9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96E53AC9EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9732C2459CB;
	Wed, 26 Feb 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AdfRlW8a";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AdfRlW8a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A33238149
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563471; cv=none; b=myCMXUk/NXTrSDm01e8zPkho1fszN7ewEP5XU2vv9+KjBHE6PgaOfQ5Ags2VF0Uv+kCAID9R8pCQk8xrbBXIj51STlsnz0gWTbEywNo2YbGFj6LmueUkNtJiM2/gg8o7aiAeOnBrGJidPlKf8eSkyr9FzC43r0kH5uqJpIK//mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563471; c=relaxed/simple;
	bh=4H6S+L9wVpWIE0OH3uXvozms74LBPMnVlS4fGZx9MvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3EHnfxLr57/Dr54tkJM2W9DlZjA6d7kP36PVYexsssv9nTJQ9rixnjUbeJfMNcU9muwg+LfKd60VkAWfKwsrDF73h3Xg3C9SsSU6Bo2J8O/s1Sy/Zq8WLjKhf9oIHbF8ZngiiEo+E4n/faPscJOpRlL/Pk90u5xFRLzGPgiiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AdfRlW8a; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AdfRlW8a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE51C1F38F;
	Wed, 26 Feb 2025 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txTd8JMa18Krv3+OertgbKWZyYGLkNLck8/1E1LKuhQ=;
	b=AdfRlW8annMtuDpq+kEqXApEn/tS6+GafQ8qxKRyC7CU5FvPu8RJDo6kkCy3bgbO+oM4uf
	WXg0JHiDA8IDsdPcO8Qrf+5M9ptt2vCxX9COmx0tlS8EYXisQWqg9XKo9C23/rFlscyhjv
	RezJ8Dc8njHMxQB1IYQmwmVqXmklDMQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=AdfRlW8a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txTd8JMa18Krv3+OertgbKWZyYGLkNLck8/1E1LKuhQ=;
	b=AdfRlW8annMtuDpq+kEqXApEn/tS6+GafQ8qxKRyC7CU5FvPu8RJDo6kkCy3bgbO+oM4uf
	WXg0JHiDA8IDsdPcO8Qrf+5M9ptt2vCxX9COmx0tlS8EYXisQWqg9XKo9C23/rFlscyhjv
	RezJ8Dc8njHMxQB1IYQmwmVqXmklDMQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACAA713A53;
	Wed, 26 Feb 2025 09:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kaYlKv7jvmcKYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:50:54 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_start_dirty_block_groups()
Date: Wed, 26 Feb 2025 10:50:54 +0100
Message-ID: <fadf1b2806385ebadca0c45b15be13dbe8863aa0.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE51C1F38F
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d99e5ed307d5..95b14e3351b5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3342,7 +3342,7 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 	struct btrfs_transaction *cur_trans = trans->transaction;
 	int ret = 0;
 	int should_put;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	LIST_HEAD(dirty);
 	struct list_head *io = &cur_trans->io_bgs;
 	int loops = 0;
@@ -3497,7 +3497,6 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 		btrfs_cleanup_dirty_bgs(cur_trans, fs_info);
 	}
 
-	btrfs_free_path(path);
 	return ret;
 }
 
-- 
2.47.1


