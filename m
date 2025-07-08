Return-Path: <linux-btrfs+bounces-15321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24094AFC9B1
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 13:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0974A1BC03FA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 11:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151D02820A5;
	Tue,  8 Jul 2025 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SK+3ylnj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CBE2690D1
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974497; cv=none; b=Jb/lzv9Zv5UPcZDe6Zeg/FLZ7zSdoVHxCcjj6rFo6S7gIK+wwPYUeeBjhEEkRfZEaYCJ3O3HS2wFaLGspOBAcgSqvaJZC0/+Ez5/pdbD5jzs5N9zfpDF2q4iVWO7IcyR/Ta1BZFls8RYeQfP5hpGc/vu/9Kfs+PN6g6OANo9hLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974497; c=relaxed/simple;
	bh=Bk3DP+06SoCiwyXd/QeP+6d8XutNZSWaB2rTikpl+OE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W37lzlYkn5uQaNPb1jmJ9Po0c46vlyYfeumfOnnwQY0ML2Q9rOt3LpwTdDCBT20CpcGv4ySeg6hE8Ishf6cfm2PpM12YqB5JAfgBK7BpUeqWIQISwlNYXkp3XgeJCOub2M/p/iOFapsUdGBkI2yJlbEp8TykDFQTYN1KAdFpx5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SK+3ylnj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso2487264f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Jul 2025 04:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751974493; x=1752579293; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+NMcbjKHVmgPTHUhj1Yf+qG+1KgczemAGf9JeCYIBo=;
        b=SK+3ylnjYhZh/Q9tWf/XDJFxqpfdch3CP5ubpUh/2Xio32fgcxlzMNgEbMo91ZyeQF
         ccnimiSVZM8ileGmDtXHtZ56iu6Nh94Bf7HKH7l8Z/TU3x2Ph0sWT/Rq9GOeSfJv631j
         q+w7inalJnSeYg9WKgQLQ0nr4LOLO+Oo71zT6PxuQuuZfio1UC6AMCUbPMujkwWZA4LL
         dwr9JdkkkJvdE4nSN/7jHE3Te2b8gk8A3Pq/URxCk+TlXrJ6D8y3zr1PiJzNZckHMz4s
         j7TNL/FpmhHy9g3NcEYGUZLfGorcc2W1NJqiHOYjV90p9Ep7lsHzhu5yaet/k2S7xKYj
         zWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974493; x=1752579293;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+NMcbjKHVmgPTHUhj1Yf+qG+1KgczemAGf9JeCYIBo=;
        b=mZ/pGECKuSX2zdJ5TqLQpypV0KCFsrgF6898qLPQ3JnXrm39K9IjnCHgnZeRVmoFWI
         N0Dx/r2kWRXjX7pc2rhstmOOKLgiRaQx3hxUdSO3l3dYvuXIV/bP6e0t0oRRYRxh+Wlm
         rsEbGLzGyfImjZ7VdxyLBubIkYp6zuUxVJ4tvsg5R0STtJv4lFloUgmjV807pkRC9efF
         Sc8FlKMj2dW+gbG9FgLYUgj4MfmMOKAporkZD3wKcvK/Hm22Yd4Udvfd74WQOIEzQ+P+
         FY0ji4lfV38oWeXBhDIjRo4z0Bxb1FuaJksFayMWJyB2Gy6rHaPiz5RRylR/V6q/YqTG
         IT+A==
X-Gm-Message-State: AOJu0YzwSleeqc0y7J6c5ewLCrWPYcoiJ9A4CItlbBC0m9/MMWMeqL4N
	fz0fpvvUGcS/+g909iy3byg8/UKTEj94gS3wA8v8iIU7zN9nCYQiiiNz6WK1teHmhAPRxPeKzoh
	8iQX1zLI=
X-Gm-Gg: ASbGncv5z0nQcxotmW3DrO5ynK2yDM30i1u10fO2ZoWTSB/UNgwcyYTu6cYjjIFt2e8
	q0gF3D5OtCcuKx19WTMtT9O0kDUPtiP0F/3Ysvq/8oPhju+NGy36JpbjpikJLASl1aSbegmEtmC
	TJQ9R2eUcPR45gbmvILiDsJIbWBnnYNJ6V9E5VeylcBGiy3vyG+gJuIf6BAblB1m/FZiYDmD9qY
	4DJnPYBG+Ytywv605A2gT0j/U54ELMcZOw9edts5RX2EpQRQM4h5s/irEGjkb8bcI+yW6OhN+Op
	skXZB024Hr1TLVqPo7mwzNu8rFZcZhiCEk1dWOfkUnMesf8NN22BxQGccZ2Pm8GLrMvqjJ31eEn
	Ikd+wx2jiR6Gm
X-Google-Smtp-Source: AGHT+IGmlNnP64MFWAL3+YAV1n7vQLupS0xRegglRx+zdUNXiYH/ZN2ATI3xu8dtOFu50jrLXck/iw==
X-Received: by 2002:a05:6000:2187:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b5dde3f94fmr2198157f8f.12.1751974492420;
        Tue, 08 Jul 2025 04:34:52 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:e07:801:a08:6480:3e01:6cde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285d3bbsm12900668f8f.96.2025.07.08.04.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:34:51 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 08 Jul 2025 12:34:49 +0100
Subject: [PATCH] fs: btrfs: Do not free multi when guaranteed to be NULL
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-btrfs_fix-v1-1-bd6dce729ddd@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFgCbWgC/x2N0QqDMAxFf0XybKGrDoe/IjKSGmce7CQpMhD/3
 brHwz2He4CxChv01QHKu5h8U4FHXUFcMH3YyVQYgg9P3/mXo6yzvWf5OQxtJG5xajqC4hMaO1J
 McbmLFS2z3sOmXPz/yTCe5wUznzn6dAAAAA==
To: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Qu Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>
Cc: linux-btrfs@vger.kernel.org, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0

multi is guaranteed to be NULL in the first two error exit paths so the
attempt to free it is not needed. Remove those calls.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/btrfs/volumes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5726981b19c..71b0b55b9c6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -972,12 +972,10 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
 again:
 	ce = search_cache_extent(&map_tree->cache_tree, logical);
 	if (!ce) {
-		kfree(multi);
 		*length = (u64)-1;
 		return -ENOENT;
 	}
 	if (ce->start > logical) {
-		kfree(multi);
 		*length = ce->start - logical;
 		return -ENOENT;
 	}

---
base-commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
change-id: 20250708-btrfs_fix-a24cbe4ad37b

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


