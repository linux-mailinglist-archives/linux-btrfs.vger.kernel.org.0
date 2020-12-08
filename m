Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8C2D2F72
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgLHQZ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730210AbgLHQZ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:27 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8890C06138C
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:20 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 1so16481530qka.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DMvNnOrRtu4yLJxhDVPBS7UDJWnYlz36sTOfG9aJkV8=;
        b=hA433fFe3SsJc4KO3meV0Y8DmXxvrbP/9oHcgevrIcUFPipsTCpLlOnqs/0SpmoLEQ
         Tto4zOF7xBlPBLl9aN3X0jbEGjkMFzbI6GzTWfvLVu2qCKR1Fi47aUSR1qUzVqZJ7O6x
         gbd6pznqqvjMyQJyhnMHFQO2Jj4ejkXIcWwLHi1VkB1PD+Wjaz0XroJApp2CDanl9H2g
         xVvETkGx2bAnPb5H/geL9ekrDlURqomGQOFbzqGGlmYy10ZwefLHMnoI+FeIsKNu3aHk
         Lv+sHz+2/lwg/xbdZu6eMm/tNMANW5TLH96F5hQBX2oSTkK2HItbfP4opWPqRDPF150o
         j0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMvNnOrRtu4yLJxhDVPBS7UDJWnYlz36sTOfG9aJkV8=;
        b=ODdOYLHgN0wBGtFujySq1fBMAO0akLGFzYGemd08MTmxiqGD8I70dShaTNM8H8F8Mw
         rT1Y1CChHnQF4iuCjiv7+iEVzflmuFev2Dj54BOIL03Dcf0ZpjAHj8AdV357dwuIzCbg
         vC6KAbinPT/ShICYDBeAPFBJQ60Vw/p22aqq8j1W27bKKx3/76FZ0yhS07LnKDmxDCJC
         1043RJxa0Bdf9UdCsOEE8rnEXddhyRh14c7k5IexK/FpIsUbpE7KSshBrX5ej9uGnInA
         iqaKWG1UT8CTIbVQGI6TFtY87YrQRZx+C4oIofaLjowufIPME1YPCJVhCF7IPjJF1bKZ
         Vnaw==
X-Gm-Message-State: AOAM531PryOmHiw/aHdCeyD2xVGsDErNW+zLgyqpHpG4VqJq0qqhLsct
        SX+q21SBCgAH6tTxdhvA5iN0SYaJHsl1/zid
X-Google-Smtp-Source: ABdhPJwOrse3m91UkeOSdg6sgN9TkzSvLHEOABSgWjVI3ZHBpU/0TrjcPQJA3BAkvI8E9mSKD+hIDQ==
X-Received: by 2002:a37:a297:: with SMTP id l145mr12664666qke.344.1607444659602;
        Tue, 08 Dec 2020 08:24:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n66sm8055925qkn.136.2020.12.08.08.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 08/52] btrfs: make sure owner is set in ref-verify
Date:   Tue,  8 Dec 2020 11:23:15 -0500
Message-Id: <2c33a26a51ab7c14f2b9d97a5dabbc2061ef0586.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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

