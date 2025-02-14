Return-Path: <linux-btrfs+bounces-11470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB0A36385
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 17:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1ADF1885C10
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3FE268680;
	Fri, 14 Feb 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baRJNXzO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3252267F5B
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551643; cv=none; b=HxiXLuHYb0N8/m1/1rn34quRVf26QEI3KGSCHWd78CRUL9KarqlV7dsSqlWWVuHz/Herdrq2oKACik6HKqpMjo2NptehG1ottvBPAn424pl/w35vto9Gm94M8IT6hMYXuhi5s8yKaGDuY9cGI9V/pubemgPaBFAZ30q8BGWjHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551643; c=relaxed/simple;
	bh=4wras9OqY/xkz1wV2Y9XnUZDl5+9jBCS+AUvcxPZUUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjtwExEnWf8xBjuwOWfNNRNfun+J84c/eyuCAoSwwuuUSlj53OjJ/hv1pFbkaKM4i/ekkoYK3BQZT3lqfI0jWmCkRSgdvV6JHSawkUjbfrz19V81Wxqu+iekWvMwvYxQaeppBQ+YPPuAvum4Z2C/g0aUlzo7MTNIex4YEO2wMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baRJNXzO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso387292666b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 08:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551640; x=1740156440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsK0Dwdh2kF8DOHiWeKNGU5ehJKPYQkFWJQ4lukkYdg=;
        b=baRJNXzOGrRd5S0eU7hibXE6TPLOxjSfTuXxQscFKFRzg6si3Y58ju1fMYTP9T7Y1/
         gWno0j/BlLBVcHeuGL0aLSbfDZ3bVMHPThuyeHKyNX4RB7Xy9oF/UtmI2CYmevDhnIjo
         MTq67bwgqqZxsq5pgI/eAeWGH3FyN/zvHcGLjDaYLAY4u/pUAF6Gsq1YWOd68uVt3NQs
         ng0PIuLlFAnyIHYZVh5VauIEQLBeOfzR9w3FW2SnRKWFw3fbxbvHDlu/ydJ4SnHLrhrl
         hMyPkuSmRF62WnbDwXZMmQs4va+R2RbvtEVDxXNGrryb1OuPwpAtm3U5alXeXZEK08Gy
         tuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551640; x=1740156440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsK0Dwdh2kF8DOHiWeKNGU5ehJKPYQkFWJQ4lukkYdg=;
        b=OX7CrvYIwdF9fC+vb5omBOX0LsfAX1LJELWklPbbiOS2crXzMIzZQuN+BmNJv7cbpH
         Y1LFFxg++hLclcaDebPhTW1gk5msfkPYPO8FJBe512cGPu1x+24ApeFnWBziPxIUfwhs
         +w2zTWmLTWya32CzBC5hqnC5zp1c7nCKfKB7aP9i57stmeF1jlApRjVjpryMssfOOMx1
         VPuF8R24KZ5aGKArqIz5nx2G4pX9k+8oBMhMERyNKy69p2gd1g35F0YVAejNTlDv/hNB
         14y/tsyKOcdkBZDqlFm5ANWxoVcHSBoSYl58JWuQEhW+zBbSeV3/dKbvUIO2J/fAJKtv
         +6tw==
X-Gm-Message-State: AOJu0YykzScbMa1SfYXmVZuHr41yNOL1KEKN3136zDqXVdpM8wq82hfx
	28zel1Np3uoMoXRg7tAQDlE7R/dsP1MsBtzcZM7PMBLhbUWlHdm3bknQjQ==
X-Gm-Gg: ASbGncvXcHhxP0F8BY2ZrrCKViU+ZADrjO6QQeczONx3PdbGIj50zlDgiky99sYlo1v
	Em4oc1X62d22hpyyXnQ3PgXqFESLZVVXobz0sOiSA83hHzzp8VthMpREByOOgwX81zLxzfHuoIR
	YL00hKvDN1BrgKfwQ+49rHY/Q3A8LqUvDCAXQR1FAqBrHp5zZPsmN7Vnk4syJX1bnA9a3oMA+zy
	Zy39ma8cKSIiXZ2qVtv/FEwsnyfQ4J5bbBDNqZ4Qy1aeH9PoNH54nROAjHr2g3jRp63ZqZslQuk
	qkV+y6Z+QNMy
