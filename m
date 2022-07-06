Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3268B568340
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiGFJN0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 05:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiGFJMj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 05:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F9B26AD5
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 02:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 882D761AE4
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 09:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECBDC341C0
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657098593;
        bh=nThNOVP3KB1tTCzi9KhuZUxY+14D+xae1rR8MxiqLUU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Lagx1w3vcG96ni970yIFDZp/Pd+GOJxrntniXKDVKBeeKT0t0XjhN0TO3xpROkQMe
         Of51TwGU0zqZGIJ/RDNOT439EvEQoMiABvbvQADI/z6Y07QeOYHXuDXO/k6CJ/F2/I
         gJJRvNvFT41BfMbPOrSGPK67qs9OKy96xq6boDjIgN8IHK9jKYK3W0b1gmoz2IPtdW
         CMR4T/lKWmBoSW3rgNhXmmqPj4F2RTCI4RfI9UV8/TTShQ0PagoS2yDiOLM01n4D13
         F9f7dFfDsKjsiOKRQt3Vt3zch6GykX0O+z6sedue/YAB1J/f/dXfTKrT4pgsvaSp4w
         tpW/9/MRyeTEA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: free qgroup metadata without holding the fs roots lock
Date:   Wed,  6 Jul 2022 10:09:47 +0100
Message-Id: <216b5bd4a975fc9dd462e3f9ce6af8b66a16d039.1657097693.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657097693.git.fdmanana@suse.com>
References: <cover.1657097693.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At commit_fs_roots(), we are freeing the per transaction qgroup metadata
while holding the fs roots lock, which is not necessary as it does not
change anything in the root itself or the fs roots XArray. So change
that to be done without holding that lock.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 1283be132776..e014b5d8a813 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1447,8 +1447,8 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 					&root->root_key, &root->root_item);
 		if (ret)
 			return ret;
-		mutex_lock(&fs_info->fs_roots_mutex);
 		btrfs_qgroup_free_meta_all_pertrans(root);
+		mutex_lock(&fs_info->fs_roots_mutex);
 	}
 	mutex_unlock(&fs_info->fs_roots_mutex);
 	return 0;
-- 
2.35.1

