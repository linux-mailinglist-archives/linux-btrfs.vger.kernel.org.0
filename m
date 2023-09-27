Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28187B0273
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 13:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjI0LJj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 07:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjI0LJi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 07:09:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3327F3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 04:09:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A520C433C8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695812977;
        bh=IdInY2600PhoiYLbimc4gGLO52J0bK/Rxxyqp7I2uas=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=u1XxXXi4LTuhcG/jrjw0Ooo60EAXZlQ0i84Hrm3uv5HRv2S/07rrE0tng89y+HSSm
         efCJJGIWCTmIXJMFt+YHeXZTp6dhBx3VXpOPg6Y4mFzIvMe+W7bA+NoTnWvyMdK6X/
         SiiyqvBcDI55aWwxc5+BkwNkV397y3MnRoKhb7i+JtdgMp6oJLByPWi5iWcj6Q3Nia
         rUc8JcD4273ZmJ0x8aWIXP6YDAfvenl9/VQaPAVHbqL7o/lFCguyaLHnaRp+YKnKsN
         G6ZicUbUnlg+jRVQrlEJtjqdZohfZe+LDTo5ApqdQioB8ABrLKK795m/hU9RAjRMXi
         Se3VL6PkiGP1A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/8] btrfs: use round_down() to align block offset at btrfs_cow_block()
Date:   Wed, 27 Sep 2023 12:09:25 +0100
Message-Id: <ec568a627d58773eb088b3ad5b1417d8ce540a9d.1695812791.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695812791.git.fdmanana@suse.com>
References: <cover.1695812791.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_cow_block() we can use round_down() to align the extent buffer's
logical offset to the start offset of a metadata block group, instead of
the less easy to read set of bitwise operations (two plus one subtraction).
So replace the bitwise operations with a round_down() call.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a05c9204928e..8d29b9e09286 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -712,7 +712,7 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		return 0;
 	}
 
-	search_start = buf->start & ~((u64)SZ_1G - 1);
+	search_start = round_down(buf->start, SZ_1G);
 
 	/*
 	 * Before CoWing this block for later modification, check if it's
-- 
2.40.1

