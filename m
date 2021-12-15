Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D749D4762E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhLOUPB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhLOUPA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:00 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE41C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:00 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id d21so13940736qkl.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bILpRxaXVtSivki0j67kMtat5wsYun7eiyHt0F+9IRY=;
        b=uC3X0mc+s7PxjrxZ7lbS0dfGEhcrxNfNMBEgNv84GIv3Ztrx5RMWUX8EupVDJIG5Cv
         QS3bhERDhPxGty1StIiZR+vPMY/o9euDKIFKJLAwlCuCtej4fQrpYRHJMB4kFJ1GOoi5
         yz8/FDb9O7lt4rsjK6d8bFm8Jaa1hdHUih6XBhl37BpPVl6oWJs0EmW1Ete3Xn83bgzP
         F+8kRdANNs7M//Wl2q44BcwGSXRllBgv27X+jdWiXNToXsBMQ/ZmpaglKfjFw1xqZpdt
         Ab2yU4YDIi77f2JVG4aqzS8hxo8AvZEqNEaf2t88eXdnM0yscj4YTsCKPNRSxaZjzn6p
         qVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bILpRxaXVtSivki0j67kMtat5wsYun7eiyHt0F+9IRY=;
        b=bLeXK9J3tVxOHrsOtg33O2NCSG4k/x/F5l8DKxz9kkKvSTL9ihPUYkdcv98Oot3g+r
         e16kaWMF2ln1y4Dj28A8hdarDzLxeqRZa43FwGaeSvMRfigZS+gBvuM+0dRmxRoWRmqh
         0zRyG+UJU2lN6N3f3dpoY5VUUPfihM66EUXetWbhYl8epSxX+KkjEmk4UBxc1/0DKU4l
         JC+2vfmJYFedOu1FsUB9dLigAL0DlHhuj4DSgeOdufo8EmpEWBjnQGKvjRBY2s1KV432
         iexYG/MMWC+kgKmCnJZgfttE5QAdLuuKnwbb2h+/zK8zcqNbdtc7lw6G1juI6HwynYOO
         g5QA==
X-Gm-Message-State: AOAM533pSWbxGW132rmt7eYtj4praCbc/ezq2vWOyr2zJXUvwnglh/Ic
        tlw9znbQ3djjrVvmKOP544vuugsflXXT6Q==
X-Google-Smtp-Source: ABdhPJzYBl3AK/SMNAVq8oRPfc4aUeXGEpNxAmhj8vSQn3xRZ1qQ7XIULmZozQYRZOgfhNJeJz/6mw==
X-Received: by 2002:a37:6509:: with SMTP id z9mr9948534qkb.583.1639599299357;
        Wed, 15 Dec 2021 12:14:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j20sm2202442qtj.43.2021.12.15.12.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:14:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/15] btrfs-progs: check: skip extent backref for metadata in extent tree v2
Date:   Wed, 15 Dec 2021 15:14:41 -0500
Message-Id: <a4fd18f4dae8c39922cd8b149c4b8e04008ed63a.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do not track backrefs for metadata in the extent root with extent
tree v2, simply skip adding the backref object.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/check/main.c b/check/main.c
index c522116e..ed38709b 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4804,6 +4804,13 @@ static int add_tree_backref(struct cache_tree *extent_cache, u64 bytenr,
 	int ret;
 	bool insert = false;
 
+	/*
+	 * There are no extent references for metadata in extent tree v2, skip
+	 * this.
+	 */
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		return 0;
+
 	cache = lookup_cache_extent(extent_cache, bytenr, 1);
 	if (!cache) {
 		struct extent_record tmpl;
-- 
2.26.3

