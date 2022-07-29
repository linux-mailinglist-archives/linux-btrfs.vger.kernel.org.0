Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536FC5854B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 19:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbiG2Rry (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 13:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbiG2Rrx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 13:47:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7804589A71
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 10:47:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3127F5BE2C;
        Fri, 29 Jul 2022 17:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659116867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Zc2g9pNr05z0kRBooCj0YvueO9O8jMwFGgPUK2uYSo=;
        b=gAXo+W/9v4O9+SJxV5tlctMiNElfX0lbwduKxVMfkCDu/wWSTj3FmazYGrP3z6L4LOyR5A
        FrVJdTsmAWh1Es9DJR1bD1wZwhzFIf1Ob9uCGV2R/OEVkK/zmtroLfO8UPo+PHzpz9+tik
        zBrE/XsNsktK30hbXJzPyxafJ0h7keA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 28D2D2C141;
        Fri, 29 Jul 2022 17:47:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1456CDA85A; Fri, 29 Jul 2022 19:42:49 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 3/4] btrfs: add checksum implementation selection after mount
Date:   Fri, 29 Jul 2022 19:42:49 +0200
Message-Id: <d62b2c8e27a7a38b5e76f1b9d94dfa0fc2fa0dd3.1659116355.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659116355.git.dsterba@suse.com>
References: <cover.1659116355.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The sysfs file /sys/fs/btrfs/FSID/checksum shows the filesystem checksum
and the crypto module implementing it. In the scenario when there's only
the default generic implementation available during mount it's selected,
even if there's an unloaded module with accelerated version.

This happens with sha256 that's often built-in so the crypto API may not
trigger loading the modules and select the fastest implementation. Such
filesystem could be left using in the generic for the whole time.
Remount can't fix that and full umount/mount cycle may be impossible eg.
for a root filesystem.

Allow writing strings to the sysfs checksum file that will trigger
loading the crypto shash again and check if the found module is the
desired one.

Possible values:

- default - select whatever is considered default by crypto subsystem,
            either generic or accelerated
- accel   - try loading an accelerated implementation (must not contain
            "generic" in the name)
- generic - load and select the generic implementation

A typical scenario, assuming sha256 is built-in:

  $ mkfs.btrfs --csum sha256
  $ lsmod | grep sha256
  $ mount /dev /mnt
  $ cat ...FSID/checksum
  sha256 (sha256-generic)
  $ modprobe sha256
  $ lsmod | grep sha256
  sha256_ssse3
  $ echo accel > ...FSID/checksum
  sha256 (sha256-ni)

The crypto shash for all slots has the same lifetime as the mount, so
it's not possible to unload the crypto module.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index cc943b236c92..0044644056ed 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1100,7 +1100,91 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 			  crypto_shash_driver_name(fs_info->csum_shash[CSUM_DEFAULT]));
 }
 
-BTRFS_ATTR(, checksum, btrfs_checksum_show);
+static const char csum_impl[][8] = {
+	[CSUM_DEFAULT]	= "default",
+	[CSUM_GENERIC]	= "generic",
+	[CSUM_ACCEL]	= "accel",
+};
+
+static int select_checksum(struct btrfs_fs_info *fs_info, enum btrfs_csum_impl type)
+{
+	/* Already set */
+	if (fs_info->csum_shash[CSUM_DEFAULT] == fs_info->csum_shash[type])
+		return 0;
+
+	/* Allocate new if needed */
+	if (!fs_info->csum_shash[type]) {
+		const u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
+		const char *csum_driver = btrfs_super_csum_driver(csum_type);
+		struct crypto_shash *shash1, *tmp;
+		char full_name[32];
+		u32 mask = 0;
+
+		/*
+		 * Generic must be requested explicitly, otherwise it could
+		 * be accelerated implementation with highest priority.
+		 */
+		scnprintf(full_name, sizeof(full_name), "%s%s", csum_driver,
+			  (type == CSUM_GENERIC ? "-generic" : ""));
+
+		shash1 = crypto_alloc_shash(full_name, 0, mask);
+		if (IS_ERR(shash1))
+			return PTR_ERR(shash1);
+
+		/* Accelerated requested but generic found */
+		if (type != CSUM_GENERIC &&
+		    strstr(crypto_shash_driver_name(shash1), "generic")) {
+			crypto_free_shash(shash1);
+			return -ENOENT;
+		}
+
+		tmp = cmpxchg(&fs_info->csum_shash[type], NULL, shash1);
+		if (tmp) {
+			/* Something raced in */
+			crypto_free_shash(shash1);
+		}
+	}
+
+	/* Select it */
+	fs_info->csum_shash[CSUM_DEFAULT] = fs_info->csum_shash[type];
+	return 0;
+}
+
+static bool strmatch(const char *buffer, const char *string);
+
+static ssize_t btrfs_checksum_store(struct kobject *kobj,
+				    struct kobj_attribute *a,
+				    const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+
+	if (!fs_info)
+		return -EPERM;
+
+	/* Pick the best available, generic or accelerated */
+	if (strmatch(buf, csum_impl[CSUM_DEFAULT])) {
+		if (fs_info->csum_shash[CSUM_ACCEL]) {
+			fs_info->csum_shash[CSUM_DEFAULT] =
+				fs_info->csum_shash[CSUM_ACCEL];
+			return len;
+		}
+		ASSERT(fs_info->csum_shash[CSUM_GENERIC]);
+		fs_info->csum_shash[CSUM_DEFAULT] = fs_info->csum_shash[CSUM_GENERIC];
+		return len;
+	}
+
+	for (int i = 1; i < CSUM_COUNT; i++) {
+		if (strmatch(buf, csum_impl[i])) {
+			int ret;
+
+			ret = select_checksum(fs_info, i);
+			return ret < 0 ? ret : len;
+		}
+	}
+
+	return -EINVAL;
+}
+BTRFS_ATTR_RW(, checksum, btrfs_checksum_show, btrfs_checksum_store);
 
 static ssize_t btrfs_exclusive_operation_show(struct kobject *kobj,
 		struct kobj_attribute *a, char *buf)
-- 
2.36.1

