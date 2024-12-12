Return-Path: <linux-btrfs+bounces-10297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E769EE0AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1678F282F3E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112420C03D;
	Thu, 12 Dec 2024 07:56:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F0D20C005
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990163; cv=none; b=UDgrUfLYK1VcpkkRtu5cyBBIvAk48SNLkdnpkJAPXP2U5XlsE3uM+IC7yBBaoHrZlCXj7byzWcX8S3yUHoHJXHlE+Zs/cZdQCqYY1Oi5PysQctb3gzwhCiWBJ9Jkaq/xevaOt8fyijE6p9TVR9saKdhpFfeTHzd8Ll6NaKqTpKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990163; c=relaxed/simple;
	bh=CbHgCjSTjEV1L+IQnWjT7hcGVbYX4lbV1ysAMVDYJS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEa2onMFQcXZtTdxy0WcgBr+gZWknIDrUgFR2OzmXjTyd6Vu7Xk3vnNdV3+CJD5vJ9/aFHO9RimNnE5SHijGbm5HPNxVz+ObLQlNfRWa3Dvjbbm6p1UO8MXlmimO4uto6jkFsTIo3+Hc7+/g8zFedZgkrEEDMcir4lFueYNx2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa662795ca3so287544066b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990160; x=1734594960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fKnwTDnFI/1sBQ+A4p7FY1EVfEWjujAuvSIFfiJIIA=;
        b=HKjUrs09W1xiL1pRfUdVmWwgLDfFBpYRfLY489+C+c/FOy4IB4kG6g3b3J5Zee9YBA
         UQxnxVUy4orp7/NN3oyMc+OCVd0Le7/aRiPDgXIXVyEpEHLAvgdaGpFmtXpICEQKq8YZ
         bihFdte7nKwUbuSFJQri54YvjyhczViEtxnu/OX+pmClb4POvzBn8kWjhfxns/KSNa5R
         swF733NWMHgfylec8Yj4pZowejOUK54M47YpIoNGGKjnR372spP7zksZCPi5BaKN/tIt
         2KjHzGoKg87Du7lvOZNVm2sdel1G2Scc5AUXbZduJjb53vIhWRkJ288jHqhEpuldManR
         wiyg==
X-Gm-Message-State: AOJu0YyXzWMD2lM4lF9cDK8/5sD5qwvB0wMB0PsOGh5GXUXsyCXblcLw
	SI/t+0t47/YUsnuDB0LeJZ3kb2IxSBELlS7xgblaiz2kIWvCHR4uYk9pucqP
X-Gm-Gg: ASbGncsrr/TBTyWJiEgjetC4ayCOmW5deThAyhCjf++YaEZSCBbZ847XvoHCa9CxFE8
	vNKIZxgk082elwaGoSta8Lf4m1j1G1QX6+CLNovujkheHrTOo6xRQRGLH3pf13+qUaYUbaLhjJN
	dP+ud0Thl2u3VncOWabl2xcA9o46KBTKW54LcpPL+/DMsyVMgl+J8EQaz9FYGTYpIN5t+TkeYJF
	kLlbZU9Eyv1dly4cu92LIV6b9skmHTPbSQri+hY9O96heK7/wkwggcSFA545VqcimzKW08XK1sV
	HOdhE8NVo7XjPZ8hqwwyAAjyYjVNAZHnnzVdSeM=
X-Google-Smtp-Source: AGHT+IHOu/UF4F8CMTM6ehHDChk6+XqSoiVUQz+3Ukn20QUGsDsAS5XtYdTbBiMpnoOFcU9/YGAshA==
X-Received: by 2002:a17:906:9c18:b0:aa6:54df:6abf with SMTP id a640c23a62f3a-aa6c4139005mr198838666b.18.1733990159698;
        Wed, 11 Dec 2024 23:55:59 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:55:59 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/14] btrfs: fix tail delete of RAID stripe-extents
Date: Thu, 12 Dec 2024 08:55:24 +0100
Message-ID: <93790ce532e9e18fba57268a6230ec312ca38360.1733989299.git.jth@kernel.org>
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

Fix tail delete of RAID stripe-extents, if there is a range to be deleted
as well after the tail delete of the extent.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 092e24e1de32..6246ab4c1a21 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -121,11 +121,18 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		 * length to the new size and then re-insert the item.
 		 */
 		if (found_start < start) {
-			u64 diff = start - found_start;
+			u64 diff_start = start - found_start;
 
 			btrfs_partially_delete_raid_extent(trans, path, &key,
-							   diff, 0);
-			break;
+							   diff_start, 0);
+
+			start += (key.offset - diff_start);
+			length -= (key.offset - diff_start);
+			if (length == 0)
+				break;
+
+			btrfs_release_path(path);
+			continue;
 		}
 
 		/*
-- 
2.43.0


