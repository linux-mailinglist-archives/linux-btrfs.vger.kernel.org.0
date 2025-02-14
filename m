Return-Path: <linux-btrfs+bounces-11468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1215A36384
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 17:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2563AEE00
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF851267B9A;
	Fri, 14 Feb 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmdXayxT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9F26773C
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551639; cv=none; b=qF/Ra3jhknD0YBr5swbS3qJNkNYlB3KD87HdorfqdmwvWDwVuAp5ZBOUpepdCsljkJo5oTqHP6G8hazZRZ2bfQTqbpcsAcAKfqmUH7P7ghRsp1UtZs0ibHz8oWC/cO6ccnNrfXRr52mH9LAutp5+lsRNZg5mnUNtXA7/TIOWylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551639; c=relaxed/simple;
	bh=FfU1709jXSdh8cXj6i1JL9YzG+JkuXKqq/1gZX5mFxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUlCNR54l89ys2OYeFjdaP1GBO5wndSmhPspltOXKyomGEPBEunj++tWoqoujMP3Utt6rHjhlIg7S6o6JEUsPfaca7+ApiurMLkmwcXHJC9QYhR2ExeUscPKhxJl8AgQS9cU3adxOefTIIRa9WvI69Y4XmoddJMZ4MkJ0FAahVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmdXayxT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7cc0c1a37so422245566b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 08:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551635; x=1740156435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAKfgHF3EWnefLOKEDxUvxYcMb7kjH4Hs3f4TlPDgIU=;
        b=VmdXayxTe9C/l6yIrJiYb92+cXioN+9JsLbFtO+U2nLEIU7YOInWaqjUKcf2KlL5U1
         AOd1dhvfKU0ajiLjW0OFwx4Val6Ew99OuUMokGGaTp3fuIfgMrV6kmkLrj03AwWax4qF
         rHXj0blcXCX7rsTPTm3QOee8u/IWcXKOq6Ljh1ynWpFwlIIW91lxs9/QsO9/DsyDw+bj
         62qKwJgY5fgiRbYgejuai7xX9ysDjv6D+PVczIJ1dRU85QqsDCUpq4t2VX04a7yxeAe/
         NI9l85qp3sUBuitoMRruFWLp3x6gXBODUeX3fPMlTm2P/XvJnwKbCSU4lO6SLiGlEjBh
         HV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551635; x=1740156435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAKfgHF3EWnefLOKEDxUvxYcMb7kjH4Hs3f4TlPDgIU=;
        b=oUG5OagP2SCktO3404E+IuENCpPr/wCRARrNI7GZarCPLfWsQWILCfKEeEHCu3vmZj
         sZMDGAF6hAvJzH9Zl3AFbxk/GKIoLTKbo25GytTA9UtEZD5YmvMmJ6PrYnKGwr5XR20p
         2N+CaMMsxZjUUGZKSxBA/KCGfQOmOYVv+gPEaUVV82medtlOtc0OjZO8IfBBoOlqL3Bf
         EQ2MNp0w2bLuw1Df4GYEVVEfjDisw7aKjxB+V9sFXZ2CVUdTh1Zel5R0CjUAc0/4469E
         FDflXMnfxymsVosK32M2ZrA9B803+SKpjdRgS0h1bIJb41O8te/lEbk8HDzySONMHdk+
         AuMQ==
X-Gm-Message-State: AOJu0YwJ3dqckfOarDiIf757mDyTfIlkfVyF0RUZeEC7073snNUU0atn
	Fdl+TVWLY9jsT7U/d+w7gZ5Xsc7vsD5hh/+xLFr1W1pxCGGUyMeB
X-Gm-Gg: ASbGncuMhIwBRnsAKAjwy6/9EajKx5yAoH0W4OJbdOK1Ze2nZYuz6ylyNJmoUpo7pg6
	m4e1zxdpXIwo626dUy2yK7R5Rzy+zM3BhOChr8x/DsERoxshf1rKtNSAvMZlMN/JjsbSvx5eMYo
	S9slUsAtZCmuWqwGclLQhT63Dae/osjpj7P63rlL2MqcaMv+R3xoRdTps/+17Nm66NEa6Cwf7jr
	ChhnrsIYeaLjWKfdfDTWxnuljiKfA0qgKj+2kW039U2amcH0m4nDBvPqX03fObRE/LeIF6JJYLS
	3/6sQhmSdqK9
