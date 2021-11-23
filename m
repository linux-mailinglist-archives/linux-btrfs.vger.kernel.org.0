Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E8459CB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 08:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhKWH0w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 02:26:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38876 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbhKWH0w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 02:26:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2615C218EF;
        Tue, 23 Nov 2021 07:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637652224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=Iz8wisvqHFH+ynR2imkEWeX6LI7585XdBjumCDEPp50=;
        b=B530F5vZCoHcVyBbIWRG+WMywLPELscRxUijv/IYwoC1aUi+kccpPAA9c3f8/9+ug+qNil
        fXhoI49HVpHrKafNJmrQiEJxH6cBMg35OjfopF3wTvoiQ8qkE/WuYWzPoECvd8PXwfwCB1
        WPmmfl7lrdtYc2ElpunCYyXUsdS1jzo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECFFD13B58;
        Tue, 23 Nov 2021 07:23:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eexiN/+WnGEgXwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 23 Nov 2021 07:23:43 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: eliminate if in main loop in tree_search_offset
Date:   Tue, 23 Nov 2021 09:23:42 +0200
Message-Id: <20211123072342.21371-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reshuffle the code inside the first loop of tree_search_offset so that
one if() is eliminated and the becomes more linear.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
V2: 
 * Set entry to NULL by default so that semantics is unchanged. 

 fs/btrfs/free-space-cache.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 145a07b19359..c5ee980e7a5e 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1592,15 +1592,10 @@ tree_search_offset(struct btrfs_free_space_ctl *ctl,
 		   u64 offset, int bitmap_only, int fuzzy)
 {
 	struct rb_node *n = ctl->free_space_offset.rb_node;
-	struct btrfs_free_space *entry, *prev = NULL;
+	struct btrfs_free_space *entry = NULL, *prev = NULL;
 
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

