Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC96999D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 17:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBPQWG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 11:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBPQWF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 11:22:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736F54E5EA;
        Thu, 16 Feb 2023 08:22:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23455B828E0;
        Thu, 16 Feb 2023 16:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847E7C4339B;
        Thu, 16 Feb 2023 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676564521;
        bh=0KmiO5Nmkyoi4KhahMDHnMrduUF16T529tDDDCwBkaI=;
        h=From:To:Cc:Subject:Date:From;
        b=oOiaBixh7N4oKOqtQC86PBUFdk3k/mJcxZSQnu3932LbC3S3PPf/aK9Y+zZO297OO
         yUuShPx2p5xqXyR8VsmuuOvXw5MuAhvPN92qnGdO5dUgUnTW8IMKkSVvNnOtuPCirJ
         xJvKWkN6zczCYqqz0YwIYdKS+0BrKpHgqFvqwfoi/0wqzTMGYs9rp/rK1aCgJ02AxY
         qnhyNfKvx6MtC6dy965Ej6K2kLwfO42vhT/swZiE7R2Li9V0AlJL2FwGpT4OR1wxvT
         4ieyTOxCKVK9Q+CFtzHs4LjbN3a1vQ0ln/PoKoXdjFRfBul2L8yLopL/ONTeLpYL/R
         4Tw4Ha/40feVg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/604: fix test to actually create dirty inodes
Date:   Thu, 16 Feb 2023 16:21:50 +0000
Message-Id: <4dd1c7d583289c12d2acf8bfee3b555307399220.1676564465.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The test case generic/604 aims to test a scenario where at unmount time we
have many dirty inodes, however the test does not actually creates any
files, because it calls xfs_io without the -f argument, so xfs_io fails
but any error is ignored because stderr is redirected to /dev/null.

Fix this by passing -f to xfs_io and also stop redirecting stderr to
/dev/null, so that in case of any unexpected failure creating files, the
test fails.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/604 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/604 b/tests/generic/604
index 3c6b76a4..9c53fd57 100755
--- a/tests/generic/604
+++ b/tests/generic/604
@@ -22,7 +22,7 @@ _require_scratch
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 for i in $(seq 0 500); do
-	$XFS_IO_PROG -c "pwrite 0 4K" $SCRATCH_MNT/$i >/dev/null 2>&1
+	$XFS_IO_PROG -f -c "pwrite 0 4K" $SCRATCH_MNT/$i >/dev/null
 done
 _scratch_unmount &
 _scratch_mount
-- 
2.35.1

