Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68122465530
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352280AbhLASVS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352266AbhLASVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:21:10 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCCEC061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:49 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id m192so32011028qke.2
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wIgFFcG7g9rufAttVebNoLhVAZ0VrSc6lTny3+BHXIU=;
        b=7a4J6B0cKbBzcmLp0c9yHHyT8tya5Gx4hySkowhxRXQdHlJvLyDBcpwtVr7Mz/GT/C
         BoN9Vbt5HFKH+//ESvwGVDIVpI94ni25H8PuftpBxs1CLblAjPasNJBkeXllvCNzWlkz
         FYWijY+TzCBFoxwY1vtaZsZSfaTGsLF+b2SqINcIhT2HFifbAuAgfQQMo904xuotQZ9L
         NmW7zNb4edk8MTWffeK+FebkDZ6QaMBYWVyvbeKg0aSobioNltkeBuUFbvxuuPFJaLrw
         Mao+DlcXWmgoUwCY+D11zbIwcQlQPhaVD9zCjPH14gCd/83ldBftpFGv0YZOM/uUTCHt
         8ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wIgFFcG7g9rufAttVebNoLhVAZ0VrSc6lTny3+BHXIU=;
        b=m2j/YdkEKZTwwbv7jTZOeWNHkP9TQLC7hEkwmvhhXntjhjhB0b0hFd3WytwTtl2e0N
         7WpKRVp/octHwPzoMCGZrT3w2wzO15Z/xnXywPuSKmRX00Rte8bLh298PErTTfGuII/0
         vdwsaMBNpzlqePY0PtZiyqSRFF3urwydEMkHg7gQb8xUxIHL3dKHUC2QUt8bhMcUQdmM
         myGXyOyO46brcKLySHZc6Lg+Vk0aBnTiN0eJt6How5cineVbmHM4kGfnUSn06DSUYl2x
         3O1RyMZhX1yHY4aDY4XAO/9Xob1hd92lStO0llnLHR7b6D3RLCrIXWPK+kb7BhdjxKXv
         Szdw==
X-Gm-Message-State: AOAM530XfM6KxdHlxNc6zfRYCO6pKVLNqWYfoJZWq+HIw+0FjXkEex7g
        7ufqmx4Frl0ekiIK1B4UHjEuAfA+QRqSKQ==
X-Google-Smtp-Source: ABdhPJxpru+qsSfkd/fuQRb8Boxl0xc5RKlGfFvJhFz1+ZPB5TSu+rPOzgznVogs87p6XcqpR70PPQ==
X-Received: by 2002:a37:92c4:: with SMTP id u187mr8023530qkd.721.1638382668263;
        Wed, 01 Dec 2021 10:17:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e17sm291688qtw.18.2021.12.01.10.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 22/22] btrfs-progs: check: don't do the root item check for extent tree v2
Date:   Wed,  1 Dec 2021 13:17:16 -0500
Message-Id: <cecfbc39beee3ac60d08c1512a4fda5e754caf24.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the current set of changes we could probably do this check, but it
would involve changing the code quite a bit, and in the future we're not
going to track the metadata in the extent tree at all.  Since this check
was for a very old kernel just skip it for extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check/main.c b/check/main.c
index 6be22d77..831f7d0d 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10078,6 +10078,9 @@ static int repair_root_items(void)
 	int bad_roots = 0;
 	int need_trans = 0;
 
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		return 0;
+
 	btrfs_init_path(&path);
 
 	ret = build_roots_info_cache();
-- 
2.26.3

