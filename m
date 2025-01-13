Return-Path: <linux-btrfs+bounces-10941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E803EA0C175
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A8D1887273
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B70C1CCEE7;
	Mon, 13 Jan 2025 19:31:56 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CFD1BFE10;
	Mon, 13 Jan 2025 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796715; cv=none; b=okK7N7nQRGbXtymiGHjiL251KBXgzneb9JmBcWW4a/TJDlvv0XKM9YPlRJvvfJrDROM6vWIRbwoK3ll8Ngo8lm7fEnMpWn8WHYwj9VFM6ZPCqfcG5EdDhV99TPFjcMazenHHDuNfJvxHymDBYM2qAInz9QvF3jRPzwqDuuD8zwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796715; c=relaxed/simple;
	bh=12M08uOzmewaRubKx3ilmywyb5xCZHGXotZUfNS0yws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRRaJtYuIfqIU7k05JHBM8+8EG3YZQLs2yNbnAiFpJrDuRhStMEDhZYn2njsWRtw5EqqUZIG3mzSn+qDXltIuo9433PRmbFChX7pl94etX0tuB6E9qi5TzwxwHVEMwcFFG1XtmggybnQ0IiRnQMv1mrxfo+cLZcV1afC8aeL6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361c705434so33815305e9.3;
        Mon, 13 Jan 2025 11:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796712; x=1737401512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaVmQNFO5ColZz3dSwoLzStXNgbCzBBF6SfmCjsGQeg=;
        b=bH2nZjQKw6caeANZTzHw0vCejO7fiFdgUXZEh2zkj430UKfRBHi2amkV16kWuthGH6
         ASxyLoEepsuITVsqkheDrvWEm01WkObQrkeF9AkDtamIWG+0DrTk4o0MP7NYiOjOhMA0
         v7iQbS3HoBL7JwC42OPIf1XZlIEvpf+w/JY/vX5FCtKk+/Xm+cWdoz2/oj/+0VVwTGpo
         rbJbNM4KUsLDgSkvy8UsTU3Ihia+BsCRHTZeI94vYmzUIiHL5CCZKKG84z1K6HDxNLr4
         H+8m29o+ehhQKhUkfVbkWml+kGR6E5fjPB+0BnEyZ/Nl2zqEAU9PX/O1+u8GPZWiXoE+
         /94A==
X-Forwarded-Encrypted: i=1; AJvYcCUtPvC6E/BTxnUt2/QCMdQOym4wKITQz+7HdFIkeGJ+dbsuynnkZSHj67FwUxKjyTndyIVNqM9eHdI8GK/Y@vger.kernel.org, AJvYcCX4TjtYXsmLtOuR0su/ucnwIeXd7WKTVv0c30Z55jIjpUpP8DtG7yqhfRVXntxREfsTo9TRad2TNvu5Cw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1gyqEDgSdkOfcRfitO6RCQnxrPTjZF7JqqODZpuCMutM0DwJ
	fJ4om/p9DHMY3HocfT+/HBPTZLMASOm7U+ms5+8lvqE0Xpejk5e+
X-Gm-Gg: ASbGncv6tvZq9OYX6cD/F7CJMtplhf697Cz//brrPjzsv6k1h8xua0FFdFn9703Q2eY
	4nl6amV7ODMggXc5JuA+m5kZJ1IH744FR0+gsl5N/hGZ31IFX15Tn5LdOycg1PbzXQEAwwiFo8f
	tr+qqGhEaialMboFTawoYUnAESno/7LlkiPAUrcTiZ6PJnmrgTWWOG72T0O1LZu0LIVph0F4/kY
	3KDXUYhl2ujdOS68dbz1MGD76bCVvuUeN9gFR//uJoQVcye/fxqSCVtdWm+la2BSO1NeOXSbFat
	hr3AYbH31UDi8QXMw0/g01oHAwY0ctRwLql/
X-Google-Smtp-Source: AGHT+IGcoo7XhMBGBK6O/oiRXZ83xTzhYTBdS2GhVc0EtNVYJLiSPhI5gzIic5Hgo2RPcZbNmYaj/Q==
X-Received: by 2002:a05:600c:3543:b0:434:f767:68ea with SMTP id 5b1f17b1804b1-436e2677c7dmr223148565e9.5.1736796712283;
        Mon, 13 Jan 2025 11:31:52 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:31:51 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:42 +0100
Subject: [PATCH v4 01/14] btrfs: selftests: correct RAID stripe-tree
 feature flag setting
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-1-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=jth@kernel.org;
 h=from:subject:message-id; bh=KtjrQjuXR52mbd1aGQPzcGKndXVW0hIn1fHnx4Cksm8=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3Zqk0nJr1Lmn6RCGWQla+3sNyARXSsvymawLrfurcD
 g/e/4Ono5SFQYyLQVZMkeV4qO1+CdMj7FMOvTaDmcPKBDKEgYtTACbipMfwP9Zz65vdna73WOdF
 tNt7B71lf/GbJf3Z1jyPs0Easr5RjowMm7Xtd7y5/ER9Wo2xKVu4BZfINCcJHtUFL/NynL/Lp1h
 yAQA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

RAID stripe-tree is an incompatible feature not a read-only compatible, so
set the incompat flag not a compat_ro one in the selftest code.

Subsequent changes in btrfs_delete_raid_extent() will start checking for
this flag.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 30f17eb7b6a8a1dfa9f66ed5508da42a70db1fa3..5801142ba7c3a43ea075a1f7aafe704c8e1e075b 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -478,8 +478,8 @@ static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
 		ret = PTR_ERR(root);
 		goto out;
 	}
-	btrfs_set_super_compat_ro_flags(root->fs_info->super_copy,
-					BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE);
+	btrfs_set_super_incompat_flags(root->fs_info->super_copy,
+				       BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE);
 	root->root_key.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
 	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root->root_key.offset = 0;

-- 
2.43.0


