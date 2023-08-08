Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A03774E74
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 00:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjHHWlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 18:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjHHWlC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 18:41:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA444FD
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 15:41:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 55DED1F45E
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 22:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691534460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8bhDiSiUrx/6Flv2xsJfVr9psz/69NC0dqq1ZfcFIY=;
        b=Y6wkzddD3mtwbjcDz1sSzk9heM55wqnZMvyd1R4Oe/hIXgE9z2eixW0Uv6NfEwRete5Qeg
        TvWvwuaLmF2abFMj5vZ7pTr/xqRe9wVYTbI7+KD/mwxvIiNTYTj/ucwM+ijl0Jji/9CrXB
        ujZI4CBuEjKwoCXlpyXrL6du0yDVk/A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAD88139D1
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 22:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iI/kHHvE0mQICgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Aug 2023 22:40:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs-progs: tests/misc/046: fix false alerts on write detection
Date:   Wed,  9 Aug 2023 06:40:43 +0800
Message-ID: <e227ed8b74af486392cc1f2607a505577f79fa4c.1691533896.git.wqu@suse.com>
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
Test case misc/046-seed-multi-mount would always fail with the following
error:

    [TEST]   misc-tests.sh
    [TEST/misc]   046-seed-multi-mount
unexpected success: writable file despite read-only mount
test failed for case 046-seed-multi-mount

[CAUSE]
Although mounting seed device is indeed read-only, sprouting it with a
new device would always make it read-write by itself.

The behavior is already there for a long time, thus expecting a new
behavior (not changing the read-only flag) is a little weird.

[FIX]
Instead of doing the write check after the sprout, do it before the
sprout.

This looks more correct, and would not rely on the kernel behavior
change (if we determine to go that path).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/046-seed-multi-mount/test.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/misc-tests/046-seed-multi-mount/test.sh b/tests/misc-tests/046-seed-multi-mount/test.sh
index 83f7a91effdd..95654fd904ff 100755
--- a/tests/misc-tests/046-seed-multi-mount/test.sh
+++ b/tests/misc-tests/046-seed-multi-mount/test.sh
@@ -42,9 +42,11 @@ nextdevice() {
 	run_check mkdir -p "$mnt"
 	TEST_MNT="$mnt"
 	run_check_mount_test_dev
-	run_check $SUDO_HELPER "$TOP/btrfs" device add ${loopdevs[$nextdev]} "$TEST_MNT"
 	run_mustfail "writable file despite read-only mount" \
 		$SUDO_HELPER dd if=/dev/zero of="$TEST_MNT/file$nextdevice" bs=1M count=1 status=none
+	run_check $SUDO_HELPER "$TOP/btrfs" device add ${loopdevs[$nextdev]} "$TEST_MNT"
+	# Although seed sprout would make the fs RW, explicitly remount it RW
+	# just in case of future behavior change.
 	run_check $SUDO_HELPER mount -o remount,rw "$TEST_MNT"
 	# Rewrite the file
 	md5sum=$(run_check_stdout md5sum "$TEST_MNT/file$nextdev" | awk '{print $1}')
-- 
2.41.0

