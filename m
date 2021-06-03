Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6BB39A96E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jun 2021 19:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFCRpH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Jun 2021 13:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhFCRpH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Jun 2021 13:45:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0C3D610A2;
        Thu,  3 Jun 2021 17:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622742202;
        bh=rvR94S1Oz6oGe4J/URF8eCTPPc5ItykZNzgtCEMw5Ow=;
        h=From:To:Cc:Subject:Date:From;
        b=NkPOeYGrEaZmM2yT58PLAototna2HNPnXoU2tvPfyTCuiyFqiK9sbSEvQOycyf/VD
         8w+DIoaa8+pIQo5/RH12xAgRyUnzgvVsCUjYZOMNTWSKAE/QGXvZRSJdn981F3pvQf
         AD0/OJeszy/io8Nn+Fq/2l6pgHTebhlyVbJh70IDd7VhlRtiM2YwIzx8nv1yYz9oJ2
         3qI5WmzKyUZoMmD8HJ1/ATJ8COvnv8vPyepNDXZEH4PhgWfEmGx7qzQTxuZAnXuIuu
         d2pmYk/QReN1es4DpzResxf+b+1U2BoTDC5eIync0AdWsyZkmMC9c+6XHRIKgLCzGy
         unEW+/AvdxzqQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] btrfs: Remove total_data_size variable in btrfs_batch_insert_items()
Date:   Thu,  3 Jun 2021 10:43:11 -0700
Message-Id: <20210603174311.1008645-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

clang warns:

fs/btrfs/delayed-inode.c:684:6: warning: variable 'total_data_size' set
but not used [-Wunused-but-set-variable]
        int total_data_size = 0, total_size = 0;
            ^
1 warning generated.

This variable's value has been unused since commit fc0d82e103c7 ("btrfs:
sink total_data parameter in setup_items_for_insert"). Eliminate it.

Fixes: fc0d82e103c7 ("btrfs: sink total_data parameter in setup_items_for_insert")
Link: https://github.com/ClangBuiltLinux/linux/issues/1391
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/btrfs/delayed-inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 2c18ed23aa27..257c1e18abd4 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -681,7 +681,7 @@ static int btrfs_batch_insert_items(struct btrfs_root *root,
 {
 	struct btrfs_delayed_item *curr, *next;
 	int free_space;
-	int total_data_size = 0, total_size = 0;
+	int total_size = 0;
 	struct extent_buffer *leaf;
 	char *data_ptr;
 	struct btrfs_key *keys;
@@ -706,7 +706,6 @@ static int btrfs_batch_insert_items(struct btrfs_root *root,
 	 */
 	while (total_size + next->data_len + sizeof(struct btrfs_item) <=
 	       free_space) {
-		total_data_size += next->data_len;
 		total_size += next->data_len + sizeof(struct btrfs_item);
 		list_add_tail(&next->tree_list, &head);
 		nitems++;

base-commit: e1bde17d15921cc866d4ad10a16ce77487516bf7
-- 
2.32.0.rc3

