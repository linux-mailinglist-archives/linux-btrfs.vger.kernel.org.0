Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020EB5F9CA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiJJKWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiJJKWj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB2552810
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD9760EB1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D484C43142
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397351;
        bh=KLOatonutJdhc2zQ41HbfT1Fc5B9bIxn0dHI21Nma6w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fZX6+AN7bG/3kf08O3B3OHz5kk/LKOW1IoHkHIuFqXRGPTNYA8qhLzpjZEGfVBXtV
         NuUTes2gFkOcE43ZnvYATLW49Aut6jGbRNgCW4rcxmHXgXCKJL3SY3ErSjXxuEAGuT
         v8WdGL0TFbEMNJJiiPh5nAS9th9cxyCCEj1Ipz9DkCWS6Pw+ONc2CmGNE5cvwM6+/F
         1oFFIa4RkNOnKyHTUf4Siqoor/r/5FAQy8qeFdveLT2wZUSoneKtgriC7hPdUayOXM
         7YivwIS32sszbjnw9FWSicy+EfLdEbehjlvB/OjbrGUdaIylvFKiIDDZkPH/Zf0trU
         k9iVWX84mk0jA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/18] btrfs: remove checks for a 0 inode number during backref walking
Date:   Mon, 10 Oct 2022 11:22:11 +0100
Message-Id: <c2d41be4cb9a0cc789e7581063df74f33ec17c88.1665396437.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665396437.git.fdmanana@suse.com>
References: <cover.1665396437.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing backref walking to determine if an extent is shared, we are
testing if the inode number, stored in the 'inum' field of struct
share_check, is 0. However that can never be case, since the all instances
of the structure are created at btrfs_is_data_extent_shared(), which
always initializes it with the inode number from a fs tree (and the number
for any inode from any tree can never be 0). So remove the checks.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index c112c99af1a1..bc3345dae381 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -887,7 +887,7 @@ static int add_delayed_refs(const struct btrfs_fs_info *fs_info,
 			 * Found a inum that doesn't match our known inum, we
 			 * know it's shared.
 			 */
-			if (sc && sc->inum && ref->objectid != sc->inum) {
+			if (sc && ref->objectid != sc->inum) {
 				ret = BACKREF_FOUND_SHARED;
 				goto out;
 			}
@@ -1023,7 +1023,7 @@ static int add_inline_refs(const struct btrfs_fs_info *fs_info,
 			key.type = BTRFS_EXTENT_DATA_KEY;
 			key.offset = btrfs_extent_data_ref_offset(leaf, dref);
 
-			if (sc && sc->inum && key.objectid != sc->inum) {
+			if (sc && key.objectid != sc->inum) {
 				ret = BACKREF_FOUND_SHARED;
 				break;
 			}
@@ -1122,7 +1122,7 @@ static int add_keyed_refs(struct btrfs_root *extent_root,
 			key.type = BTRFS_EXTENT_DATA_KEY;
 			key.offset = btrfs_extent_data_ref_offset(leaf, dref);
 
-			if (sc && sc->inum && key.objectid != sc->inum) {
+			if (sc && key.objectid != sc->inum) {
 				ret = BACKREF_FOUND_SHARED;
 				break;
 			}
-- 
2.35.1

