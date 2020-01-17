Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A4C140B6E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAQNs2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:28 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39521 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgAQNs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:27 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so21786922qtm.6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hA4iNKOpd+uPQ09XByOlq3GwjvuYpxH5XpAmxRgdPC0=;
        b=omBSQgDMooYNwNK43B1ZL7Xq0PelftjwZTUxhlwkhv6P3CclKiDeMtgx5n5joCfu/+
         fvfwzI7scEIlvd4jBk8PtILXdv3EyTDGw8H27wLVcAT+UwXmpxd/eRzW6RR8FD0j2DQA
         Ed8vuBkF/N1FZcWWq1SkO/Gstz1+uhfsM9e9QlTtlQuplO9xG2GB18qJrjGi2XVuJjXD
         rwTg6F9dviHyaddhW/hClm7zI21cKJZdQR7UmiSUEZz4S6u8/OOYm5VrfHLM8vzmEQCZ
         Mu2eP1JeBtbpzaQbnlJ0HhB5N1Z4mp0sr2bMoTuCL7sDOHZbMK+ev14IS2EYy8zlHNIH
         oQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hA4iNKOpd+uPQ09XByOlq3GwjvuYpxH5XpAmxRgdPC0=;
        b=svLj9Yn/Zy8v6PlutM2HcRVVAWuINB26qypwk4UEHCRIiYAolaTHjOdd3116nAU6DA
         iL/dhu7f5GYO6wTvMgh0x/AWuf7mIqWqQI7XbF6KnETeTSbNKui8LEqmXqN+5/LLuX7+
         GZieCJ81qRydsDyoZLNxFii50JNgbtQJc/u2a4cy4dLCdRR/ymyrokKL81+APLcGH7/E
         HuCdNIWK4GDR8SmGhdIn0Qoa4Aq7NiWxiF3AH1C4shFNsB23Bk9Ib+MzmDy0I4bwrY+U
         HiY/mGsuMq2J4dgvtJKmu2yz9gyMHPxU+8CftjDnZfLI/3uKqQxz0rOMAm/bJTt2Q29z
         OZyg==
X-Gm-Message-State: APjAAAVk+GSaRFXBHRAvLvHXXFB2UAvqc8T/fZ++pvc/vaGF8lXa9n2h
        x62x6VYsEJT62I2SYI/CLObGw/E7kWu33A==
X-Google-Smtp-Source: APXvYqy5Dei77XEsU/GGDzUQHPf4rYMX7exi1rYjPKsweAPrExu9l8SdeG0MRAxNlOp+6RbYicfVVA==
X-Received: by 2002:aed:3f32:: with SMTP id p47mr7765343qtf.374.1579268906295;
        Fri, 17 Jan 2020 05:48:26 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u24sm11722140qkm.40.2020.01.17.05.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/43] btrfs: hold a ref on the root in create_subvol
Date:   Fri, 17 Jan 2020 08:47:30 -0500
Message-Id: <20200117134758.41494-16-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're creating the new root here, but we should hold the ref until after
we've initialized the inode for it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 958c0245c363..b1d74cb09cb4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -672,10 +672,16 @@ static noinline int create_subvol(struct inode *dir,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
+	if (!btrfs_grab_fs_root(new_root)) {
+		ret = -ENOENT;
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	btrfs_record_root_in_trans(trans, new_root);
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
+	btrfs_put_fs_root(new_root);
 	if (ret) {
 		/* We potentially lose an unused inode item here */
 		btrfs_abort_transaction(trans, ret);
-- 
2.24.1

