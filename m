Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70C6115382
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLFOq3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:29 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35701 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfLFOq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id s8so7378914qte.2
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XZBfHw2CaSGcV4Kz3t+sRB/YUfVLcSB+/pO+8o4bxc0=;
        b=EHKDouGM2AePlrAD2V6Bn+rVs6CsfOs6t2rAVKNjFECs+UBJ2v4/8vcqpxUHaJJhXE
         f6Kq9vQY2GWPp78TlSMdyzDDIBIVqnqzfz9sToGYZqHVjsLdMbqGuBSOF/FPnMvzed9X
         F3cyPUkbF4B3QgB2+/m1kLWLs4ZskNtd02OWB3LBWkkG2vzEu0moacCAx3WUJoVHjmNt
         XIFLb5TZloQbHaFVtwmOxXFt+C6gdFJn/taaQlt0oNeGRjLV6yg6zNS0yvA11o2H0n1P
         k06Q5QzTvnw3OxgeuYkCJZul7qGoKJdSjV6sv2DmRtb52OpAouf2LEc8pvhGKw21IB6e
         9BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZBfHw2CaSGcV4Kz3t+sRB/YUfVLcSB+/pO+8o4bxc0=;
        b=es3IKdty3rYEujqdadA9ok1J85YgKKPiuMHyOTPDbyjkf/kJQAZiICpPrO/guUgk6E
         XXGN0yQC+lducvo0hxvX278l1bUaw4tZ0MhGk6uU1gSnMaUp60QrPHp/odsrlRsBUDdq
         tm91e/3A2R+UXWO8ktIhnlEWSlUEmbFR+UQR+2ZeGLR6GUH0QgTyPNM16eLJdKA3AwoF
         4CybW6bLZ9mOPn+Nt78b+riVPM88hnZ0eOfx8YNsZRqO/6H5O0epPSzYGnVnqm2e8gUj
         dAznFVngeP21lc4oxiUcX1Y3o7Y1mGIu5ZkZv1BtVcCN9FINqVkB5VxEbxK0xJQBqNGW
         fiXA==
X-Gm-Message-State: APjAAAXTJTn5iYQYjj8l2BwWYI2xh52YSvl+KDwRrP9StqXD2t6Mm/fR
        SaPRPwO7gDxvnBJBuAs4d3/u8Cb+qJxZcw==
X-Google-Smtp-Source: APXvYqwbUpqnMtUOrbG6TgRkl8YcBm06NhwGyL3FNbCW8VpJSeCDwWM/iGr8x4UP3DOHFiIMRfNwOg==
X-Received: by 2002:ac8:66d6:: with SMTP id m22mr12708285qtp.147.1575643586829;
        Fri, 06 Dec 2019 06:46:26 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l6sm6551875qti.10.2019.12.06.06.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 26/44] btrfs: hold a ref on the root in record_reloc_root_in_trans
Date:   Fri,  6 Dec 2019 09:45:20 -0500
Message-Id: <20191206144538.168112-27-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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
index dfd3d9053301..c3cf582f943f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2563,15 +2563,20 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
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
2.23.0

