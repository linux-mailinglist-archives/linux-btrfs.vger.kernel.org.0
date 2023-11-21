Return-Path: <linux-btrfs+bounces-255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A75147F33D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 17:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DBEB22099
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763545B205;
	Tue, 21 Nov 2023 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jM9j26vZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAEB191;
	Tue, 21 Nov 2023 08:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700584360; x=1732120360;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GyvvIo5B3m5fGvInoKE69As5yRuaY1/RgWCjARzh/rw=;
  b=jM9j26vZJOBAKKVdVjcY129zRyY79LEi6aQKTbTzglYTKjliga+blJRT
   mZ6DoQkoKx4DkKMKyaOfnGK5LckBxcaXXp4Vva5iEEUk+8+eyvwvFliYf
   oJ/urYu6oJHzIjWnjC+Nhezr53VIHJOx7Trc5eTyeXkZEM4cDCe4txbAT
   OHvIBLGxuipnMbDG1qzJApTpRBdN8kPRX8+BRmNyNkqlBgCiHxDZFVY+l
   1FcgkliBukxU5sj/pNsjQdD4zMMEvH4o52u03ru31TGnLrQ1BhRwkB991
   B+lDVAADTnPUDABT0kHKcUWYNxVEf8Z+vbrFcxsSC7zbqW8syQ+p+nKJu
   w==;
X-CSE-ConnectionGUID: y8vfalxwQ0eniSeCGttfGw==
X-CSE-MsgGUID: tBt0p4GZRWimZH5ipT19NA==
X-IronPort-AV: E=Sophos;i="6.04,216,1695657600"; 
   d="scan'208";a="3076045"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2023 00:32:40 +0800
IronPort-SDR: Wp5f1ERwQPdg+fGAzlqwt76SsDbLn2jGV2i5MMfEBG8W1GYeL9gQDw+kBUT4ussrJMy3X6K4xa
 3VJTSQZDUL+7DFTV+fe3DMvBaNJv9aEtI1N7ri1KRD12OG3T6WBEpR7iKvWWvd7nPzBA5WXL2c
 qGUu8rF8ZZxyIEcQ6hejSWCpiAM3ArMZgXzW8Q1q/Ccbwl+YdyiR7xTX5vRG98ItDDJLszGnaq
 nvMMYMqflA0nvUjpCos1xwS9l1Kq1rznqyEyMA3PJpwPWbyR+xcWPIv4mdShabCSfaUyxoL/rS
 cFU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2023 07:38:18 -0800
IronPort-SDR: 7L7Q4yvS9exJiAN/L1dW7y9uCIoQVMGIUMbigYogWdwet3lBZyJP+8fXe+jlSF9d9/LSfEyibe
 PuyzKCgNiaoNrXN7TCJJi1ex576ynXYw16alUSvPP7gkAqUZZLJwnz4kbreKmNXiwG9GXALJ4I
 z8YrZ2UUaNTm5azLvYJmXCsSlmdsQJ1qewk5AZ9wSI238hesBJIdF7q2JzRHxsFCHatUxyQG8e
 +2kg65KTWq8IqFiluK4rbvXOvydJNrP1TnN3ZZ3RpFtuEZs5cnTWgPgrJyrZQJK28OgMXQ3NfG
 3zc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Nov 2023 08:32:40 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 21 Nov 2023 08:32:33 -0800
Subject: [PATCH 4/5] btrfs: use memset_page instead of opencoding it
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-josef-generic-163-v1-4-049e37185841@wdc.com>
References: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
In-Reply-To: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700584354; l=742;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=GyvvIo5B3m5fGvInoKE69As5yRuaY1/RgWCjARzh/rw=;
 b=ThZ7PZrN2xKIjW1JXyMxUy8WWGY2yZ/ltGzTllLzrcLzQ41lrHZFdy3awwUOHF9UcvbuK2+rG
 3KpETc+qTy5AR//+WtQ3qet+HbGL0Vm4Kb/m8xenuYBrU4ffEY/i9dg
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Use memset_page() in memset_extent_buffer() instead of opencoding it.

This does not not change any functionality.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8bc5025ce278..b8a73ebe3485 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4186,7 +4186,7 @@ static void memset_extent_buffer(const struct extent_buffer *eb, int c,
 		struct page *page = eb->pages[index];
 
 		assert_eb_page_uptodate(eb, page);
-		memset(page_address(page) + offset, c, cur_len);
+		memset_page(page, offset, c, cur_len);
 
 		cur += cur_len;
 	}

-- 
2.41.0


