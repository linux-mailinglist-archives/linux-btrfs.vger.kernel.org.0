Return-Path: <linux-btrfs+bounces-11366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD78A2FAB3
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 21:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CE81693D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 20:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E3426463F;
	Mon, 10 Feb 2025 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0Kr86sR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907EB26462E
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219345; cv=none; b=twlWPSI9vZK3OYJfAy28xh24CJ9A1loUvbGemQiQ4E8FeDeBOEcVqBSoVQbzw0mMKfHAX+HlLX+EtE9YGs+9k2QRiNMFZ3wIuXRWAl+8JluNDrFgfnUPh1T6zRpHp+BSa9n5tkq6yh4It10XhE//YAd//EqlUn7gJdJ5aZf9EEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219345; c=relaxed/simple;
	bh=J4dLaaB3fBOp+JcrNEkDPEFUEixWE8jgJYMYPdDCPZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B32QLPyHOgKQHw5wLlDPHbxHYQu7oyfj9wmnd/joioTcIGeamxb9IIUzSxftCChCWOS2g0Gk0Xhy1utKsBI3ww5UtUuLv0sqUWkHc+pogULUxPKyPvfSUKO/bJ2obeipf/ccnivf3EPGNsY3CygZHhSm1YVcrlF4UzYkXxhtEpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0Kr86sR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso13561065e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 12:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739219342; x=1739824142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrmX9BQQPb9OcmTZP+o9BiiaGylL3IKKZay8xnvoITE=;
        b=E0Kr86sRy3KHOBioC4SGxFGJkcZReAxU5wqbxEE9Qj62+CJFiF+W6Jf4PKVZhQNpTI
         zgTk7uJcRnvifcPBrKdvydnPp2CnPRmAJ0xzkFRhDEGMPHtJjNTnnQdixhnEOsoWEe2d
         s8wjabQ8V+9yevCoWgI3ShY81W8tQOknKOAhOubcyGpk2va6narJGGUovYI0B79O1Dwm
         pWa1u6DcZYif90KpcQaMA2bOP+1MGfDlQTGRtyfj6cmgNsguNHmssxL/9UnY1gJ13IpW
         9vLUf6DVhDLhfdHIfZxSSKe9BOOAO9TyHne+ixH2qu1gUj19Al3ma/PF+G/DUH3QWz6b
         UXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219342; x=1739824142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrmX9BQQPb9OcmTZP+o9BiiaGylL3IKKZay8xnvoITE=;
        b=ZVkw3Fg1saVZqibOzpCkcEFe7uJNZSbMxwbMYg4v/D6NLaog2pmIXxHCovK8DJc1DZ
         87WF7W8s1VSReY4jYq+oG06Y/sGQzmIFz81F6AOXxwHf9NAkK6VH6pX0qb5d72ZWsQxX
         m8+PTZ7GwlUEuoBRl90p67m7o40WhNuqdPFyUuoluoRy2fUVDfL+lKb8iOvuNWN2SVgQ
         mZGBGRDl1auNU1ff47a6THZqRYqd1yJOO6tNUrkYlgwVt24Pzwe6RmQMd7FDdRiw6VrU
         QjpA1D4rurml2m0BP2ESAoRrmMB9RP65FEAWmfbMyRruNVlEqQ8KWrhuq55v928Rq3VJ
         zqFw==
X-Gm-Message-State: AOJu0Yx73T1qZnI0jebrBRwo6J9VhgwaZAEg7byl1KR5mF99Bfjx30/0
	yThptpkyks1MTtaYvd3NX3wRznCNapmxZa8pXpjOxaJRwN19YazGFV0SBZ4+
X-Gm-Gg: ASbGncvHA9zbvVQgxp12xhq3kuAVKirMyVzgI4GDqUaAXedYvUBEG9MzenisWQBRzLJ
	FtK1Mii+fsKJKZJSDl8sdTKqAidTpsl9usK+hb2GZBmBi0nt9v62f4oSg0aEnoROxKMr9bEjhI8
	FtOCZJeElsAOv3VxSUww+le0vshAlzBVBgd6aLuP8msjRK6yG5TmV9WDGeZ5e2xz2l4MWrr1YDE
	IJymzWwYbp3oFTphtcsFsumtKwO090u6rTS/2BbBhxKHoRJCexOg1lcDf8OPGowS/o7L/cbexH7
	x1h92POnNxxPMQ==
