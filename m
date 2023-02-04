Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5768ABDC
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Feb 2023 19:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjBDSfR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Feb 2023 13:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjBDSfP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Feb 2023 13:35:15 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A03F74A
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Feb 2023 10:35:12 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 7so5719933pgh.7
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Feb 2023 10:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy+wil4pznhpFSUKoZDmYz/n7Vbj4cg/Qau15VHcGRI=;
        b=VloeAGiG3UPi5KsMTTNrtc4v/yZg8m90avTS0EOL2Mw+lmwW10QlW6n7pSfNIks2ej
         BiPWwz4ScY0BJFVhxc3dYY5V6h2ZWwHTFYWwsWQVB+NPB5nPRirVnvDdmhiwHkjRw0WB
         L1XliHzO9SNrHrBOx/ZTTeyxbSTaMuqLyORNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zy+wil4pznhpFSUKoZDmYz/n7Vbj4cg/Qau15VHcGRI=;
        b=bQxnKhN255Gu6lo0RkSp4BxXE5e3zS/X4GuvOA5+R8EyXYXZlemKgMNJTfNzfscZW8
         MyGfpTlHnvH7o5jZrBRgylvBMzp6AlVu3D6oe4qB7YQacJEnbYl7Df4vCS18VzPJ8cmK
         Brz6FZaKEidHAnnmrkJ1e+/fT4rR7pYtLmOI8Zyma3IlzcUNXb5JM0ZDsZDHt9VMGZ8t
         KGM5S9TZ8GJ7UouDPVfX77i7J019kv/ZqcjrRUyvEYD/NArTfnTthTtS+JZCOrwe9vBx
         EkOuerLZfJw228EycgIwPX6LpjiHtFlXmeo4Qo2yAUVn3Ts2I6qCb0sR5UpIGVGHVzVC
         5t1w==
X-Gm-Message-State: AO0yUKUr9TPl3WsxhXNXNHqoOTO/EwZXgwEhsSeg9jm7bq89DKqr8NQO
        h6mC20uLtZj7uYfGT0DaSelKtw==
X-Google-Smtp-Source: AK7set+lCvtBfP1bidnuFepfgCmwDLrYIotsUrVrbmdnY4q7jjQhsA48S0pwo06HrAX/BZde/IvkTg==
X-Received: by 2002:aa7:8e89:0:b0:593:b021:7d42 with SMTP id a9-20020aa78e89000000b00593b0217d42mr14957391pfr.6.1675535712278;
        Sat, 04 Feb 2023 10:35:12 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z9-20020aa79589000000b0058e23ca0ca7sm4028881pfj.3.2023.02.04.10.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 10:35:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Chris Mason <clm@fb.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] btrfs: sysfs: Handle NULL return values
Date:   Sat,  4 Feb 2023 10:35:10 -0800
Message-Id: <20230204183510.never.909-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10318; h=from:subject:message-id; bh=odUCWzSZYkitaDJTEriC4EG03GVKChh8VEDm/Jq7Zn4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj3qVeC7qm+E/t2Hvh3ItBnc6YQ7+BcvKEvEOpqcJe PCejuVWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY96lXgAKCRCJcvTf3G3AJtnnEA CmcpR5P4RLYXAezGaITygw1GNZL5bidlDic5cX8KnnloL9gGxTLuL1yKQHJGcnjQZKONlFIVagXAAm Lssj3Oz1+2jBZxraE0gYyLeIqfGjhHuY7AaR3HRVKVlDblC3jcMBW3qAklgk0BhoCbgN3g2O+PnArV FPsw6s+aSCy1koHomXark/rwM393rbR1AC806O3TysWuX/29jRoNQN2fpf1St3smbE+FUyMIq2yw99 h8dzWIsR0MqLzGSc3ysScoEqoqicUOsJxEw95MpKdRguRpSKVKjlkdwjajCcKwRTeIuxvjAUV7gwBt EcJArub/uldnhdtW74WLRyep0+EgQf3dkUAhmayAvxjrdG6QsgLAVzKGNQszFKYMs/zNTdHI3d9RrW MEjYCs56UbyZOdoDm3CDkG9afTM3aVd+kMQVE/DhwkE0zZwJREgQRkKILtjjfLfwEIsbYd9jhC0vP0 OF1narUKvXQr6WRcMNvYAVTAM7VFkC3vbqZWzSRkLd8cxIMWeNKaCpqca9d9MhamkqClKpA0p2cB8F RHP1bxidS8hImDQiDnveouzJwwHF7syISPOoTOr5XP21bDGkRxS8YpeEmyS58Y5XsC8vYL0+uLc/P4 hrF5YTwo1Ibr0NNf04FL90xZQBwm1hwcGd6gkcSMtbxXn3xNWebKpRRIWxOw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Each of to_fs_info(), discard_to_fs_info(), and to_space_info() can
return NULL values. Check for these so it's not possible to perform
calculations against NULL pointers. Fixes many warnings seen with GCC 13
like:

