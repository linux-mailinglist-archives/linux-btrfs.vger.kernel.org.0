Return-Path: <linux-btrfs+bounces-11471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCC8A3638A
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 17:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EB63ADE1B
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D414E268697;
	Fri, 14 Feb 2025 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0UJFtYu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7CB267F79
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551646; cv=none; b=brJCtSf1vUW3VnQC4LUJfF2ymDpPk5Z5HUCrRFS7ECJ3Pj4smjF7wkp3oU4dRThfAEAgf2idTKIzWomLDAGclNZsSdOxQf3pcokr/ONFsACbxqduSBV1BGCUuj/1CVYPc+u8uXgubzz7jGwZgMJCa7c+Ryh2iw/kI5+gTL5glEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551646; c=relaxed/simple;
	bh=Oold34gvns1nFn3gQ6R2J824L4cnY1KoTzw6iWqHZQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COyVgxOTIYBtfkhhOpYNymBKgoVDZ7iYBw0zon15dvM0yqHBdGcIheqlYYvbIKpbj5fg4TaDjQK+swQr9i0zcWTbMFWt4j/IHO2Wizk+pxgM/Crd6/GpHMrFV5ONXHC9pgjG/P1Zq4u+Amv7UbRqFF9fleHJ95x0PCWqjIlYEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0UJFtYu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec61d0f65so503482466b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 08:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551642; x=1740156442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xb22AeKi64gpzMov1KOUTkvSVj27vxiziS77gybHb7Y=;
        b=Y0UJFtYuZIUZ46JG5+/4/G+PXKww121sEJt2iMoaTgsvWzo6W+207QcOjhLS31f+fd
         iz68f3wBaNbw8Qw/LE6xx3QpC9C0/1N2TPplo48z4FG4YNoa2kp9qtN2SMRrCXjplIeF
         k4I+H7jLZYQotUUvyplbiMLT7JvbC8PhQag/FipFm+s8oNksvIjYk57a7CaFVWzYoRgN
         YGmZIA2auoFJYjTlixUEZSUVi8cEbZLFNhh06ryVM5ZBviCLZzrMrHicxUG+QbJwNfHC
         8XTnoqN4gk4EWazzMxhVI2b9lmIh2iJy/lY89Zb2y59enh/avle116qwRXruR1/ofO6W
         9zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551642; x=1740156442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xb22AeKi64gpzMov1KOUTkvSVj27vxiziS77gybHb7Y=;
        b=MHeqR3nVjCC9Dh33s74/pdEoauUxYfQw7WE74Y1GULiyJy1RMO9iZb55Qdkqx1+yJd
         tkSBQfJJ4jhy0T2Uk0RkcmDvacLBq8pQOnk6axs355CIIG7Rltef+MJtDz0OQRAvrNjh
         htbcNi7IzTuNtP4tExDQawMpof4NW4YwyIGY6w1EJDiQZSsmL6RLrTHRxORpMmCpPxrg
         QaTsbeYvccNWxOeN30idHzUYUyw4GLVSIL8qGKL4Ufcxx+q4jXysnKbUPz50p/p+4W0U
         cTUDM5tmsDfoWfqxFpxop44o0BVV44aocjCGV0WltQ42cB2G6FUnhdmuws7L2m2wMCQ1
         Pn+Q==
X-Gm-Message-State: AOJu0YzlBHXeVHQ9kIQSVzGIsQvIvfLhuyvRaAGDx1VBBK9x/OuElCWS
	Oc4CKuJxQCfOYv9Bks3G2AFWuC9RTGshzNDJFJEq77wcUCkiOAKq
X-Gm-Gg: ASbGncuUsYlSOE1mh1MPi6FSC9cE/T97O9LEQM4iedk+9DH5eVO1tK8t9btVj52YtS/
	aRVBkkLRO8ALi7ecBnYhORd3vkUUsz2kOBn7Ez8znIGj4EexXKaHbODtCGh5o72/H1eYqren2/d
	TZixHG8+Ht+EMLWvaJwxw3GiLLkM0VTsAVqGnpyOdT+wwusiwI2YTN5IiprbcHB14Kg+IOIBCWB
	LNoVYoR1E7ux5ZFlDFMfKeC8k87gh/lbIpi5ZjTONasYMdrocyCbY3MwOtFBJtyRn0fD9LjMaL+
	xdNeFPYcKUl2
X-Google-Smtp-Source: AGHT+IGnRmHu0kV9u2EQJRc2WHgfVfVJuad0Px68uHFJ4CPcKxAd7cbdRNMSFrvOWDcza55QJk1NMw==
X-Received: by 2002:a17:906:6a0e:b0:aaf:74d6:6467 with SMTP id a640c23a62f3a-aba5017ed07mr934515966b.42.1739551642088;
        Fri, 14 Feb 2025 08:47:22 -0800 (PST)
