Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3298F4762EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhLOUPK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbhLOUPJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:09 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5AFC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:08 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id t34so23108500qtc.7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cZ4niCKfTZ8+2IgdYH8VnkAvUBXaGzPBI2s3SgjCQ5k=;
        b=u14P8VwzzgkpdPyBFER7+ODtDSIAfDUqosjR5GqZcNBmCy5U+IuWXUYrCqaRnWJa7L
         8QjA+pY8IGHdkN/8tEf6Hifb9wsQiZXpeNHUFgLcePw/85ixIjNyeK5zx89exbiDQ94r
         K54VkqgCXKJR2om71Pe6Zd0xIQlURBqXG3fvgoPx85G9KCVqXL/vSkOjCZKOTfCKn/l1
         vtJxKGg+6PIm3dDXUvmAGG1FQ/UYBZ6Hl50Ktri8yGSPkH2Guer0F/b6YpbtaGjHI7vm
         7mLR3bt/PIWvSlQZTZOKOHIZu3sytt0o/P4zk/WIM2OtwTT0u3xaPFQ0uTNLg4P3WxMT
         L4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZ4niCKfTZ8+2IgdYH8VnkAvUBXaGzPBI2s3SgjCQ5k=;
        b=RsUsds44LNAU7bFKAyahp0gSJ6inmNAmY3pLvfVXbaxSsQwI/L7YV+5FgjLv9Z4NBM
         9f3yZc+xChIioanlA22N9QD7BPqAwY4QOLf55dzfBewPT+HhaRV80LlACbpiZHUUS0Ko
         5+7WAMo+ohDo3Ta2P6FX9HZQDy4hzkDpTR8BzNw9R0wuHCPHviu4c4/qPej5CsWg7f5z
         or51zSJlfyubFBUl/8FprXQp3w5MponI+wT9gP5vEKOT0h0qTkxhO/1K83RL1r4h3y8d
         B+yrBjK7QFQ7tsSb5HEkG1bfoNZwPC+h4N565BwxvrmxmyDuVK1MmUjoKfof89rSXDvo
         9AFQ==
X-Gm-Message-State: AOAM532deCrVvVdJ7S1JcTQfBvwZ0w6WAbjpt5elWsB+y3gv5LKbqKb0
        jAXUQaHfoqz1dqGn1KLFOuvnc7yUDk2iUw==
X-Google-Smtp-Source: ABdhPJztRECLAxgs0/IOOOOheToZvLxTHnPFr4AOybagHMahyEoKVUOGb6g51gDw75X+S1OcKvHgUA==
X-Received: by 2002:a05:622a:170d:: with SMTP id h13mr14229012qtk.99.1639599307834;
        Wed, 15 Dec 2021 12:15:07 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l15sm2283615qtx.77.2021.12.15.12.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:15:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/15] btrfs-progs: repair: traverse tree blocks for extent tree v2
Date:   Wed, 15 Dec 2021 15:14:47 -0500
Message-Id: <cd48d5ed3e7cc4b3064518369d756cc64a797205.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have extent-tree-v2 enabled we can't only rely on the extent trees
to find all the used space, we have to walk all the trees as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/repair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/repair.c b/common/repair.c
index 9071e627..6784534b 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -210,6 +210,12 @@ int btrfs_mark_used_blocks(struct btrfs_fs_info *fs_info,
 	struct rb_node *n;
 	int ret;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		ret = btrfs_mark_used_tree_blocks(fs_info, tree);
+		if (ret)
+			return ret;
+	}
+
 	root = btrfs_extent_root(fs_info, 0);
 	while (1) {
 		ret = populate_used_from_extent_root(root, tree);
-- 
2.26.3

