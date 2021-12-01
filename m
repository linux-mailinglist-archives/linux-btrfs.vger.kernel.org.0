Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BE7464652
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 06:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346663AbhLAFVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 00:21:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37828 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhLAFVh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 00:21:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7B98A1FD58;
        Wed,  1 Dec 2021 05:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638335896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hF+d1OqsGjogNJdDpe0L/7qbT0oBeA/kXRnlOH9HPjc=;
        b=ae7emaCSA8zlyEKAmMKs+k06ZOHfwF2XoTVH8zUBKzGhvOUeTMci2g5GteAgeVOWzz4RE2
        JBjjgkVD3q0th2oUbAj6gROHqoDE/Oa016wo1umRWFlwxnXpzlql1UJ56Hne4osS9pUEPK
        58sx3HBptQ1hYg/ekRkaTLEdnZ02Sb0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 756D313425;
        Wed,  1 Dec 2021 05:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uPFEEZcFp2EGbwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 01 Dec 2021 05:18:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 01/17] btrfs: update an stale comment on btrfs_submit_bio_hook()
Date:   Wed,  1 Dec 2021 13:17:40 +0800
Message-Id: <20211201051756.53742-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201051756.53742-1-wqu@suse.com>
References: <20211201051756.53742-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function is renamed to btrfs_submit_data_bio(), update the comment
and add extra reason why it doesn't completely follow the same rule in
btrfs_submit_data_bio().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 504cf090fc88..6079d30f83e8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8202,7 +8202,13 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 	bool write = btrfs_op(bio) == BTRFS_MAP_WRITE;
 	blk_status_t ret;
 
-	/* Check btrfs_submit_bio_hook() for rules about async submit. */
+	/*
+	 * Check btrfs_submit_data_bio() for rules about async submit.
+	 *
+	 * The only exception is for RAID56, when there are more than one bios
+	 * to submit, async submit seems to make it harder to collect csums
+	 * for the full stripe.
+	 */
 	if (async_submit)
 		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers);
 
-- 
2.34.1