X-Google-Smtp-Source: AGHT+IHyF0LR6R/2tpMXPW8nUgQXc7v2ZLZVn4JUQGOH5dx/JvIAGmdCybaQ6esknG4LE3GTcEj1kA==
X-Received: by 2002:a05:600c:3ba4:b0:439:4c7f:e167 with SMTP id 5b1f17b1804b1-4394ceb0ef5mr6447465e9.1.1739219341500;
        Mon, 10 Feb 2025 12:29:01 -0800 (PST)
Received: from 192.168.1.3 ([82.78.241.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf4438sm195079345e9.25.2025.02.10.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:29:00 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH] btrfs-progs: scrub status: add json output format for -d (per device scrub status) option
Date: Mon, 10 Feb 2025 22:28:37 +0200
Message-ID: <20250210202837.45565-1-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch depends on the "[PATCH 0/2] btrfs-progs: scrub status: add json output format" patchset, 
and extends it with json output format for the per device scrub status (-d) option too.

When using the -d option the resulted json will have a slightly
different format containing the "devices" -> "device" keys and the "device" key will further 
contain the "info" and "scrub" subkeys. 

Example usage: 
btrfs --format json scrub status / -d

json output:
{
  "__header": {
    "version": "1"
  },
  "scrub-status": {
    "uuid": "1a7d1bc4-c212-42bf-b05c-73bd313d3ecd",
    "devices": [
      "device": {
        "dev": "/dev/nvme0n1p3",
        "id": 1
      }
    ]
  }
}


---
 cmds/scrub.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 31b965fc..46a5ae77 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -128,6 +128,8 @@ struct format_ctx fctx;
 
 static const struct rowspec scrub_status_rowspec[] = {
 	{ .key = "uuid", .fmt = "%s", .out_json = "uuid"},
+	{ .key = "dev", .fmt = "%s", .out_json = "dev"},
+	{ .key = "id", .fmt = "%llu", .out_json = "id"},
 	{ .key = "status", .fmt = "%s", .out_json = "status"},
 	{ .key = "duration", .fmt = "%u:%s", .out_json = "duration"},
 	{ .key = "started_at", .fmt = "%s", .out_json = "started-at"},
@@ -402,8 +404,10 @@ static void _print_scrub_ss(struct scrub_stats *ss)
 
 	const bool json_output = (bconf.output_format == CMD_FORMAT_JSON);
 
-	if ((!ss || !ss->t_start) && !json_output) {
-		pr_verbose(LOG_DEFAULT, "\tno stats available\n");
+	if (!ss || !ss->t_start) {
+		if (!json_output)
+			pr_verbose(LOG_DEFAULT, "\tno stats available\n");
+		
 		return;
 	}
 
@@ -455,10 +459,19 @@ static void print_scrub_dev(struct btrfs_ioctl_dev_info_args *di,
 				struct btrfs_scrub_progress *p, int raw,
 				const char *append, struct scrub_stats *ss,
 				u64 limit)
-{
-	pr_verbose(LOG_DEFAULT, "\nScrub device %s (id %llu) %s\n", di->path, di->devid,
+{	
+	
+	const bool json_output = (bconf.output_format == CMD_FORMAT_JSON);
+
+	if (json_output) {
+		fmt_print_start_group(&fctx, "device", JSON_TYPE_MAP);
+		fmt_print(&fctx, "dev", di->path);
+		fmt_print(&fctx, "id", di->devid);
+	} else 	
+		pr_verbose(LOG_DEFAULT, "\nScrub device %s (id %llu) %s\n", di->path, di->devid,
 	       append ? append : "");
 
+
 	_print_scrub_ss(ss);
 
 	if (p) {
@@ -481,6 +494,10 @@ static void print_scrub_dev(struct btrfs_ioctl_dev_info_args *di,
 			print_scrub_summary(p, ss, di->bytes_used, limit);
 		}
 	}
+
+	if (json_output) 
+		fmt_print_end_group(&fctx, "device");
+
 }
 
 /*
@@ -2032,6 +2049,9 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
 		pr_verbose(LOG_DEFAULT, "UUID:             %s\n", fsid);
 
 	if (do_stats_per_dev) {
+		if (json_output) 
+			fmt_print_start_group(&fctx, "devices", JSON_TYPE_ARRAY);
+
 		for (i = 0; i < fi_args.num_devices; ++i) {
 			u64 limit;
 
@@ -2049,6 +2069,10 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
 							"history" : "status",
 					&last_scrub->stats, limit);
 		}
+
+		if (json_output) 
+			fmt_print_end_group(&fctx, "devices");
+
 	} else {
 		u64 total_bytes_used = 0;
 		struct btrfs_ioctl_space_info *sp = si_args->spaces;
-- 
2.48.1


