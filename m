Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108604FBE5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 16:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346926AbiDKOLJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 10:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346908AbiDKOLI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 10:11:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C032EE0;
        Mon, 11 Apr 2022 07:08:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E644B8160F;
        Mon, 11 Apr 2022 14:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42D5C385A3;
        Mon, 11 Apr 2022 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649686131;
        bh=08rRsdo2ov0EKlOH+2wSRBfyuCC99XlpkHreU8aGw/s=;
        h=From:To:Cc:Subject:Date:From;
        b=Ce2nwAkLnldgKA2zmpUIM4nIWmCyWcMpMPg4sAh3Bn4khfT/jBduIMerzQ3jf8wn0
         IWtV/ZmmKpFSP/Pw3KxZgZTTfIl5rZAGI0RB91dJPAGiV2zMrW4kDiNwHUhS/dMBbM
         Qw5WjsNBrnGscXTRDwT18ZAj5jU59jfzr5WP2/+7I24P3UxMa+SXQyOPxrNDv+59ze
         v97on/8BQmT6vy+HZOzRudxU4hjSrhVMVSthjZFWKlRs435EkkV6JbpEifQSgea/DW
         PPr37VHgNPQ/Sv6b2Cv4ZyubTDM5VZFLoyPyy4RXIpgg414Rpvzm5FpJoT7NUiONat
         BZwq7WVMjNa7Q==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, brauner@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] common/rc: fix _try_scratch_mount() and _test_mount() when mount fails
Date:   Mon, 11 Apr 2022 15:08:38 +0100
Message-Id: <0ab59504aef01776ab58f9f92c55e86bf1c75424.1649685964.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
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

After the recent commit 4a7b35d7a76cd9 ("common: allow to run all tests
on idmapped mounts"), some test that use _try_scratch_mount started to
fail. For example:

$ ./check btrfs/131 btrfs/220
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian9 5.17.0-rc8-btrfs-next-114 (...)
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/131 2s ... - output mismatch (see .../results//btrfs/131.out.bad)
    --- tests/btrfs/131.out	2020-06-10 19:29:03.818519162 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/131.out.bad (...)
    @@ -6,8 +6,6 @@
     Disabling free space cache and enabling free space tree
     free space tree is enabled
     Trying to mount without free space tree
    -mount failed
    -mount failed
     Mounting existing free space tree
     free space tree is enabled
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/131.out ...
btrfs/220 7s ... - output mismatch (see .../results//btrfs/220.out.bad)
    --- tests/btrfs/220.out	2020-10-16 23:13:46.802162554 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/220.out.bad (...)
    @@ -1,2 +1,32 @@
     QA output created by 220
    +Option fragment=invalid should fail to mount
    +umount: /home/fdmanana/btrfs-tests/scratch_1: not mounted.
    +Option nologreplay should fail to mount
    +umount: /home/fdmanana/btrfs-tests/scratch_1: not mounted.
    +Option norecovery should fail to mount
    +umount: /home/fdmanana/btrfs-tests/scratch_1: not mounted.
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/220.out ...
Ran: btrfs/131 btrfs/220
Failures: btrfs/131 btrfs/220
Failed 2 of 2 tests

The reason is that if _try_scratch_mount() fails to mount the filesystem,
we don't return the failure, instead we call _idmapped_mount(), which
can succeed and make _try_scratch_mount() return 0 (success). The same
happens for _test_mount(), however a quick search revealed no tests
currently relying on the return value of _test_mount().

So fix that by making _try_scratch_mount() return immediately if it gets
a mount failure. Also do the same for _test_mount().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index 17629801..37d18599 100644
--- a/common/rc
+++ b/common/rc
@@ -329,11 +329,15 @@ _supports_filetype()
 # mount scratch device with given options but don't check mount status
 _try_scratch_mount()
 {
+	local mount_ret
+
 	if [ "$FSTYP" == "overlay" ]; then
 		_overlay_scratch_mount $*
 		return $?
 	fi
 	_mount -t $FSTYP `_scratch_mount_options $*`
+	mount_ret=$?
+	[ $mount_ret -ne 0 ] && return $mount_ret
 	_idmapped_mount $SCRATCH_DEV $SCRATCH_MNT
 }
 
@@ -494,12 +498,16 @@ _idmapped_mount()
 
 _test_mount()
 {
+    local mount_ret
+
     if [ "$FSTYP" == "overlay" ]; then
         _overlay_test_mount $*
         return $?
     fi
     _test_options mount
     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
+    mount_ret=$?
+    [ $mount_ret -ne 0 ] && return $mount_ret
     _idmapped_mount $TEST_DEV $TEST_DIR
 }
 
-- 
2.35.1

