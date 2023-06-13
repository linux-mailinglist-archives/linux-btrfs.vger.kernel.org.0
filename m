Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F46772DA92
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 09:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbjFMHO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 03:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbjFMHOZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 03:14:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC592C9;
        Tue, 13 Jun 2023 00:14:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 812D51FD83;
        Tue, 13 Jun 2023 07:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686640463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cpTbpFhYag1wW9aFZ8EBcA10MKiSsw3nlH6NWkke3c8=;
        b=JGhiY33onBUCbJT6nXY1NeyYC9DzDlsv+ggzntiMgP43fervmHqYqnbkgFyWEgAqMokh+J
        3hC3c0iUs2OYLSLJcuSkBnm1LImV+sPCOyn8/MnzAtspBDi7uEQ4fdabvKL8DjB1kHbE9H
        U2qS4DEb0LzXcXP9M83tD1/hFhZxpWs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5B4313345;
        Tue, 13 Jun 2023 07:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ojGdG04XiGTTDQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 13 Jun 2023 07:14:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: verify data checksum during _check_btrfs_filesystem()
Date:   Tue, 13 Jun 2023 15:14:04 +0800
Message-ID: <61bb187a554ff0397665a8898ca2bd56419b6944.1686640441.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

By default btrfs only checks the metadata consistency, but sometimes if
we have some corruption in data while the test case doesn't utilize
scrub to verify, or there is some bugs in scrub itself, we will not
detect those problems.

So here we do one step further by utilizing --check-data-csum option, so
that if there is some data corruption, we can detect them early.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/btrfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/btrfs b/common/btrfs
index bd4dc31fa5a8..be8ac04cd9a3 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -144,7 +144,7 @@ _check_btrfs_filesystem()
 		rm -f $tmp.qgroup_report
 	fi
 
-	$BTRFS_UTIL_PROG check $device >$tmp.fsck 2>&1
+	$BTRFS_UTIL_PROG check --check-data-csum $device >$tmp.fsck 2>&1
 	if [ $? -ne 0 ]; then
 		_log_err "_check_btrfs_filesystem: filesystem on $device is inconsistent"
 		echo "*** fsck.$FSTYP output ***"	>>$seqres.full
-- 
2.41.0

