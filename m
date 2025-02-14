Return-Path: <linux-btrfs+bounces-11472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15DA36387
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 17:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C309318924DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D18C26869C;
	Fri, 14 Feb 2025 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCsv+3NJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170BC268690
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551647; cv=none; b=EwBnptoyk9sO1UZOY77anXMgA4drRYBXfm3BVSL3GuLy/7XdKI+sBJC9guKvx9YsrkXoxFoU4IiTx4lclBGPplCxhWlZMU/+o5x+5sisfLfh2dC/5vk4681YA2Gh/QG37DzqSxqnCw9KPNiDpvnBIL0BnsYWOPTIdteUw4kriZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551647; c=relaxed/simple;
	bh=q/KbQOJ3Uy02LtPHjGcUI9wQwAXlVRD3YMvHcHNxuAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sToHg8eSn61FGrxu7tpCPYTS8Pg9dN8pAJ2bLhEsblwCmoWHkqSSMHxTV4su27wQWLsuQunjBydNKKLKbt5e93/I4eWAt77wv+dhQ5HCgLQKonE2LzNytBxKmpT+mH1nf5iwmXNX///a8jGw/5vrCbaPL9sy11dL+lOPZmDU91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCsv+3NJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de56ff9851so4077694a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551644; x=1740156444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmJkHH+2iwVZXTw72Zfb9KM8s62eylV96gHUFlRH2q8=;
        b=cCsv+3NJH/D0uUatD8e3utwK6Km7naSOjM8f2du1TLxU/ruaAQalCZ6Y13Znzxx5Uh
         MrI8PSuOd4rXXYYe//m/YQ9KKiODzzx929U8NjCjGS+b8rJhz39UsVuBl+OEypvYN6hn
         R1nS/GqOcl/25dFkyMvGdC2ajKbpn2B0xotR/lMYLXKwJeosiyA1sB2MTCzjfFwJAq/u
         bhC9K+KEEFAz7euiUocYDaEcfC3rWyTtcvzOJX9VkJAcGSmL2Echn+PlvTOIpLwy12FO
         RqRy8W80p2ANVIECQdBRP2+58kpUqbM6Fcv7yfetdE2r91qGWmaqXI6oEKzEOFhGAbBD
         uOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551644; x=1740156444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmJkHH+2iwVZXTw72Zfb9KM8s62eylV96gHUFlRH2q8=;
        b=JJSlbvdeDgAMVyK8+VtkGlahDo3JNcNvgxF+PlNubimkUoZosF932bNf9A6LPRuDai
         yTDdfk0B3QbHVgPmXVnBH1qEgYakZrlnpKrawoYsolVk2UMDo61VdPvOxLz54/KbpCFZ
         inIlsf/YHENEHEmMKti9J/MK4ozWFRWfnuqMdic7MQI0f98tNHpbAbAzg+3ecmmM/vKb
         OcjbQHHgusoDrEdcDYsv1GLXJTf962sDKH9ildzgETrH/CbjRjzcc9wS4tAynpN9KdRn
         eME8kzqcJ24M9vBn7TcGmGmWP2CNOrMBwk6eA2Jtt4j0PwkAobA1ZhsKKuXzrZhFsFIa
         BC6Q==
X-Gm-Message-State: AOJu0YxIyIg6F33kKW+CZx+U0ShdZtTKyitphc5Q/Ghbe0y0XSD8L6ZU
	co3iVazuIv1YhwWWuvTo3epWarsYdCS2m8xE9gXhmajOdAqvOCqN
X-Gm-Gg: ASbGncu/wDOQMOKaCyyMjBqYkpGvndsczYiRVLiHYhIj7H+kcNFGK7gdJvEnA/uN0LY
	y+lUDt6GYB2sVOUnMTm5y6zJOe1P2XpFsYcLWNTaXhdRkmguGXJMZBwBJeK11vznEgP5EPIBoK/
	cqo6ev2zK6jF8mbh7ibWx9D4y6BoprcEj+4/mUpJXCvcrvPpuDrfRy0V+/3ZzN1gc/gNe0dYzOO
	WGnsLZwLYaoQJAWbEg6sgcWbSbjRn7aWkAdSVPPxn/uJPRnxRKi0H0hSrikcD+EQ8Qld7/jbih8
	OfORlM/EZ3EJ
X-Google-Smtp-Source: AGHT+IFHTz1azqf6FznwgwtW6eLgULiZZtZ0Ztn3IKYnB5DiXqYOJXJErjGcOF7r7v4ihVddUBVOMw==
X-Received: by 2002:a17:907:cf8a:b0:ab7:b5d9:525a with SMTP id a640c23a62f3a-ab7f3874115mr1332540766b.37.1739551644339;
        Fri, 14 Feb 2025 08:47:24 -0800 (PST)
Received: from 192.168.1.3 ([82.78.85.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533984f2sm375019266b.131.2025.02.14.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:47:24 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH 5/6] btrfs-progs: Added json output format for cmd_scrub_status
Date: Fri, 14 Feb 2025 18:47:08 +0200
Message-ID: <20250214164709.51465-6-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214164709.51465-1-racz.zoli@gmail.com>
References: <20250214164709.51465-1-racz.zoli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 cmds/scrub.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 1f3f032f..e47c1869 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -1991,6 +1991,8 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
 	int fdres = -1;
 	int err = 0;
 
+	const bool json_output = (bconf.output_format == CMD_FORMAT_JSON);
+
 	unit_mode = get_unit_mode_from_arg(&argc, argv, 0);
 
 	optind = 0;
@@ -2069,9 +2071,18 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
 	}
 	in_progress = is_scrub_running_in_kernel(fdmnt, di_args, fi_args.num_devices);
 
-	pr_verbose(LOG_DEFAULT, "UUID:             %s\n", fsid);
+
+	if (json_output) {
+		fmt_start(&fctx, scrub_status_rowspec, 1, 0);
+		fmt_print_start_group(&fctx, "scrub-status", JSON_TYPE_MAP);
+		fmt_print(&fctx, "uuid", fsid);
+	} else 
+		pr_verbose(LOG_DEFAULT, "UUID:             %s\n", fsid);
 
 	if (do_stats_per_dev) {
+		if (json_output) 
+			fmt_print_start_group(&fctx, "devices", JSON_TYPE_ARRAY);
+
 		for (i = 0; i < fi_args.num_devices; ++i) {
 			u64 limit;
 
@@ -2089,6 +2100,10 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
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
@@ -2116,10 +2131,16 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
 			/* This is still slightly off for RAID56 */
 			total_bytes_used += sp->used_bytes * factor;
 		}
+
 		print_fs_stat(&fs_stat, print_raw, total_bytes_used,
 			      fi_args.num_devices, limit);
 	}
 
+	if (json_output) {
+		fmt_print_end_group(&fctx, "scrub-status");
+		fmt_end(&fctx);
+	}
+
 out:
 	free_history(past_scrubs);
 	free(di_args);
@@ -2130,7 +2151,7 @@ out:
 
 	return !!err;
 }
-static DEFINE_SIMPLE_COMMAND(scrub_status, "status");
+static DEFINE_COMMAND_WITH_FLAGS(scrub_status, "status", CMD_FORMAT_JSON);
 
 static const char * const cmd_scrub_limit_usage[] = {
 	"btrfs scrub limit [options] <path>",
-- 
2.48.1


