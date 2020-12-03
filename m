Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB3E2CDD60
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389302AbgLCSYh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388028AbgLCSYg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:36 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E13EC08E85F
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:18 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id v11so2028036qtq.12
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DMvNnOrRtu4yLJxhDVPBS7UDJWnYlz36sTOfG9aJkV8=;
        b=N4huRTxttzYL5voQ7SxS0dxMWFqXMJMAPON28fEEf7iPpAV2c0QJmTuuum1XJ/4/P1
         n7XLIQWmoZByw36cCqZrg7bLKf3D7m5B+6zlgXIlx34bZ4A50FGEpD0g+uR1UkXgidfX
         Xh2vQZvxZ5to8nqnD8OWIQ+AUps6Txd5rl/1bRJrs+XVtzGQrRBsyhkHbiw30a/noOtC
         J4r6rV9IdpKT1XqO5aIghGNZPkF25Y5BfK7tZc3kOjdcP1a/eG2k4AWjSyBOh69Hd6im
         yIyv/wB/N609A/XivjogShtkUbsnU2vsTLFWQySutZumUKWrbFh2XcfFeXhh078uC9AP
         HxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMvNnOrRtu4yLJxhDVPBS7UDJWnYlz36sTOfG9aJkV8=;
        b=tMN05gM83CFFc0kFv0kIPAZwpzEgwF6GPbf2JqoX3CCB2Toy9qd9ydmHrxXqGzLGQE
         9ZN2ULQ6ldfLUGbv8RpRRkqo/REkPF/EpATW+IXDcME0SIZ19NbLx8dz0MmqSO4l25Rv
         CVKwdGS4YGMSlHAiL64m3jbJzhRW7A7T9P/GpNXeHSY9FvLJ4uII87jny0nAEAhSGbPc
         tE4je6chr1xBbZ9V+v+HfYlC6enJJAeg2aAaxzbpf9XT571RbwUsGZaqybvRGRxVbues
         8pxWnJG9PwBp8baUocgxyeTx+waZ2ypho0Mg9vi2+bOahjO5FXDOqhiFAM7/S0AbUnuC
         VRXg==
X-Gm-Message-State: AOAM531CxuVBHNaJ7JrAv9jN2XM1W2orOX6+UhnqKP7A18YP9oaHuGGj
        bkhOlNiMyk8CKZWrvjMcb2XduFofc4NwOO8N
X-Google-Smtp-Source: ABdhPJxpUBs0ev/bC+N+RUNcNQZ+T9STbHQRZM75jxUDuX0VSEtUSDFYNI6q7HYJY9r8agAxgU5zBw==
X-Received: by 2002:ac8:5c0e:: with SMTP id i14mr4436193qti.328.1607019796757;
        Thu, 03 Dec 2020 10:23:16 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 199sm2159551qkm.62.2020.12.03.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 09/53] btrfs: make sure owner is set in ref-verify
Date:   Thu,  3 Dec 2020 13:22:15 -0500
Message-Id: <46f35e067b444528e4c1f3ffb511ce69937dd150.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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

