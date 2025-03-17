Return-Path: <linux-btrfs+bounces-12326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5D4A64C70
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 12:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2980116884F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 11:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4FE2376E2;
	Mon, 17 Mar 2025 11:25:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E9236436
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210715; cv=none; b=LhLfnAuIbANA/nhKjY0wNYEC6NWa0waxLoUCrzzkOkcXr4auepkEphN6lndaat3x0GFRlhcyf2Vmzh8v/Otc9eXznICopEkjVoqxEHw/Vrp7cTMquK2Udju14KQlezMG5Q+uwUQ2TQ3jWrvkbkdaQvtomf+yB9Yicu+3eDJeuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210715; c=relaxed/simple;
	bh=qi7VHB8UAsRcO9WqNQuT5FhbFUG3E5EP6F0/7Wloljo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qi+b9sYTYRZFwzRIDjVphoAz1iKT3hEsREG9w7C+12pIfQI56X2vwN/neoxwUBLeWVLfIZa7n4dqk62eCaovWTOqNp7kfJr/DypkzBnD5HwIDBAD/v3Aj2cWTOtGZZ8o4fIOuMzF1/DRXB1SSkscFioq1W1CV3CnDSPkUCnXpYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43948021a45so21023465e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 04:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210712; x=1742815512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhjxRerMIcX2nnI7NwAcm2gGoaocl9fCFjyXyIfHZAw=;
        b=Jhr7I4drwlVZNfQe41xCS/dNViK5DoooFKG8BcXxnhXPr6ktLVr0I2APyV1UoQMxdS
         4wvZf1AVZzIFMJVKxnqF3pMvbMmP8F9vEUHUbjLDOJh7JsqaXWBwie075iWICs3Kf1sU
         pyw8KrqWfv+A4rvwQQOuybzsJzUFfif24FgmrdC0KUTSKiXYhFJ8iV/SpuX1mEILqwV8
         8F2smRvf1NQTxDE893EuVSopWeMY95jtK92F7SQXa4wCYQMv6QLm+z4bW6UAxQXUE/yL
         8lUGdA+Cbe2KZ9q6cJJ3IlwRrFspFAKXRZFq4WKwaxVGyaAPAroS+QvbfVZKBfix81aR
         R2Nw==
X-Gm-Message-State: AOJu0Ywr+AkT0gWYCKCbbInfFtz+YcorVo/z5kOGIYeeOimbzxapu8g0
	6DCQu4CYrxkBRzs5C9TjnHQrGvRo+QOI8aM7dAia3nU6TDKtC/13XzBZ1A==
X-Gm-Gg: ASbGncvc/6u4uOa66EFCTF0ZWpugfmhO/RvNALe9Gf71081aHnIPkG4DmLEilz6i89H
	DTjk62co/HyGFh5a0EbbidJQS7EQolCwuKJMNCadQLCK5y5Clt8L23JG4Jc2U8CIdNmBOT3MQlE
	7xwGMNBC+M4KaF4S/yyEbgVUN8GCOOKF+kJArbQJKLC3XTdAM/H0IiF91fqTmcfrEgkYGrCAlJL
	ElhlItOER+LRGGUO9+DVaqInY4KeRL730+wJUI6VgybNMgVyCU3xuI8u+2UEYuAGVLWc1FrF5Ev
	0O1W+EgqE3t/VmubQUeKYWf5iO4t2jcS9+9QrLOLua/RgLTHKrisGEq+ox6053Dqq0nOnzvrvte
	2MV1zIwOhSInMe5+8kS8WrpMaL0VOgcPOwYryYQ==
X-Google-Smtp-Source: AGHT+IGIijIGDwhio1lPeK3Q1uDVF4gxxain8MNUUe8X3319+5U8XW0+QMV+O0MV5EN8z6cda5SrNg==
X-Received: by 2002:a05:600c:470e:b0:43c:f4df:4870 with SMTP id 5b1f17b1804b1-43d1ecd0eb5mr109681035e9.25.1742210711660;
        Mon, 17 Mar 2025 04:25:11 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71d1000fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71d:1000:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fad59sm103188675e9.26.2025.03.17.04.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:25:11 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/2] btrfs: zoned: fix zone finishing with missing devices
Date: Mon, 17 Mar 2025 12:24:59 +0100
Message-ID: <bb295448aa49bf3ea08ae7244bb1b3d044e711da.1742210138.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742210138.git.jth@kernel.org>
References: <cover.1742210138.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

If do_zone_finish() is called with a filesystem that has missing devices
(e.g. a RAID file system mounted in degraded mode) it is accessing the
btrfs_device::zone_info pointer, which will not be set if the device
in question is missing.

Check if the device is present (by checking if it has a valid block device
pointer associated) and if not, skip zone finishing for it.

Fixes: 4dcbb8ab31c1 ("btrfs: zoned: make zone finishing multi stripe capable")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 8924f58919e8..7c502192cd6b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2274,6 +2274,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		struct btrfs_zoned_device_info *zinfo = device->zone_info;
 		unsigned int nofs_flags;
 
+		if (!device->bdev)
+			continue;
+
 		if (zinfo->max_active_zones == 0)
 			continue;
 
-- 
2.43.0


