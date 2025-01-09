Return-Path: <linux-btrfs+bounces-10854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AD4A07B8F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EBE18828B2
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9BE221DAC;
	Thu,  9 Jan 2025 15:15:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C321D5BE;
	Thu,  9 Jan 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435726; cv=none; b=DnIrxGBQlyUikB3YKx6mkQ4nQk8tkieNt4SLBne5Gqmk59IqaUADj3TQlUK1Y62YsrcOegFlXaMfLwBJ/hh0sYIv9YScqeEcyK38X0/HTDvTXrJigsQjC3+IKUrcfoOY7rNVk2dNaiLex+q+QkSaqdgHWsN8F07qL/WAGX7+gcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435726; c=relaxed/simple;
	bh=7RU977jD6JRAc8nXAQ13ycRxUPQ4S0XJnjV+jaAEk0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4wMA3tmWTPlYhVWL9opr6N4ZrAFaNe52k+LSu1h4ItL6Ogozi6lJVJDzJuEDEuLj+UWH6KlLX28gy3BuqEbVolfa6bw+VnAlVWw4AlRJGp8S8M1HuhTsKZIcopryzPZFTqc/9Eff+SCc999Dx/PqlO9aQE8UWJMEegW6bb2mNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf60d85238so207514366b.0;
        Thu, 09 Jan 2025 07:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435722; x=1737040522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f7HYuc/zbqPX3K8D9UCOiwzkZM0PQUy17Tw7kvX52w=;
        b=s9j3gTchYHS5Mqv3Tv5HRpNZ1gxCImkPTymfGGFx67VW3MMKei6ZqexuAR6ayL1iWJ
         qJfyjMCXj16FVsZ4tbEOBNLgndVUEQSNbOHQo0BU7609M9W2YopQojufQUl9x+4pZpsT
         nlM0DjlKmEoagFiA6HWLmD/jkXTSLUj1iAl8j2Q9CaRthp4Yplf7vjCtoR/3y4H9NrXq
         7Qcy4wQt0zK19Yknr4E0pC7Ek+FN3AXB54tWnYptaqUd4EjOp0EXB2WO1d2y2w4HAeCO
         vXVfSygwnv/vHWIWPV6MXJINqiTZBosPZdUSqnK8RUsCpXQZrE6RtU1dqHmt/xiC7raS
         Mi0A==
X-Forwarded-Encrypted: i=1; AJvYcCUqZpHXecOzEu/jYF8uVCONQa+wP1GWyWyI4XN19EaTwMpcwwKGmLqm0n/kIi+KJ83A/uA30Ay4exV98OX4@vger.kernel.org, AJvYcCWLstVwELSZ72fE5RdEWQSBVkSdWWD+hRER3QZBMxxJ4dJ9HE6PSOIwQeYizOFbvms+BXRJV3/mPJJUGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdN+chO6gaOUhudRJfH7fPkQjQP3LiAmZ/wgv30VjV279VrMq
	bCatNm/K89BLccjBvgIhMz3g6c5xPivYRBlRycQJkObdyDbNRIIx
X-Gm-Gg: ASbGnctEhD5FwRB3/a6Ti1Rx1DY4EX5xNaHTkttuACNWIUGppbdj8uNvVAsylDfOwuG
	WcJRck3Bh6H1Uqdey95uyqm5PsBZtILbGsALhmZm/I6xuNt8epYxaKYBA0m0XzendY3amX9qCDd
	CiHuzdU9zEFqK9BW8kyJrs5MifC45MzQaq5FMFEqaMiR7gWu9I/TGTbqZWi0gnDLS5MLc7GxTJn
	0cnvZYZ/2g6m07YA9kHCIxT4bVx68wvqI5G1G1xS/s/XUw0m21MKWSKYNmMfC+C57SZl+2B1ibI
	7JGVBFf5LR1jW4SuDOX0CEZGeMI7HZOcuifI
X-Google-Smtp-Source: AGHT+IEQDuH5vEI2s87tcEK5jCYm/XUFOxyLSJn5epjUE+x/2rNdA5AxjGzQGSgPPt0wmvtRSff3Pg==
X-Received: by 2002:a17:907:9410:b0:aae:8495:e064 with SMTP id a640c23a62f3a-ab2abc78b52mr581770266b.40.1736435722341;
        Thu, 09 Jan 2025 07:15:22 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:21 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:05 +0100
Subject: [PATCH v3 04/14] btrfs: fix front delete range calculation for
 RAID stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-4-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=jth@kernel.org;
 h=from:subject:message-id; bh=5+Uh5g3sT+QliGHP6NK8OMLhj3AmhkLM0KvlvFFuU6s=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2BpCnuVOXF6X+e62OX2i1srTrc+7cgSMnznxDv5a
 vOO2TLfO0pZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAiH/kZ/qck9LvuP3fqk47q
 j+kZYarbEw4/j1nywmVTpf9Vn8szpmxn+Geu5PBydrRWxNuyn5y/YwQWFrP6WPnXf7iU9FV3i/H
 Ke4wA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When deleting the front of a RAID stripe-extent the delete code
miscalculates the size on how much to pad the remaining extent part in the
front.

Fix the calculation so we're always having the sizes we expect.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid-stripe-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 0c351eda3551efec67c35d76d06e648da5f33c71..9e559ad48810b704c997ff5e51222aced0b91637 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -136,10 +136,12 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		 * length to the new size and then re-insert the item.
 		 */
 		if (found_end > end) {
-			u64 diff = found_end - end;
+			u64 diff_end = found_end - end;
 
 			btrfs_partially_delete_raid_extent(trans, path, &key,
-							   diff, diff);
+							   key.offset - length,
+							   length);
+			ASSERT(key.offset - diff_end == length);
 			break;
 		}
 

-- 
2.43.0


