Return-Path: <linux-btrfs+bounces-16809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 403D4B57070
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 08:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8614189AA66
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704832857C1;
	Mon, 15 Sep 2025 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JePbk6LU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JePbk6LU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969C280A29
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918279; cv=none; b=ZEK6zjPGPEetANUYzApASEADtON5PUi5GYJZOBGCEiRhuUPkpXuv5sty+yQraBPyy3Qs6P5sgGZXuqU854kpWbIYRe1HJ4cTW49N6YlAHp+Ae8BbY3UApxm493IhOPMQumNNNJhETt1ZRr75iI6nDJKatAQP6y5kdhIJEVMJ7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918279; c=relaxed/simple;
	bh=XGmEGwisf6zSgsbBTbOwmoJX8wGQxh/quJkG8Pw/dJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2aIJfCwC5cZzSy9WNv9POskpqoN/rVixA1QBuVL6IiaSMaKQkUaJHvTvglob4bkdzWUT0SZ5/+pDh3ollz1ngbhJnNvy3xdPwIA1NP4XijOKtd0OusTXzyt+yeyDYZGAzpChhZLGN7uJvnp5QiP5Q070caUaO/JM4EYQ6Y6EEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JePbk6LU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JePbk6LU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1653D336FA;
	Mon, 15 Sep 2025 06:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757918275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OACvUci3sEc0qovGOPSRmROT4YmWov/ACa3d1WlxNdI=;
	b=JePbk6LUNj/MH1Fx3zsdFPLYwMo0KLDEruRN8MC953k4LiYRTI+oLK8FuJUnf3IKKslOC2
	lXXh/Krohylcqkk6soptMqmUsn1gqjDFjmn1Iu6fpP8Rmrzhkee+De6Q253B/r7pGSq/sc
	bNOscpdQNjs/FInLvU0wMdLtV0oqPBo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757918275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OACvUci3sEc0qovGOPSRmROT4YmWov/ACa3d1WlxNdI=;
	b=JePbk6LUNj/MH1Fx3zsdFPLYwMo0KLDEruRN8MC953k4LiYRTI+oLK8FuJUnf3IKKslOC2
	lXXh/Krohylcqkk6soptMqmUsn1gqjDFjmn1Iu6fpP8Rmrzhkee+De6Q253B/r7pGSq/sc
	bNOscpdQNjs/FInLvU0wMdLtV0oqPBo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 105131368D;
	Mon, 15 Sep 2025 06:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qz/0A0O0x2gNQgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 15 Sep 2025 06:37:55 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: ref-verify: handle damaged extent root tree
Date: Mon, 15 Sep 2025 08:37:47 +0200
Message-ID: <20250915063747.39796-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[9c3e0cdfbfe351b0bc0e];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Syzbot hits a problem with enabled ref-verify, ignorebadroots and a
fuzzed/damaged extent tree. There's no fallback option like in other
places that can deal with it so disable the whole ref-verify as it is
just a debugging feature.

Reported-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ref-verify.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 3871c3a6c743b5..9f1858b42c0e21 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -980,11 +980,18 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 	if (!btrfs_test_opt(fs_info, REF_VERIFY))
 		return 0;
 
+	extent_root = btrfs_extent_root(fs_info, 0);
+	/* If the extent tree is damaged we cannot ignore it (IGNOREBADROOTS). */
+	if (IS_ERR(extent_root)) {
+		btrfs_warn(fs_info, "ref-verify: extent tree not available, disabling");
+		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
+		return 0;
+	}
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	extent_root = btrfs_extent_root(fs_info, 0);
 	eb = btrfs_read_lock_root_node(extent_root);
 	level = btrfs_header_level(eb);
 	path->nodes[level] = eb;
-- 
2.51.0


