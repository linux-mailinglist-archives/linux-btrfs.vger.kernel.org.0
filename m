Return-Path: <linux-btrfs+bounces-15565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D760EB0AC60
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 00:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A88567FA7
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 22:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6684D225A24;
	Fri, 18 Jul 2025 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mbYnzWRR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mbYnzWRR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370EE1799F
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879477; cv=none; b=q0sQYp10rx+Rs648jz8ftisMHiP7Mp/u8Adf/O9xhejviSaGs0YxWhVBpxbKgnl3GuDqmbhVfZ4AZ7k0G84urPRwGQUzcXszIsF4Rw2tjscSWbAwcQDaV9lVcQECPegNNITLmxKhjztOxdKdN8rfhIInD2OaYJQeg1iBuciYB8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879477; c=relaxed/simple;
	bh=Y22XYJXnPCb5HIUveve1/nbDPFVW5ZPdVMYra6EDWZE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JfG+Qdr64gG7xNal2+U6V3rhP9+fxsBvqMTMSO79u7fMY9Mlx0C6/pwPR8Qht5uDpGSBuOxvKDiyidCOfo50tjVxKEJSjv3zriwnPkO4CUrs4JwtzXo1IBaIFHGRG5CPyb/YQB2BVTHGyM1Gmayni/L40WwRY/A6HP1dwKf9dNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mbYnzWRR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mbYnzWRR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FE1C21225
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 22:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752879473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vzZ30Yj0JYwo6Hj3AhIBvPxMWyBv1agXYoHvjIRH9mg=;
	b=mbYnzWRRycwvbXghCvARjRi9N0PV6dFbRr+q/MQHNuSZtEzcmW5DKNMihsNoOa25nyoJ2K
	FFM7U9bpBArzJ4zbTvdXzXBDSObYJwYuNwTLksGsnV8Wq50KA3725JihDkWRf7Y2kA3Smi
	KjsWD9NDFaxCfNyy2dj3V8buksGLUrA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752879473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vzZ30Yj0JYwo6Hj3AhIBvPxMWyBv1agXYoHvjIRH9mg=;
	b=mbYnzWRRycwvbXghCvARjRi9N0PV6dFbRr+q/MQHNuSZtEzcmW5DKNMihsNoOa25nyoJ2K
	FFM7U9bpBArzJ4zbTvdXzXBDSObYJwYuNwTLksGsnV8Wq50KA3725JihDkWRf7Y2kA3Smi
	KjsWD9NDFaxCfNyy2dj3V8buksGLUrA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71E21138D2
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 22:57:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jv0/DHDRemjxLwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 22:57:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove unnecessary xa lock for btrfs_free_dummy_fs_info()
Date: Sat, 19 Jul 2025 08:27:34 +0930
Message-ID: <a7028fb9bc67996dd7c1c547e66ffbbea8485183.1752879168.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80

xa_for_each() is utilizing xa_for_each_range(), which in turns calls
xa_find() and xa_find_after(), both are already taking RCU lock
internally.

Although RCU lock is not enough if there is a concurrent entry adding,
but for btrfs_free_dummy_fs_info() there won't be any concurrent entry
adding at all, thus we are safe to remove the xa lock.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tests/btrfs-tests.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index b576897d71cc..e4cd3970e893 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -169,13 +169,8 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 
 	test_mnt->mnt_sb->s_fs_info = NULL;
 
-	xa_lock_irq(&fs_info->buffer_tree);
-	xa_for_each(&fs_info->buffer_tree, index, eb) {
-		xa_unlock_irq(&fs_info->buffer_tree);
+	xa_for_each(&fs_info->buffer_tree, index, eb)
 		free_extent_buffer(eb);
-		xa_lock_irq(&fs_info->buffer_tree);
-	}
-	xa_unlock_irq(&fs_info->buffer_tree);
 
 	btrfs_mapping_tree_free(fs_info);
 	list_for_each_entry_safe(dev, tmp, &fs_info->fs_devices->devices,
-- 
2.50.0


