Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDAF2A0FE2
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgJ3VD0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3VDZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:25 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BF5C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:24 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cv1so3428764qvb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WMUbVGZ7vNT9aaXRMWfM9y5LnBlAxY8h1QiNSBsIprI=;
        b=JK87gXBeH0oxvU2LkdCauncrKA8+ZYMdorYGWMrb/qS8tcFt3czpQn3GMQCi9vkNrT
         Ugf3A6jkDgp6c4yq2pqEbvwTru9ETAN4sS1WnP+73eTAj2/OlEfSj+JOIO1v3o1ZtVyQ
         zIBl+Z9BQJBu2FnIj+8iVE8RzViOAeM2SmEOaKv3Lm63x+R+C916KvGtqEyjDYXZ47OW
         dv2uhg0++r3eHeYnQ2JG094dgRawLcm8U3NZn799xt6rggMN/pBU8hn8NAXhfY8TNzJw
         TKhWsGYFWyvxyawDOYAw+2goPbcim07z28ljNdluma1Z5JxYILhdrBgHVqj1N2D4ZxoC
         To3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMUbVGZ7vNT9aaXRMWfM9y5LnBlAxY8h1QiNSBsIprI=;
        b=UcJku1ZGMtlAFybEb+Hl3Iddf0npeDssieWEbdevkuX7tB2cHiDRonGonCUokAoKG/
         Btkmg8mKoNNviO6IphVGtDJMUYHi/Q/dskBaNkO/X1VJJ2cpVZkgm0bjtJ2LI0SZvpfX
         qLwWzRPYwUqab4/rqpVgmmI3YUUd32oFxNQf1Y0OBLmAicLvLZOCrQuLXyNcr+6OdqbR
         lB9YMGDEc+o0AQVvisIn73QF2QmauCwoV2FaZP/czEkq/UfTmRDg7WQFBE1gDVBFWPUO
         JgpGpRmQJK8t+/QFVwNCXMBkl84q7K/AejuKfv06dvVcRdIs/1xsKu0tmU2u8PLm7iPT
         mRuQ==
X-Gm-Message-State: AOAM532a5sJjZqilAHwkofYiAqMnNznXMAJTPp3XAj73/rHIhqhs2c5P
        KAOh70F3GIhS65EALOImPht7tqFvYR/SAcW9
X-Google-Smtp-Source: ABdhPJytp6wNVaiLrHgK/uj/h2JLttW1AhUMms/m9MkfmqmLjggyJD/uwTooSFyyTcZToNDKesHhhw==
X-Received: by 2002:a05:6214:209:: with SMTP id i9mr11485484qvt.38.1604091803584;
        Fri, 30 Oct 2020 14:03:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n201sm3399812qka.32.2020.10.30.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/14] btrfs: use btrfs_read_node_slot in qgroup_trace_extent_swap
Date:   Fri, 30 Oct 2020 17:03:00 -0400
Message-Id: <2ce778346135ceaf868dca5ec26c4dfa0846853b.1604091530.git.josef@toxicpanda.com>
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
 fs/btrfs/qgroup.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 77c54749f432..f009beeba385 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1894,27 +1894,16 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 		struct btrfs_key dst_key;
 
 		if (src_path->nodes[cur_level] == NULL) {
-			struct btrfs_key first_key;
 			struct extent_buffer *eb;
 			int parent_slot;
-			u64 child_gen;
-			u64 child_bytenr;
 
 			eb = src_path->nodes[cur_level + 1];
 			parent_slot = src_path->slots[cur_level + 1];
-			child_bytenr = btrfs_node_blockptr(eb, parent_slot);
-			child_gen = btrfs_node_ptr_generation(eb, parent_slot);
-			btrfs_node_key_to_cpu(eb, &first_key, parent_slot);
 
-			eb = read_tree_block(fs_info, child_bytenr, child_gen,
-					     cur_level, &first_key);
+			eb = btrfs_read_node_slot(eb, parent_slot);
 			if (IS_ERR(eb)) {
 				ret = PTR_ERR(eb);
 				goto out;
-			} else if (!extent_buffer_uptodate(eb)) {
-				free_extent_buffer(eb);
-				ret = -EIO;
-				goto out;
 			}
 
 			src_path->nodes[cur_level] = eb;
-- 
2.26.2

