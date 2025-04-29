Return-Path: <linux-btrfs+bounces-13514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BDDAA0AD1
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 13:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A5A484546
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 11:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5D2D1F75;
	Tue, 29 Apr 2025 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7ok08LE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AFD2D1F63;
	Tue, 29 Apr 2025 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927429; cv=none; b=ZUDkZegK6ZVjg6NbWWEhcSySXEzu8p6na42SCpvhsH6fpayamG3zVVsbTIq+fDZG6euxrlWcdmqmA09LdUb4hB/dmVfk1qsyeBFVGelGQwuJDsittjfH+VKb49B/hcnamvAKr/FBbxNDdfAZ+9aXvSO/18wNBK0elEJjlmYtb4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927429; c=relaxed/simple;
	bh=bjClv6BryTyDpGkWdfsiI+95q6D8k7MY583X7jPAQJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppG3fu1fv+iUKzGIoRCRXi8wZHNXkr2+ai11gB9M/ZJLV68gCY1u+47CQEDJIJ10vwdvNhW64GgCJif6g/FAcy7ZBdMURQ9LhVl3eaR+CuI3buubCxSnj4LamDIeq4QsyJ4Z5cg/XQZoJcrpgyscI2UB07UengiWdEnVjCX2RZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7ok08LE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736a72220edso5843642b3a.3;
        Tue, 29 Apr 2025 04:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745927427; x=1746532227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tq3nEj4DUSPSU3dXBHWbYOiByd1+bRHGbfykzSesdrc=;
        b=S7ok08LE4iJdi1CuDPQfT/F30XCLMLEO6NkEyeHaE0XC+RISQE9lZ4T3vOX0TPwCxF
         +sNOXeGNAzRLjEVhP3WMj0qvXFSStyl1uOXExpXqngcekrzV2FMLPRzwd+RPafVDo862
         g0AvBWIN8kGnbg6yAZ0aneD+hqthXoxb/2qPuUBXCK9TGruTs9AFPh+zKQbv1l4gUG7M
         O1eMlquhpGwpAM2zFujEBiIRGVynQ5iCQCKx8PMQnk5iRI3DUv6CzgLNIKsTkYgL0i8C
         Qh6UFznzr7qNRt4Kgvd8E2RJBzw4rF5gPUWNyhoJCSZ4O+Ib22OYcaIJQuv2OS732YR2
         zB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745927427; x=1746532227;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tq3nEj4DUSPSU3dXBHWbYOiByd1+bRHGbfykzSesdrc=;
        b=EGVaYYUNAq3dCAkvPwao3F8GGNX0zkFSUgRgKT/QJvFakUyMc2XgR789cR+jQySY7S
         TaALhX2zMDPuN7CyCRmY5IWandptxJZRLzvl7SBSwICXhqFE4zd/1WIKfR5oftP53erw
         K3PdYMk+T5EFhXg1QO8QcNlzLtPb/0Sbq1/Z6Qohp1CG/Lw1Au/3Nm332+vdmJQ5OopW
         6AVoqZYaUnWyrAXnWDqOXUEQclDgb8T/SeAMU9oKQQJbBJ/RYBfzXebS8jY59V9Z96ZM
         z2d9lYCGNagWllIGJA0+K9U0J7TiNZd/yveJpCZijgkV3IeO6ClMWJJ7GZK3F1NGIGwp
         eqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFVEMz0FYG6mIVLuIi7+rRTvonVe45wGC3v0E7TBtANQSRk7XBX+LhdDOmAxxKHZ/4YzW1/4gJ6Dc4PFq8@vger.kernel.org, AJvYcCXdRUtgti/K8BCWG91jwpUXk0nzYDernf66JqkMWMt4PYiroHt21Xgn+ccIkyZcA8NtqW/EPH4kej3Pog==@vger.kernel.org
X-Gm-Message-State: AOJu0YyD04p8Dfi7cqKWg5LCvCLoZvw3WcTL8Aw0EMc+Jc1ZCgaYTF9E
	23lmgwb0T2PvfkfpQXB1xdjAJ0TqNivRcr5Mfmaf6k0P+OJEphSPKeyPtdr3
X-Gm-Gg: ASbGnctx2RjuNkf/v6VBsVPNmXb0oWljqjTkYBllMqvcqt8EOfB8X0iH/8eP8oqwpZ/
	d7v67LnARWuMs56lppsOSiYrKyseeuO1RaGygqcmkW5zoz9gBkSiOxCIB0v6HOjks5275p1rtal
	p+XPRefkbLv8fBtHxVElzVL0rKEzRDt8v59COOmQOEozq50Wle9RRU8dFZcZWzknr1Q2Le/RdFk
	EpaJxClsja48sm6NNzH6ZJsHe46/VhI2ZBfwhubj2YjKYucz32l2pW0BBpZ4kHFubDOFaBG51Wx
	eU8i1XcNZ/2KFFSHOG9Ps4DcWo0pmm6wc/Ur5kkNFL6wzh0QVaDijhKK2K3OEX9mtwLgsO4=
X-Google-Smtp-Source: AGHT+IFceGviU6cyFKzyG4aWjdQDKx3Cfc2HEqFWBXzPaKs+4WEXEA1l8P+G5QoBnkrWzjUrg/mxQA==
X-Received: by 2002:a05:6a21:3a44:b0:1f5:6e71:e55 with SMTP id adf61e73a8af0-2095907d1bamr3893991637.6.1745927426869;
        Tue, 29 Apr 2025 04:50:26 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca62csm9661644b3a.167.2025.04.29.04.50.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Apr 2025 04:50:26 -0700 (PDT)
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
Subject: [PATCH v2 2/6] btrfs: drop usage of folio_index
Date: Tue, 29 Apr 2025 19:49:45 +0800
Message-ID: <20250429114949.41124-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429114949.41124-1-ryncsn@gmail.com>
References: <20250429114949.41124-1-ryncsn@gmail.com>
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


