Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB366C300A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjCULPI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCULPA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506DB2ED72
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8104F61B18
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E68C433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397259;
        bh=omYWRS+633ABZzbNsfh7CvBQsTvK758ID5Da2jNK4Dc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ca5NbL5rkgaxMrqyQjI03wkGTlC358fp1QPf7IrPLBB0LdUmRp7nop15OonK2kpNz
         z7l7r2YoCPJoG+veMr1ksD832o3O4YaLIXYn2EfCsGnuxuxcy+QKhk2Ff0+UBZKE4E
         WoYGaOFRqG2tY2kLpYB3R0nVzLX4hdhrckULxqLIm/ZHjGtFThNdSRaUJnFwVFkgz9
         uzw9WQTtqzpTYAcHQtFMDF6VfMK1v2eyv5eL3pMKEMNtAaHkShzLFAlP9NWYsX+4ts
         3jNgk5y5Rs/Ryz8ba/hOmCg7OfgsZvghI9hPNHNg6vMEix3FXayxkFgCS+PPB+ddzp
         HNzmoVJzs2Ygg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 17/24] btrfs: constify fs_info argument of the metadata size calculation helpers
Date:   Tue, 21 Mar 2023 11:13:53 +0000
Message-Id: <9a763409b806ae4e3be981a554628e6f7dcb6fe6.1679326434.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
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

The fs_info argument of the helpers btrfs_calc_insert_metadata_size() and
btrfs_calc_metadata_size() is not modified so it can be const. This will
also allow a new helper function in one of the next patches to have its
fs_info argument as const.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 492436e1a59e..0ce43318ac0e 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -822,7 +822,7 @@ static inline u64 btrfs_csum_bytes_to_leaves(
  * Use this if we would be adding new items, as we could split nodes as we cow
  * down the tree.
  */
-static inline u64 btrfs_calc_insert_metadata_size(struct btrfs_fs_info *fs_info,
+static inline u64 btrfs_calc_insert_metadata_size(const struct btrfs_fs_info *fs_info,
 						  unsigned num_items)
 {
 	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * 2 * num_items;
@@ -832,7 +832,7 @@ static inline u64 btrfs_calc_insert_metadata_size(struct btrfs_fs_info *fs_info,
  * Doing a truncate or a modification won't result in new nodes or leaves, just
  * what we need for COW.
  */
-static inline u64 btrfs_calc_metadata_size(struct btrfs_fs_info *fs_info,
+static inline u64 btrfs_calc_metadata_size(const struct btrfs_fs_info *fs_info,
 						 unsigned num_items)
 {
 	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * num_items;
-- 
2.34.1

