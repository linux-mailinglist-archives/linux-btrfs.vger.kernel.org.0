Return-Path: <linux-btrfs+bounces-11469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C16EA3638C
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 17:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC3C16764A
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 16:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68669267F6D;
	Fri, 14 Feb 2025 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQwakCcX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A7267B93
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551641; cv=none; b=BLGu3P3UOCQpQWZ5bLVHx7shJAJV7XGX/gFbOtRT1IT4lg5fg7+vjSvOunC8Ssyyp0W+tfFDN14M04lQ4/bparerY7KY0AOExS9/HdM9arW/CHZcKXh7azS9JfjIMG0YnUku6tgwjHEXHTMsKgxA/EZoMjXJzwRHngDa8s7iM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551641; c=relaxed/simple;
	bh=h9VC7ia3NboQIqnCFyUNSDF36KFQNuPUm9JazifEehA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEtzH825+yxvpKDjoXVx+WbaLNlFh+KCBusxwBGC+99QpTjzb73zIwRiv4VqejDnQMg/dRy0+cDNsdI9tXfpHtdjMT11M+ihcHG8vheu4PSYXdRyUV6ClGcDOBpFHl+vfjLpomreIWJPV86XSz13oQW3Ca3tEfOzoM4dOxzapBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQwakCcX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so4043560a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 08:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551638; x=1740156438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R+HK/X5VMpBmqx5xn03kG1XjHDGI5xpiTtfkHXYnXI=;
        b=IQwakCcXOM4XNOyD24FcTaePjiUP1A3cgCFLAw6OU0EeCGoiISayCTWDLKTxLMfyIH
         pB5AqZJjZaoiUC4wy0wWrkEKfVjPoW0aOOT8m7U2sKxJVByKwZVB/bdLkAzgbqSWPV2v
         zjT6vE53IuecIaxYRHoI5Xn6JQhBa9pDfJ55xcfjjS7CIqX2sVuoebhf3qr/1TwBXJgh
         BoWBVYgdYBoJpiDjadiFgjbGnigj6TXLnQ4FU4phbgzWjLHQvSS54XJBZMUx1csPefjE
         LJXaL21FowQVJnSvXoz0HXKxvD22sZ0H66M6ImrgUaFJHsBQBVgNoRduB78cxeZPNITL
         D48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551638; x=1740156438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R+HK/X5VMpBmqx5xn03kG1XjHDGI5xpiTtfkHXYnXI=;
        b=OCuFFbnrRg1cB2vcg10YY5wmoJaM6OkRpJfI0wgfxwTHfsrYN+l9qXUGbz7spASiD9
         LZ7gFaSV9D12EZiK5smsZZCa8W/ZOct+ygIFb3iA/COKLnTUUDKZVZ7h0v/+itkVc7UB
         o/KicSb7pjEe0WK6BCVP9ElBZlIRRTi/Z5xlCvBrNl9a+R3BTF+btSVH5+sSFGi89F3/
         xqptHPl1BA10WUVJZgxi2+wNuwez/2FpNDRTVRFxsYeMWIFO0md6qQxq1GdWsrQDqvkt
         XaxO0u1w7GXy+chOWmhooED6VUBhEnVEg77LqHZxOTsVsE6JhMq5FH7vW+C8BwLLoj5N
         Hi3g==
X-Gm-Message-State: AOJu0YwW+hqr0tjRw0QcUJiRKMUc3uBQXFKYeyP2jGNVSrw+tL3vKbfr
	0sy0CbwnMjT0f+bxnW66y8lXVQ20NGjwyoIl3hyjIeHBKYTMYlar
X-Gm-Gg: ASbGncsOhvHIlOOliChIuvNDhfzz1hvg8qqCVN+y/VUO2bNx4zHjM0j8KItL0i5b14b
	WpOad0j5HqGYJCebqGyOYhhEJenzSx8SlNEEtNC40ajjauJhCqY90jiuGQ1NEM1yghiF3iIcmEc
	pkpmNcmjnMoYS66aWzIE3kReVORGFuQeBvswZRCKe4bSpyR6yzXBE4BDkpIu5LyXX0wGszj1jSE
	wIVoXat34xYn+8R6iwX+ahi5dbiPOeJdQyqKt2MG+HQroL6A/z+aU8du74mUYAK2amJsJgdlPva
	47LnF+uFm2iH
X-Google-Smtp-Source: AGHT+IGbR4Z4vCYAxCsSC4dCaR0LKV8PWCkL+jCBxvkK0qgymmOGeo0pcCmMsojZN4hfVn+sYk/CjQ==
X-Received: by 2002:a17:907:2d2b:b0:ab7:f096:61d8 with SMTP id a640c23a62f3a-aba4ebfb4e8mr828861266b.29.1739551637739;
        Fri, 14 Feb 2025 08:47:17 -0800 (PST)
