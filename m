Return-Path: <linux-btrfs+bounces-10853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9349AA07B8D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21586167F83
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67721CA10;
	Thu,  9 Jan 2025 15:15:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08A21D58F;
	Thu,  9 Jan 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435725; cv=none; b=tf9Z24wNHxelwW/6T31EAKChphxUQtOF3shxqbSGN1Uq0iaNfn5mlhPaUvT4TOPhVhjc3ckvy0285CZtfj4Y/Tgg5rSu/ge9jX3T/pM00BuSmgDUvbTQEYgqfYwQ0yUhidvb6jRp290RiGHGp4j49Xi+wMjU2m+EZK+pjzrEUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435725; c=relaxed/simple;
	bh=dr6eMa7aZX3mdAc3Sis8Kf7XJi6Q+T6fLGYjF8gg0FA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J8/hYHCs09PyVPC0fqEhjayOjNdvXmg/UUYiprfol3pb3KHnf/YmzDSZOFkgE1PkI0V8Frnh9cCfzN+WHDmnZ9aOqFI4azzkDj7Akf5TEZUrp6PX9sEIwSRS8b9aTYMBSoz5R4JgCrcZjtXCPPAkvxiXThBCVgveIdoxiu3jAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa689a37dd4so196559966b.3;
        Thu, 09 Jan 2025 07:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435721; x=1737040521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiVBZyMEPUj9kKl+Kgc4755bAqGr6clEU+UsodEl16E=;
        b=dDRAog8FR1PVS6CvJkdEiwBHY/0442CIcMdILW184+SnWK02PSfKKLyUQy7SY7O7FM
         wyV5+b8IJWF9B4Z/UVMHmZldVeghJpcQK48N7EPnvKkR72ibgSRuF8V5VtRD8NwdEVmr
         zcYMHQ61f3ibRwqn/Wb+eAKfSGF8odxIP0rHRsEChPS4KImcKe7DK6m6Lhu3wk87n5zT
         BqE/0XabQTXrI6DB53kMDrsbSE/LDtSovTNrTSJfw4xe6wP49QSUPEfCKH3rA3/Xya3L
         gjCaNnPtsDaMPI7tMZkAZuA8rQt9KKDTrH0Q0Q6V+FtVP/2H7padXwOkdI04rE+NnYR3
         yrYA==
X-Forwarded-Encrypted: i=1; AJvYcCWcqykb7l1crBFxKUfdWRLkHOrZOi3yCgD74B6L53Z5vJDNfKA6JexfLUr94Xxhwa0fCClMoXEG/vrxl4Lm@vger.kernel.org, AJvYcCXwpDKbZ70Qit5krqjBnf1N4T7WiUdlrUuCP01MdV2rFhU32qsXKhqafaR4e3xNsFKRHv9THJLLlfdonA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyE8SA2JLROl5Hi1BxEZYbHnwuxUwjW0rDUdWpkyLSa7CrsNXe5
	rK3EAoHfsAKKRqDpn7q8zhz/A77eCX7VFFneYRGinOzGIbR4zD9Z8zpORg==
X-Gm-Gg: ASbGncu5N4/XOedtuD8eX77R4IWUewXd4I3zR6xZt8kv5xHmgIUJdKWITishkonmjdA
	UB5/o6VpKT7p6hvpOFGiB3CHx+7DQxUJRhsJIatfcD0wmHCs8Lhm8W+u27O9UpKvfr0cmJRZ++m
	bHhp+MBD4SwBAYAmf8rKZUnCzZNAsf/OOIjHlpVeqeyBq5cDRkHWLCYg1wdq2HkRtO3kiqRr+nx
	RD9p+8y1t6xvDAjYQUqyCWcsjRGF2DV7UxQGWwjVxLe5mYhGTwI5iKd9u4xMiscfNsDRCR5pFoV
	pMFKnZS6tJPidLkBCTNhEyCOPK6hmEfnni+n
X-Google-Smtp-Source: AGHT+IHjxecBjRighX8BRJMdLZbfV+1eK30ovPOKwEscHs1H4qbEiz19Apl39uMC7fxJ1nmIksO7Xw==
X-Received: by 2002:a17:907:809:b0:aaf:117c:e929 with SMTP id a640c23a62f3a-ab2abcb1440mr641283066b.57.1736435721412;
        Thu, 09 Jan 2025 07:15:21 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:21 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:04 +0100
Subject: [PATCH v3 03/14] btrfs: assert RAID stripe-extent length is always
 greater than 0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-3-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=jth@kernel.org;
 h=from:subject:message-id; bh=5L8Yr+hmUCjhksYmwhWau8cY2+f/Vjr1c4fw/eMouPM=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2BZ09hwX+FNFsu2/vtm061+Scr3rH17qDawJFBD/
 rWguMTjjlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZjIX2mGf9aM5o4X9DZmsP09
 NlXW9pq3+Q7fBRtlhPsXzBA5I8pznIOR4ecs66+z2xN/5l/OmZbqKmtzL0Z/n8h59pgHcxPKz1k
 HMQIA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When modifying a RAID stripe-extent, ASSERT() that the length of the new
RAID stripe-extent is always greater than 0.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid-stripe-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index be923144cc85a0ecb370dbb1ebeea44269a1f4ad..0c351eda3551efec67c35d76d06e648da5f33c71 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -28,6 +28,7 @@ static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 		.offset = newlen,
 	};
 
+	ASSERT(newlen > 0);
 	ASSERT(oldkey->type == BTRFS_RAID_STRIPE_KEY);
 
 	leaf = path->nodes[0];

-- 
2.43.0


