Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E558D774E78
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 00:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjHHWlE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 18:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjHHWlD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 18:41:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC02FD
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 15:41:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 617B81F853
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691534461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ff7alGF9fATTFj75SKCxHOxDxpbQoDt65+5iOilJ3pQ=;
        b=VgDHnu2D6aVHgoT9rF/hRmOJiXyLwPPuvszwiKnybGlImYyeqDYXDN+sj8qlKgNEHUjeIy
        suV1tH5GDgsqrAMWVuuJQUoCuJ1thZTNmF3PE7iuZHeECfaGKD8EPlAnimAgTlCkpa1PIJ
        FzcClopOrvjy5A/xh+4Wl4e3cmvvuH4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6EC4139D1
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 22:41:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cL8eIHzE0mQICgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Aug 2023 22:41:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: tests/misc/058: reduce the space requirement and speed up the test
Date:   Wed,  9 Aug 2023 06:40:44 +0800
Message-ID: <173e7faa9202a5d3438cd5bbdca765708f3bc729.1691533896.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691533896.git.wqu@suse.com>
References: <cover.1691533896.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When I was testing misc/058, the fs still has around 7GiB free space,
but during that test case, btrfs kernel module reports write failures
and even git commands failed inside that fs.

And obviously the test case failed.

[CAUSE]
It turns out that, the test case itself would require 6GiB (4 data
disks) + 1.5GiB x 2 (the two replace target), thus it requires 9 GiB
free space.

And obviously my partition is not that large and failed.

[FIX]
In fact, we really don't need that much space at all.

Our objective is to test "btrfs device replace --enqueue" functionality,
there is not much need to wait for 1 second, we can just do the enqueue
immediately.

So this patch would reduce the file size to a more sane (and rounded)
2GiB, and do the enqueue immediately.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/058-replace-start-enqueue/test.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/misc-tests/058-replace-start-enqueue/test.sh b/tests/misc-tests/058-replace-start-enqueue/test.sh
index 1a24d5ec7ecb..bdbc87b4090d 100755
--- a/tests/misc-tests/058-replace-start-enqueue/test.sh
+++ b/tests/misc-tests/058-replace-start-enqueue/test.sh
@@ -21,16 +21,15 @@ run_check_mount_test_dev
 run_check $SUDO_HELPER "$TOP/btrfs" device remove "$REPLACE1" "$TEST_MNT"
 run_check $SUDO_HELPER "$TOP/btrfs" device remove "$REPLACE2" "$TEST_MNT"
 
-for i in `seq 48`; do
+for i in `seq 16`; do
 	run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT/file$i" bs=1M count=128 status=noxfer
 done
 # Sync so replace start does not block in unwritten IO
 run_check "$TOP/btrfs" filesystem sync "$TEST_MNT"
 run_check "$TOP/btrfs" filesystem usage -T "$TEST_MNT"
 
-# Go background, should not be that fast, estimated 10 seconds
+# Go background, should not be that fast.
 run_check $SUDO_HELPER "$TOP/btrfs" replace start 2 "$REPLACE1" "$TEST_MNT"
-run_check sleep 1
 # No background, should wait
 run_check $SUDO_HELPER "$TOP/btrfs" replace start --enqueue 3 "$REPLACE2" "$TEST_MNT"
 run_check $SUDO_HELPER "$TOP/btrfs" replace status "$TEST_MNT"
-- 
2.41.0

