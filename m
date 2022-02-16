Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8794B867E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 12:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiBPLLP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 06:11:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBPLLO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 06:11:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628ABEDF08
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 03:11:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 134EB212C0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645009861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZZo6v9ObgD4oPRx7tuao4Q6qTHWNZQm7raMROZJB5i4=;
        b=PY0zhGqOUxawXTTEy7iC5M6Z+87u+z7hE8vGcMRTfgUQH5KAWQSCdiU+D7852NuyYLV3Xe
        Wre4g5plOYKF+wTeSd4Fu6+TqYD16QZ8jIS4JC7mvIrZSHXDjkYGGnTfa9wvmyj18HeiDd
        45KvAIbewp7lbO/mtjtjvsyWUlO0fCw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6725713ADB
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 11:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jDskDcTbDGIoJgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 11:11:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: Doc: update autodefrag mount options
Date:   Wed, 16 Feb 2022 19:10:43 +0800
Message-Id: <90c29d3ce0096d1de56c898b63c40ebcdeafbba0.1645009831.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will add the following contents:

- Add how autodefrag works

- More detailed cases which are not sutiable for autodefrag

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/ch-mount-options.rst | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/ch-mount-options.rst b/Documentation/ch-mount-options.rst
index f4ff0084d00f..f2dd12e6f841 100644
--- a/Documentation/ch-mount-options.rst
+++ b/Documentation/ch-mount-options.rst
@@ -28,9 +28,23 @@ autodefrag, noautodefrag
         (since: 3.0, default: off)
 
         Enable automatic file defragmentation.
-        When enabled, small random writes into files (in a range of tens of kilobytes,
-        currently it's 64KiB) are detected and queued up for the defragmentation process.
-        Not well suited for large database workloads.
+        When enabled, small random writes into files (in a range of tens of
+        kilobytes, currently it's 64KiB for uncompressed write, and 16KiB for
+        compressed write) are detected and queued up for the defragmentation
+        process.
+
+        Then btrfs-cleaner kernel thread will try to defrag all those files.
+        The defragmentation process will scan the whole file from offset 0,
+        finding out mergeable small writes since last modification, and
+        re-dirty suitable targets (small, newer than last modification, mergeable)
+        for next writeback.
+
+        Thus autodefrag, just like regular defrag, will cause extra data write.
+
+        Not suited for heavy random write workload (including database and
+        torrent), as such small random writes can get re-dirtied very
+        frequently, causing amplified data write IO, while the file can still be
+        heavily fragmented by the new writes.
 
         The read latency may increase due to reading the adjacent blocks that make up the
         range for defragmentation, successive write will merge the blocks in the new
-- 
2.35.1

