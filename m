Return-Path: <linux-btrfs+bounces-6845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678F93FBD7
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 18:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7FC1B212EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F3015A87C;
	Mon, 29 Jul 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LwL0/ywV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA2E17756
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271878; cv=none; b=PIbQxp06RAWYYjI0ZOKYr7KTeHKzG81rY/u2VfRuFAM9YEGsuzX3ILSPEcdIoW9jfbVi9oeGVHRyjwCrzDPyHbmY5QsqBczX4Q5LjJcrmsWj/d24wZ749hhu0bbxnasvRZsiojerVeXKwCdBbCmAYhCHH+CDUYZ/Y4804S/T0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271878; c=relaxed/simple;
	bh=iX0JRbWsrgeflv74Nb63YnHYOTTvKYQaPCCNd6oi+ms=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uCopXG6fIg6FAN2e9AnjTbdBrTulkIgllb9NBz/GAcZMdaOPbxKit70zS+4noqCOkoVDD6FtGOxayQgFXqi+OqmJzRuUYSu8IkwSDATLIgA+TuaYQyjG6CKn8CB7y+UbRS4Kiq40gadWMzv9yl89gm0MQW6DCuOM5C5YPVRnx2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LwL0/ywV; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e03caab48a2so1609752276.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722271875; x=1722876675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=izogWgCAqG3q+sP9UianWIpxBiTpNP7441bGsUm/0+o=;
        b=LwL0/ywVaIAq/DzflSy4r0buBkYDn7Pz2J1tmXg9gk7y3aFw41kRVfG2zdSb777v1a
         WUfFlyvQ5ELC9hEbIXkcYa3Oc0ONzpv60GYBwlv97SsNlIURIybEUc/NUgGouJ4qwVSq
         RgBvb/SVVjsBpIJ0vMNCifMY3cu+tJ1MEbrskSjiHzhIMvqlECLwCXX78ikdMGkpI/M8
         El75AkvcwBHYpDth40erGtJ7oX0MVv5RwvwYPhjLfvU3dV2tH8sVqneb/cVDB1YMLxj7
         FBdfbSNU1uFtgmxNfXE+jO/OwJ9toKKM0SORwoLbsRF7zKQiJPf3FUxWP+mSbPyqmMr1
         RRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271875; x=1722876675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izogWgCAqG3q+sP9UianWIpxBiTpNP7441bGsUm/0+o=;
        b=RGTO2RXVadWX68ZmbhYs4eiibqYn+X6qNH+7Gu7tUX9e/gWjqhNT6NHQXrE5zu5b0K
         YBw0+DThEO3OQHysNr4xNs4moTvi8fX4LTSntXxgL7d/4dJcbi5CYU+zP/KnUWt2G7cr
         9qSxyre8mnxNKLhuW2dmmKdaYI42lSxr6CGqIIa6jf32414IU71FefVtURVOLc+drE/k
         rkCvzVfbfx+Ukh4Bquj3rcAt+Gl52SNQOqBmFs3e+/8K8kOOGjPV+MBAPiyuuuYPVPpc
         crmkrdkyfrxw7FrWGFvZ50plN71owTNF3n9IiVu+6RYXZDdMAjf8mjzs36HM2VTPcZCF
         s0ew==
X-Gm-Message-State: AOJu0YwPm6r+AVti5H8e/Y7H1GlP4sqiza22JnMmUeYKbgGakXQlV2Bh
	dC59EL0tbTUpsxQaU9xZrri0jzY5ytwn8F6IaP5IANpK0jiz6KdR0J4lJV82GL1+3ghQJ9SzCX1
	U
X-Google-Smtp-Source: AGHT+IEP6nj/SxLfyyQBONSeO4lDhkumCTKCgslbpNf3yJOcuKTOAIOfoR8cCQiQfURaYHlMpRZq9Q==
X-Received: by 2002:a05:6902:1b81:b0:e08:6373:dfc8 with SMTP id 3f1490d57ef6-e0b55989d3dmr5059056276.23.1722271875344;
        Mon, 29 Jul 2024 09:51:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a28d442sm1902714276.38.2024.07.29.09.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:51:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: emit a warning about space cache v1 being deprecated
Date: Mon, 29 Jul 2024 12:51:10 -0400
Message-ID: <942fd7466a40978db591c57457616f22fb0640c6.1722271865.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've been wanting to get rid of this for a while, add a message to
indicate that this feature is going away and when so we can finally have
a date when we're going to remove it.  The output looks like this

BTRFS warning (device nvme0n1): space cache v1 is being deprecated and will be removed in a future release
BTRFS warning (device nvme0n1): please use -o space_cache=v2

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0eda8c21d861..1f2e9900e410 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -682,8 +682,12 @@ bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_
 		ret = false;
 
 	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
-		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
+		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
 			btrfs_info(info, "disk space caching is enabled");
+			btrfs_warn(info,
+		"space cache v1 is being deprecated and will be removed in a future release");
+			btrfs_warn(info, "please use -o space_cache=v2");
+		}
 		if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
 			btrfs_info(info, "using free-space-tree");
 	}
-- 
2.43.0


