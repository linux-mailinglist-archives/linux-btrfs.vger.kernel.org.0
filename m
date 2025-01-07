Return-Path: <linux-btrfs+bounces-10764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DD3A03FB4
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA03165E2C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C31F0E59;
	Tue,  7 Jan 2025 12:47:54 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A64D1F03D0;
	Tue,  7 Jan 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254074; cv=none; b=A2906hJWvsIDzYcWpGiGSK7FOcaeCUKSmSfgu8C6bMj5jkMsDFZKzq8eZ4rd5yczlCIsFK8G3k7HVsPR6fxoDu9+EEK4zYP/4hjjSNr3K0fQMpXeUGrsL5Pbwr2GtxaWkg3o7skCuZUPI1JpYW0fp0gYy6s/vcI8deQZqMMllvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254074; c=relaxed/simple;
	bh=GIKHDQhqZDJAYaFHZGrkBjKhlMrRaLC7syejF347pTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b+MPGNPrXtYaGGhDlDCzcQt822wB+7h90bdCQfEQtgyLA7qJM9KC/WgZgTZ4ul3PpWPxWng1+abLzwES7GM4Hh8nKiLZ6DcdIQ47cxXhD0kevk7EES40cxUT8yAuABKD561OT0g0RDEV4q7sc8jP0tW7O1Do64kXTC/Ku5I2Auk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361f796586so159470205e9.3;
        Tue, 07 Jan 2025 04:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254070; x=1736858870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZ+41chn53AePcraYYwzRS0bJwF7+ChOsC22yjS6oeQ=;
        b=T+Gba6HsHvwGY26kGDqYxeXH0zS9Y/scxxnkdfmGyhRyvjiRndXR8QPTgihBj8FcpA
         KbvsJBL3WC0nSbpAozpO7Njyxd2ziyhAyMSDXke3Z69Yw2FNz1ysCrxfE5/i0xpoN0QH
         T7pY6RtUGPHrP0H7eK3Hvj5tBkBUBdcMl0lCmT/Fbn3HQGLz4HqezXyKKAH1aBsrrFRp
         dYqxMo5WeypZ7dkyjqmVvGqfOBW/v2zITIsSYxj71FE5E+vleOHlaeACVQfDrkHS5bsD
         kj224wvQlcSjSMpJLUW3r/Z0Ky8TaN6niUrWnwTbdPt1l4oBEh4IBCA93862Fszxhh67
         T4ew==
X-Forwarded-Encrypted: i=1; AJvYcCVsYb6ksGbrpHFLkV6EdqL0V2hfLjNF13+TBIAz6Mv0Jv+lTzIBaJrpdxNjOgxj1/MinoiBVokm0TDJjWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNcoYmcS+Y7Rw159nzBe60zlh8yqwaJ/2y1ZnwK+KUGHGyj7Ug
	q0uMZsp/c1kxKJT7Lln/vxE4a0u91nlz8dMV5v9z+CCEkKhQg5OIK3/JGg==
X-Gm-Gg: ASbGncv8lZ1pJN8sv+eHS2PSvpDmS+X61RQoYg0gjQfOWj8NtJRjv0G5zER7BD21nv/
	YxR7qICxYbWwNhy+yCdTJ2ly0FXdtRZVNW5PotTAvyR/88QROWT0oF2WHw1zuc2I9RK/q/mvXIC
	J7NG+YgC4k2tdfibjPFQEwdBJsp9BrjohN3jmxIyAJic/0gYjJFtoBYao0LKUNVdOoPgGz/8JDX
	NWbwET9a5bnZnEpiI8HfIpnCxTj4kru8d50Xboc8zfpvXWG0jc344bVCiafy+YuCQWvd/898CQb
	qCik//1M0s7gi8qXou2tOqoVYt3JwdQ98HlA
X-Google-Smtp-Source: AGHT+IF6Pacu9vst++guSQ2z1yKyR2kDw8NVNA/GR542pTf8v9Xkg+gh1FI95hccbvz0fzGKBe/jgg==
X-Received: by 2002:a05:600c:1388:b0:434:f131:1e71 with SMTP id 5b1f17b1804b1-4366854c07emr504368665e9.8.1736254070268;
        Tue, 07 Jan 2025 04:47:50 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:49 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:33 +0100
Subject: [PATCH v2 03/14] btrfs: fix search when deleting a RAID
 stripe-extent
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-3-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=jth@kernel.org;
 h=from:subject:message-id; bh=glA+R11vO1yQhVEHOgoPFPTfxl/IB6/5DfePvcXkVqM=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhVar/m+VEr/EqOAqezjL43nz8dbzC/jjC3eMfVRs
 qPh4rSJHaUsDGJcDLJiiizHQ233S5geYZ9y6LUZzBxWJpAhDFycAjAR4yZGhsk9Ou7nTlz44H5i
 w6rV946yMp4Q+MUWxS7rUv07/nGEWjkjw4v4pTtyms1YZ5/vzvR/N2uTnaKOw2wDP7/O5y3zfDs
 nMQEA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Only pick the previous slot, when btrfs_search_slot() returned '1'.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 5c6224ed3eda53a11a41bffdf6c789fbd6d3a503..0c4d218a99d4aaea5da6c39624e20e77758a89d3 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -89,8 +89,12 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		if (ret < 0)
 			break;
 
-		if (path->slots[0] == btrfs_header_nritems(path->nodes[0]))
-			path->slots[0]--;
+		if (ret == 1) {
+			ret = 0;
+			if (path->slots[0] ==
+			    btrfs_header_nritems(path->nodes[0]))
+				path->slots[0]--;
+		}
 
 		leaf = path->nodes[0];
 		slot = path->slots[0];

-- 
2.43.0


