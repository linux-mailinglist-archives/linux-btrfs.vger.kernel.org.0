Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A3F2DC3E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgLPQT5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgLPQT5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:19:57 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664B9C061282
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:18:59 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id h16so7161904qvu.8
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DMvNnOrRtu4yLJxhDVPBS7UDJWnYlz36sTOfG9aJkV8=;
        b=eWPTGQ5R56bj7Uq3/EaQQK/96g1kHmrVzJx15LP1z2Fvc8oZAZin9dU8+xySF85WVz
         +BITqS5VeWPvWMfchoAj9bZ4AOw3Fm31eVfyYM5Omjkedk3eqz9MXC8zuzOMBf0uRRIl
         PZfUW3OHpaHr5zCJpB0aeFvM/xsL5Gyq+sybj2GzOFW3vfN1Xyb2s+YTqmxpQ9QcafPZ
         Spl0hDA7C8BiXpgCdrVukv8ukCtFdKEeAKfCQQY2+JaRdfSlocnHh1Rwe0xAmuy11eVy
         NFqNOHRd+hrC+5V3m5K/fcAWOX6FqAtvvlRYhONxxJ8xmOJUT7EEKBnPave3bQXC88ks
         8tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMvNnOrRtu4yLJxhDVPBS7UDJWnYlz36sTOfG9aJkV8=;
        b=Y3dU2szVEz3Bb+dqcx1LxeyiHkdDulhrAauRDzoDeRuNktsZvlZ1xZyaG96gR8lMHn
         ihYodMaS/0sysABV+HpLkFg//TcIcYhMsPyQIGWxztxiAxiqegWYuvqBmrTDoJ7ofj8H
         4YRwGwvELXjRYS070Eg82c9fB13ZdrXxmYl51kRaXWxqtTSr2dkkmf0hqCPtqGI4IG1H
         hcTmNm4tk9LU+aXhYXOYetgKbpFhoyOWPhduNhim9E/9VUK/d9BsiCnkrLCiQJqRxx7v
         +E9eg3VA7BdqTG9p1PZTTv8nb2wjxoGFH3bbKiglQeROYgyDBJUq8X1S3mZKjzWjXKGG
         xIow==
X-Gm-Message-State: AOAM531gBzqnBoct21xlzwtMo9QEmmrUrc7DNHpBttIaZgCpj4DHdDS/
        sUwE0zR62/RuL1iaXqZaIx+4+U4LyNp+kmjE
X-Google-Smtp-Source: ABdhPJw46M51fFSB3WdIHiMjo42j4wCyAclsjFEe8wxmqiy11RkebNqdv91z5xiaajyzIZJK6a8Smg==
X-Received: by 2002:a05:6214:10c6:: with SMTP id r6mr43216140qvs.44.1608135538316;
        Wed, 16 Dec 2020 08:18:58 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a77sm1342469qkg.77.2020.12.16.08.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:18:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: make sure owner is set in ref-verify
Date:   Wed, 16 Dec 2020 11:18:47 -0500
Message-Id: <75bfbd77fa0cf99dcd84edd1f213c7fb3df1d5e6.1608135381.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135381.git.josef@toxicpanda.com>
References: <cover.1608135381.git.josef@toxicpanda.com>
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

