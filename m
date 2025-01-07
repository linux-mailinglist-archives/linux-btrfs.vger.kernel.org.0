Return-Path: <linux-btrfs+bounces-10773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2CEA03FC5
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C434F16706C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B8B1F3D34;
	Tue,  7 Jan 2025 12:48:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95741F2363;
	Tue,  7 Jan 2025 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254083; cv=none; b=jRDhyUL5cws7urLjNULrHEbSqON2jZs/8Jcd8bty9YqeNpOX5iGlBxmhjreLJe+Oo04SqC40FhNanlz2+it8wtyqUTwSJOUgWu8JmEo8cjQfLKinU4aFoufzeMEcybNQqbTGa+2mPaDnPo0zg5Adsr8Ba6LFMwlmJpIQR4M/ZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254083; c=relaxed/simple;
	bh=kxPheXsGcgr7C7bmW2sFDIN+8yZhU6P18+xwCuVRn3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TkOCzfSGFLIJi4WXP7RtFI0HMX/Gax4QCPJNnSy76hBRFYhTjYKKOq1zM/4Cx/gkUwQVKn/Xh8wxRbDF4BOvdV8y8vUlXvoYDUJchHtxl/GaT/m8GO1VokrAH2jM+Avbhp/nAjy6tJG72BVX7cacyyxVMWWGaWEkMiASY+69a7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43618283d48so111997155e9.1;
        Tue, 07 Jan 2025 04:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254076; x=1736858876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4qxRvmfu7+JXk512bdqWeZXj/ZLfnbrQ2mO7uJqnjk=;
        b=wg9VI//s2IGO8qtOAaQFjNgKGx5fC7407lYh9jg1KcAOEFC82WFPiZN7rgb3rp8euq
         6xAQsdjSkLx8yqbe62/iASrFgz6sQeMGDK9mLclLbwIbhm/Pxci1s82Vrvo2nvMN7b5M
         2FPKF95Usr2NW0PSFT7a9GC2mD3lLnqYkL+0Rd34a9r05dAz1BuSkqFoH2JqNsAWTHbI
         rx1LmdvSlvZnH66N3N2tbBNEPLChspTdt1jukme5x8HCZh5I1KhKgPGpjMLhwkDusHb8
         fKIPVn5UVpGYJdvHYW3Kd1mOO9bPbzhWt5aJAyq71JqKQMRFJp6ph6SP6HMWN+PMSUaB
         WYWg==
X-Forwarded-Encrypted: i=1; AJvYcCXnNyNPTt3o2gLmn5RJl0TncDKaBQ8pQcEkhzK0Zp5kQMAWmukPG1NEgP0Uen0r+ZvZpvaG1bnpacX6Or4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSvKJxtuiJp36XTgAXgVpkT8qdXMjNEetcZ51m7CzppdtKk0kq
	aQAB9/f10Q116+JYb1Kb5HvCnbuuPFrvaoNq8Ir/Xec4MMWJQNmS9CuUWw==
X-Gm-Gg: ASbGncu11UINsJ++3AGe5QgoOy+kXAuAzHuVcBJvS0dLY3qGqdXDE5mxrmm8fTRvHWH
	v28b2pczWBbOO4whlQunXEMdCeKRE7bC2grJGxf0ngMkwHNGJHQhWPrWbNjzlgLqAH1y4miquT5
	fk0FetmWnmaEikF+EPTubKxHk2b9tXrBAMA+nNMGE9ZAQmwFLNonUe3Dqlfflz0DoeEC17v4SEO
	0uZOgvQWgyv/MUBGIQ24cjjWocybpJCe/BfLJJNbIDHoK0AzcisLYWK05s1XAGkRj71Q7LF7rWR
	Y7J6anfWGATZidb6c7LuYitfPVn6nuFqZQpi
X-Google-Smtp-Source: AGHT+IE9aeh4Lr468eG0o0wsJYJS9hFeRSanSJtFDz5kmozzNdydoBEncfl1ImRPq0B9/+Re76OD2g==
X-Received: by 2002:a05:600c:a0a:b0:434:f0df:9f6 with SMTP id 5b1f17b1804b1-4366854737fmr553050555e9.3.1736254075828;
        Tue, 07 Jan 2025 04:47:55 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:55 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:39 +0100
Subject: [PATCH v2 09/14] btrfs: selftests: check for correct return value
 of failed lookup
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-9-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=jth@kernel.org;
 h=from:subject:message-id; bh=Hai+FH+wlQA9jUF34rKWHq12Hes2Et4vpJtRh4PDbc4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhUmSlY9bWWNrfiS6bG9QT/zw8XE4m51zkq3/t2Lg
 uvmf+7uKGVhEONikBVTZDkeartfwvQI+5RDr81g5rAygQxh4OIUgIlMbWBkmMqgv++vu9PS3zHP
 pdy17bn3yOypOBaTUlF6pEday6j0KSPDqYbytcVn09h3bBXYF3kk/l/k19NPv4myG3zYeSnJxP4
 vIwA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Commit 5e72aabc1fff ("btrfs: return ENODATA in case RST lookup fails")
changed btrfs_get_raid_extent_offset()'s return value to ENODATA in case
the RAID stripe-tree lookup failed.

Adjust the test cases which check for absence of a given range to check
for ENODATA as return value in this case.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index f060c04c7f76357e6d2c6ba78a8ba981e35645bd..19f6147a38a54f6fe581264a971542840bc61180 100644
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


