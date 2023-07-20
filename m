Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D108A75BACF
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGTWyu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGTWyt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:54:49 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A7F30D0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:54:28 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 613DA5C018B;
        Thu, 20 Jul 2023 18:54:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 20 Jul 2023 18:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893667; x=
        1689980067; bh=FA2ij8OqublvACzxe7mIgdfXV8I9eHgXi7D+L0QbFO4=; b=X
        epuKDBwQo8YOzkPirCjaI8nclnItfEeiULeIgtFJj1abTEbOu9NJtZ0oSQGQDGLK
        HPQ1e3Fzk92vZBsXKbPo3apP8XZ8THSTsxym9eIUdmIkXpQaMmN6JEW7w5/K4uCT
        kaLTDvq4xeQPYrN+U63FZjiwZR9Z+8LAVEvzmrdBHdqhlhTVR8AGQnIYmFNYkU3D
        7uf5Q9AjZR96uxHavdg0Wv8hIRmDJycXblQfSHwsfYFkfo5ZE1rWEkjHI4eCahik
        Dvz00uSJZLNMMLhqHQXWIgSL6ltewALP3iy/njb/D2U6nlAJ4XK/s90O5rGxHBar
        AaNSkEFi3AUjOF4EhbSEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893667; x=1689980067; bh=F
        A2ij8OqublvACzxe7mIgdfXV8I9eHgXi7D+L0QbFO4=; b=ZqFK+4+gsgSw9dMkO
        CxxqPu36TIlBg5Ur3rhcI/4UoMV/IF9z6gWwSXEqSVwiDXR7/buIFgIEDOUu4VZN
        V/oRB5+mTpdu8LhqWsVKw3dvAWRpDVI3+WqwqgGR4i8NGcfz68ItS8Pe5Z9vZHXD
        JV0YK6/EgKNamFr8VN4XaV9E8kly6zjOibpJ8e//ZQlOKtaslj0GcAQTA96uW4s3
        dmuDPyKNg5DT2PeQPKmZCa1YrfljdMJY6/7VR34NILwgUy1Mnpkmv98t7lvvB6jo
        AlbqKqjs/kJlTo3RtI0vHr68GOSDXa0iFFl16/bjGdibJfMfgR5vM5/Q5D5K3RFx
        rW7sw==
X-ME-Sender: <xms:I7u5ZF3NHWcSapnsMFTBFXklyTnE267W3Rnf9Lk7qiBbttW2w4_GnQ>
    <xme:I7u5ZMEa5O1lJ6OhLG9A58fdK8wv6edLbIi8VuG0IzJEa31JM8MNI7vhp8M-VFfQJ
    d61CNa5gBR1C0Cz01M>
X-ME-Received: <xmr:I7u5ZF4idTmupvd0IIQ3CuLFf-jLHIfgZvX-jaMHLjqwA3DletyMqPoatJ8r3jwLdwp_E4Cy6sjjfin4qc1K5lUuNOo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:I7u5ZC2CSyvay_MK4GZoGlEDfzsgZ3WoWxnZf1bhIyoKcrxoIk93zQ>
    <xmx:I7u5ZIGf2okMCi63EERGIY2wwM_U3IdVIEYxDtHUusgjD-WPwSgA7w>
    <xmx:I7u5ZD9sNod5JIWaQYgfmcF3eYy5dsCDiPBwwh8J9NrHrQ1MiiyDqQ>
    <xmx:I7u5ZDPtVKozO5nZcm_ei54mB3On6abUjz3KIpBRr49jCKk_Gc8Xcw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:26 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/20] btrfs: free qgroup rsv on io failure
Date:   Thu, 20 Jul 2023 15:52:29 -0700
Message-ID: <a260b7a8e02aa9deca066f9dcc53b2ba028f6d42.1689893021.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893021.git.boris@bur.io>
References: <cover.1689893021.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ebe70ed96f25..6daaa4fd69f2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3358,6 +3358,13 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
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

