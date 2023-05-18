Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB00A707EC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 May 2023 13:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjERLGl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 May 2023 07:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjERLGk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 May 2023 07:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B653E8;
        Thu, 18 May 2023 04:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3219A61D59;
        Thu, 18 May 2023 11:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACEAC433D2;
        Thu, 18 May 2023 11:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684407998;
        bh=7MQAJijcItjvtjawzeIdKpt3CqkT09fZYyTyQM9iMUo=;
        h=From:To:Cc:Subject:Date:From;
        b=WaN4cr6opiS9ybXUUCHuCqTiCYwOjtNGngrPhG/GJocPyiXpnPoR4GsdAtA30F9/J
         kHoVdJTFfo+qDTuxd3FihCkZBhVnXdL4pmO5QaEqh0yUzvzTclErMGx5pxTQn4rKbQ
         TZzIbdd+BBjvwPssP8DSCpwcQfoOUd3Oz796mkIgSB4SwkFQcf8EzeHr/W8Ec8YV4f
         Kwd2M7jXYeBtIW/a4I14JWc4Y8TlLCoP2KUO7RNOeYuDN9x7Z+Qm0MPYv4X3gl2bHE
         r0V7NkOdrlqooh86mLygZFInvL9uLA2NeKgCjhXz6cLh3mjW+7iR7yRzHa8qAIKFL0
         QiIAYYLWdWWcQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/287: add git commit hash for the kernel fix
Date:   Thu, 18 May 2023 12:06:33 +0100
Message-Id: <dd250729b7e59e9208f3e6a96b320a57f31f74cf.1684407974.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The respective fix landed on kernel 6.4-rc2, commit:

  0cad8f14d70c "btrfs: fix backref walking not returning all inode refs"

So update the test to include the commit hash.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/287 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/287 b/tests/btrfs/287
index a0b71c7e..cac96a23 100755
--- a/tests/btrfs/287
+++ b/tests/btrfs/287
@@ -19,7 +19,7 @@ _require_xfs_io_command "fpunch"
 
 # This is a test case to test the logical to ino ioctl in general but it also
 # serves as a regression a test for an issue fixed by the following commit.
-_fixed_by_kernel_commit XXXXXXXXXXXX \
+_fixed_by_kernel_commit 0cad8f14d70c \
 	"btrfs: fix backref walking not returning all inode refs"
 
 query_logical_ino()
-- 
2.34.1

