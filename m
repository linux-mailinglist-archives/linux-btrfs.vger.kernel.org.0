Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F496140B77
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAQNsn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:43 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43456 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgAQNsm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:42 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so21765819qtj.10
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q0ME8zuxwDKrlPtMSCeBEA8wviFlvHpy4bzNGMK4LpA=;
        b=FORTMino1eZJyYyJsOEm8GJnIn/Mdyk+CZ/kbMQ1oplgu/LMeSIUgEZ4A/cI0wxIHE
         ScP7RGXfXh88KE0CUq/BeoKuv/vjuvamcSWTXmbq98iDjyoxf4Wpxo8cXqoYv8QqxA+a
         6ysct+lXrXEKOpLJFYK5UH7Qs8JONLBlmcV4X1fQhcfOKeGNaSEkJO9UfiXap1Xs4xUt
         ZqVm0gHyRzQ+YRjBnAFtfYBEtwHKlsGB93lUPKVAvQF7tjy6KdzfMkW5oLXLSHugHhbT
         v7ztQqHa26SiXgpiAhM0mzi8f2RP9lTDE1W/ju00zF3P51os1olV2KdcLYE8NZhOjZk9
         RX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0ME8zuxwDKrlPtMSCeBEA8wviFlvHpy4bzNGMK4LpA=;
        b=TqjFA/oltZYE1f9XLOXT8x4w6ls+d6xNsEhDrE0BH6xYyOEnam+GoNAygPqHvOtOih
         x9nqL3hph8SzIt6DBYiYKStUl42egDwiwnvVtziB/73pt/TtJrofhSvZu8xs5Rkq4fFr
         T6jR2YNj7s2+AnYSdWkb4ilkqtQQL3liUxao9h2fjZFDYV5PO7vIDKQ4BAX8GxTAqv2e
         AwqBK3A7iKNQY1It4IADJog1bmWuhwWKunK1cJOcbETL0o4ld/m1A/+Gp90C6v9BhnbO
         f2qQvad+sx3f5X1iPVlVjyxG90ntL93JbQ9A9sPv+ag9x3oOaxxP7h7Lz/S+3ShTiDhR
         1NwA==
X-Gm-Message-State: APjAAAVwqhur0iyXqTBpjxkoW98oyXhp0Xk51WDHRaep+U2nkFCEXwKN
        FJOR+3HfNKGaKxBUHcXwxtfM4JLmesvS1g==
X-Google-Smtp-Source: APXvYqxyzmNCX24G1VqWQmh06hPHwpzlHa1tGmDVmcu2yIO3D8dEZ6+A6HKkeV84JD6Ue7ry+TSXeA==
X-Received: by 2002:ac8:41cc:: with SMTP id o12mr7821572qtm.263.1579268921530;
        Fri, 17 Jan 2020 05:48:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w1sm13288003qtk.31.2020.01.17.05.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 24/43] btrfs: hold a ref on the root in record_reloc_root_in_trans
Date:   Fri, 17 Jan 2020 08:47:39 -0500
Message-Id: <20200117134758.41494-25-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are recording this root in the transaction, so we need to hold a ref
on it until we do that.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 953978ba46a4..04d7892093bf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2604,15 +2604,20 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = reloc_root->fs_info;
 	struct btrfs_root *root;
+	int ret;
 
 	if (reloc_root->last_trans == trans->transid)
 		return 0;
 
 	root = read_fs_root(fs_info, reloc_root->root_key.offset);
+	if (!btrfs_grab_fs_root(root))
+		BUG();
 	BUG_ON(IS_ERR(root));
 	BUG_ON(root->reloc_root != reloc_root);
+	ret = btrfs_record_root_in_trans(trans, root);
+	btrfs_put_fs_root(root);
 
-	return btrfs_record_root_in_trans(trans, root);
+	return ret;
 }
 
 static noinline_for_stack
-- 
2.24.1