Received: from 192.168.1.3 ([82.78.85.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533984f2sm375019266b.131.2025.02.14.08.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:47:21 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH 4/6] btrfs-progs: Added json output format for _print_scrub_ss and print_scrub_dev
Date: Fri, 14 Feb 2025 18:47:07 +0200
Message-ID: <20250214164709.51465-5-racz.zoli@gmail.com>
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
 cmds/scrub.c | 79 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 5c05d00f..1f3f032f 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -403,32 +403,61 @@ static void _print_scrub_ss(struct scrub_stats *ss)
 	struct tm tm;
 	time_t seconds;
 	unsigned hours;
+	char *status;
+
+	const bool json_output = (bconf.output_format == CMD_FORMAT_JSON);
 
 	if (!ss || !ss->t_start) {
-		pr_verbose(LOG_DEFAULT, "\tno stats available\n");
+		if (!json_output)
+			pr_verbose(LOG_DEFAULT, "\tno stats available\n");
+		
 		return;
 	}
+
+	if (json_output)
+		fmt_print_start_group(&fctx, "info", JSON_TYPE_MAP);
+
 	if (ss->t_resumed) {
-		localtime_r(&ss->t_resumed, &tm);
-		strftime(t, sizeof(t), "%c", &tm);
-		t[sizeof(t) - 1] = '\0';
-		pr_verbose(LOG_DEFAULT, "Scrub resumed:    %s\n", t);
+		if (json_output)
+			fmt_print(&fctx, "resumed-at", ss->t_resumed);
+		else {
+			localtime_r(&ss->t_resumed, &tm);
+			strftime(t, sizeof(t), "%c", &tm);
+			t[sizeof(t) - 1] = '\0';
+
+			pr_verbose(LOG_DEFAULT, "Scrub resumed:    %s\n", t);
+		}
 	} else {
-		localtime_r(&ss->t_start, &tm);
-		strftime(t, sizeof(t), "%c", &tm);
-		t[sizeof(t) - 1] = '\0';
-		pr_verbose(LOG_DEFAULT, "Scrub started:    %s\n", t);
-	}
-
-	seconds = ss->duration;
-	hours = ss->duration / (60 * 60);
-	gmtime_r(&seconds, &tm);
-	strftime(t, sizeof(t), "%M:%S", &tm);
-	pr_verbose(LOG_DEFAULT, "Status:           %s\n",
-			(ss->in_progress ? "running" :
+		if (json_output)
+			fmt_print(&fctx, "started-at", ss->t_start);
+		else {
+			localtime_r(&ss->t_start, &tm);
+			strftime(t, sizeof(t), "%c", &tm);
+			t[sizeof(t) - 1] = '\0';
+
+			pr_verbose(LOG_DEFAULT, "Scrub started:    %s\n", t);
+		}
+	}
+
+	status = (ss->in_progress ? "running" :
 			 (ss->canceled ? "aborted" :
-			  (ss->finished ? "finished" : "interrupted"))));
-	pr_verbose(LOG_DEFAULT, "Duration:         %u:%s\n", hours, t);
+			  (ss->finished ? "finished" : "interrupted")));
+	
+
+	if (json_output) {
+		fmt_print(&fctx, "status", status);
+		fmt_print(&fctx, "duration", ss->duration);
+		fmt_print_end_group(&fctx, "info");
+	} else {
+		seconds = ss->duration;
+		hours = ss->duration / (60 * 60);
+		gmtime_r(&seconds, &tm);
+		strftime(t, sizeof(t), "%M:%S", &tm);
+		
+		pr_verbose(LOG_DEFAULT, "Status:           %s\n", status);
+		pr_verbose(LOG_DEFAULT, "Duration:         %u:%s\n", hours, t);
+	}
+
 }
 
 static void print_scrub_dev(struct btrfs_ioctl_dev_info_args *di,
@@ -436,7 +465,14 @@ static void print_scrub_dev(struct btrfs_ioctl_dev_info_args *di,
 				const char *append, struct scrub_stats *ss,
 				u64 limit)
 {
-	pr_verbose(LOG_DEFAULT, "\nScrub device %s (id %llu) %s\n", di->path, di->devid,
+	const bool json_output = (bconf.output_format == CMD_FORMAT_JSON);
+
+	if (json_output) {
+		fmt_print_start_group(&fctx, "device", JSON_TYPE_MAP);
+		fmt_print(&fctx, "dev", di->path);
+		fmt_print(&fctx, "id", di->devid);
+	} else 	
+		pr_verbose(LOG_DEFAULT, "\nScrub device %s (id %llu) %s\n", di->path, di->devid,
 	       append ? append : "");
 
 	_print_scrub_ss(ss);
@@ -461,6 +497,9 @@ static void print_scrub_dev(struct btrfs_ioctl_dev_info_args *di,
 			print_scrub_summary(p, ss, di->bytes_used, limit);
 		}
 	}
+
+	if (json_output) 
+		fmt_print_end_group(&fctx, "device");
 }
 
 /*
-- 
2.48.1


