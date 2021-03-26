Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F78134A78C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 13:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCZMvX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 08:51:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:58018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230057AbhCZMvN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 08:51:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616763071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fCK0V/uXpKihNW7AkKnGGIDVRsmwmgMluIkKUTEyLdY=;
        b=FPKnDGpZmTFjelBKfjXk4dFdmn/k7I7qeWvUE7t4gGa2sMBxvKYMr3qJlL5Ps5NmqP1mVX
        OBx3J9EToRkdCBiIRG3fqLtHb0/gCs8ayVI0gdeOZ/MAC7GI56w74FX8wfWbtAmnFj/Eeg
        QoxoIdClygFitZzNw601NslnHDkn9Ck=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 684B0AD8D
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Mar 2021 12:51:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: image: remove the dead stat() call
Date:   Fri, 26 Mar 2021 20:50:45 +0800
Message-Id: <20210326125047.123694-2-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210326125047.123694-1-wqu@suse.com>
References: <20210326125047.123694-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In restore_metadump(), we call stat() but never uses the result get.

This call site is left by some code refactor, as the stat() call is now
moved into fixup_device_size().

So we can safely remove the call.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/image/main.c b/image/main.c
index 48070e52c21f..24393188e5e3 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2690,7 +2690,6 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 	if (!ret && !multi_devices && !old_restore &&
 	    btrfs_super_num_devices(mdrestore.original_super) != 1) {
 		struct btrfs_root *root;
-		struct stat st;
 
 		root = open_ctree_fd(fileno(out), target, 0,
 					  OPEN_CTREE_PARTIAL |
@@ -2703,13 +2702,6 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 		}
 		info = root->fs_info;
 
-		if (stat(target, &st)) {
-			error("stat %s failed: %m", target);
-			close_ctree(info->chunk_root);
-			free(cluster);
-			return 1;
-		}
-
 		ret = fixup_chunks_and_devices(info, &mdrestore, fileno(out));
 		close_ctree(info->chunk_root);
 		if (ret)
-- 
2.30.1

