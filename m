Return-Path: <linux-btrfs+bounces-15582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AEBB0BD27
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 09:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB8217A953
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 07:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0AD280CFB;
	Mon, 21 Jul 2025 07:02:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5395927E07F
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081350; cv=none; b=NBfaIKt6114VzXF3s9NH5MVawEBr2ZWpdXHmX0FB7SaCLOy2apqCTmIU6nGBRhbPbWK7gC3WQL15eYSuEXzoqwqNWuhOIIEos5c7D8w041Ugj6VDEtsbiH7QytQCvu0TdAPH1gb+0u2HEpSebmeBS27zyKb7l19bjyvC/tk+ji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081350; c=relaxed/simple;
	bh=AYFKA3uvP5QzhMRhbDBY8wjFJUgjsXPdvlZQlFAl0Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbBy2Q5dJGlLb3/dH7LYMd9uf+HgD08CzZHUw4LQWaZw1hQlpEq3KEaGk0qIxOvDm8/92Y2JCGRiLB1CDePYmkteCioR/NWnVuiG0L7+nc2XKyCLvSzvRrCYd6HIWlaWK4nNBYeVvZtQOAVYs21K8B3E28/zHxw0uhIuaNwGq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b5e6bfb427so2225484f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 00:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753081347; x=1753686147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmEWK2nS68ep+7oZETJCVMEUnrN4HyYfXYVZR+t0xpI=;
        b=lm1PyGWjx3HFwKelBsV4P1gyKoPeQjLBwkqMStPV3Ob4Y6svw9xKQX94jU0AkDbg2h
         CVECyzoV1+veRMYhm87RGTQmpBO796KRtdO0KYCnf6Bq7+f7nV+y1VE+lP7GRRtSRxZV
         pBubS+A1dAtqLmulvTEWBW4LfziVQtGl8m7rc2ZnBxLhLc9NyYvxirisfqvRA2xTWQ1l
         5uClxqNBRrpJfQdqZcA8KlNZzmNq8l4+g21+MdkBbzksoz1nAhQkELSMeLAMXUx0im5Q
         luZjoVTVBRdTqvCEFtDEDlEyztvntPMSn2Hqah1Oyt2MUlwmy2oZwqZK78Dhapga4Yo4
         +AiA==
X-Gm-Message-State: AOJu0YwLbBNkH+2DzuXoPkeHdu9tCyremqx/HA/tT23BILEmuM/sqpvv
	4nITzgzlhsPDpuNlENx/aN/ZjHxy/SrGomvJ6dIMLP1vJ0eMij5clyWeHZDDvn6z
X-Gm-Gg: ASbGncs0z5UBR+3PxcT1xv14g6+OG168vxUl0gvXCKHdvosaa4M8+ZVO9793HsaAUxC
	Q6GV1yoCDIg9v8H8F7r5FZUBFMPA5BWW7hqLiAWCWRtwfOZ7zvJP9n4TMhZnzJF7HVYcm4EEFZ8
	0iQg6zM/zriOJC/j5EpMw1HXBXJ8rKT5QLmi+dK00XTD0aB+74SUCy9KxqD1UZnpv+X1ucUgspy
	a0jKMw6PW+5QgUasXtsbyDELCR3jj1DvHlLpTPW6I2yaY3PriXrA9DD1KV4nXghXpZzyyR24qz2
	HqmO0NmucppfYqByl8TUxRKOyR5WLy23yGcGdEcvwZFXNORh2zhrT/0YTblw3fH+2oqVySgQLta
	EjkzssC3gFbxV0mx+kEMee9jn2cC9cDyqtFNBubDqKNYiktRweIiBF6gVime1KyIQ43Ic7u5lVs
	GUHf2XhdrkDw==
X-Google-Smtp-Source: AGHT+IGefp4FlvY7cWdnuZ6Hx6wgmzqfSOoaiphd/XygJg2uhbYvOhcPQyA7zyjODlDmVSUOp8hZKQ==
X-Received: by 2002:a05:6000:652:b0:3b5:dc07:50a4 with SMTP id ffacd0b85a97d-3b61b0ec0f1mr8084086f8f.2.1753081347234;
        Mon, 21 Jul 2025 00:02:27 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f71c45003fa4d1e815666221.dip0.t-ipconnect.de. [2003:f6:f71c:4500:3fa4:d1e8:1566:6221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d73esm9327128f8f.66.2025.07.21.00.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 00:02:26 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] btrfs: directly call do_zone_finish() from btrfs_zone_finish_endio_workfn()
Date: Mon, 21 Jul 2025 09:02:15 +0200
Message-ID: <20250721070216.701986-2-jth@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250721070216.701986-1-jth@kernel.org>
References: <20250721070216.701986-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When btrfs_zone_finish_endio_workfn() is calling btrfs_zone_finish_endio()
it already has a pointer to the block group. Furthermore
btrfs_zone_finish_endio() does additional checks if the block group can be
finished or not.

But in the context of btrfs_zone_finish_endio_workfn() only the actual
call to do_zone_finish() is of interest, as the skipping condition when
there is still room to allocate from the block group cannot be checked.

Directly call do_zone_finish() on the block group.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 245e813ecd78..4444a667c71e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2466,7 +2466,8 @@ static void btrfs_zone_finish_endio_workfn(struct work_struct *work)
 
 	wait_on_extent_buffer_writeback(bg->last_eb);
 	free_extent_buffer(bg->last_eb);
-	btrfs_zone_finish_endio(bg->fs_info, bg->start, bg->length);
+	bg->last_eb = NULL;
+	do_zone_finish(bg, true);
 	btrfs_put_block_group(bg);
 }
 
-- 
2.50.0


