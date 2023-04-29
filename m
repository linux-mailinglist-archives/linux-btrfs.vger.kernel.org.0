Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7706A6F2652
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjD2UUk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjD2UUe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:34 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5448E77
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:33 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54f8af6dfa9so20301177b3.2
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799633; x=1685391633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3o8quIZ2qw7VXGH9TgH15X7BhGRwXuhJtg12h5dinI=;
        b=HTYWW8dsAIoWDQZ+zu4PCVDtvJdjpMB7MxnNtDKH3nRhhsJ0QwEUEej3H6XSuCvyTO
         IoPeltdIGcUiD3U34Ag8w1obxxNt2h4zOak6nuzCS9/TPf9B/Q17Uogx3cv+uNUnupS9
         S3VsuzsQ7WNy7FpmvWOIfxI7uy0LvAXTJVw3CrbtIIetVSkwCkCG6oEI061GhAZGX0R9
         YFC25CjBQbDub35nWVdbsTL5cmaEpOEH7hIUrAvDApuJC1O/b/Hg/c+3fSC5sD9H/5KO
         5nu3o/eoMC4u7ii6lnQXOgp9wGNynEnroOB0YU8ETu7qO3L/hY2Anci5LorY76giHaZL
         Afrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799633; x=1685391633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3o8quIZ2qw7VXGH9TgH15X7BhGRwXuhJtg12h5dinI=;
        b=OxI6LuEaz3QgtFGAf99aUl1o4QOlaNeS2LRJkYssZLeWhQ8ZH6JkQhaCUeiyZZdcjt
         XwIrSFATZ03jaeqKyW8RfZr8pvj1mP+puIf3vv2ydlkQfItiXaSxu1vQgWujCzavmofT
         zdmrTyutU5AluNNjm8JppazKAL7aK70M9xiYqXdRYEFtrpc5TpKh4YIDE+Mzbua50fHG
         FT8ecciyBmTg5drSLRo+bNdd7Ojlsy1ehBdH/OsJvmAHR3So1pcuOAsuPRAFIhF/cQlb
         BH2NnBfplh+yOipYqr+E9pgBzfuDahBiB9koRlGfLEkndIYiGlwKc1vyGsBgb2/qrddh
         GnyQ==
X-Gm-Message-State: AC+VfDw3upeYI4IgJS6dB+Rc3NI93wilIZQ5O3osoILgfEtW3UNWwNgr
        2fTnvIn74xiYfVD9QjcJXrMBgkndTFP/qekJZwmACg==
X-Google-Smtp-Source: ACHHUZ56IdXN+qyv1/F55xTVO9gHDvhG8701WujxRz4aMh3wUAGOcYd/jODCnCTkIztbfGd0rfvgLg==
X-Received: by 2002:a81:498d:0:b0:54f:b4eb:bc14 with SMTP id w135-20020a81498d000000b0054fb4ebbc14mr7591986ywa.3.1682799632918;
        Sat, 29 Apr 2023 13:20:32 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d201-20020a814fd2000000b0054f8b7b8514sm6250773ywb.128.2023.04.29.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 25/26] btrfs-progs: init new tree blocks in btrfs_alloc_tree_block
Date:   Sat, 29 Apr 2023 16:19:56 -0400
Message-Id: <816212e82d57a67fdf9b741ab0621ab7f12b57ab.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is how the kernel initializes blocks, so anybody who uses
btrfs_alloc_tree_block in the kernel expects the blocks to be already
initialized.  Put this init code into btrfs-progs so as we sync code
from the kernel we get the correct behavior.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index e29a1cb4..6da30011 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2559,6 +2559,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					u64 hint, u64 empty_size,
 					enum btrfs_lock_nesting nest)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_key ins;
 	int ret;
 	struct extent_buffer *buf;
@@ -2579,6 +2580,14 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		return ERR_PTR(-ENOMEM);
 	}
 	btrfs_set_buffer_uptodate(buf);
+	memset_extent_buffer(buf, 0, 0, sizeof(struct btrfs_header));
+	btrfs_set_header_level(buf, level);
+	btrfs_set_header_bytenr(buf, buf->start);
+	btrfs_set_header_generation(buf, trans->transid);
+	btrfs_set_header_backref_rev(buf, BTRFS_MIXED_BACKREF_REV);
+	btrfs_set_header_owner(buf, root_objectid);
+	write_extent_buffer_fsid(buf, fs_info->fs_devices->metadata_uuid);
+	write_extent_buffer_chunk_tree_uuid(buf, fs_info->chunk_tree_uuid);
 	trans->blocks_used++;
 
 	return buf;
-- 
2.40.0