In function 'btrfs_show_u64',
    inlined from 'btrfs_space_info_show_flags' at ../fs/btrfs/sysfs.c:827:1:
../fs/btrfs/sysfs.c:636:13: warning: array subscript -50 is outside array bounds of 'struct kobject[36028797018963967]' [-Warray-bounds=]
  636 |         val = *value_ptr;
      |         ~~~~^~~~~~~~~~~~

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/btrfs/sysfs.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 108aa3876186..01e0f439d8e6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -444,6 +444,8 @@ static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%lld\n",
 			atomic64_read(&fs_info->discard_ctl.discardable_bytes));
 }
@@ -455,6 +457,8 @@ static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%d\n",
 			atomic_read(&fs_info->discard_ctl.discardable_extents));
 }
@@ -466,6 +470,8 @@ static ssize_t btrfs_discard_bitmap_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%llu\n",
 			  fs_info->discard_ctl.discard_bitmap_bytes);
 }
@@ -477,6 +483,8 @@ static ssize_t btrfs_discard_bytes_saved_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%lld\n",
 		atomic64_read(&fs_info->discard_ctl.discard_bytes_saved));
 }
@@ -488,6 +496,8 @@ static ssize_t btrfs_discard_extent_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%llu\n",
 			  fs_info->discard_ctl.discard_extent_bytes);
 }
@@ -499,6 +509,8 @@ static ssize_t btrfs_discard_iops_limit_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%u\n",
 			  READ_ONCE(fs_info->discard_ctl.iops_limit));
 }
@@ -512,6 +524,8 @@ static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
 	u32 iops_limit;
 	int ret;
 
+	if (!fs_info)
+		return -EINVAL;
 	ret = kstrtou32(buf, 10, &iops_limit);
 	if (ret)
 		return -EINVAL;
@@ -530,6 +544,8 @@ static ssize_t btrfs_discard_kbps_limit_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%u\n",
 			  READ_ONCE(fs_info->discard_ctl.kbps_limit));
 }
@@ -543,6 +559,9 @@ static ssize_t btrfs_discard_kbps_limit_store(struct kobject *kobj,
 	u32 kbps_limit;
 	int ret;
 
+	if (!fs_info)
+		return -EINVAL;
+
 	ret = kstrtou32(buf, 10, &kbps_limit);
 	if (ret)
 		return -EINVAL;
@@ -560,6 +579,8 @@ static ssize_t btrfs_discard_max_discard_size_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%llu\n",
 			  READ_ONCE(fs_info->discard_ctl.max_discard_size));
 }
@@ -573,6 +594,8 @@ static ssize_t btrfs_discard_max_discard_size_store(struct kobject *kobj,
 	u64 max_discard_size;
 	int ret;
 
+	if (!fs_info)
+		return -EINVAL;
 	ret = kstrtou64(buf, 10, &max_discard_size);
 	if (ret)
 		return -EINVAL;
@@ -644,6 +667,9 @@ static ssize_t global_rsv_size_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
+
+	if (!fs_info)
+		return -EINVAL;
 	return btrfs_show_u64(&block_rsv->size, &block_rsv->lock, buf);
 }
 BTRFS_ATTR(allocation, global_rsv_size, global_rsv_size_show);
@@ -653,6 +679,9 @@ static ssize_t global_rsv_reserved_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
+
+	if (!fs_info)
+		return -EINVAL;
 	return btrfs_show_u64(&block_rsv->reserved, &block_rsv->lock, buf);
 }
 BTRFS_ATTR(allocation, global_rsv_reserved, global_rsv_reserved_show);
