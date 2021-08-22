Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058F33F3E3B
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Aug 2021 09:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhHVHCx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Aug 2021 03:02:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44182 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhHVHCt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Aug 2021 03:02:49 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E8DA21E5A
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 07:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629615728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4q/8JHdE9sSopcd9a8r0G+RKGptipRPa+vhG6x+Zvv0=;
        b=AUxmOmqPgDBWr1jCmBDeFHlTx1UBXJq/RhqNhDpR5Px8jg6PO7EwiD+XFnnT06KhdByoM7
        LavNfQ3ZQydxBNiwxc/GrPqkLwBRx50+PCo4ha3kSGpPuIv2jyY0XYePmJfWfLEMs0867s
        zrU7iJdgQx2+4GM8Z9/UDdn/aIntf5E=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DBA4B13C43
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 07:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id eEoqJ2/2IWHLBwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 07:02:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 4/4] btrfs: skip subtree scan if it's too high to avoid low stall in btrfs_commit_transaction()
Date:   Sun, 22 Aug 2021 15:02:00 +0800
Message-Id: <20210822070200.36953-5-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210822070200.36953-1-wqu@suse.com>
References: <20210822070200.36953-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs qgroup has a long history of bringing performance penalty in
btrfs_commit_transaction().

Although we tried our best to migrate such impact, there is still a
unsolved call site, btrfs_drop_snapshot().

This function will find the highest shared tree block and modify its
extent ownership to do a subvolume/snapshot dropping.

Such change will affect the whole subtree, and cause tons of qgroup
dirty extents and stall btrfs_commit_transaction().

To avoid such problem, we can simply skip such subtree accounting if
it's too high.
Of course, the cost is to mark qgroup inconsistent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 291c404e8718..c650258f5cec 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2248,6 +2248,19 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
 		return 0;
 
+	/*
+	 * This function only get called for snapshot drop, if we hit a high
+	 * node here, it means we are going to change ownership for quite a lot
+	 * of extents, which will greatly slow down btrfs_commit_transaction().
+	 *
+	 * So here if we find a high tree here, we just skip the accounting and
+	 * mark qgroup inconsistent.
+	 */
+	if (root_level >= 4) {
+		qgroup_mark_inconsistent(fs_info);
+		return 0;
+	}
+
 	if (!extent_buffer_uptodate(root_eb)) {
 		ret = btrfs_read_buffer(root_eb, root_gen, root_level, NULL);
 		if (ret)
-- 
2.32.0

