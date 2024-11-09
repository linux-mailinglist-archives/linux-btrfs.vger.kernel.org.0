Return-Path: <linux-btrfs+bounces-9399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B53C9C2B6D
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2024 10:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7784B21E6F
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2024 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A551465AB;
	Sat,  9 Nov 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b="Kk3yUV0m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wiki.archlinuxcn.org (wiki.archlinuxcn.org [104.245.9.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F6288D1
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Nov 2024 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.9.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731145047; cv=none; b=OU6xJP8QOchNzEXrTM5AflI2JSV7Xvaz0jAe8WznpBUvPuchKrJlXbBxSPq8bP6MuEEorkviSqG4RydDoVfFtliIOx8ShgKTwai3cfHUoVpeJiDB8O8Cw2+mBUZy3XpvF7Q8VKPvwELfdoe7AVcw3Mz7fz72OH4u+Ri2FKXBjP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731145047; c=relaxed/simple;
	bh=WUSzPC8LbEZflAiPwWuJ6yP6ZjLxEoe3h9ZGCgKbiUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TjoFCPm1cr7rBAvCDVwbJeXoRPnkAU49EuK2pns+FHXvO1udARGzraxprIAimYq7d+W/7at2Z/qaqnAOehkksXlIwElvPBaoLAbvQPUnnrwSOtd4r+G7B/GY11tBjN7WB1XE2I43RKNqoRDrDPMf957WcHsMT/vWIRCMbzi021s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org; spf=pass smtp.mailfrom=archlinuxcn.org; dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b=Kk3yUV0m; arc=none smtp.client-ip=104.245.9.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinuxcn.org
DKIM-Signature: a=rsa-sha256; bh=cxO0GmgaAdtV8tJp1nxO8HDTT0hbYq1WO3k4oMyY/lo=;
 c=relaxed/relaxed; d=archlinuxcn.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@archlinuxcn.org; s=default; t=1731145040; v=1; x=1731577040;
 b=Kk3yUV0mvsvu3mSN7cg4hH9C83lqE4ukbJiYpKzyFH9MgoQJfc7NrjDj3luaCMKZsGrD8Gki
 vWXDqkOGcrwFPriYKEK6Q+8Fyc227nRE0cW2MO5XWCNc6bfDvJWO78qWOKRa4rIQgLfN92kQGQf
 RD9tu3xNr45PJaMwsjNde0FpipmUpS1bECs2rRfOa2PSN7+IG0y9EOWz/Lpo9vjhRuFpUlHKjiB
 FWdP6lg/yy3qlF2xWDZBM6A+IfN2Ko3tf6vezcqWJ0shugr5krFPn8Bg33Nm8wNi4S8op6U/DZa
 GtJn2qrpj09Jg0HKfXLFMV8XRhX4n0GkCFCeWFLYyYOWA==
Received: by wiki.archlinuxcn.org (envelope-sender
 <integral@archlinuxcn.org>) with ESMTPS id 1500ce07; Sat, 09 Nov 2024
 17:37:20 +0800
From: Integral <integral@archlinuxcn.org>
To: linux-btrfs@vger.kernel.org,
	wqu@suse.com
Cc: integral@archlinuxcn.org
Subject: [PATCH] btrfs-progs: replace sizeof() with ARRAY_SIZE() macro
Date: Sat,  9 Nov 2024 17:37:04 +0800
Message-ID: <20241109093704.84519-1-integral@archlinuxcn.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ARRAY_SIZE() macro to simplify for loop.

Signed-off-by: Integral <integral@archlinuxcn.org>
---
 common/format-output.c | 2 +-
 common/sort-utils.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/format-output.c b/common/format-output.c
index 3b333ed5..f150a4f2 100644
--- a/common/format-output.c
+++ b/common/format-output.c
@@ -149,7 +149,7 @@ static bool fmt_set_unquoted(struct format_ctx *fctx, const struct rowspec *row,
 {
 	static const char *types[] = { "%llu", "bool" };
 
-	for (int i = 0; i < sizeof(types) / sizeof(types[0]); i++)
+	for (int i = 0; i < ARRAY_SIZE(types); i++)
 		if (strcmp(types[i], row->fmt) == 0)
 			return true;
 
diff --git a/common/sort-utils.h b/common/sort-utils.h
index 09be7b7d..a8af9658 100644
--- a/common/sort-utils.h
+++ b/common/sort-utils.h
@@ -56,7 +56,7 @@ void test() {
 	const char *sortby[] = { "size", "id" };
 
 	compare_init(&comp, sortit);
-	for (i = 0; i < sizeof(sortby) / sizeof(sortby[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(sortby); i++) {
 		ret = compare_add_sort_key(&comp, sortby[i]);
 		if (ret < 0) {
 			printf("ERROR adding sort key %s\n", sortby[i]);
-- 
2.47.0


