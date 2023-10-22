Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F417D20E2
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Oct 2023 05:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjJVDkj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Oct 2023 23:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJVDkg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Oct 2023 23:40:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AC611B
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Oct 2023 20:40:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 06A891FDC7
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 03:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697946032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvLZzufsD0C5mynKDJKHpBlZd5XqixKKPKIy8kc6FO4=;
        b=Ol70R42tz4QycsYDWjeyHe17T0LhLvaDD230RVa8IO8rfUg9dRakfMamNLYvqMisua17M1
        fznvdLknMgODjcg1D0Pwd5JlOiy1nnDPP+SLgWZdhxs80NeRWg+7ldReEh6lLTZ6vhFwcT
        oOlc6kk+BZi9XhgkR34NdZUwwQDlkaA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 345191348C
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 03:40:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8KBZOK6ZNGVHZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 03:40:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: fsck-tests: add test image of out-of-order inline backref items
Date:   Sun, 22 Oct 2023 14:10:09 +1030
Message-ID: <e260e8432e3ae5e09d012dce6bd6f96ff0569649.1697945679.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697945679.git.wqu@suse.com>
References: <cover.1697945679.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_ONE(0.00)[1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         DBL_PROHIBIT(0.00)[0.0.0.9:email,0.0.0.2:email];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Issue #622 reported a case where ntfs2btrfs can generate out-of-order
inline backref items, which can lead to kernel transaction abort, but
not detected by btrfs-check.

This patch would add such image, whose extent tree looks like this for
the only data extent:

        item 0 key (13631488 EXTENT_ITEM 4096) itemoff 16172 itemsize 111
                refs 3 gen 7 flags DATA
                (178 0xdfb591fa80d95ea) extent data backref root FS_TREE objectid 257 offset 0 count 1
                (178 0xdfb591fbbf5f519) extent data backref root FS_TREE objectid 258 offset 0 count 1
                (178 0xdfb591f49f9f8e7) extent data backref root FS_TREE objectid 259 offset 0 count 1

While the original good base image has the following backrefs for the
same data extent:

        item 0 key (13631488 EXTENT_ITEM 4096) itemoff 16172 itemsize 111
                refs 3 gen 7 flags DATA
                (178 0xdfb591fbbf5f519) extent data backref root FS_TREE objectid 258 offset 0 count 1
                (178 0xdfb591fa80d95ea) extent data backref root FS_TREE objectid 257 offset 0 count 1
                (178 0xdfb591f49f9f8e7) extent data backref root FS_TREE objectid 259 offset 0 count 1

Notice the sequence (the 2nd number in the round brackets) should be
descending.
(Meanwhie type should be ascending, but it's way harder to create)

For now we don't have a way to fix it, but at least we should detect it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../btrfs_image.xz                            | Bin 0 -> 2264 bytes
 .../061-out-of-order-inline-backref/test.sh   |  19 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tests/fsck-tests/061-out-of-order-inline-backref/btrfs_image.xz
 create mode 100755 tests/fsck-tests/061-out-of-order-inline-backref/test.sh

diff --git a/tests/fsck-tests/061-out-of-order-inline-backref/btrfs_image.xz b/tests/fsck-tests/061-out-of-order-inline-backref/btrfs_image.xz
new file mode 100644
index 0000000000000000000000000000000000000000..65c10617bc250edce2affb3ed91c359041119345
GIT binary patch
literal 2264
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

literal 0
HcmV?d00001

diff --git a/tests/fsck-tests/061-out-of-order-inline-backref/test.sh b/tests/fsck-tests/061-out-of-order-inline-backref/test.sh
new file mode 100755
index 000000000000..f80d58f416f0
--- /dev/null
+++ b/tests/fsck-tests/061-out-of-order-inline-backref/test.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+#
+# Verify that check can detect out-of-order inline backref items.
+#
+# There is a report that one ntfs2btrfs generated some out-of-order inline
+# backref items, while btrfs-check failed to detect it at all.
+#
+# Make sure btrfs check can at least detect such error.
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+
+check_image() {
+	run_mustfail "out-of-order inline backref items not detected" \
+		"$TOP/btrfs" check "$1"
+}
+
+check_all_images
-- 
2.42.0

