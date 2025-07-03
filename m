Return-Path: <linux-btrfs+bounces-15218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A131AF668B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 02:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AB477AA572
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 00:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D4EDDC3;
	Thu,  3 Jul 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpdLeBlN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1012DE706
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 00:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751502005; cv=none; b=HB8iNSuilrx5XGX0BfEb5nUb6ypwVZu7eJDUGoP+6CatwadEZvGM+D6wnNnM1rOYyhYVi1g/VtJk11CQun65kOi6+pFdSRWR9LTFpK6T/dHxYpAFIOpdx49Zbh1XYGNyEcQtfuNnbcuo2P7QVYnIhkOkC+Wv1Q+vfDGR9OV3/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751502005; c=relaxed/simple;
	bh=PoNitstVI/5wUY+zS5CDoVGzbOv2X+1rAhe50kFvWVQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=W9xZjDfLHokm8ENc4ItrDg9PADVzWq0UK4nWAV/IelCXjm0M6Rb9XCZTJA+vr+hiozC8681gTZybio5mJ6IJQr7m0TtbIx03kPdiopzTk6HTsfSPCM/rELE0ijnIfkJXcPLjNbEI41UPF62XfNY/JVQdmCChVL6HhD5/M5Xbvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpdLeBlN; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso6552183276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Jul 2025 17:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751502002; x=1752106802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MrHi+ZzwOqUvBL7g1sm23Wbd++J9GiRpdD/ucWd0Q6w=;
        b=SpdLeBlNwtUd1qf2WIZD7KBaC09N6XtFHJB1OQgI8roi01tr9V/VhgW/JkTDi5vLLD
         w8+WY5Xp2btkbrpSttkT1/gghdiFT2vChRU0oN8Mim30O0q1Vsk1BVhU9RwMHc0Grahw
         2ci5y/9c+Qkux7X92Tk7MQ0g1fSd4Ib/++PkDJMB6GNKV7tkph0jURB2GV0wvnCBRgUU
         3a9Lfav+K07NjweLRUHQdCpjLjwd14gK//TfYDYG9OIhxF05/r4jZVHOpoVOHuo6dKjA
         n4G6F5XrWc1B9lXP9SJXyBcFL1RSuF0uup9DMs6AGK3H6EEurMFxZ68q4FwrPnWV6l+v
         8W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751502002; x=1752106802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrHi+ZzwOqUvBL7g1sm23Wbd++J9GiRpdD/ucWd0Q6w=;
        b=U7Mjt0xYDyY1AE1UN1qnR2OzTQn0tJqCXSu/rHpMRaz7HmoBuMwxnoNMbY+eXuceHf
         anM+ZqZ3Xzws9NQopBw6bndQMfly4RFxESACRitBMqmfxy+AM00GQQxB43oqb+z+znMv
         dyF0ZF0RhY9Hwzo1d9sdS4jFSKRUNNoeBJipUyNwlH+1ikKAqJ8k/g6QMwMbJPxaVvjD
         JsOfPpGEnTIsV1aUsLQC5DPwsLvI68KeQMvfX3I4cmMWa/LwYTJop/hhJO06eNTS2ubn
         8heLASi1pigmVtFQ+lzDKb2GcGNNigMff/C2X7Z5XEPN141FaayxAhazArFqqh+LI7nc
         +m9Q==
X-Gm-Message-State: AOJu0YyVmaLKbXwaa4ist/UcJuQMT+0SudkIHbyQaugzHyN9vFoIiKMc
	YqiuY5LbmoOdLG6jc791J2nFpa22nF1YvIeF7RKflQbsHqNpdixHWpccvElENZGh
