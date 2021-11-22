Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F97459125
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 16:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbhKVPTz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 10:19:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:32888 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhKVPTz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 10:19:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F62321910;
        Mon, 22 Nov 2021 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637594208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=wZe9NZtlJwa/cTjFGUOuWsbIv+YKhM9iOoqO0lvEYGs=;
        b=d93HIJifTfYyBoKMWLbFyswmkxLsUMcLYjAG2X6bn89tsiDl2igpqxhbuF04Sylltf/6D6
        FN3Ep0hy/DYKXCQO9HyaXvIYJfIRAxz4KjmjqzTGgwn+pL3Lq3td5a8357DafSPlpsv1NP
        l5Dm4eda2LckdWyzLt22y8cS+lMcKpI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCD5E13B44;
        Mon, 22 Nov 2021 15:16:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rR64L1+0m2F8DQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 22 Nov 2021 15:16:47 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: get next entry in tree_search_offset before doing checks
Date:   Mon, 22 Nov 2021 17:16:46 +0200
Message-Id: <20211122151646.14235-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a small optimisation since the currenty 'entry' is already
checked in the if () {} else if {} construct above the loop. In essence
the first iteration of the final while loop is redundant. To eliminate
this extra check simply get the next entry at the beginning of the loop.
---
 fs/btrfs/free-space-cache.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f3fee88c8ee0..145a07b19359 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1686,6 +1686,10 @@ tree_search_offset(struct btrfs_free_space_ctl *ctl,
 		return NULL;
 
 	while (1) {
+		n = rb_next(&entry->offset_index);
+		if (!n)
+			return NULL;
+		entry = rb_entry(n, struct btrfs_free_space, offset_index);
 		if (entry->bitmap) {
 			if (entry->offset + BITS_PER_BITMAP *
 			    ctl->unit > offset)
@@ -1694,11 +1698,6 @@ tree_search_offset(struct btrfs_free_space_ctl *ctl,
 			if (entry->offset + entry->bytes > offset)
 				break;
 		}
-
-		n = rb_next(&entry->offset_index);
-		if (!n)
-			return NULL;
-		entry = rb_entry(n, struct btrfs_free_space, offset_index);
 	}
 	return entry;
 }
-- 
2.17.1

