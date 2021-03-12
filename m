Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CB9339838
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhCLU0J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbhCLUZp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:45 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7CFC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:45 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id l132so25716024qke.7
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ZShPBI7AjyNrxGZbKP3JEKbwG7ciYzPWmjgBbz8TLA=;
        b=nWdoKbnuDFCHNtP1mGz5ZVyX41VF+1DeD9NM2WHeKV62FGsdcq8rHZwZ5oH7cwYFa4
         vx4OQweCWy9H1sJgx9JSVwgBDUHp+9QVsOPEVdXhXe8HQQjYyF9UBYtkgV020OJH6bNI
         uwp7w7YlFIg5bn+8h/bVwJWWNjnD4g4KS+Q1X2fyTGRR4nQxfiGzOahWPczboa+le8Bp
         dd4bOdJ44rTuoYqjsLUS84z0ZIsgitCxtO+b8pcsi+kQebTglk0+W96SD+ryflOcGhQk
         hoFhcUTRGRC65/FwKt+NV4pcQRwVIhD3VweNxslbAHfhPf86yh9innosT76FECw8gyeY
         zufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ZShPBI7AjyNrxGZbKP3JEKbwG7ciYzPWmjgBbz8TLA=;
        b=j4gVFkzpBE3Kt8QYEyRD1Scv06yLwXEl++fLACkQWsk+wY5USb5BnZErqnG3HievwK
         MUDjbGrMkc9OZSj0cZWJF4vps5Ib8wn4n1cAkfCDiAYmyqXyNU+rRB8uttDM/Cr000r6
         Y5DdddPi47j+9VxBEC56lNYJOZfEU5Lst7382kU4/vIJboj6C4Q2H9bFLWgKuTenFsYB
         a7ghn+t5XjHC+63vQDaFesI5kK2F9jdr32EqY3jzjazSMj27j0rWWgFJ2bPP/Cy3aD4L
         HkYVVLbiPYrCRMlYF3h9iQmpFxVz5o3w/yMNAoT5psQnaAm2cyHlTJlsforzXavMjWI0
         +FFQ==
X-Gm-Message-State: AOAM530tyT4j6SQUkQII7x9D2jc8ZPj8tyowy1LgNoU0NPORYsuxpamL
        TDqSUuvKsgi1/bEQ8HzkO5Wf2eyIToJdv1I2
X-Google-Smtp-Source: ABdhPJzGmqiUWNuXONGRmxkYGGYKMq1G0qRbgJeZEo6h/Fd/RwQJcxYQwvTcd22kU4B8rbiSei1abQ==
X-Received: by 2002:a37:4743:: with SMTP id u64mr14548286qka.350.1615580744193;
        Fri, 12 Mar 2021 12:25:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d24sm5176835qkl.49.2021.03.12.12.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 05/39] btrfs: check record_root_in_trans related failures in select_reloc_root
Date:   Fri, 12 Mar 2021 15:25:00 -0500
Message-Id: <101e340fc079ffd729abf5913f9bda4cf0c61b05.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will record the fs root or the reloc root in the trans in
select_reloc_root.  These will actually return errors in the following
patches, so check their return value here and return it up the stack.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0f2ecf61696e..b70a666612a7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1988,6 +1988,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_node *next;
 	struct btrfs_root *root;
 	int index = 0;
+	int ret;
 
 	next = node;
 	while (1) {
@@ -2023,11 +2024,15 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		}
 
 		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
-			record_reloc_root_in_trans(trans, root);
+			ret = record_reloc_root_in_trans(trans, root);
+			if (ret)
+				return ERR_PTR(ret);
 			break;
 		}
 
-		btrfs_record_root_in_trans(trans, root);
+		ret = btrfs_record_root_in_trans(trans, root);
+		if (ret)
+			return ERR_PTR(ret);
 		root = root->reloc_root;
 
 		if (next->new_bytenr != root->node->start) {
-- 
2.26.2

