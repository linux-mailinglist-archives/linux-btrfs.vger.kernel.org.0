Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3797A1A8A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjIOJ2A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 05:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjIOJ16 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 05:27:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE75A2D4C;
        Fri, 15 Sep 2023 02:26:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B678C433C9;
        Fri, 15 Sep 2023 09:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694770018;
        bh=8sBX1v1mdO1iTppzvt3RoNfdKg+7RpBEaJIViDMGV50=;
        h=From:To:Cc:Subject:Date:From;
        b=q0OhUBrh398VQh7kORctcMGrMAOqDMoKBQYVP+bz4HMeK3s7k03sE/5V1MtByl/D1
         d3plIuH2Ga3ziO/7CaGeHDMvajV5zenBCJ7fTxnnTBmgIvuyGq6LXG/6Lt7En8vXUq
         MGTlBinQOSwLQRJ52JrAqVJ7d1WgFVsOJ4ItudnQhiQGtAbye1gNjzwt2dMgswGI9Q
         KzAhkcF6yyjqYWLps+qkJXxdg+EoAYVYciTrBDzXbqjb7vpp1qngawFWJPEqvOYzS2
         lc3xDi2KilOy4lgfY6aU90JSf3b8nhHVFf0CfdzrJLI5xVv2eVARvKLbnQeJ0WfO1c
         SOD5WshJesF4A==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: add missing commit ids for a few tests using _fixed_by_kernel_commit
Date:   Fri, 15 Sep 2023 10:26:50 +0100
Message-Id: <be0250a9232aa614dd07b40e8cbbebb591fc3e0b.1694769988.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
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

The tests btrfs/288, btrfs/289 and btrfs/300 are using the "xxxx..." stub
for commit ids, as when they were submitted/merged the corresponding
btrfs patches were not yet in Linus' tree. So replace the stubs with the
commit ids.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/288 | 2 +-
 tests/btrfs/289 | 2 +-
 tests/btrfs/300 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/288 b/tests/btrfs/288
index 52245895..efa9a631 100755
--- a/tests/btrfs/288
+++ b/tests/btrfs/288
@@ -22,7 +22,7 @@ _require_odirect
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 1f2030ff6e49 \
 	"btrfs: scrub: respect the read-only flag during repair"
 
 _scratch_dev_pool_get 2
diff --git a/tests/btrfs/289 b/tests/btrfs/289
index 9cb6c1a5..39d8f733 100755
--- a/tests/btrfs/289
+++ b/tests/btrfs/289
@@ -25,7 +25,7 @@ _require_non_zoned_device "${SCRATCH_DEV}"
 # is dependent on the sectorsize.
 _require_btrfs_support_sectorsize 4096
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 79b8ee702c91 \
 	"btrfs: scrub: also report errors hit during the initial read"
 
 # Create a single btrfs with DUP data profile, and create one 128K file.
diff --git a/tests/btrfs/300 b/tests/btrfs/300
index d3722503..ff87ee71 100755
--- a/tests/btrfs/300
+++ b/tests/btrfs/300
@@ -13,7 +13,7 @@ _begin_fstest auto quick subvol snapshot
 _register_cleanup "cleanup"
 
 _supported_fs btrfs
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 94628ad94408 \
 	"btrfs: copy dir permission and time when creating a stub subvolume"
 
 _require_test
-- 
2.40.1