X-Google-Smtp-Source: AGHT+IHUMYZ7AywObXTWuIlCHSvsq5tpPSXcEY2HJWpNCmiVJO1zRxWx9ekodmIOZeeoC6fJmRPJRQ==
X-Received: by 2002:a17:907:c282:b0:ab7:bcc0:9050 with SMTP id a640c23a62f3a-ab7f33da7c2mr1276849966b.27.1739551635147;
        Fri, 14 Feb 2025 08:47:15 -0800 (PST)
Received: from 192.168.1.3 ([82.78.85.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533984f2sm375019266b.131.2025.02.14.08.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:47:14 -0800 (PST)
From: Racz Zoltan <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH 1/6] btrfs-progs: Added rowspec struct and neccesary include file for json output format
Date: Fri, 14 Feb 2025 18:47:04 +0200
Message-ID: <20250214164709.51465-2-racz.zoli@gmail.com>
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
 cmds/scrub.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index f769188a..f049e1ed 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -53,6 +53,7 @@
 #include "common/sysfs-utils.h"
 #include "common/string-table.h"
 #include "common/string-utils.h"
+#include "common/format-output.h"
 #include "common/help.h"
 #include "cmds/commands.h"
 
@@ -124,6 +125,41 @@ struct scrub_fs_stat {
 	int i;
 };
 
+struct format_ctx fctx;
+
+static const struct rowspec scrub_status_rowspec[] = {
+	{ .key = "uuid", .fmt = "%s", .out_json = "uuid"},
+	{ .key = "dev", .fmt = "%s", .out_json = "dev"},
+	{ .key = "id", .fmt = "%llu", .out_json = "id"},
+	{ .key = "status", .fmt = "%s", .out_json = "status"},
+	{ .key = "duration", .fmt = "duration", .out_json = "duration"},
+	{ .key = "started-at", .fmt = "date-time", .out_json = "started-at"},
+	{ .key = "resumed-at", .fmt = "date-time", .out_json = "resumed-at"},
+	{ .key = "data-extents-scrubbed", .fmt = "%llu", .out_json = "data-extents-scrubbed"},
+	{ .key = "tree-extents-scrubbed", .fmt = "%llu", .out_json = "tree-extents-scrubbed"},
+	{ .key = "data-bytes-scrubbed", .fmt = "%llu", .out_json = "data-bytes-scrubbed"},
+	{ .key = "tree-bytes-scrubbed", .fmt = "%llu", .out_json = "tree-bytes-scrubbed"},
+	{ .key = "read-errors", .fmt = "%llu", .out_json = "read-errors"},
+	{ .key = "csum-errors", .fmt = "%llu", .out_json = "csum-errors"},
+	{ .key = "verify-errors", .fmt = "%llu", .out_json = "verify-errors"},
+	{ .key = "no-csum", .fmt = "%llu", .out_json = "no-csum"},
+	{ .key = "csum-discards", .fmt = "%llu", .out_json = "csum-discards"},
+	{ .key = "super-errors", .fmt = "%llu", .out_json = "super-errors"},
+	{ .key = "malloc-errors", .fmt = "%llu", .out_json = "malloc-errors"},
+	{ .key = "uncorrectable-errors", .fmt = "%llu", .out_json = "uncorrectable-errors"},
+	{ .key = "unverified-errors", .fmt = "%llu", .out_json = "unverified-errors"},
+	{ .key = "corrected-errors", .fmt = "%llu", .out_json = "corrected-errors"},
+	{ .key = "last-physical", .fmt = "%llu", .out_json = "last-physical"},
+	{ .key = "time-left", .fmt = "duration", .out_json = "time-left"},
+	{ .key = "eta", .fmt = "date-time", .out_json = "eta"},
+	{ .key = "total-bytes-to-scrub", .fmt = "%llu", .out_json = "total-bytes-to-scrub"},
+	{ .key = "bytes-scrubbed", .fmt = "%llu", .out_json = "bytes-scrubbed"},
+	{ .key = "rate", .fmt = "%llu", .out_json = "rate"},
+	{ .key = "limit", .fmt = "%llu", .out_json = "limit"},
+
+	ROWSPEC_END
+};
+
 static void print_scrub_full(struct btrfs_scrub_progress *sp)
 {
 	pr_verbose(LOG_DEFAULT, "\tdata_extents_scrubbed: %llu\n", sp->data_extents_scrubbed);
-- 
2.48.1


