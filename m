Return-Path: <linux-btrfs+bounces-6872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8421940F9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 12:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82C4286B3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 10:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C31A2577;
	Tue, 30 Jul 2024 10:33:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A061A257B;
	Tue, 30 Jul 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335610; cv=none; b=d83lXoQAi87PqwR/GPwDvkCnhPPm1yVvpQCh3CZ4sbxNy+pWF2gPB95D3ppZ4tL6BXmx5M4/IsFqkFGwexg/3U4xhswGFQ8dEgZ7n2PDnF8+XMc0bjL7rjCo0fmDY0HfpDBXMoHpUBm+iLS9bJWOgYqRhmW6EMhREqvqEUa046E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335610; c=relaxed/simple;
	bh=yOFE4cthNpKAw1Wf+HIS6SvopF2maYH+CgYnhjyzGGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V4CnIygIH30n27NTK2pBngaWB8gf6Ec4YvFYopP3qlQcLP7PJte9smTLPkDdyFe89/yMY33cZlIxcV6vU5KBL5MGYk6cnNKom2m2eOwuTHk9IwRBpu3SThyFPZiXMZoRmp4BtDyTFGAbelB2/AwpGd9JAuCp04nUE5nwAl82H/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so606802866b.2;
        Tue, 30 Jul 2024 03:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335607; x=1722940407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaFTL1duU5GueP6k8bggejkXYESAFbdWPOLFrsucxBA=;
        b=MrFng3Hwg+lRRxARXsykX6zbk5DZrqWCSEgQaSA7pSx3jSD5sz9st1bdp2bz68vR/c
         dQgy7NII3f8e768BzRIU39MlTt9sxPPKBl74a9XLeA2PHqQws3Zif++JCJ7YYgD4/l6W
         Bm0mrvth5Spn4iYSADOpBXzqLzVYkKVc/nQHUxu7YjQD8NvBPdQkKQzfirCFG604y5AM
         guUuF+OjakOHDybPMl0ZtjKeMmbVhxGy7++Uu76CDUVa6IwhxOcJ5CzIvCI/qVbU6Csj
         8q1+5wQG3Qz2YhL2R5NzSCSIFxcovdDtaz4XRxrGgQ+29Wg2WirwV/6gEDUq2x9002W7
         XgQw==
X-Forwarded-Encrypted: i=1; AJvYcCWDu8fijTCjOq5cZum0wHTlxvLuXsH0eoeYy6lObBJQ7BCpjKpxopD6Bij0TV37SDeWpfoLhG3GkUvH/Z2GccFD6G2oTWKrqTjiPsZ7
X-Gm-Message-State: AOJu0Yx0JjFNnXv4mzuEjT5C9rTrusywrpG3XiFPPYT7aMAbVsw5Ssbz
	iFtfCz5GR6Mz3WiD2HkgCtpfW5NWNeSRMNzEk8o5SZ6tKZyZLw8y
X-Google-Smtp-Source: AGHT+IHRRUmXvR3WWPVqOcTceVSq3FWDHM1Sc7Qnyw/GDuk1HhEJ9VLDJxXOztwOLL35Bn+flWfeKQ==
X-Received: by 2002:a17:907:874c:b0:a7a:acae:340e with SMTP id a640c23a62f3a-a7d400744bcmr665951266b.26.1722335607401;
        Tue, 30 Jul 2024 03:33:27 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9f60sm622455266b.223.2024.07.30.03.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:33:26 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 30 Jul 2024 12:33:18 +0200
Subject: [PATCH v2 5/5] btrfs: change RST lookup error message to debug
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-debug-v2-5-38e6607ecba6@kernel.org>
References: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
In-Reply-To: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=jth@kernel.org;
 h=from:subject:message-id; bh=5Nb2TPyDI1r9k9JWR1KqOfBjfmC0JElmTsqSFizt6aE=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaStOFhwLfDCms/Vc9Z0qT9m4OTjn/bu41vHGRyPDRnOn
 FD4PkF9ZUcpC4MYF4OsmCLL8VDb/RKmR9inHHptBjOHlQlkCAMXpwBMJFWO4b/Xs/BM33323zeK
 Xi7vF16w8F9z2oXHO7j2W18Vv36woWIBw39/z8f/Jj7tffGWeafHLPsZ7wSvfb8uPZOrz+TaLuN
 /1v8YAQ==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Now that RAID stripe-tree lookup failures are not treated as a fatal issue
any more, change the RAID stripe-tree lookup error message to debug level.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index bfb567f602b1..a734e25a6a55 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -284,7 +284,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	if (ret > 0)
 		ret = -ENOENT;
 	if (ret && ret != -EIO && !stripe->rst_search_commit_root) {
-		btrfs_err(fs_info,
+		btrfs_debug(fs_info,
 		"cannot find raid-stripe for logical [%llu, %llu] devid %llu, profile %s",
 			  logical, logical + *length, stripe->dev->devid,
 			  btrfs_bg_type_to_raid_name(map_type));

-- 
2.43.0


