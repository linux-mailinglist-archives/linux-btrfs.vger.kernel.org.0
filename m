Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5284D0B3B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbiCGWiT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiCGWiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:38:11 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04C26158
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:37:16 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id x3so13244043qvd.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/F0QpiLrOePEXomwM613es9wYEF7GGZuL2Sa62LoZMM=;
        b=HzdyQVEfJQevaTJn6f0t4jhTcLxmYIp1xOqBCCaC66LW7ErCVsF1h0akK0kNkI+Pbj
         vummIIEAcxyiftpRVsT/JP3CIEenb81hzCJ53v54OOnzlIyyiVrff/JrXL0yZOkVa5Hw
         g12tBMG/AQ4sug/ZKMkkdq2lUN5fGELdi79tvDKe267da6Om19mWybjlZPEXiYhhRo0s
         8U9Dx4bBLWF5eIJjgKCfKsCYdVaTtKvcj0cWYfPKMtyxsRiY3FxQ2imOTlvJDjBR1RIu
         2ik19w+l7SEPaMsB9ctAl8eOqeiw0NlM0Yshj9ycyKp8LaGrW1wPzPK2owXn4iBLRrOJ
         mMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/F0QpiLrOePEXomwM613es9wYEF7GGZuL2Sa62LoZMM=;
        b=cfhS+4vaD4zn7c44oJ8uKnIdnTNmC5eiS7R6W0uaQ2+ieqR76eZDAYxvBN8eNPQrKa
         8nZJcM3eRdNf7IP/eMEd89mMzKkbBBVndje2LTPuT8VKWlWhIT3lkl/ZBL/2LGM2khFL
         t2tD14HODoiDKaVU/Up9bGHg1glTt7TpiH2NhC8Eg4k7iM5aCQcOueqQ04OCj7fCMD7M
         D+OQ9Wa29q9jHjI4nkd65+EL2338t18JVjjW6xhtahsREkBxh/p6Ip8krg9ZlSB3zMRq
         a53xRnkqP0t6vkfEoMcaUM28Z0jnTDcfcEGdN6f+IB/yY01WoWGh2WFJE81HrzaGMUXp
         HbpQ==
X-Gm-Message-State: AOAM530gl61DqEY3Hl0yX2jwkLrPTxf5KCU1drbvYHNxToKmS8gObhqh
        xPkAthXy4C7o+w0KpdDpSqM1W8Xw/rMUi0CD
X-Google-Smtp-Source: ABdhPJzB02ooq2F7sDlJ20miCKlU2mwUoFEne/I9+/zE6ml/ejI2mHcThDQ0ogxGlredAKdZQJ7IFA==
X-Received: by 2002:a05:6214:27e1:b0:435:8a67:fa25 with SMTP id jt1-20020a05621427e100b004358a67fa25mr6072359qvb.101.1646692635646;
        Mon, 07 Mar 2022 14:37:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e8-20020ac85dc8000000b002de409f360fsm9387682qtx.76.2022.03.07.14.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:37:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/11] btrfs: selftests: add a test for delete_one_dir_name
Date:   Mon,  7 Mar 2022 17:36:59 -0500
Message-Id: <af91dc5a529a81bfb70b6c3336700c7ab06aa71c.1646692474.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692474.git.josef@toxicpanda.com>
References: <cover.1646692474.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Because I can't do simple math I was convinced btrfs_delete_one_dir_name
was doing the wrong thing, so I wrote a self test to validate my theory.
I turned out to be wrong, but it's a valuable test to have for the
future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tests/extent-buffer-tests.c | 170 ++++++++++++++++++++++++++-
 1 file changed, 169 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tests/extent-buffer-tests.c b/fs/btrfs/tests/extent-buffer-tests.c
index 51a8b075c259..131495ffad12 100644
--- a/fs/btrfs/tests/extent-buffer-tests.c
+++ b/fs/btrfs/tests/extent-buffer-tests.c
@@ -8,6 +8,7 @@
 #include "../ctree.h"
 #include "../extent_io.h"
 #include "../disk-io.h"
