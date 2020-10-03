Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D174281F9D
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Oct 2020 02:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJCAM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 20:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJCAM2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Oct 2020 20:12:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAB7C0613D0;
        Fri,  2 Oct 2020 17:12:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id x2so1898466pjk.0;
        Fri, 02 Oct 2020 17:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5QZv+Rd3bQMX47IS5ZlWsHnrzTDh43gZUw508PHN7F8=;
        b=I/+spYdaGvO2WV5sfLpO8DHlGCmBH7ZvKcq5mZ3GMoooMMmswFizyAl3a+GoeIMirK
         MmxwUO8wXBdiuRKVmjTZ9NP4dkYAfsgwgtBj7W4EMTc5lXwd6NfzJ93BAeDCXs/DTAm+
         iDc+mmVR96FHw3cfok3Hk74Sm5HzwlzCmfIr2YrJ8NbTKWoZWcDjaG5xRtBcBHZzfgkA
         y9mUYD1+/NDJ8IwZQSzbIchw+Ti2dcLTvZLiv/PxfjDldLLoJPejaXWfFvSrb/5htXod
         7clXyg9dHz3J9KV2vrIrwLkvNOuKAfbjO/UAkOvncEkDr4ryZpYH9gzMsCscahKriBSc
         /gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5QZv+Rd3bQMX47IS5ZlWsHnrzTDh43gZUw508PHN7F8=;
        b=c2c822guNycAOP0eVsrXXCka1s34GA8doVquaWdqDzIWxlxDo17tgNYIUb4mbn8IHL
         vB8mTK4rdDdiQ3pAZM7KAEkiHLtEsHJnR40IIeJ+64/CxioVaWviv8F7mg/lbjVsnfEW
         8kPmpNAQd8Dw6SnaQZ9Ydh8ecJ+B8XhymhRo0gRV+WX9zf8/o+jYpTqOHdtXuYxjZoPh
         PnfECCSdBVKrE9aAY4NkBd9beD2SNKifEiuH5IQrCEuYixXcOQYzJMUfYPJ+vJD3CtYI
         aSzfLgHQrQdHjcml/N1LdZASRS/XXFC57RAnnn63XmEYRIPDlz8achK1xtyEl/uReFpX
         54gg==
X-Gm-Message-State: AOAM533Dts5EkM9aIbRhamZmc3Dx+TRw68Bqt9xd+Gekn34T/GoxaJW5
        9EDO60OOH5w6dQUs5LpmjA==
X-Google-Smtp-Source: ABdhPJyIYYo3YEa+NE0tgLYIBhTIWLWVeoPQBsAN0/yxAhaJHr0QNbg9Wy59W3wd2zXtS6tsvNkB5g==
X-Received: by 2002:a17:90a:203:: with SMTP id c3mr5063154pjc.149.1601683948034;
        Fri, 02 Oct 2020 17:12:28 -0700 (PDT)
Received: from localhost.localdomain ([47.242.140.181])
        by smtp.gmail.com with ESMTPSA id x140sm3303157pfc.211.2020.10.02.17.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 17:12:27 -0700 (PDT)
From:   Pujin Shi <shipujin.t@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, hankinsea@gmail.com,
        Pujin Shi <shipujin.t@gmail.com>
Subject: [PATCH] fs: tree-checker: fix missing brace warning for old compilers
Date:   Sat,  3 Oct 2020 08:11:51 +0800
Message-Id: <20201003001151.1306-1-shipujin.t@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For older versions of gcc, the array = {0}; will cause warnings:

fs/btrfs/tree-checker.c: In function 'check_root_item':
fs/btrfs/tree-checker.c:1038:9: warning: missing braces around initializer [-Wmissing-braces]
  struct btrfs_root_item ri = { 0 };
         ^
fs/btrfs/tree-checker.c:1038:9: warning: (near initialization for 'ri.inode') [-Wmissing-braces]

1 warnings generated

Fixes: 443b313c7ff8 ("btrfs: tree-checker: fix false alert caused by legacy btrfs root item")
Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index f0ffd5ee77bd..5028b3af308c 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1035,7 +1035,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			   int slot)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
-	struct btrfs_root_item ri = { 0 };
+	struct btrfs_root_item ri = {};
 	const u64 valid_root_flags = BTRFS_ROOT_SUBVOL_RDONLY |
 				     BTRFS_ROOT_SUBVOL_DEAD;
 	int ret;
-- 
2.18.1

