Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E7E36AC3B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhDZG3U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhDZG3S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418517; x=1650954517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+fwcmCXKKtTFB5Xass2mOzXgeswnfWXCWGsBUZMjcNc=;
  b=WyXnm79kuOGB2W5S3IHKt6vhxoSexlSbks3IbX/PTULepqPL107SyyO1
   G1K5WaCWDbJfkkVpzbiKw7NOK4+T5+PHZtCYvQTfrrPTe3iS48IS3pxA8
   j0vGiaaJrAAEszT7DVXNmEMF56nlg4gui2MbGX9616qFUIUI0VD85FHGV
   LlP3HMsTeUEqjy2ng2V0fWBBqZTxNBSaOpDobUxaG7lshrtTYKZoFsPCe
   RGhERMgT+ZJb5IDPJW4nhjvAx0CfIJhxVLguB7/LjLieDMSopWi1Q3O4X
   LB0TrbLRlitFngfdomrANQ4W2us29Mod0k3Mobhdx3ErMQYD+QdHxm+KT
   Q==;
IronPort-SDR: fgFhEdl2E56xG6zY5C6AURprwzKUVutQYLRpBUd+VDcm7QoE5iDi/1Y9rchDwVuX9wY+jqSUe9
 s8ZKQ9ZDOaCgKX7G27xqfZZejQk3gyO/DuFQcfqzr7MK3u+sZf+YaSAebvhtalbRL1WpKRoJQ0
 0vqNVhVPvOZImANT3eIBZMmrUeLfJglWagM3dkWnocUM9S4CS5STEe53F6Ixcy0/Pqc/V3XC8Z
 X7uPxul/2GXLfy/RAJ1Ozt2+NIJke1aX7qdaeXzmKjPQwqtjG4aBs56AlTx2Eu4TVk+gtfFHy6
 Srw=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788145"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:37 +0800
IronPort-SDR: tW91xyIxFdJdHJRxCrqt2W5cpQ3G9i/YEJM3QBddidvpLdSU1wUxWEICu3oTZYlT8I29dBuu6v
 EYaIOv/80lU1E5kWcGhYJCju33E4XoJCSlLECsNApbaOw84KFuluksaug5dqQdYy8hP2HHlwKc
 qAH4U42+ARCmkuFjnJ2lZQ63y+8SrQM6Y8EqoPeS4ljxknN3XePpie78umBtyc05iAgB0xDP6G
 144hfKeWG/CxjOCyGITn5whjSm2Tk8xFMv3p/RvCvxxKPN1CZ6zJqkomOgUVJ/sU9IaCm0YnQ7
 W4WPVOwVJ7B2c5AeNaOGJva5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:09:01 -0700
IronPort-SDR: RhviBfCuwSH3Fu2C3J5d9gj3VrxU5FRxYgGgBvk/tqQSfFb7QaSZbmO3hbLVDHJN/Z5KFAgIj+
 PWl5fWYW/Q/ClB7S+841NjpH79Nfh8ccyUhB9Nevuhcld77BY+BOMNqiGWjGXGnCB9OnC7UWmR
 yiH7epYcYClKwCtQm9z+WUpDAlzwio0yCGPq7diHc9oum5Q6JLMuOccTyHUli1KhIICnx5QqxG
 WiUXzvqEnyaEHw3/3Xn9LT9W/lOYw58SI7GQCx2B5FQNbJDHHEgM/VbzzjBm/ZSmIH4Cxl+lDi
 yJk=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:37 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 26/26] btrfs-progs: zoned: introduce zoned support for device replace
Date:   Mon, 26 Apr 2021 15:27:42 +0900
Message-Id: <63e64f41e87756562d34322f19c78e5e5b4ec068.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch checks if the target file system is flagged as ZONED. If it is,
the device to be added is flagged PREP_DEVICE_ZONED.  Also add checks to
prevent mixing non-zoned devices and zoned devices.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 cmds/replace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/cmds/replace.c b/cmds/replace.c
index 53af8ca61898..1de4a6d3ca9f 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -122,12 +122,14 @@ static const char *const cmd_replace_start_usage[] = {
 static int cmd_replace_start(const struct cmd_struct *cmd,
 			     int argc, char **argv)
 {
+	struct btrfs_ioctl_feature_flags feature_flags;
 	struct btrfs_ioctl_dev_replace_args start_args = {0};
 	struct btrfs_ioctl_dev_replace_args status_args = {0};
 	int ret;
 	int i;
 	int fdmnt = -1;
 	int fddstdev = -1;
+	int zoned;
 	char *path;
 	char *srcdev;
 	char *dstdev = NULL;
@@ -182,6 +184,14 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	if (fdmnt < 0)
 		goto leave_with_error;
 
+	ret = ioctl(fdmnt, BTRFS_IOC_GET_FEATURES, &feature_flags);
+	if (ret) {
+		error("zoned: ioctl(GET_FEATURES) on '%s' returns error: %m",
+		      path);
+		goto leave_with_error;
+	}
+	zoned = feature_flags.incompat_flags & BTRFS_FEATURE_INCOMPAT_ZONED;
+
 	/* check for possible errors before backgrounding */
 	status_args.cmd = BTRFS_IOCTL_DEV_REPLACE_CMD_STATUS;
 	status_args.result = BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT;
@@ -286,7 +296,8 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	strncpy((char *)start_args.start.tgtdev_name, dstdev,
 		BTRFS_DEVICE_PATH_NAME_MAX);
 	ret = btrfs_prepare_device(fddstdev, dstdev, &dstdev_block_count, 0,
-			PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE);
+			PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE |
+			(zoned ? PREP_DEVICE_ZONED : 0));
 	if (ret)
 		goto leave_with_error;
 
-- 
2.31.1