@@ -714,6 +743,9 @@ static ssize_t btrfs_space_info_show_##field(struct kobject *kobj,	\
 					     char *buf)			\
 {									\
 	struct btrfs_space_info *sinfo = to_space_info(kobj);		\
+									\
+	if (!sinfo)							\
+		return -EINVAL;						\
 	return btrfs_show_u64(&sinfo->field, &sinfo->lock, buf);	\
 }									\
 BTRFS_ATTR(space_info, field, btrfs_space_info_show_##field)
@@ -723,6 +755,8 @@ static ssize_t btrfs_chunk_size_show(struct kobject *kobj,
 {
 	struct btrfs_space_info *sinfo = to_space_info(kobj);
 
+	if (!sinfo)
+		return -EINVAL;
 	return sysfs_emit(buf, "%llu\n", READ_ONCE(sinfo->chunk_size));
 }
 
@@ -745,6 +779,9 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!space_info || !fs_info)
+		return -EINVAL;
+
 	if (!fs_info->fs_devices)
 		return -EINVAL;
 
@@ -795,6 +832,9 @@ static ssize_t btrfs_force_chunk_alloc_store(struct kobject *kobj,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!space_info || !fs_info)
+		return -EINVAL;
+
 	if (sb_rdonly(fs_info->sb))
 		return -EROFS;
 
@@ -842,6 +882,8 @@ static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
 {
 	struct btrfs_space_info *space_info = to_space_info(kobj);
 
+	if (!space_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%d\n", READ_ONCE(space_info->bg_reclaim_threshold));
 }
 
@@ -853,6 +895,9 @@ static ssize_t btrfs_sinfo_bg_reclaim_threshold_store(struct kobject *kobj,
 	int thresh;
 	int ret;
 
+	if (!space_info)
+		return -EINVAL;
+
 	ret = kstrtoint(buf, 10, &thresh);
 	if (ret)
 		return ret;
@@ -924,6 +969,9 @@ static ssize_t btrfs_label_show(struct kobject *kobj,
 	char *label = fs_info->super_copy->label;
 	ssize_t ret;
 
+	if (!fs_info)
+		return -EINVAL;
+
 	spin_lock(&fs_info->super_lock);
 	ret = sysfs_emit(buf, label[0] ? "%s\n" : "%s", label);
 	spin_unlock(&fs_info->super_lock);
@@ -973,6 +1021,8 @@ static ssize_t btrfs_nodesize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%u\n", fs_info->super_copy->nodesize);
 }
 
@@ -983,6 +1033,8 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%u\n", fs_info->super_copy->sectorsize);
 }
 
@@ -993,6 +1045,8 @@ static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf,
 		"commits %llu\n"
 		"last_commit_ms %llu\n"
@@ -1035,6 +1089,8 @@ static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%u\n", fs_info->super_copy->sectorsize);
 }
 
@@ -1046,6 +1102,8 @@ static ssize_t quota_override_show(struct kobject *kobj,
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 	int quota_override;
 
+	if (!fs_info)
+		return -EINVAL;
 	quota_override = test_bit(BTRFS_FS_QUOTA_OVERRIDE, &fs_info->flags);
 	return sysfs_emit(buf, "%d\n", quota_override);
 }
@@ -1085,6 +1143,8 @@ static ssize_t btrfs_metadata_uuid_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%pU\n", fs_info->fs_devices->metadata_uuid);
 }
 
@@ -1094,8 +1154,11 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 				   struct kobj_attribute *a, char *buf)
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
-	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
+	u16 csum_type;
 
+	if (!fs_info)
+		return -EINVAL;
+	csum_type = btrfs_super_csum_type(fs_info->super_copy);
 	return sysfs_emit(buf, "%s (%s)\n",
 			  btrfs_super_csum_name(csum_type),
 			  crypto_shash_driver_name(fs_info->csum_shash));
@@ -1109,6 +1172,8 @@ static ssize_t btrfs_exclusive_operation_show(struct kobject *kobj,
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 	const char *str;
 
+	if (!fs_info)
+		return -EINVAL;
 	switch (READ_ONCE(fs_info->exclusive_operation)) {
 		case  BTRFS_EXCLOP_NONE:
 			str = "none\n";
@@ -1147,6 +1212,8 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%llu\n", fs_info->generation);
 }
 BTRFS_ATTR(, generation, btrfs_generation_show);
@@ -1205,6 +1272,8 @@ static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
+	if (!fs_info)
+		return -EINVAL;
 	return sysfs_emit(buf, "%d\n", READ_ONCE(fs_info->bg_reclaim_threshold));
 }
 
@@ -1216,6 +1285,9 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
 	int thresh;
 	int ret;
 
+	if (!fs_info)
+		return -EINVAL;
+
 	ret = kstrtoint(buf, 10, &thresh);
 	if (ret)
 		return ret;
@@ -1273,6 +1345,8 @@ static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj)
 
 static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj)
 {
+	if (!kobj)
+		return NULL;
 	if (kobj->ktype != &btrfs_ktype)
 		return NULL;
 	return to_fs_devs(kobj)->fs_info;
-- 
2.34.1

