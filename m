Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16BB63A803
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 13:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiK1MRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 07:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiK1MQh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 07:16:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D7D2A271;
        Mon, 28 Nov 2022 04:08:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6142EB80D87;
        Mon, 28 Nov 2022 12:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F2AC433C1;
        Mon, 28 Nov 2022 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669637264;
        bh=FGvdoor3l+WjHvBfaSO2rgUjQ70wu9j8ZNwkdBI8kpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GrllKa/R2vBxFb3GpHADXH58VClIfRp28jimqgjZSoXJw2S/pxczvUsj/YjvwS+t4
         3AAFqopCkyfyuLfR7+wR5PVtFzjL+uftlvS8+v/PoTBHrcONkctGn2wqYS/G2Pp1m8
         RXJkrWctdea8uFNqLQ0zNpiZVr62KxSaJk+NlMPvVj9biU6aWw1NPJ8PQG7zGsvSgV
         L7rM5z2y1ZyIStq/UpUZq54U7sE5ayOqBxXh0op3zwCEQ2cmD/FoqyY1FRiuOegoA1
         70hSXxOc1bYMUcDGt7R+A/YJ+NB2jSIzK7eUMboMil2/hmxpYu/e15/AEe/mfP+QGw
         TaIXmFKLy4Tmg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/4] btrfs/280: also verify that fiemap reports extents as encoded
Date:   Mon, 28 Nov 2022 12:07:23 +0000
Message-Id: <0b80a51c716c252c437f218ab224e9ddc8a501f2.1669636339.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669636339.git.fdmanana@suse.com>
References: <cover.1669636339.git.fdmanana@suse.com>
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

Now that _filter_fiemap_flags() optionally reports the encoded flag and
since btrfs/280 explicitly uses and tests compression, make it check that
fiemap reports the compressed extents with the encoded flag set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/280     |  4 ++--
 tests/btrfs/280.out | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/280 b/tests/btrfs/280
index 06ef221e..fc049adb 100755
--- a/tests/btrfs/280
+++ b/tests/btrfs/280
@@ -42,7 +42,7 @@ $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scr
 echo
 echo "File foo fiemap before COWing extent:"
 echo
-$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap_flags
+$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap_flags 1
 
 echo
 echo "Overwriting file range [120M, 120M + 128K) in the snapshot"
@@ -57,7 +57,7 @@ echo "File foo fiemap after COWing extent in the snapshot:"
 echo
 # Now we should have all extents marked as shared except the 128K extent in the
 # file range [120M, 120M + 128K).
-$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap_flags
+$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap_flags 1
 
 # success, all done
 status=0
diff --git a/tests/btrfs/280.out b/tests/btrfs/280.out
index c3f82966..5371f3b0 100644
--- a/tests/btrfs/280.out
+++ b/tests/btrfs/280.out
@@ -5,8 +5,8 @@ Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 
 File foo fiemap before COWing extent:
 
-0: [0..261887]: shared
-1: [261888..262143]: shared|last
+0: [0..261887]: shared|encoded
+1: [261888..262143]: shared|encoded|last
 
 Overwriting file range [120M, 120M + 128K) in the snapshot
 
@@ -15,7 +15,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 File foo fiemap after COWing extent in the snapshot:
 
-0: [0..245759]: shared
-1: [245760..246015]: none
-2: [246016..261887]: shared
-3: [261888..262143]: shared|last
+0: [0..245759]: shared|encoded
+1: [245760..246015]: encoded
+2: [246016..261887]: shared|encoded
+3: [261888..262143]: shared|encoded|last
-- 
2.35.1