Received: from 192.168.1.3 ([82.78.85.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533984f2sm375019266b.131.2025.02.14.08.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:47:17 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH 2/6] btrfs-progs: Added json output format for print_scrub_full
Date: Fri, 14 Feb 2025 18:47:05 +0200
Message-ID: <20250214164709.51465-3-racz.zoli@gmail.com>
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
 cmds/scrub.c | 52 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index f049e1ed..caada704 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -162,21 +162,43 @@ static const struct rowspec scrub_status_rowspec[] = {
 
 static void print_scrub_full(struct btrfs_scrub_progress *sp)
 {
-	pr_verbose(LOG_DEFAULT, "\tdata_extents_scrubbed: %llu\n", sp->data_extents_scrubbed);
-	pr_verbose(LOG_DEFAULT, "\ttree_extents_scrubbed: %llu\n", sp->tree_extents_scrubbed);
-	pr_verbose(LOG_DEFAULT, "\tdata_bytes_scrubbed: %llu\n", sp->data_bytes_scrubbed);
-	pr_verbose(LOG_DEFAULT, "\ttree_bytes_scrubbed: %llu\n", sp->tree_bytes_scrubbed);
-	pr_verbose(LOG_DEFAULT, "\tread_errors: %llu\n", sp->read_errors);
-	pr_verbose(LOG_DEFAULT, "\tcsum_errors: %llu\n", sp->csum_errors);
-	pr_verbose(LOG_DEFAULT, "\tverify_errors: %llu\n", sp->verify_errors);
-	pr_verbose(LOG_DEFAULT, "\tno_csum: %llu\n", sp->no_csum);
-	pr_verbose(LOG_DEFAULT, "\tcsum_discards: %llu\n", sp->csum_discards);
-	pr_verbose(LOG_DEFAULT, "\tsuper_errors: %llu\n", sp->super_errors);
-	pr_verbose(LOG_DEFAULT, "\tmalloc_errors: %llu\n", sp->malloc_errors);
-	pr_verbose(LOG_DEFAULT, "\tuncorrectable_errors: %llu\n", sp->uncorrectable_errors);
-	pr_verbose(LOG_DEFAULT, "\tunverified_errors: %llu\n", sp->unverified_errors);
-	pr_verbose(LOG_DEFAULT, "\tcorrected_errors: %llu\n", sp->corrected_errors);
-	pr_verbose(LOG_DEFAULT, "\tlast_physical: %llu\n", sp->last_physical);
+	if (bconf.output_format == CMD_FORMAT_JSON) {
+		fmt_print_start_group(&fctx, "scrub", JSON_TYPE_MAP);
+
+		fmt_print(&fctx, "data-extents-scrubbed", sp->data_extents_scrubbed);
+		fmt_print(&fctx, "tree-extents-scrubbed", sp->tree_extents_scrubbed);
+		fmt_print(&fctx, "data-bytes-scrubbed", sp->data_bytes_scrubbed);
+		fmt_print(&fctx, "tree-bytes-scrubbed", sp->tree_bytes_scrubbed);
+		fmt_print(&fctx, "read-errors", sp->read_errors);
+		fmt_print(&fctx, "csum-errors", sp->csum_errors);
+		fmt_print(&fctx, "verify-errors", sp->verify_errors);
+		fmt_print(&fctx, "no-csum", sp->no_csum);
+		fmt_print(&fctx, "csum-discards", sp->csum_discards);
+		fmt_print(&fctx, "super-errors", sp->super_errors);
+		fmt_print(&fctx, "malloc-errors", sp->malloc_errors);
+		fmt_print(&fctx, "uncorrectable-errors", sp->uncorrectable_errors);
+		fmt_print(&fctx, "unverified-errors", sp->unverified_errors);
+		fmt_print(&fctx, "corrected-errors", sp->corrected_errors);
+		fmt_print(&fctx, "last-physical", sp->last_physical);
+
+		fmt_print_end_group(&fctx, "scrub");
+	} else {
+		pr_verbose(LOG_DEFAULT, "\tdata_extents_scrubbed: %llu\n", sp->data_extents_scrubbed);
+		pr_verbose(LOG_DEFAULT, "\ttree_extents_scrubbed: %llu\n", sp->tree_extents_scrubbed);
+		pr_verbose(LOG_DEFAULT, "\tdata_bytes_scrubbed: %llu\n", sp->data_bytes_scrubbed);
+		pr_verbose(LOG_DEFAULT, "\ttree_bytes_scrubbed: %llu\n", sp->tree_bytes_scrubbed);
+		pr_verbose(LOG_DEFAULT, "\tread_errors: %llu\n", sp->read_errors);
+		pr_verbose(LOG_DEFAULT, "\tcsum_errors: %llu\n", sp->csum_errors);
+		pr_verbose(LOG_DEFAULT, "\tverify_errors: %llu\n", sp->verify_errors);
+		pr_verbose(LOG_DEFAULT, "\tno_csum: %llu\n", sp->no_csum);
+		pr_verbose(LOG_DEFAULT, "\tcsum_discards: %llu\n", sp->csum_discards);
+		pr_verbose(LOG_DEFAULT, "\tsuper_errors: %llu\n", sp->super_errors);
+		pr_verbose(LOG_DEFAULT, "\tmalloc_errors: %llu\n", sp->malloc_errors);
+		pr_verbose(LOG_DEFAULT, "\tuncorrectable_errors: %llu\n", sp->uncorrectable_errors);
+		pr_verbose(LOG_DEFAULT, "\tunverified_errors: %llu\n", sp->unverified_errors);
+		pr_verbose(LOG_DEFAULT, "\tcorrected_errors: %llu\n", sp->corrected_errors);
+		pr_verbose(LOG_DEFAULT, "\tlast_physical: %llu\n", sp->last_physical);
+	}
 }
 
 #define PRINT_SCRUB_ERROR(test, desc) do {	\
-- 
2.48.1


