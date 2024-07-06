Return-Path: <linux-btrfs+bounces-6342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAF492D5FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 18:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B924B261EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDB71990B7;
	Wed, 10 Jul 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsUQEpVB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3750319754A
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2024 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627893; cv=none; b=o7k/f6k9IiaWrKL8jcfzzF6fU+m593gx6o3+yPIeSgZBjozhCnNPFJDQf+0FLeO6B/rAA/uxyfzxWZluo681DXI3JSzv9G8ENKWkkU+FepfDbtVXlockLaA4kwEsMEElB0+WSKjtMB2Ao7RMXtc5nGAV6BBwxxybNMxAv/q0ULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627893; c=relaxed/simple;
	bh=W+xC2mKfBPn97b9Wxsh+oaTKEQsB8EEqY2f1Mz2EcQo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HlnrgzvL0nZk8CB6eRuUkKpNg3R9+NScEGGhPcP+NCUZI+EuVT7ORwtZGntKRuttiD8Kubu+t3Q9BW3rS30FdiY4Te7F4FQzxjZVtUG0iY+RRZKqXte6j3Gzx+rhua4iqkyRKSw87VPI3HIPD1RDp8UwomYkMFhg/8HOqET6PhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsUQEpVB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fb222a8eaeso45335805ad.3
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2024 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720627890; x=1721232690; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQl2yHiVy+mPn7Waz0O9okAMLZNv3k/93SJ5oKHS4Iw=;
        b=AsUQEpVByDBAwR37IA8/g4Zp/LTn73+xWHxelm9ugGlmOxlQa7AJH9dmON3iZy9Fq5
         QsXkqVnMDHzGeTa15JmG9yg/NIbxlYxqpwpSjEt4wQUKotl3JMGdlAmbXHcNYXyDHePZ
         pUwInVdDK43pGzy5cVaTKSu1XpKjSnL/Vxlde+/2l/lrLw7up/v1s9e2LZf2vePu9Xb9
         7P7r5p2hnn1Z7IUv1ObADU/cYzypJxngNZ4d6m4FK9tWXkeapRhBG1Gpnbv0O/bR50rm
         BotRCap2UC6LDYv84v2h+pXmhOpBCCxDOG05djF6SojzEkJ3Wr2BobqE57n9P2iFI2NP
         dFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627890; x=1721232690;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQl2yHiVy+mPn7Waz0O9okAMLZNv3k/93SJ5oKHS4Iw=;
        b=Hb8GAQU3B3zGg/RnK4JxD7BnQM5XNaoGzmyfO9odFnv3LFZ+B3ApI84huv0PpW5NNb
         HRnCX2TTiY/7XXZsDAwkr3vqZ66iFThcJC9ltGJSTgFi2OTSboOyewwlLDx4o/URrp9j
         57mrJeUEhMHLP1cad3IBbGBADj1pfvXLl9/DL0ZYJJ/9NAvVjpFn/lNbn0RJxgWyECxC
         SazAdU/oSdVoU/Wf0yQg0c9JR9Beu6Cf9V0CaCQDBqE+vPNqdPhJNecna9xtRBw9eW11
         FBES06H7jWTTksJj65tn72iSNHQU+Dcr0tu5acRKSkWNdor0No9L2XaZHUUImnaGRHPq
         gYNA==
X-Gm-Message-State: AOJu0YwEl4xTAsVqLzwVDU7F75hWA/0vd0dMv2JhwtPxZcEZ//25hawf
	9ZhoPFGC72rUM8yIaXoYDZ0thFTSC9/QjfMgxUtNTPyZpzXwkij2JGZr4WYppVkLMQ==
X-Google-Smtp-Source: AGHT+IHEbj+FNxF+2vKpBPpLku95wP8SK6G62IDREK90tREHUBG0pg6DsSHD6bkHxsqnK1coKiZOFw==
X-Received: by 2002:a17:903:2445:b0:1fa:d3d:a68d with SMTP id d9443c01a7336-1fbb6d0457fmr56039375ad.22.1720627890119;
        Wed, 10 Jul 2024 09:11:30 -0700 (PDT)
Received: from zlke.localdomain ([14.145.7.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a28e5csm35677955ad.79.2024.07.10.09.11.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2024 09:11:29 -0700 (PDT)
From: Li Zhang <zhanglikernel@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH V2] btrfs-prog: scrub: print message when scrubbing a  read-only  filesystem without r option
Date: Sun,  7 Jul 2024 02:58:36 +0800
Message-Id: <1720292316-24008-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

[enhancement]
When scrubbing a filesystem mounted read-only and without r
option, it aborts and there is no message associated with it.
So we need to print an error message when scrubbing a read-only
filesystem to tell the user what is going on here.

[implementation]
Move the error message from the main thread to each scrub thread,
previously the message was printed after all scrub threads
finished and without background mode.

[test]
Mount dev in read-only mode, then scrub it without r option

$ sudo mount /dev/vdb -o ro /mnt/
$ sudo btrfs scrub start /mnt/
ERROR: this filesystem is mounted readonly, but scrub option without r option.

issue: #666

V1:
  Output directly within the thread.

V2:
  Use the getmntent() function to obtain a bitmask to check
  whether the file system is mounted read-only.

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 cmds/scrub.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 202690d..79011a2 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -42,6 +42,7 @@
 #include <syscall.h>
 #include <time.h>
 #include <uuid/uuid.h>
+#include <mntent.h>
 #include "kernel-lib/sizes.h"
 #include "kernel-shared/volumes.h"
 #include "common/defs.h"
@@ -1224,6 +1225,34 @@ static u64 write_scrub_device_limit(int fd, u64 devid, u64 limit)
 	return ret;
 }
 
+/*
+ * Check if given path is a mount read only.
+ *
+ * Return: 1 if yes,
+ *         0 if no,
+ *        -1 for error
+ */
+static int path_is_mount_readonly(const char *path){
+	FILE *f;
+	struct mntent *mnt;
+	int ret = -1;
+	
+	f = setmntent("/proc/self/mounts", "r");
+	if (f == NULL)
+		return -1;
+	while ((mnt = getmntent(f)) != NULL) {
+		if (strcmp(mnt->mnt_dir, path))
+			continue;
+		if (hasmntopt(mnt, MNTOPT_RO))
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	}
+	endmntent(f);
+	return ret;
+}
+
 static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 		       bool resume)
 {
@@ -1320,11 +1349,17 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	}
 
 	path = argv[optind];
+	if (strlen(path) > 1 && '/' == path[strlen(path)-1])
+		path[strlen(path)-1] = 0;
 
 	fdmnt = btrfs_open_mnt(path);
 	if (fdmnt < 0)
 		return 1;
 
+	if (path_is_mount_readonly(path) && !readonly){
+		error("The file system is mounted read-only, but the scrub options do not have an r option.");
+		return 1;
+	}
 	ret = get_fs_info(path, &fi_args, &di_args);
 	if (ret) {
 		errno = -ret;
-- 
1.8.3.1


