Return-Path: <linux-btrfs+bounces-14700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FAEADC17D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 07:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE47C3B75FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 05:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51BC23B639;
	Tue, 17 Jun 2025 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jYu7i/iT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ng2d/UhF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC501155C88
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750137610; cv=none; b=pddFSIQYNBCB/I+LhIV7vQqnDI7y9mLabFUf5XPvKdKTTbKS30gO1YC3V2Zv5qBg3i1CB8XLPTB9H/u9xYFUiv6wOyYdJUTQ4AVmjGh7rdgWdNkKKjM+HpZ85VqrlQ8Y+E6tD+FNqvYUIqFrVJMX92mU28mv+rfbUMNCadlPFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750137610; c=relaxed/simple;
	bh=JQLc8xPi9Mea0yh5hnrKq0ulTad7WA5XbAk1sUFLdVw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVYjV1f+3tpRUNkU8UEvVCPGGeuRz7JagptEaPqqtPsw2uqttmNbfiXWDoTMmP3L5RTzm2vMiFe5dpqhABkmSS0V0xpCGAsm/KPExF/NFFJMTY2oYAhuJNDVGUX0uxH+o1Bkf0W+xs5O+1RB8nxDaxUqEs3FNV9RvkfAW+fZLfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jYu7i/iT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ng2d/UhF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E74EF1F388
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750137605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1cPNk5IE4rnIZmn8h8zbkY8Jh6yeTernGsDe1hhiNk=;
	b=jYu7i/iTLIZJBWca58hLFvVwMJBLAnAqWTNtLTHG2td7ML/m6h0BS9bCKkRAqa1MTbDskt
	BUw/98ogMQOGN5USq+N+6ZW7mBtcKaV6ItFJpB6f5frdh2XHsO0Xqf4z9Cv63i1mj1/OWM
	o1hssvq7afA4gsbfsQLbWaUr11jY6yU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750137604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1cPNk5IE4rnIZmn8h8zbkY8Jh6yeTernGsDe1hhiNk=;
	b=ng2d/UhFMg3pI2kjHgcZP17EWP16o+aKRSlImF5Dw4n2Kr1X/Jp/e/+N+erqdHtDaPA+WS
	kxnwZIpRn9YLlAUtSDLrDbrmPXxEPlTsmXwZV1ZKpn97dwCuTPVBdvsB0m64fmmOVVlK5/
	BaChsxhpTxXs/uwwqvaczU0pQLEVF/8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E8F0139E2
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IOBiOAP7UGgePwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/6] btrfs: add comments to make super block creation more clear
Date: Tue, 17 Jun 2025 14:49:35 +0930
Message-ID: <c86ee5c7e8588b9755c66f6827dc5087de2fd910.1750137547.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750137547.git.wqu@suse.com>
References: <cover.1750137547.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

When calling sget_fc(), there are 3 different situations:

a) Critical error
   No super block created.

b) A new super block is created
   The fc->s_fs_info is transferred to the super block, and fc->s_fs_info
   is reset to NULL.

   In this case sb->s_root should still be NULL, and needs to be properly
   initialized later by btrfs_fill_super().

c) An existing super block is returned
   The fc->s_fs_info is untouched, and anything related to that fs_info
   should be properly cleaned up.

This is not obvious even with the extra comments at sget_fc().

Enhance the situation by:

- Add comments for case b) and c)
  Especially for case c), the fs_info and fs_devices cleanup happens at
  different timing, thus needs extra explanation.

- Move the comments closer to case b) and case c)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d977d2da985e..c5c3ad40d07e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1876,15 +1876,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 
 	bdev = fs_devices->latest_dev->bdev;
 
-	/*
-	 * From now on the error handling is not straightforward.
-	 *
-	 * If successful, this will transfer the fs_info into the super block,
-	 * and fc->s_fs_info will be NULL.  However if there's an existing
-	 * super, we'll still have fc->s_fs_info populated.  If we error
-	 * completely out it'll be cleaned up when we drop the fs_context,
-	 * otherwise it's tied to the lifetime of the super_block.
-	 */
 	sb = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
 	if (IS_ERR(sb)) {
 		ret = PTR_ERR(sb);
@@ -1894,6 +1885,20 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	set_device_specific_options(fs_info);
 
 	if (sb->s_root) {
+		/*
+		 * Not the first mount of the fs thus got an existing super block.
+		 *
+		 * Will reuse the returned super block, fs_info and fs_devices.
+		 */
+		ASSERT(fc->s_fs_info == fs_info);
+
+		/*
+		 * fc->s_fs_info is not touched and will be later freed by
+		 * put_fs_context() through btrfs_free_fs_context().
+		 * 
+		 * But we have opened fs_devices at the beginning of the
+		 * function, thus still need to close them manually.
+		 */
 		btrfs_close_devices(fs_devices);
 		/*
 		 * At this stage we may have RO flag mismatch between
@@ -1902,6 +1907,13 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 * needed.
 		 */
 	} else {
+		/*
+		 * The first mount of the fs thus a new superblock, fc->s_fs_info
+		 * should be NULL, and the owner ship of our fs_info and fs_devices is
+		 * transferred to the super block.
+		 */
+		ASSERT(fc->s_fs_info == NULL);
+
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
 		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
-- 
2.49.0


