Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3500F73192C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jun 2023 14:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243609AbjFOMuD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jun 2023 08:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245355AbjFOMtt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jun 2023 08:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C262126;
        Thu, 15 Jun 2023 05:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEF46625CE;
        Thu, 15 Jun 2023 12:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFCCC433C0;
        Thu, 15 Jun 2023 12:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686833388;
        bh=HM9QW1ikx4EuJYt+6nVJniUFb4xtHPyQLNFeKRRhfHw=;
        h=From:To:Cc:Subject:Date:From;
        b=hvEow0ZHKEwQzuT8JwSEbRj3CWwl1VS3v2SVeSkGQYCjPlNwOm63B6ylLPT00IPOk
         HgAJsVXawicgSu+UzO+s+j4/HMSIausAcbhBnDPqe4+8Mb8SZpDJT8+vLD2Hh0LN2V
         t2Ru7eZ36grvORvPf0dAqhkf30vEY5ZdCM5oZoCSXSz8tkndU4Y/7vSr+k0FK6C0J0
         O/J9FJQ8lOr3gYy68rL4Qq4dLJ4vnW3h6kQF7c+g9PaOIMDvukUdm/65BgF02YaTk6
         eTJhw7uBFb0rV9LYKBXhgu87ynbcaI4KE6qWl2Qzm7mMw2b9M6jxUl5kcHDmaQysc8
         VXa8bskFdtX2Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: update i_version in update_dev_time
Date:   Thu, 15 Jun 2023 08:49:45 -0400
Message-Id: <20230615124946.106957-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When updating the ctime, we also want to update i_version.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This is just something I noticed by inspection. There is probably no way
to test this today unless you can somehow get to this inode via nfsd.
Still, I think it's the right thing to do for consistency's sake.

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 841e799dece5..c62570b6eb0f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1918,7 +1918,7 @@ static void update_dev_time(const char *device_path)
 		return;
 
 	now = current_time(d_inode(path.dentry));
-	inode_update_time(d_inode(path.dentry), &now, S_MTIME | S_CTIME);
+	inode_update_time(d_inode(path.dentry), &now, S_MTIME | S_CTIME | S_VERSION);
 	path_put(&path);
 }
 
-- 
2.40.1

