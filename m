Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A344C2BB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 13:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiBXM31 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 07:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiBXM3Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 07:29:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B53264983
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 04:28:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 317631F44A;
        Thu, 24 Feb 2022 12:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645705729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nKggag2hJWv7dfhOOlLqh9aOcxM8bmHXMy6+G0dgRk=;
        b=VDuTOKT+/wgGkvixj92FZ4VNf+rpZTvQn1acJeW1QVeNx20m1QFvDfB2H2ntueioGeMWoM
        tArLzYf6C4+sbMwoyTjQ9H6XqUBihBnK4ifCSLicVFacwwNjxeEL5MjIrET4oAvaHnA8Xo
        ZzeCsJaJ5n4gpnEMPIlyAxqsYmPw6Wg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4032313AD9;
        Thu, 24 Feb 2022 12:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kGvzAQB6F2LhAgAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 24 Feb 2022 12:28:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/7] btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK for later sanity check
Date:   Thu, 24 Feb 2022 20:28:37 +0800
Message-Id: <b542a3d6a77751653b593967f20d4c9420bf7fd4.1645705266.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645705266.git.wqu@suse.com>
References: <cover.1645705266.git.wqu@suse.com>
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

And since we're here, replace the hardcoded bit flags (1, 2) with
(1UL << 0) and (1UL << 1), respectively.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 include/uapi/linux/btrfs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index d956b2993970..3d4bfdacf935 100644
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
2.35.1

