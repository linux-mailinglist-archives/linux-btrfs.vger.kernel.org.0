Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE76986D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 22:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBOVCW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 16:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjBOVBw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 16:01:52 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988B8234F9
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 12:59:56 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E1B3A320098F;
        Wed, 15 Feb 2023 15:59:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 15 Feb 2023 15:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1676494795; x=1676581195; bh=kB
        t99LsxkdDNHk35DIiv7BtevojIx5IKtFuJHxTgYuw=; b=b2ebEzdrzK3MjN8lE8
        M5oBRrPHToOUTrcSS7vZS3MJeeR1hTWw5Cx8+PdAh/pme+k1wOyDTTuxvZEX2PNZ
        dCdcw/UvChIPrk7QYSOJZONAfy5Gp27nrnDwze7U8KMJ+JYuOtgL31Ii9pesh8qM
        82bd/7brZSdrxBVc1437SbzSw1oMr8viX44AAjK3wQZnX9n9xqnBftlrcB2lMA2j
        dnLu96cDaG4LMWJRDTosEvwXZv5j6LC6pUa9CuFX6EATzJt4DeQKqyznOEh8htK2
        x2LgDGlDZJT9tCBCfUhVWfHBcseu8Y0Nqqx8SMm6FznGZYiwy3Q2l3QAv95aKeG5
        U4ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1676494795; x=1676581195; bh=kBt99LsxkdDNH
        k35DIiv7BtevojIx5IKtFuJHxTgYuw=; b=H6TRuWQU8pTfI265y36Yp4f5AY931
        57zaMx5dH3POO50s2qIQ22HWqpan1wqWyv1kHtVJbIVF1DhN4EwJenntHLGr/IUb
        vTsETCo56Ooert7udsxdDb84Gfk7n/68bv9JryIxeTrYDY1Fc+cLZ8B3doWQ62pw
        FhHNy2YZC3rxWm5cIqJwQ6bV/1+o7z/KhNFQIen/trqIKuLQS/EQWRxNW9vvP7Z3
        XKYXusJ0btrV0ECS3u30lLOdr50PVEEbwKH81UWHFbSdlyiKwz8JSptNkwlIqrjv
        aTShpZIiu8UJf+8yu7+QOl/rIWKEkP+Fyvk4hxG0TWS+iW1A1Ky0T60cA==
X-ME-Sender: <xms:y0ftY-VdcW8cS8U6GocsH9BumLWpeA4cCnBwzQ_3bCvu8KWMEcUDCg>
    <xme:y0ftY6nUsrq57rJPfB3tJf5Pmeecy4ZK7EupmwG4wsuNr_HAngmxFjfD7be9pA1P0
    -pGic5XFx-Wp93aGTQ>
X-ME-Received: <xmr:y0ftYya6YLq8hHLQp3rZgFxr_cHWN228v1WgwnF6H3QDh_Ayv1zsTlT4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:y0ftY1XSWBYI6xMW_xVk53RmLs96Ipne1maGxS5MnusOSO40Mub1AA>
    <xmx:y0ftY4mwaSnUafMPvD2Jn0Vp2EPXQD_xtP3gp89-QzcpK2gYBSKAkg>
    <xmx:y0ftY6fczaNvCgagt-IqkK7LV7b8riCGVvV-xrLPvlmQAYUbahzS_Q>
    <xmx:y0ftY_u14MOC4-xBidQWXVPwRBAjgukNlZEM5IpilcyNP6RtN5MjnA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Feb 2023 15:59:54 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 1/2] btrfs: add size class stats to sysfs
Date:   Wed, 15 Feb 2023 12:59:49 -0800
Message-Id: <2fff5aa06edf1387677bdb1329359295c6d38506.1676494550.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676494550.git.boris@bur.io>
References: <cover.1676494550.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make it possible to see the distribution of size classes for block
groups. Helpful for testing and debugging the allocator w.r.t. to size
classes.

The new stats can be found at the path:
/sys/fs/btrfs/<uid>/allocation/<bg-type>/size_class
but they will only be non-zero for bg-type = data.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/sysfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 8c5efa5813b3..4926cab2f507 100644
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
@@ -778,6 +779,47 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
 	return len;
 }
 
+static ssize_t btrfs_size_classes_show(struct kobject *kobj,
+				       struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_space_info *sinfo = to_space_info(kobj);
+	struct btrfs_block_group *bg;
+	u32 none = 0;
+	u32 small = 0;
+	u32 medium = 0;
+	u32 large = 0;
+
+	down_read(&sinfo->groups_sem);
+	for (int i = 0; i < BTRFS_NR_RAID_TYPES; ++i) {
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
+		if (rwsem_is_contended(&sinfo->groups_sem)) {
+			up_read(&sinfo->groups_sem);
+			cond_resched();
+			down_read(&sinfo->groups_sem);
+		}
+	}
+	up_read(&sinfo->groups_sem);
+	return sysfs_emit(buf, "none %u\nsmall %u\nmedium %u\nlarge %u\n",
+			  none, small, medium, large);
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 /*
  * Request chunk allocation with current chunk size.
@@ -835,6 +877,7 @@ SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show, btrfs_chunk_size_store);
+BTRFS_ATTR(space_info, size_classes, btrfs_size_classes_show);
 
 static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
 						     struct kobj_attribute *a,
@@ -887,6 +930,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(space_info, chunk_size),
+	BTRFS_ATTR_PTR(space_info, size_classes),
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
 #endif
-- 
2.38.1

