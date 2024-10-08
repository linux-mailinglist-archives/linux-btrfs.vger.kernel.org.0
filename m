Return-Path: <linux-btrfs+bounces-8632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E07993BC9
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 02:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0F01C23DE5
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 00:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D9DEAD0;
	Tue,  8 Oct 2024 00:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd8HCBOV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237AAD24
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347325; cv=none; b=CS5yGJdqceCjzd9aP7HSbXkePhhi1gYOPu6GouJBnfqKxj3B2E0aN7fDKmkzSDP6MzRZjF6dQSycpgT9MdD+6pcRiSufH4oNhi5QZg5bqHcSdoBNTINqo5wl3eBqTIeoGKJZxGv9czt1IWmIFfa616pIVMAF22EWnVFwa7RSnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347325; c=relaxed/simple;
	bh=yGVx+6IsFC4X5rLjroo099GW2HO/SYUKsVe3Icz7Sac=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4xBmrNAh6hjHRaQFvp6U+tYFSTXe4raA/pHfstR6C8dODfufW+dQSrO9n1SW2xLHmKsytBwySmhqScmWiOdAfiwtsEnyFVOyYvB+n6X5+RzLp38ySKaxh8XSGmu89zjSjRzunI1H8Ckj8Il7zy9E9+QQN+WGrfSe7xUFjNfCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd8HCBOV; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20ba733b904so49503155ad.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 17:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728347323; x=1728952123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFAdmzEnV3i1fxUaclUOs9yaWxIhH+cg4GHI/fQaUq0=;
        b=Vd8HCBOVG5lg74IpozUIYjmHz2GuLCJkri1c26CrtB1LRR7cFSsZ0v9GWS7eVmyklO
         1fqpdnyiFwUmEpe8wlueCiUkbMzB1+/kn2ozCifqV95GjIGPZ2YcoFILrKYHPl54AW7o
         bl+xADRCpzT80aUjsmewZLWN1W9ryLhuN40tBcm+JWWYItC0lq5pZmMoGRKrPBBZvoHg
         R+Cjyp+NswIjIFqzIODQpUQ8faTeO+txHH5b3zi17gvn+y0eu0GJtJsJSYORgbEzQ40R
         +I/rkBSakuTkesxSdxs+JCKd3n8wimPjPDEomWb4g/Zam0C8//+KWi2UfO8PeJRn2fju
         XVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728347323; x=1728952123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFAdmzEnV3i1fxUaclUOs9yaWxIhH+cg4GHI/fQaUq0=;
        b=XFxblVlYQisZL0YlG1APNFDmwv9/q6ytTA8nn2Kw0fK/cCn3QJgtvF105myG62Qy0y
         xwjN1BvvmRHBlzqXef79isrjm0jA2OCyb15McMi1bS7NEjg+OEFnumKG3W4rJyglAigU
         ACEtixuFJDoQkT3/Mq1TPW9W3kM2iEe39PL3AOEyodiPr0p515Wf2K1AXLynxwgzHR7T
         SrUvGS1f5nri4TesZs7BtigxNcY4dXijy127wUHFc+zoqpr2hGbQiFT4eK4Nz3YBd0+F
         OoSoCOn4/jGJKHBoMKNsEAiiegVtSYy7ghelIWsbHBCbDMdsYK4dK6EgCO8Wu4QkJV4Y
         LZqw==
X-Gm-Message-State: AOJu0Yz5gbwWehTsNbRgQ19+OMjLPnnh06YvMq/EYkoNq0ur35lJvlt7
	IlpcbKHBO5ZKrEqfq6TNM1rHAteGJqOn//3ZQpqRU9ldePham4SDKQ+Zaqgq
X-Google-Smtp-Source: AGHT+IESsDO1alKgNd7gRd39MgzVS2wXsJ0ahvgcptnOak186V2xLE2Xhj78NbuEiT0Up89zjBVY+w==
X-Received: by 2002:a17:903:1c1:b0:206:c12d:abad with SMTP id d9443c01a7336-20bfe04d596mr192489925ad.34.1728347323114;
        Mon, 07 Oct 2024 17:28:43 -0700 (PDT)
Received: from localhost (fwdproxy-eag-115.fbsv.net. [2a03:2880:3ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13934971sm45416155ad.150.2024.10.07.17.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 17:28:42 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 2/3] btrfs-progs: check free space maps to block group
Date: Mon,  7 Oct 2024 17:27:47 -0700
Message-ID: <fe95778b1f5e29c035720ca7c02946fde25dcbb2.1728346056.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1728346056.git.loemra.dev@gmail.com>
References: <cover.1728346056.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that the block-group that is found matches the objectid and offset
of the free-space-info. Without this the check only verifies that there
is some block-group that exists with objectid >= free-space-info's
objectid.

I have softened the language of the warning and included instructions on
how to fix the problem. This can be done in a couple of ways:
- btrfs check --repair
- btrfs rescue clear-space-cache v2

I chose to include btrfs rescue as it is more targeted.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
CHANGELOG:
v3:
- softened the warning and added instructions
---
 common/clear-cache.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/common/clear-cache.c b/common/clear-cache.c
index 6493866d..6b362f64 100644
--- a/common/clear-cache.c
+++ b/common/clear-cache.c
@@ -165,9 +165,16 @@ static int check_free_space_tree(struct btrfs_root *root)
 		}
 
 		bg = btrfs_lookup_first_block_group(fs_info, key.objectid);
-		if (!bg) {
+		if (!bg || key.objectid != bg->start ||
+		    key.offset != bg->length) {
 			fprintf(stderr,
-		"We have a space info key for a block group that doesn't exist\n");
+				"We have a space info key [%llu %u %llu] for a block group that "
+				"doesn't exist.\n",
+				key.objectid, key.type, key.offset);
+			fprintf(stderr,
+				"This is likely due to a minor bug in mkfs.btrfs that doesn't properly\n"
+				"cleanup free spaces and can be fixed using btrfs rescue "
+				"clear-space-cache v2\n");
 			ret = -EINVAL;
 			goto out;
 		}
-- 
2.43.5


