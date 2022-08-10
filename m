Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E7D58E7E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 09:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiHJHer (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiHJHeq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 03:34:46 -0400
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3955CBC96
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 00:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1660116880; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=G+Uj6+91aYtJVkiknZhOQCKUjETaVt/ldTWKcMcyasYCVqqZZQ149wjl/zwkhnoob0wVKm4FqEXphtRBW4mStT0u1W9628jt16gIM7Ltxmi0hc25u8XFkK/onRz3MOE07ETOux7gLfU38WcQ2Z50STQiZ0mvKp9f9NUfzRG15lg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1660116880; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Eq0GbbbpHuNYV8oNdTo6Ah8fzTU3Y+aeVIHfufwIIGs=; 
        b=TUn8Q82iZjoS9QgA9Ifzr/uQJ8BaJK98sozgiYgs1CmnqDJX+hFMPyQC5CvXxE+dzO4xmykfLV82HYnjtNK9jgXJVjYnfMqLqRTACQAdUef0qhyRTcow6IzE5p4iWw7G0o+SDoOxsKntpWeAtymMyi05RJHRB2fTiu23DHW0DWQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:mime-version; 
  b=j+jnNH23jqH6O9HrsEcih2mPfffTbAUf2YxQLlOV0GRMZhpffQbvPVc3C/kJOXZ6fCwndmbnis0F
    jITkm3YBUhJJ6sezwN1kRC2SqrrDNAtHT+ZmCShOsf1a8p5K30sm  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660116880;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=Eq0GbbbpHuNYV8oNdTo6Ah8fzTU3Y+aeVIHfufwIIGs=;
        b=FEXNbLIiq/liEZHYub+rKe/W8kw3g1+Za/ETEEQxnyiWfAP5wrTNSLbIQfGrhkSb
        nfZcySGUp1clnIQs5IqXr/ldidqczvqlipdUplPZ526m1gOcrPlAgf2yR2GONFkHoo9
        +8lrdS3DR+Y6O1TOgqZOXmN7ysfyieceVztiDRkY=
Received: from localhost.localdomain (58.247.201.219 [58.247.201.219]) by mx.zohomail.com
        with SMTPS id 1660116875638372.8095626980464; Wed, 10 Aug 2022 00:34:35 -0700 (PDT)
From:   "Flint.Wang" <hmsjwzb@zoho.com>
To:     anand.jain@oracle.com, nborisov@suse.com
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, clm@fb.com
Subject: [PATCH] btrfs-progs: Fix seed device bug for btrfs249
Date:   Wed, 10 Aug 2022 15:33:47 +0800
Message-Id: <20220810073347.4998-1-hmsjwzb@zoho.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
---
 cmds/device.c           |  2 +-
 cmds/filesystem-usage.c | 10 +++++-----
 cmds/filesystem-usage.h |  2 +-
 common/utils.c          |  9 +++++----
 common/utils.h          |  2 +-
 ioctl.h                 |  2 ++
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index 7d3febff..81559110 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -752,7 +752,7 @@ static int _cmd_device_usage(int fd, const char *path, unsigned unit_mode)
 	int devcount = 0;
 
 	ret = load_chunk_and_device_info(fd, &chunkinfo, &chunkcount, &devinfo,
-			&devcount);
+			&devcount, false);
 	if (ret)
 		goto out;
 
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 01729e18..b2ed3212 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -693,7 +693,7 @@ out:
  *  This function loads the device_info structure and put them in an array
  */
 static int load_device_info(int fd, struct device_info **device_info_ptr,
-			   int *device_info_count)
+			   int *device_info_count, bool noseed)
 {
 	int ret, i, ndevs;
 	struct btrfs_ioctl_fs_info_args fi_args;
@@ -727,7 +727,7 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
 			goto out;
 		}
 		memset(&dev_info, 0, sizeof(dev_info));
-		ret = get_device_info(fd, i, &dev_info);
+		ret = get_device_info(fd, i, &dev_info, noseed);
 
 		if (ret == -ENODEV)
 			continue;
