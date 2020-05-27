Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996511E3EC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbgE0KPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387852AbgE0KPx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:15:53 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB8F0208B8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 10:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590574553;
        bh=ottdDgRwXyDbwhf38e1U1M6jpsj4eWQS6cB9EJbfpVo=;
        h=From:To:Subject:Date:From;
        b=Ush9yDeQR9uLw1g5VUNRwJZmm6vkMoYdvoFiMsRCIc+30+8x2GTOR0uhmccM1OBNg
         YTizDyuXvBnKuqy24q1FRtpSHru2lftIP2OEL1l6AOpd2IKu6v6Cngg+dK/onaFRau
         XgcZyiLVxd1fSPyxl/+5VWDvqC5Jfb75MTJZVg/M=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] Btrfs: fix wrong file range cleanup after an error filling dealloc range
Date:   Wed, 27 May 2020 11:15:53 +0100
Message-Id: <20200527101553.25396-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If an error happens while running dellaloc in COW mode for a range, we can
end up calling extent_clear_unlock_delalloc() for a range that goes beyond
our range's end offset by 1 byte, which affects 1 extra page. This results
in clearing bits and doing page operations (such as a page unlock) outside
our target range.

Fix that by calling extent_clear_unlock_delalloc() with an inclusive end
offset, instead of an exclusive end offset, at cow_file_range().

Fixes: a315e68f6e8b30 ("Btrfs: fix invalid attempt to free reserved space on failure to cow range")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 320d1062068d..79f833f920d3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1142,7 +1142,7 @@ static noinline int cow_file_range(struct inode *inode,
 	 */
 	if (extent_reserved) {
 		extent_clear_unlock_delalloc(inode, start,
-					     start + cur_alloc_size,
+					     start + cur_alloc_size - 1,
 					     locked_page,
 					     clear_bits,
 					     page_ops);
-- 
2.11.0

