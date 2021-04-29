Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2351336E79C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhD2JHx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 05:07:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:41356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232734AbhD2JHv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 05:07:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619687224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RoVjMJByJv/KChToVgXY+iQb7XvM269HatuufiwXlY=;
        b=YktXvNBXRHFPPyt03iKe4k1ReQyIfuOYPZN1+T3wfzxFmvV+0r6c01j48HyFGDWRPIkH6i
        BotCdnn4D9KOvTYy6Bhxv1mqpYazm1ZwKJze4sfz2fTW25qJblztdVoP0kyud01T3gMJpL
        k00wZfvifjQdrNrMM4Zkf2EQ8Sfr37s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6BFCAF83;
        Thu, 29 Apr 2021 09:07:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <l@damenly.su>
Subject: [PATCH v2 1/3] btrfs-progs: image: remove the dead stat() call
Date:   Thu, 29 Apr 2021 17:06:56 +0800
Message-Id: <20210429090658.245238-2-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210429090658.245238-1-wqu@suse.com>
References: <20210429090658.245238-1-wqu@suse.com>
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
Reviewed-by: Su Yue <l@damenly.su>
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
2.31.1

