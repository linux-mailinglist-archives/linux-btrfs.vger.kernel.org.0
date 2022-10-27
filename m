Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C8360F5E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 13:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiJ0LHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 07:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiJ0LHS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 07:07:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE89201B1
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 04:07:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 095151FDFF;
        Thu, 27 Oct 2022 11:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666868837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/RSI9KAts4K61HkCJJyloyRsx+0Yj3nhoCVn0lavCM=;
        b=vJ/SmOpy1AGny5pqmEnZPYs+MTIEokEdGV0CZXS6jvUXu51/jmgz3X9yXPRUjmImhjSnBe
        3HQWoVqL6UQM/4c4Z2HsnhHThfW9MnpPHhjN/ZS/VgmaTK6lnlmBzsmNPDxfMBXWK3QHMC
        4mkIqZee9dEpqG8aFxeRRn7URM48sms=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 007832C141;
        Thu, 27 Oct 2022 11:07:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 69836DA79B; Thu, 27 Oct 2022 13:07:03 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: switch extent_page_data bit fields to bools
Date:   Thu, 27 Oct 2022 13:07:03 +0200
Message-Id: <56a5c6ea32166aaaf1a0bf89d27ea822a0ebdaff.1666868739.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666868739.git.dsterba@suse.com>
References: <cover.1666868739.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The semantics of the two members is a boolean, so change the type
accordingly.  We have space in extent_page_data due to alignment there's
no change in size.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4b47bb8c590f..1f83610d3491 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -105,10 +105,10 @@ struct extent_page_data {
 	/* tells writepage not to lock the state bits for this range
 	 * it still does the unlocking
 	 */
-	unsigned int extent_locked:1;
+	bool extent_locked;
 
 	/* tells the submit_bio code to use REQ_SYNC */
-	unsigned int sync_io:1;
+	bool sync_io;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
-- 
2.37.3

