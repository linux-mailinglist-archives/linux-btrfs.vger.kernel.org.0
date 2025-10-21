Return-Path: <linux-btrfs+bounces-18110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43001BF61B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 13:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4139F4EC9CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 11:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E632E681;
	Tue, 21 Oct 2025 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="J2Wn9tG2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sg-1-39.ptr.blmpb.com (sg-1-39.ptr.blmpb.com [118.26.132.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A94253B59
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046975; cv=none; b=mryUAqcR6yvBPxXV3hqdWP+b1kXvW3JtJR63jJ770FN1AVfcHrogvm7jxKz4VmdQ9Ob+SaGWVokEeRc5/OVERXcU9Hkm62tFtDWUwBCog12aMNwEibwcFow57RMbnWNuyFtVfPLFjobeJULOtfnAPNfK6MHxbYAXTqqLs6ceROg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046975; c=relaxed/simple;
	bh=B4tsUSO8yiFKFRKonsO8RddcnRX8VOCRh2Kbu18R+wA=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:To:Cc:Date; b=XUc/WkzHqDsl1Fl/1YKEnOZDKkowPX6rA78TNh3amZXegswNIgc867o+jVQIJ95rZGZwQts3p59vVbbzSc1BEWNv7SiTM5H6JCKZ7D9lUYBB0FF/9+zIDJSl1pwFaOBOiIv457jiuwxXKKX47DVJXwk1NG2SBn6Nj8OFvBnWbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=J2Wn9tG2; arc=none smtp.client-ip=118.26.132.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1761046953;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=JHFMaMddiIiWhSnguLqzboaxMqfAgi74JB4+FXDGciQ=;
 b=J2Wn9tG218zsqH0bGTW/HUslccVlO7fUK0CuJDvYpGPHNSrLK5F7mLESf/j8qGp8U6A2RS
 Vm6vJNzchMRXU1xgSd2foyMm4wj11QmuEMvvIarq2BwPeEJyo8gAFEM9of7HZbjDlJXJhd
 uTD6GhhxByWeu7Yv0AQW+AiugXU2023ZP0GAJq5AZqPxzZT3/mwwl+2ZuDhDY9Z9NtMEn8
 cppZq0L+rbOvaTfdo4NjMR2cE7MncepEmDKifmK1LuLgAhS/mZizFhjMJCbm6v3jUAdW2i
 NcVgX9bfusNAqdl+DdZXkoJuVKQ2dzmigKR2GJWOdRA9ZxedAR2yiTPV9ZO+4w==
Content-Type: text/plain; charset=UTF-8
From: "Dongjiang Zhu" <zhudongjiang@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from debian.localdomain ([116.23.174.48]) by smtp.feishu.cn with ESMTPS; Tue, 21 Oct 2025 19:42:30 +0800
X-Mailer: git-send-email 2.39.5
X-Original-From: Dongjiang Zhu <zhudongjiang@fnnas.com>
X-Lms-Return-Path: <lba+268f771a7+1b8c21+vger.kernel.org+zhudongjiang@fnnas.com>
Subject: [PATCH] btrfs-progs: btrfs-find-root: fix incorrect command name in usage text
Message-Id: <20251021114211.2216602-1-zhudongjiang@fnnas.com>
Content-Transfer-Encoding: 7bit
To: <linux-btrfs@vger.kernel.org>
Cc: <dsterba@suse.com>
Date: Tue, 21 Oct 2025 19:42:11 +0800

The usage string incorrectly showed "btrfs-find-usage" instead of
"btrfs-find-root", which could confuse users reading the help text.

Signed-off-by: Dongjiang Zhu <zhudongjiang@fnnas.com>
---
 btrfs-find-root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btrfs-find-root.c b/btrfs-find-root.c
index f0f0079e..5ed6fa51 100644
--- a/btrfs-find-root.c
+++ b/btrfs-find-root.c
@@ -321,7 +321,7 @@ static void print_find_root_result(struct cache_tree *result,
 }
 
 static const char * const btrfs_find_root_usage[] = {
-	"btrfs-find-usage [options] <device>",
+	"btrfs-find-root [options] <device>",
 	"Attempt to find tree roots on the device",
 	"",
 	OPTLINE("-a", "search through all metadata even if the root has been found"),
-- 
2.39.5

