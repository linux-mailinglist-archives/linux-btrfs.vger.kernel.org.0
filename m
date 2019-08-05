Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE21824E2
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfHESb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 14:31:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45889 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbfHESb4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Aug 2019 14:31:56 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so60934117qkj.12
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Aug 2019 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jsD5hKX3OEbtSKC+z49aaa0ekgV/10pazKlHfxbm28=;
        b=HiL514FauyNFh2R4BsXtCNXI/cJq1ux5APjsWfd7DoRlYOOAze1UVuuLky84/6OtDO
         D19brkIuaANMTr89JUOjneVI5e65z71cbQAfz+BwreO6RNMJhZz+eFXB598iNvRSRWZ+
         oQbkdFISGG/SiL2PgaFSkxp3QK5B4pZV7MtNVlKAA0raYRNm285zxZISq7JcXb30Whsw
         tNYv/I8li63EOwuouydv3rKI90Kd8P69B8pFeJAjIRYufjpRJkIEN+RKavRKrzcMvvK5
         E3NooJR5G1cjWKNFNwwh2U/SnnPTABkUex4Kiu3feUFdttIHxiGfUL7rK1BEtnGA/VQv
         5xGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jsD5hKX3OEbtSKC+z49aaa0ekgV/10pazKlHfxbm28=;
        b=amu4JQw9dXfa6WZLpPgLyR1VPZl+mmkrDV7LpBwUg5uV4MiOZ8KsuNucO1Vpvw5AoI
         tqzFNam7QaBnNJAhISa9xbcO+jynWSQOI0GNKyjIXUGyzzJt7fsPW26dTLvxP8H8HZdW
         ZDLtzzTxZ7B6dP2NmKvl793uHVCMND6vVmuSAtHWwdzAdeHsRq53+cKaHBabUhXCjHAR
         zPWqicb/nrptrOJ+jEFaeUiiw9DQYzGP+51hn5Zk4HfkKeA/SoBvGSPJ4f8n9db8YTwI
         teWU0lDpIdZFjR0PoRpZJw5iTk3s7ixdJLFED1s/czK+vuKEwyh/RSJ4kBmW+/svMjgl
         aXcQ==
X-Gm-Message-State: APjAAAXIwj1ykmFKtab5lEKXmdaghagZwiFY9gD/2VhDg3wsvyKdn1Ob
        PPouBGP3DiYHGgUaScKXXmDgt6enQf4=
X-Google-Smtp-Source: APXvYqykUFt5ARIcN7HQEhfurH90VSiUppr5emTp3PE9X2m+UcgWaKU6yqxROee2krkblt6vMT9p7Q==
X-Received: by 2002:a37:91c2:: with SMTP id t185mr23433252qkd.193.1565029915094;
        Mon, 05 Aug 2019 11:31:55 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p3sm54810605qta.12.2019.08.05.11.31.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 11:31:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v3] btrfs: add a force_chunk_alloc to space_info's sysfs
Date:   Mon,  5 Aug 2019 14:31:53 -0400
Message-Id: <20190805183153.22712-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In testing various things such as the btrfsck patch to detect over
allocation of chunks, empty block group deletion, and balance I've had
various ways to force chunk allocations for debug purposes.  Add a sysfs
file to enable forcing of chunk allocation for the owning space info in
order to enable us to add testcases in the future to test these various
features easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v2->v3:
- as per Qu's suggestion, moved this to sysfs where it's easier to mess with and
  makes more sense.
- added side-effect is mixed bg forced allocation works with this scheme as
  well.
- had to add get_btrfs_kobj() to get to fs_info, not sure this is better than
  just adding the fs_info to the space_info, am open to other opinions here.

 fs/btrfs/sysfs.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e6493b068294..12cff81aa8ea 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -20,6 +20,7 @@
 
 static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj);
 static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj);
+static inline struct kobject *get_btrfs_kobj(struct kobject *kobj);
 
 static u64 get_features(struct btrfs_fs_info *fs_info,
 			enum btrfs_feature_set set)
@@ -321,6 +322,58 @@ struct kobj_type btrfs_raid_ktype = {
 	.default_attrs = raid_attributes,
 };
 
+static ssize_t btrfs_space_info_force_chunk_alloc_show(struct kobject *kobj,
+						       struct kobj_attribute *a,
+						       char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0\n");
+}
+
+static ssize_t btrfs_space_info_force_chunk_alloc(struct kobject *kobj,
+						  struct kobj_attribute *a,
+						  const char *buf, size_t len)
+{
+	struct btrfs_space_info *space_info = to_space_info(kobj);
+	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
+	struct btrfs_trans_handle *trans;
+	unsigned long val;
+	int ret;
+
+	if (!fs_info) {
+		printk(KERN_ERR "couldn't get fs_info\n");
+		return -EPERM;
+	}
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (sb_rdonly(fs_info->sb))
+		return -EROFS;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * We don't really care, but if we echo 0 > force it seems silly to do
+	 * anything.
+	 */
+	if (val == 0)
+		return -EINVAL;
+
+	trans = btrfs_start_transaction(fs_info->extent_root, 0);
+	if (!trans)
+		return PTR_ERR(trans);
+	ret = btrfs_force_chunk_alloc(trans, space_info->flags);
+	btrfs_end_transaction(trans);
+	if (ret == 1)
+		return len;
+	return -ENOSPC;
+}
+BTRFS_ATTR_RW(space_info, force_chunk_alloc,
+	      btrfs_space_info_force_chunk_alloc_show,
+	      btrfs_space_info_force_chunk_alloc);
+
 #define SPACE_INFO_ATTR(field)						\
 static ssize_t btrfs_space_info_show_##field(struct kobject *kobj,	\
 					     struct kobj_attribute *a,	\
@@ -363,6 +416,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, total_bytes_pinned),
+	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
 	NULL,
 };
 
@@ -556,6 +610,16 @@ static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj)
 	return to_fs_devs(kobj)->fs_info;
 }
 
+static inline struct kobject *get_btrfs_kobj(struct kobject *kobj)
+{
+	while (kobj) {
+		if (kobj->ktype == &btrfs_ktype)
+			return kobj;
+		kobj = kobj->parent;
+	}
+	return NULL;
+}
+
 #define NUM_FEATURE_BITS 64
 #define BTRFS_FEATURE_NAME_MAX 13
 static char btrfs_unknown_feature_names[FEAT_MAX][NUM_FEATURE_BITS][BTRFS_FEATURE_NAME_MAX];
-- 
2.21.0

