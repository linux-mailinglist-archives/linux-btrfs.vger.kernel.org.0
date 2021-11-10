Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9D544C062
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 12:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhKJL7Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 06:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJL7O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 06:59:14 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92548C061764;
        Wed, 10 Nov 2021 03:56:26 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f5so2020349pgc.12;
        Wed, 10 Nov 2021 03:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uyyEYH/oz3uvikXK9+2VWo0a9DwlAAoX4gpH3loPWMg=;
        b=ZOtXv5f4l29o3BjVHC7rEzY4mpitkLICEWPBDW0B9z9ecobUWpgOdlimXauAnFG5eM
         lONlPt7NpkmRRr18lIB54QQI3wUCrw+qVYWky7jgICJl1JRnR+myO+iI+2hX1wdg3DZE
         NtlZ6G2FqM+3xNDW13itMA+a/OnX02wdOHFEEEKl8ePW9UjFTasFeVJyfX7gL/oO7J8/
         FPxmchJjDYWpAZnr1DSMiwbKhpZbVW51gCV4u9K4M8xQJ/ytPcNtSQKN971H4yMYxWUK
         4/huqPDrHqh6UZATJyZjOnKvWvGIonbbW5fVWcgVvKNcyixEFT3Mm+DFtDijlVOWVV2K
         JVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uyyEYH/oz3uvikXK9+2VWo0a9DwlAAoX4gpH3loPWMg=;
        b=btRmihHmhJVp97pmLHYKHbOyFlRPT+B3TTefzk81CSrvMw2f+znvJHSvSj3N/zOhen
         BCZ7yPYg1plZCS2yOHOmVK5DxT8uXeaNzjK/Le3uHL+JGualwxB3GSlFXlTcqP96UWtU
         nlqyXb3sKzoqvmNsTs56K2QEYQIbI8CTPDM3TK6g82ewSsQUxbXPzD6sIrXcT22AatdG
         ojA1GkOjnDQtJgF0qP2QdHR7xx7zOYaeYUXsz1cEzha2166Cu74O+GhCK1ViqRtq9mfE
         lprNdGoY5F3GBUJlyaW+XMbVtZ0kYHPggerL2zbo2tAgYYK5urW6AVnZEYnzzn0OKnwA
         xdlA==
X-Gm-Message-State: AOAM530BVX7mIAdC5+EMsZ8Ndv7DRjCW5YhMC4wyICEfHcKjnKxkFhaW
        dTgjyRE5jQPl/so0qsADscc=
X-Google-Smtp-Source: ABdhPJyWQWTJv63x6IClsGsIoQuSMKXwOjz4LVYWtRqKWC5K/QiQsXlTxtthwbfXchHnsJQE5+L/rw==
X-Received: by 2002:a63:2d47:: with SMTP id t68mr11418214pgt.52.1636545386112;
        Wed, 10 Nov 2021 03:56:26 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i185sm13940304pfg.80.2021.11.10.03.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:56:25 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] btrfs: remove unneeded variable
Date:   Wed, 10 Nov 2021 11:56:19 +0000
Message-Id: <20211110115619.150678-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck review:
./fs/btrfs/disk-io.c: 4641: 5-8: Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 fs/btrfs/disk-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1ae30b29f2b5..781c93d59ed6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4638,7 +4638,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
-	int ret = 0;
 
 	delayed_refs = &trans->delayed_refs;
 
@@ -4646,7 +4645,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	if (atomic_read(&delayed_refs->num_entries) == 0) {
 		spin_unlock(&delayed_refs->lock);
 		btrfs_debug(fs_info, "delayed_refs has NO entry");
-		return ret;
+		return 0;
 	}
 
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
@@ -4709,7 +4708,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 
 	spin_unlock(&delayed_refs->lock);
 
-	return ret;
+	return 0;
 }
 
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
-- 
2.25.1

