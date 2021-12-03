Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5750C467FD8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383410AbhLCWWK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383408AbhLCWWJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:22:09 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D89C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:45 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id i12so4122012qvh.11
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qISeoj5fnwcteS9756ffi82UIwH3LmhPGhdkH/LqKD0=;
        b=SO7RTIFpLHUAgs5UXV7kiHn0nPlXuycZ1EaE4Bc6Vc/JRbSkC613mCO5ikmJ2YVk1a
         OKgada+Awkw7M5fFq1D+ZRUY5iim2DKZfytJdvGj2GnSEuJoJBegkLs2hcZPAm0B2ogD
         Smmhv0XXem0GrwLMCyYTR3zyTMnO2bH/vnbi3TpzuPdHzNg809AP7VBekxDxKgjZWSvD
         n2unS/hL4hpkQSABxdAbkhcT9eg4zJIfmMyfUP1qKQ/YbpLBoPkAhbo6pOr/ftUX4Y/G
         NDtLhJl1GRtLyAGXMacKVpQd6r2ogZYyQq/c+FeNppQEm/fxHgX4+VNJvo9Tt+RI+1vD
         b9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qISeoj5fnwcteS9756ffi82UIwH3LmhPGhdkH/LqKD0=;
        b=iaK20nX7Hx5ssrF2L5eGucVDJQfP4THjJd/RMmqLc02RVyMMK1kfi1gWNfdx4L49qk
         U0kSmZLaIwhIJ6l9bETuaRsntNHlb5E9Exw8ZFDs3ksd5FZiC5SGntO3k8YeuFoNdcm2
         BoJ/V4ZKAiMQQl8doh1yvDD3zWmqDektOK+ZfORen3Gwy6ChN+1mbb1h+qW/XCzHtkVa
         2hUDb+/8iuiWtH/qFxRJxbZhE0n3/0Y/WYqarWQYNmg5yxZbicDVLSbEq7fobKEuAewN
         1OqUryqWvMeQ0vBYTArTvipRt/6D+FTdFnUmbFIPepPhAA0hE7NOoFgusdKj4O9qSWU6
         OlTA==
X-Gm-Message-State: AOAM532IHN3m7ad97KhC4EuV4xTrPw39cZ7XLwiqE1imG573GsAnUqiS
        zA3u2KCOAlNLmG41l2SUMhiO8xSlaPk5gA==
X-Google-Smtp-Source: ABdhPJyXM6DE8QWKoTzMp6hf5wLCpmtWxRJq4Ded+StJKn0Xb6NY2AKVUqZjrmw1P6pEbVkPTCWu+Q==
X-Received: by 2002:ad4:42cb:: with SMTP id f11mr21946934qvr.23.1638569924238;
        Fri, 03 Dec 2021 14:18:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t11sm2790122qkm.96.2021.12.03.14.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/18] btrfs: do not check -EAGAIN when truncating inodes in the log root
Date:   Fri,  3 Dec 2021 17:18:20 -0500
Message-Id: <0fe7c6435fb966e93f748d7d2132931e94870f5d.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We only throttle the btrfs_truncate_inode_items if the root is
SHAREABLE, which isn't set on the log root, which means this loop is
unnecessary.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 80520ad1de4f..d7322ceb8aa2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4101,13 +4101,8 @@ static int truncate_inode_items(struct btrfs_trans_handle *trans,
 		.min_type = min_type,
 		.skip_ref_updates = true,
 	};
-	int ret;
-
-	do {
-		ret = btrfs_truncate_inode_items(trans, log_root, &control);
-	} while (ret == -EAGAIN);
 
-	return ret;
+	return btrfs_truncate_inode_items(trans, log_root, &control);
 }
 
 static void fill_inode_item(struct btrfs_trans_handle *trans,
-- 
2.26.3