+#include "../transaction.h"
 
 static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 {
@@ -210,8 +211,175 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
+static int test_delete_one_dir_name(u32 sectorsize, u32 nodesize)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_path *path = NULL;
+	struct btrfs_root *root = NULL;
+	struct extent_buffer *eb;
+	struct btrfs_dir_item *dir_item;
+	char *ptr;
+	struct btrfs_trans_handle trans;
+	char name_buf[6];
+	struct btrfs_key key;
+	u32 len = 0;
+	int ret = 0;
+	int i;
+
+	test_msg("running btrfs_delete_one_dir_name tests");
+
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	if (!fs_info) {
+		test_std_err(TEST_ALLOC_FS_INFO);
+		return -ENOMEM;
+	}
+
+	root = btrfs_alloc_dummy_root(fs_info);
+	if (IS_ERR(root)) {
+		test_std_err(TEST_ALLOC_ROOT);
+		ret = PTR_ERR(root);
+		goto out;
+	}
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		test_std_err(TEST_ALLOC_PATH);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	path->nodes[0] = eb = alloc_dummy_extent_buffer(fs_info, nodesize);
+	if (!eb) {
+		test_std_err(TEST_ALLOC_EXTENT_BUFFER);
+		ret = -ENOMEM;
+		goto out;
+	}
+	path->slots[0] = 0;
+
+	key.objectid = 0;
+	key.type = BTRFS_DIR_ITEM_KEY;
+	key.offset = 0;
+
+	btrfs_init_dummy_trans(&trans, fs_info);
+
+	/*
+	 * We are going to have 5 names, a, bb, ccc, dddd, eeeee, so the sizes
+	 * are the dir_item + i + 1.
+	 */
+	for (i = 0; i < 5; i++)
+		len += sizeof(struct btrfs_dir_item) + i + 1;
+
+	btrfs_setup_item_for_insert(root, path, &key, len);
+
+	ptr = btrfs_item_ptr(eb, path->slots[0], char);
+	for (i = 0; i < 5; i++) {
+		unsigned long name_ptr;
+
+		memset(name_buf, 'a' + i, i + 1);
+		dir_item = (struct btrfs_dir_item *)ptr;
+		btrfs_set_dir_type(eb, dir_item, i);
+		btrfs_set_dir_data_len(eb, dir_item, 0);
+		btrfs_set_dir_name_len(eb, dir_item, i + 1);
+		name_ptr = (unsigned long)(dir_item + 1);
+		write_extent_buffer(eb, name_buf, name_ptr, i + 1);
+		ptr += sizeof(struct btrfs_dir_item) + i + 1;
+	}
+
+	if (btrfs_item_size(eb, 0) != len) {
+		test_err("invalid len after initial start up");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Delete the ccc dir_name */
+	ptr = btrfs_item_ptr(eb, path->slots[0], char);
+	for (i = 0; i < 2; i++)
+		ptr += sizeof(struct btrfs_dir_item) + i + 1;
+	dir_item = (struct btrfs_dir_item *)ptr;
+	if (btrfs_dir_type(eb, dir_item) != 2) {
+		test_err("got the wrong dir type???\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_delete_one_dir_name(&trans, root, path, dir_item);
+	if (ret) {
+		test_err("got %d from btrfs_delete_one_dir_name", ret);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	len -= sizeof(struct btrfs_dir_item) + 3;
+	if (btrfs_item_size(eb, 0) != len) {
+		test_err("invalid len after delete");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ptr = btrfs_item_ptr(eb, path->slots[0], char);
+	for (i = 0; i < 4; i++) {
+		int real_index = i;
+		int c;
+
+		/*
+		 * We deleted ccc, which was index 2, so increase real_index by
+		 * 1 so we get the right value.
+		 */
+		if (i >= 2)
+			real_index++;
+
+		dir_item = (struct btrfs_dir_item *)ptr;
+		if (btrfs_dir_type(eb, dir_item) != real_index) {
+			test_err("dir item %d is mangled, dir_type is %d expected %d",
+				 i, btrfs_dir_type(eb, dir_item), real_index);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (btrfs_dir_data_len(eb, dir_item) != 0) {
+			test_err("dir item %d is mangled, data_len is %d expected 0",
+				 i, btrfs_dir_data_len(eb, dir_item));
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (btrfs_dir_name_len(eb, dir_item) != real_index + 1) {
+			test_err("dir item %d is mangled, name_len is %d expected %d",
+				 i, btrfs_dir_name_len(eb, dir_item),
+				 real_index + 1);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		read_extent_buffer(eb, name_buf, (unsigned long)(dir_item + 1),
+				   btrfs_dir_name_len(eb, dir_item));
+		for (c = 0; c < real_index + 1; c++) {
+			if (name_buf[c] != 'a' + real_index) {
+				test_err(
+		"dir item name %d is mangled, index is %d val is %c wanted %c",
+					 i, c, name_buf[c], 'a' + real_index);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+
+		ptr += sizeof(struct btrfs_dir_item) + real_index + 1;
+	}
+out:
+	btrfs_free_path(path);
+	btrfs_free_dummy_root(root);
+	btrfs_free_dummy_fs_info(fs_info);
+	return ret;
+}
+
 int btrfs_test_extent_buffer_operations(u32 sectorsize, u32 nodesize)
 {
+	int ret;
+
 	test_msg("running extent buffer operation tests");
-	return test_btrfs_split_item(sectorsize, nodesize);
+	ret = test_btrfs_split_item(sectorsize, nodesize);
+	if (ret)
+		return ret;
+	test_msg("running delete dir name etests");
+	return test_delete_one_dir_name(sectorsize, nodesize);
 }
-- 
2.26.3

