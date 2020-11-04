Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED52A6EEF
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 21:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgKDUis (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 15:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgKDUis (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 15:38:48 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4548FC0613D4
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 12:38:48 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id x20so20677814qkn.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 12:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6jCAIi7adhwqVwohexVJJXc0KyROVrBQ+3K+9l94etA=;
        b=JWvoN5cXNMQASLMG8dL2YjDiVLtLmKHAH/Mp/fX63Q1pg7hg49Yj0gZCHR5QSwcuqW
         m0bzFXv+UE64KY2+4wBlbjmnB6PK+4AKXhVzfIf4IuzbqFFWu1F9gQD4AEM2j9LfyWPB
         E718hXvbQkW9ZMo9gOS+qqtfStWldKx+GfrF0ya+QxC75+OAKvoRik1nASFPqCXb0bOj
         lt+QaMVbn5P2Eq0eyz9ddnIhTLNP2S3MhTdXLvA/x2yRomlk53QEXX/NAEXo66ljCWVA
         7TYDGmiVWJAiIYXIWy04tQfB2xAZx2L0LueKm+VgmKEGrgDOR4WOj795fDueB5hgwBaF
         jlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6jCAIi7adhwqVwohexVJJXc0KyROVrBQ+3K+9l94etA=;
        b=OnKuH5B2Yp5SdhIt9fAsCVhxn04GEdAFEaiKmchvQBHmrKqS//ls32TT5Afg4eyr9B
         BuwrIjeayqkrpbTCZ1XZFnicM4tvruB9FM+fKljR4Q5CuWLJaEyWTukwlkyH/Y1t/yMA
         8sVFs101ss2zpGX4P0EfG+HpVficT2ZrJl4NuP5OL1XsDQgIZXHkR2/6s2QiH2ZoChDv
         cR6r8qbx5qWYzH/BeFzWmQSMRHlvgEeSMP89ALgndUgXD7cc/sWLvOxeqwABqOvSY989
         xuwXTumL1Q+BHUNwKzKbeBg23hmrFWGV1JVU47loL6XwFPzhSIV3yNxASgydruYIlM0v
         ljIg==
X-Gm-Message-State: AOAM5330jiBh7dt1QPFSWkqJ8ZrgrOAs8H2fRYkykarVff5Z9Zxhi4zT
        VRIfnoT3rAwHXbv5Z218qX4FAjXZB+dJ3oCp
X-Google-Smtp-Source: ABdhPJzc7J/ACTyCtT0j2rgxkDu+R1F+cGmWVf5bX2tY5Q0BwqmOL3NaI/pHtK956XaiZTb6JdAmpQ==
X-Received: by 2002:a37:ba42:: with SMTP id k63mr4324qkf.22.1604522327020;
        Wed, 04 Nov 2020 12:38:47 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q70sm3083951qka.87.2020.11.04.12.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:38:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] btrfs/220: fix how we tests for mount options
Date:   Wed,  4 Nov 2020 15:38:45 -0500
Message-Id: <8ef2b30c248a05af25f563124f1b75cf30378035.1604522311.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe noticed that btrfs/220 started failing with some mount option
changes I made recently, but upon closer inspection this test actually
fails in a lot of different ways normally, specifically if you specify
MOUNT_OPTIONS, or if you make an fs with the free space tree.

Address all these issues by reworking how we test that the mount options
are what we expect.  First get what the default mount options are for a
plain mount of SCRATCH_DEV.  This is used as the baseline, so no matter
how the mount options change in the future it will always work properly.

Secondly instead of specifying a rigid order of the mount options we're
testing, which breaks if we adjust the order in /proc/self/mounts,
simply specify the options we're actually interested in checking.  Then
in the test function combine the common options with the new options
we're testing, and then combine that with our actual options and use
some sort magic to see if there's any difference.  If there's no
difference then we know we have everything set as expected, if not we
fail.

This patch addresses the initial issue that Filipe noticed, but also
fixes the failures when you specified MOUNT_OPTIONS, or if you made the
fs with the free space tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/220 | 124 ++++++++++++++++++++++++++++++------------------
 1 file changed, 77 insertions(+), 47 deletions(-)

diff --git a/tests/btrfs/220 b/tests/btrfs/220
index 8f4ba5c6..c84c7065 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -39,13 +39,35 @@ test_mount_flags()
 {
 	local opt
 	local opt_check
+	local stripped
 	opt="$1"
 	opt_check="$2"
 
 	active_opt=$(cat /proc/self/mounts | grep $SCRATCH_MNT | \
 					$AWK_PROG '{ print $4 }')
-	if [[ "$active_opt" != *$opt_check* ]]; then
-		echo "Could not find '$opt_check' in '$active_opt', using '$opt'"
+
+	if [ "$opt_check" != "$DEFAULT_OPTS" ]; then
+		# We only care about the common things between defaults and the
+		# active set, so strip out the uniq lines between the two, and
+		# then we'll add this to our $opt_check which should equal
+		# $active_opt.  We also strip 'rw' as we may be checking 'ro',
+		# so we need to adjust that accordingly
+		stripped=$(echo "$DEFAULT_OPTS,$active_opt" | tr ',' '\n' | \
+				sort | grep -v 'rw' | uniq -d | tr '\n' ',' | \
+				sed 's/.$//')
+		opt_check="$opt_check,$stripped"
+	fi
+
+	# We diff by putting our wanted opts together with the current opts,
+	# turning it into one option per line, sort'ing, and then printing out
+	# any uniq lines left.  This will catch anything that is set that we're
+	# not expecting, or anything that wasn't set that we wanted.
+	#
+	# We strip 'rw' because some tests flip ro, so just ignore rw.
+	diff=$(echo "$opt_check,$active_opt" | tr ',' '\n' | \
+		sort | grep -v 'rw' | uniq -u)
+	if [ -n "$diff" ]; then
+		echo "Unexepcted mount options, checking for '$opt_check' in '$active_opt' using '$opt'"
 	fi
 }
 
@@ -173,116 +195,124 @@ test_subvol()
 	# subvol and subvolid should point to the same subvolume
 	test_should_fail "-o subvol=vol1,subvolid=1234132"
 
-	test_mount_opt "subvol=vol1,subvolid=256" "space_cache,subvolid=256,subvol=/vol1"
-	test_roundtrip_mount "subvol=vol1" "space_cache,subvolid=256,subvol=/vol1" "subvolid=256" "space_cache,subvolid=256,subvol=/vol1"
+	test_mount_opt "subvol=vol1,subvolid=256" "subvolid=256,subvol=/vol1"
+	test_roundtrip_mount "subvol=vol1" "subvolid=256,subvol=/vol1" "subvolid=256" "subvolid=256,subvol=/vol1"
 }
 
 # These options are enable at kernel compile time, so no bother if they fail
 test_optional_kernel_features()
 {
 	# Test options that are enabled by kernel config, and so can fail safely
-	test_optional_mount_opts "check_int" "space_cache,check_int,subvolid"
-	test_optional_mount_opts "check_int_data" "space_cache,check_int_data,subvolid"
-	test_optional_mount_opts "check_int_print_mask=123" "space_cache,check_int_print_mask=123,subvolid"
+	test_optional_mount_opts "check_int" "check_int"
+	test_optional_mount_opts "check_int_data" "check_int_data"
+	test_optional_mount_opts "check_int_print_mask=123" "check_int_print_mask=123"
 
 	test_should_fail "fragment=invalid"
-	test_optional_mount_opts "fragment=all" "space_cache,fragment=data,fragment=metadata,subvolid"
-	test_optional_mount_opts "fragment=data" "space_cache,fragment=data,subvolid"
-	test_optional_mount_opts "fragment=metadata" "space_cache,fragment=metadata,subvolid"
+	test_optional_mount_opts "fragment=all" "fragment=data,fragment=metadata"
+	test_optional_mount_opts "fragment=data" "fragment=data"
+	test_optional_mount_opts "fragment=metadata" "fragment=metadata"
 }
 
 test_non_revertible_options()
 {
-	test_mount_opt "clear_cache" "relatime,space_cache,clear_cache,subvolid"
-	test_mount_opt "degraded" "relatime,degraded,space_cache,subvolid"
+	test_mount_opt "clear_cache" "clear_cache"
+	test_mount_opt "degraded" "degraded"
 
-	test_mount_opt "inode_cache" "space_cache,inode_cache,subvolid"
+	test_mount_opt "inode_cache" "inode_cache"
 
 	# nologreplay should be used only with
 	test_should_fail "nologreplay"
-	test_mount_opt "nologreplay,ro" "ro,relatime,rescue=nologreplay,space_cache"
+	test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay"
 
 	# norecovery should be used only with. This options is an alias to nologreplay
 	test_should_fail "norecovery"
-	test_mount_opt "norecovery,ro" "ro,relatime,rescue=nologreplay,space_cache"
-	test_mount_opt "rescan_uuid_tree" "relatime,space_cache,rescan_uuid_tree,subvolid"
-	test_mount_opt "skip_balance" "relatime,space_cache,skip_balance,subvolid"
-	test_mount_opt "user_subvol_rm_allowed" "space_cache,user_subvol_rm_allowed,subvolid"
+	test_mount_opt "norecovery,ro" "ro,rescue=nologreplay"
+	test_mount_opt "rescan_uuid_tree" "rescan_uuid_tree"
+	test_mount_opt "skip_balance" "skip_balance"
+	test_mount_opt "user_subvol_rm_allowed" "user_subvol_rm_allowed"
 
 	test_should_fail "rescue=invalid"
 
 	# nologreplay requires readonly
 	test_should_fail "rescue=nologreplay"
-	test_mount_opt "rescue=nologreplay,ro" "relatime,rescue=nologreplay,space_cache"
-
-	test_mount_opt "rescue=usebackuproot,ro" "relatime,space_cache,subvolid"
+	test_mount_opt "rescue=nologreplay,ro" "ro,rescue=nologreplay"
 }
 
 # All these options can be reverted (with their "no" counterpart), or can have
 # their values set to default on remount
 test_revertible_options()
 {
-	test_roundtrip_mount "acl" "relatime,space_cache,subvolid" "noacl" "relatime,noacl,space_cache,subvolid"
-	test_roundtrip_mount "autodefrag" "relatime,space_cache,autodefrag" "noautodefrag" "relatime,space_cache,subvolid"
-	test_roundtrip_mount "barrier" "relatime,space_cache,subvolid" "nobarrier" "relatime,nobarrier,space_cache,subvolid"
+	test_roundtrip_mount "acl" "$DEFAULT_OPTS" "noacl" "noacl"
+	test_roundtrip_mount "autodefrag" "autodefrag" "noautodefrag" "$DEFAULT_OPTS"
+	test_roundtrip_mount "barrier" "$DEFAULT_OPTS" "nobarrier" "nobarrier"
 
 	test_should_fail "commit=-10"
 	# commit=0 sets the default, so btrfs hides this mount opt
-	test_roundtrip_mount "commit=35" "relatime,space_cache,commit=35,subvolid" "commit=0" "relatime,space_cache,subvolid"
+	test_roundtrip_mount "commit=35" "commit=35" "commit=0" "$DEFAULT_OPTS"
 
 	test_should_fail "compress=invalid"
 	test_should_fail "compress-force=invalid"
-	test_roundtrip_mount "compress" "relatime,compress=zlib:3,space_cache,subvolid" "compress=lzo" "relatime,compress=lzo,space_cache,subvolid"
-	test_roundtrip_mount "compress=zstd" "relatime,compress=zstd:3,space_cache,subvolid" "compress=no" "relatime,space_cache,subvolid"
-	test_roundtrip_mount "compress-force=no" "relatime,space_cache,subvolid" "compress-force=zstd" "relatime,compress-force=zstd:3,space_cache,subvolid"
+	test_roundtrip_mount "compress" "compress=zlib:3" "compress=lzo" "compress=lzo"
+	test_roundtrip_mount "compress=zstd" "compress=zstd:3" "compress=no" "$DEFAULT_OPTS"
+	test_roundtrip_mount "compress-force=no" "$DEFAULT_OPTS" "compress-force=zstd" "compress-force=zstd:3"
 	# zlib's max level is 9 and zstd's max level is 15
-	test_roundtrip_mount "compress=zlib:20" "relatime,compress=zlib:9,space_cache,subvolid" "compress=zstd:16" "relatime,compress=zstd:15,space_cache,subvolid"
-	test_roundtrip_mount "compress-force=lzo" "relatime,compress-force=lzo,space_cache,subvolid" "compress-force=zlib:4" "relatime,compress-force=zlib:4,space_cache,subvolid"
+	test_roundtrip_mount "compress=zlib:20" "compress=zlib:9" "compress=zstd:16" "compress=zstd:15"
+	test_roundtrip_mount "compress-force=lzo" "compress-force=lzo" "compress-force=zlib:4" "compress-force=zlib:4"
 
 	# on remount, if we only pass datacow after nodatacow was used it will remain with nodatasum
-	test_roundtrip_mount "nodatacow" "relatime,nodatasum,nodatacow,space_cache,subvolid" "datacow,datasum" "relatime,space_cache,subvolid"
+	test_roundtrip_mount "nodatacow" "nodatasum,nodatacow" "datacow,datasum" "$DEFAULT_OPTS"
 	# nodatacow disabled compression
-	test_roundtrip_mount "compress-force" "relatime,compress-force=zlib:3,space_cache,subvolid" "nodatacow" "relatime,nodatasum,nodatacow,space_cache,subvolid"
+	test_roundtrip_mount "compress-force" "compress-force=zlib:3" "nodatacow" "nodatasum,nodatacow"
 
 	# nodatacow disabled both datacow and datasum, and datasum enabled datacow and datasum
-	test_roundtrip_mount "nodatacow" "relatime,nodatasum,nodatacow,space_cache,subvolid" "datasum" "relatime,space_cache,subvolid"
-	test_roundtrip_mount "nodatasum" "relatime,nodatasum,space_cache,subvolid" "datasum" "relatime,space_cache,subvolid"
+	test_roundtrip_mount "nodatacow" "nodatasum,nodatacow" "datasum" "$DEFAULT_OPTS"
+	test_roundtrip_mount "nodatasum" "nodatasum" "datasum" "$DEFAULT_OPTS"
 
 	test_should_fail "discard=invalid"
-	test_roundtrip_mount "discard" "relatime,discard,space_cache,subvolid" "discard=sync" "relatime,discard,space_cache,subvolid"
-	test_roundtrip_mount "discard=async" "relatime,discard=async,space_cache,subvolid" "discard=sync" "relatime,discard,space_cache,subvolid"
-	test_roundtrip_mount "discard=sync" "relatime,discard,space_cache,subvolid" "nodiscard" "relatime,space_cache,subvolid"
+	test_roundtrip_mount "discard" "discard" "discard=sync" "discard"
+	test_roundtrip_mount "discard=async" "discard=async" "discard=sync" "discard"
+	test_roundtrip_mount "discard=sync" "discard" "nodiscard" "$DEFAULT_OPTS"
 
-	test_roundtrip_mount "enospc_debug" "relatime,space_cache,enospc_debug,subvolid" "noenospc_debug" "relatime,space_cache,subvolid"
+	test_roundtrip_mount "enospc_debug" "enospc_debug" "noenospc_debug" "$DEFAULT_OPTS"
 
 	test_should_fail "fatal_errors=pani"
 	# fatal_errors=bug is the default
-	test_roundtrip_mount "fatal_errors=panic" "relatime,space_cache,fatal_errors=panic,subvolid" "fatal_errors=bug" "relatime,space_cache,subvolid"
+	test_roundtrip_mount "fatal_errors=panic" "fatal_errors=panic" "fatal_errors=bug" "$DEFAULT_OPTS"
 
-	test_roundtrip_mount "flushoncommit" "relatime,flushoncommit,space_cache,subvolid" "noflushoncommit" "relatime,space_cache,subvolid"
+	test_roundtrip_mount "flushoncommit" "flushoncommit" "noflushoncommit" "$DEFAULT_OPTS"
 
 	# 2048 is the max_inline default value
-	test_roundtrip_mount "max_inline=1024" "relatime,max_inline=1024,space_cache" "max_inline=2048" "relatime,space_cache,subvolid"
+	test_roundtrip_mount "max_inline=1024" "max_inline=1024" "max_inline=2048" "$DEFAULT_OPTS"
 
-	test_roundtrip_mount "metadata_ratio=0" "relatime,space_cache,subvolid" "metadata_ratio=10" "space_cache,metadata_ratio=10,subvolid"
+	test_roundtrip_mount "metadata_ratio=0" "$DEFAULT_OPTS" "metadata_ratio=10" "metadata_ratio=10"
 
 	# ssd_spread implies ssd, while nossd_spread only disables ssd_spread
-	test_roundtrip_mount "ssd_spread" "relatime,ssd_spread,space_cache" "nossd" "relatime,nossd,space_cache,subvolid"
-	test_roundtrip_mount "ssd" "relatime,ssd,space_cache" "nossd" "relatime,nossd,space_cache,subvolid"
-	test_mount_opt "ssd" "relatime,ssd,space_cache"
+	test_roundtrip_mount "ssd_spread" "ssd_spread" "nossd" "nossd"
+	test_roundtrip_mount "ssd" "ssd" "nossd" "nossd"
+	test_mount_opt "ssd" "ssd"
 
 	test_should_fail "thread_pool=-10"
 	test_should_fail "thread_pool=0"
-	test_roundtrip_mount "thread_pool=10" "relatime,thread_pool=10,space_cache" "thread_pool=50" "relatime,thread_pool=50,space_cache"
+	test_roundtrip_mount "thread_pool=10" "thread_pool=10" "thread_pool=50" "thread_pool=50"
 
-	test_roundtrip_mount "notreelog" "relatime,notreelog,space_cache" "treelog" "relatime,space_cache,subvolid"
+	test_roundtrip_mount "notreelog" "notreelog" "treelog" "$DEFAULT_OPTS"
 }
 
 # real QA test starts here
 _scratch_mkfs >/dev/null
 
+# This test checks mount options, so having random MOUNT_OPTIONS set could
+# affect the results of a few of these tests.
+MOUNT_OPTIONS=
+
 # create a subvolume that will be used later
 _scratch_mount
+
+# We need to save the current default options so we can validate our changes
+# from one mount option to the next one.
+DEFAULT_OPTS=$(cat /proc/self/mounts | grep $SCRATCH_MNT | \
+		$AWK_PROG '{ print $4 }')
+
 $BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/vol1" > /dev/null
 touch "$SCRATCH_MNT/vol1/file.txt"
 _scratch_unmount
-- 
2.26.2

