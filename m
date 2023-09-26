Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524D77AED20
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjIZMpg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 08:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjIZMpe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 08:45:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1622C9
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 05:45:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3223CC433C7
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732327;
        bh=5hRu3KrrRJv3CpO5Cj3Ym9PfH7hIqgLUDM6h9wszXhQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nfrVn8dRhL5NfKxYutQyBVtv6Fbm/OXBZQUFac9opY3oZ8r+7PCrKsGJ717VSzhic
         bq4hhbh3JRZ6dBG3vJz5r4uZjOVHcw769E6Sx5GzadReWMxuq3ZoXXlGr6vwQsuLK9
         lXTUnm4NNLH70qtgWpuZgXbCgg+OwDsIFlfoCdVmhrTCoHeRuX4QTpmgrDxalSpjeA
         Dz9giGKV+qQ9z1rGkZMuusJsYZiZ34W5u9BQ9IZzZEnW0idqh8PDQw6vhdfJq4ro0Y
         2o7vT22TMgeX9IvS1SV1xM7r/7kVPthxpkPJBvHcwnkK+6PV2js381r5fHal37XK8F
         OCke4ZcRmklHQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: remove noinline attribute from btrfs_cow_block()
Date:   Tue, 26 Sep 2023 13:45:16 +0100
Message-Id: <8ee8102f8cb59c53efbc93ae7bfd129a28c76b19.1695731843.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695731838.git.fdmanana@suse.com>
References: <cover.1695731838.git.fdmanana@suse.com>
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

It's pointless to have the noiline attribute for btrfs_cow_block(), as the
function is exported and widely used. So remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8619172bcba1..602da318ba11 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -672,7 +672,7 @@ static inline int should_cow_block(struct btrfs_trans_handle *trans,
  * This version of it has extra checks so that a block isn't COWed more than
  * once per transaction, as long as it hasn't been written yet
  */
-noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
+int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, struct extent_buffer *buf,
 		    struct extent_buffer *parent, int parent_slot,
 		    struct extent_buffer **cow_ret,
-- 
2.40.1

