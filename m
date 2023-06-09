Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63904729260
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 10:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbjFIIMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 04:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbjFIIM0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 04:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA6D210C
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 01:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10F1265468
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 08:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFDEC433EF
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 08:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298344;
        bh=5ZWnkFzqZo3dWQ/fUbAUTjSK/+/0xvBDH/kAGy3vCGw=;
        h=From:To:Subject:Date:From;
        b=l8z7CiHaqnOvGeWe4q/4ByFXpWoweBXufPo7cWFdOZ+Qd6gneybgQ3wSeHOG1hwo1
         plWnT9Bz84XLeV6JGWi0QG7zJ+S0AbPJ1AHD/W7CfVUDKxryWkrmnuvJGFNfmBH2Oh
         +Xqyg5IsST6Zd3TamtgcyMyl/vMwxfRbPOpnR4zU7AuspCaWJfXEJ+L0JGaM3/II71
         jJe0+054JrwtCWOmWO8NeMQgVTmQJximx0vxaNm4PAOIyU/i4fm/d8fQUwVrAwQeM8
         dxKI7l9cfAtpWo2wRWOId40QbbcGWbFsXmIKKxwdjMw1rCO9KTetG46h1Fe20p+uDx
         JcXRywmV5xK5w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: always assign false literal to ref head processing field
Date:   Fri,  9 Jun 2023 09:12:21 +0100
Message-Id: <0a50236c4f79f588c48f44dfd80519423bbacb1c.1686298104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There's a couple places at extent-tree.c assigning a 0 to a ref head's
is_processing field, but that field was recently changed from an int
type to a bool type (patch "btrfs: use bool type for delayed ref head
fields that are used as booleans"). While this is not a problem in the
sense the end result is the same, as a 0 is equivalent to false, use a
literal false to make the code a bit more clear.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

Note, this can be folded into patch:

  "btrfs: use bool type for delayed ref head fields that are used as booleans"

 fs/btrfs/extent-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index effb01749a24..911908ea5f6f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1745,7 +1745,7 @@ static void unselect_delayed_ref_head(struct btrfs_delayed_ref_root *delayed_ref
 				      struct btrfs_delayed_ref_head *head)
 {
 	spin_lock(&delayed_refs->lock);
-	head->processing = 0;
+	head->processing = false;
 	delayed_refs->num_heads_ready++;
 	spin_unlock(&delayed_refs->lock);
 	btrfs_delayed_ref_unlock(head);
@@ -3211,7 +3211,7 @@ static noinline int check_ref_cleanup(struct btrfs_trans_handle *trans,
 		goto out;
 
 	btrfs_delete_ref_head(delayed_refs, head);
-	head->processing = 0;
+	head->processing = false;
 
 	spin_unlock(&head->lock);
 	spin_unlock(&delayed_refs->lock);
-- 
2.34.1

