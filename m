Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7799854289C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 09:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiFHHyr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 03:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiFHHyI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 03:54:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F5187C04;
        Wed,  8 Jun 2022 00:20:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CECB721BAD;
        Wed,  8 Jun 2022 07:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654672840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4kAUqU7oYw9DHR87K5m8UWS9lXofWSz1lGY1kx4IdTg=;
        b=uPuW80p3xp/V4PKGl5/bSTEsKqPxcOUq+vGXSYz9qPsuSzWzw1TCC1qFdSJD6ddJMzXpYx
        A7QEVELoinLVx3QVTIfxYPXEzJ2DPCXkuk+izcHZyxRwVg7zcri8UyeLgwPGM6jdVG4j7F
        XJnef8kABatcul8QbTHFQcFQyS9YTEo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F27AA13A15;
        Wed,  8 Jun 2022 07:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sD+6LsdNoGJyGgAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 08 Jun 2022 07:20:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: re-add btrfs/125 into auto group
Date:   Wed,  8 Jun 2022 15:20:21 +0800
Message-Id: <63471ce6c6d4a4e9db4c3f4771bb512f31131932.1654672817.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

Test case btrfs/125 previous has a very random pass/fail ratio.

This is due to the fact that previously btrfs RAID56 recovery path will
always trust the cached data.

Thus if there is some operation reading part/all of the full stripe,
that full stripe can be cached, making later recovery to generate bad
data.

As the cached data can be stale (intentionally caused by the test case).

Upstream commit d4e28d9b5f04 ("btrfs: raid56: make steal_rbio() subpage
compatible") incidentally disable all the cache re-use for btrfs RAID56,
thus make btrfs/125 to always pass.

Although we will later re-enable the cache behavior for btrfs RAID56, we
will not let recovery path to use any cache at all, thus this will give
us the best things from both worlds, making btrfs/125 to pass
consistently, while still enable cache for regular read/write.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/125 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/125 b/tests/btrfs/125
index b58f2aa282bd..ced812cd921a 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -22,7 +22,7 @@
 # Verify if all three checkpoints match
 #
 . ./common/preamble
-_begin_fstest replace volume balance
+_begin_fstest auto replace volume balance
 
 # Override the default cleanup function.
 _cleanup()
-- 
2.36.1