X-Gm-Gg: ASbGncuQWtPYWfA6ic5ZHK1MD5YgT0fUpcDh/nb4uAK8etpXAo47hQJDTs63oce6KmO
	pklmDhhu3xNZLouJAE9mgDJKhqiRf8ZOx38P5YdKCD6OgRD+8cFsPO3iNDVngO9c1DJwRUBEs2L
	ORRednu9SbNB2uu58aY58mOaoYcDLcO1dvh2pi+fgtci0ZLDkRsxcmc0EisQouw9qDRceppfpAc
	vmO0tyCQsl1Y2nv7uBlP73FjyJUHGkq+472Y7/7WqxZ9Vqp0WwFrC0XFNZNss+CrosnrFTN1aJD
	y3BI7VlNdkLLr++S3sIfxJSIF1h+6sYTe1FU02FD3tpDilETPueljg3rvw==
X-Google-Smtp-Source: AGHT+IGVmvHMHHqBVOXW7WXhh0YuEJOyGb6N3XNz5q0w2uSJ0MW9fwlIBTdINSDLan72+5d5g24nRw==
X-Received: by 2002:a05:690c:d1d:b0:703:afd6:42e3 with SMTP id 00721157ae682-7165a411a27mr15662727b3.37.1751502002167;
        Wed, 02 Jul 2025 17:20:02 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:47::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb33c5sm26752747b3.86.2025.07.02.17.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 17:20:01 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/1] btrfs-progs: offline filesystem resize feature
Date: Wed,  2 Jul 2025 17:19:59 -0700
Message-ID: <88692c651bf3350e1d7e9becb1789ec1c687afd1.1751501355.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces the ability to resize a btrfs filesystem while it
is not mounted via a new `--offline` flag. Currently only increasing the
size of the filesystem is supported, though I believe it would be possible
to implement shrinking the filesystem to the end of the last device extent.

This is a more general, and hopefully more useful, solution to the problem
I was trying to solve with the
("btrfs-progs: add slack space for mkfs --shrink") patch. This patch
should enable users to resize a filesystem without the capabilities needed
for mounting a filesystem.


Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 cmds/filesystem.c | 260 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 258 insertions(+), 2 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 54a186f0..81eae6c8 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -38,10 +38,12 @@
 #include "kernel-lib/sizes.h"
 #include "kernel-lib/list_sort.h"
 #include "kernel-lib/overflow.h"
+#include "kernel-shared/accessors.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/compression.h"
-#include "kernel-shared/volumes.h"
 #include "kernel-shared/disk-io.h"
+#include "kernel-shared/transaction.h"
+#include "kernel-shared/volumes.h"
 #include "common/defs.h"
 #include "common/internal.h"
 #include "common/messages.h"
@@ -1270,6 +1272,7 @@ static const char * const cmd_filesystem_resize_usage[] = {
 	"[kK] means KiB, which denotes 1KiB = 1024B, 1MiB = 1024KiB, etc.",
 	"",
 	OPTLINE("--enqueue", "wait if there's another exclusive operation running, otherwise continue"),
+	OPTLINE("--offline", "resize an offline filesystem, only increases are allowed"),
 	NULL
 };
 
@@ -1423,6 +1426,246 @@ out:
 	return ret;
 }
 
