Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716813C71A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 15:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhGMOBb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 10:01:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58690 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbhGMOBa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 10:01:30 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 105BD21F89;
        Tue, 13 Jul 2021 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626184720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=46GYXKGqf3qQse/qN4EeTGBb0waYanoSpHgMJRE/gwM=;
        b=dNaJLpXnNaLFQGnDad7Z81i/XDDFoVgKbVUa88q7bR4r+5eT0xPm4x5DB2PzFY9cULw5Mf
        h6L+Iznm10ygl0ZU9n0NoDBJSF9/9d5s0qJD5glAuIMO6TQ9rmuZ0AEkB9W5MLi4ZVojIe
        HfQ3fMhtzBkupE/gusl0NV+MfYtI4ZM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id ED2FC13A45;
        Tue, 13 Jul 2021 13:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OPE1LQ6c7WDzdQAAGKfGzw
        (envelope-from <mpdesouza@suse.com>); Tue, 13 Jul 2021 13:58:38 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: Use next_leaf instead of next_item when slots > nritems
Date:   Tue, 13 Jul 2021 10:58:03 -0300
Message-Id: <20210713135803.4469-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After calling btrfs_search_slot is a common pratice to check if the
slot found isn't bigger than number of slots in the current leaf, and if
so, search for the same key in the next leaf by calling btrfs_next_leaf,
which calls btrfs_next_old_leaf to do the job.

Calling btrfs_next_item in the same situation would end up in the same
code flow, since

* btrfs_next_item
  * btrfs_next_old_item
    * if slot >= nritems(curr_leaf)
      btrfs_next_old_leaf

Change btrfs_verify_dev_extents and calculate_emulated_zone_size
functions to use btrfs_next_leaf in the same situation.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Please let me know if I'm missing something obvious here, but all other places
 who check for slot >= nritems are calling next_leaf...

 I found this code while checking all btrfs_search_slot users.

 fs/btrfs/volumes.c | 2 +-
 fs/btrfs/zoned.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6c14315b1c9..d57ad0c9bb99 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8143,7 +8143,7 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 		goto out;
 
 	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
-		ret = btrfs_next_item(root, path);
+		ret = btrfs_next_leaf(root, path);
 		if (ret < 0)
 			goto out;
 		/* No dev extents at all? Not good */
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 6cefdaf89461..882f5946e262 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -245,7 +245,7 @@ static int calculate_emulated_zone_size(struct btrfs_fs_info *fs_info)
 		goto out;
 
 	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
-		ret = btrfs_next_item(root, path);
+		ret = btrfs_next_leaf(root, path);
 		if (ret < 0)
 			goto out;
 		/* No dev extents at all? Not good */
-- 
2.26.2

