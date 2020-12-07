Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D581D2D12C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgLGN7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgLGN7U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:20 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC06AC061A53
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:03 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id y15so1811226qtv.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DMvNnOrRtu4yLJxhDVPBS7UDJWnYlz36sTOfG9aJkV8=;
        b=MaCsCPA70a4wPh+jKg4HNqiWHWO4am2tgOnCha7hIbMLwxtkHHOj2cfHQtNxC4JSpl
         vWaJABRxJZiuOP92ArBLG1eSkcz04ulkOJtD7TrSBxz3a1pN4DzWQnV6AB7wkPUQO8/P
         2ruWorBzWm08XpwUWYOV6prwDbE0zkunn3A3o6aOuFw2aSGwbJ1ufDc4rUnU4T/YPD2n
         as27q7q/QMMFbPXvDqmu+CEwr6CgqzAWs/NEM6GzIEJ/2MePJjM6hM9p4hjUT7dIWQI/
         9CMrpVzYHpXyLx9mf6QcCbhl7ZoYYCj//0foFg2Up7HgooMnjA0B+jOTDdUiYHTfMMDa
         1oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMvNnOrRtu4yLJxhDVPBS7UDJWnYlz36sTOfG9aJkV8=;
        b=i5jVN5bwPwM/OHKFCEUDSZZKVQBoG2cAGPdWY4XnZiV6iAsDHZdv8LfJWl24zVgJSe
         7Tf/S858Rm8O9qtF7eBq0UQjz3wAVOuOt2bnqd34Z6X1Bxga0Kv7+rj/lmQxbOR2Gm9j
         AwFaYreqxunqqeep52CmtkDFV4IFFd9/PfGjXuUvQrv+bBGo88RoNbzPmveZEew5VAAM
         KNDFQN/QRjaPsXhVfLHAmOz/cgOqW1OJqSpK8+bwUP5hfV+kyzx8lNnxBAMglsaYVlG6
         3c1WNB8eoDPF4Bf528YmH2ejyimczOm7bC/6zexninKn7mqT7usNyYdHr29ryjTxzChS
         n6ZA==
X-Gm-Message-State: AOAM532dIExFd+jY4jllncPjtbkqR2qiJnn6VBzVkELm8bl3VKlpbxgy
        +ZzRrCo6AWoIyYLJ0zvRTcQz+wy80zr8C17J
X-Google-Smtp-Source: ABdhPJzeSo7yjME4/d2iZRH5hiXvg0tFyIrLvdshm4gDm258OqqV2Vfy4DS0AxUYC6593wQ7vLWKhg==
X-Received: by 2002:ac8:5901:: with SMTP id 1mr24141310qty.350.1607349482762;
        Mon, 07 Dec 2020 05:58:02 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a185sm9302858qkd.83.2020.12.07.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 08/52] btrfs: make sure owner is set in ref-verify
Date:   Mon,  7 Dec 2020 08:57:00 -0500
Message-Id: <7fd17c9dfde7076d1c86afae4f5ecd35dee141e8.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed that shared ref entries in ref-verify didn't have the proper
owner set, which caused me to think there was something seriously wrong.
However the problem is if we have a parent we simply weren't filling out
the owner part of the reference, even though we have it.  Fix this by
making sure we set all the proper fields when we modify a reference,
this way we'll have the proper owner if a problem happens and we don't
waste time thinking we're updating the wrong level.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ref-verify.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 409b02566b25..2b490becbe67 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -669,18 +669,18 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 	u64 bytenr = generic_ref->bytenr;
 	u64 num_bytes = generic_ref->len;
 	u64 parent = generic_ref->parent;
-	u64 ref_root;
-	u64 owner;
-	u64 offset;
+	u64 ref_root = 0;
+	u64 owner = 0;
+	u64 offset = 0;
 
 	if (!btrfs_test_opt(fs_info, REF_VERIFY))
 		return 0;
 
 	if (generic_ref->type == BTRFS_REF_METADATA) {
-		ref_root = generic_ref->tree_ref.root;
+		if (!parent)
+			ref_root = generic_ref->tree_ref.root;
 		owner = generic_ref->tree_ref.level;
-		offset = 0;
-	} else {
+	} else if (!parent) {
 		ref_root = generic_ref->data_ref.ref_root;
 		owner = generic_ref->data_ref.ino;
 		offset = generic_ref->data_ref.offset;
@@ -696,13 +696,10 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	if (parent) {
-		ref->parent = parent;
-	} else {
-		ref->root_objectid = ref_root;
-		ref->owner = owner;
-		ref->offset = offset;
-	}
+	ref->parent = parent;
+	ref->owner = owner;
+	ref->root_objectid = ref_root;
+	ref->offset = offset;
 	ref->num_refs = (action == BTRFS_DROP_DELAYED_REF) ? -1 : 1;
 
 	memcpy(&ra->ref, ref, sizeof(struct ref_entry));
-- 
2.26.2

