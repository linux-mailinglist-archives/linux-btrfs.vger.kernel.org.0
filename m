Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1AF7AED1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 14:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjIZMph (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 08:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbjIZMpf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 08:45:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBA310A
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 05:45:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25874C433CA
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732328;
        bh=E1HcVfdQdZW2Bmxub4BO1QP38sBF6ilOjbghlsV3yLE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Fr+eUa82jaD3ETxawMg2S9wWZ1vq6LZ0J4pOxtw8WDbYQyscJ6KaxArg4lUs8PVj7
         zW33vXByfz7EJbew5HS6lbc7SUay/HsXd6IPqMBMQDK/+wX04qFcH47/MNgagRj7UP
         EYCl7qY1NUCtkv+KvC65mW89I9CVzYfpdo6Knr6x3D85I2duvPk+gFhNeHoG4G+jY2
         6F9HfvX+3YXHlvMG8aakAdw0/RpAJq+0kmJZF92q7SiG9rcKGHAxnynzHjJvM6Jytp
         kzJ2yj3p/QhU0BZqrJRLKOZzThGCjve8ZA9Tjv7gxQaNv0C7GyZEhTt3K0JbFCbjRJ
         Gv8f9vs2Q1GPQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: use round_down() to align block offset at btrfs_cow_block()
Date:   Tue, 26 Sep 2023 13:45:17 +0100
Message-Id: <fbeeb5bca850f70e3e01744130d05239e5267c9c.1695731843.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695731838.git.fdmanana@suse.com>
References: <cover.1695731838.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_cow_block() we can use round_down() to align the extent buffer's
logical offset to the start offset of a metadata block group, instead of
the less easy to read set of bitwise operations (two plus one subtraction).
So replace the bitwise operations with a round_down() call.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 602da318ba11..9849477c5e19 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -712,7 +712,7 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		return 0;
 	}
 
-	search_start = buf->start & ~((u64)SZ_1G - 1);
+	search_start = round_down(buf->start, SZ_1G);
 
 	/*
 	 * Before CoWing this block for later modification, check if it's
-- 
2.40.1

