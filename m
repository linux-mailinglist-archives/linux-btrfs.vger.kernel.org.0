Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75552A0FE0
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgJ3VDV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3VDV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:21 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A0C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:21 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cv1so3428670qvb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dKsLAVRFHOF79R1j9NWyn3sHXCaDSRbE0s9vqh+FgYo=;
        b=kBvc9M7VZ40AxBXSf7Q4MLQHNxit0ShUo2zJVMgxj/wHFfaIr4hE+IdIp7CWD8/fD2
         +BGxbKY1d4fQZ3ZyI3cRUFd1QG/v6P5A6phAfqM3Hv1T11BwfeK1w5r8unP1Um/L2XX/
         ftetSW4RVrCA06uFHWJNp2pqc4ebxVNnfUprB7sdYq917N+y05HkrFxa5D4eRtpTNqE2
         isG8BzznFi30yo5hDYniXqHW26Qt7b4Ku0URs6YxKjfEEZ/IeIe1ixtqPC18ADbEYpxN
         a17xsG1IHmn0u8HMk6Tnl6Tl9CNiiSPUY5NckZmb32VMgsqQzhXwNwljWl1yXxDuyDQh
         4zqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKsLAVRFHOF79R1j9NWyn3sHXCaDSRbE0s9vqh+FgYo=;
        b=K2XkyJtIpaAtkgwVfrsLTIQICX4tqkmDU4/85xgTjixv5KHvJchWk8BZ350QN2VyBl
         GMoPoL0MsIFQcTXxG0Nm+fYOp2ADseTL69dQARyUB/0RBL9vgFtRVjC69tZQFnuv1Z3v
         SxP8TvVRtpL3x+I8K6DtRpNaqDjFYTK8vuYFytWmfvfClW+Cuv+VvSTsl8h8pIFETO89
         d6Vb8y0QofQ7+3GA8OKbO0GzdZTQTli5sYU6Y6Y5NcZFQb6ICZIHpHSbhFVvTwzUxb+1
         Hz38LCslSr2fNcwOTh9S/nl1eZtiXIp8i6KkApiLScfIKhvAoJcCorO16SmmO4j+uTNw
         PDKQ==
X-Gm-Message-State: AOAM533X3MJyLdnNbcVjVuQeDixIe0Z55f39ZcwGoN243z1ZV/KhqxKP
        KO31hDqq60QfoAYWW1gEViatpvF9/xuYxSBK
X-Google-Smtp-Source: ABdhPJxlDg1Et4eugd8oZyZaj4hDrK2ZY/2VE//wSov/lo8Bn+7Wud2goaneVYQbGcn3/aur9VpD8Q==
X-Received: by 2002:a0c:9e6b:: with SMTP id z43mr11026326qve.51.1604091799985;
        Fri, 30 Oct 2020 14:03:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k2sm3374334qtm.22.2020.10.30.14.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/14] btrfs: use btrfs_read_node_slot in replace_path
Date:   Fri, 30 Oct 2020 17:02:58 -0400
Message-Id: <63ebff2a4a7195cd8ad3e19ae4dc981ea8632ac1.1604091530.git.josef@toxicpanda.com>
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
 fs/btrfs/relocation.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 874ae92c0df4..55a745cb28d4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1220,8 +1220,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 
 	parent = eb;
 	while (1) {
-		struct btrfs_key first_key;
-
 		level = btrfs_header_level(parent);
 		BUG_ON(level < lowest_level);
 
@@ -1237,7 +1235,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		old_bytenr = btrfs_node_blockptr(parent, slot);
 		blocksize = fs_info->nodesize;
 		old_ptr_gen = btrfs_node_ptr_generation(parent, slot);
-		btrfs_node_key_to_cpu(parent, &first_key, slot);
 
 		if (level <= max_level) {
 			eb = path->nodes[level];
@@ -1262,15 +1259,10 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				break;
 			}
 
-			eb = read_tree_block(fs_info, old_bytenr, old_ptr_gen,
-					     level - 1, &first_key);
+			eb = btrfs_read_node_slot(parent, slot);
 			if (IS_ERR(eb)) {
 				ret = PTR_ERR(eb);
 				break;
-			} else if (!extent_buffer_uptodate(eb)) {
-				ret = -EIO;
-				free_extent_buffer(eb);
-				break;
 			}
 			btrfs_tree_lock(eb);
 			if (cow) {
-- 
2.26.2

