Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1F6491DA1
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 04:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346729AbiARDk2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 22:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354497AbiARDG3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 22:06:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6701C014F2D;
        Mon, 17 Jan 2022 18:48:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A27DAB8123F;
        Tue, 18 Jan 2022 02:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECA2C36AE3;
        Tue, 18 Jan 2022 02:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642474129;
        bh=cNui+YkB5Y2agNwARKZTbHINIQ67HilcXWGYp+VJqsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHupozQXuP7kkZNhazBgzkoj/een302p9+Ekl+BpjHYAg0Z0YsUFyO/rKmSz3hBm1
         YUfou5sGY58x9Mu0Qx0i1rIHG4n+nsnFkgc8VF4KgICenSwRxIwZ0HMZLD570EgftA
         MgeSsy4U28pu0tPOm9RwsZh51eQaPQEn5YL3Mi/DrifknWs7Y8SXECny05ZwiP7Tkv
         IZtUIx3tyzD43KACgXMyBIkkNuk21mShNPvoc94+tROT1FWj62PJYIN/mYHJ/bvTH6
         PQ474PyLBNdlbxX7lU/mjOoHF81LLyvCy1lOW++w9wpXjcg5LE8uTIJw/9qj1MyZZ5
         I+znw8bQ3GI2Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 48/59] btrfs: remove BUG_ON() in find_parent_nodes()
Date:   Mon, 17 Jan 2022 21:46:49 -0500
Message-Id: <20220118024701.1952911-48-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118024701.1952911-1-sashal@kernel.org>
References: <20220118024701.1952911-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit fcba0120edf88328524a4878d1d6f4ad39f2ec81 ]

We search for an extent entry with .offset = -1, which shouldn't be a
thing, but corruption happens.  Add an ASSERT() for the developers,
return -EUCLEAN for mortals.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/backref.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 6b8824de2abb2..0073182d4e689 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1160,7 +1160,12 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
-	BUG_ON(ret == 0);
+	if (ret == 0) {
+		/* This shouldn't happen, indicates a bug or fs corruption. */
+		ASSERT(ret != 0);
+		ret = -EUCLEAN;
+		goto out;
+	}
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	if (trans && likely(trans->type != __TRANS_DUMMY) &&
-- 
2.34.1

