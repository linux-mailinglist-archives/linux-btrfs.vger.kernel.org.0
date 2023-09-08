Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA47986CA
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbjIHMJn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243212AbjIHMJm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501381BC5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72115C433CA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174979;
        bh=tndu4mmAhqsjkELfVkNsN8ukn7LnhQEO0iQpYV/e/1o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NjHldNqU1L2IbJ4aLgFLzAAsNGqQRhGQB/bUJavfe+VjdAAUYAZX7hMf/jOyDMyfs
         0BJx9oRlEgFOLSPYjGRX5Vy6gx7KFjpwaMmU0qVDrXdpk3D1OvFEOOw4m709T2jnTl
         arfJa/x75YQlrDV9znzKI9Ry6txt9TLZuq0iDoNEt7uBxjvp4UdreXxMmEjnoKtRmi
         f7wnTbMZZz1uY6Dqm7tybBEVMmP4hAdrEmLTpo1ku5oJSZ06F459vbNODzPii5OCbt
         wBMKQfqambYL2dmycatny2s5MfpaJb+lm4I++4WGOaVK6ErPD6FuEwky676P/s0twH
         bMITL5XyAE15A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/21] btrfs: log message if extent item not found when running delayed extent op
Date:   Fri,  8 Sep 2023 13:09:14 +0100
Message-Id: <5c0f10fff0bb9e0bbd0368069d965d8e4ea0cb1e.1694174371.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694174371.git.fdmanana@suse.com>
References: <cover.1694174371.git.fdmanana@suse.com>
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

