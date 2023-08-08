Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C45774213
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjHHRdQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 13:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjHHRci (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 13:32:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0224B91B39
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 09:14:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1713720311
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 06:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691474941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VpcJUfyx823L0mpm43zyNXi7pxT46u0NGb5HMam35y0=;
        b=jdvmdOHjBxqh7U5esiAEQhn1PDwjvAmQQNOGcTA5MwzeKqNmkXXsBp0OvTSlzOsOqmEzkA
        uXCRT/cXqP+ijv/Z3EuMC0qZ5McXEQa+142JBmUJEJejOOReU4A1r3slFIt34zks4VqZ43
        pj95iDTRXb/S88+7iLbeh5N5qaWRxaY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73CEE139D1
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 06:09:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S4oSEPzb0WTCPAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Aug 2023 06:09:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tests/misc/030: do not require v1 cache for the test case
Date:   Tue,  8 Aug 2023 14:08:42 +0800
Message-ID: <c56a81542acc3319265ed1041640253d2b4b8276.1691474892.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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

[PROBLEM]
Since we have migrated to default v2 cache, the test case
misc/030-missing-device-image is no longer executed:

    [TEST/misc]   030-missing-device-image
    [NOTRUN] unable to create v1 space cache

[CAUSE]
The test case itself is trying its best to cover all paths, including
the data extent read path.

Thus the test case is requiring v1 cache, as that's the only way to
cover the data read path.

[FIX]
Just remove the v1 space cache requirement, it's still better to run the
test even it only exercises the metadata read path.

The good news is, after commit 3ff9d352576b ("btrfs-progs: use
read_data_from_disk() to replace read_extent_from_disk() and replace
read_extent_data()"), all data/metadata read paths are unified.
They only differ in the verification part.

Thus even if we didn't fully exercise the data read path, we didn't lose
much coverage anyway.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/030-missing-device-image/test.sh | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tests/misc-tests/030-missing-device-image/test.sh b/tests/misc-tests/030-missing-device-image/test.sh
index be022c4bb9eb..1438f8a45229 100755
--- a/tests/misc-tests/030-missing-device-image/test.sh
+++ b/tests/misc-tests/030-missing-device-image/test.sh
@@ -37,14 +37,6 @@ test_missing()
 	run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT/b" bs=4k count=1000 conv=sync
 	run_check $SUDO_HELPER umount "$TEST_MNT"
 
-	# make sure we have space cache
-	if ! run_check_stdout "$TOP/btrfs" inspect dump-tree -t root "$dev1" |
-		grep -q "EXTENT_DATA"; then
-		# Normally the above operation should create the space cache.
-		# If not, it may mean we have migrated to v2 cache by default
-		_not_run "unable to create v1 space cache"
-	fi
-
 	# now wipe the device
 	run_check wipefs -fa "$bad_dev"
 
-- 
2.41.0

