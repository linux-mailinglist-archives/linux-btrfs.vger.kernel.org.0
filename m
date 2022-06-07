Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6AA5421DD
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346494AbiFHA2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 20:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587674AbiFGXxc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 19:53:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1809221C610
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 15:48:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B90BB1F892;
        Tue,  7 Jun 2022 22:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654642086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=O15+Ss7fS2iJzBANwdbWSHFCBHmkUXSz2vVE94mvMD0=;
        b=jZRfKdwMuAmZhTFS6u591bF4PDY4LXMUjgGk037NiP1Vlvnw1dgZsTGTxVeYFZT03RvcbK
        Bj7Qh2bL70cXkDf9zB+HWScM7rauC9nl/vRj9cj2YQuNgVR6cXdkK7Qkjgncjx/SazdUOh
        xi8e0OouujIZVgBKvM7N28XkA6ESmi4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B0CDB2C141;
        Tue,  7 Jun 2022 22:48:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 33BB8DA8EA; Wed,  8 Jun 2022 00:43:38 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH RFC] btrfs: customizable log message id
Date:   Wed,  8 Jun 2022 00:43:37 +0200
Message-Id: <20220607224337.11898-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs messages are made of several parts, like prefix, the device
for identification, and the message:

  BTRFS info (device loop0): using free space tree

Based on user feedback, something else than the device would be desired,
like the uuid or label. As the messages are sort of a public interface,
eg. for log scrapers or monitoring tools, changing current 'device' to
a new default would potentially break that, and users have different
preferences as the discussion showed.

Thus it's configurable. As implemented now it's per filesystem and can
be set after mount. There's no global setting but can be implemented.

Configuration is done by sysfs by writing following strings to the file
/sys/fs/btrfs/UUID/msgid:

- device (current default)
- uuid - will print the filesystem uuid/fsid

  BTRFS info (uuid 7989fadb-469d-4969-ba6b-d1ead726a920): using free space tree

- uuid-short - print only first part of the uuid

  BTRFS info (uuid 7989fadb-469d): using free space tree

- label - print label

  BTRFS info (label TEST): using free space tree

Signed-off-by: David Sterba <dsterba@suse.com>
---

This is RFC, questions to discuss:

- rename 'msgid' to something else
- configurable at module load time as a parameter as the default
- configurable after load gobally in sysfs (/sys/fs/btrfs/msgid)
- both global and per-filesystem sysfs knob
- change the default eventually but to what
- other identification, suggestions were eg. devid, uuid+devid

 fs/btrfs/ctree.h   | 10 ++++++++++
 fs/btrfs/disk-io.c |  3 +++
 fs/btrfs/super.c   | 31 +++++++++++++++++++++++++++++--
 fs/btrfs/sysfs.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f7afdfd0bae7..e448394451f1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -646,6 +646,14 @@ enum {
 #endif
 };
 
+enum btrfs_msgid_type {
+	BTRFS_MSGID_DEVICE,
+	BTRFS_MSGID_UUID,
+	BTRFS_MSGID_UUID_SHORT,
+	BTRFS_MSGID_LABEL,
+	BTRFS_MSGID_COUNT
+};
+
 /*
  * Exclusive operations (device replace, resize, device add/remove, balance)
  */
@@ -744,6 +752,8 @@ struct btrfs_fs_info {
 	 */
 	u64 max_inline;
 
+	enum btrfs_msgid_type msgid_type;
+
 	struct btrfs_transaction *running_transaction;
 	wait_queue_head_t transaction_throttle;
 	wait_queue_head_t transaction_wait;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 800ad3a9c68e..d1c6d372d5f7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3138,6 +3138,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 
 	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
 	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
+
+	/* Set default here */
+	fs_info->msgid_type = BTRFS_MSGID_UUID;
 }
 
 static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 719dda57dc7a..8227bcce9817 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -291,10 +291,37 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
 	if (__ratelimit(ratelimit)) {
 		if (fs_info) {
 			char statestr[STATE_STRING_BUF_LEN];
+			char *idtype;
+			char id[64] = { 0 };
+			bool short_fsid = false;
+
+			switch (READ_ONCE(fs_info->msgid_type)) {
+			default:
+			case BTRFS_MSGID_DEVICE:
+				idtype = "device";
+				scnprintf(id, sizeof(id), "%s", fs_info->sb->s_id);
+				break;
+			case BTRFS_MSGID_UUID_SHORT:
+				short_fsid = true;
+				fallthrough;
+			case BTRFS_MSGID_UUID:
+				idtype = "fsid";
+				scnprintf(id, sizeof(id), "%pU",
+					  fs_info->fs_devices->fsid);
+				if (short_fsid)
+					id[13] = 0;
+				break;
+			case BTRFS_MSGID_LABEL:
+				idtype = "label";
+				/* Fixme: first 64 from label */
+				scnprintf(id, sizeof(id), "%s",
+					  fs_info->super_copy->label);
+				break;
+			}
 
 			btrfs_state_to_string(fs_info, statestr);
-			_printk("%sBTRFS %s (device %s%s): %pV\n", lvl, type,
-				fs_info->sb->s_id, statestr, &vaf);
+			_printk("%sBTRFS %s (%s %s%s): %pV\n", lvl, type,
+				idtype, id, statestr, &vaf);
 		} else {
 			_printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);
 		}
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 3554c7b4204f..94dd28112414 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -962,6 +962,8 @@ static ssize_t btrfs_label_store(struct kobject *kobj,
 	memcpy(fs_info->super_copy->label, buf, p_len);
 	spin_unlock(&fs_info->super_lock);
 
+	/* Fixme: if label is empty, reset msgid_type to default */
+
 	/*
 	 * We don't want to do full transaction commit from inside sysfs
 	 */
@@ -1214,6 +1216,43 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
 BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
 	      btrfs_bg_reclaim_threshold_store);
 
+static const char *msgid_strings[] = {
+	[BTRFS_MSGID_DEVICE]	= "device",
+	[BTRFS_MSGID_UUID]	= "uuid",
+	[BTRFS_MSGID_UUID_SHORT] = "uuid-short",
+	[BTRFS_MSGID_LABEL]	= "label",
+};
+
+static ssize_t btrfs_msgid_show(struct kobject *kobj,
+				struct kobj_attribute *a,
+				char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+
+	return sysfs_emit(buf, "%s\n", msgid_strings[fs_info->msgid_type]);
+}
+
+static ssize_t btrfs_msgid_store(struct kobject *kobj,
+				 struct kobj_attribute *a,
+				 const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	int i;
+
+	for (i = 0; i < BTRFS_MSGID_COUNT; i++) {
+		/* Fixme: if label is empty do a fallback */
+		if (strmatch(buf, msgid_strings[i])) {
+			WRITE_ONCE(fs_info->msgid_type, i);
+			break;
+		}
+	}
+	if (i == BTRFS_MSGID_COUNT)
+		return -EINVAL;
+
+	return len;
+}
+BTRFS_ATTR_RW(, msgid, btrfs_msgid_show, btrfs_msgid_store);
+
 /*
  * Per-filesystem information and stats.
  *
@@ -1231,6 +1270,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, generation),
 	BTRFS_ATTR_PTR(, read_policy),
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
+	BTRFS_ATTR_PTR(, msgid),
 	NULL,
 };
 
-- 
2.36.1

