Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5632C777C2
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2019 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbfG0IvV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Jul 2019 04:51:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36684 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfG0IvV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Jul 2019 04:51:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so25858632pgm.3;
        Sat, 27 Jul 2019 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=55lHtDMtjfNlskw3j+8zYPRK4+1cB7I6V8RARCYX3GI=;
        b=GzLD5ekhx8z/wb3QT917ttdtnrY+EQw9g4h227ZKoDRaDGntaoPSobxnJMTVxuAnLi
         Er+lioES9H6o9VYY+sYonwfyNHLpyaCOHlHvDBDdLs/Q3fdpOi80fs713rtz7hdOEqxy
         VMVERGr2FjK1PBUrk76jg9FOoC8CMYaXunzJVPS7467bQWINqsi8TORLeXWyzjAIiVpk
         AAdpMeqXxlGC5kpH4hkaC3DWg9ug0Oz44xawWoXifyM9M96mvjqa4674iYdQFCnh1WFh
         V0eUIoQN4+WdB1iCyJxncFi0R+h1OQlRKmS/8coSSudG8eiKmd38TIGmap5SrNoNAuM0
         LMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=55lHtDMtjfNlskw3j+8zYPRK4+1cB7I6V8RARCYX3GI=;
        b=UFvgJU1uK1zNaRoqOZf4pQUBzBM9gmxFTWUZfqPYsvMVD27bS2gH4AomLsJUeh4uFj
         5OfhRlwDhqWZcIIbZpfQDlAJAZUOEk9t5kEdVpK9mnqXOX81dDRabv17g4bHF8vLyRJU
         6h3xHPgK3mxVeSYrZ/irgq/EyNtGSv/HuXBygFpWWl5q0goaEmRslXJIq9V0lPPJrDSz
         6arrbKEgQ3LeEZCEZakayqmFLQWkK8o6asoJFpk8nlorOmB8jGOvPsC+Ar2QS1tVB8wo
         2pkCbic0k9HuhSc2Xxpxnet3q0mBHP5E644J9fxevUpHVxdisiZnkAeefvadhjbFmTps
         S1lw==
X-Gm-Message-State: APjAAAVX9r3aKvCjnDinSJUCSbZFhL7chjWNNaXDoDJkV9ud86eOS2ji
        ZPpLho+SOEiuvOd2KOYZcvg=
X-Google-Smtp-Source: APXvYqx44yw7o82mpVABbAixZf9fnlIPZmQr+F9FqSf3L8jf5wtTzZM8CxeliTuepcZWyROQjTjJWw==
X-Received: by 2002:a63:3046:: with SMTP id w67mr57703189pgw.37.1564217480832;
        Sat, 27 Jul 2019 01:51:20 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id r18sm52693443pfg.77.2019.07.27.01.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 01:51:20 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.cz,
        quwenruo.btrfs@gmx.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: btrfs: Add an assertion to warn incorrct case in insert_inline_extent()
Date:   Sat, 27 Jul 2019 16:51:13 +0800
Message-Id: <20190727085113.11530-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In insert_inline_extent(), the case that compressed_size > 0 
and compressed_pages = NULL cannot occur, otherwise a null-pointer
dereference may occur on line 215:
     cpage = compressed_pages[i];

To warn this incorrect case, an assertion is added.
Thank Qu Wenruo and David Sterba for good advice.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/btrfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1af069a9a0c7..21d6e2dcc25f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -178,6 +178,9 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	size_t cur_size = size;
 	unsigned long offset;
 
+	ASSERT((compressed_size > 0 && compressed_pages) ||
+			(compressed_size == 0 && !compressed_pages))
+
 	if (compressed_size && compressed_pages)
 		cur_size = compressed_size;
 
-- 
2.17.0

