Return-Path: <linux-btrfs+bounces-11333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F092A2B91D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 03:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE5D188020F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 02:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E831552E3;
	Fri,  7 Feb 2025 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPhYJb5r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E37E0FF
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 02:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738895607; cv=none; b=dbDQP7dmokCKEblGcECjJFnec5uZ/HHjUCzfU9EwC/9mDESW7tkoWJiGVbjG9RYUz+rN3czbqsYVmAUKwFpTE4Nhi+r5GK+6KHxcmz2nG/mbFjvFeR2FFI8qOMvpCfflgMZAi8zJm9kA7u1z5xz8RLg9h+i7r18yFOvETW5umJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738895607; c=relaxed/simple;
	bh=v/3R9Oiuw3S+c7WE28C3m14X8xsa64o6m2HeYoGoFvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsQtTC6b1SWYNxlyPaQMGpAgBD9OHu5WCzhS3xOGO83zISRRzCXRtoOL9GcsVcVtkBxYqvMMxjwoyN4Yps5+6Xbv/RzEZ78JJwdWEhMKx3u7a5LpaN1D0h4O3SDvR2YFY/pgDLDHRTCJ2NXE6wSua/DBTqcyj/Si78TXzfFQ+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPhYJb5r; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dcedee4f84so2909338a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2025 18:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738895604; x=1739500404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tUCvuvBJhuT/xFPdHl5dBZu9WPZjgXYzjQquiW8LRk=;
        b=bPhYJb5rV/Wopq9eRfGBxNRQsM9NneJrq0bDurhM37fc66El2RPeD6xtgPlb2nn0WA
         FDDQo6UupwAjBiJD6BVR8D+cf9wzfD5JvAtdvLppJ1+v/2D3NeFOYboflxBk4DMKbdOt
         CuRau1r6emCIPh/BPOILCfc8pD5kC3sv6XZoDBH/idTUYMsAlX+ptzwoVMDbvEy0AlsA
         x1t06oPvMjW3zL6do5msCRUnjfU+4tHmbHGbujCci5ZfCv0yXFg7slLeiseTkeH7aLmm
         Eui1aLrPol5VIiy/ISzbFpWpOhvub3n/W3cAVpvNsuDo8y5W+enHZiJaH2r3UnpVUhIv
         25Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738895604; x=1739500404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tUCvuvBJhuT/xFPdHl5dBZu9WPZjgXYzjQquiW8LRk=;
        b=iqdzGhZj5KxIcUQecCDVG5FRdoAg2FEkgxLnL7MoDpq2Ek6w99N7Ar37Qx6MabGDw4
         PJZmHezWtweVLAfdTgN4cmRDq5fZN3TlVx7db86Mdf7cTKxHo2D4pqAtxhKD261mB4iQ
         YC30PnW+7ZCkV4ddDN5kBzTNL/PbUM8FnFx8eoISR7usvohIv3jXnU+TMmuUqEQ6y9z1
         +HWltDUG18YfB3O00ddPb3003tc4Y194/s6ZgEIqwB8F0mthqdFIppctwvoDU5D5djEg
         kN+BE/c2sr88VqU3eVsz0lcC2dDPhQY9x/0w8IBkqD38Ga48+kvxJid808AcEO2DbSLW
         er7A==
X-Gm-Message-State: AOJu0Yw4yXKiB6QfeNKe4zjp7ayz61k/BOoXFVnRavx5QcFLjoBuWkcx
	Q3MWPfTWPouHjjPysS/1yAU8/RCcoZb9LOGrb3ve4l33L+5zIimB
X-Gm-Gg: ASbGncvyoUFIEE1k+o5XvuL7IYzVB5SqBnvYPwiZ/ZOpp2unh77Xynpp8bYzp+iw3Es
	xCr5I2LQcpkET3bzVqDk5FhiQNXe2eEQDbvxVJrBRXB7DwXC5eb61nbwVwFC/7o+v3EAGpW5Iv5
	LyC2MYltPUWVYqm2SfhZqOQIgEK2B8WpecR1YaMaJdvPAvHdXQG++Tm3RXQJR1Lhk6xtHbwEJr8
	Pydp9wwtWgvVEoNCGs6xMd1sjF3WLJ4vwICvxX10lgbzNb/wl6dcan55zHdy41f3AB8SFSqg3Eq
	mIsCS8h+ozdjRA==
