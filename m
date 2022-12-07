Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2913646418
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 23:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLGW23 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 17:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLGW22 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 17:28:28 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C681D87
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 14:28:27 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id s14so13672433qvo.11
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Dec 2022 14:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJjFPZ3bVjCi1soL/NYCpPC55azD6NczF2opwl7HCRI=;
        b=K/Vex0L6GHrv7qSMqXK1BoHzNkmE+ZWNUb686Yp++Ff+H+B324t9Aj4mJAb2x6Y50r
         A4PRanlTrOcpyV3HzzsCsCLsP7xcytdfSspKu56Q4TgZUt1k6uyeScpXkqJAZE32hwob
         eOVO9FtqoVzhDoiiCaP1j8F8qqpl+TRAPNAP0prgaGE5G+aOfZ+/UA/In+6jNoijwWN8
         02xNiokeKuhyAAahi2Ew+sP/SVKKhUrreb4z8ekqNqg3X05MLNN16BTszNO97uPETBox
         EyRxWM7FS9jTQR4+LpDcXReBTpsthMIk/e5E1oO9WkFRzntm20abRKbX8uvZEpnICcNH
         L5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJjFPZ3bVjCi1soL/NYCpPC55azD6NczF2opwl7HCRI=;
        b=lNiyPtrj/ukH8p1LdA2BvfUCNzqWCZGjNVmq+AEPS41GjgogBhCLfYdG0LgRL0gv59
         R1X27anNEff+9j+Gg4wqLSHvuaqPZI/zeNZ31aObOKyFuxlGcHm9CvXfriJBDbbneyqT
         +NP+/X3Wkj7jxVRvO0bWh1gIknvuKpy00OYnAxG+ff4mbkZZAA4bEVHSMnQTiAai9rkj
         epnkokar+kGL0QQ0W14jEVPtpnxJnSS+OiE53BXA0Zg/L/5ScS+cZKX8eZYZEXhxpGaK
         cXrhGR8upu7i+Cg2h0pehMR8BXSjHktcINls09WBc9e4/+y20YCTCKCuBmlDvDf0OvMs
         ZNkw==
X-Gm-Message-State: ANoB5pnLxXnkl+356PvV3up1A25aQmtXW2UTHFgzRKRBiPfY37aPiviU
        e3JHYCPy/VwKCKiLqIehet7ufgUnTN663VOw
X-Google-Smtp-Source: AA0mqf51lcxBgwwfgkHuVfND8lsznY3KbcBdXYf2YAVMcW1z4GelOEE2oCuZUY+XZhdD1DotntsVmQ==
X-Received: by 2002:a05:6214:e6c:b0:4c7:7257:68a2 with SMTP id jz12-20020a0562140e6c00b004c7725768a2mr2013758qvb.15.1670452106392;
        Wed, 07 Dec 2022 14:28:26 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a258a00b006bb82221013sm18033073qko.0.2022.12.07.14.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:28:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] btrfs: remove btrfs_wait_tree_block_writeback
Date:   Wed,  7 Dec 2022 17:28:11 -0500
Message-Id: <455b500ef31fc9cc86b181a51bb840086dcc1ade.1670451918.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1670451918.git.josef@toxicpanda.com>
References: <cover.1670451918.git.josef@toxicpanda.com>
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

This is used in the tree-log code and is a holdover from previous
iterations of extent buffer writeback.  We can simply use
wait_on_extent_buffer_writeback here, and remove
btrfs_wait_tree_block_writeback completely.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 15695f505f05..15f8130d812c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -278,12 +278,6 @@ void btrfs_end_log_trans(struct btrfs_root *root)
 	}
 }
 
-static void btrfs_wait_tree_block_writeback(struct extent_buffer *buf)
-{
-	filemap_fdatawait_range(buf->pages[0]->mapping,
-			        buf->start, buf->start + buf->len - 1);
-}
-
 /*
  * the walk control struct is used to pass state down the chain when
  * processing the log tree.  The stage field tells us which part
@@ -2637,7 +2631,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 
 				btrfs_tree_lock(next);
 				btrfs_clear_buffer_dirty(next);
-				btrfs_wait_tree_block_writeback(next);
+				wait_on_extent_buffer_writeback(next);
 				btrfs_tree_unlock(next);
 
 				if (trans) {
@@ -2706,7 +2700,7 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 
 				btrfs_tree_lock(next);
 				btrfs_clear_buffer_dirty(next);
-				btrfs_wait_tree_block_writeback(next);
+				wait_on_extent_buffer_writeback(next);
 				btrfs_tree_unlock(next);
 
 				if (trans) {
@@ -2787,7 +2781,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 
 			btrfs_tree_lock(next);
 			btrfs_clear_buffer_dirty(next);
-			btrfs_wait_tree_block_writeback(next);
+			wait_on_extent_buffer_writeback(next);
 			btrfs_tree_unlock(next);
 
 			if (trans) {
-- 
2.26.3

