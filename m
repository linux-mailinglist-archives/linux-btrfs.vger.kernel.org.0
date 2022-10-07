Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AAB5F7948
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 15:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJGNyF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 09:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJGNyD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 09:54:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE8A114DD2;
        Fri,  7 Oct 2022 06:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66D0DB82366;
        Fri,  7 Oct 2022 13:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEE2C433D6;
        Fri,  7 Oct 2022 13:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665150840;
        bh=scGEi70A05frxQWFYf+ZBs3SYujSvbWGdBtg8Xs6Dhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yj7a8UeIwgqEr4DvJQVlzPyXclu7uxYhCgfv9VKYZdD4v7fRSWiHA9+csiZSPXRor
         C0/iXnBRSALXXlXresvKArnqYazEzut6nBYQADih3Q516+/JCGe4OXAVai3wpo8xdl
         KawW+5W0YeQgtv0YiX3WMCc1DNSM8dgz6gNzErUZHik/OzBcsi7paUWP2KGEJAOb5g
         rxMevvR4oCbQuqn0N1SJ2S0Bw/XG3i16iNvr6QpzzHmQwPXhlv84+lUzBeDUzRvnax
         dzZ4m2kI0A4bhko2GFG6z68k/vf1RyRTY7eFEqzvqLX/tYbElURmoJzDc8/VYjIOuW
         2VM2zm1dJt1Fw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, zlang@redhat.com,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/3] fstests: add missing require of xfs_io fiemap command to some tests
Date:   Fri,  7 Oct 2022 14:53:35 +0100
Message-Id: <f10f9fb7fe2ba35d651150f891aec3d996731a96.1665150613.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665150613.git.fdmanana@suse.com>
References: <cover.1665150613.git.fdmanana@suse.com>
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

btrfs/257, btrfs/258, btrfs/259 and xfs/443 use the fiemap command of
xfs_io but don't do a '_require_xfs_io_command "fiemap"'. So add the
missing requirement.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/257 | 1 +
 tests/btrfs/258 | 1 +
 tests/btrfs/259 | 1 +
 tests/xfs/443   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tests/btrfs/257 b/tests/btrfs/257
index 3092495f..87f9e0b2 100755
--- a/tests/btrfs/257
+++ b/tests/btrfs/257
@@ -33,6 +33,7 @@ _require_btrfs_no_compress
 # Needs 4K sectorsize
 _require_btrfs_support_sectorsize 4096
 _require_xfs_io_command "falloc"
+_require_xfs_io_command "fiemap"
 
 _scratch_mkfs -s 4k >> $seqres.full 2>&1
 
diff --git a/tests/btrfs/258 b/tests/btrfs/258
index da073333..be61d039 100755
--- a/tests/btrfs/258
+++ b/tests/btrfs/258
@@ -17,6 +17,7 @@ _begin_fstest auto defrag quick
 # Modify as appropriate.
 _supported_fs generic
 _require_scratch
+_require_xfs_io_command "fiemap"
 
 # Needs 4K sectorsize, as larger sectorsize can change the file layout.
 _require_btrfs_support_sectorsize 4096
diff --git a/tests/btrfs/259 b/tests/btrfs/259
index 92d0b9a6..36f499f9 100755
--- a/tests/btrfs/259
+++ b/tests/btrfs/259
@@ -18,6 +18,7 @@ _begin_fstest auto quick defrag
 # Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
+_require_xfs_io_command "fiemap"
 
 _scratch_mkfs >> $seqres.full
 
diff --git a/tests/xfs/443 b/tests/xfs/443
index f2390bf3..de28b85b 100755
--- a/tests/xfs/443
+++ b/tests/xfs/443
@@ -30,6 +30,7 @@ _require_test_program "punch-alternating"
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
 _require_xfs_io_command "swapext"
+_require_xfs_io_command "fiemap"
 
 _scratch_mkfs | _filter_mkfs >> $seqres.full 2> $tmp.mkfs
 _scratch_mount
-- 
2.35.1

