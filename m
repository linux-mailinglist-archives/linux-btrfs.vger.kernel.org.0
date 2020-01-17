Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6561140B7C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgAQNsw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:52 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37403 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgAQNsv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:51 -0500
Received: by mail-qv1-f68.google.com with SMTP id f16so10708557qvi.4
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ckTN1AcxkeHORRhsqXj7YNF2NgUrl9S+/nMmxj1pRCE=;
        b=Br0aVBEooUaXz7BGa09MKzxM1cLKFk8XuCoIOPA53AnHGi0A+yRwRpM9G6YUJf277d
         hNj9vgwC4P7wmbSgMheDxT/f2FOLDyGyOEU5uXETYnhP7+Tyu5sSKUwR1sYs8H/TMxNp
         VPywDyWojydSc48cDe/ulWSrZDBdJt7S1VXXzz65FaONMo7EGDFbFOp0i8LjRrpMEHHs
         HgYz3Hw33SL7LYT7JSdv9JsazTMSnpUvXLoS5EECkHEbe8oSGsVCcdn9z/NfPCRAS1gg
         tkdUBBCWbJf8DWPBVVuV5OwdovJI7PQ07BpARh0ZDwIj9opq5S3HvN14h0+TGjVMDl4q
         2TIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ckTN1AcxkeHORRhsqXj7YNF2NgUrl9S+/nMmxj1pRCE=;
        b=FPz8kN48lzssmfBxNxCg5ZspooFF5C8IlKHUkctp2VBQJXtDVIIuxhjyaKLzrHgaJL
         HetDstuInZiGOycVkwA0rVraAZBQip4NJwk8S9xE4D6k4Mke5cRosRsGE4/IMMzK9e2V
         cxBbXlczeTLrAcftJoyG+RP+o2/wFMNi6H7gAf57POzIX4q6Y9Vu+3H58agH7ph7lCga
         RPzbT5uoGdifNTI3MzsmXUZDQoe3v+ZUGvCYGRn3+TXKSXiAif80sGLLPQqCB76Dh+m+
         wdZy/lh6BJJnDvnDlgd82vsPbNnP2lEMCU2oHbA8FO1qF89+vOz9O+fdbp3FkTWu9Y2N
         oAAQ==
X-Gm-Message-State: APjAAAVbTLQMYVuv8GQrX8alo3fQEuhifbSKLshBsGyngYAsnp2Pc/j/
        BSU3bOg+a1/C/JEFJX/7EdysXJS+bNYy9g==
X-Google-Smtp-Source: APXvYqzQS6lK0/j4XX14NPlDYr3Pt5duNGnUcHnZhmdBVAQylIu1y8p6PD845Z6z/MGRymB5dU7yWw==
X-Received: by 2002:ad4:4a14:: with SMTP id m20mr7931221qvz.100.1579268930236;
        Fri, 17 Jan 2020 05:48:50 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c13sm11769394qko.87.2020.01.17.05.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 29/43] btrfs: hold a ref for the root in btrfs_find_orphan_roots
Date:   Fri, 17 Jan 2020 08:47:44 -0500
Message-Id: <20200117134758.41494-30-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup roots for every orphan item we have, we need to hold a ref on
the root while we're doing this work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/root-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 094a71c54fa1..25842527fd42 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -257,6 +257,8 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 
 		root = btrfs_get_fs_root(fs_info, &root_key, false);
 		err = PTR_ERR_OR_ZERO(root);
+		if (!err && !btrfs_grab_fs_root(root))
+			err = -ENOENT;
 		if (err && err != -ENOENT) {
 			break;
 		} else if (err == -ENOENT) {
@@ -288,6 +290,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 			set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
 			btrfs_add_dead_root(root);
 		}
+		btrfs_put_fs_root(root);
 	}
 
 	btrfs_free_path(path);
-- 
2.24.1

