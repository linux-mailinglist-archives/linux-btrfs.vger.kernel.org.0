Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CCB5F4DAB
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 04:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJECZv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Oct 2022 22:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiJECZt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Oct 2022 22:25:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4EB1F2C5
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 19:25:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59FC5218E7
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 02:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664936735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6SIpQOTpusfoE8gfOMF9+EYS+GvQtd180rdbVVybuU=;
        b=IADRbc6Z/zY4hLLdCfLI8C/xviszAtyy+JEQ3MJ4Zr+R4qm5r4t/pPqocMHBswpn1LjyD3
        F4qV1cX6ExmzO3jYzKZn8+Lw/LPqAx7QOUQmVWmgZKlgvC3V9ZBH9CopojClkziwbpb8Qr
        kYdu72AQ65VpeCF1xZPIDplyB7tOWGo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE9DD13345
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 02:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aOsVHh7rPGPddgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Oct 2022 02:25:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: convert-tests/022: add reiserfs support check
Date:   Wed,  5 Oct 2022 10:25:14 +0800
Message-Id: <feae908d2bfe2e92efc26f4cef5d8ddf186c7114.1664936628.git.wqu@suse.com>
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
Btrfs-progs test case convert/022 will fail if the system doesn't have
reiserfs support nor reiserfs user space tools:

  # make TEST=022\* test-convert
    [TEST]   convert-tests.sh
  WARNING: reiserfs filesystem not listed in /proc/filesystems, some tests might be skipped
    [TEST/conv]   022-reiserfs-parent-ref
  Failed system wide prerequisities: mkreiserfs
  test failed for case 022-reiserfs-parent-ref
  make: *** [Makefile:443: test-convert] Error 1

[CAUSE]
Unlike other test cases, convert/022 doesn't even check if we have
kernel support for it.

[FIX]
Add the proper check before doing system wide prerequisities checks.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/convert-tests/022-reiserfs-parent-ref/test.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/convert-tests/022-reiserfs-parent-ref/test.sh b/tests/convert-tests/022-reiserfs-parent-ref/test.sh
index 66aaff7b6502..5d5ccdc5702f 100755
--- a/tests/convert-tests/022-reiserfs-parent-ref/test.sh
+++ b/tests/convert-tests/022-reiserfs-parent-ref/test.sh
@@ -2,6 +2,11 @@
 # Test that only toplevel directory self-reference is created
 
 source "$TEST_TOP/common"
+source "$TEST_TOP/common.convert"
+
+if ! check_kernel_support_reiserfs >/dev/null; then
+	_not_run "no reiserfs support"
+fi
 
 setup_root_helper
 prepare_test_dev
-- 
2.37.3

