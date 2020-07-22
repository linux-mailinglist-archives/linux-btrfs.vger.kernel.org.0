Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BE2229F77
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 20:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbgGVSpk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 14:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgGVSpk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 14:45:40 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C141C0619DC
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 11:45:40 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x62so2611790qtd.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rYRexB32BNsJiDXEKKguRJIxSKZMrIgkLA0B4NRkUWo=;
        b=VTA6AuNTPhbLH9Wdtwq4+ytX9ILdGGSDPVKWDAybDulTRThTZDRzoi+iOUuArDmD0r
         J4jtdPYj9G9xveCwCm/e7ITq1wWQPNqwDNoYw4B0SYQu3DuhfKMg+ggn03ipyQ0I9Oyu
         m4DItqaIqSMhU8aw9hv1Q0TjsQj0iHtbay9k9PHW8FSekt94BY8Ob2pq/qLs0DJAENj2
         mt25d3uU+3BOpDFRQ2C0xpANWG031dCv3QxlKyrLdyAqvEPOaEdkDP0TqvIopE81WhGQ
         5wmkqyW7iFM5ICMNnLKVqP6hylo3r4gi9zKSNKW+fuRCnCVfz0o0KIpHfX9WzQ3Uve8A
         /BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYRexB32BNsJiDXEKKguRJIxSKZMrIgkLA0B4NRkUWo=;
        b=Y9xsk5V7+QDnv/4zyRQx1R3tedRPLzDuSRG7m8wOOtrTuSyqMONFTOHFzwQKu8uRi+
         FsIwaKojG3a/SUyCLw3ZIQ4ZWTzBue8t1yEXu+6Lu8J1PPjVif7YXK6m2FT/20uz3j1/
         cA2BOsMvW6IPhf3uv3eo3Y/O49T9PIQPb/+COGEDi+jTXGp4qxnJMScWDPF6caxU6Feq
         zbOabkURSKXHh6DdzoEOXOrvsfDmygZ71dTiQQwNQ4OhyFLjHXxc93jKeC86UqvIxt2O
         UbtTQTCgYTx8p363Pu9ONayXvETd2e78EwG0c8EgyHWX2YxqHMFUf9hkZGLtSc93Z2q9
         gvnQ==
X-Gm-Message-State: AOAM532Nuj3IE/1Mz3vMsrQ8PZKSTkQks1rTNPoVJjpg5+GLMxe2yEef
        5BiQNEn9nlQF9Iv4gTAviwE5FMxmoAE6Dg==
X-Google-Smtp-Source: ABdhPJwAGN+aA/k/Z1zsdZwzItfIP1rqp6bErG2bMKnCWxUuFwOKmdCwmpUErRrVQaWv+RIj0SilxA==
X-Received: by 2002:ac8:6f73:: with SMTP id u19mr810456qtv.36.1595443539281;
        Wed, 22 Jul 2020 11:45:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h55sm449561qtc.28.2020.07.22.11.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:45:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v2] btrfs: only search for left_info if there is no right_info
Date:   Wed, 22 Jul 2020 14:45:37 -0400
Message-Id: <20200722184537.19896-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722184245.19699-1-josef@toxicpanda.com>
References: <20200722184245.19699-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The CVE referenced doesn't actually trigger the problem anymore because
of the tree-checker improvements, however the underlying issue can still
happen.

If we find a right_info, but rb_prev() is NULL, then we're the furthest
most item in the tree currently, and there will be no left_info.
However we'll still search from offset-1, which would return right_info
again which we store in left_info.  If we then free right_info we'll
have free'd left_info as well, and boom, UAF.  Instead fix this check so
that if we don't have a right_info we do the search for the left_info,
otherwise left_info comes from rb_prev or is simply NULL as it should
be.

Reference: CVE-2019-19448
Fixes: 963030817060 ("Btrfs: use hybrid extents+bitmap rb tree for free space")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Fixed the title, I had changed the fix but forgot to change the title in v1

 fs/btrfs/free-space-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6d961e11639e..37fd2fa1ac1f 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2298,7 +2298,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	if (right_info && rb_prev(&right_info->offset_index))
 		left_info = rb_entry(rb_prev(&right_info->offset_index),
 				     struct btrfs_free_space, offset_index);
-	else
+	else if (!right_info)
 		left_info = tree_search_offset(ctl, offset - 1, 0, 0);
 
 	/* See try_merge_free_space() comment. */
-- 
2.24.1

