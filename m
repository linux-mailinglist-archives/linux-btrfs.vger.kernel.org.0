Return-Path: <linux-btrfs+bounces-6177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65B926769
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 19:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900041F248B2
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFCE186E27;
	Wed,  3 Jul 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do8X6XjZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684917F511
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028837; cv=none; b=RYICP/Ia1nexeYBdPBAqlMGa0C2HzPESrcH9xlqmFBCujrcwsNlwftofR0c71zuHt2LJhVPn91DG8DIQhqWvMxQa6FSVS3pJCxsBJaJBNN09+yIttt/9lrlL/DYNiRfmIkkcBwlsrO8LZ2zy4W0yMgm3TGhGyGQWrjX3dkuNrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028837; c=relaxed/simple;
	bh=k0o9L3DWpGBDVP7QACrBbYv0aVYrL1PMNyK0CtV/Q4E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RantNSA/N+WeNWW3EE4ufIniE0/CKIenpG5baxnWM709zQPuLidTf+KQDFYO7z57LtM/RxAitxmPMVoBBAY89U/XCwmLAHex0CUfpDIPVi9B+wkeab8r50fD6a8aHceChlbQ30TS1ZPr6xgD4Cr/QgApQ2kXTRideg+1RwVFvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=do8X6XjZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f4a5344ec7so7423045ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jul 2024 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720028835; x=1720633635; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/NNO4TUrTRWF9We/bFIxpcH/SvOz8WFurHiKLHJfaw=;
        b=do8X6XjZ7z0xJHbJ/rlNIUq2IAtsL0LFikRw0mV0usDDKGUE//ZkTjUQM0MnsFBUc8
         donxpikk4nQvndX51ZmOS0XusI9hIQHq6D4eHqhVZfIehsM8eTep6JBCAvIFAu2rCkCS
         CBMoRdVU30HKjEciovGs7HFMJtXTERQIGjTk+eaygdqkxXq3t9oBnDMTEnIZhmsotdPx
         1i9jZcY7RG5lVjuewcUiWIj1aOBhwVZYXizQs7EtJ+VsidCYbOfkOI5xHvPFFNjnVieh
         3FWrJ12haHstOlVGI5LZvFzCOnsdxQOc57sALZ2zDx6iesIeRVGugSAXjkfEpdwVIeoh
         4rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028835; x=1720633635;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/NNO4TUrTRWF9We/bFIxpcH/SvOz8WFurHiKLHJfaw=;
        b=rltgDugvugOmicvR/c1yn6pe9b/0m06hd3BQiGcQf89QPC4odxmPFyIF/ZVCMbvoJa
         rn1xhlVYy4XtBzsjSqxtNLk+3xpDaIT/+qLMvHjB/BBiMwWOGpa5gRGVdps2ScpGTtyx
         HLXVEUVVBdYbmITI14/WUpIR8ClNsgLfioAhoyMfncgJh6NzNUls/l1xo0nZXxwZWNsQ
         tRNaQZgxXHJJ/x2FF6MqThObxtKlPjd4vN5hmC72eBvRaBT1qomAFjitJjVxHlmfOk77
         Iyj/6ya0BFJxNu+Rl9O4RbL6xDukF+vSedxIg+uHxhOaokarqDLAcI5ybBa7zk6IhmSv
         Zq6A==
X-Gm-Message-State: AOJu0YyywcpQY6+90cjZa408UboDR2w32MD7+NQbov38jBLbGqcWs/sY
	FFj7yrVohamNeXS8TcbrMWXrh49gbjxVqyDyPJmFbjaBjoeKim5s8va+tQ+kNGYX0A==
X-Google-Smtp-Source: AGHT+IGzAHydS4QV21GOE08Dj31GehHnPRIgBDFCviRPLQDphdLWHbOqU4pSuiromMGgOlwhoxtB8w==
X-Received: by 2002:a17:902:d512:b0:1fa:fe30:fc16 with SMTP id d9443c01a7336-1fb1a0a7728mr37138685ad.25.1720028835063;
        Wed, 03 Jul 2024 10:47:15 -0700 (PDT)
Received: from zlke.localdomain ([14.145.8.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb0bd80588sm25947515ad.7.2024.07.03.10.47.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2024 10:47:14 -0700 (PDT)
From: Li Zhang <zhanglikernel@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH] btrfs-prog: scrub: print message when scrubbing a read-only filesystem without r option
Date: Thu,  4 Jul 2024 01:47:01 +0800
Message-Id: <1720028821-3094-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

issue:666

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
$ sudo btrfs scrub start  /mnt/
scrub started on /mnt/, fsid f7c26803-a68d-4a96-91c4-a629b57b7f64 (pid=2892)
Starting scrub on devid 1
Starting scrub on devid 2
Starting scrub on devid 3
scrub on devid 1 failed ret=-1 errno=30 (Read-only file system)
scrub on devid 2 failed ret=-1 errno=30 (Read-only file system)
scrub on devid 3 failed ret=-1 errno=30 (Read-only file system)

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 cmds/scrub.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index d54e11f..e0400dd 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -957,7 +957,10 @@ static void *scrub_one_dev(void *ctx)
 		warning("setting ioprio failed: %m (ignored)");
 
 	ret = ioctl(sp->fd, BTRFS_IOC_SCRUB, &sp->scrub_args);
-        pr_verbose(LOG_DEFAULT, "scrub ioctl devid:%llu ret:%d errno:%d\n",sp->scrub_args.devid, ret, errno);
+	if (ret){
+		pr_verbose(LOG_DEFAULT, "scrub on devid %llu failed ret=%d errno=%d (%m)\n", 
+			sp->scrub_args.devid, ret, errno);
+	}
 	gettimeofday(&tv, NULL);
 	sp->ret = ret;
 	sp->stats.duration = tv.tv_sec - sp->stats.t_start;
@@ -1596,13 +1599,6 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 				++err;
 				break;
 			default:
-				if (do_print) {
-					errno = sp[i].ioctl_errno;
-					error(
-		"scrubbing %s failed for device id %lld: ret=%d, errno=%d (%m)",
-						path, devid, sp[i].ret,
-						sp[i].ioctl_errno);
-				}
 				++err;
 				continue;
 			}
-- 
1.8.3.1


