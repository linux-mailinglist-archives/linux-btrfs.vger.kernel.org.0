Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A036F264A
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjD2UUK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjD2UUI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:08 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306D6E77
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:07 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9da6374fa2so838203276.0
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799606; x=1685391606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApFbhI/fHYAer2NanadPAfLYIZhU2eINRXfKeznF/So=;
        b=y9yiz/HMBfJo799nGYVhml+S5AcmSySsfHaYvv32B+GTpomvcjO+Nz1d2iYrD/OkB5
         p3Ml9CXsf5gmGSfU/cx1Wf+KlEvH6ljyADDJ1/699d8MsKqmJEiHTzmW/Qx2LtmGv267
         CMuYhZ7g0GQBDmK9nujr93HLYD3jRbDwlGsqBL5BzPkaRHl1UESH5ClhPNuJytB6a4bE
         OGyJ6+aTQITsz7DGxL6hJR7DmNMUXyFGnW1puwXrdTazeUET/EjZFTqyv9TPnMu2xeMJ
         JCauR8xSIGIDR6J8zBNS8vjXTKFvRWRv833F5w/JzuSvlzxjOh2UioF8Sk0QIILpeVah
         uTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799606; x=1685391606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApFbhI/fHYAer2NanadPAfLYIZhU2eINRXfKeznF/So=;
        b=b/OK4bpG76l31HJpcYi7apjpJTiMT5QlSrRL2FLNPdIJx3bIvD4XhZMZC1XvdLpALu
         B68+q/+Ntd1+5CIabPVBQOuK3wZgN3PxshvtcYo7lXYvUwuctvkjlDSdYknJoq37uyGt
         pvnW3AjGkJAaKdQdjoFYXnpVXbo9GWwjSmHOrWp68xeXP5O6tNA2xCI8cVDgHcyyBy1h
         6yJhtSAsi9g8Xh3aClC0VTRSTbsTrRFOVHt4deM6cGULLzPRW2XjcceJlqx15NxWIpHu
         uY9bLDlPSr2TlLHZETmo58wv6C326OjeqysezUZdSazU97uISd1jYgQeh179uaJakBDs
         UU0w==
X-Gm-Message-State: AC+VfDxHHxO5F6xOLlQ9FGfuaHMeFRrtGOC1HfnkbZrqhgGTugBg6Lpq
        QU+FTzyrFSqltV+X2NZD8hRIk9x+h0OPPXjfr8jD9w==
X-Google-Smtp-Source: ACHHUZ7QJU7wAVzHHQDcICU7h/SzTDnoL0jEgVPRgbPD+1S2rrqf+p1s08ymEykmY8skZpoYKMWbZw==
X-Received: by 2002:a25:ab50:0:b0:b98:d45e:7bd4 with SMTP id u74-20020a25ab50000000b00b98d45e7bd4mr7783756ybi.13.1682799606122;
        Sat, 29 Apr 2023 13:20:06 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z82-20020a256555000000b00b9a82c1b070sm1465676ybb.27.2023.04.29.13.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/26] btrfs-progs: stop using add_root_to_dirty_list in check
Date:   Sat, 29 Apr 2023 16:19:32 -0400
Message-Id: <767d1929fdc767e2603ffe16699acb838b533f96.1682799405.git.josef@toxicpanda.com>
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

This is used to make sure the root is updated in the tree_root when we
re-init the root, however this function is static in the kernel and
doesn't need to be exported for any reason.  Simply update the root item
and then update it in the tree_root instead of adding it to the dirty
list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index 8714c213..d9c54deb 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9163,8 +9163,12 @@ static int btrfs_fsck_reinit_root(struct btrfs_trans_handle *trans,
 
 	free_extent_buffer(root->node);
 	root->node = c;
-	add_root_to_dirty_list(root);
-	return 0;
+
+	btrfs_set_root_bytenr(&root->root_item, c->start);
+	btrfs_set_root_generation(&root->root_item, trans->transid);
+
+	return btrfs_update_root(trans, gfs_info->tree_root, &root->root_key,
+				 &root->root_item);
 }
 
 static int reset_block_groups(void)
-- 
2.40.0

