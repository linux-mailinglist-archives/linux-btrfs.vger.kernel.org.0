Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2C701721D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 16:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbgB0PHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 10:07:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40531 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbgB0PHM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 10:07:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id m2so3409759qka.7
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2020 07:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSvkhxdyEmqrE70vHF9aoFMW2HtdnZsj8RL28OWB0v4=;
        b=e9rXKYP1EB/waTxFPn0Y+fvYMmPCFaNMXA31zUjhrAXuCR1UR6AlCD2s3Rx3YocpZ0
         oIi3iReJADnNfOLCQhmT185I6nAcJCc50FI73RxHOjIu9B3K2KK1pnXmgj1xCg/JHxRk
         T9g77CJJji0X1OM88JERbp0N3iwbY55FMLE15xjwRulEtioXqqdrwSDaXNqaCuhY5x2a
         KaczuMKjC6k9EMbou0NeeQJWeYgmDCXsogQtMAWNrTjRKxkYgNAnUM8mg3M3h2to9EaG
         x9FogcUTh1i/bx9jjnB5bGJzFH7iIjrQyud4ICJknwgq88/N/lDRor3Rwv2+W7nF+Gt2
         qaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSvkhxdyEmqrE70vHF9aoFMW2HtdnZsj8RL28OWB0v4=;
        b=ZNMmez4x2+9qdjdBOj3XYek7j7bkGfswy72g37Fe7y1S95EubilB3wKg4pkvrlbWi4
         xyd4AvoRIjNbadzYYnCyoJ6/xKXLBl+rs+PnfzYOIZo2RJ7tEl2G3qXVMS2uCaqmGQ+Y
         astvGRDOL3S3G/uwiDnpc3n/NZYbB7JA+h/KGxfzGg6bgWwZ/xguapXMYRBHyc9BbJYW
         mMtFCXxxVTzkyOgVi1q/nVk6bpa75SkXDd2M/20fpaDw/NQJEYWKvy70zgCYZVtpCvf7
         cDzGyjj/dqBVTPtZ9qOUE5CfKq7J82z7iKU/E4Rm8q6c7UtLnNcU089lbEwd8p/24gSD
         3QRA==
X-Gm-Message-State: APjAAAX88i/1+g+VOkU1QaUOpAN7JJ7COALK81s1hvuYsHZtFDMhAj9F
        osmBqZ/hqEpoOUFlGYnhMTNUP2ZPbhk=
X-Google-Smtp-Source: APXvYqwU1pD7qEu2EBk77hFo5xSyx7wbMQB9bMeby6Up5L1xIcTsNjCexUFlV8BwQr3S3KbwVL0rzA==
X-Received: by 2002:a37:64cb:: with SMTP id y194mr5787012qkb.364.1582816030566;
        Thu, 27 Feb 2020 07:07:10 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t55sm3381903qte.24.2020.02.27.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 07:07:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] btrfs: set root to null in btrfs_search_path_in_tree_user
Date:   Thu, 27 Feb 2020 10:07:08 -0500
Message-Id: <20200227150708.4026770-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We could potentially have root uninitialized in some cases, so this will
cause problems with btrfs_put_root.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- Dave, this can be folded into "btrfs: hold a ref on the root in
  btrfs_search_path_in_tree_user"

 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0bd691055e51..92cb38c9889a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2388,7 +2388,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 	unsigned long item_len;
 	struct btrfs_inode_ref *iref;
 	struct btrfs_root_ref *rref;
-	struct btrfs_root *root;
+	struct btrfs_root *root = NULL;
 	struct btrfs_path *path;
 	struct btrfs_key key, key2;
 	struct extent_buffer *leaf;
-- 
2.24.1

