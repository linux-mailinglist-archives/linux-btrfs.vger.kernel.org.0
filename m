Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6EB4762E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhLOUPA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhLOUO7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:14:59 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26858C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:14:59 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id 8so23100242qtx.5
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IU26d6NARysVXRmiAZpUKB9PDS4gjM34Bct7yUbHRE0=;
        b=M+iQ6i3QLmXd0fYDhumVGbSqi9CCugXNcQPMWvZzI+LfG6ktdUwScLhr9mAhwkKovj
         RmI6zthpmOWmHXbXURfbonWkRDTJKiG3OQqsJk7noX2oDBc+8sw638+jiZIa6L4O8sVi
         5Qq+DF+rSUJLdxU5xkwQi6UaE1lkKb0LhEpes0JdnPiOv/M78PRrBp0J9RlacEcyBkzv
         tPVezM1QJ1h4sXWxj3dFR19FD0FOcuwgNIBVsJhpY+5d+IatCsT40Mq0tVji9S2OGjlp
         RILGeXU4HaWjWum5kuScrdrafSBE3riQdQPCOfSzBs8105v+0Dc3flLS+fQDWO7NYLxA
         N6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IU26d6NARysVXRmiAZpUKB9PDS4gjM34Bct7yUbHRE0=;
        b=pr/vukKl1fiuqrQcrPoGX9nyB4DkB93QG8YTJXvoQbsJXpp/Ablc52QOodTXDhq1Nf
         +F7zeOcqCMAtWHit/yLDpohemgAeWQnb98FdvsyRjXIBJQ7MHHfRRXRYTTvmapnnL5/Q
         J+sz3H/RMPgu9r44ZCXOYgL4uBV2ooOH3Wmmt0zxwjJYCCg55YfMnw6N2n4OtoSOWAiO
         GOjjqqE152fJWoG/wMQI0POZQK6vtI1aW6A9PRxhdHuhMCjnthVBUe9uD/LJMbVp21NN
         n/Nw+5yXD5PODwxeY4F5PvQMuMFkzKmLa7p0FNb8i10BzEnzRyhHMLNVJ/aOM3Z2OyW0
         /I2g==
X-Gm-Message-State: AOAM530FwNRQ/yuq+K0VM7smSnzSvJCyPyyzF3OjttOZSv6DSzBkk5U/
        MZSkAMwIx8hRLFNzmWlHSe9aMRwDNk2ZuQ==
X-Google-Smtp-Source: ABdhPJzWLpvYCV5UUB9bfJV6YB06jwiy8c2s4xqVWBNFhLojJq7xhxJsMCNRcUvZaOA6wybpBDz4cw==
X-Received: by 2002:ac8:5f52:: with SMTP id y18mr14146380qta.534.1639599298067;
        Wed, 15 Dec 2021 12:14:58 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t15sm2320143qta.45.2021.12.15.12.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:14:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/15] btrfs-progs: check: skip owner ref check for extent tree v2
Date:   Wed, 15 Dec 2021 15:14:40 -0500
Message-Id: <5fa67a0628f41f822675a956770beb7e009e35d5.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do not track extent references for metadata in extent tree v2, simply
skip this check if it is enabled.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/check/main.c b/check/main.c
index 0eab91b5..c522116e 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4102,6 +4102,13 @@ static int check_owner_ref(struct btrfs_root *root,
 	int found = 0;
 	int ret;
 
+	/*
+	 * We don't have extent references for metadata with extent tree v2,
+	 * just return.
+	 */
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		return 0;
+
 	rbtree_postorder_for_each_entry_safe(node, tmp,
 					     &rec->backref_tree, node) {
 		if (node->is_data)
-- 
2.26.3

