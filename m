Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231BD115379
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfLFOqN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:13 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40036 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFOqM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:12 -0500
Received: by mail-qv1-f65.google.com with SMTP id i3so2720427qvv.7
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7VlXuMmW6vkmcDdGX4eAWzkcyjFhrGSVL6+MEgHg3UY=;
        b=dhY/9Vw78RU8eZX43NuLpRJ3Nd+dSU2LBgeCMMib6PUkx0SKwDt6HOlD2w1MGOuqcJ
         00jCf1/VAj13icfFsd8FKYvAi4BnXHEDr0Xw9tTEXNh5yU+fK+IHqpg/vzql71VuJHgp
         UJxcDFpzjCHJCQos/IsASWFl457i9dosvRm7RovcQl5kmPGY2dPNHUpMto9qeN2QJ+Ja
         Zh4WwGlC4+nVf2V5Rh2r03+Zj4KjLwHTVXoyYYJb6iS+xzVY+C6S47htY025zs476Z2S
         J93SzsqIGuHBPW7iVX1IxDmrr/CaGMyEZDUKjxvcegux65C/jOLV6jPhtCZC4WelVMx+
         O5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VlXuMmW6vkmcDdGX4eAWzkcyjFhrGSVL6+MEgHg3UY=;
        b=sa0B5bVWhwlpS+T6SKIWBXD1JAWkKX1E1r8gOCm5yArp2D7zYojt26qMIu+noZnyBK
         8aCIRXWHiUQo+Q6EWZO6cUz9vEifacp132JuuRn6ValS+YDUlFYU6Y+6YW5bnxLGgZI/
         Cb0YzZZEfAmTOj+8raJTdqhXvj1GHlAsZNOwGFfbAMVNzfAXU8Jq7g2CnPP3/U9HNGiD
         ipif1ahXPoymFJyYvyTTgJ4EK2xlQ7VDc8lPx5K4NW2Gwe0fKbRJkjVhSGZZAdLn60jE
         eJIWdq7ziy7AB6P46jMD9aMoc7j8OqCWg9GyJIJ7jV0yOTs/5BBE3N2TVYi/JM/utjMJ
         XFXg==
X-Gm-Message-State: APjAAAXKDCo/oZ9z+64+Ppt9aGL6udUanjXyGhhjUy6v58qTE1+wGeAR
        8q/GnwSIMd3w2m2vbpdbvpZmOe005FgVqw==
X-Google-Smtp-Source: APXvYqz6qP7GiwNZik5O8RMH49TRVR6UJr6H1b7WAhU40+Dx8qIFbgI7eWdsF01W5MBYtKt20aCaqQ==
X-Received: by 2002:a0c:f792:: with SMTP id s18mr13010839qvn.118.1575643571444;
        Fri, 06 Dec 2019 06:46:11 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r41sm6688039qtr.60.2019.12.06.06.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/44] btrfs: hold a ref on the root in create_subvol
Date:   Fri,  6 Dec 2019 09:45:11 -0500
Message-Id: <20191206144538.168112-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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
index 95b0488b7da6..29c363a70fe7 100644
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
2.23.0

