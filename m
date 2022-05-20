Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACB852E1FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 03:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbiETBcO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 21:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344487AbiETBcN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 21:32:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C39985B6
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 18:32:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CDE21FA63
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653010331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlmNZa3fY2NgR3HRYQ/ua2mRNcV1wMnMygXE5AoZzec=;
        b=fyr/5D6glXlCfZNX3V6JhcmbhJmFN9mTbK+x4uxYnaXfNFxb5CA1IQTaAcLolhDMWERstc
        //vxbgT/0vd6+w68JDcuiivrTt+3m7pYGra5mcYWij/lgb5eBNDJw8dQbMnQ+1cUp5Mc4P
        JRud9V8AUOJ1LXv7qCtKMVB0Ty0EdEM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 971A613A5F
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gOGxGZrvhmKXOQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:32:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: mkfs-tests: add test case to make sure we don't create bitmaps for empty fs
Date:   Fri, 20 May 2022 09:31:51 +0800
Message-Id: <0333d0b18d0fa0ddfafe7b13a40c4e43e3c8928f.1653009947.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653009947.git.wqu@suse.com>
References: <cover.1653009947.git.wqu@suse.com>
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

The new test case is to make sure on a relative large empty fs, we won't
create bitmaps to unnecessarily bump up the size of free space tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/024-fst-bitmaps/test.sh | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 tests/mkfs-tests/024-fst-bitmaps/test.sh

diff --git a/tests/mkfs-tests/024-fst-bitmaps/test.sh b/tests/mkfs-tests/024-fst-bitmaps/test.sh
new file mode 100755
index 000000000000..8d88c08cb25a
--- /dev/null
+++ b/tests/mkfs-tests/024-fst-bitmaps/test.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+# Basic check if mkfs supports the runtime feature free-space-tree
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+setup_root_helper
+
+setup_loopdevs 4
+prepare_loopdevs
+dev1=${loopdevs[1]}
+tmp=$(_mktemp fst-bitmap)
+
+test_do_mkfs()
+{
+	run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$@"
+	if run_check_stdout "$TOP/btrfs" check "$dev1" | grep -iq warning; then
+		_fail "warnings found in check output"
+	fi
+}
+
+test_do_mkfs -m raid1 -d raid0 ${loopdevs[@]}
+
+run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-tree \
+	-t free_space "$dev1" > "$tmp.dump-tree"
+cleanup_loopdevs
+
+if grep -q FREE_SPACE_BITMAP "$tmp.dump-tree"; then
+	rm -f -- "$tmp*"
+	_fail "free space bitmap should not be created for empty fs"
+fi
+rm -f -- "$tmp*"
+
-- 
2.36.1

