Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66348525DA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 10:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355465AbiEMIem (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 04:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357776AbiEMIej (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 04:34:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266F72A8077
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 01:34:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB6F21F924
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652430876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+hBtSggG06Pr07Q09iVsvTNOGmMVbyqP+65Leu768A=;
        b=htfFcX4DPvFJeSZB9Xf/B0NP+kjZOySxnQMEq1zzQJHgvHIEprDL9FEQGI1Wk6Yw9SaOCa
        7Vg/kJld6GYEIJcn8VHr4StdSlHU6nPrlLW5RBeBVbwlX6Y0d/MuXEB+8yEbw/9Zp/b1so
        xP7EJVdY0axPzaGCGvCIBHLT9ZUSLiE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DB6613446
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aEuuAhwYfmI2YQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: use btrfs_chunk_max_errors() to replace weird tolerance calculation
Date:   Fri, 13 May 2022 16:34:29 +0800
Message-Id: <b10b56b94a518bb423b89e29c82639584b68eb64.1652428644.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652428644.git.wqu@suse.com>
References: <cover.1652428644.git.wqu@suse.com>
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

In __btrfs_map_block() we have a very weird assignment to @max_errors
using nr_parity_stripes().

Although it works for RAID56 without problem, it's not reader friendly.

Just replace it with btrfs_chunk_max_errors().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a49d72d845b1..c6c55ef17000 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6480,7 +6480,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 			/* RAID[56] write or recovery. Return all stripes */
 			num_stripes = map->num_stripes;
-			max_errors = nr_parity_stripes(map);
+			max_errors = btrfs_chunk_max_errors(map);
 
 			*length = map->stripe_len;
 			stripe_index = 0;
-- 
2.36.1

