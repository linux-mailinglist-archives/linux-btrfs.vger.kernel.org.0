Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F165FB23B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJKMRa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJKMRX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C214B0D6
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9CB7B815AE
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467CAC433D6
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490640;
        bh=xF9/R7YVjtghfkYXEeRbo+TbuqPX3iNh3BFvcCajNc0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=utiJ1hCbfJQaFYzyi0ToHlyHrPPqNuqIXV5vgsufTJNgWYGPgnad2kXvNRyszTYzt
         /1NfcOM4qz3kZxEEtexs6nFtTjjfhH9KlDnLdDmbvoAiHHqgnlW/qBjTk6V28jMB2l
         fMA22P6dSju+kCgJAiZRa2q3vuFuBe0E/A+oJd7E3xYqN5zP9W8mWwl9y15VfTQv60
         tk0IQ05MQeQZfIhIWyw5IlHjR4OHs2uV0cLI37TYWqDxFrBzBXhWxrf5XB7NHj4bbp
         50YaW/khmmr9KLENdz8j4PGc5bHV7mUH5n2FfihqeWgd1a6poB7XfB69JfwciAAoM6
         CZtgdO/eB/rPg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/19] btrfs: remove checks for a root with id 0 during backref walking
Date:   Tue, 11 Oct 2022 13:16:59 +0100
Message-Id: <f5496a81ec0a5d9590fd7de1730f0dd9a46777c6.1665490018.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665490018.git.fdmanana@suse.com>
References: <cover.1665490018.git.fdmanana@suse.com>
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
testing the root_objectid of the given share_check struct is 0, but that
is an impossible case, since btrfs_is_data_extent_shared() always
initializes the root_objectid field with the id of the given root, and
no root can have an objectid of 0. So remove those checks.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 4ec18ceb2f21..4757f9af948a 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -705,8 +705,7 @@ static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 			continue;
 		}
 
-		if (sc && sc->root_objectid &&
-		    ref->root_id != sc->root_objectid) {
+		if (sc && ref->root_id != sc->root_objectid) {
 			free_pref(ref);
 			ret = BACKREF_FOUND_SHARED;
 			goto out;
@@ -1330,8 +1329,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		 * and would retain their original ref->count < 0.
 		 */
 		if (roots && ref->count && ref->root_id && ref->parent == 0) {
-			if (sc && sc->root_objectid &&
-			    ref->root_id != sc->root_objectid) {
+			if (sc && ref->root_id != sc->root_objectid) {
 				ret = BACKREF_FOUND_SHARED;
 				goto out;
 			}
-- 
2.35.1

