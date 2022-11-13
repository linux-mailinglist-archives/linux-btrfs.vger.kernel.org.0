Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C6626D60
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 02:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiKMBxq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Nov 2022 20:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiKMBxo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Nov 2022 20:53:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD142DED;
        Sat, 12 Nov 2022 17:53:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B17581FF53;
        Sun, 13 Nov 2022 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668304421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=X3V9FT7m9Rof6wc2BITb0PiK6GaGh93rAHOyAdpEwrY=;
        b=jFTN5wxDrO67FvwLWmrhNanuZ038IHHNWIQU85/RYFCvG6m5kCzlfwNlO5nz1EjMzKlAWg
        69L29WUNJGsqIxFOq9ZAI8+JI70RIjWv/3RSHKjyG3SJRoQ6tSfF7rIzte8EWR1t4qafXw
        HgjSbpbjJcX2DWo51VJnQv660S7dbm8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF6EA13A08;
        Sun, 13 Nov 2022 01:53:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fJgaJiROcGOAWgAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 13 Nov 2022 01:53:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/053: use "-n" to replace the deprecated "-l" mkfs option
Date:   Sun, 13 Nov 2022 09:53:23 +0800
Message-Id: <20221113015323.38789-1-wqu@suse.com>
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
Test case btrfs/053 will fail if using newer btrfs-progs with the extra
error output:

    mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
           dmesg(1) may have more information after failed mount system call.
    mount /dev/mapper/test-scratch1 /mnt/scratch failed

[CAUSE]
The option "-l"/"--leafsize" is already marked deprecated since
btrfs-progs v4.0, and finally in btrfs-progs v6.0 we removes the support
for such deprecated option completely.

But unfortunately the test case is still using the old option.

[FIX]
Fix and improve the test case by:

- Use "-n" to replace the "-l" option

- Rename "leaf_size" variable to "node_size"

- Save the output of _scratch_mkfs to $seqres.full
  This would save quite some time if it later failed due to some other
  reasons in mkfs.btrfs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/053 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/053 b/tests/btrfs/053
index fbd2e7d9..006ea0e6 100755
--- a/tests/btrfs/053
+++ b/tests/btrfs/053
@@ -37,14 +37,14 @@ _require_attrs
 # max(16384, PAGE_SIZE) is the default leaf/node size on btrfs-progs v3.12+.
 # Older versions just use max(4096, PAGE_SIZE).
 # mkfs.btrfs can't create an fs with a leaf/node size smaller than PAGE_SIZE.
-leaf_size=$(echo -e "16384\n`getconf PAGE_SIZE`" | sort -nr | head -1)
+node_size=$(echo -e "16384\n`getconf PAGE_SIZE`" | sort -nr | head -1)
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
 rm -fr $send_files_dir
 mkdir $send_files_dir
 
-_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
+_scratch_mkfs "-n $node_size" >> $seqres.full 2>&1
 _scratch_mount
 
 echo "hello world" > $SCRATCH_MNT/foobar
@@ -72,7 +72,7 @@ _run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 _scratch_unmount
 _check_scratch_fs
 
-_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
+_scratch_mkfs "-n $node_size" >> $seqres.full 2>&1
 _scratch_mount
 
 _run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
-- 
2.38.0

