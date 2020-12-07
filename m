Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C2A2D12BA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgLGN6f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgLGN6f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:58:35 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23890C0613D3
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:57:55 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id u4so12480105qkk.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMa7bV9M06CL/jmsCalzp9jQP6wxpAhOdiQ2gxt0798=;
        b=n9tWfkLmQqMcmC6fqUYSjAIC6q4RSWhdVVf43DJSYOzkkVDE2SUlG8PG38qwEJknwc
         FHfoWMFE8tZfUn1X/iH3Ac3qHmTCHsdaHQ4w2ZNpIWp6eQKfSV2NanMi+MtO0WlL4xLa
         oSKEfNXyj2JXamzXGtbXuVRm1oi0srF5ooXvIdaUpXghA7cFT5MgwugpLMHpoNBgVEVF
         QNg5MJmcaUmuHcazPXZPbP9bPWB/TIvzI9++/MVO0gLvTlVoeq6/oY2RrNtVJe4SYZmH
         kDD2hDBl9I5RI84AIkF5YYf6xZCW8oB9mj2slHaQJW2WGeYVGHfmqsMcsdLxgux6fxAa
         VVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMa7bV9M06CL/jmsCalzp9jQP6wxpAhOdiQ2gxt0798=;
        b=RbCIEmcWn48aVq0s5P+UoNIwScdNJ6tQnwZxO5L8CG6Yp80+tkC3s+t3HwUJWsMkYX
         WxEuN3hComHJiY9STBxuih1tvRAzslvpu0TxSsK2QaZjjolHCcwrIbWJLDDA9iA4Eo1Y
         F/6i2iYkIz+F2BraLf6ZJvTAkQIK45Xy/wHnC8sNu8BqXwc3OBhcJO8m3oAQQ8tfMBzG
         QTZiuUeFmFdg6K8o5/uGBtMZSDzSbIkCKyfKLZFXKvk6m9n+Lj6myDBfsv+qrVxfbfIp
         ireNmDawJNXgjgGSnt2XmIlfdxTlAdGWbDcFPC7FzuLHnE0f2Az9oQ1KxNgRuyx/8ikj
         fVYw==
X-Gm-Message-State: AOAM533Ze0v6I+aSXltJyffyIBytS6Qjw1Dey6VDAk3ChCZoxLmfuqXH
        cJD2GQzxD9/d8a8k6Jt1fV3wZkg6GxJH4sk+
X-Google-Smtp-Source: ABdhPJyh1EUuQuXFrcAWIUNB6j8lBrkTzojTq1G0vuylRy832gXs0fnXBjKcEc05N7j1U/s4ViyczA==
X-Received: by 2002:a37:2c82:: with SMTP id s124mr23910858qkh.130.1607349468475;
        Mon, 07 Dec 2020 05:57:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h26sm7202971qkj.96.2020.12.07.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:57:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 01/52] btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
Date:   Mon,  7 Dec 2020 08:56:53 -0500
Message-Id: <f95ececbdae1d635391feb070bf869da15fb2c95.1607349281.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following patches are going to address error handling in relocation,
in order to test those patches I need to be able to inject errors in
btrfs_search_slot and btrfs_cow_block, as we call both of these pretty
often in different cases during relocation.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index cc89b63d65a4..56e132d825a2 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1494,6 +1494,7 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
 
 /*
  * helper function for defrag to decide if two blocks pointed to by a
@@ -2821,6 +2822,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		btrfs_release_path(p);
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
 
 /*
  * Like btrfs_search_slot, this looks for a key in the given tree. It uses the
-- 
2.26.2

