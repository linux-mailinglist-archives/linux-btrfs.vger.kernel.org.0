Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1639781C0C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 15:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfHENTq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 09:19:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33743 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbfHENTp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Aug 2019 09:19:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so76604484qtt.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Aug 2019 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MjrvG5Iy27TTtNA8NIXna7aAQa5cPkh57BwwjQaFKTk=;
        b=Fz+TXTjde9kCf1CMkjsIO11OfkcUYs3EeINCSqydm4L3EDxw744lCl+qPEgAeVE/H1
         BO9UAPkFxZvoeLPaJ07h1ZMM6ng2j8NlHPzpO5vIzvv22COkQSKCiCxQarbyZiaOE6aM
         EECaIs5glk5LSfe7t1OyhQLNuNVISzJnwKVVrwSnqQpNoiIgNIuDeXf6co0QcOa36RJe
         nI07CaHNUmkP+I5tuifNWo9ltjhioaPOhWd5k6X3WYvI06PEbi9EOYGCePVHlEImIW4F
         V0ozjITKbDvdEY2l+WMweEztHSMeedgrdBXW5ktY0HtJyKDHUQvh5fKus0hD+O4esXwR
         UhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MjrvG5Iy27TTtNA8NIXna7aAQa5cPkh57BwwjQaFKTk=;
        b=ttGaPzvkVeqwEDviU5N5AD+tiX5kzTCMBcVZtm6HaqKmYimU6EGUxYhBxTD9x/3K8J
         Man1vmWlqgmzxdQrz1x+2hwj8EBKRd4lAv5TNOWXKdYlGFT+oCWUf+Is3jmVQ60Fp5R3
         b1cqy6ohsuQZYlqxoPGbqvpwWG8nO/CekqFLeEGjJJJK37xE5+nBegNZRTGs07UEnnGz
         7d4g+hz2dAK3g4CZDkaqhMhy8/equVtfei6MCRcFtMdXDkdB3i2BSQh7RLcXqc9yUTcH
         aENYvfDnsjZtpYKDs50zSJvIhpzAp9jVDTDvztrAH28b+byNonORM2N5MrXSXNmqT7WD
         wU5g==
X-Gm-Message-State: APjAAAW/9nVJEf88NqDh5Ff4t0XeeKnlY7CxApDR0MtIMDM/rYGxBB85
        LesFveZM2yxHnA3DkTgjLbBKf8T4Zdw=
X-Google-Smtp-Source: APXvYqw3ZDw63JrMHS3VehRtevVckM2Vj+YFo/WCvSLtqTm6WnU+Ld40+09B62gXyuG9KN6QKaZSfQ==
X-Received: by 2002:ac8:738e:: with SMTP id t14mr75074683qtp.386.1565011184119;
        Mon, 05 Aug 2019 06:19:44 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i12sm33870005qtq.65.2019.08.05.06.19.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 06:19:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v2] btrfs: add an ioctl to force chunk allocation
Date:   Mon,  5 Aug 2019 09:19:42 -0400
Message-Id: <20190805131942.8669-1-josef@toxicpanda.com>
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
v1->v2:
- I noticed last week when backporting this that btrfs_chunk_alloc doesn't
  figure out the rest of the flags needed for the type.  Use
  btrfs_force_chunk_alloc instead so that we get the raid settings for the alloc
  type we're using.

 fs/btrfs/ioctl.c           | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d0743ec1231d..891bf198d46a 100644
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
+	ret = btrfs_force_chunk_alloc(trans, flags);
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