X-Google-Smtp-Source: AGHT+IH4gZyrAUr7oKh8QKoxP9quFXLkpZLfUxrNJ5IaFh/7JqEoOTadirHNxD3cvq4c+n9ssO79Gw==
X-Received: by 2002:a05:6402:210c:b0:5dc:80ba:ddb1 with SMTP id 4fb4d7f45d1cf-5de46a30389mr1149305a12.14.1738895603348;
        Thu, 06 Feb 2025 18:33:23 -0800 (PST)
Received: from 192.168.1.3 ([82.78.241.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de379cedc6sm1086752a12.44.2025.02.06.18.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 18:33:22 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH 2/2] scrub status: add json output format
Date: Fri,  7 Feb 2025 04:33:02 +0200
Message-ID: <20250207023302.311829-3-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207023302.311829-1-racz.zoli@gmail.com>
References: <20250207023302.311829-1-racz.zoli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for json formatting of the "scrub status"
command. Please not that in the info section the started-at key in
02:00:00 1970 because i bypassed the "no stats available" so I can make
sure those stats are correctly formatted in the output as well. 

Example usage:
1. btrfs --format json scrub status /

json output:
{
  "__header": {
    "version": "1"
  },
  "scrub-status": {
    "uuid": "1a7d1bc4-c212-42bf-b05c-73bd313d3ecd",
    "info": {
      "started-at": "Thu Jan  1 02:00:00 1970",
      "status": "finished",
      "duration": "0:00:00"
    },
    "scrub": {
      "total-bytes-to-scrub": "67184017408",
      "rate": "0"
    }
  }
}

2. btrfs --format json scrub status / -R

json output: 
{
  "__header": {
    "version": "1"
  },
  "scrub-status": {
    "uuid": "1a7d1bc4-c212-42bf-b05c-73bd313d3ecd",
    "info": {
      "started-at": "Thu Jan  1 02:00:00 1970",
      "status": "finished",
      "duration": "0:00:00"
    },
    "scrub": {
      "data-extents-scrubbed": "0",
      "tree-extents-scrubbed": "0",
      "data-bytes-scrubbed": "0",
      "tree-bytes-scrubbed": "0",
      "read-errors": "0",
      "csum-errors": "0",
      "verify-errors": "0",
      "no-csum": "0",
      "csum-discards": "0",
      "super-errors": "0",
      "malloc-errors": "0",
      "uncorrectable-errors": "0",
      "unverified-errors": "0",
      "corrected-errors": "0",
      "last-physical": "0"
    }
  }
}

 cmds/scrub.c | 251 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 195 insertions(+), 56 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 3507c9d8..31b965fc 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -53,6 +53,7 @@
 #include "common/sysfs-utils.h"
 #include "common/string-table.h"
 #include "common/string-utils.h"
+#include "common/format-output.h"
 #include "common/help.h"
 #include "cmds/commands.h"
 
@@ -123,23 +124,78 @@ struct scrub_fs_stat {
 	int i;
 };
 
+struct format_ctx fctx;
+
+static const struct rowspec scrub_status_rowspec[] = {
+	{ .key = "uuid", .fmt = "%s", .out_json = "uuid"},
+	{ .key = "status", .fmt = "%s", .out_json = "status"},
+	{ .key = "duration", .fmt = "%u:%s", .out_json = "duration"},
+	{ .key = "started_at", .fmt = "%s", .out_json = "started-at"},
+	{ .key = "resumed_at", .fmt = "%s", .out_json = "resumed-at"},
+	{ .key = "data_extents_scrubbed", .fmt = "%lld", .out_json = "data-extents-scrubbed"},
+	{ .key = "tree_extents_scrubbed", .fmt = "%lld", .out_json = "tree-extents-scrubbed"},
+	{ .key = "data_bytes_scrubbed", .fmt = "%lld", .out_json = "data-bytes-scrubbed"},
+	{ .key = "tree_bytes_scrubbed", .fmt = "%lld", .out_json = "tree-bytes-scrubbed"},
+	{ .key = "read_errors", .fmt = "%lld", .out_json = "read-errors"},
+	{ .key = "csum_errors", .fmt = "%lld", .out_json = "csum-errors"},
+	{ .key = "verify_errors", .fmt = "%lld", .out_json = "verify-errors"},
+	{ .key = "no_csum", .fmt = "%lld", .out_json = "no-csum"},
+	{ .key = "csum_discards", .fmt = "%lld", .out_json = "csum-discards"},
+	{ .key = "super_errors", .fmt = "%lld", .out_json = "super-errors"},
+	{ .key = "malloc_errors", .fmt = "%lld", .out_json = "malloc-errors"},
+	{ .key = "uncorrectable_errors", .fmt = "%lld", .out_json = "uncorrectable-errors"},
+	{ .key = "unverified_errors", .fmt = "%lld", .out_json = "unverified-errors"},
+	{ .key = "corrected_errors", .fmt = "%lld", .out_json = "corrected-errors"},
+	{ .key = "last_physical", .fmt = "%lld", .out_json = "last-physical"},
+	{ .key = "time_left", .fmt = "%llu:%02llu:%02llu", .out_json = "time-left"},
+	{ .key = "eta", .fmt = "%s", .out_json = "eta"},
+	{ .key = "total_bytes_to_scrub", .fmt = "%lld", .out_json = "total-bytes-to-scrub"},
+	{ .key = "bytes_scrubbed", .fmt = "%lld", .out_json = "bytes-scrubbed"},
+	{ .key = "rate", .fmt = "%lld", .out_json = "rate"},
+	{ .key = "limit", .fmt = "%lld", .out_json = "limit"},
+
+	ROWSPEC_END
+};
+
 static void print_scrub_full(struct btrfs_scrub_progress *sp)
 {
-	pr_verbose(LOG_DEFAULT, "\tdata_extents_scrubbed: %lld\n", sp->data_extents_scrubbed);
-	pr_verbose(LOG_DEFAULT, "\ttree_extents_scrubbed: %lld\n", sp->tree_extents_scrubbed);
-	pr_verbose(LOG_DEFAULT, "\tdata_bytes_scrubbed: %lld\n", sp->data_bytes_scrubbed);
-	pr_verbose(LOG_DEFAULT, "\ttree_bytes_scrubbed: %lld\n", sp->tree_bytes_scrubbed);
-	pr_verbose(LOG_DEFAULT, "\tread_errors: %lld\n", sp->read_errors);
-	pr_verbose(LOG_DEFAULT, "\tcsum_errors: %lld\n", sp->csum_errors);
-	pr_verbose(LOG_DEFAULT, "\tverify_errors: %lld\n", sp->verify_errors);
-	pr_verbose(LOG_DEFAULT, "\tno_csum: %lld\n", sp->no_csum);
-	pr_verbose(LOG_DEFAULT, "\tcsum_discards: %lld\n", sp->csum_discards);
-	pr_verbose(LOG_DEFAULT, "\tsuper_errors: %lld\n", sp->super_errors);
-	pr_verbose(LOG_DEFAULT, "\tmalloc_errors: %lld\n", sp->malloc_errors);
-	pr_verbose(LOG_DEFAULT, "\tuncorrectable_errors: %lld\n", sp->uncorrectable_errors);
-	pr_verbose(LOG_DEFAULT, "\tunverified_errors: %lld\n", sp->unverified_errors);
-	pr_verbose(LOG_DEFAULT, "\tcorrected_errors: %lld\n", sp->corrected_errors);
-	pr_verbose(LOG_DEFAULT, "\tlast_physical: %lld\n", sp->last_physical);
+	if (bconf.output_format == CMD_FORMAT_JSON) {
+		fmt_print_start_group(&fctx, "scrub", JSON_TYPE_MAP);
+
+		fmt_print(&fctx, "data_extents_scrubbed", sp->data_extents_scrubbed);
+		fmt_print(&fctx, "tree_extents_scrubbed", sp->tree_extents_scrubbed);
+		fmt_print(&fctx, "data_bytes_scrubbed", sp->data_bytes_scrubbed);
+		fmt_print(&fctx, "tree_bytes_scrubbed", sp->tree_bytes_scrubbed);
+		fmt_print(&fctx, "read_errors", sp->read_errors);
+		fmt_print(&fctx, "csum_errors", sp->csum_errors);
+		fmt_print(&fctx, "verify_errors", sp->verify_errors);
+		fmt_print(&fctx, "no_csum", sp->no_csum);
+		fmt_print(&fctx, "csum_discards", sp->csum_discards);
+		fmt_print(&fctx, "super_errors", sp->super_errors);
+		fmt_print(&fctx, "malloc_errors", sp->malloc_errors);
+		fmt_print(&fctx, "uncorrectable_errors", sp->uncorrectable_errors);
+		fmt_print(&fctx, "unverified_errors", sp->unverified_errors);
+		fmt_print(&fctx, "corrected_errors", sp->corrected_errors);
+		fmt_print(&fctx, "last_physical", sp->last_physical);
+
+		fmt_print_end_group(&fctx, "scrub");
+	} else {
+		pr_verbose(LOG_DEFAULT, "\tdata_extents_scrubbed: %lld\n", sp->data_extents_scrubbed);
+		pr_verbose(LOG_DEFAULT, "\ttree_extents_scrubbed: %lld\n", sp->tree_extents_scrubbed);
+		pr_verbose(LOG_DEFAULT, "\tdata_bytes_scrubbed: %lld\n", sp->data_bytes_scrubbed);
+		pr_verbose(LOG_DEFAULT, "\ttree_bytes_scrubbed: %lld\n", sp->tree_bytes_scrubbed);
+		pr_verbose(LOG_DEFAULT, "\tread_errors: %lld\n", sp->read_errors);
+		pr_verbose(LOG_DEFAULT, "\tcsum_errors: %lld\n", sp->csum_errors);
+		pr_verbose(LOG_DEFAULT, "\tverify_errors: %lld\n", sp->verify_errors);
+		pr_verbose(LOG_DEFAULT, "\tno_csum: %lld\n", sp->no_csum);
+		pr_verbose(LOG_DEFAULT, "\tcsum_discards: %lld\n", sp->csum_discards);
+		pr_verbose(LOG_DEFAULT, "\tsuper_errors: %lld\n", sp->super_errors);
+		pr_verbose(LOG_DEFAULT, "\tmalloc_errors: %lld\n", sp->malloc_errors);
+		pr_verbose(LOG_DEFAULT, "\tuncorrectable_errors: %lld\n", sp->uncorrectable_errors);
+		pr_verbose(LOG_DEFAULT, "\tunverified_errors: %lld\n", sp->unverified_errors);
+		pr_verbose(LOG_DEFAULT, "\tcorrected_errors: %lld\n", sp->corrected_errors);
+		pr_verbose(LOG_DEFAULT, "\tlast_physical: %lld\n", sp->last_physical);
+	}
 }
 
 #define PRINT_SCRUB_ERROR(test, desc) do {	\
@@ -157,6 +213,8 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p, struct scrub_sta
 	u64 sec_left = 0;
 	time_t sec_eta;
 
+	const bool json = (bconf.output_format == CMD_FORMAT_JSON);
+
 	bytes_scrubbed = p->data_bytes_scrubbed + p->tree_bytes_scrubbed;
 	/*
 	 * If duration is zero seconds (rounded down), then the Rate metric
@@ -177,8 +235,13 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p, struct scrub_sta
 
 	err_cnt2 = p->corrected_errors + p->uncorrectable_errors;
 
+	if (json) {
+		fmt_print_start_group(&fctx, "scrub", JSON_TYPE_MAP);
+	}
+
 	if (p->malloc_errors)
-		pr_verbose(LOG_DEFAULT, "*** WARNING: memory allocation failed while scrubbing. "
+		if (!json) 
+			pr_verbose(LOG_DEFAULT, "*** WARNING: memory allocation failed while scrubbing. "
 		       "results may be inaccurate\n");
 
 	if (s->in_progress) {
@@ -191,44 +254,81 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p, struct scrub_sta
 		t[sizeof(t) - 1] = '\0';
 		strftime(t, sizeof(t), "%c", &tm);
 
-		pr_verbose(LOG_DEFAULT, "Time left:        %llu:%02llu:%02llu\n",
-			sec_left / 3600, (sec_left / 60) % 60, sec_left % 60);
-		pr_verbose(LOG_DEFAULT, "ETA:              %s\n", t);
-		pr_verbose(LOG_DEFAULT, "Total to scrub:   %s\n",
-			pretty_size_mode(bytes_total, unit_mode));
-		pr_verbose(LOG_DEFAULT, "Bytes scrubbed:   %s  (%.2f%%)\n",
-			pretty_size_mode(bytes_scrubbed, unit_mode),
-			100.0 * bytes_scrubbed / bytes_total);
+		if (json) {
+			fmt_print(&fctx, "time_left", sec_left / 3600, (sec_left / 60) % 60, sec_left % 60);
+			fmt_print(&fctx, "eta", t);
+			fmt_print(&fctx, "total_bytes_to_scrub", bytes_total);
+			fmt_print(&fctx, "bytes_scrubbed", bytes_scrubbed);
+		}
+		else
+		{
+			pr_verbose(LOG_DEFAULT, "Time left:        %llu:%02llu:%02llu\n",
+				sec_left / 3600, (sec_left / 60) % 60, sec_left % 60);
+			pr_verbose(LOG_DEFAULT, "ETA:              %s\n", t);
+			pr_verbose(LOG_DEFAULT, "Total to scrub:   %s\n",
+				pretty_size_mode(bytes_total, unit_mode));
+			pr_verbose(LOG_DEFAULT, "Bytes scrubbed:   %s  (%.2f%%)\n",
+				pretty_size_mode(bytes_scrubbed, unit_mode),
+				100.0 * bytes_scrubbed / bytes_total);
+
+		}
 	} else {
-		pr_verbose(LOG_DEFAULT, "Total to scrub:   %s\n",
-			pretty_size_mode(bytes_total, unit_mode));
+		if (json) 
+			fmt_print(&fctx, "total_bytes_to_scrub", bytes_total);
+		else
+			pr_verbose(LOG_DEFAULT, "Total to scrub:   %s\n",
+				pretty_size_mode(bytes_total, unit_mode));
 	}
 	/*
 	 * Rate and size units are disproportionate so they are affected only
 	 * by --raw, otherwise it's human readable
 	 */
-	
-	pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
-		pretty_size_mode(bytes_per_sec, unit_mode));
-	if (limit > 1)
-		pr_verbose(LOG_DEFAULT, " (limit %s/s)",
-			pretty_size_mode(limit, unit_mode));
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
+	if (json) {
+		fmt_print(&fctx, "rate", bytes_per_sec);
+		if (limit > 1)
+			fmt_print(&fctx, "limit", limit);
 	} else {
-		pr_verbose(LOG_DEFAULT, " no errors found\n");
+		pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
+			pretty_size_mode(bytes_per_sec, unit_mode));
+		if (limit > 1)
+			pr_verbose(LOG_DEFAULT, " (limit %s/s)",
+				pretty_size_mode(limit, unit_mode));
+		else if (limit == 1)
+			pr_verbose(LOG_DEFAULT, " (some device limits set)");
+		pr_verbose(LOG_DEFAULT, "\n");
+	}
+
+	if (json) {
+		if (err_cnt || err_cnt2) {
+			fmt_print_start_group(&fctx, "error-summary", JSON_TYPE_MAP);
+			fmt_print(&fctx, "read_errors", p->read_errors);
+			fmt_print(&fctx, "super_errors", p->super_errors);
+			fmt_print(&fctx, "verify_errors", p->verify_errors);
+			fmt_print(&fctx, "csum_errors", p->csum_errors);
+			fmt_print(&fctx, "corrected_errors", p->corrected_errors);
+			fmt_print(&fctx, "uncorrectable_errors", p->uncorrectable_errors);
+			fmt_print(&fctx, "unverified_errors", p->unverified_errors);
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
+	if (json) {
+		fmt_print_end_group(&fctx, "scrub");
 	}
 }
 
@@ -298,32 +398,57 @@ static void _print_scrub_ss(struct scrub_stats *ss)
 	struct tm tm;
 	time_t seconds;
 	unsigned hours;
+	char *status;
 
-	if (!ss || !ss->t_start) {
+	const bool json_output = (bconf.output_format == CMD_FORMAT_JSON);
+
+	if ((!ss || !ss->t_start) && !json_output) {
 		pr_verbose(LOG_DEFAULT, "\tno stats available\n");
 		return;
 	}
+
+	if (json_output)
+		fmt_print_start_group(&fctx, "info", JSON_TYPE_MAP);
+
 	if (ss->t_resumed) {
 		localtime_r(&ss->t_resumed, &tm);
 		strftime(t, sizeof(t), "%c", &tm);
 		t[sizeof(t) - 1] = '\0';
-		pr_verbose(LOG_DEFAULT, "Scrub resumed:    %s\n", t);
+
+		if (json_output)
+			fmt_print(&fctx, "resumed_at", t);
+		else 
+			pr_verbose(LOG_DEFAULT, "Scrub resumed:    %s\n", t);
 	} else {
 		localtime_r(&ss->t_start, &tm);
 		strftime(t, sizeof(t), "%c", &tm);
 		t[sizeof(t) - 1] = '\0';
-		pr_verbose(LOG_DEFAULT, "Scrub started:    %s\n", t);
+
+		if (json_output)
+			fmt_print(&fctx, "started_at", t);
+		else
+			pr_verbose(LOG_DEFAULT, "Scrub started:    %s\n", t);
 	}
 
 	seconds = ss->duration;
 	hours = ss->duration / (60 * 60);
 	gmtime_r(&seconds, &tm);
 	strftime(t, sizeof(t), "%M:%S", &tm);
-	pr_verbose(LOG_DEFAULT, "Status:           %s\n",
-			(ss->in_progress ? "running" :
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
+		fmt_print(&fctx, "duration", hours, t);
+		fmt_print_end_group(&fctx, "info");
+	} else {
+		pr_verbose(LOG_DEFAULT, "Status:           %s\n", status);
+		pr_verbose(LOG_DEFAULT, "Duration:         %u:%s\n", hours, t);
+	}
+
 }
 
 static void print_scrub_dev(struct btrfs_ioctl_dev_info_args *di,
@@ -1818,6 +1943,8 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
 	int fdres = -1;
 	int err = 0;
 
+	const bool json_output = (bconf.output_format == CMD_FORMAT_JSON);
+
 	unit_mode = get_unit_mode_from_arg(&argc, argv, 0);
 
 	optind = 0;
@@ -1896,7 +2023,13 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
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
 		for (i = 0; i < fi_args.num_devices; ++i) {
@@ -1943,10 +2076,16 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
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
@@ -1957,7 +2096,7 @@ out:
 
 	return !!err;
 }
-static DEFINE_SIMPLE_COMMAND(scrub_status, "status");
+static DEFINE_COMMAND_WITH_FLAGS(scrub_status, "status", CMD_FORMAT_JSON);
 
 static const char * const cmd_scrub_limit_usage[] = {
 	"btrfs scrub limit [options] <path>",
-- 
2.48.1


