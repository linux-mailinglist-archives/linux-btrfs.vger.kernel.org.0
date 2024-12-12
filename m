Return-Path: <linux-btrfs+bounces-10301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238E19EE0AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36191886405
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB2920B20B;
	Thu, 12 Dec 2024 07:56:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF220C485
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990166; cv=none; b=mxyMykHrrUsNxLIP9RizJQs9AZFrJ6Xess9a9Kj3GvcWV3xcNiLruYfMG+wuc7Zmv5LYJJSan/g2uZtoYpD0EtadPrnoYwMFJWb/WM6Isz0NXZwz61oJRBOx82sIBUl86OfjzE3syWyuANKj9/kqQP9mtHhUVqeSqTVJ2KERA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990166; c=relaxed/simple;
	bh=DPCdWz0uEldY2rRUaGlSEV+v2xvBHaWjnQLAEL6VZGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tg/+IE96+7m2h8s2ocGouvkVzQv64NooFx/hZZ3LLeuQWGVok9VNV1j3WeRxV/trw5nR8j4dZvRFY3pDp+vPO87Ui6PbIXO+stIwxyQn19ud2w8Qnr0+JpZ4C7f/E4x/HcyJfLTIM0NiZhREw2AiXDtj1lVSA+ANYJWZxBaG9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa670ffe302so48525066b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990164; x=1734594964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eF15fnQ7O/HlXtS6eEPT/P4udZm/bAW5ml/GacSwR1E=;
        b=GQ9nOB3lnmJ0w/kmJGrfFIMHJ+hk1fAKRpXMfguyNksXbiJkUnSONkyICb0andXB6R
         3LZKsbiMOMjFRvX277kjg01AzWwbYwM5Xm3kESrX/nWhhr852mr604fFk8jptg31ONUr
         KVZiyt6CJTtIStu27+ryhvKNhNs+VlV8bAMLOo98oPagIP7bS9z+XC+vYvVwVLeazz2s
         sgg/A8du5Dr778k6fi68/u2FhPBjNBW3RDISNEEs/DIcFd4+ACJSMgxzaw1mdCVDGmm3
         MHdgtqXdIYbEtWimk/UqFBKDjRjU+lTORfSFwySjmt0BlJ0Z2ZDLVSjZgOIJVE9aMCA3
         xmUg==
X-Gm-Message-State: AOJu0YyeyJEu0RV4Q78/oyCzQQi4xM8VKJpKR3HisoXfotF34vhrVCgA
	bCFldWPXvRhSrqZq2lfxzQ4GyH3pvxIlQn186Df784kIbPh8txl20Z8LRjFi
X-Gm-Gg: ASbGncvu8+sweDXz08h5tUhEF8nXcehQ6g4Xmy8AfhNU0YbZilZNhDtC6DUmxZ0diyK
	0M33zYolQpz+V8rAKkQqQBwEYnRbAm+KqQqNcbbgkYKhNHIwQ47KeSdB0oVaSFjdSyQBC3tAJ8K
	qnuAOfUu+P5W2JzYNo8SHDywTciJojWqErZH1AOLsiINTf7XSln8m+TpOj57jwVPWEigxRcbgIO
	UjRwYQtEkDbgzsWIe1Hmuiww0pf9sgYFpe97NclcP7npdZ2OefgEoSurMFfbfvPIhnk4/AXerp2
	mnskohTjCU+enq8nXtFC7YjO7W88WO6xRcybSOk=
X-Google-Smtp-Source: AGHT+IH9rEYLvDEW8YJN/9BIJLLVlLn8rUtCaGB8rmE8YKGPZci8wk3IXru4A2su0JoL5UrBnm4syA==
X-Received: by 2002:a17:906:318a:b0:aa6:7165:504c with SMTP id a640c23a62f3a-aa6c1cf0b1cmr262992566b.37.1733990163750;
        Wed, 11 Dec 2024 23:56:03 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:56:03 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/14] btrfs: selftests: check for correct return value of failed lookup
Date: Thu, 12 Dec 2024 08:55:28 +0100
Message-ID: <001ec4d2336af581f1014c6a3ec96c24ba6e5dba.1733989299.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733989299.git.jth@kernel.org>
References: <cover.1733989299.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Commit 5e72aabc1fff ("btrfs: return ENODATA in case RST lookup fails")
changed btrfs_get_raid_extent_offset()'s return value to ENODATA in case
the RAID stripe-tree lookup failed.

Adjust the test cases which check for absence of a given range to check
for ENODATA as return value in this case.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index f060c04c7f76..19f6147a38a5 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -125,7 +125,7 @@ static int test_front_delete(struct btrfs_trans_handle *trans)
 	}
 
 	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0, &io_stripe);
-	if (!ret) {
+	if (ret != -ENODATA) {
 		ret = -EINVAL;
 		test_err("lookup of RAID extent [%llu, %llu] succeeded, should fail",
 			 logical, logical + SZ_32K);
-- 
2.43.0


