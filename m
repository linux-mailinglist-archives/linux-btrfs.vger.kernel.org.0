Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAB26F3B07
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 01:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEAXaC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 May 2023 19:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEAXaB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 May 2023 19:30:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C83588
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 16:29:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 36E7E224B5
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 23:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682983798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgtzVPPaH1iyN/VTX2Arshe7gcs5ZjEnV/FjhhHbBvc=;
        b=StF0Bwf9aPVtMIlIR7jCunj7nE0YtcEWSBM7IxpWh4JuLDszP0fE0yv6Sxfz4uqU2EN9eo
        lrtd8plyjD0Gbhn6ZOUQkve3b9Zu8VN9gyCFp/SDyeI9jBP4+olqXqqIUAadsUzwGptdxb
        FNi2sRsg0fSZPwsevyrklT+e3LTF5yE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E82C13580
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 23:29:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MCpiEXVLUGTYUwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 01 May 2023 23:29:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: tests: mkfs/021: update to use -O instead of deprecated -R
Date:   Tue,  2 May 2023 07:29:38 +0800
Message-Id: <20230501232938.10544-2-wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501232938.10544-1-wqu@suse.com>
References: <20230501232938.10544-1-wqu@suse.com>
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

-R option is deprecated since commit 4dbe66ca2f21 ("btrfs-progs: mkfs: make
-R|--runtime-features option deprecated"), migrate the test case to
follow the change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/021-rfeatures-quota-rootdir/test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/mkfs-tests/021-rfeatures-quota-rootdir/test.sh b/tests/mkfs-tests/021-rfeatures-quota-rootdir/test.sh
index ec45c1d9..b03e3f61 100755
--- a/tests/mkfs-tests/021-rfeatures-quota-rootdir/test.sh
+++ b/tests/mkfs-tests/021-rfeatures-quota-rootdir/test.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# Check if mkfs runtime feature quota can handle --rootdir
+# Check if mkfs feature quota can handle --rootdir
 
 source "$TEST_TOP/common" || exit
 
@@ -38,7 +38,7 @@ run_check dd if=/dev/zero bs=2K count=1 of="$tmp/2K"
 run_check dd if=/dev/zero bs=4K count=1 of="$tmp/4K"
 run_check dd if=/dev/zero bs=8K count=1 of="$tmp/8K"
 
-run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f --rootdir "$tmp" -R quota "$TEST_DEV"
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f --rootdir "$tmp" -O quota "$TEST_DEV"
 
 rm -rf -- "$tmp"
 
-- 
2.39.0

