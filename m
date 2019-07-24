Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6849372443
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 04:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfGXCLk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 22:11:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36955 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfGXCLk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 22:11:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so20073537pfa.4;
        Tue, 23 Jul 2019 19:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vYCyXyUlEJ+5pTzzjpf+4+GCCP70bZjgS7B7HXVmbtA=;
        b=otq0W+OrGNxxvqCa1TtufSkA9JzZzKD7d5er425UOQKMWYquzFbYe+GOJPkzjOyv1D
         LDbsOyMfu+uRsxjVwMzU021cUVnI8iWMV5k6XdQIO3kFfBrQbPqWQRC4MzIgPz/+SgWy
         TZdp5ZScXcnkyJ5tjmsQxOoOUIk7MFE8LyVI9CKUjlAJmP2yeGrB5k37HZ9qG/AN6tdu
         XkM9NtSsGbXc46WuKuB5b8XtD0CJSyXgxAnqB4jytsSt8GEhPIlpMA+HISSXJe7m0b0b
         iRIt9O3Ag4AOr0BD+qRLeyjM80NJ63DcPNVaOEwIBptTUB5uopMZ1aZlmBQndpOxGtEN
         fdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vYCyXyUlEJ+5pTzzjpf+4+GCCP70bZjgS7B7HXVmbtA=;
        b=tKd6ekwZEcEil/KIVApFIxgcpwHe+gy3PsxNSabTfbvxX7TJ/Hz5mG2APshzfWnn6d
         SBgSjci4KAvsMkBykpcqPt4GkpHznhYrWOEof7OAZ6KWacd9KZUz6yUz5o8neqXPqOdY
         cd29uwkktnw3wb9uHQxSxJkRr5ZikA5EUBB3TrtKu7NFpwohCbKrGiwhfGbO9PeuicFZ
         qHKLR5Y2dkwA52ROsYPLwcehNlpxfWVGFeTcpZDElKal/+TZhOzesEZBN+ABfREUOmHB
         b+nFiNwVNNk9NaqbsjDRpuGlzhLdi7X4pQj3klJ2KcI/nyaNLn+7RfQUv/yagJn9Xq2t
         pz6A==
X-Gm-Message-State: APjAAAVLDhb9AOdXTbYyCCRVQX/V4E60vS6aqj9J4HnLgmqVD54teLNB
        nfIAIZ0oU0D4oLgUJZgQrFQ=
X-Google-Smtp-Source: APXvYqwZJrpSWCYWG8akdfq3HnBSbqCnDpq/7f+zse9/+/Jb4APq1dD4/PpozYP8ga0yqHxnZ98dZw==
X-Received: by 2002:a63:f13:: with SMTP id e19mr78828781pgl.132.1563934299784;
        Tue, 23 Jul 2019 19:11:39 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id j15sm65783194pfn.150.2019.07.23.19.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 19:11:38 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: btrfs: Fix a possible null-pointer dereference in insert_inline_extent()
Date:   Wed, 24 Jul 2019 10:11:32 +0800
Message-Id: <20190724021132.27378-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In insert_inline_extent(), there is an if statement on line 181 to check
whether compressed_pages is NULL:
    if (compressed_size && compressed_pages)

When compressed_pages is NULL, compressed_pages is used on line 215:
    cpage = compressed_pages[i];

Thus, a possible null-pointer dereference may occur.

To fix this possible bug, compressed_pages is checked on line 214.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1af069a9a0c7..19182272fbd8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -211,7 +211,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		struct page *cpage;
 		int i = 0;
-		while (compressed_size > 0) {
+		while (compressed_size > 0 && compressed_pages) {
 			cpage = compressed_pages[i];
 			cur_size = min_t(unsigned long, compressed_size,
 				       PAGE_SIZE);
-- 
2.17.0

