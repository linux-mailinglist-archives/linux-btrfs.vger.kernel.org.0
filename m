Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7DF6FDD17
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbjEJLtF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 07:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjEJLtE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 07:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C4D30F4;
        Wed, 10 May 2023 04:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C01D63C97;
        Wed, 10 May 2023 11:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60D9C4339B;
        Wed, 10 May 2023 11:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683719342;
        bh=4PUpitOkXykPs3XaJwLUoqJyjmmIr7h73IhcD55ceh8=;
        h=From:To:Cc:Subject:Date:From;
        b=MMzYdwaxOm0mWE+PwnXHTUM0tSEh3amCyap7ooIKI6YTMKZKFmMaMS2IsrVK77w8o
         Spo73GjDfpyRcA8pO+vyPfDkwOdIwynnKMu9clHKZcfbbjf8GyQd3qN5+nYIyGCy/F
         CWm6Txzcyvynyt3q19GH2g9djQowXJwkalP1yrXL9hxjcVQ24gtIu1V5IUJoYgQ70S
         vwt+CmStxX9eNEOiAqRKD68faDb2HDQQo0DKtyQrG+Za1bzM5NICGsZsbytol9q6HV
         MDjb5xCHsMQqjmlazacsakUWScxaGCVe1Wx6BJQXYdH0YRXEDpnItSb7e47pkfFlT1
         Q//QzQT8LGFog==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/254: correct subject of the relevant kernel patch and add git commit
Date:   Wed, 10 May 2023 12:48:29 +0100
Message-Id: <21c4680c4cae24a8428adbc27802b1fba75fd128.1683719290.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
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

From: Filipe Manana <fdmanana@suse.com>

The top comment of test btrfs/254 mentions a kernel patch with a subject
of:

   "btrfs: harden identification of the stale device"

but that is actually not correct, as the subject was slightly changed when
the patch was picked to:

   "btrfs: harden identification of a stale device"

So fix that by removing the comment and use instead a call to
_fixed_by_kernel_commit, which also allows us to specify git commit id.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/254 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/254 b/tests/btrfs/254
index ae55ae8c..a358e374 100755
--- a/tests/btrfs/254
+++ b/tests/btrfs/254
@@ -7,9 +7,6 @@
 #
 # Test if the kernel can free the stale device entries.
 #
-# Tests bug fixed by the kernel patch:
-#	btrfs: harden identification of the stale device
-#
 . ./common/preamble
 _begin_fstest auto quick volume
 
@@ -42,6 +39,9 @@ _require_scratch_nocheck
 _require_command "$WIPEFS_PROG" wipefs
 _check_minimal_fs_size $((1024 * 1024 * 1024))
 
+_fixed_by_kernel_commit 770c79fb6550 \
+	"btrfs: harden identification of a stale device"
+
 _scratch_dev_pool_get 3
 
 setup_dmdev()
-- 
2.35.1