+static int check_offline_resize_args(const struct btrfs_fs_info *fs_info,
+				     const char *amount, const char *path,
+				     struct btrfs_device **device_ret,
+				     u64 *new_size_ret)
+{
+	int ret = 0;
+
+	char amount_dup[BTRFS_VOL_NAME_MAX];
+
+	struct btrfs_device *device = NULL;
+	struct btrfs_device *mindev = NULL;
+	bool dev_found = false;
+	u64 devid = 1;
+	u64 mindevid = (u64)-1;
+	char *devstr = NULL;
+
+	struct stat stat_buf;
+	char *sizestr = NULL;
+	u64 new_size = 0, old_size = 0, diff = 0;
+	int mod = 0;
+
+	if (check_mounted(path)) {
+		error("%s must not be mounted to use --offline", path);
+		ret = 1;
+		goto out;
+	}
+
+	if (!fs_info->fs_devices->num_devices) {
+		error("no devices found");
+		ret = 1;
+		goto out;
+	}
+
+	ret = snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%s", amount);
+	if (strlen(amount) != ret) {
+		error("newsize argument is too long");
+		ret = 1;
+		goto out;
+	}
+	ret = 0;
+
+	if (strcmp(amount, "cancel") == 0) {
+		error("cannot cancel offline resize since the operation is synchronous");
+		ret = 1;
+		goto out;
+	}
+
+	/* Parse device id. */
+	sizestr = amount_dup;
+	devstr = strchr(sizestr, ':');
+	if (devstr) {
+		sizestr = devstr + 1;
+		*devstr = 0;
+		devstr = amount_dup;
+
+		errno = 0;
+		devid = strtoull(devstr, NULL, 10);
+
+		if (errno) {
+			error("failed to parse devid %s: %m", devstr);
+			ret = 1;
+			goto out;
+		}
+	}
+
+	/* Find device matching device id */
+	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
+		if (device->devid < mindevid) {
+			mindevid = device->devid;
+			mindev = device;
+		}
+		if (device->devid == devid) {
+			dev_found = true;
+			break;
+		}
+	}
+
+	if (devstr && !dev_found) {
+		/* Devid specified but not found. */
+		error("cannot find devid: %lld", devid);
+		ret = 1;
+		goto out;
+	} else if (!devstr && devid == 1 && !dev_found) {
+		/*
+		 * No device specified, assuming implicit 1 but it does not
+		 * exist. Use minimum device as fallback.
+		 */
+		warning("no devid specified means devid 1 which does not exist, using\n"
+			"\t lowest devid %llu as a fallback",
+			mindevid);
+		devid = mindevid;
+		device = mindev;
+	}
+	if (!device) {
+		error("unable to find device");
+		ret = 1;
+		goto out;
+	}
+	*device_ret = device;
+	old_size = device->total_bytes;
+
+	if (strcmp(sizestr, "max") == 0) {
+		if (path_is_block_device(device->name)) {
+			new_size = device_get_partition_size(device->name);
+		} else if (path_is_reg_file(device->name)) {
+			stat(device->name, &stat_buf);
+			new_size = stat_buf.st_size;
+		}
+
+		if (new_size == 0) {
+			error("unable to get size for device: %s",
+			      device->name);
+			ret = 1;
+			goto out;
+		}
+	} else {
+		if (sizestr[0] == '-') {
+			error("offline resize does not support shrinking");
+			ret = 1;
+			goto out;
+		} else if (sizestr[0] == '+') {
+			mod = 1;
+			sizestr++;
+		}
+		ret = parse_u64_with_suffix(sizestr, &diff);
+		if (ret < 0) {
+			error("failed to parse size %s", sizestr);
+			ret = 1;
+			goto out;
+		}
+
+		/* For target sizes without +/- sign prefix (e.g. 1:150g) */
+		if (mod == 0) {
+			new_size = diff;
+		} else if (mod > 0) {
+			if (diff > ULLONG_MAX - old_size) {
+				error("increasing %s is out of range",
+				      pretty_size_mode(diff, UNITS_DEFAULT));
+				ret = 1;
+				goto out;
+			}
+			new_size = old_size + diff;
+		}
+	}
+	new_size = round_down(new_size, fs_info->sectorsize);
+	if (new_size < old_size) {
+		error("offline resize does not support shrinking");
+		ret = 1;
+		goto out;
+	}
+	*new_size_ret = new_size;
+
+	if (path_is_block_device(device->name) &&
+	    new_size > device_get_partition_size(device->name)) {
+		error("unable to resize '%s': not enough free space",
+		      device->name);
+		ret = 1;
+		goto out;
+	}
+
+	if (new_size < 256 * SZ_1M)
+		warning("the new size %lld (%s) is < 256MiB, this may be rejected by kernel",
+			new_size, pretty_size_mode(new_size, UNITS_DEFAULT));
+
+	pr_verbose(LOG_DEFAULT, "Resize device id %lld from %s to %s\n", devid,
+		   pretty_size_mode(old_size, UNITS_DEFAULT),
+		   pretty_size_mode(new_size, UNITS_DEFAULT));
+out:
+	return ret;
+}
+
+static int offline_resize(const char *amount, const char *path)
+{
+	int ret = 0, ret2 = 0;
+	struct btrfs_root *root;
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_device *device;
+	struct btrfs_super_block *super_copy;
+	struct btrfs_trans_handle *trans;
+	u64 new_size;
+
+	u64 old_total;
+	u64 diff;
+
+	char dev_name[BTRFS_VOL_NAME_MAX];
+
+	root = open_ctree(path, 0, OPEN_CTREE_WRITES);
+	if (!root) {
+		error("could not open file at %s\n"
+		      "offline resize works on a file containing a btrfs image.",
+		      path);
+		return 1;
+	}
+	fs_info = root->fs_info;
+	super_copy = fs_info->super_copy;
+
+	ret = check_offline_resize_args(fs_info, amount, path, &device,
+					&new_size);
+	if (ret) {
+		ret = 1;
+		goto close;
+	}
+
+	ret = snprintf(dev_name, BTRFS_VOL_NAME_MAX, "%s", device->name);
+	if (strlen(device->name) != ret) {
+		error("device name too long %s", device->name);
+		ret = 1;
+		goto close;
+	}
+	ret = 0;
+
+	trans = btrfs_start_transaction(root, 0);
+	old_total = btrfs_super_total_bytes(super_copy);
+	diff = round_down(new_size - device->total_bytes, fs_info->sectorsize);
+	btrfs_set_super_total_bytes(
+		super_copy, round_down(old_total + diff, fs_info->sectorsize));
+	device->total_bytes = new_size;
+
+	ret = btrfs_update_device(trans, device);
+	ret2 = btrfs_commit_transaction(trans, root);
+	if (ret2)
+		ret = 1;
+close:
+	ret2 = close_ctree(root);
+	if (ret2)
+		ret = 1;
+
+	if (ret)
+		return ret;
+
+	if (path_is_reg_file(dev_name)) {
+		ret = truncate(dev_name, new_size);
+		if (ret) {
+			error("failed to truncate %s", device->name);
+			ret = 1;
+		}
+	}
+	return ret;
+}
+
 static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 				 int argc, char **argv)
 {
@@ -1432,6 +1675,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	u64 devid;
 	int ret;
 	bool enqueue = false;
+	bool offline = false;
 	bool cancel = false;
 
 	/*
@@ -1441,6 +1685,8 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	for (optind = 1; optind < argc; optind++) {
 		if (strcmp(argv[optind], "--enqueue") == 0) {
 			enqueue = true;
+		} else if (strcmp(argv[optind], "--offline") == 0) {
+			offline = true;
 		} else if (strcmp(argv[optind], "--") == 0) {
 			/* Separator: options -- non-options */
 		} else if (strncmp(argv[optind], "--", 2) == 0) {
@@ -1455,6 +1701,12 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	if (check_argc_exact(argc - optind, 2))
 		return 1;
 
+	if (offline && enqueue) {
+		error("--enqueue is not compatible with --offline\n"
+		      "since offline resizing is synchronous");
+		return 1;
+	}
+
 	amount = argv[optind];
 	path = argv[optind + 1];
 
@@ -1464,6 +1716,9 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		return 1;
 	}
 
+	if (offline)
+		return offline_resize(amount, path);
+
 	cancel = (strcmp("cancel", amount) == 0);
 
 	fd = btrfs_open_dir(path);
@@ -1473,7 +1728,8 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 			error(
 		"resize works on mounted filesystems and accepts only\n"
 		"directories as argument. Passing file containing a btrfs image\n"
-		"would resize the underlying filesystem instead of the image.\n");
+		"would resize the underlying filesystem instead of the image.\n"
+		"To resize a file containing a btrfs image please use the --offline flag.\n");
 		}
 		return 1;
 	}
-- 
2.47.1


