Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 355B9113ACE
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 05:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfLEE3d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 23:29:33 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40064 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfLEE3d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 23:29:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id y5so1374390lfy.7
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 20:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ef5rNQy/9R2qhyIXv8LAgVHiMMgU/UWmJrYPihoKTNk=;
        b=VV0EgKFk+KO7ukEQrA1kvfK4VLBUvgI7RX0AXD67K4NkuAlmO1th8Vog5PLTeHt/0H
         JkSvHciR3I0rcJFGLZM4BUiogo7mkSekGkh+BtxK5PRRY31FTbiSCfzlKPuLtDOBuBCJ
         +eZD0qJ8NPEry+cFfbrVzn/NLehTb0TUPlwS+Y+Sw7JFt5T3XE6CJCX5/fjpjonlPWsx
         klZtswN7Uv2WfIFo241MLSR9EmDxn5JbT4TPnOdOd7DVH8JmC+0CYAYaFHvVSJXRco2e
         wOFlfukvb7KtCggLQHGSDMX8X9GWN7iq/nDoCzBkQVLatTNn5twdv7fiG3UAcW8WMJ3o
         7aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ef5rNQy/9R2qhyIXv8LAgVHiMMgU/UWmJrYPihoKTNk=;
        b=lVckkVIKRqibadQ8CaKKY+L+e5ZexSayjbBu0s9tDOxXv9qvJEgAPWhvzAK2UHa7tr
         QFkRRFrOlb2OjG+ZbBTiF5JPfRh9nnbQb9BjFj+VTXm/tqBCesQu8fqusEdtLcDuspQc
         7EMCW5OwmdjFFfU33Q/WJ7riY5wVtqthajUsGEgtAK1kOGjE+IVIk7aYjtyuBT+8a7gS
         87IYXYQBj1MxdMuS9BL/99K8Zrq7jqsrMl1S2bj05Pd1JZkiiuatu9HrgcthCp9UkAF+
         +AOIYhWliQcCcphZnxh/HRhfIswIUVOMI0YV996eR3paEJRjTu+0ctZqWB0BihTMFdde
         AeYA==
X-Gm-Message-State: APjAAAVzUHmhNNxlYyxB1NuRYFrlsB3X9uEo0oARp1zgUVCRnJuR51j3
        sjnAaVaI0EIhU6Am92Y5I4hXSek95Bc=
X-Google-Smtp-Source: APXvYqx0BihXIS9wkmbo3lRlAsxjpB2HDmlTE7hgERSf0ebrLi6yh7TyXO5BgPBDSLVBA+UCqZOstg==
X-Received: by 2002:ac2:485c:: with SMTP id 28mr4054211lfy.118.1575520170837;
        Wed, 04 Dec 2019 20:29:30 -0800 (PST)
Received: from p.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id c23sm4170865ljj.78.2019.12.04.20.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 20:29:30 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 01/10] btrfs-progs: handle error if btrfs_write_one_block_group() failed
Date:   Thu,  5 Dec 2019 12:29:12 +0800
Message-Id: <20191205042921.25316-2-Damenly_Su@gmx.com>
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

Just break loop and return the error code if failed.
Functions in the call chain are able to handle it.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 extent-tree.c | 4 +++-
 transaction.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index 53be4f4c7369..4a3db029e811 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1596,9 +1596,11 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 
 		cache = (struct btrfs_block_group_cache *)(unsigned long)ptr;
 		ret = write_one_cache_group(trans, path, cache);
+		if (ret)
+			break;
 	}
 	btrfs_free_path(path);
-	return 0;
+	return ret;
 }
 
 static struct btrfs_space_info *__find_space_info(struct btrfs_fs_info *info,
diff --git a/transaction.c b/transaction.c
index 45bb9e1f9de6..c9035c765a74 100644
--- a/transaction.c
+++ b/transaction.c
@@ -77,7 +77,9 @@ static int update_cowonly_root(struct btrfs_trans_handle *trans,
 					&root->root_item);
 		if (ret < 0)
 			return ret;
-		btrfs_write_dirty_block_groups(trans);
+		ret = btrfs_write_dirty_block_groups(trans);
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
-- 
2.21.0 (Apple Git-122)

