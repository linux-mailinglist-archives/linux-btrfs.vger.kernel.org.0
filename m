Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADC814893F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404586AbgAXOdq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:46 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34907 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404571AbgAXOdo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so1651856qto.2
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b2Rhd/xiW6guBCO0svVDPB2riGJU48lMSVrOtNfEDqU=;
        b=jLWrc37VDoZ2+Wobl1zS9IPMImBQEE7c1Dif/AxyKp0TNsSrtyAsnZmHQp200gEqoX
         5feJTbHeXOv8a8n1ySWF0Wh5kSsjY7GJiMn9RkzU78ggd6ZlhZNsAQARzaSFw9HNV6J5
         xaGsArLivDdfDLiRmt+BwLy9ROhfFP4jyOTKI8OYtOnNZqplEnX14cg1yI2jJlZNF0Iu
         6lcHiab3JfhCAazlGDJ7lBiwzDr1HBfiRU0pSeKBjlbst7l1JX/bYEooHLvFuUEa5LUe
         1RbGWbPW4yD2G5WuZbWWLRExF+4tBQpv+S3yvChpzTo+awE2Tphh4kgQqAVrYXqZmskV
         4ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2Rhd/xiW6guBCO0svVDPB2riGJU48lMSVrOtNfEDqU=;
        b=qZOVOna/XhysS9C+eP1owKd5LLGyBqxNnnyz6OVu79rFIZ1Hm/amNraMsw0cOj3Lw2
         elngbLXKUaJokxRlRPLtolyzSwMrqIUZfu6CZOX6XDVGK9n6R82pc5hLLKJilhc31Siu
         rCO5E3HM4fR9txW1j7uJXes8CSdM3tAjMbQIFaAPke8u6AM6mxeHOa8Z65OcnpM5/pJl
         WsvIMr+1o/kjwj+ylMp4qibNAdZIeHg6ddyW3MiwdfW63b6smQPM7nOBJyX9GzdAObYj
         eYt7TaXJclc9tHeGOnGco31q97jBfDemZnsC6OtzfJAjXK9w2TNLcelidwsE+x/MJ3uQ
         Rl0g==
X-Gm-Message-State: APjAAAXNcLEBxoyF86ad7YkOG08WPBQaopbplCs3QpSN3pjHJWDfRYSa
        juLC+e9pO9Ypbe/IJLmUf+3SFA==
X-Google-Smtp-Source: APXvYqzxzjGUQecaElj72n7cun27P7IS+wkS7wLkXnHdamOUCuFeFGYZly0lEVs6peuF4mRhWVT5Qw==
X-Received: by 2002:aed:35e7:: with SMTP id d36mr2461020qte.363.1579876423091;
        Fri, 24 Jan 2020 06:33:43 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a36sm3378760qtk.29.2020.01.24.06.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 24/44] btrfs: hold a ref on the root in record_reloc_root_in_trans
Date:   Fri, 24 Jan 2020 09:32:41 -0500
Message-Id: <20200124143301.2186319-25-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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
index 79430a4245b5..9b61fdc89af7 100644
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

