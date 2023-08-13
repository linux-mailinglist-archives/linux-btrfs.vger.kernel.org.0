Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713AB77A612
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 13:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjHMLBi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjHMLBg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 07:01:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB77B1717;
        Sun, 13 Aug 2023 04:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46130617F0;
        Sun, 13 Aug 2023 11:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C319FC433C8;
        Sun, 13 Aug 2023 11:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691924497;
        bh=QmZ+u6TaehU90xPcLMEZC/g/9AIEeut3aPawuhHSy70=;
        h=From:To:Cc:Subject:Date:From;
        b=UaIKGmvgofANvZI6DnwlpO4wV/cXib4XUnkPGS20/xPKIF6ddCIzkze89fj8/WjE9
         BZVGk/o6GWFFfi7dLsO2vX3iVVZQMq+P3cPG/4iRnZhPQC8+zgWOtnrRTHBPujpaNE
         8jodUd4ekUjA53z25OEIiOYxJRL7QivrnJjVLgSfsWRB7/5Ie9FQVcnE4NhoPX3g9p
         8WBicUsFTMBhzzmgWbzVzQLgyAcl3w4KgOPH4nQtsrF5W2ZgT7OjVfXUTiFBUedbZZ
         WjLcPLvovkJIHMuG+5UFpzhFoZ1sYMLGACAWzcTvYApnZkVSUwBST8uc5x5jtx0pqO
         1D2K18/eZeDNw==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/213: fix failure due to misspelled function name
Date:   Sun, 13 Aug 2023 12:01:22 +0100
Message-Id: <71413edbeb1ee5b945f0b82faccaf4a75e8ba56b.1691924176.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The test is calling _not_run but it should be _notrun, so fix that.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/213 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/213 b/tests/btrfs/213
index 5666d9b9..6def4f6e 100755
--- a/tests/btrfs/213
+++ b/tests/btrfs/213
@@ -55,7 +55,7 @@ sleep $(($runtime / 4))
 # any error about no balance currently running.
 $BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT" 2>&1 | grep -iq 'not in progress'
 if [ $? -eq 0 ]; then
-	_not_run "balance finished before we could cancel it"
+	_notrun "balance finished before we could cancel it"
 fi
 
 # Now check if we can finish relocating metadata, which should finish very
-- 
2.34.1

