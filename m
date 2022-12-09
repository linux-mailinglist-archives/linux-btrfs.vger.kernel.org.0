Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED187647D8E
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Dec 2022 07:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLIGFj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Dec 2022 01:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLIGFc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Dec 2022 01:05:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A10D60EB9;
        Thu,  8 Dec 2022 22:05:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8EF7833759;
        Fri,  9 Dec 2022 06:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670565929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MnlAWFQCb//aV8JEAqQCKJzoKP4w0kgL8HIm4EcAXNU=;
        b=PI2ag7IYyNGvqI2vjpauXJ+hZtrZ7s4GjDU2nuKtVMZc3ORp0O+6waFVkVFbpkUZ2HvE5n
        O679Zkge1/CjqZjqlUjXh9hrVcjxhfx5B6Ox6nT9umOWiOJyaKz4cpN97cbc+JHNKxOfbQ
        HmIGDsVqgz+8OByEld3qRbw3p+kZ5aU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C11F138E0;
        Fri,  9 Dec 2022 06:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LypZGCjQkmPIAgAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 09 Dec 2022 06:05:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/220: fix the test failure due to new default mount option
Date:   Fri,  9 Dec 2022 14:05:10 +0800
Message-Id: <20221209060510.29557-1-wqu@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The latest misc-next tree will make test case btrfs/220 fail with the
following error messages:

btrfs/220 15s ... - output mismatch (see ~/xfstests/results//btrfs/220.out.bad)
    --- tests/btrfs/220.out	2022-05-11 09:55:30.749999997 +0800
    +++ ~/xfstests/results//btrfs/220.out.bad	2022-12-09 13:57:23.706666671 +0800
    @@ -1,2 +1,5 @@
     QA output created by 220
    +Unexepcted mount options, checking for 'rw,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/' in 'rw,relatime,space_cache=v2,subvolid=5,subvol=/' using 'nodiscard'
    +Unexepcted mount options, checking for 'rw,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/' in 'rw,relatime,space_cache=v2,subvolid=5,subvol=/' using 'nodiscard'
    +Unexepcted mount options, checking for 'rw,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/' in 'rw,relatime,space_cache=v2,subvolid=5,subvol=/' using 'nodiscard'
     Silence is golden
    ...
    (Run 'diff -u ~/xfstests/tests/btrfs/220.out ~/xfstests/results//btrfs/220.out.bad'  to see the entire diff)
Ran: btrfs/220
Failures: btrfs/220
Failed 1 of 1 tests

[CAUSE]
Since patch "btrfs: auto enable discard=async when possible", which is
already in the maintainer's tree for next merge window, btrfs will
automatically enable asynchronous discard for devices which supports
discard.

This makes our $DEFAULT_OPTS to have "discard=async" in it.

While for "nodiscard" mount option, we will completely disable all
discard, causing the above mismatch.

[FIX]
Fix it by introducing $DEFAULT_NODISCARD_OPTS specifically for
"nodiscard" mount option.

If async discard is not enabled by default, $DEFAULT_NODISCARD_OPTS will
be the same as $DEFAULT_OPTS, thus everything would work as usual.

If async discard is enabled by default, $DEFAULT_NODISCARD_OPTS will
have that removed, so for "nodiscard" we can use $DEFAULT_NODISCARD_OPTS
as expected mount options.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/220 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/220 b/tests/btrfs/220
index 4d94ccd6..30ca06f6 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -280,10 +280,10 @@ test_revertible_options()
 	if [ "$enable_discard_sync" = true ]; then
 		test_roundtrip_mount "discard" "discard" "discard=sync" "discard"
 		test_roundtrip_mount "discard=async" "discard=async" "discard=sync" "discard"
-		test_roundtrip_mount "discard=sync" "discard" "nodiscard" "$DEFAULT_OPTS"
+		test_roundtrip_mount "discard=sync" "discard" "nodiscard" "$DEFAULT_NODISCARD_OPTS"
 	else
 		test_roundtrip_mount "discard" "discard" "discard" "discard"
-		test_roundtrip_mount "discard" "discard" "nodiscard" "$DEFAULT_OPTS"
+		test_roundtrip_mount "discard" "discard" "nodiscard" "$DEFAULT_NODISCARD_OPTS"
 	fi
 
 	test_roundtrip_mount "enospc_debug" "enospc_debug" "noenospc_debug" "$DEFAULT_OPTS"
@@ -344,6 +344,12 @@ _scratch_mount
 DEFAULT_OPTS=$(cat /proc/self/mounts | grep $SCRATCH_MNT | \
 		$AWK_PROG '{ print $4 }')
 
+# Since 63a7cb130718 ("btrfs: auto enable discard=async when possible"),
+# "discard=async" will be automatically enabled if the device supports.
+# This can screw up our test against nodiscard options, thus remove the
+# default "discard=async" mount option for "nodiscard" tests.
+DEFAULT_NODISCARD_OPTS=$(echo -n "$DEFAULT_OPTS" | $SED_PROG 's/,discard=async//')
+
 $BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/vol1" > /dev/null
 touch "$SCRATCH_MNT/vol1/file.txt"
 _scratch_unmount
-- 
2.38.0

