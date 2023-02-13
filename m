Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F8D693DDD
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 06:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjBMF07 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 00:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMF05 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 00:26:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CDFEB5A
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 21:26:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE4D420259
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676266014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N+r/+A68Cfv+qXNTXjRsGoSIfNB7/kWDiJFEqb5rtiw=;
        b=VqIH+vW8niXurdhZ/RzB8Zyh2nBvZbvsp+cO0nhoa/1o3fu5jh3ld5SjfpKEjHsp21m8F3
        z0b6OI+qHf0UymKXonGCbqd4B7bBkxRbysVzo2k/9F1SfJZB+RTjTh7BSpV/GWg9lpiedc
        kU1giencBPJLTWK3C1VpDTSA4/Sacw0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 414EE13A1F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id APgeAh7K6WOAbQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:26:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: tests: cli: fix 017 test case failure
Date:   Mon, 13 Feb 2023 13:26:33 +0800
Message-Id: <25e9de59bdc39f714661d8f5e7b321f6cfeff658.1676265837.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676265837.git.wqu@suse.com>
References: <cover.1676265837.git.wqu@suse.com>
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
Test case cli/017 fails with the following errors:

    [TEST]   cli-tests.sh
    [TEST/cli]   017-fi-show-missing
  didn't find exact missing device
  test failed for case 017-fi-show-missing

[CAUSE]
After kernel commit cb3e217bdb39 ("btrfs: use btrfs_dev_name() helper to
handle missing devices better"), all dev info ioctl call on missing
device would only return "<missing disk>" for its path.

Thus "btrfs filesystem show" would never report detailed device path for
missing disks.

[FIX]
Instead of relying on the device path, change the check to rely on devid
instead.

Now cli/017 can properly pass.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/cli-tests/017-fi-show-missing/test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/cli-tests/017-fi-show-missing/test.sh b/tests/cli-tests/017-fi-show-missing/test.sh
index 25e4c60a70e0..67757e20a898 100755
--- a/tests/cli-tests/017-fi-show-missing/test.sh
+++ b/tests/cli-tests/017-fi-show-missing/test.sh
@@ -23,7 +23,7 @@ run_check $SUDO_HELPER mv "$dev2" /dev/loop-non-existent
 run_check $SUDO_HELPER mount -o degraded $dev1 $TEST_MNT
 
 if ! run_check_stdout $SUDO_HELPER "$TOP/btrfs" filesystem show "$TEST_MNT" | \
-	grep -q "$dev2 MISSING"; then
+	grep -q -e "devid[[:space:]]\+2.*MISSING"; then
 
 	_fail "didn't find exact missing device"
 fi
-- 
2.39.1

