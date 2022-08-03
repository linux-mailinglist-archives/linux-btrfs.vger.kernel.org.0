Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D932D589241
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 20:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbiHCS2v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 14:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiHCS2v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 14:28:51 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634652B62B
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 11:28:50 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id h8so12473044qvs.6
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Aug 2022 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbajvgpsvxUlCUU0b5Kl8R24tNd8kf2+SWmfTr3l31Q=;
        b=uhr2vgTVvgjr1D4CN0OWRGkaCeIpFgobEjUTEvjOUCK70s2t6z0TIiqu8lu08Y8AVN
         rS4AyVkTX11wZadwScdMnS+siOzyU6s9GDFFINWpKHmYpXdR2NKaAptaGzCKpJonGlJx
         wNDKEeHuvFm8Nb8FlDFaSDOqmhYyv+E1v3pHrt8x5NMMLR0DXyyRuXASA82RhYNjA7E/
         66crAw6VALLXIueh6LZhxIvY4HBKgecbwVTnESlh67Fg3RVXoaDQ/YWEFOwOEzpC8mjx
         K0zHl2H3LZCDwI1Wlt7jwPpLs1xd4eR5M3I33eFVyc5DUXJ7UnzJ1eWaRU6D04/FYh7L
         /zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbajvgpsvxUlCUU0b5Kl8R24tNd8kf2+SWmfTr3l31Q=;
        b=BMsH0JP6ViaA+pC5dihZoWSbSQThw/s2e/JU8asOCYWbTvYl2APazqQ4gkGmr+B9tp
         RnqR1Ai1NjX+EZrFLcTcxjyGsPEhf89V/nEjJkeUYnaCYIhXRilG/WbyaLzJNwtVQMTb
         gt0Jly3kzgTgxOEZO6Wjse16puAyL++h6BK9UsNmIqu4Hby1XuKfwpYt+2avY4uLM0MY
         bJ//Q0+IDd0FIAVt1gOViDTCDltH/25cv0Faf31iNulMYOCkOhHlYam+fKO0gaqpy+ii
         p1/nZbIL0QjLLGs1M5Ix/NpGRjHLzyjx+loWJ1OAjzipFiXvdGvvPXkjsSR1vlrwft9/
         7V7w==
X-Gm-Message-State: ACgBeo0tNmcvUM6a+ajPxKGSItxmb2RfV1eo59ih90WBBM9KXdFt2TfC
        OOB7eLiODfIeb57f7+lwzX/h6kW+6mHGXg==
X-Google-Smtp-Source: AA6agR4UmI2rB75aTtoGZMpjF9rQL/sz5DmQhsv4+V/TS5iHqpCU4tIY0hq5Osh09VRDqItrzjx7HQ==
X-Received: by 2002:a05:6214:2121:b0:476:a741:92a8 with SMTP id r1-20020a056214212100b00476a74192a8mr11937552qvc.117.1659551329190;
        Wed, 03 Aug 2022 11:28:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h19-20020ac85e13000000b0031eb02307a9sm12672251qtx.80.2022.08.03.11.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:28:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: check for overlapping extent items in tree checker
Date:   Wed,  3 Aug 2022 14:28:47 -0400
Message-Id: <0a9f7ca2717c0378acf77d71a0d1b680d4d5d6b9.1659551313.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're seeing a weird problem in production where we have overlapping
extent items in the extent tree.  It's unclear where these are coming
from, and in debugging we realized there's no check in the tree checker
for this sort of problem.  Add a check to the tree-checker to make sure
that the extents do not overlap each other.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 9e0e0ae2288c..43f905ab0a18 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1233,7 +1233,8 @@ static void extent_err(const struct extent_buffer *eb, int slot,
 }
 
 static int check_extent_item(struct extent_buffer *leaf,
-			     struct btrfs_key *key, int slot)
+			     struct btrfs_key *key, int slot,
+			     struct btrfs_key *prev_key)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_extent_item *ei;
@@ -1453,6 +1454,26 @@ static int check_extent_item(struct extent_buffer *leaf,
 			   total_refs, inline_refs);
 		return -EUCLEAN;
 	}
+
+	if ((prev_key->type == BTRFS_EXTENT_ITEM_KEY) ||
+	    (prev_key->type == BTRFS_METADATA_ITEM_KEY)) {
+		u64 prev_end = prev_key->objectid;
+
+		if (prev_key->type == BTRFS_METADATA_ITEM_KEY)
+			prev_end += fs_info->nodesize;
+		else
+			prev_end += prev_key->offset;
+
+		if (unlikely(prev_end > key->objectid)) {
+			extent_err(leaf, slot,
+	"previous extent [%llu %u %llu] overlaps current extent [%llu %u %llu]",
+				   prev_key->objectid, prev_key->type,
+				   prev_key->offset, key->objectid, key->type,
+				   key->offset);
+			return -EUCLEAN;
+		}
+	}
+
 	return 0;
 }
 
@@ -1621,7 +1642,7 @@ static int check_leaf_item(struct extent_buffer *leaf,
 		break;
 	case BTRFS_EXTENT_ITEM_KEY:
 	case BTRFS_METADATA_ITEM_KEY:
-		ret = check_extent_item(leaf, key, slot);
+		ret = check_extent_item(leaf, key, slot, prev_key);
 		break;
 	case BTRFS_TREE_BLOCK_REF_KEY:
 	case BTRFS_SHARED_DATA_REF_KEY:
-- 
2.26.3

