Return-Path: <linux-btrfs+bounces-11757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2274A4398D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 10:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055F8188CE72
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3BA26159F;
	Tue, 25 Feb 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qtzOxqD9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338CA261592
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475866; cv=none; b=dxzXENpUI7KeMmrpS7D+eGZfvUddGl3cZVRDW4DsbftqLYnOI13C95A1EQSPDoGIWO7RQYu71CR9IO3hIC4j/2rG0QEBJN91MiOm3XmdA3lW3blEfBDXrLpG31yJUc+tXi8eAJ9OKP7kiXr2z0Iz4uUV//gldlPaEwiE+zSsoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475866; c=relaxed/simple;
	bh=gwp2fuJXCL/bjNIarZEPkgmjBf8NLWIelOI9giPWV8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=muGkWH+3yq1CQHK9NeJ3Y99Eq8ffClhJDrZ8EuZGauaq0A10+H/mqGvX41k03pshr+Pb73LxQ2o0wnWiSVD9W09OdGn+TfGU/4euU7bEfr43lTDq+Xv3RUQ+LVuzGqD0GvxX54Y/9r5yo+kBKRPQadk245fBzzea3A38e7mG2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qtzOxqD9; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740475861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=isPQgwurSdwU4T9ma6rP9Qtz5aT2veuB9Ji0NyBAn4o=;
	b=qtzOxqD9Ri5jjb902pbFYhzZ6EzVrV12wtzG47jsrGdYj7Sg2QCW9dKlkagI5EIv5pRgIL
	0g/P6xRW1qyAchXbFS0h7FAm1hB6JpPmn0JKgQfczdufF5Wi8ps59ZhbGhrCUjhudYqvCe
	xpdRdnUOV+AyDBIb+ndHJknC6QocUWk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Replace deprecated strncpy() with strscpy_pad()
Date: Tue, 25 Feb 2025 10:29:49 +0100
Message-ID: <20250225092949.287300-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy_pad() instead and don't zero-initialize the param array.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/btrfs/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 53b846d99ece..b941fb37776d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1330,13 +1330,13 @@ MODULE_PARM_DESC(read_policy,
 
 int btrfs_read_policy_to_enum(const char *str, s64 *value_ret)
 {
-	char param[32] = { 0 };
+	char param[32];
 	char __maybe_unused *value_str;
 
 	if (!str || strlen(str) == 0)
 		return 0;
 
-	strncpy(param, str, sizeof(param) - 1);
+	strscpy_pad(param, str);
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/* Separate value from input in policy:value format. */
-- 
2.48.1


