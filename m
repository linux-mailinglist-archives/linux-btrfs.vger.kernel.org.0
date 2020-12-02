Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E232CC739
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389859AbgLBTxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389858AbgLBTxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:39 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7280FC061A49
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:44 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id h20so2475182qkk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MNYfN9Weo90pg02yoVmh2ok1f8E+gOfxD5JlSFIWHws=;
        b=sweugU5CnIlm6haV6/30uIrbOuXPxXNZUPjlV+zqBrg3saN9Teg1LxALUi1sNnA0bC
         +1ZYhecRq8VV5KhMmveogA1S5hxilrNCNzeYnYTucbmJf8Ujxphxf2s+vijbIIHWcDna
         IAvFdoIwLXqsDAcu/AqbUBQtW9uzRz75VCHSjJlR/jP3kMhsSSm3lQFH4O3tJKD6suxC
         CdR26tGgWYileXHy/U9tyFLwAAF+eZ+qsV1HgMl2JQTCYTT0CXxtXCBMfT3GjSL8tuD2
         MsoTHqg3eYebPpboQSCQO+Z9CAhZFqbhga8usmwZq4Lpx9BgpyBFbDyBR09nSBeBkU75
         I07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNYfN9Weo90pg02yoVmh2ok1f8E+gOfxD5JlSFIWHws=;
        b=bLzK4JvB7bIKe9LRNhmSYET4IN10nGzHMVoscMU5wiV/B+Fl+x3RqPcnKpq2PPBch2
         x7KLGuUw5HWR/b6kSQtdGMnQW7tGaQUkyee+LNCHW3mGYQhedr/zSniQPV5+BgLKEONH
         kNjVxTGu4kbXai4PIkSLcyN+2epjQkCizJGbQktJkeFL4GJRF0WCMe/7B+tZPUGobq2T
         tSZZK+kYvjPUT8GjPAS+z9VT9kRTOlfePnOkRaYd2+1wxFHVd3BGMlG/RYO9AJjbfqfB
         MJpELU1X4/NELWHEWDgniLbXu5A9BjkoS4fBPXkIWBqpv197xXlnBasV46NmPPV18iRg
         cxKQ==
X-Gm-Message-State: AOAM530hig6z5jCmh2h08/+1KcPuKlV2xRSBJPZUCMA5qoO9djh+0i46
        x/VuL4ZYMK0CJw50PvmOiVjtLpiZBOv8DQ==
X-Google-Smtp-Source: ABdhPJzAAVMcRKtWvQiBq7ZClt4pGAwrXHOuIviCw4u1eCHAE5GlKRcjh6fs+O+gUBWEWW8S3YbxEA==
X-Received: by 2002:ae9:e8c6:: with SMTP id a189mr3317224qkg.334.1606938763353;
        Wed, 02 Dec 2020 11:52:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j63sm2816630qke.67.2020.12.02.11.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 49/54] btrfs: do proper error handling in merge_reloc_roots
Date:   Wed,  2 Dec 2020 14:51:07 -0500
Message-Id: <bf1e7b86cd6c3e7c2584cd785a7d4e595c1491e2.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a BUG_ON() if we get an error back from btrfs_get_fs_root().
This honestly should never fail, as at this point we have a solid
coordination of fs root to reloc root, and these roots will all be in
memory.  But in the name of killing BUG_ON()'s remove this one and
handle the error properly.  Change the remaining BUG_ON() to an
ASSERT().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 91479979d2a7..099a64b47020 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1949,9 +1949,18 @@ void merge_reloc_roots(struct reloc_control *rc)
 
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					 false);
+		if (IS_ERR(root)) {
+			/*
+			 * This likely won't happen, since we would have failed
+			 * at a higher level.  However for correctness sake
+			 * handle the error anyway.
+			 */
+			ret = PTR_ERR(root);
+			goto out;
+		}
+
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-			BUG_ON(IS_ERR(root));
-			BUG_ON(root->reloc_root != reloc_root);
+			ASSERT(root->reloc_root == reloc_root);
 			ret = merge_reloc_root(rc, root);
 			btrfs_put_root(root);
 			if (ret) {
-- 
2.26.2

