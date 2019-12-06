Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB773115349
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfLFOhc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:37:32 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34261 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfLFOhc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:37:32 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so2724831qvf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ldo5fnCi3eBdP6CdyfBFH6O1QFUGoUipCvtg1jMdxMQ=;
        b=NEPDL9XNfs0jd7sjoofmCXqWp0RtS9v0SfgFm6nTAdtulQzHg5zsoymsojRNNCrncT
         8CyATZcDNoTJLWN3680PiGyeYN4vZDs0OYKIq4uMi4TW65raP89yChLT2X58XqTtP+aJ
         2LEepYU52Oy1xzoKgyP2E0exNlATYCFwCebwCqGwEBnKIBAP1ElMhJ5X4BJ1Ukq6i6+R
         xcgqoiWozSap8nf8Qee+SXdpSGTDdGHafgsWln4t48bteLuxPNtw0hk3t5Z4lU0hFZ+M
         aGcaSWQhpxz/Np2x4ytGfUcCBF3N4NdbUqoqWlY5LuY+5+W43SeIk2g99EHzZOxefpaC
         cLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ldo5fnCi3eBdP6CdyfBFH6O1QFUGoUipCvtg1jMdxMQ=;
        b=nGFFKb0cazvRYBfhMc66gw+WDKSC20uMAs+KshVdvtyQoJfj4wcvubzZF+49+AU5py
         Svsjz1WESLq3AIyyXixM/SrT+wApaskHPd/dNTnnILxWhapXZEiuy+6LEx0BMvyQhwNE
         prDywVJqYbcPsZlMKaSfycr3exBauxN5uOZVXTqZcSI+1KFNTfUEFhJML+ViEyupCUHE
         TAnVr7YJIfdD8oSbrDXpof6dMYl1vOuDReuMfjcUQ8LOG/3VnlbukkeFIJKgpYNRITm7
         B/MAEc+QwBKWvDgqi9eKCaXyqcqe1bKH9X+6P0wDVF9+ZLULSKBhRc0naX+G8btTkkEb
         zOrw==
X-Gm-Message-State: APjAAAV1iUCL2suSdsXoIr5QC8CQtJpJJE5LF7HdyrLNdLfoWaaXTKuz
        aft6JNp6xM47wKJAilLmj96vSoG4+LQj1w==
X-Google-Smtp-Source: APXvYqwCsyl1FbC+9rDxlUcY0ILEgTVr47+SrwsCUmu0rHyg+GDkVKtavZe38ylu/khDZb9dyBJP4g==
X-Received: by 2002:ad4:5525:: with SMTP id ba5mr12397370qvb.117.1575643050734;
        Fri, 06 Dec 2019 06:37:30 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v7sm6457110qtk.89.2019.12.06.06.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:37:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: do not leak reloc root if we fail to read the fs root
Date:   Fri,  6 Dec 2019 09:37:18 -0500
Message-Id: <20191206143718.167998-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206143718.167998-1-josef@toxicpanda.com>
References: <20191206143718.167998-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to read the fs root corresponding with a reloc root we'll
just break out and free the reloc roots.  But we remove our current
reloc_root from this list higher up, which means we'll leak this
reloc_root.  Fix this by adding ourselves back to the reloc_roots list
so we are properly cleaned up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a857fc8271d2..c5fcddad1c15 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4554,6 +4554,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		fs_root = read_fs_root(fs_info, reloc_root->root_key.offset);
 		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
+			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			goto out_free;
 		}
 
-- 
2.23.0

