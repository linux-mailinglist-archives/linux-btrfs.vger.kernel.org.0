Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404B72B204E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgKMQYl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgKMQYk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:40 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B0FC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:40 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id v143so9313841qkb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X0hymZFo0A/afeIEWHyeNz1yvsVsYFb4bS9foED8GA0=;
        b=sjpB/OzbDinXHcBVsC9D1TRSZyoH8UDtXEc1tOxctThFJVPuA1IfUbc6kOu+Unw3D8
         C0cPOymeykXr369MMPosjfBBAvxYLWunquAft/cDUpjyIN4oH0ZWBh+TR4KPfSMnRvGC
         tJLGlHI6s0+qE1Rwg02f3+wONKNtKb4uRNvCpWPO+2WgF5aIvDzVm+ZOM8GgR2lHebq+
         3NOPJfjNMuLgb460xSwj39+pzslWuw3A+Ev1oYGISqdZtjhtmhpdlFKPq7ib9OnlJ5Kg
         p/BTU6MQwalyXsb2ggAcc6uwhgpLSX4bCianSp+cUG76Rm8QLwa712niMp4b3Nu3sSWe
         w3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0hymZFo0A/afeIEWHyeNz1yvsVsYFb4bS9foED8GA0=;
        b=UjT6kouB9WatQNnxrxuUJRWr6DVhxPUbIZaWeU6evTjPr17HtlgUTQapOb47lsTsrd
         sO4YYNdPz/ee0zHobzf/QUXvOGQWj8dcl+60lJH68sYy0pcrFBkrXLEQ7JfQtJl+m7wW
         LgRQxG/nP2xmXD1o4IeqVM0UsxXZMXDpdTt9SRcmh87C48mBJTX6H/ZeaWuJAlIrgRFH
         Q2KLqJPMXQVxCui9tgoUGrAhmmNG8y5e/RdjxsYmX84eG1DfWsECDeqaOWj0N70EnF+S
         OX7PHUZAa1XSIVYuCe4Po4ms76bX8IZxdqs5honw3RF2tiAphW5x8/kyPKeQ/Z3ZvTu3
         bwoQ==
X-Gm-Message-State: AOAM532kW5sAI+6hwS3py6X+ClQEWHpSfWu8mzCIqdx4EpqyHNTuDj5F
        j9kOjjT1xxy903VE0RYlscfqzD1xcuTM7g==
X-Google-Smtp-Source: ABdhPJySvIyDI+zDzzF0hPSR3/vAI9A4bVm0vP/ieDrNYsYRVUoSyxPqDYuHtqjnQpSwKRzRfYc/MA==
X-Received: by 2002:a37:78c:: with SMTP id 134mr2833683qkh.359.1605284674160;
        Fri, 13 Nov 2020 08:24:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b4sm6685413qtt.52.2020.11.13.08.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 32/42] btrfs: handle errors in reference count manipulation in replace_path
Date:   Fri, 13 Nov 2020 11:23:22 -0500
Message-Id: <e5de4ba3b1f5129cc37700b9c89d884c08da278f.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If any of the reference count manipulation stuff fails in replace_path
we need to abort the transaction, as we've modified the blocks already.
We can simply break at this point and everything will be cleaned up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7c7dda11f2aa..74d52fc457c7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1355,27 +1355,39 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.skip_qgroup = true;
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
 		ret = btrfs_inc_extent_ref(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
 				       blocksize, 0);
 		ref.skip_qgroup = true;
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
 		ret = btrfs_inc_extent_ref(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, new_bytenr,
 				       blocksize, path->nodes[level]->start);
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
 		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, old_bytenr,
 				       blocksize, 0);
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
 		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_unlock_up_safe(path, 0);
 
-- 
2.26.2

