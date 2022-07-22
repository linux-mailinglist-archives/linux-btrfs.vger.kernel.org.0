Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D14957E490
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jul 2022 18:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiGVQjS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jul 2022 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGVQjR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jul 2022 12:39:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F939B1BD;
        Fri, 22 Jul 2022 09:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7216A6220B;
        Fri, 22 Jul 2022 16:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63410C341C6;
        Fri, 22 Jul 2022 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658507955;
        bh=MEi2m4TGcodbNgd3R7bbStCdDYtwQlJb8yVB4L59ngc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZNned+9bSniIx8axnXg/sYmvDBy/jyC0YX3iIjiVhu6tgVm98lRPPu99MrO5SaVU+
         01634FI0y3GSwLAksZaLBHIcMyZWy0KcB5bHQS9PlUzOD+Q65iDSndNCke2FLGM3lG
         ySat6/4vrTts0yXMnrradSElZGQsBPapFbQmiwvUZxAlyJlLr7JSauANZ/RrfJPKUf
         0EULpc/KBIWApJxSpO1W4ZL+VyFvYP7Mujz0diJHaEBGT63f+WgSXYfTDaBl3H2Po0
         xWw4/AH/WlJ+CGL1e8k5W4ChU9sK+Cz0rwR9obyKrm5ZpvitYZSFr3xuHjFduv1zqX
         v5FDFoAQxOsaA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] btrfs: Fix unused variable in load_free_space_cache()
Date:   Fri, 22 Jul 2022 09:38:54 -0700
Message-Id: <20220722163854.1189931-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When CONFIG_LOCKDEP is unset, there is a warning about the mapping
variable being unused:

  fs/btrfs/free-space-cache.c:929:24: warning: variable 'mapping' set but not used [-Wunused-but-set-variable]
          struct address_space *mapping;
                                ^
  1 warning generated.

lockdep_set_class() does not do anything with the first parameter to the
macro when CONFIG_LOCKDEP is not set so just eliminate the mapping
variable and use inode instead, which is always used in the function.

Fixes: 22d85ab1af7d ("btrfs: Change the lockdep class of struct inode's invalidate_lock")
Link: https://github.com/ClangBuiltLinux/linux/issues/1672
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/btrfs/free-space-cache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index a2b2329ae558..e8fce6b19559 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -926,7 +926,6 @@ int load_free_space_cache(struct btrfs_block_group *block_group)
 	int ret = 0;
 	bool matched;
 	u64 used = block_group->used;
-	struct address_space *mapping;
 
 	/*
 	 * Because we could potentially discard our loaded free space, we want
@@ -991,8 +990,8 @@ int load_free_space_cache(struct btrfs_block_group *block_group)
 	 * space inodes to prevent false positives related to locks for normal
 	 * inodes.
 	 */
-	mapping = &inode->i_data;
-	lockdep_set_class(&mapping->invalidate_lock, &btrfs_free_space_inode_key);
+	lockdep_set_class(&inode->i_data.invalidate_lock,
+			  &btrfs_free_space_inode_key);
 
 	ret = __load_free_space_cache(fs_info->tree_root, inode, &tmp_ctl,
 				      path, block_group->start);

base-commit: ba37a9d53d71f94ed78f2e53d84be7fa77e2a2b3
-- 
2.37.1

