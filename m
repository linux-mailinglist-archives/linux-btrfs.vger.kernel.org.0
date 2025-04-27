Return-Path: <linux-btrfs+bounces-13448-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B792CA9E441
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Apr 2025 21:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3445A177EFA
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Apr 2025 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40891FC0F0;
	Sun, 27 Apr 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ7LU+Os"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BB81EB194;
	Sun, 27 Apr 2025 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745780418; cv=none; b=LRlAAfF1OMDcmyVb4wjxqtvyoYlHvDkvJY/3rnH5ZWQVSQ5AGviFNPYdepbSXRRmmRgHcLngBibQSmANW5j9GWrJyVYmeuSjjwqynxSYU5nBmcKeR6rCXmxQCfrvk58tH1s9Hk5RNA5AZFhTXP0y/n39LhZI9aYqWHpSKLEPfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745780418; c=relaxed/simple;
	bh=IcZsI7Oroz0kOLntXx2TPdJDuzwG+IXq5Cx1/e3EwgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKL3Wb3dmY3RoBHly+OefwpVWTh2QhDrI/FEVGemmoengH5p3gkNaSLADYtEwtUICj1wSNBAcsqe6uGiLZ2KaLM9fJvZNXtH75THYxI9AYPMxh2AXz5Gtxk4+Ci44IZKiiElNU15Gy3EwTGi5jDd5Utzoy+fFQp2phQyEkFQlNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ7LU+Os; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73972a54919so3292805b3a.3;
        Sun, 27 Apr 2025 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745780414; x=1746385214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sjYvr+yA+zdWfNHFdWRXavur5ow2fufmvm69FNNW48U=;
        b=cJ7LU+Os2NjorFdoPl+/NkAUe/wEzTFZlmYLyB4tVNzMYz+IIMohyAOM8jJjPRgCEZ
         SxLuliee2iM0zMUeHYbblJWwcjahMQ7woSRw0iEoUPhP+7GMbrs8GDATvAGEgUMCyRGJ
         rEKwi/Lf4kqu5wH3R3Cb4wcbbJYPjH49pX1FqXXYVml93ztL2dpXacTPMncec9NNOHhp
         fS1mWqD3AxTggXgYhGcPqOu/i5RUV64Xd8X/tD7hs2Xh0gvCAcR/5kRHe173ZReKR5TM
         9No/L74VqHNVX8+3ucumnRDp/e13ztSV1bKKd40EdFJQlHIcwHEWTdjNF5rw5d9zhGcR
         +wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745780414; x=1746385214;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjYvr+yA+zdWfNHFdWRXavur5ow2fufmvm69FNNW48U=;
        b=DMSZGZIOD4CLsQ6tG6otUw7D3pKayNZXNadVmf8fNx8UNAEep1Bebx+t4C8DKwFP2o
         wBnmQPVxMExauAfsHvo8zQlNOuaEtjtgQzG3uGE0h8qBKY3G+KC0ynJdkc9k8dGNbOdj
         fSR3KNkbc3yvkiCvPpeWZ9nGoN3le0lnPXRGBSL7ltVuZZ8tJubVmMF3AUNm4jouHIyE
         Ud+1SF9im1zRpHzVe+5fPcaCoKtBvQq1B3I0YKFW3YzYysS5NDE2+XWLq4+E2tHMD0OQ
         wWkAMrmegKoS3hIIXS5j3+6lLsiSrCmqYvRLtPlsf369K3XpVkSHZJx3MeDjZSd/BL3U
         LRGA==
X-Forwarded-Encrypted: i=1; AJvYcCWi2kNW+KHirxGZotUZ0lTznAfozh6OUoj3226sOu8w3kujHiztj2KgCmdJD5VXUa0B2F1RiEJ5+Ola2g==@vger.kernel.org, AJvYcCWqCscYfmjsu7DNbOiEA9mQulkF25skOYMv7E4CmxV043pt7UG/yO1rtljl4DRrSzxS09MELasCFpH/b2n7@vger.kernel.org
X-Gm-Message-State: AOJu0YzrlkZt1VQsUlojrfzKBLjTW8Sw3n4+PfS4Yos5byrklE6L+Fwq
	ovJ/pA9cZ4tkyh0/04Zx0l30RadPhsKHX7YSPeYwuNesFgENw4en
X-Gm-Gg: ASbGncuAjZwHn+pKyC3KERhR+W3QBwBCaauLeDrYzuxreKymKIvCahJkcRmNkEpxrRc
	Puv+CM8Sf2fBUoI3v+yfRkhXT54yDuXtaFkkaVgwAAtbp4sh1s1KKth0R13yiKO83zYSLFLqs0A
	XePh5Atl36j+kVT0F0oy1lmCG+DUZNRaXG+ncX1jrnXvpuPajmy/mTsJ5okQwGDf50ZKNm8USEq
	+UJKArYRcVvaE6hxy6uwOFMMwoNNGGqYqQZqx2f7LYraf+trXM/bazrhcfEwM8lyrTPJt5mta2x
	EUVdvKBcI2GLJjFb5RUIc2dH0SmjHH/4WFQmgebBq/KFCE8hMviRizRWyDK2MEkFAa8EL2Cc
X-Google-Smtp-Source: AGHT+IGqp/hwdsuDHXNECCCGo0RS9+jH9xdWghKghtAN8mLfYvPhaOhox/tezpC0KBjUwj380xdEDw==
X-Received: by 2002:a05:6a20:d817:b0:1f5:839e:ecdd with SMTP id adf61e73a8af0-2045b6960e9mr12016852637.9.1745780413622;
        Sun, 27 Apr 2025 12:00:13 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([115.171.40.102])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15faded554sm5862153a12.72.2025.04.27.12.00.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Apr 2025 12:00:12 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: drop usage of folio_index
Date: Mon, 28 Apr 2025 02:59:04 +0800
Message-ID: <20250427185908.90450-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250427185908.90450-1-ryncsn@gmail.com>
References: <20250427185908.90450-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

folio_index is only needed for mixed usage of page cache and swap
cache, for pure page cache usage, the caller can just use
folio->index instead.

It can't be a swap cache folio here.  Swap mapping may only call into fs
through `swap_rw` and that is not supported for btrfs.  So just drop it
and use folio->index instead.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM)
Cc: Josef Bacik <josef@toxicpanda.com> (maintainer:BTRFS FILE SYSTEM)
Cc: David Sterba <dsterba@suse.com> (maintainer:BTRFS FILE SYSTEM)
Cc: linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 197f5e51c474..e08b50504d13 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3509,7 +3509,7 @@ static void btree_clear_folio_dirty_tag(struct folio *folio)
 	xa_lock_irq(&folio->mapping->i_pages);
 	if (!folio_test_dirty(folio))
 		__xa_clear_mark(&folio->mapping->i_pages,
-				folio_index(folio), PAGECACHE_TAG_DIRTY);
+				folio->index, PAGECACHE_TAG_DIRTY);
 	xa_unlock_irq(&folio->mapping->i_pages);
 }
 
-- 
2.49.0


