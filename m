Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1FEC140B6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgAQNsX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41372 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgAQNsW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id x129so22666849qke.8
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MLBOgsB9gJ9L9KSeDm3NlcZBDe8/qJV/rRnXG9wy7vM=;
        b=s+nueVvuN88c5G5KmM/8/p/jbUaGH7gDhfSQbzmH79nol+lTGlNFzUEobE/ELJcNYO
         HI4CckXmQ+CMkGNy74jQIGvv6euIaXZmgrmSFIdKK8TZwbJjyogQQfXYxo6xE3AGfW2W
         RBpdlhtmWww+gUKUPO2IbOIag7suxJEGVNG2Q4C8bsLBSsnZpgv66wJmOk3kulUfyPYi
         DEPylzLnc/Mkhf63RatQUTWrmLdZLvKd11hLNZboNPI/yXCYdXzjowuDYz5bq/g0PsXt
         cEEeINzIBWBJoQnRuL0Rw6HvU6cg95P93JpsCO/FNFtmIbvy3f5yCoWbNkcGPOdpUOll
         zo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLBOgsB9gJ9L9KSeDm3NlcZBDe8/qJV/rRnXG9wy7vM=;
        b=RTvL+DIvLNjQzp8vh5fX+CRlsp0mgUqYlB7Xj/+iZwVX6hM6vgEfK9SlmR3Kdlrlb3
         QdETBRSrUH2CvPoo9Xt+oDH6Hxcl1DCPaADlhR0bVLxbYzMkfwpnMeFa+KL3TldAeeCe
         GHlF2VK1YvWoOfsCCfh3gGblbOKtqOXZDG9B1RZQCYsE9WkNskqFeMYht+ZYCstG3D5d
         hpUug4LqmWv1yZuacbTYIprKk1sYpmsZrkyZTWiLCD7eH1xBpRjN5UKhE+K3BLVf/x9/
         pw+heRVhlSA2oMvYB3w9hHrW+XHh06EDoGA5JJ34eOypAUx1rLd2QgWwjg0AE72LfMnH
         mQZQ==
X-Gm-Message-State: APjAAAUVeD1ouC38NZCQXY+i3S736wQND97N7wE7OCJSVCUL798l/A6X
        pwMi9xeRj6xZf2y/ahqGzrWacHlp7WCTbA==
X-Google-Smtp-Source: APXvYqxmo+JYImt6ZhnNaOToraDUNLA+wu7nReLZQ9o2SrI4jAfdNJpXGC6UAGR9OmoNtirV5fq/6A==
X-Received: by 2002:a37:8182:: with SMTP id c124mr34001518qkd.165.1579268901376;
        Fri, 17 Jan 2020 05:48:21 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s26sm13265305qtc.43.2020.01.17.05.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/43] btrfs: hold a root ref in btrfs_get_dentry
Date:   Fri, 17 Jan 2020 08:47:27 -0500
Message-Id: <20200117134758.41494-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looking up the inode we need to search the root, make sure we hold a
reference on that root while we're doing the lookup.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/export.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 08cd8c4a02a5..eba6c6d27bad 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -82,12 +82,17 @@ static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 		err = PTR_ERR(root);
 		goto fail;
 	}
+	if (!btrfs_grab_fs_root(root)) {
+		err = -ENOENT;
+		goto fail;
+	}
 
 	key.objectid = objectid;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
 	inode = btrfs_iget(sb, &key, root);
+	btrfs_put_fs_root(root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto fail;
-- 
2.24.1

