Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56BA7FE4C
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390045AbfHBQKf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 12:10:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35590 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389951AbfHBQKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Aug 2019 12:10:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so55256677qke.2
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2019 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEE9BURXq/CcFhTG0kTrWbkssIFAc4F3H+vKX68PpxU=;
        b=03VvsZd/7b0GgCK3Gvhxm5/Sy3tJ+enmYvzJP2jBmVjeYZCMaYO9OYeCMtjLL/47cI
         IFy2zyoTpVLqZEF5QgOahzPJM+TcdqB4TjNhkoDW/9lwZ+lMW9OsUVZzfuRXrbvm9zju
         xnYE7dZMgv0Tw98rtjYFSGQXOlaSIZ2fb82vMiLDdtzHk1F0eWUtpVK5gHUzgjURHrQj
         t0tNpKSKS53eWBEXmgaRkjmTAEsbcP03YHskogu8nr6XEB3RQFT/bNiQ0pMUfPzPV8/r
         rIxnEH/6cYW3lV2mNhlwLK8COHIO/bwuet4FNyY6M2B2B74qJXWNDvf/0eLvbvxvTM8d
         FsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEE9BURXq/CcFhTG0kTrWbkssIFAc4F3H+vKX68PpxU=;
        b=U6I30DhM6R+R32bFA6VhAzMGhrzyUwgxe7Ajo9jMZbjY9TEwG4yYHxOYmOKYG8oJR4
         BkeEDAigroXSrnDdy+oAA459R17mHnW8tLHuiVoKnJbnmccz36WUPKnEpWHgRwAdLfvv
         mb7lW/ZA/TxVCVk4JGO8htAkBtIzG2lOo7kmSdSFlEpKNhiA1Vxn+n1NzlklgdqSJgWT
         pfolGzU/mof8pu374dNwUQkflJy42it/7e2Wy1xAJvbq5/HtqO1Zg/Mgf3o3PSG2E5uj
         85NlbjfNbqjCp19iwOzDaMvBfy4ZBhb/Sei1eG6WXNAVuIN7sUck4drno9bnjImC1Z0M
         1LiQ==
X-Gm-Message-State: APjAAAVBKBzi7rxPj3iZZLEffqA0C1Gr3YtC20MV7vCXJ4olmG77HLxr
        tc8TO/RrdeJJi0zCAn0bMKD1EVZAqC8=
X-Google-Smtp-Source: APXvYqy+Yq7nwyvcxHiN8+xefBh5t4F1zNOHj5p0BWIEKE37SrYpdqVQecEGNHjkgtucwanYRlrTlw==
X-Received: by 2002:a05:620a:166a:: with SMTP id d10mr86561066qko.195.1564762233128;
        Fri, 02 Aug 2019 09:10:33 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b18sm28572126qkc.112.2019.08.02.09.10.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 09:10:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: add an ioctl to force chunk allocation
Date:   Fri,  2 Aug 2019 12:10:31 -0400
Message-Id: <20190802161031.18427-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In testing block group removal it's sometimes handy to be able to create
block groups on demand.  Add an ioctl to allow us to force allocation
from userspace.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c           | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d0743ec1231d..f100def53c29 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5553,6 +5553,34 @@ static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
 	return ret;
 }
 
+static long btrfs_ioctl_alloc_chunk(struct file *file, void __user *arg)
+{
+	struct btrfs_root *root = BTRFS_I(file_inode(file))->root;
+	struct btrfs_trans_handle *trans;
+	u64 flags;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&flags, arg, sizeof(flags)))
+		return -EFAULT;
+
+	/* We can only specify one type at a time. */
+	if (flags != BTRFS_BLOCK_GROUP_DATA &&
+	    flags != BTRFS_BLOCK_GROUP_METADATA &&
+	    flags != BTRFS_BLOCK_GROUP_SYSTEM)
+		return -EINVAL;
+
+	trans = btrfs_start_transaction(root, 0);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	ret = btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE);
+	btrfs_end_transaction(trans);
+	return ret < 0 ? ret : 0;
+}
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
@@ -5699,6 +5727,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_subvol_rootref(file, argp);
 	case BTRFS_IOC_INO_LOOKUP_USER:
 		return btrfs_ioctl_ino_lookup_user(file, argp);
+	case BTRFS_IOC_ALLOC_CHUNK:
+		return btrfs_ioctl_alloc_chunk(file, argp);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index c195896d478f..3a6474c34ad0 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -943,5 +943,6 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_get_subvol_rootref_args)
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
+#define BTRFS_IOC_ALLOC_CHUNK _IOR(BTRFS_IOCTL_MAGIC, 63, __u64)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.21.0

