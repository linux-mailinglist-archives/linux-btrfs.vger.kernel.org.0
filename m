Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBA22A0FE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgJ3VD2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3VD1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB3EC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:26 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m14so5124903qtc.12
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=o/bz1iIWHTfbrqVDCQV3PVmyOtuMZXS2SbpHpZVesTQ=;
        b=VY53MwRpRP+8rLf05KILsDT77OT0ugyiefi0/pobGcYuhBgX+t+czUMFZWUQY3zS3S
         5Z91P4uJweBHMlWO28UZAGezrVPFBLE4zyvLUnYP5WSah9xj2jU3/tWnwEyg2Zx9LAEz
         w0MGhz4dJNwqsW0NvpgqqOl5+hF2M13FEGDctUv+X92ULPejId5DLUu3oJz5mHNZF1py
         K0Rp36yikESmdRjd7ebUqL664H54h8lHITHGgJ78ms59PReIt8NUMRKjtHVuHpgvYRqo
         PI73Cnp586QMefZHwwJ+xgelyicVrosUMJquE+PqFfwA1ednJ2bfdiybcY4+8NRoBOyv
         STOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/bz1iIWHTfbrqVDCQV3PVmyOtuMZXS2SbpHpZVesTQ=;
        b=mwhh2iJYJHXsnaPCpHRsHnA61flMd/5/S+XhgKAhe5zPjptbq1oBRELnvRJGwejPu2
         zgpaYN/hDqhQPsplazQp/dt+Rr78JQWA5T1L0SwwWxOxr1t44LuR6SIMJkIkVnCkJDNP
         lLoMvIPyxBHDNJno9IowJuIfuS322fOmkWzhSLnAZz0HpsqG/WKgA18Su5LzVwLxZdGn
         SAHwkpRJAR4u6VgBdyoTzQsnlxiNKrY7Vihu3lMG65jTAYIM5dN1GhXLoiMuXDBjnXTx
         1DqFjGjWGZ5iXaWEBaavxqP/0KYIz3MSj4RgG7IlZTExtHM2jklCrxxZLhZ8uq+z0+Fk
         gRoQ==
X-Gm-Message-State: AOAM533THoWmIIumtmuhWaJp59CAGJZHfzO7AUC4ejoCyE9lKMKh2Byy
        NXhzV6jFqzsnHVvyTAuHsvYxQgOvbP4baJ2F
X-Google-Smtp-Source: ABdhPJxylZICDS5JMoexbY4JQFyQU5XsjRjvN4tIMkwzuBYZNcmE9XJVcCWiD1J2081g3NxwIfw02A==
X-Received: by 2002:ac8:7454:: with SMTP id h20mr4082361qtr.34.1604091805365;
        Fri, 30 Oct 2020 14:03:25 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z6sm3253866qti.88.2020.10.30.14.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/14] btrfs: use btrfs_read_node_slot in qgroup_trace_new_subtree_blocks
Date:   Fri, 30 Oct 2020 17:03:01 -0400
Message-Id: <35706903f3ff92e0e2a44b9d2c468149b85380bd.1604091530.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604091530.git.josef@toxicpanda.com>
References: <cover.1604091530.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're open-coding btrfs_read_node_slot() here, replace with the helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index f009beeba385..ddd1cd6db6c4 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2005,10 +2005,8 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 
 	/* Read the tree block if needed */
 	if (dst_path->nodes[cur_level] == NULL) {
-		struct btrfs_key first_key;
-		int parent_slot;
 		u64 child_gen;
-		u64 child_bytenr;
+		int parent_slot;
 
 		/*
 		 * dst_path->nodes[root_level] must be initialized before
@@ -2027,23 +2025,16 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 		  */
 		eb = dst_path->nodes[cur_level + 1];
 		parent_slot = dst_path->slots[cur_level + 1];
-		child_bytenr = btrfs_node_blockptr(eb, parent_slot);
 		child_gen = btrfs_node_ptr_generation(eb, parent_slot);
-		btrfs_node_key_to_cpu(eb, &first_key, parent_slot);
 
 		/* This node is old, no need to trace */
 		if (child_gen < last_snapshot)
 			goto out;
 
-		eb = read_tree_block(fs_info, child_bytenr, child_gen,
-				     cur_level, &first_key);
+		eb = btrfs_read_node_slot(eb, parent_slot);
 		if (IS_ERR(eb)) {
 			ret = PTR_ERR(eb);
 			goto out;
-		} else if (!extent_buffer_uptodate(eb)) {
-			free_extent_buffer(eb);
-			ret = -EIO;
-			goto out;
 		}
 
 		dst_path->nodes[cur_level] = eb;
-- 
2.26.2

