Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C0E3EA069
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 10:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhHLIQp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 04:16:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53450 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbhHLIQo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 04:16:44 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EEF561FF1E;
        Thu, 12 Aug 2021 08:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628756178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=/v/s/hA9da4EEmjFRuR9t6tPzSfv7xViYFPy46UpeQE=;
        b=pWMFd0XURJLhwu3ytnPBZ99GAI0AxQXNhXEvCxVuTQIOYTcTVdJRZPQOxwrZ342/X5rvSX
        FAyOHZJESJKV+aXGlpPO4oLEymROKSe1ImYb7nsVIVc0yqI+M41mt63va73sjq+ksPHWmz
        nKEyG+vA95xLwO/JJ9C+So7HM8oOtHg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C18AA13846;
        Thu, 12 Aug 2021 08:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id HXPdLNLYFGGXCAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 12 Aug 2021 08:16:18 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: Improve error handling while loading log root
Date:   Thu, 12 Aug 2021 11:16:17 +0300
Message-Id: <20210812081617.20811-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

read_tree_block can return an error due to a variety of reason,
currently its return value is not being checked when loading the
log root's node but is directly used in a call to
extent_buffer_uptodate. This can lead to a crash if read_tree_block
errored out, since the node won't be a pointer but an error value cast
to a pointer.

Fix this by properly checking the return value of read_tree_block before
utilising the value for anything else.
---
 kernel-shared/disk-io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index cc635152c46d..4b5436254671 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -629,15 +629,14 @@ static int find_and_setup_log_root(struct btrfs_root *tree_root,
 
 	log_root->node = read_tree_block(fs_info, blocknr,
 				     btrfs_super_generation(disk_super) + 1);
-
-	fs_info->log_root_tree = log_root;
-
-	if (!extent_buffer_uptodate(log_root->node)) {
-		free_extent_buffer(log_root->node);
+	if (IS_ERR(log_root->node) || !extent_buffer_uptodate(log_root->node)) {
+		if (!IS_ERR(log_root->node))
+			free_extent_buffer(log_root->node);
 		free(log_root);
 		fs_info->log_root_tree = NULL;
 		return -EIO;
 	}
+	fs_info->log_root_tree = log_root;
 
 	return 0;
 }
-- 
2.17.1

