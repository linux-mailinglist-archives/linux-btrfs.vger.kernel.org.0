Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A151A42D327
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 09:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhJNHFS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 03:05:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43256 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJNHFR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 03:05:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B8EB2027F;
        Thu, 14 Oct 2021 07:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634194992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LryAzl6qtxBUwE4XmYj8y1sWDaniT//Tl0WADhtNWLU=;
        b=aoUhvVhRLmMg/rfJGIPoRFYjIhaGp/5WKdLMnesg3dppRR0DLPM4SVwnga3bWEm6q3BPJk
        4mSfYttaXnUOP7rQMqSQF6+LIdFlUWBsueAj9B+px+Zxv9X0ojyZ9obJNE9hsv63coSA6X
        dXZxnNWfS6EyZaSBgBvzLiJlgveqou8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CBC513D3F;
        Thu, 14 Oct 2021 07:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P8TmFzDWZ2HhDgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Oct 2021 07:03:12 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Remove spurious unlock/lock of unused_bgs_lock
Date:   Thu, 14 Oct 2021 10:03:11 +0300
Message-Id: <20211014070311.1595609-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since both unused block groups and reclaim bgs lists are protected by
unused_bgs_lock then free them in the same critical section without
doing an extra unlock/lock pair.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e790ea0798c7..308b8e92c70e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3873,9 +3873,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		list_del_init(&block_group->bg_list);
 		btrfs_put_block_group(block_group);
 	}
-	spin_unlock(&info->unused_bgs_lock);
 
-	spin_lock(&info->unused_bgs_lock);
 	while (!list_empty(&info->reclaim_bgs)) {
 		block_group = list_first_entry(&info->reclaim_bgs,
 					       struct btrfs_block_group,
-- 
2.25.1

