Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAC37A21B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjIOPDG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIOPDF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 11:03:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656AE2111
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 08:03:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B061C433C8
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694790180;
        bh=vgeV3QoPGAhkvazIme4uIk8fznd4ZZVKqohghhrlj4U=;
        h=From:To:Subject:Date:From;
        b=FxmgywAOn8Nt0yxmS6zptzZPtyOEGHp+Oqq9wKgQc37Nr6MV7S/+8GoBih5nNE/o1
         apAZkB1I2GvIswWooay/Yc6y2pCpXYP5DuCp+Rtshnw92QrIQMDfF/xUd/xgGLwhCq
         2WoNM0uDEuXBiy04ccVPdWaNHwtMz61gHWGHTDR1z1flOqyGHT2dmg+ECJqMstcYbj
         ziCrqVOWnm/EQhKV98q0an08MjlKfgMvVitoywZ65XQSJtau0ZzBakNiEdbZJMUpnt
         y9jC5btnjpv7EE0yVZGJ04HuBAJOWNnyIsgPTtT6/QpQKI1DLFm8yiCYbRX+gvNO1V
         KZA/D64hEuUTg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove stale comment from btrfs_free_extent()
Date:   Fri, 15 Sep 2023 16:02:56 +0100
Message-Id: <61aee02e43101491f4e83144fd58833f04848e16.1694790065.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A comment at btrfs_free_extent() mentions the call to btrfs_pin_extent()
unlocks the pinned mutex, however that mutex is long gone, it was removed
in 2009 by commit 04018de5d41e ("Btrfs: kill the pinned_mutex"). So just
delete the comment.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6ef7319bb7ef..1701aadbfea3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3375,7 +3375,6 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	     ref->tree_ref.owning_root == BTRFS_TREE_LOG_OBJECTID) ||
 	    (ref->type == BTRFS_REF_DATA &&
 	     ref->data_ref.owning_root == BTRFS_TREE_LOG_OBJECTID)) {
-		/* unlocks the pinned mutex */
 		btrfs_pin_extent(trans, ref->bytenr, ref->len, 1);
 		ret = 0;
 	} else if (ref->type == BTRFS_REF_METADATA) {
-- 
2.40.1

