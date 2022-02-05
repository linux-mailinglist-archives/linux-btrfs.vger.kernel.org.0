Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831764AA6F6
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 06:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbiBEFr3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Feb 2022 00:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238376AbiBEFr2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Feb 2022 00:47:28 -0500
X-Greylist: delayed 361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Feb 2022 21:47:27 PST
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ECAC061346
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 21:47:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7DC53210E3;
        Sat,  5 Feb 2022 05:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644039685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fc2T2IANwyTgtqLu1BqKdMejqjOMMqxaoKE16O5jtT0=;
        b=M/fSuFd+BbZTMcn6HsFDk/M1+5MeIrm6fPqu+WLFzOjXfLvvXGaSeXQweyQO0nVTuhCFd/
        Z6Oaqzwl0oXzZ+bmSofM/XxHv3PqCoyICwXrxev3TWGukz1dxAh7U/bM5cMkAtqB3q8DHd
        kDDZwC9djnEfQTEpAUr6x7lAB3tFXUo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0F7113A6D;
        Sat,  5 Feb 2022 05:41:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mJPhGgQO/mFCQAAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 05 Feb 2022 05:41:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 1/5] btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK for later sanity check
Date:   Sat,  5 Feb 2022 13:41:02 +0800
Message-Id: <5173816fff578b3979aae6cf96e2050af9e56a6e.1644039495.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1644039494.git.wqu@suse.com>
References: <cover.1644039494.git.wqu@suse.com>
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

And since we're here, replace the hardcoded bit flags (1, 2) with
(1UL << 0) and (1UL << 1), respectively.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 include/uapi/linux/btrfs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 1cb1a3860f1d..57332a529c4e 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -576,8 +576,10 @@ struct btrfs_ioctl_clone_range_args {
  * Used by:
  * struct btrfs_ioctl_defrag_range_args.flags
  */
-#define BTRFS_DEFRAG_RANGE_COMPRESS 1
-#define BTRFS_DEFRAG_RANGE_START_IO 2
+#define BTRFS_DEFRAG_RANGE_COMPRESS	(1UL << 0)
+#define BTRFS_DEFRAG_RANGE_START_IO	(1UL << 1)
+#define BTRFS_DEFRAG_RANGE_FLAGS_MASK	(BTRFS_DEFRAG_RANGE_COMPRESS |\
+					 BTRFS_DEFRAG_RANGE_START_IO)
 struct btrfs_ioctl_defrag_range_args {
 	/* start of the defrag operation */
 	__u64 start;
-- 
2.35.0

