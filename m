Return-Path: <linux-btrfs+bounces-13562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F2AAA536C
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 20:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D6D4C94DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A803027A46C;
	Wed, 30 Apr 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xyo+JaDQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E186279904;
	Wed, 30 Apr 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036674; cv=none; b=Ic7SusCfHJJUNr73VO77fDK5o6id80a/JjYEfS+j0+bKqDbgtrIl9TqbWLy7NX72/yP3IYsalugRoSicUQ1Eq6SKxkIvxSjMGVnbUEyjzpXTYNPgWhEnPL1U/GKY932Pg20rKDgU+MT4Ej/+eCLvC33DhXA41vHUH3LGBpul2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036674; c=relaxed/simple;
	bh=bjClv6BryTyDpGkWdfsiI+95q6D8k7MY583X7jPAQJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbhC4XOQ+vj1sM74FVHFFIEUOJ2puv2yPByhiE8oVQLGeVmaZXJS0bUOIlNAeSot1+wJqBwE801ldRYWUR/bjzUtkHf3NU55kTKCkj8LiVbvS44VOlun2VBPIil9+DJ6ByK7t0/94zRpneUaZbAGWDvQDr+KplbLu2pAA8XM2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xyo+JaDQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so283326b3a.0;
        Wed, 30 Apr 2025 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746036672; x=1746641472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tq3nEj4DUSPSU3dXBHWbYOiByd1+bRHGbfykzSesdrc=;
        b=Xyo+JaDQ9INLleVptVhRQpYuGrBchG8Y8HjZbttORjNEJU+wmOKPtumtPLIhZK2SNw
         HCp36kmei8v7Ng4kJG6W76qpJJ/8ZpJEr23pQ26K55Bzw0KLFL+KwGOwVJpnBaLsujyO
         vTginbmmwzUiYsJAzVXabU/gaHoJwV88FbxLd3gTSs2OUgsO/sBglMESAmCvYT3GhOiZ
         4zrnntzsEPLNZ5fWhT3P1DMslc4HOm/abqONAGsgmVgwK7eNOkqHbCZR7Ker/CGmeTM8
         WynijBqkyQILuJ46IJJrnLBGN1UWydnN0DNKN6mZZRz1m+qPApyNlfBBnRzbkgvDtfay
         8w3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036672; x=1746641472;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tq3nEj4DUSPSU3dXBHWbYOiByd1+bRHGbfykzSesdrc=;
        b=xKnRe/WU/xRnGeJuszENZkkQaocUCgFTwVTS6H9WT9zyAwBlNaHqMadDTIGzIu8iTj
         008xozXxgbOaCVKkBBeFq1zF2w+g2yGFITZZmqUeNhc1t0cI777fCZDvsVe0eNwa709t
         PwV3BCRbqHXlJB1MCm5qrfBQ6+FwqsbU/erOVWcaCzr3Z9r5szFaKr0WgimY54hnG/9S
         7mE+eZqB7YzlMzfX5TJruUG2Pq05I0ZtMAB9XKpX1KhMXX+aLU6rslNgEPay/KHSRKiY
         pD5uET6pcVJlEEDa4p7kXBZaQzGz+QCjo6kNhxktwaCA93wQTeHCtOvJf/N3vSVU86sA
         BkYA==
X-Forwarded-Encrypted: i=1; AJvYcCUl36umNva4a++R9DowvZckZyCMVt7smYOPxWZTlcfOPwdTsKZI2t+BZh8e1AXFFTQKcoNPhQoG4Km+YhZf@vger.kernel.org, AJvYcCWv/XYj0iwn/KzfOcugGTLaOoMP9YRjWVmwuy+09rRam+8O+ZKsWzIsLNaeCExMA76qCRsKNnSo0RqX9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6MiOtRExZuz7zwxYmuRNfm4/0RnGcabKhURciy7fG1QXhfG8
	JZpky7ihTGojYsbvELTxZ7uNhBkwHH3eP688cKd4DucXNn3nldHGj7A98meUfJ3ngQ==
X-Gm-Gg: ASbGncu/YsGOXdeG+ZxyoeYyxm9TeU/0Dm0kfVZOLQWhiB+QNlZMHF/tEKCWEgXq7uf
	W9CoI8GWvDlmpYI3LKxTpjwAtQlcFFRbcXyChFZiuIy4ikjdqE36ClYYUB9wiE2LEvlBECPNR+V
	AjnKw4V6zCHC3jAUmqYeIQ5TJRBioQG1jPFC0nOvdZmmMigAipuRoVhMuvPAQuewPnVcrC6Zk+A
	Ubb2LoNeYUzVvtlwrELRZqhgx/ebrstRf90cdSaIf/w/NmURwxJZXq6iONK023Zi7jRQgJosBje
	tct36YmRvNsQBIqeF5z9TlVRhPbnICyAhphr+aKgHaYVgJKAD1wAQ1nflvX8Rg==
X-Google-Smtp-Source: AGHT+IGPmIR52RvLNc4qp7jBDc7epoAkUWjSXFVEqnCRZkqTXLMSG6UyM8sVIbiZ/MbiNgWOBB70hw==
X-Received: by 2002:a05:6a20:7f81:b0:1ee:d8c8:4b82 with SMTP id adf61e73a8af0-20a89419b37mr6855342637.31.1746036672506;
        Wed, 30 Apr 2025 11:11:12 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.122.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039947976sm1983822b3a.84.2025.04.30.11.11.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Apr 2025 11:11:11 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 2/6] btrfs: drop usage of folio_index
Date: Thu,  1 May 2025 02:10:48 +0800
Message-ID: <20250430181052.55698-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430181052.55698-1-ryncsn@gmail.com>
References: <20250430181052.55698-1-ryncsn@gmail.com>
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
through `swap_rw` but btrfs does not use that method for swap.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM)
Cc: Josef Bacik <josef@toxicpanda.com> (maintainer:BTRFS FILE SYSTEM)
Cc: David Sterba <dsterba@suse.com> (maintainer:BTRFS FILE SYSTEM)
Cc: linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Qu Wenruo <wqu@suse.com>
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


