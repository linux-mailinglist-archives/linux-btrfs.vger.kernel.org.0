Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7367F4D0A83
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbiCGWFc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbiCGWFa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:05:30 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20865443F5
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:04:35 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id o69so745138qke.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Rt7jX1+ib6kFVkx2qbgD59LGRRu+EfhZ/Z0Otm42+K8=;
        b=EiciQgdouy1H/ZtULeH4ScJWBpofUDsKLHWIsdUpfvVg2935vk5bEViaL1Ww/rwh8B
         Z4iIPS6FmlGQCHLoBBUI5j9PWSXUhElSkAnkg3JGLeh2xE1bkpWsLby6kRVCwmZQXcZ0
         h0++pnOFKCCIey+M8n78dZ6oN1qGrI92/QQ7YO/NN3fTCXeY9pmnQ+WSN068qe2RhyyI
         pEDXvpT+dbc00zExbqGsSE8+lR0rfQ3rfHZ6iF/A+mVX0/y1aLnhV2KZgkKL4DYDDcPQ
         hWeJNCU0V8ztv5/DDCSyJcDvZi8+QwBu1ZeqKwqSe+iNtX32++NoaPkPonIGTx3G9/2o
         F7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rt7jX1+ib6kFVkx2qbgD59LGRRu+EfhZ/Z0Otm42+K8=;
        b=R0IEpgyruGCQho3Y4o4aaU3m8N1jBVWJ0PI5HLFhtJwYp4pxHiHFr3Eujzj/ru7MK+
         ed5TvLGncVPSBiSSvcXPMSE/uOKzMPoG4orMmbGPRPMQFUpCn6szLtGSx3oix0G/Itoc
         v/ws6cDdMDVpgqX3DqBHbd5rqNI8WIoG7T61kYCGyV1lqHgL0aa7OBlATs1LciZzoE4P
         gakHAvH4EfD4uZxJH+bv0AGY+XiaPAYQIgUkivhduhxA/U5Rx+wxZCyjltJ4bKob3a1J
         B4NIHb3eP/NynVvT/D77RdWR6OnXGrucGOh0lAT3z7A5x/YzZ919h/lpl0cOrb7oBftC
         sQ/A==
X-Gm-Message-State: AOAM5329vTXyyTdbtdKY8Xo3apzlIH6VI1KQ3WtJZB0SdZI5D2D8daai
        ZYo8rDPRZuWYSaTiZGY0Zf22LoEMhsY3vX1K
X-Google-Smtp-Source: ABdhPJy4PrEbmJn/QjoSejOBVlTFselHL+wLcm6UNeLhMSIsc+z7qW4LbA+XwKF+TR2H+g3kdsn33A==
X-Received: by 2002:a05:620a:240a:b0:67d:16a4:4c21 with SMTP id d10-20020a05620a240a00b0067d16a44c21mr212218qkn.244.1646690673955;
        Mon, 07 Mar 2022 14:04:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z203-20020a3765d4000000b0067b48d49c65sm970862qkb.95.2022.03.07.14.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:04:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 4/6] btrfs: add a btrfs_first_item helper
Date:   Mon,  7 Mar 2022 17:04:25 -0500
Message-Id: <34ddd9cff453a67479839858138ab7f4b2aa98bd.1646690556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690555.git.josef@toxicpanda.com>
References: <cover.1646690555.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The GC tree stuff is going to use this helper and it'll make the code a
bit cleaner to abstract this into a helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 23 +++++++++++++++++++++++
 fs/btrfs/ctree.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0eecf98d0abb..eee0b7e3c68a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4791,3 +4791,26 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 	}
 	return 1;
 }
+
+/**
+ * btrfs_first_item - search the given root for the first item.
+ * @root: the root to search.
+ * @path: the path to use for the search.
+ * @return: 0 if it found something, 1 if nothing was found and < on error.
+ *
+ * Search down and find the first item in a tree.  If the root is empty return
+ * 1, otherwise we'll return 0 or < 0 if there was an error.
+ */
+int btrfs_first_item(struct btrfs_root *root, struct btrfs_path *path)
+{
+	struct btrfs_key key = {};
+	int ret;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret > 0) {
+		if (btrfs_header_nritems(path->nodes[0]) == 0)
+			return 1;
+		ret = 0;
+	}
+	return ret;
+}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aaa8451ef8be..0260c191c014 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2914,6 +2914,7 @@ void btrfs_wait_for_snapshot_creation(struct btrfs_root *root);
 int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
 		     int *slot);
 int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
+int btrfs_first_item(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_previous_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid,
 			int type);
-- 
2.26.3

