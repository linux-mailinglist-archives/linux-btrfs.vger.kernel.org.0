Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01795798B68
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245412AbjIHRU6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbjIHRU5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:20:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629521FCD
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C064C433CA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193654;
        bh=jwuYcvop/9E7P2ZX6LtQ5vOMGKiV+/0ZJkxyn7k1S/Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nEw3jNDpswQUdrxrEDsBhCS2q01b3IxwT2gu5ZgF1jXcZ0mld67+gD6pFJtIch/2N
         h2TTQ+coG3Kfs3xzVhFBAjRlqjp2KrRDY1ciT0Y1GLYgbdCJPF5VAdyB81LVL8WcW2
         IaxdzHSsiOrsZ1xpjVR5Q5pINeYZYp96RqLz1xz5SbpEPGdFw64D8PGOv8ZzK+P/nZ
         hXrwDkOXe9GmR0CZ+rJaYwXmaVm2QsLvRnmK9XYka6r25MBK2v3GplQ/Otik0CfKEN
         qSANzVK8Yxp85CpdMjneJRYOcqJvq2Fo4jO/Q49qX2+InffxZQUI6Qn4R6vw1EmkLq
         hOGen8BgJIUUQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 12/21] btrfs: log message if extent item not found when running delayed extent op
Date:   Fri,  8 Sep 2023 18:20:29 +0100
Message-Id: <89c5e2e0918dc291f85d8024898e9c142ea6b1e4.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
References: <cover.1694192469.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When running a delayed extent operation, if we don't find the extent item
in the extent tree we just return -EIO without any logged message. This
indicates some bug or possibly a memory or fs corruption, so the return
value should not be -EIO but -EUCLEAN instead, and since it's not expected
to ever happen, print an informative error message so that if it happens
we have some idea of what went wrong, where to look at.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 21049609c5fc..167d0438da6e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1653,7 +1653,10 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 				goto again;
 			}
 		} else {
-			err = -EIO;
+			err = -EUCLEAN;
+			btrfs_err(fs_info,
+		  "missing extent item for extent %llu num_bytes %llu level %d",
+				  head->bytenr, head->num_bytes, extent_op->level);
 			goto out;
 		}
 	}
-- 
2.40.1

