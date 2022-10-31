Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A84613E4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 20:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJaTeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 15:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaTd6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 15:33:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0C513D2C
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 12:33:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 857641F45B;
        Mon, 31 Oct 2022 19:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667244836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PB656fbs8zEZy84sXm6lRLo/pMgC4WJ+8jjIyAjW3II=;
        b=gB5bvUEy4aSffbWMtY8Ih5xTHaiB/jyO32L2DYXXGihZaQROXxfnCJT9+KANDCkX02rXmL
        b+NK1utkUiIiHWUlcRAvsDJIlvyPFdkKLL8jwne2iKogJmPMVLqh0ZvAiJGrvLDXaAze4H
        IHK6YWm6AN9K26mJ1F6jrOvVbvyLAB8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7D7842C141;
        Mon, 31 Oct 2022 19:33:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6787FDA79D; Mon, 31 Oct 2022 20:33:40 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/4] btrfs: zlib: use copy_page for full page copy
Date:   Mon, 31 Oct 2022 20:33:40 +0100
Message-Id: <5f5b4513ded109bd87c5aa5105608fa8363d72d2.1667244568.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667244567.git.dsterba@suse.com>
References: <cover.1667244567.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The copy_page helper may use an optimized version for full page copy
(eg. on s390 there's a special instruction for that), there's one more
left to convert.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zlib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index b4f44662cda7..c5275cb23837 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -155,8 +155,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 					in_page = find_get_page(mapping,
 								start >> PAGE_SHIFT);
 					data_in = kmap_local_page(in_page);
-					memcpy(workspace->buf + i * PAGE_SIZE,
-					       data_in, PAGE_SIZE);
+					copy_page(workspace->buf + i * PAGE_SIZE,
+						  data_in);
 					start += PAGE_SIZE;
 				}
 				workspace->strm.next_in = workspace->buf;
-- 
2.37.3

