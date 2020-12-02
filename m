Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02B72CC72D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbgLBTxZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbgLBTxZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:25 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4DC09424D
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:34 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id l7so1974722qtp.8
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VJjId8hZEVzyIER86VZ8xDHAVM9xeJsKzfY/gc8fAqo=;
        b=Blzy/UQPQ7RjU17BmwjFc3GqvspbG1drX2MqvVwe0iERjPJ+I8MoxLSFWQktEgl23r
         gyRLnrm7Qomm1p5O4M54cPJGO0wejU/T5jMK2eVU4Oj2qJgJWCioP/mKiG2Ssjt0Jx38
         4MVKyeeoW59aC1Jvs+wRBhz5dA0dh3HsmGcnTJ1ThEydq/zvsu8Si1wK7ug6/eHwKzVs
         rWq8R8rophqwFPP2u07zuC+9MKbFLoY4e2ID5BpIpteFtcQtt4dZB8Lkubm1Bp+IQoeX
         bK1NkmURmq/9h3vmZWQagdfL9SThht1PzI/bbYRPp579+kjzlW8OFt82mR9VncknqHH1
         WKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJjId8hZEVzyIER86VZ8xDHAVM9xeJsKzfY/gc8fAqo=;
        b=OCGD8O+4uq25FoPvdi7h4KVijjflclX9f44aK6Ck1wlbwrza/0ma51NKEZv7aEw86W
         h0ksP90Azq1+VxplwzWfLzBwnV5GzBspPDNaI/kPBPeHNeg1sBlfXsmiQOqd84fN00Lp
         1zr1gh09pyZA0F6yuWIQwUg/WhHRashcf38jxOpHi9Ztaw73mZ5BKxSmkXmYDYayQjnn
         b6mWOZGLMTuXsV03BAcqJBha+ZeSupDvTPhF9/8s5K3oQh0fwD/x840gP/gadrs0vUoH
         U2CGwzqvZqIeQRrygAY1/AEIIwPZBJ24DBF3xHol+9V+R4VPwHablXQtBqWUh1QcrsbT
         bKuQ==
X-Gm-Message-State: AOAM532YBaq/XQ6bxgSbcyyO4cCoRcGEgBDIvQIBz2MBpB/6U+V1V0wF
        Ul9hlrT2KFInKxRY+6jC5jEmq1z+itwfUQ==
X-Google-Smtp-Source: ABdhPJxqXyqzJ0RjyMXu/Mw4/LEg9tKHxk2KqAxWSL26EM1EQmD1TYuY/xcmyrQL+UFMiMb7BUejog==
X-Received: by 2002:a05:622a:30e:: with SMTP id q14mr4519352qtw.77.1606938753074;
        Wed, 02 Dec 2020 11:52:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d140sm2836702qke.59.2020.12.02.11.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 43/54] btrfs: remove the extent item sanity checks in relocate_block_group
Date:   Wed,  2 Dec 2020 14:51:01 -0500
Message-Id: <09013ee34800bd1bd6354254a1b6a29ddf68f09f.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These checks are all taken care of for us by the tree checker code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3159f6517588..8f4f1e21c770 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3370,20 +3370,6 @@ static void unset_reloc_control(struct reloc_control *rc)
 	mutex_unlock(&fs_info->reloc_mutex);
 }
 
-static int check_extent_flags(u64 flags)
-{
-	if ((flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
-		return 1;
-	if (!(flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    !(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
-		return 1;
-	if ((flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF))
-		return 1;
-	return 0;
-}
-
 static noinline_for_stack
 int prepare_to_relocate(struct reloc_control *rc)
 {
@@ -3435,7 +3421,6 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	struct btrfs_path *path;
 	struct btrfs_extent_item *ei;
 	u64 flags;
-	u32 item_size;
 	int ret;
 	int err = 0;
 	int progress = 0;
@@ -3484,19 +3469,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 
 		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				    struct btrfs_extent_item);
-		item_size = btrfs_item_size_nr(path->nodes[0], path->slots[0]);
-		if (item_size >= sizeof(*ei)) {
-			flags = btrfs_extent_flags(path->nodes[0], ei);
-			ret = check_extent_flags(flags);
-			BUG_ON(ret);
-		} else if (unlikely(item_size == sizeof(struct btrfs_extent_item_v0))) {
-			err = -EINVAL;
-			btrfs_print_v0_err(trans->fs_info);
-			btrfs_abort_transaction(trans, err);
-			break;
-		} else {
-			BUG();
-		}
+		flags = btrfs_extent_flags(path->nodes[0], ei);
 
 		if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 			ret = add_tree_block(rc, &key, path, &blocks);
-- 
2.26.2

