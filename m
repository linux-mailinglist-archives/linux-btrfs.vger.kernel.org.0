Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE769506B38
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 13:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351829AbiDSLmA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351787AbiDSLlu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 07:41:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166C536E05
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 04:36:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B7594210FC
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 11:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650368203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/LwJ69cw9K3w228o8Nu/tGIQ8zNU9l9HhS3AHQ+NK4=;
        b=fOMCnDPfz4ZnQjQSDAjUuIteMga45oTDJKBrunZ0LzPUEpqviicfVoIq6j3x4Go0jcXzit
        q3KlE9G5zykMugJIuDQtzs4IbtseEB+SGOLWJXY1F+FeVTIwRFAQLsp7R8h9dAsa7SPCDH
        VEUY9PQCQNLu9TGcgIQ9t914S2sUJm4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CBF7132E7
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 11:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CMQ+McqeXmK8UQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 11:36:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs-progs: make sure "btrfstune -S1" will reject fs with dirty log
Date:   Tue, 19 Apr 2022 19:36:22 +0800
Message-Id: <e3eb450197af2754ff945095b8aa11c3ac875b01.1650368004.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650368004.git.wqu@suse.com>
References: <cover.1650368004.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new test case will have a image file which has dirty log
(btrfs-image supports dumping log tree).

So we can easily check if "btrfstune -S" will reject fs with dirty log.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../052-seed-dirty-log/dirty_log.img.xz          | Bin 0 -> 2140 bytes
 tests/misc-tests/052-seed-dirty-log/test.sh      |  12 ++++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 tests/misc-tests/052-seed-dirty-log/dirty_log.img.xz
 create mode 100755 tests/misc-tests/052-seed-dirty-log/test.sh

diff --git a/tests/misc-tests/052-seed-dirty-log/dirty_log.img.xz b/tests/misc-tests/052-seed-dirty-log/dirty_log.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..a14b0cb02b8a5e36b4dad49e0cddf5c5dbeebed5
GIT binary patch
literal 2140
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
SkZy6Y#Ao{g000001X)@nj3T`N

literal 0
HcmV?d00001

diff --git a/tests/misc-tests/052-seed-dirty-log/test.sh b/tests/misc-tests/052-seed-dirty-log/test.sh
new file mode 100755
index 000000000000..2f16f43a29a2
--- /dev/null
+++ b/tests/misc-tests/052-seed-dirty-log/test.sh
@@ -0,0 +1,12 @@
+#!/bin/bash
+#
+# Make sure btrfstune will not set seed flag when the fs has dirty log
+
+source "$TEST_TOP/common"
+
+check_prereq btrfstune
+
+image=$(extract_image "./dirty_log.img.xz")
+
+run_mustfail "btrfstune should reject fs with dirty log for seeding flag" \
+	"$TOP/btrfstune" -S1 "$image"
-- 
2.35.1

