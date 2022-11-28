Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EDB63A7FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 13:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiK1MQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 07:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiK1MQP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 07:16:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D9C1D30E;
        Mon, 28 Nov 2022 04:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01C40B80D86;
        Mon, 28 Nov 2022 12:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27E4C433B5;
        Mon, 28 Nov 2022 12:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669637262;
        bh=YUHqfSELNXmApPtoMFMRsgG5qz0bhrLhnOxHV12DOgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B6FQSQ5GgF3X5tKecNWtZDG6mW1XXoXfrsqAHH3Nyjch9OxewsJMpnFLePoSwqgM6
         HppOHtqFa4vEvidq2jPzBlI5dbSPpN070rb8KcD8id1BE4GiUg28dfui790XCAPdaw
         6fvqJiAXMWQgw8MYamP6HTrDZhrK4P69fUMHp8jDpSGK9PcBRqCvYRhkgyyoh6AI1N
         go6HqJRjhuxo1xksov+KrG3/Nxyg+NpedlROy8o+VgWJ+yeE89nlcFF99vthnH3dss
         ah509IbLFjp+fPhSY1ylb8+6g28F/8QAncv5y6wa3TzeZSNKk6pptAF8WZf/7Uj+3n
         O0whybDs/oDig==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/4] common: make _filter_fiemap_flags optionally print the encoded flag
Date:   Mon, 28 Nov 2022 12:07:22 +0000
Message-Id: <bb362fc269cdbbfcd36d970d8ee499e0fe2b4582.1669636339.git.fdmanana@suse.com>
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

We'd like to have some btrfs test cases in the future to verify that
extents are compressed when using fiemap. For that we can just check if
the FIEMAP_EXTENT_ENCODED (0x8) flag is set for an extent. Currently
_filter_fiemap_flags does not print that flag, so this changes it to
print the flag.

However printing the encoded flag is optional, because some tests use
the filter and use its output to match the golden output. So always
printing the flag would make the tests fail on btrfs when they are run
with "-o compress" (or compress-force) set in MOUNT_OPTIONS due to a
mismatch with the golden output. The tests that can be run with or
without compression on btrfs are generic/352, generic/353 and btrfs/279.
Since those tests don't care about the encoded flag, there is no need to
change them, just make the output of the flag optional, and any future
tests that want to check the presence of the encoded flag, will just pass
a parameter to _filter_fiemap_flags to tell it that the encoded flag
should be printed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/punch | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/common/punch b/common/punch
index 94599c35..3b8be21a 100644
--- a/common/punch
+++ b/common/punch
@@ -109,7 +109,23 @@ _filter_fiemap()
 
 _filter_fiemap_flags()
 {
-	$AWK_PROG '
+	local include_encoded_flag=0
+
+	# Unless a first argument is passed and with a value of 1, the fiemap
+	# encoded flag is filtered out.
+	# This is because tests that use this filter's output in their golden
+	# output may get the encoded flag set or not depending on the filesystem
+	# and its configuration. For example, running btrfs with "-o compress"
+	# (or compress-force) set in MOUNT_OPTIONS, then extents that get
+	# compressed are reported with the encoded flag, otherwise that flag is
+	# not reported. Like this the fs configuration does not cause a mismatch
+	# with the golden output, and tests that exercise specific configurations
+	# can explicitly ask for the encoded flag to be printed.
+	if [ ! -z "$1" ] && [ $1 -eq 1 ]; then
+		include_encoded_flag=1
+	fi
+
+	local awk_script='
 		$3 ~ /hole/ {
 			print $1, $2, $3;
 			next;
@@ -126,7 +142,22 @@ _filter_fiemap_flags()
 			if (and(flags, 0x2000)) {
 				flag_str = "shared";
 				set = 1;
-			}
+			}'
+
+	if [ $include_encoded_flag -eq 1 ]; then
+		awk_script=$awk_script'
+			if (and(flags, 0x8)) {
+				if (set) {
+					flag_str = flag_str"|";
+				} else {
+					flag_str = "";
+				}
+				flag_str = flag_str"encoded";
+				set = 1;
+			}'
+	fi
+
+	awk_script=$awk_script'
 			if (and(flags, 0x1)) {
 				if (set) {
 					flag_str = flag_str"|";
@@ -136,8 +167,9 @@ _filter_fiemap_flags()
 				flag_str = flag_str"last";
 			}
 			print $1, $2, flag_str
-		}' |
-	_coalesce_extents
+		}'
+
+	$AWK_PROG -e "$awk_script" | _coalesce_extents
 }
 
 # Filters fiemap output to only print the 
-- 
2.35.1

