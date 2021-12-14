Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1A74743A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 14:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhLNNjp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 08:39:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53030 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhLNNjo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 08:39:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4AAA31F37C;
        Tue, 14 Dec 2021 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639489183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kCfdNKANQDjdZd9a2+K2InADM55fbbOxcBwjJd0VgK4=;
        b=iWO/DfBzUiYqDZXMHJ/oX7EVfMhLrSbTY4tHpEbeR40KiVfV1ZvnSGpb0aMUMk0Fi0AytC
        KNaLYXgXfwKLzbJ8mEMz2AlLZYH+dbRhaQe9VniZu9v7DFLvggInFAaJd7MRIEHGVVEpJc
        2QdUczNzcjigoUoYpcXcqlwUeOtQXMU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 125BD13C66;
        Tue, 14 Dec 2021 13:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1GJmAZ+euGGALwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 14 Dec 2021 13:39:43 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Refactor unlock_up
Date:   Tue, 14 Dec 2021 15:39:39 +0200
Message-Id: <20211214133939.751395-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The purpose of this function is to unlock all nodes in a btrfs path
which are above 'lowest_unlock' and whose slot used is different than 0.
As such it used slightly awkward structure of 'if' as well as somewhat
cryptic "no_skip" control variable which denotes whether we should
check the current level of skipiability or no.

This patch does the following (cosmetic) refactorings:

* Renames 'no_skip' to 'check_skip' and makes it a boolean. This
variable controls whether we are below the lowest_unlock/skip_level
levels.

* Consolidates the 2 conditions which warrant checking whether the
current level should be skipped under 1 common if (check_skip) branch,
this increase indentation level but is not critical.

* Consolidates the 'skip_level < i && i >= lowest_unlock' and
'i >= lowest_unlock && i > skip_level' condition into a common branch
since those are identical.

* Eliminates the local extent_buffer variable as in this case it doesn't
bring anything to function readability.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 62066c034363..ab2ea0b2863c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1348,33 +1348,34 @@ static noinline void unlock_up(struct btrfs_path *path, int level,
 {
 	int i;
 	int skip_level = level;
-	int no_skips = 0;
-	struct extent_buffer *t;
+	int check_skip = true;
 
 	for (i = level; i < BTRFS_MAX_LEVEL; i++) {
 		if (!path->nodes[i])
 			break;
 		if (!path->locks[i])
 			break;
-		if (!no_skips && path->slots[i] == 0) {
-			skip_level = i + 1;
-			continue;
-		}
-		if (!no_skips && path->keep_locks) {
-			u32 nritems;
-			t = path->nodes[i];
-			nritems = btrfs_header_nritems(t);
-			if (nritems < 1 || path->slots[i] >= nritems - 1) {
+
+		if (check_skip) {
+			if (path->slots[i] == 0) {
 				skip_level = i + 1;
 				continue;
 			}
+
+			if (path->keep_locks) {
+				u32 nritems;
+
+				nritems = btrfs_header_nritems(path->nodes[i]);
+				if (nritems < 1 || path->slots[i] >= nritems - 1) {
+					skip_level = i + 1;
+					continue;
+				}
+			}
 		}
-		if (skip_level < i && i >= lowest_unlock)
-			no_skips = 1;
 
-		t = path->nodes[i];
 		if (i >= lowest_unlock && i > skip_level) {
-			btrfs_tree_unlock_rw(t, path->locks[i]);
+			check_skip = false;
+			btrfs_tree_unlock_rw(path->nodes[i], path->locks[i]);
 			path->locks[i] = 0;
 			if (write_lock_level &&
 			    i > min_write_lock_level &&
-- 
2.25.1

