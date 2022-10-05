Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1306C5F4DA9
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 04:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiJECZu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Oct 2022 22:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJECZf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Oct 2022 22:25:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0F71EADB
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 19:25:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E95F21982
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 02:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664936733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUf2jQghP3XtdYt1gG99fsLoVHOHrHgGZXTNjnGIBY4=;
        b=Oa0RV+BCK6fp/9l7cPgXHvM72m83dH/4vhdzE6Mzp6Rqki67pAkbRogT+Nmmip3P3QesA8
        5WLWklrCod5+npKRzlfAhg/qRHQvuEXeN728qPYZ5Tn2WCWwoZSl2t75x4JedkaXKLKGZa
        FN8Ild61R6679rIOTQmzf/NkzqbarM8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92A0E13345
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 02:25:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +FBAFxzrPGPddgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Oct 2022 02:25:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: tests: fix the wrong kernel version check
Date:   Wed,  5 Oct 2022 10:25:12 +0800
Message-Id: <26571df609d06e0a484a800d424be3e22c0f9961.1664936628.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664936628.git.wqu@suse.com>
References: <cover.1664936628.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
After upgrading to kernel v6.0-rc, btrfs-progs selftest mkfs/001 no
longer checks single device RAID0 and other new features introduced in
v5.13:

  # make TEST=001\* test-mkfs
    [TEST]   mkfs-tests.sh
    [TEST/mkfs]   001-basic-profiles
  $ grep -IR "RAID0\/1" tests/mkfs-tests-results.txt
  ^^^ No output

[CAUSE]
The existing check_min_kernel_version() is doing an incorrect check.

The old check looks like this:

	[ "$unamemajor" -lt "$argmajor" ] || return 1
	[ "$unameminor" -lt "$argminor" ] || return 1
	return 0

For 6.0-rc kernels, we have the following values for mkfs/001

 $unamemajor = 6
 $unameminor = 0
 $argmajor   = 5
 $argminor   = 12

The first check doesn't exit immediately, as 6 > 5.
Then we check the minor, which is already incorrect.

If our major is larger than target major, we should exit immediate with
0.

[FIX]
Fix the check and add extra comment.

Personally speaking I'm not a fan or short compare and return, thus all
the checks will explicit "if []; then fi" checks.

Now mkfs/001 works as expected:

  # make TEST=001\* test-mkfs
    [TEST]   mkfs-tests.sh
    [TEST/mkfs]   001-basic-profiles
  $ grep -IR "RAID0\/1" tests/mkfs-tests-results.txt
   Data,RAID0/1:          204.75MiB
   Metadata,RAID0/1:      204.75MiB
   System,RAID0/1:          8.00MiB

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tests/common b/tests/common
index 3ee42a80dcda..d985ef72a4f1 100644
--- a/tests/common
+++ b/tests/common
@@ -659,6 +659,9 @@ check_kernel_support()
 # compare running kernel version to the given parameter, return success
 # if running is newer than requested (let caller decide if to fail or skip)
 # $1: minimum version of running kernel in major.minor format (eg. 4.19)
+#
+# Return 0 if we meet the minimal version requirement.
+# Return 1 if not.
 check_min_kernel_version()
 {
 	local unamemajor
@@ -672,10 +675,22 @@ check_min_kernel_version()
 	uname=${uname%%-*}
 	IFS=. read unamemajor unameminor tmp <<< "$uname"
 	IFS=. read argmajor argminor tmp <<< "$1"
-	# "compare versions: ${unamemajor}.${unameminor} ? ${argmajor}.${argminor}"
-	[ "$unamemajor" -lt "$argmajor" ] || return 1
-	[ "$unameminor" -lt "$argminor" ] || return 1
-	return 0
+	# If our major > target major, we definitely meet the requirement.
+	# If our major < target major, we definitely don't meet the requirement.
+	if [ "$unamemajor" -gt "$argmajor" ]; then
+		return 0
+	fi
+	if [ "$unamemajor" -lt "$argmajor" ]; then
+		return 1
+	fi
+
+	# Only when our major is the same as the target, we need to compare
+	# the minor number.
+	# In this case, if our minor >= target minor, we meet the requirement.
+	if [ "$unameminor" -ge "$argminor" ]; then
+		return 0;
+	fi
+	return 1
 }
 
 # Get subvolume id for specified path
-- 
2.37.3

