Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0132B2DC429
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgLPQ2X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgLPQ2W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:22 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDE9C0611C5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:14 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id z20so17597954qtq.3
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UP22N1wW4BouddiNGmO6P25lyeEkJRg0GBlKgir49N8=;
        b=G3dx9LVFAG3YfG1c08cw07KodN+3pH3sOFE0w5beBS1yCG3mckSey8eL5nlIS2nDQ2
         fK6QdKgR1QxR5Migs1kOlH8xVregs4bEDaxYW/S1Ye11yGjVe1cwFg4UiiOdMh91yVNf
         TDh4xWMJa0AMQR1FISuLnX59rZTAfKj4jsFRkFOskblsSVztiJPFy2+8cR7IGu3FDFr1
         5QPt9ujcYEJ8HKOX7Yg7WXiqnaHal0JhCsntufR9d+jVA8U4leW8ESOfupFZmxtOMSi/
         UIFGayHuZd9LT7voedBGtB92ZWLDkg08JXC5r0lln1oD9JR8FfWIVzc/kA4vLW/M1RFn
         6WkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UP22N1wW4BouddiNGmO6P25lyeEkJRg0GBlKgir49N8=;
        b=drRi/9J+4DXadnn5kIYMH5p5RiEu/ASUGbMGFEvQ1d5dg1Y7xJRW9R1Y0p+HX8H1Qx
         12SN2YL1CYr8z0LBbRNdr+WtFtLQ2osbkS1GFVY+ujBiiwm5SeDX2KJIhPjdVtPBoibM
         5+ZVHtwpCw4SK1NaLWd587l8Rp2MiaUdrIMJq2hXCBU4rhDeqmt+uBQUlhI+gnqtPXa/
         U5PNyLXq13l8jYn+q4D9WfFeNE4YtFiM5Qh4b4wiB/htEd7etoFd74uiF2Jh6p97cjED
         zd39fNTu7T4GNHfRwYmnMDXAB3VH3Ea9rPRa7hlZzy5V+5CjbzEgSqUiseHzlyHkauo3
         oUyw==
X-Gm-Message-State: AOAM531J3FTYIH1FzbOoedP42fOi/tdRLL1g4GOuuoDWlezjlGUxmnbj
        sMPhtCuUc/D2Ue8rkjMH9XnkvV/8eO8UYykM
X-Google-Smtp-Source: ABdhPJwgxm2x5L8rUbUr58LUUqqGk/6etlx+qBAXMdAG1Xure58B1hT+UhtKAeV0NAAgUKxa++0ujw==
X-Received: by 2002:a05:622a:14e:: with SMTP id v14mr43867447qtw.298.1608136033816;
        Wed, 16 Dec 2020 08:27:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a206sm1360542qkc.30.2020.12.16.08.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 10/38] btrfs: handle btrfs_record_root_in_trans failure in btrfs_recover_log_trees
Date:   Wed, 16 Dec 2020 11:26:26 -0500
Message-Id: <bdc0ed539ef819a38d53dc2c8ea278231bbf4656.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
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

