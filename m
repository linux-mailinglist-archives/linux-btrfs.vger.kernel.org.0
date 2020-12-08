Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A52D2F76
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgLHQZa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbgLHQZ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:29 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62684C0611C5
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:27 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q22so16437684qkq.6
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vx6FQGPAtVmSplymEMoDA9sA2iSVI0CL70LRafsPBms=;
        b=J/WlXtf3QCM8Eq3RyKuvVelx8MAHO66kGJB6x2Hi8wdmwuax1jmT89cIPYMzeFn1ga
         PjZunewi9D3tVUYj66+cirNBN9UE2rDeXaLCqfSqstCZaED4cDwSigbNNRSSctWLjTGQ
         hRxEY6NzL/gSQxW9yJQb7HOcvfFp/kBFCpXZNJUJiY85YMqojKEsOBBFtFLyPMPhZ56m
         HnhG36ofebufuflVCRpfrrDsKpsp7JLJiSCRFkEncaIvgcn92zo1L8JxKyRg4jc1R3u6
         UTP7rx73txV1PRAAJViPd0kYdZmhA2WTGLALwLejDSbftvFDBnc5939t/5NURKNE3BK2
         acxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vx6FQGPAtVmSplymEMoDA9sA2iSVI0CL70LRafsPBms=;
        b=rYue+517dp+W6QAcUna7iqjDYo+ID1OrH7XnRgXTPRfUULjlhoTwABX/2Y2PMupgwj
         4cNO+1bmGN8J1SCUlqUoY7oOYOTgrdlUSaZDMHc+SQSR5MYqbKxK2Ejhn+okx57WzIN6
         HYypTSLuR26HF1es8eAADEmEQDCHO1zmsW0cS7zCpSjl8ia4X2F5UsPqfH1egOdp7Rr7
         u2zXWESdkgcUTRyLnIYs7MKOtIxUnu3hMZ1CYib43ItmqGyjwCPF2PmJ37SWWweULebg
         rS/Q3LNZJjePfjwHzVceBuKBCnDZE/WB0y7XEm3kwQc7/HsKVR2NTgUR5C7OBuDI0xXN
         CKgw==
X-Gm-Message-State: AOAM531ttlCv/BeZAhLMBiyO+VR8SFTVf0oo6rW5FwMiYj9JOxu6BCgv
        cDPXzeS+9ADA0p4s+QJAW4pYYgr/N+fshsAX
X-Google-Smtp-Source: ABdhPJxKPTP76CvNrGc2iSyGVS8CWhPBHXd+nzO79Kgx3XpsEVYbLkSjSVPybQ6w4IsHN5phsV4V9w==
X-Received: by 2002:a05:620a:630:: with SMTP id 16mr7510909qkv.230.1607444666175;
        Tue, 08 Dec 2020 08:24:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x65sm748119qkc.130.2020.12.08.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 11/52] btrfs: convert BUG_ON()'s in relocate_tree_block
Date:   Tue,  8 Dec 2020 11:23:18 -0500
Message-Id: <1d90d8f0b061d0b009a753a6f51b648e0b41ebcb.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a couple of BUG_ON()'s in relocate_tree_block() that can be
tripped if we have file system corruption.  Convert these to ASSERT()'s
so developers still get yelled at when they break the backref code, but
error out nicely for users so the whole box doesn't go down.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d0ce771a2a8d..4333ee329290 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2456,8 +2456,28 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
 	if (root) {
 		if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
-			BUG_ON(node->new_bytenr);
-			BUG_ON(!list_empty(&node->list));
+			/*
+			 * This block was the root block of a root, and this is
+			 * the first time we're processing the block and thus it
+			 * should not have had the ->new_bytenr modified and
+			 * should have not been included on the changed list.
+			 *
+			 * However in the case of corruption we could have
+			 * multiple refs pointing to the same block improperly,
+			 * and thus we would trip over these checks.  ASSERT()
+			 * for the developer case, because it could indicate a
+			 * bug in the backref code, however error out for a
+			 * normal user in the case of corruption.
+			 */
+			ASSERT(node->new_bytenr == 0);
+			ASSERT(list_empty(&node->list));
+			if (node->new_bytenr || !list_empty(&node->list)) {
+				btrfs_err(root->fs_info,
+				  "bytenr %llu has improper references to it",
+					  node->bytenr);
+				ret = -EUCLEAN;
+				goto out;
+			}
 			btrfs_record_root_in_trans(trans, root);
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
-- 
2.26.2

