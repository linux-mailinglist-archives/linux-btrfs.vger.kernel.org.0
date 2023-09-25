Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF7A7ADEC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjIYSbV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 14:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjIYSbU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 14:31:20 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E45E95
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 11:31:13 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id CB0AC3200947;
        Mon, 25 Sep 2023 14:31:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Sep 2023 14:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1695666670; x=1695753070; bh=G5xZIgMutn
        9i9f836/dr6QuYj4QT7x6/+oRcyN9uoCc=; b=Jqc8qur5IHszRaGN1hjpdNOr6Y
        iis3dap1oTpQTeBVfEL+C7EzcJxMu7WvxM4DbQRVrd3tUugvqX2LpNo+RXWxVMWe
        I5LblAL2idYJGvJC/+/w3n6I5JlsNr9wA8lRRGivVYKPelSwasIA/dUNqEzIs7ZY
        EnZhLImCqYF/IBtZrmZ/4Fz6X95cnDDMp94vSaaKzCYpeZZFSfgYwl29XVKoiFQp
        AjtdW/XRZUzIirHCPNQj6bb3kADrt0r/hZfAKblW/RrCKvMbQqAZUpntySL+fmIr
        9xaIcU0x8qHkx5c5BoLpfSEBFfJkQcw2qBby+I2oCAipcUf7a3VwN8/lQLmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1695666670; x=1695753070; bh=G5xZIgMutn9i9f836/dr6QuYj4QT
        7x6/+oRcyN9uoCc=; b=eEBZKD6sGVqYv0jAA8v0DpFJVckD+rw6pvAv/axsDyxe
        TqLdv/25TZJC7Tp7Gf0uDQgA7gNpHEMQEulpjmDw+etRnIK4SE/grEgJJpCRel1B
        mbeICaLAixTxf0ZSf+X7FrGoSyXWt03GbUUvt0bgKgiGDPXzSkn4jZVwsCpJA3/U
        1zuWX6OJjnn/Wkb1MVmfw0cs2VDp6ndoBcnmrUi7KEf0oyZRYgoN/Nqu/VUCbUwE
        b/DGyHfUePlpkIw7zjDPV+LjlEOOKYyErQ9qqKzd0xXVxeOL32pGspUU63LHWCbW
        JBCRpZNhkkZZcX3rgNnH/F3HDHTtEHQXVMf3BIIqpw==
X-ME-Sender: <xms:7tERZTTB_9qGpsnsNWz4o7ogo6C_-ZXqZr3BOkkbPwSp1t5cGdNkmw>
    <xme:7tERZUwXYIJfQoVaBatxe2PsTRdT2HrM_OqSA2pGo4AYIr-pBvQe936bjBO_gKMpv
    iZYUkJ6OHzncIZMots>
X-ME-Received: <xmr:7tERZY2LSDGHQJrG85tZatJ1Ih13buxcV7fqrw_rw4KrBN5oJGI5hzqPh-HUixYhWOc7AOSlOYSya75ZT0QGEwIxLQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeltdffhffhvddtfeegvdeiteelieejjeeitdfhfe
    egkeehveehkeejleekgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:7tERZTCFI1oAQQONJhPbXnvgBWvOgjo5b1Dt4znC9i_Qyi5bmHCXUA>
    <xmx:7tERZciZTO8qKC6Vtb5e_EtoC13_z-0SGm_AKEs9mQ3QBlDFHdgvsg>
    <xmx:7tERZXrGDWsAVo_hcYdEmqaNqYUd3I5CZQpsnnDKc1UY1EffyQVpWg>
    <xmx:7tERZUKttE_RDS9jnfBC1MS_BHNC94khOAs3ZEF4kCJtN5ytO5hvjw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 14:31:09 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: qgroup: fix use-after-free in btrfs_qgroup_inherit
Date:   Mon, 25 Sep 2023 11:32:07 -0700
Message-ID: <26e6880fa1dabf3771519fb86ed96b15e6b292a6.1695666651.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a new subvolume under simple quota uses the auto inherit feature, it
will free the temporary auto inherit struct before freeing
qlist_prealloc. The latter reads the inherit struct to see how much to
free, so this is a UAF.

Fix it by freeing the inherit struct after the btrfs_qgroup_list.

This can be reproduced by running a simple quotas test with KASAN
enabled. The test is not yet in upstream fstests, but can be found in
this patch:
https://lore.kernel.org/fstests/a7f4e4db-37a5-3685-4621-99b05343a864@oracle.com/T/#u

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202309230501.FnBPmnOv-lkp@intel.com/
Fixes: 356d8a464995 ("btrfs: qgroup: simple quota auto hierarchy for nested subvolumes")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ff470afeea7c..1a486d8a7b5a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3310,13 +3310,13 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (need_rescan)
 		qgroup_mark_inconsistent(fs_info);
-	if (free_inherit)
-		kfree(inherit);
 	if (qlist_prealloc) {
 		for (int i = 0; i < inherit->num_qgroups; i++)
 			kfree(qlist_prealloc[i]);
 		kfree(qlist_prealloc);
 	}
+	if (free_inherit)
+		kfree(inherit);
 	kfree(prealloc);
 	return ret;
 }
-- 
2.42.0

