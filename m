Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5468626D6E
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 03:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiKMCJE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Nov 2022 21:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiKMCJD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Nov 2022 21:09:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B95713D3B;
        Sat, 12 Nov 2022 18:09:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 388B1336CA;
        Sun, 13 Nov 2022 02:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668305340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Jz0TZQje3XgXeIhuL22DcJvqvjJirGw/xoh5AkbGWGo=;
        b=b03CCsJyI+0q1QwpaUO2TsOf5ffZiPacXY04xXdOnUarLnZaFh0A/CAPwNTS7YJvE+Fb57
        PNRdBkhPLTq3IXAMSgpJSQsAxDbukOCZA1m1mF9GI9tlGgc7VvvN4voLlpk8YoGv7ESDcE
        qSdEhAAnWGA8fp2QJqJuSYxBrF8th+k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49D75139C6;
        Sun, 13 Nov 2022 02:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1hWMBLtRcGO6YAAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 13 Nov 2022 02:08:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/021: redirect the output of defrag command
Date:   Sun, 13 Nov 2022 10:08:41 +0800
Message-Id: <20221113020841.40180-1-wqu@suse.com>
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

[BUG]
Test case btrfs/021 will fail with v6.0 btrfs-progs, with the extra
output:

     QA output created by 021
    +/mnt/scratch/padding-0
    +/mnt/scratch/padding-1
    +/mnt/scratch/padding-2
    +/mnt/scratch/padding-3
    +/mnt/scratch/padding-4
    +/mnt/scratch/padding-5
    ...

[CAUSE]
In fact this is a btrfs-progs bug, btrfs-progs commit db2f85c8751c
("btrfs-progs: fi defrag: add global verbose option") changed the output
level of defrag command.

[FIX]
This will be fixed in btrfs-progs, while as a workaround we can redirect
the stdout into $seqres.full.

If we hit some error, the stderr will still pollute the golden output
and be caught by the test case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/021 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/021 b/tests/btrfs/021
index 5943da2f..6b6383cb 100755
--- a/tests/btrfs/021
+++ b/tests/btrfs/021
@@ -23,7 +23,7 @@ run_test()
 	sleep 0.5
 
 	find $SCRATCH_MNT -type f -print0 | xargs -0 \
-	$BTRFS_UTIL_PROG filesystem defrag -f
+	$BTRFS_UTIL_PROG filesystem defrag -f >> $seqres.full
 
 	sync
 	wait
-- 
2.38.0

