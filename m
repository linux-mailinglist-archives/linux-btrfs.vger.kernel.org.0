Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8182CDD80
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502035AbgLCSZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502018AbgLCSZM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:12 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F18C09424A
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:39 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y18so2982483qki.11
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UP22N1wW4BouddiNGmO6P25lyeEkJRg0GBlKgir49N8=;
        b=odlvaZc2WWNgLaTvU2kNVTM5TN8roRIPmox3t0yOsCrwgSDgFriDINZJd67eAZ0DjM
         DMs6ZQw/M/V4gAYqJSFsiuxWfBbAvprAfEPCLfw7i9iJmpwsMH7Gs6TvUTCL6Bha1NH8
         jEsPORefw0GHPO3Xf0GNLCXbVPAhJCUaJEY6rpdBw1ooTISAS1hUEYoKBGtPVa6RfSB7
         /qHzsFKRkUS3mBjzr7csK8w5FA6YU6xElcfDWsqGKgJKgx8C6/cZrafTMv9pQ9cUh9Jp
         5SFeOLcHJAZDQYSdY3YMWhq5/7xI7aO3upZhFU9NvC84kR1XqLHFfgeeYZxfn4NPU/Hk
         NI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UP22N1wW4BouddiNGmO6P25lyeEkJRg0GBlKgir49N8=;
        b=srd/i8TJweNpCKIivviXiUZNAbl4UHYl7xahbE4p3Lfwse2Emdi9+Dvzpd+jp0bL3B
         iEPJPwddxFswRisfZky0Q4PfOh+DBfhKWwkUwPKb21V9Og013dj7A2kx2KdBbkdYudkc
         7CLw2FyrmR04Lnep3gq0ls0BIrJWy/ELYNUNEH5Z96NYMAkViEcJ4SkgGYbFlewbTCtT
         /u3L/A7Bbpsden3F7B4IYXO72vDI/bmpIazGIZXC30HyixSf/27AsKJ2GBiq793MkcKJ
         f/xGjhX0IpY1DXzFfqkNgFH1RNzvxVgSvpx8kRknaddYDOmCs8uFDXQEelBQ/tiB1l60
         Cdgw==
X-Gm-Message-State: AOAM531Pk83O5r74++xpEiRncXPTAykkfmHmN1Anausg4yAnaYY6YkoH
        invgu+ZhsVOtb0mz0W0+iW3RiURrCS+p+Mmb
X-Google-Smtp-Source: ABdhPJx7rNj0VVkymn1tEUxwShgIyYO8rMZq2SK85cPxxvwTU+0dQRFZlqC5MIVHoHORQnmCmuNzSw==
X-Received: by 2002:ae9:f507:: with SMTP id o7mr4129152qkg.420.1607019818401;
        Thu, 03 Dec 2020 10:23:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y3sm2237081qkl.110.2020.12.03.10.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 21/53] btrfs: handle btrfs_record_root_in_trans failure in btrfs_recover_log_trees
Date:   Thu,  3 Dec 2020 13:22:27 -0500
Message-Id: <587afabcc7e1faf4c860917eeddfebc2b0bf81e0.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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

