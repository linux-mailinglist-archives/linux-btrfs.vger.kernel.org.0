Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3167491BE
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGEXXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjGEXXJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:09 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7523199F
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8DC785C0283;
        Wed,  5 Jul 2023 19:23:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Jul 2023 19:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599384; x=
        1688685784; bh=65B4RDPqj4d2xwt0izRLno+OHGLMGrpNZjT9HMvRX+8=; b=S
        HyRoNn7qxUZKt1AkqwYSTy7YvoYFt0fTGKQcaXjL1DIfCI5NJ8ia6mxOraqdhlyG
        gsx6TOeBWkyG695PNGVG6mQrbdo0xV/bm9W2CupbUz28JLSli8+ntC+uISfcTqb8
        cCJNidl39Za1nY0cwH7wHEVkJ/IplylgBM46cejXsA4gVZ49sTJZpRBUXBgeQFpc
        IpEfykkQEnsyBxOJLGJOSb6YhGwnjCtNdl7kXFBiKVf1k/3D38YnNbJZGhf0TqN9
        ejpY8gG498hboNo7QWZ7GamlfERNu8kCe1TumdLmjCO1xmY+5Jo6Qjz9JFlyaOsn
        wb/8hIXRho+nDIvWh2dMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599384; x=1688685784; bh=6
        5B4RDPqj4d2xwt0izRLno+OHGLMGrpNZjT9HMvRX+8=; b=UN1hYZrW2/MkvbvDp
        G/izV48FGLKFYfIU7/d9Yn9ZaamtAJm4g2a0degxPaPJ04p69YNNjkkG1guGQXuG
        aKJfjBMO/S99JBJqvLWF6BfKV8JraBgNNE7wlUg9j2CFkM/OE7OyVtzY/T497G+m
        HKW4GHjLB13/zwQwSpNB3AhUh4CHgOPNpzim6jw2ly7kAxopFZGDVaiWxbyVUTa7
        XS/0G325C1zZrytbkVh48pGunBfC+OfiACmPNKWcYsH472nOnfrW6D3NEexVJSLk
        mWV6bt24+jIjelyPg3SchCZiCYmxG+FO/taYxZs65jdjCVNDkBCbICFewtEnNCqX
        CTygw==
X-ME-Sender: <xms:WPulZAhXkxsmIGt2TtKcs30YOhIa5IiRPrKF1Knc38e1nBOX0ewf_g>
    <xme:WPulZJBaQ5Hd214dTOcwBh-Om1UvfNvQvB0m7Qx7Qq7yFxvT8LcXA9wnP9BJouWxg
    75kG8cScAy_N81lcp4>
X-ME-Received: <xmr:WPulZIFHK7FBURkcOtkWlP21xVQFSragDRMQf3731nlXVPt1131dZuOtcUViEqaC2g4rneOn2w_Yvq8CAShwdIz1esE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:WPulZBTEel9oEG-U6T82gbAVKPsOCZfgJo914WTGJxCeHlmTXDvEFw>
    <xmx:WPulZNw4I0od1_68DTu_m6g_43PCJfyLB-n6ml5VmhB6d5REQCo9hw>
    <xmx:WPulZP55y-kuMa-L7-mbRFPNEoD84jDP99qcMPPLdqtY9VOK_Qadpg>
    <xmx:WPulZLZz71TeaicrERkEEygNFKl-3RE7irOofQwMm4onC9kpiUKEOQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:03 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/18] btrfs: free qgroup rsv on io failure
Date:   Wed,  5 Jul 2023 16:20:38 -0700
Message-ID: <860ef499b2c45e2798267dd323b1b991c2bac79a.1688597211.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688597211.git.boris@bur.io>
References: <cover.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we do a write whose bio suffers an error, we will never reclaim the
qgroup reserved space for it. We allocate the space in the write_iter
codepath, then release the reservation as we allocate the ordered
extent, but we only create a delayed ref if the ordered extent finishes.
If it has an error, we simply leak the rsv. This is apparent in running
any error injecting (dmerror) fstests like btrfs/146 or btrfs/160. Such
tests fail due to dmesg on umount complaining about the leaked qgroup
data space.

When we clean up other aspects of space on failed ordered_extents, also
free the qgroup rsv.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dbbb67293e34..1984e140ca46 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3359,6 +3359,13 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 			btrfs_free_reserved_extent(fs_info,
 					ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes, 1);
+			/*
+			 * Actually free the qgroup rsv which was released when
+			 * the ordered extent was created.
+			 */
+			btrfs_qgroup_free_refroot(fs_info, inode->root->root_key.objectid,
+						  ordered_extent->qgroup_rsv,
+						  BTRFS_QGROUP_RSV_DATA);
 		}
 	}
 
-- 
2.41.0

