Return-Path: <linux-btrfs+bounces-10599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C76E19F73B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 05:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C36A7A3D56
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 04:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD5A2165FB;
	Thu, 19 Dec 2024 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uPt9b2eF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uPt9b2eF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524D2163B4
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 04:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734582875; cv=none; b=mBNc3caTqmo8CtklYm1JJcjixPEKrOl1Jmv7EUevEehEgU4EorAishj7igvW5iUjOetmLdmk/8RXZ7QiPqsAuz/q/6QtCQu266R2NeiV8E1c6a+FKgGji2EF76Eq8yQAGA/hjvnu1fI8BbZsCAKVvDf5vac7AgTBmrQE2nfbXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734582875; c=relaxed/simple;
	bh=5yzMvBjb+bIxxU/MzZb8jF+EKc8ONa3hZIvMj+VbN/4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gDKXzgxrqa/VYwxT1xvaYhK/hjyK0dkMAjv9djaC/YtWLaJjJe8ey/U3SZykxg9IOUPqBW2MNGXgkJeS6VTrrZCIDTmVNQ9D4GjyyB2xaF4jnMAPe71Lk8dqZUcLgViWE073T+Y21WRKLcFq1IfEj+51V77YWNKz+O8wycfxXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uPt9b2eF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uPt9b2eF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA9502115A
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 04:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734582870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gKN6juSbk5kcYYY70BL8Vz0i95OEEiBkWY6K6G2S5Dg=;
	b=uPt9b2eFuO+vr/Vk/TwMuqMPmVWq4v4Rd170ITyLWEq24NocyAb990V3obgplCteC/2EVS
	HWaWWuPyLn/fHoKrFVsfN2n0vQy05Zdvl8vaPK8vIKARpuk3qYs7sHCeoV9viasSDDKamd
	2O0QXpj4qQKLPdoYdHeEv2uRc+YGCZs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734582870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gKN6juSbk5kcYYY70BL8Vz0i95OEEiBkWY6K6G2S5Dg=;
	b=uPt9b2eFuO+vr/Vk/TwMuqMPmVWq4v4Rd170ITyLWEq24NocyAb990V3obgplCteC/2EVS
	HWaWWuPyLn/fHoKrFVsfN2n0vQy05Zdvl8vaPK8vIKARpuk3qYs7sHCeoV9viasSDDKamd
	2O0QXpj4qQKLPdoYdHeEv2uRc+YGCZs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2291913A32
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 04:34:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oc1hNVWiY2duBgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 04:34:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: handle free space tree rebuild in multiple transactions
Date: Thu, 19 Dec 2024 15:04:08 +1030
Message-ID: <648c181a4b3d2076ee838945232e3b87b5d575e7.1734582790.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

During free space tree rebuild, we're holding a transaction handler for
the whole rebuild process.

This can lead to blocked task warning, e.g. btrfs-transaction kthread
(which is already created before btrfs_start_pre_rw_mount()) can be
waked up to join and commit the current transaction.

But the free space tree rebuild process may need to go through thousands
block groups, this will block btrfs-transaction kthread for a long time.

Fix the problem by calling btrfs_should_end_transaction() after each
block group, so that we won't hold the transaction handler too long.

And since the free-space-tree rebuild can be split into
multiple transactions, we need to consider the safety when the rebuild
process is interrupted.

Thankfully since we only set the FREE_SPACE_TREE compat_ro flag without
FREE_SPACE_TREE_VALID flag, even if the rebuild is interrupted, on the
next RW mount, we will still go rebuild the free space tree, by deleting
any items we have and re-starting the rebuild from scratch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use btrfs_should_end_transaction() instead of batching
  Which should be more reliable than batching.
---
 fs/btrfs/free-space-tree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 7ba50e133921..2400fa5a5be4 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1350,6 +1350,12 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
 			btrfs_end_transaction(trans);
 			return ret;
 		}
+		if (btrfs_should_end_transaction(trans)) {
+			btrfs_end_transaction(trans);
+			trans = btrfs_start_transaction(free_space_root, 1);
+			if (IS_ERR(trans))
+				return PTR_ERR(trans);
+		}
 		node = rb_next(node);
 	}
 
-- 
2.47.1


