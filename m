Return-Path: <linux-btrfs+bounces-10929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C937FA0B294
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 10:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151A03A34CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 09:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FCF2397AA;
	Mon, 13 Jan 2025 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY5OvjMN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21566231A28;
	Mon, 13 Jan 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759932; cv=none; b=r4lRd8c7zjcKdQmvjVeG7GcHsh6Te/E7NL/cXnr0ajhbu8hOkVJ7zf7IeKsTkx4RD8cR+buiNWdcMh8wp7sTg1vlojuZLes4OKEQbvA6Cs3jeFvO9IVUbop+epjxFzFiz6rgzpFiB1QyX67qlkjUecpgurJaAVSPaUg9ObGaFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759932; c=relaxed/simple;
	bh=Qz5v7zUdXm6F9Dl4ST3WqxsLsQQUTe0zwXZNtSHnwEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P/jY3NgJVBxs9H1DlGK/8Pk1+zb4YJSa3D0DXd1Ic2OwUmlOTBHpYoQ8BfPQz+ijAZ+n7XValvXtlW4SoKFrhlMudkEZpV/WH0iJJnaV7J+hHILGuZ5YttMXGklsBNa0bcOgPVlg42tuWrhPnquSY3MREw1lkfEpvwJwpOs+39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY5OvjMN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso30616925e9.0;
        Mon, 13 Jan 2025 01:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736759929; x=1737364729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RFz7BQwkqoIfde6PnfDrbiIrjAkh9YEAo2vYQz7ffzw=;
        b=VY5OvjMN1GqM5SGvlWz6DrEGiU/VrX1jmEhJN5NVIx1ecqZxl3VEkVbvv+r4ae+TKI
         fjodnnSBJmh0/acuo1q3vluKNwULucDN/aa81H8oHrClqUrriAn2x8WcJmzc3aYDHIVr
         XToA8H7EcaH+yf+oCAhsWhF3f75xBTx8Kt8ojuX//ehIFigxlAnuhIOhYc5DfgZZE/kL
         2jJKlMZmupZ8eX20+UkBSqi7GBNLwVLMmVixbeMEcOpR+oc57Z8uXFVuAU5rclcOlWzq
         si6o9GeHOuwyW9SiwUXIur2Y8J/xcrDOUZxJdZ1vyUrwW/JRq0EUM7c2ndXnrq8Q5SpP
         ARoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736759929; x=1737364729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFz7BQwkqoIfde6PnfDrbiIrjAkh9YEAo2vYQz7ffzw=;
        b=s3Yg93Q/FXJpo1xxKZ7kFI4iRFu45/e8M4K1Fiycf+EumcvFrbA0AnT0eKlAbxgNe1
         xw+mNqk+FM0rODD+fKk9znD+fZQUYxI0JOtkwy29hNjKf6d6AfXRrrXHctjqzE3emFpH
         etmK6Doz1G4hku49+Z5/TXp7RBC7zdSXhNwVzpZmQ+1vdEvCA0t3+6Wj24nVq7wb9wny
         0sZD/sCB9gispsz0tke5ny9zkmfAozOZ05KvPb8aKsLljVmrujxEum5fc5bPecxbDL0i
         QXgBToa4d5sE7dEljSH+0p75dpj8Ei9/j9s4IZxhgnBtEKz5JsX1EPEBu8KOONBUL+Yy
         aWrg==
X-Forwarded-Encrypted: i=1; AJvYcCVbt5Q+I43DXCrxJMtqBaK0b34rrivVXBZTiH9n/Vv9UC+TNrCy0BB1akkiKdNLZJxrbXpK9k+XUtBlTOBG@vger.kernel.org, AJvYcCXRJq630AVbC4yUeMQbh1sVtyB8e/7EyvWPfvzUwjJdiN1WiEAb4E1HdvJEyMRi/emhn/OQvb7pX0MN5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRWwd+qzfQLNE0airzEUAqATFwO/tU5BrvM7rshEEH7GR22dZU
	7ros4SkWvHKd0Qy7xSB7IBO3hYmxFn1fvXSiWM6JZv4D75eP7MzS
X-Gm-Gg: ASbGncuxC9rJZWH+UPESqKJRBCLQSmu1tVxV71ykOsQV46KezAnkuBvicNKe1dlJtHl
	s2B+URXZhMpMZwT+L+fBSFNimsTeFElQlLhHuHjjLk6McQ3SlPNLJKLNwFbjDu5hDS35MpGX7Hv
	/MRdeboxYML6QKsEpIU/ifNJ6rCRq9aW/ZPxSjejLWTOocru1YYyI093ev/MCU76ib/VSEQvJbj
	A+C+pV8meoscJY/68nj+pO+t0beNJLENCMWY4f7RR7VfBr6ZEZWGE5gxw==
X-Google-Smtp-Source: AGHT+IGrv/zuAQzERifEkONhQKmLn3TypfML/BeVv/Gstn7ttb30FZOPIor5F4JhgeJ+yUYdbL25Xg==
X-Received: by 2002:a05:6000:1884:b0:386:37f8:451c with SMTP id ffacd0b85a97d-38a8b0b802cmr14946742f8f.1.1736759929310;
        Mon, 13 Jan 2025 01:18:49 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0babsm171070775e9.14.2025.01.13.01.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:18:48 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	linux-btrfs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: selftests: Fix spelling mistake "suceeded" -> "succeeded"
Date: Mon, 13 Jan 2025 09:18:46 +0000
Message-ID: <20250113091846.23813-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in two test_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 6c7e561e5564..6747350a05f5 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -315,7 +315,7 @@ static int test_delete_two_extents(struct btrfs_trans_handle *trans)
 	ret = btrfs_get_raid_extent_offset(fs_info, logical1, &len1, map_type,
 					   0, &io_stripe);
 	if (ret != -ENODATA) {
-		test_err("lookup of RAID extent [%llu, %llu] suceeded, should fail\n",
+		test_err("lookup of RAID extent [%llu, %llu] succeeded, should fail\n",
 			 logical1, len1);
 		goto out;
 	}
@@ -323,7 +323,7 @@ static int test_delete_two_extents(struct btrfs_trans_handle *trans)
 	ret = btrfs_get_raid_extent_offset(fs_info, logical2, &len2, map_type,
 					   0, &io_stripe);
 	if (ret != -ENODATA) {
-		test_err("lookup of RAID extent [%llu, %llu] suceeded, should fail\n",
+		test_err("lookup of RAID extent [%llu, %llu] succeeded, should fail\n",
 			 logical2, len2);
 		goto out;
 	}
-- 
2.47.1


