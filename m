Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E567F0B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 22:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjA0V45 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 16:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjA0V4z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 16:56:55 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6F92E0F4
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 13:56:52 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 278C45C00BE;
        Fri, 27 Jan 2023 16:56:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 27 Jan 2023 16:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1674856612; x=1674943012; bh=hWt71huU3XcQnOfp/9k3431bx
        mr8YamYtcTS2t1IWvo=; b=E72rPjVHXW2274LL5DwP2L0D2vwRRsKlYRQrNnI06
        paaxOJO4H6y+Bv0nrQ/HCU3Hqek9mmIqjIz2U9GdfRCMS/NnL2kkHBqvMz7aWsUR
        7kP0NK5O/ISnTPzn5IAh7qVqgubRQg/xhrC1DFL2ew8hN4jcKGvQLU1sfSajFKrQ
        xGka1Kx2ViOUEGdquqeWS2Diwx6jkMfxot+ibhsd2dLBE8peIGIxhHT4leJvplBv
        4LOAdYwpglGiOfPWxv1uhPf3LEK8knXBS9LQz+3GW+sECfUluTTrZsqSdiOAyta6
        ewvLWb87nJP2IaRo5Qd2dRU3BO3xvTeXVZNDxmOwD+d5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1674856612; x=1674943012; bh=hWt71huU3XcQnOfp/9k3431bxmr8YamYtcT
        S2t1IWvo=; b=AwtX1lcBGdcOr3WTdst4SDqU9vX3rC27Swp7CmC8YVipBgtK73r
        ImZKxpoIzOhHSGqe48HtugKrfFxj39r+zT4j0W9E1TGUWuNQp5yPy8cijTchoKt/
        lMF4nS4s66Xf/RCIqTCof03xaoYqlXfAs7iI/KJFqYxrEAl4AvsSHfeDW8v2v+qT
        H00bCbAvfRlqqwadCm5OLrl/e9DuIMcnO7cfyjZCiXDb8M+srYDHrGnS3PTm8C6w
        iV5Vh2FShCXtrp8ridKLH6FIA+yNpqd+vgK8MEPVxJQRgOuRZQ4f0NkTbJIWc+FB
        mK8rrO4ryB4p68kWpopl706OqIVhgyscl1Q==
X-ME-Sender: <xms:o0jUY2nygeXrq5uo91aBV5Z7nhuTHOEo0ubVSbcfaX6_n1B44gwG8Q>
    <xme:o0jUY92o4EbS3EVI7I_UpneUMOdPnbGlzdh7IbPTz-OjByGW_gimIlyVAmkzRRoBQ
    H_TsIh5Htq6gxSapww>
X-ME-Received: <xmr:o0jUY0rMek5JdtEjsmdf3HaQQvcgRxq22PBaW0MP9YummQtzMjcbPA1j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:pEjUY6nj7oIbAe5z-KUSWOOhE2J1wxU7KZqwaJhdGMANOzT6jt1dSQ>
    <xmx:pEjUY02JUAoT6xxhhtfrgHhLQ4azuV5toMp_mrGh7y1JoYp2_cNdjg>
    <xmx:pEjUYxtAiJnzY3fQm-x0w3UKmMXvMLb-POu7cFD3EJxBBvrPkrBBcA>
    <xmx:pEjUY59otQcUjyagVVZTburcRSDZuy9RuTcpnERn3fokVyqMFXrhRw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jan 2023 16:56:51 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2] btrfs: add size class stats to sysfs
Date:   Fri, 27 Jan 2023 13:56:50 -0800
Message-Id: <5c4fcf99c1486e6c2c2c45f11ade73d40f153021.1674856476.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
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

The new stats can be found at the path:
/sys/fs/btrfs/<uid>/allocation/<bg-type>/size_class
but they will only be non-zero for bg-type = data.

Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v2:
- add sysfs path to commit message
- unsigned counter types
- labeled stat-per-line output format

 fs/btrfs/sysfs.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 108aa3876186..639f3842f99d 100644
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
@@ -778,6 +779,40 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
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
+	}
+	return sysfs_emit(buf, "none %u\nsmall %u\nmedium %u\nlarge %u\n",
+			  none, small, medium, large);
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 /*
  * Request chunk allocation with current chunk size.
@@ -835,6 +870,7 @@ SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show, btrfs_chunk_size_store);
+BTRFS_ATTR(space_info, size_classes, btrfs_size_classes_show);
 
 static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
 						     struct kobj_attribute *a,
@@ -887,6 +923,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(space_info, chunk_size),
+	BTRFS_ATTR_PTR(space_info, size_classes),
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
 #endif
-- 
2.38.1