X-Google-Smtp-Source: AGHT+IExyYMl0M1WeDkNyoGkg3pLNCfhmddd72uQnm0wdSpNJZUiEWVNd4qpIf5W9sAWSGNT9wYs2w==
X-Received: by 2002:a17:906:c055:b0:aba:cc21:8b3c with SMTP id a640c23a62f3a-abacc218c05mr167007066b.38.1739551639757;
        Fri, 14 Feb 2025 08:47:19 -0800 (PST)
Received: from 192.168.1.3 ([82.78.85.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533984f2sm375019266b.131.2025.02.14.08.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:47:19 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH 3/6] btrfs-progs: Added json output format for print_scrub_summary
Date: Fri, 14 Feb 2025 18:47:06 +0200
Message-ID: <20250214164709.51465-4-racz.zoli@gmail.com>
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
 cmds/scrub.c | 110 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 76 insertions(+), 34 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index caada704..5c05d00f 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -216,6 +216,8 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p, struct scrub_sta
 	u64 sec_left = 0;
 	time_t sec_eta;
 
+	const bool json_output = (bconf.output_format == CMD_FORMAT_JSON);
+
 	bytes_scrubbed = p->data_bytes_scrubbed + p->tree_bytes_scrubbed;
 	/*
 	 * If duration is zero seconds (rounded down), then the Rate metric
@@ -236,8 +238,12 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p, struct scrub_sta
 
 	err_cnt2 = p->corrected_errors + p->uncorrectable_errors;
 
+	if (json_output) 
+		fmt_print_start_group(&fctx, "scrub", JSON_TYPE_MAP);
+
 	if (p->malloc_errors)
-		pr_verbose(LOG_DEFAULT, "*** WARNING: memory allocation failed while scrubbing. "
+		if (!json_output)
+			pr_verbose(LOG_DEFAULT, "*** WARNING: memory allocation failed while scrubbing. "
 		       "results may be inaccurate\n");
 
 	if (s->in_progress) {
@@ -246,21 +252,33 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p, struct scrub_sta
 
 		sec_eta = time(NULL);
 		sec_eta += sec_left;
-		localtime_r(&sec_eta, &tm);
-		t[sizeof(t) - 1] = '\0';
-		strftime(t, sizeof(t), "%c", &tm);
 
-		pr_verbose(LOG_DEFAULT, "Time left:        %llu:%02llu:%02llu\n",
-			sec_left / 3600, (sec_left / 60) % 60, sec_left % 60);
-		pr_verbose(LOG_DEFAULT, "ETA:              %s\n", t);
-		pr_verbose(LOG_DEFAULT, "Total to scrub:   %s\n",
-			pretty_size_mode(bytes_total, unit_mode));
-		pr_verbose(LOG_DEFAULT, "Bytes scrubbed:   %s  (%.2f%%)\n",
-			pretty_size_mode(bytes_scrubbed, unit_mode),
-			100.0 * bytes_scrubbed / bytes_total);
+		if (json_output) {
+			fmt_print(&fctx, "time-left", sec_left);
+			fmt_print(&fctx, "eta", sec_eta);
+			fmt_print(&fctx, "total-bytes-to-scrub", bytes_total);
+			fmt_print(&fctx, "bytes-scrubbed", bytes_scrubbed);
+		}
+		else {
+			localtime_r(&sec_eta, &tm);
+			t[sizeof(t) - 1] = '\0';
+			strftime(t, sizeof(t), "%c", &tm);
+
+			pr_verbose(LOG_DEFAULT, "Time left:        %llu:%02llu:%02llu\n",
+				sec_left / 3600, (sec_left / 60) % 60, sec_left % 60);
+			pr_verbose(LOG_DEFAULT, "ETA:              %s\n", t);
+			pr_verbose(LOG_DEFAULT, "Total to scrub:   %s\n",
+				pretty_size_mode(bytes_total, unit_mode));
+			pr_verbose(LOG_DEFAULT, "Bytes scrubbed:   %s  (%.2f%%)\n",
+				pretty_size_mode(bytes_scrubbed, unit_mode),
+				100.0 * bytes_scrubbed / bytes_total);
+		}
 	} else {
-		pr_verbose(LOG_DEFAULT, "Total to scrub:   %s\n",
-			pretty_size_mode(bytes_total, unit_mode));
+		if (json_output) 
+			fmt_print(&fctx, "total-bytes-to-scrub", bytes_total);
+		else
+			pr_verbose(LOG_DEFAULT, "Total to scrub:   %s\n",
+				pretty_size_mode(bytes_total, unit_mode));
 	}
 
 	/*
@@ -271,28 +289,52 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p, struct scrub_sta
 	if (unit_mode != UNITS_RAW) 
 		mode = unit_mode & UNITS_BINARY ? UNITS_HUMAN_BINARY : UNITS_HUMAN_DECIMAL;
 
-	pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
-		pretty_size_mode(bytes_per_sec, mode));
-	if (limit > 1)
-		pr_verbose(LOG_DEFAULT, " (limit %s/s)",
-				pretty_size_mode(limit, mode));
-	else if (limit == 1)
-		pr_verbose(LOG_DEFAULT, " (some device limits set)");
-	pr_verbose(LOG_DEFAULT, "\n");
-
-	pr_verbose(LOG_DEFAULT, "Error summary:   ");
-	if (err_cnt || err_cnt2) {
-		PRINT_SCRUB_ERROR(p->read_errors, "read");
-		PRINT_SCRUB_ERROR(p->super_errors, "super");
-		PRINT_SCRUB_ERROR(p->verify_errors, "verify");
-		PRINT_SCRUB_ERROR(p->csum_errors, "csum");
-		pr_verbose(LOG_DEFAULT, "\n");
-		pr_verbose(LOG_DEFAULT, "  Corrected:      %llu\n", p->corrected_errors);
-		pr_verbose(LOG_DEFAULT, "  Uncorrectable:  %llu\n", p->uncorrectable_errors);
-		pr_verbose(LOG_DEFAULT, "  Unverified:     %llu\n", p->unverified_errors);
+	if (json_output) {
+		fmt_print(&fctx, "rate", bytes_per_sec);
+		if (limit > 1)
+			fmt_print(&fctx, "limit", limit);
 	} else {
-		pr_verbose(LOG_DEFAULT, " no errors found\n");
+		pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
+			pretty_size_mode(bytes_per_sec, mode));
+		if (limit > 1)
+			pr_verbose(LOG_DEFAULT, " (limit %s/s)",
+					pretty_size_mode(limit, mode));
+		else if (limit == 1)
+			pr_verbose(LOG_DEFAULT, " (some device limits set)");
+		pr_verbose(LOG_DEFAULT, "\n");
 	}
+
+	if (json_output) {
+		if (err_cnt || err_cnt2) {
+			fmt_print_start_group(&fctx, "error-summary", JSON_TYPE_MAP);
+			fmt_print(&fctx, "read-errors", p->read_errors);
+			fmt_print(&fctx, "super-errors", p->super_errors);
+			fmt_print(&fctx, "verify-errors", p->verify_errors);
+			fmt_print(&fctx, "csum-errors", p->csum_errors);
+			fmt_print(&fctx, "corrected-errors", p->corrected_errors);
+			fmt_print(&fctx, "uncorrectable-errors", p->uncorrectable_errors);
+			fmt_print(&fctx, "unverified-errors", p->unverified_errors);
+			fmt_print_end_group(&fctx, "error-summary");
+		}
+	}
+	else {
+		pr_verbose(LOG_DEFAULT, "Error summary:   ");
+		if (err_cnt || err_cnt2) {
+			PRINT_SCRUB_ERROR(p->read_errors, "read");
+			PRINT_SCRUB_ERROR(p->super_errors, "super");
+			PRINT_SCRUB_ERROR(p->verify_errors, "verify");
+			PRINT_SCRUB_ERROR(p->csum_errors, "csum");
+			pr_verbose(LOG_DEFAULT, "\n");
+			pr_verbose(LOG_DEFAULT, "  Corrected:      %llu\n", p->corrected_errors);
+			pr_verbose(LOG_DEFAULT, "  Uncorrectable:  %llu\n", p->uncorrectable_errors);
+			pr_verbose(LOG_DEFAULT, "  Unverified:     %llu\n", p->unverified_errors);
+		} else {
+			pr_verbose(LOG_DEFAULT, " no errors found\n");
+		}
+	}
+
+	if (json_output)
+		fmt_print_end_group(&fctx, "scrub");
 }
 
 #define _SCRUB_FS_STAT(p, name, fs_stat) do {	\
-- 
2.48.1


