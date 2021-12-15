Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8944762ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhLOUPI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbhLOUPH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:07 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84299C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:07 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 193so21218455qkh.10
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jzl3+h6hOIbTUwR8WRX35Y23D8rQGapS7vo5cciR0xs=;
        b=qQGvqHhSgYNV5nw25/1KpKKH0JERG/0MeyJIv1jXsSYEjFREwgnirSpVS6lz2dn3PY
         QRb+8rbNoHLKVb9smEM3n3TAeDABK0O+GVXGGkOqOTODuyKsVE+mkCykrbWrynB3491J
         C3xSGcv8DQeZMBQtspgF9hMEyDT7u9cRnGqhJKwm4pGwDHh306lkHYfHmYaJqihTna3E
         6UefYs02E/fPbqwClVbk8KkQ+syt14mIr7Zk1m3N4COY+zf+B1NG7ZQFMDFBSAVYBwWU
         0g4bC1OPpg/q9YIqwWtwG69nYwLG04AvY1sYN6+6JuujfbD3AJCq9a0GFhPbvTCLAM/d
         cqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzl3+h6hOIbTUwR8WRX35Y23D8rQGapS7vo5cciR0xs=;
        b=CGXnexlYbUratXLG1u7E3m5V0DtTuqeFpxzPuxuH+wGMbRJ/zfM9qSXe4R63OqJTf/
         tjh7lXelrGkyVKGHpdoa2pzd/042XDyCiq5liP+vM/MaggI8u7uSyodZIWPqwWaYOMqW
         q6PSH1Dpuo+QGKTWa+/8/SoY3fr0s67n6rcNsOOHQBBc688JFXP/WzYLKiq0zd4jPWRz
         zerIm0WsrRqHmVqIp7XppXLQcc2qNube16emm2xfkKZrK9Hn5rmMJEQL28khQ5czuxMp
         MmsXX+Vim3iziN6ha1stll9HQdU669uwlYhE9umW9lm7hfpS7y1QFBcBBDlI/nOpKsQf
         MCqA==
X-Gm-Message-State: AOAM532Fv8FF8L1XLwyzT3W8yNuxpDu1JtniNhfQ04qo7rWckfjH0w9L
        x7wzqwAg271lWcIt3KNW6nfOO1KCG7vOWA==
X-Google-Smtp-Source: ABdhPJyxfrx+G1hBwhFFz3OkKwRhFnzr3yLqFQ9s59yt/O74WgzBQAKWL5AS7N3WjIe8KCFxbVxGTA==
X-Received: by 2002:a05:620a:4446:: with SMTP id w6mr10184069qkp.631.1639599306449;
        Wed, 15 Dec 2021 12:15:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x15sm1612923qko.82.2021.12.15.12.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:15:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/15] btrfs-progs: do not remove metadata backrefs for extent tree v2
Date:   Wed, 15 Dec 2021 15:14:46 -0500
Message-Id: <73c54153be7f526c27839a9f09b07e6d75f5d0c1.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do not have backrefs for metadata in extent tree v2, skip this work
in __free_extent() and simply do the update of the accounting and free
space tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 7beff7ee..0c0d7bb9 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1961,11 +1961,16 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 						owner_offset, refs_to_drop);
 
 	}
+
+	is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
+
+	if (btrfs_fs_incompat(trans->fs_info, EXTENT_TREE_V2) && !is_data)
+		return do_free_extent_accounting(trans, bytenr, num_bytes, false);
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
 	if (is_data)
 		skinny_metadata = 0;
 	BUG_ON(!is_data && refs_to_drop != 1);
-- 
2.26.3

