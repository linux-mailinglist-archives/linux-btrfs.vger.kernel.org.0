Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3F4140B75
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgAQNsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:39 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35835 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgAQNsj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id e12so21799453qto.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uXZBI5vZLZIuYv3y1kQk3k5G+sPiPGLyrSbXaJX7PBU=;
        b=C4eIhrMHJ4XCkHeTxbgLoYFBihy/Vuvva3LZXDR0fL7QBmVSMQ4nXKYL8u23FRggc/
         gCXqwT4SYEpqJ+BCAeb3nR50ep7h69MfGruAkBtm1IlwlWpx+TUm5FCS1z32ufMXsoDP
         ZINdC1N8f4RolQF3VKGpqPRaaFK8EoiSP1Er+t1i94DL6fdz4+eHrjycBsGQpNSJ38ih
         Nk5lIHqtfWHW2/uylu6bHzaSL0B/XwdGnyTUsZ9IaPDtGoP5yTZf0M9QTZw4mO8QY39H
         8B5arvxCNu8ffMJnlBzBTAoBbkJCaTl6RNC2o/3uPHv2LimS/cfrKP5KB68Q52umL3AQ
         ovAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXZBI5vZLZIuYv3y1kQk3k5G+sPiPGLyrSbXaJX7PBU=;
        b=nCsYJVpD8QWo/afoIsHkYzIwFYeChv+rxl7ZF2Yl8ZdJo3MXdGNFvbF2biOFAkONUo
         hUJLZQvp1wnDdcqpEnO8WIwPpFeVtDd0wuH22v8LYDfU67uK33Ib2ZnnsSSo59jVrU3A
         I5RQJq8lBaWoBNzSJssRvJbSt4bl3lMoaUit5LEKy6iCpWdvoLbF44jeXxY74HEaMVzx
         /VKPAeJZDtVW0qswMLbwmpqkKYgQ3936HWUuqXlvEP//uDZa6AZGWGDR5rFv2i3nnhAy
         5VjVpPvjdGmQn1LaRdOS4OJT6WyVS2eAZN5AH5DBzeUzoEd6Y6bWz4tnmn/fE5rIuo80
         aGtg==
X-Gm-Message-State: APjAAAXL5DltOdp4OMp4OzGapfLNZK19CeDDWifbuI5IKz50enTTYsxh
        eO4sKo+kbaAH4ds+naabWsXN5aMAhgRsRA==
X-Google-Smtp-Source: APXvYqzL8EU879dBWfhzNCaZyylra+Fvz11l9RGKuAgNVJQdygoAWttxYILLU20d+WAqlrH+A25y8g==
X-Received: by 2002:ac8:1349:: with SMTP id f9mr7619333qtj.179.1579268917938;
        Fri, 17 Jan 2020 05:48:37 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f97sm13237829qtb.18.2020.01.17.05.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 22/43] btrfs: hold a ref on the root in prepare_to_merge
Date:   Fri, 17 Jan 2020 08:47:37 -0500
Message-Id: <20200117134758.41494-23-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the reloc roots corresponding root, we need to hold a ref on
that root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 05a301204fd9..0068b7b940f8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2474,6 +2474,8 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		list_del_init(&reloc_root->root_list);
 
 		root = read_fs_root(fs_info, reloc_root->root_key.offset);
+		if (!btrfs_grab_fs_root(root))
+			BUG();
 		BUG_ON(IS_ERR(root));
 		BUG_ON(root->reloc_root != reloc_root);
 
@@ -2486,6 +2488,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		btrfs_update_reloc_root(trans, root);
 
 		list_add(&reloc_root->root_list, &reloc_roots);
+		btrfs_put_fs_root(root);
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
-- 
2.24.1

