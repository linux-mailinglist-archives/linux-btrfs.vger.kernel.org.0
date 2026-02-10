Return-Path: <linux-btrfs+bounces-21574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GkCDRKlimmhMgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21574-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 04:25:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6A9116BBA
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 04:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73F47301C6E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 03:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEA72FBE1F;
	Tue, 10 Feb 2026 03:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RlN+3Gkr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RlN+3Gkr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4687285073
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770693901; cv=none; b=kA3h8yyzkgHD7XfwpdutsvQNXKwOcL6jzU1ZV9eIxursO1XmZBXW22ENgykYai99mPHtTumemw6mbO0gDmujm0rRMnEuAs3QB7oU2N/kwtvRiG+vjGaoFpNq1x2KsI/Xvl16ae/naVQTNiMre4v578CpLG0/EhZlJOO+EURzco4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770693901; c=relaxed/simple;
	bh=cKpPM1Cyr1V/P7gY19n3LaHXiOO32GSZZJwdwu5lB8o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzuHSW/dAnjhKUvtaLq9Yz69/KQzOOiKfO9H6RkuxK4Q5aoAMQ7ZdPeIXMPZybB2IanJ92gUvE3BLzH1rI+sYgucZdNdxO2OVSx/8ijbcA3RthgtN6XZ1zV8TnC/gTSW1NMViycAJcZCV8F6H+u9TRCTWUGDh6NQc2Wp/cDVAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RlN+3Gkr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RlN+3Gkr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 673AE5BD37
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770693894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SooYLxBZ7Cpj451On6lkmVeaC4/BNp+fBiCEm2wO4JA=;
	b=RlN+3Gkr5l/LS0H0MfVxMKLQyORj0mKM9UgjfVMePoSDjcmT2ExI37Keljd2ntB5H3WaK6
	MO1biPxc8PIm5dOmGtP6qqX/Ye7C1wsNwb+aJ6MpW8wBvsCJbP+TjV6fCxRiwu2EIKKm4k
	CbO9y/7HPjYw2lEMteCyN68sHaNpQwI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770693894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SooYLxBZ7Cpj451On6lkmVeaC4/BNp+fBiCEm2wO4JA=;
	b=RlN+3Gkr5l/LS0H0MfVxMKLQyORj0mKM9UgjfVMePoSDjcmT2ExI37Keljd2ntB5H3WaK6
	MO1biPxc8PIm5dOmGtP6qqX/Ye7C1wsNwb+aJ6MpW8wBvsCJbP+TjV6fCxRiwu2EIKKm4k
	CbO9y/7HPjYw2lEMteCyN68sHaNpQwI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58BE63EA62
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ADHXAQWlimkrEgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: make add_pending_csums() to take an ordered extent as parameter
Date: Tue, 10 Feb 2026 13:54:30 +1030
Message-ID: <8a725fe6a4cd056e4922d96970c1b5a977ac7577.1770693583.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770693583.git.wqu@suse.com>
References: <cover.1770693583.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21574-lists,linux-btrfs=lfdr.de];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EA6A9116BBA
X-Rspamd-Action: no action

The structure btrfs_ordered_extent has a lot of list heads for different
purposes, passing a random list_head pointer is never a good idea as if
the wrong list is passed in, the type casting along with the fs will be
screwed up.

Instead pass the btrfs_ordered_extent pointer, and grab the csum_list
inside add_pending_csums() to make it a little safer.

Since we're here, also update the comments to follow the current style.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 73c193a38b80..6c7fe7c87bc3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2739,17 +2739,19 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 }
 
 /*
- * given a list of ordered sums record them in the inode.  This happens
- * at IO completion time based on sums calculated at bio submission time.
+ * Given an ordered extent and insert all its checksums into the csum tree.
+ *
+ * This happens at IO completion time based on sums calculated at bio
+ * submission time.
  */
 static int add_pending_csums(struct btrfs_trans_handle *trans,
-			     struct list_head *list)
+			     struct btrfs_ordered_extent *oe)
 {
 	struct btrfs_ordered_sum *sum;
 	struct btrfs_root *csum_root = NULL;
 	int ret;
 
-	list_for_each_entry(sum, list, list) {
+	list_for_each_entry(sum, &oe->csum_list, list) {
 		trans->adding_csums = true;
 		if (!csum_root)
 			csum_root = btrfs_csum_root(trans->fs_info,
@@ -3308,7 +3310,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	ret = add_pending_csums(trans, &ordered_extent->csum_list);
+	ret = add_pending_csums(trans, ordered_extent);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
-- 
2.52.0


