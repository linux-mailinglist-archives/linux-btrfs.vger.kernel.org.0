Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847BD33984E
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhCLU0j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbhCLU0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:12 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E4FC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:11 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id g24so4839591qts.6
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aXO4v2hpXzT/esLFhaZmNAjCzSU2PAqamgw/AA/rS8Q=;
        b=KAwRlYcbTT3zK4jvMZmunM3WmtvhJoN23ovTbBKGb6X8nlPekfEoe3i0yMXO7UN3Ng
         c/37gdsPC7eaEu5VednfR/Ji4vFyB6CJB43Ki+QlJHSxwPu0+Cl59sBKbqGKAa3AFFuW
         AOFfkTZsUMtAZOAeAU2Ip+fFtC1UgQEQBkLRGQIWAxMTxH5W8pMd9NWaa/4VsQiznXCL
         kToVspD3rrCQuPNQR0VVZv/wuDFnK2KDGV1Vm1SJZdum6WKcf38tKrtI9gjPdWFnFBKT
         Jog5PPI8Wjwsu1Ae61LbeVHmkt8Wee0HAGuro2dK9HdfkjQwyqPFyK4bN+SYY4NQSkaC
         SJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aXO4v2hpXzT/esLFhaZmNAjCzSU2PAqamgw/AA/rS8Q=;
        b=gdP8LUfL0puSmhPDyptYalhG03X/scsiC7TGtMr4hzUX6B59AIdxY1U0Tiz07aXn7U
         bBJcPNsLKQzdG/SmPK50auWlAcjc7jatyfEQiMVS/4e9EiT0Z8fMhRAABh0Mbzw5I8QK
         BftWy23AdwGSsfX3qZLpuGJO303JxPU5TYxRT27PFXrP7DtE6dwgH4W3V6RoXmu1z7gJ
         BWptFRnT7GLU+pIarwqwc2g/2KtDsJ0U6mkETtpbemyu9aiNYVuhyycCbKX/Xw6OONaY
         kC02bu8Nzk9RWEyM6ISddXgLZnx/Cq+amnoCTn+wfXQGIe3c+Ab0si9vO2y4VfvrAdnD
         BmVg==
X-Gm-Message-State: AOAM532d0b0UtSmS/dWuy6uyiwte6Xlp9+1G3VWXMlTQvg8q/2tpE4Wa
        swNVgTrqQDKQBlammCUwUq1XcBUvhOayQTPQ
X-Google-Smtp-Source: ABdhPJypzMdPKzbewcoUgDfsk//FgJ6xibISag8onE489OMiUn3zNSELKisMtDVdPTbRNR/zmj67ZQ==
X-Received: by 2002:ac8:47cf:: with SMTP id d15mr12187112qtr.288.1615580770827;
        Fri, 12 Mar 2021 12:26:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l5sm4528756qtj.21.2021.03.12.12.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 22/39] btrfs: change insert_dirty_subvol to return errors
Date:   Fri, 12 Mar 2021 15:25:17 -0500
Message-Id: <871bef6b8f1668f7d94d154e68dfeabae791552e.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will be able to return errors in the future, so change it to return
an error and handle the error appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4022649e2365..2187015fc412 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1564,9 +1564,9 @@ static int find_next_key(struct btrfs_path *path, int level,
 /*
  * Insert current subvolume into reloc_control::dirty_subvol_roots
  */
-static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
-				struct reloc_control *rc,
-				struct btrfs_root *root)
+static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
+			       struct reloc_control *rc,
+			       struct btrfs_root *root)
 {
 	struct btrfs_root *reloc_root = root->reloc_root;
 	struct btrfs_root_item *reloc_root_item;
@@ -1586,6 +1586,7 @@ static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		btrfs_grab_root(root);
 		list_add_tail(&root->reloc_dirty_list, &rc->dirty_subvol_roots);
 	}
+	return 0;
 }
 
 static int clean_dirty_subvols(struct reloc_control *rc)
@@ -1787,8 +1788,11 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 out:
 	btrfs_free_path(path);
 
-	if (ret == 0)
-		insert_dirty_subvol(trans, rc, root);
+	if (ret == 0) {
+		ret = insert_dirty_subvol(trans, rc, root);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+	}
 
 	if (trans)
 		btrfs_end_transaction_throttle(trans);
-- 
2.26.2

