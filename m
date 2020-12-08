Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18E2D2F90
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbgLHQ0J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbgLHQ0J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:09 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBDCC061793
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:47 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id j13so1078443qvi.8
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UP22N1wW4BouddiNGmO6P25lyeEkJRg0GBlKgir49N8=;
        b=oU73JLOoGsob5K1k3oBA67JNS+g+hU81cYLXZIW1JhVNr15fe51FuQymamEVN4mDEz
         thZiNMncfjR90/XXfp3SmibBpigIDMSkJTw64SUAT+s+JY09hUAB3b/rAxIJrudvTJWg
         OWedrp5gbVvfS7cXeG9eJt+EIPLW/0LXE/OFOw26fD1715tBooK04RhtUPLFMHiwyVHQ
         C0HMZJsJ7YIJ5AqQ9VYC9liA++fBIVyvXvJlP7uwHgbN5simMboeqTJ9SFm4Ip4A2VuC
         btJ+Ktb8AKv8mYJiWj3VMODtsmAUGsM0lDeYST4WnZugjdj3+gLnL5QsqISXCbKXVmyc
         TD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UP22N1wW4BouddiNGmO6P25lyeEkJRg0GBlKgir49N8=;
        b=ozTRd2xInQ8+bqFNcGRlKN9eo78mbgFGH+UWOxv0sW7y4tS1W/jZYOiWwpr9CdBhu4
         43+9x9Zpyxtpnt2qQJFBaXx5bO+JWPGg418zUxU6ihjogZ3dYsvx34SSa+j422kJe6Nx
         h1gHO43Sy906mQz6K9kFtQyZ45iR2a05vhnPMskFbr+UMsPTJizokNNdj4yUvD7lQUYA
         nGq5lIvH82LOcygU+pPnQnO9aNvCXTD9HOwpNO+f32S0KgmKXtUuipRMecq7CqisrFDm
         tLQYg/J+KCwDuhNgampqwXjLl1pISLB1FkKnFuzqrWdgaFaJN+qUj3bnVLcHQQI1eghY
         kcWw==
X-Gm-Message-State: AOAM530NYxC/XZZ1EtcvKNzC8U2LS6IgF7/T9Lhmdg2zZwh8B6SpPkWI
        z12CsoXfG0F4vCbp9yXsL0RNg/kIj10FWnlT
X-Google-Smtp-Source: ABdhPJxiv2jUuG03kvlDGBbT2SXew9879uIQsjG7ejJwAj9JPbD6QdKGl6SIk9SP+BaCoEhCxqLvmQ==
X-Received: by 2002:a0c:b629:: with SMTP id f41mr11115153qve.58.1607444686570;
        Tue, 08 Dec 2020 08:24:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o13sm13585964qkm.78.2020.12.08.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 20/52] btrfs: handle btrfs_record_root_in_trans failure in btrfs_recover_log_trees
Date:   Tue,  8 Dec 2020 11:23:27 -0500
Message-Id: <3ec7f04c56621f60973bfd9293729b5748f003ea.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_recover_log_trees.

This appears tricky, however we have a reference count on the
destination root, so if this fails we need to continue on in the loop to
make sure the properly cleanup is done.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 254c2ee43aae..77adeb3c988d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6286,8 +6286,12 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		wc.replay_dest->log_root = log;
-		btrfs_record_root_in_trans(trans, wc.replay_dest);
-		ret = walk_log_tree(trans, log, &wc);
+		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
+		if (ret)
+			btrfs_handle_fs_error(fs_info, ret,
+				"Couldn't record the root in the transaction.");
+		else
+			ret = walk_log_tree(trans, log, &wc);
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
 			ret = fixup_inode_link_counts(trans, wc.replay_dest,
-- 
2.26.2

