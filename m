Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622B1647D51
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Dec 2022 06:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiLIFfX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Dec 2022 00:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiLIFe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Dec 2022 00:34:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A4445ED6;
        Thu,  8 Dec 2022 21:34:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69796337F0;
        Fri,  9 Dec 2022 05:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670564060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=q0McCrr9lmfnJ+plWSMy8tUqzVRn4eUsxqDZS2QA1Ms=;
        b=twpxXjBv3HUUvg4jjZjo/IUzP5eb9jJx7NDadNRPYXF0eBTcVxi1GPYLQsJHWFl08UAwkt
        vUIjxCvD+SqN/PdSZW64/5fxwCtiJF612RzdbhXSZUFY1hUiTsFDaBPnbnMvN4KzJrRO5c
        L4Rx02/y1fWInEgaGXg/2R1vFCZT9c8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CF5B13253;
        Fri,  9 Dec 2022 05:34:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pIPbFdvIkmOXdAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 09 Dec 2022 05:34:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/219: remove it from auto group
Date:   Fri,  9 Dec 2022 13:34:02 +0800
Message-Id: <6c08b564ea499de6d34a1bd8bb0f435d73de2770.1670563995.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
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

The test case is to make sure we can mount a fs with older generation
(but with the same fsid/dev uuid).

Normally we will reject such case as btrfs is maintaining an internal
devices list (for multi-device support), and if we find a device
suddenly got an older generation, we will directly reject it.

Although for single device btrfs, we may add an exception for it,
the corresponding kernel patch is never merged.

So for now, just remove the test case from auto group.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/219 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 528175b8a4b9..d69e6ac918ae 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -15,7 +15,7 @@
 #
 
 . ./common/preamble
-_begin_fstest auto quick volume
+_begin_fstest quick volume
 
 # Override the default cleanup function.
 _cleanup()
-- 
2.38.1

