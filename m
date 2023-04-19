Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B4E6E8393
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDSVXp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjDSVXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:23:44 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F122E6A66
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:23:22 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id gb12so642138qtb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939263; x=1684531263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ksq8LnPUyd2VA7eDtt0QHlRpPKRWB2/v6YOoeF68kiQ=;
        b=QG0/LUvbO4K2kgoWiTuTPD9sUSfUYojm4ORSaJvoYFkyz7Q89xTbu6S/+FhbJhfRPm
         yFYIjS1XIkUiKJK/rSdZE5XWFoQB1Lg4QfCKXpRKZMLmLQ3udZsgaw9sxsdbJEZVqsDl
         fwr6Hq+AhlBU0e3hb7AbIPixI40g6I6+zhANM9zUfxkoCTN+LfN05COeMdk4ugOdaHK3
         EjIjqHeRECjiGldXhN9Ir0w5wEu2bSwQb6l/yD3xGZvLr+H+nqbDoF+xVaM4E4FNnnhh
         ezcQV+BoG0OscTRSGx60YJU/0h3RNm4iBYRqUCpG8vWwwnubscOoBpofR5A7/xfb7YVk
         7GWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939263; x=1684531263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ksq8LnPUyd2VA7eDtt0QHlRpPKRWB2/v6YOoeF68kiQ=;
        b=hgJT0EwP3xSytcfzlaYXCsuNr+E9Py5OVKj/T86d5w5wznRmEbqDq2xi+kzE/t3BSQ
         jn5eEHEcdCfpZaeCZt1MDBeWF4rI31Y94uDrH9TUfgOhVgQbFAJZ/40WJVxwbDDA/W/G
         E+w+0eH01Ynd7lQU2FYOll+Q/Z11TSMc7IZrokkX8Dw2JQEnNFc2RGX/okB6AeHyV2PJ
         A/W1XtMTQNB+gUif+FFX/cMSWPqJqVWX1a1Bnuu6K04elpYqDb4R7LTqHLtIS2ldkXjp
         lNi2XldFcyqTtfJTcEULgGOflKJhTuPkHjtivTM1o09M77srOUhPT6sTw8bFQm2mhzf3
         I8Rg==
X-Gm-Message-State: AAQBX9desAwV9wIHM6R2NIuIZjbOiY9b7/FpYCK1gw072+6GO9QZEiNG
        /ZRPNMuN9SnhqdSS6POvBca9e01bfdg8791COul33A==
X-Google-Smtp-Source: AKy350YnqqW/if0E/PxpWF/IGui4F7zepnRMkH01N/PaXkH3HQwEKiZyR7X8dc4/wklDYpjPHjPAJw==
X-Received: by 2002:a05:622a:14a:b0:3ef:20fc:6f99 with SMTP id v10-20020a05622a014a00b003ef20fc6f99mr9093450qtw.49.1681939262886;
        Wed, 19 Apr 2023 14:21:02 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a288d00b0073b8745fd39sm4906873qkp.110.2023.04.19.14.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:21:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/10] btrfs-progs: rename btrfs_set_block_flags -> btrfs_set_disk_extent_flags
Date:   Wed, 19 Apr 2023 17:20:47 -0400
Message-Id: <9ac26c031920b4f4dad3edafe10cb0fd783f9c0d.1681939107.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939107.git.josef@toxicpanda.com>
References: <cover.1681939107.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This helper in the kernel is named btrfs_set_disk_extent_flags, which is
a more accurate description than btrfs_set_block_flags.  Rename to the
in kernel name to make sync'ing ctree.c easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c       | 6 +++---
 kernel-shared/ctree.h       | 4 ++--
 kernel-shared/extent-tree.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index cad15093..e95dcc79 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -419,9 +419,9 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			BUG_ON(ret);
 		}
 		if (new_flags != 0) {
-			ret = btrfs_set_block_flags(trans, buf->start,
-						    btrfs_header_level(buf),
-						    new_flags);
+			ret = btrfs_set_disk_extent_flags(trans, buf->start,
+							  btrfs_header_level(buf),
+							  new_flags);
 			BUG_ON(ret);
 		}
 	} else {
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index f416fc36..aaace45e 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -859,8 +859,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info, u64 bytenr,
 			     u64 offset, int metadata, u64 *refs, u64 *flags);
-int btrfs_set_block_flags(struct btrfs_trans_handle *trans, u64 bytenr,
-			  int level, u64 flags);
+int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans, u64 bytenr,
+				int level, u64 flags);
 int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct extent_buffer *buf, int record_parent);
 int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 916eb840..8a6ab996 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1375,8 +1375,8 @@ out:
 	return ret;
 }
 
-int btrfs_set_block_flags(struct btrfs_trans_handle *trans, u64 bytenr,
-			  int level, u64 flags)
+int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans, u64 bytenr,
+				int level, u64 flags)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bytenr);
-- 
2.40.0

