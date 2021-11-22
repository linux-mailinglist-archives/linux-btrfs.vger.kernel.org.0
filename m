Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E476459127
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 16:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbhKVPUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 10:20:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:32894 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhKVPUW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 10:20:22 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 81DB5218F6;
        Mon, 22 Nov 2021 15:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637594235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=a8QmPcS9Qz1DyqrC4bxhKUbzNjRkC3lKY7sUatGz8zw=;
        b=JVgI/N7JEG+bQsDvbBPa6YkzKsUlMoqG+Ki9JYbe8yz5aH4qt/MdTf9KMo23jRmJ3wjcGD
        VF/mQL7c8WsbGjzP0/rQBEQZo9LJo4nK7QXEmG2ouIp8VTEHtbVW1mDja5in/ng76MchgB
        grlGiWe9SjC2egwIgKuZCaa+w5UknCY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C80C13B44;
        Mon, 22 Nov 2021 15:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A/6EDHu0m2GwDQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 22 Nov 2021 15:17:15 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: eliminate if in main loop in tree_search_offset
Date:   Mon, 22 Nov 2021 17:17:13 +0200
Message-Id: <20211122151713.14316-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reshuffle the code inside the first loop of tree_search_offset so that
one if() is eliminated and the becomes more linear.
---
 fs/btrfs/free-space-cache.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 145a07b19359..141fae2692a4 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1595,12 +1595,7 @@ tree_search_offset(struct btrfs_free_space_ctl *ctl,
 	struct btrfs_free_space *entry, *prev = NULL;
 
 	/* find entry that is closest to the 'offset' */
-	while (1) {
-		if (!n) {
-			entry = NULL;
-			break;
-		}
-
+	while (n) {
 		entry = rb_entry(n, struct btrfs_free_space, offset_index);
 		prev = entry;
 
@@ -1610,6 +1605,8 @@ tree_search_offset(struct btrfs_free_space_ctl *ctl,
 			n = n->rb_right;
 		else
 			break;
+
+		entry = NULL;
 	}
 
 	if (bitmap_only) {
-- 
2.17.1

