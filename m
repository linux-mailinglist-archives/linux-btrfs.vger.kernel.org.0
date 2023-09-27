Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB04E7B0272
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 13:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjI0LJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 07:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjI0LJh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 07:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0992FC
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 04:09:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18110C433C9
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695812976;
        bh=HjMVyyMqEKFpRlBfsuVkYOfwZFe4txQVDiQ7r+hmpA0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OyGP1+D2Dk+jXz3m8y74k3icpNVBsEVzHkkiV4Ki56vYv2MruEhW1Qekmpq1GYJSI
         3nsXMEIL85TITJzrw2PnoXPmaJ5Du/r7YhVJnMIYFa7iPTJkxNVaxGtLrI7Q5j+So6
         dFbXeOYiS7pIQDx6m+GhB9YKNLXndfRbQKNM3B5lCxaMloPZbje8MDBUuF6Y59pOSB
         o4iIenEtMjxSAUAiJds7LYO12b+rXC8LH4mKgQMlGa+M8XTmYPTzGp5ppxqYw8g8np
         KbwGU2XTCeBzbv3zEE2IeiHhXE+j3m0D3JBfEHYtNm2Luqd53m4sgR08YKWCzF7E9+
         GHsayX5FIV9jQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/8] btrfs: remove noinline attribute from btrfs_cow_block()
Date:   Wed, 27 Sep 2023 12:09:24 +0100
Message-Id: <7b53170a99a48a6c6085be3f8629b4eb753ab53e.1695812791.git.fdmanana@suse.com>
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

It's pointless to have the noiline attribute for btrfs_cow_block(), as the
function is exported and widely used. So remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 2a51cac7f21d..a05c9204928e 100644
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