@@ -779,7 +779,7 @@ out:
 }
 
 int load_chunk_and_device_info(int fd, struct chunk_info **chunkinfo,
-		int *chunkcount, struct device_info **devinfo, int *devcount)
+		int *chunkcount, struct device_info **devinfo, int *devcount, bool noseed)
 {
 	int ret;
 
@@ -791,7 +791,7 @@ int load_chunk_and_device_info(int fd, struct chunk_info **chunkinfo,
 		return ret;
 	}
 
-	ret = load_device_info(fd, devinfo, devcount);
+	ret = load_device_info(fd, devinfo, devcount, noseed);
 	if (ret == -EPERM) {
 		warning(
 		"cannot get filesystem info from ioctl(FS_INFO), run as root");
@@ -1172,7 +1172,7 @@ static int cmd_filesystem_usage(const struct cmd_struct *cmd,
 			printf("\n");
 
 		ret = load_chunk_and_device_info(fd, &chunkinfo, &chunkcount,
-				&devinfo, &devcount);
+				&devinfo, &devcount, true);
 		if (ret)
 			goto cleanup;
 
diff --git a/cmds/filesystem-usage.h b/cmds/filesystem-usage.h
index cab38462..6fd04172 100644
--- a/cmds/filesystem-usage.h
+++ b/cmds/filesystem-usage.h
@@ -45,7 +45,7 @@ struct chunk_info {
 };
 
 int load_chunk_and_device_info(int fd, struct chunk_info **chunkinfo,
-		int *chunkcount, struct device_info **devinfo, int *devcount);
+		int *chunkcount, struct device_info **devinfo, int *devcount, bool noseed);
 void print_device_chunks(struct device_info *devinfo,
 		struct chunk_info *chunks_info_ptr,
 		int chunks_info_count, unsigned unit_mode);
diff --git a/common/utils.c b/common/utils.c
index 1ed5571f..72d50885 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -285,14 +285,15 @@ void btrfs_format_csum(u16 csum_type, const u8 *data, char *output)
 }
 
 int get_device_info(int fd, u64 devid,
-		struct btrfs_ioctl_dev_info_args *di_args)
+		struct btrfs_ioctl_dev_info_args *di_args, bool noseed)
 {
 	int ret;
+	unsigned long req = noseed ? BTRFS_IOC_DEV_INFO_NOSEED : BTRFS_IOC_DEV_INFO;
 
 	di_args->devid = devid;
 	memset(&di_args->uuid, '\0', sizeof(di_args->uuid));
 
-	ret = ioctl(fd, BTRFS_IOC_DEV_INFO, di_args);
+	ret = ioctl(fd, req, di_args);
 	return ret < 0 ? -errno : 0;
 }
 
@@ -498,7 +499,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 		 * search_chunk_tree_for_fs_info() will lacks the devid 0
 		 * so manual probe for it here.
 		 */
-		ret = get_device_info(fd, 0, &tmp);
+		ret = get_device_info(fd, 0, &tmp, false);
 		if (!ret) {
 			fi_args->num_devices++;
 			ndevs++;
@@ -521,7 +522,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 		memcpy(di_args, &tmp, sizeof(tmp));
 	for (; last_devid <= fi_args->max_id && ndevs < fi_args->num_devices;
 	     last_devid++) {
-		ret = get_device_info(fd, last_devid, &di_args[ndevs]);
+		ret = get_device_info(fd, last_devid, &di_args[ndevs], false);
 		if (ret == -ENODEV)
 			continue;
 		if (ret)
diff --git a/common/utils.h b/common/utils.h
index ea05fe5b..de4f93ca 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -68,7 +68,7 @@ int lookup_path_rootid(int fd, u64 *rootid);
 int find_mount_fsroot(const char *subvol, const char *subvolid, char **mount);
 int find_mount_root(const char *path, char **mount_root);
 int get_device_info(int fd, u64 devid,
-		struct btrfs_ioctl_dev_info_args *di_args);
+		struct btrfs_ioctl_dev_info_args *di_args, bool noseed);
 int get_df(int fd, struct btrfs_ioctl_space_args **sargs_ret);
 
 const char *subvol_strip_mountpoint(const char *mnt, const char *full_path);
diff --git a/ioctl.h b/ioctl.h
index 368a87b2..e68fe58d 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -883,6 +883,8 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
 					struct btrfs_ioctl_scrub_args)
 #define BTRFS_IOC_DEV_INFO _IOWR(BTRFS_IOCTL_MAGIC, 30, \
 					struct btrfs_ioctl_dev_info_args)
+#define BTRFS_IOC_DEV_INFO_NOSEED _IOR(BTRFS_IOCTL_MAGIC, 30, \
+				       struct btrfs_ioctl_dev_info_args)
 #define BTRFS_IOC_FS_INFO _IOR(BTRFS_IOCTL_MAGIC, 31, \
                                  struct btrfs_ioctl_fs_info_args)
 #define BTRFS_IOC_BALANCE_V2 _IOWR(BTRFS_IOCTL_MAGIC, 32, \
-- 
2.37.0

