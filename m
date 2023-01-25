Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6B067BD5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 21:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjAYUul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 15:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjAYUuk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 15:50:40 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0183744BE
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 12:50:38 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 65F215C02F0;
        Wed, 25 Jan 2023 15:50:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 25 Jan 2023 15:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1674679838; x=1674766238; bh=TZ
        ODq5ipBPHXR1fUlqHdF3BP+C8x4KpdWUsdeq1DwJA=; b=gdeL9KCdz5q3guWbXc
        HVhaMEDbogq4BFxBIg8BwjuFW2FBTCFRj4o/EjpwKWe2zOFQ/IuwTz/OECc0QGcw
        OHQGfKq5YHpD7BVOndoNkOk+TPGIHvwe91ruMBgCteuHW+331ThjO5n0Y7VwY8AF
        XP10l+V+Mms+nDj/AaDpLpHH1QPLiGV72dzcOrd5y4JBxTe9c/1dF5RD4QYdoMej
        OSCprQb1En0rJgyz7ePizfV3dCVq64u8SZhf6HfOqS7zGXZc0UTSQXlvXEct+QCQ
        xl2SNB/weacTkMRF3cBgbopnXfNeLuESxsZIeEw5snV3sWjg0A/wFuaMxaCpRfyb
        /GVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674679838; x=1674766238; bh=TZODq5ipBPHXR
        1fUlqHdF3BP+C8x4KpdWUsdeq1DwJA=; b=QOHcr1bqnfx0qzmS5vnRgl2IB3+oh
        rBuOIHni9yWeRNBk6JK4Jt/MnQoeU8prUdyCPFGirViDvt7x3zeXHHDdeRJaYvFM
        XYh/xDv4NxPrqItyNF1VK7xN2ikDwwoOg6wXGXBEQRYutwmQiIhSe23mljbsAi0v
        AdZxkANBVYSO272oGhpNQlf58DOiPpMvtGOUjoPEyuI3igaHt1cWQb5WxVTABBOb
        pfyrhUhGZAbkzJ6Q7Dx7+AiudLHmfPT4oG0JPyvob36QYXuQf6d6ah6MLODzNZog
        uJy5N6HiiairWTOmAncGLAsXiEFto1krkLh4IaRHe+RRVlXGZkZfg49dg==
X-ME-Sender: <xms:HpbRYxt29XU591ys71OoWaA4m32wXZb8SWAIPClrYjG89rGNvyXxXQ>
    <xme:HpbRY6eneVQsJOPCP6PmDz6M_R-coS71TIn9jW1Hq91JYpCTfhz2hMjkjVbXXC-Nx
    E619Mv7vv4NLntL6Bk>
X-ME-Received: <xmr:HpbRY0zEwJsjIpLz0VsdN-Aq6KIQPFXwpEjNCkH2yvbloWtTyBkStBlp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:HpbRY4NIY6QwS9_TUrF24e-diWNRdHdDYTdu5o7uuumjF0X1t4JZIg>
    <xmx:HpbRYx9Wc-BjOUNAP3UyNdsPy42FNwPSfFVY7KHPe96B_n1FhtJi6A>
    <xmx:HpbRY4Uh9vfJxDUefo2nh7VjC2ocYDvlbF6q5UgrYcdNr-5n5YGW5Q>
    <xmx:HpbRY-GeDYkSCplqpPDlwU3sVYU_QuaYqR1UVT8BLNxabhBGFUsGEQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 15:50:37 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: add size class stats to sysfs
Date:   Wed, 25 Jan 2023 12:50:33 -0800
Message-Id: <3e95d7d8a42fa8969f415fc03ad999de3d29a196.1674679476.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1674679476.git.boris@bur.io>
References: <cover.1674679476.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make it possible to see the distribution of size classes for block
groups. Helpful for testing and debugging the allocator w.r.t. to size
classes.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/sysfs.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 108aa3876186..e1ae4d2323d6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -9,6 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/bug.h>
+#include <linux/list.h>
 #include <crypto/hash.h>
 #include "messages.h"
 #include "ctree.h"
@@ -778,6 +779,42 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
 	return len;
 }
 
+static ssize_t btrfs_size_classes_show(struct kobject *kobj,
+				       struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_space_info *sinfo = to_space_info(kobj);
+	struct btrfs_block_group *bg;
+	int none = 0;
+	int small = 0;
+	int medium = 0;
+	int large = 0;
+	int i;
+
+	down_read(&sinfo->groups_sem);
+	for (i = 0; i < BTRFS_NR_RAID_TYPES; ++i) {
+		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
+			if (!btrfs_block_group_should_use_size_class(bg))
+				continue;
+			switch (bg->size_class) {
+			case BTRFS_BG_SZ_NONE:
+				none++;
+				break;
+			case BTRFS_BG_SZ_SMALL:
+				small++;
+				break;
+			case BTRFS_BG_SZ_MEDIUM:
+				medium++;
+				break;
+			case BTRFS_BG_SZ_LARGE:
+				large++;
+				break;
+			}
+		}
+	}
+	up_read(&sinfo->groups_sem);
+	return sysfs_emit(buf, "%d %d %d %d\n", none, small, medium, large);
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 /*
  * Request chunk allocation with current chunk size.
@@ -835,6 +872,7 @@ SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show, btrfs_chunk_size_store);
+BTRFS_ATTR(space_info, size_classes, btrfs_size_classes_show);
 
 static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
 						     struct kobj_attribute *a,
@@ -887,6 +925,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(space_info, chunk_size),
+	BTRFS_ATTR_PTR(space_info, size_classes),
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
 #endif
-- 
2.38.1

