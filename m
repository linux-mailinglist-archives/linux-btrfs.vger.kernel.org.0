Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20BD7113AD0
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 05:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfLEE3i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 23:29:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44879 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfLEE3i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 23:29:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19so1844352lji.11
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 20:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IieLt4RY+lRPoXEcpgZM30llPw+0ObXerqajWE+Ds24=;
        b=C2V79rctCBwqb8OMkZISLlFg1eNg48aOBsk+j7CKj9w9R37Cfr/cK6+1BmLSJ5LrrY
         kP3XydR58eTVdvqaEVn75vK/3DjAi1hq1o2aQfhRutBrVoQGUIUPAMEg9dmnOALw7TGV
         4M0SXkwS6rW4Bmezd3PuUyo1TuAIHxb+v7zuBHVfkIlwR43HxBW5LK5oBpJegGuWQukA
         empGrtLa0rDX2vxeMJaxrg0TDPtCGoTkdexjDhIpSzlmxJUYKNPTT27Jpn646eAc49BK
         x6jP3RpkQlCoWL46hwgFGhTQT8fsqGaAfRVmBz7Yk7UAI95CasziSMiQ6AP6i2hnRvbW
         Z8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IieLt4RY+lRPoXEcpgZM30llPw+0ObXerqajWE+Ds24=;
        b=AUTSrk9ORzXUQFITnG4KLrkMezWYUCHJ+iw92RrVI7eVprpQXH0u9f0263huw6DUUR
         s798t+1wsO7HPLb06IJM/gRT8seGFV4EyWw2kt3+owjIQtBRqubOZgRysghiuePKxC/D
         tn48EBpcaK+Ea295Z0+VqGodUtoWysVkYq7yC1QlZZ1Zu02k8P7wtlsv145sFAR+RdzL
         Rv4PmOfyWTkiVv95JadCquJWGtEblH3+EKg397hlxr39jwUwk7vHk9x+Aicek2vKd9z6
         ikxLFZdMS0TLeXFRTOL2IktixJU8gF6qv3TtdtG3LygfxeMV1uhVtPp6LVb9zuEFwWlP
         Z6qQ==
X-Gm-Message-State: APjAAAVaik/eJun5xJ7Dm/ePaLw/pICkWpS5y5VaHSSsi25/mUj56w8O
        h5UgB8duLY8nM3wieBr5xBrGhoOwcIs=
X-Google-Smtp-Source: APXvYqy8iEkT/nYc5xZg5tVNZU/h22VTXqBgvSoyPkfUFCP/fy58NvhzsWLw+v90gWtwp5b2qqTwKw==
X-Received: by 2002:a2e:2418:: with SMTP id k24mr4257513ljk.49.1575520176509;
        Wed, 04 Dec 2019 20:29:36 -0800 (PST)
Received: from p.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id c23sm4170865ljj.78.2019.12.04.20.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 20:29:36 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 03/10] btrfs-progs: port block group cache tree insertion and lookup functions
Date:   Thu,  5 Dec 2019 12:29:14 +0800
Message-Id: <20191205042921.25316-4-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191205042921.25316-1-Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

Simple copy and paste codes, remove useless lock operantions in progs.
Th new coming lookup functions are named with suffix _kernel in
temporary.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 extent-tree.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/extent-tree.c b/extent-tree.c
index 4a3db029e811..ab576f8732a2 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -164,6 +164,92 @@ err:
 	return 0;
 }
 
+/*
+ * This adds the block group to the fs_info rb tree for the block group cache
+ */
+static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
+				struct btrfs_block_group_cache *block_group)
+{
+	struct rb_node **p;
+	struct rb_node *parent = NULL;
+	struct btrfs_block_group_cache *cache;
+
+	p = &info->block_group_cache_tree.rb_node;
+
+	while (*p) {
+		parent = *p;
+		cache = rb_entry(parent, struct btrfs_block_group_cache,
+				 cache_node);
+		if (block_group->key.objectid < cache->key.objectid)
+			p = &(*p)->rb_left;
+		else if (block_group->key.objectid > cache->key.objectid)
+			p = &(*p)->rb_right;
+		else
+			return -EEXIST;
+	}
+
+	rb_link_node(&block_group->cache_node, parent, p);
+	rb_insert_color(&block_group->cache_node,
+			&info->block_group_cache_tree);
+
+	return 0;
+}
+
+/*
+ * This will return the block group at or after bytenr if contains is 0, else
+ * it will return the block group that contains the bytenr
+ */
+static struct btrfs_block_group_cache *block_group_cache_tree_search(
+		struct btrfs_fs_info *info, u64 bytenr, int contains)
+{
+	struct btrfs_block_group_cache *cache, *ret = NULL;
+	struct rb_node *n;
+	u64 end, start;
+
+	n = info->block_group_cache_tree.rb_node;
+
+	while (n) {
+		cache = rb_entry(n, struct btrfs_block_group_cache,
+				 cache_node);
+		end = cache->key.objectid + cache->key.offset - 1;
+		start = cache->key.objectid;
+
+		if (bytenr < start) {
+			if (!contains && (!ret || start < ret->key.objectid))
+				ret = cache;
+			n = n->rb_left;
+		} else if (bytenr > start) {
+			if (contains && bytenr <= end) {
+				ret = cache;
+				break;
+			}
+			n = n->rb_right;
+		} else {
+			ret = cache;
+			break;
+		}
+	}
+	return ret;
+}
+
+/*
+ * Return the block group that starts at or after bytenr
+ */
+struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(
+		struct btrfs_fs_info *info, u64 bytenr)
+{
+	return block_group_cache_tree_search(info, bytenr, 0);
+}
+
+/*
+ * Return the block group that contains the given bytenr
+ */
+struct btrfs_block_group_cache *btrfs_lookup_block_group_kernel(
+		struct btrfs_fs_info *info, u64 bytenr)
+{
+	return block_group_cache_tree_search(info, bytenr, 1);
+}
+
 /*
  * Return the block group that contains @bytenr, otherwise return the next one
  * that starts after @bytenr
-- 
2.21.0 (Apple Git-122)

