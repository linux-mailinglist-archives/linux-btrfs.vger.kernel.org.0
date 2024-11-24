Return-Path: <linux-btrfs+bounces-9846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DEE9D6E2F
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 13:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7C4280633
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467EB193403;
	Sun, 24 Nov 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOvDvPYC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09F18BC1D;
	Sun, 24 Nov 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732451975; cv=none; b=mAeJ3vhpdA7Qe52/uaTf+MdtcqpCwb6fo/lOZi2h7oidhd3asp+gtU2INvSAbXTFpWD0jy8BydKk+SIYAnRUrlSn/bQLdkuO8+Q0DGkS57zI9CthN7mBRp7Dv7rihxpW5HawcdWRcWGfesGD+NUI7h50cQqYM4e+U4KUnQ7wqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732451975; c=relaxed/simple;
	bh=BTIyG8F4g64dVslBAYFoYV0UOdN3lrL+xD0x/pqevMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+UUl+9C4O472pwjuyEMZkPMlSEqcf7Nx2lMCmqhELcjMX5uCRQC2skNqsABKJo+HPnL774035TGW+uO9T8yTqdSzzFAXt5sw5ckdXkIdNxil2mwI9vUp3kz89qPDI2YTUMkYwJWVKY4pdbON/Z78PLaUC10dmzLB//IFLs8eYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOvDvPYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76F1C4CED3;
	Sun, 24 Nov 2024 12:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732451974;
	bh=BTIyG8F4g64dVslBAYFoYV0UOdN3lrL+xD0x/pqevMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOvDvPYCoegO5Hb9rfSF4fEgB6TNiwvOwBaMJ6rPDZmW2GdZbtScgRMqeVEPEiP2h
	 A6Vd2bG0oXm0o0YAD0rlwfoQ1DznpYlt5c5M1dny7wuFa4dLW9IDF8RP1YY6aZ0ZYt
	 5yEzx46RX6XVFzRHj+N46XzpI1SxXCcQ9lDYvH1Y8e6pk+1iS3ebcYSTc2y7RNmJ8k
	 gb9n+CPvL3uqe5+fXLePeZAvxu/8H8ChkhcACDFD3ojpGJaMPl0ZxiydLJFnkeFljW
	 9J3AN4KSm3pYOb6aQJoqvHh9ybvF6Rf8kBWBWuYSNqeYQ2xsLFz5gBJQvAWFVCbCsg
	 6KfL12EEs0Jgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 09/19] btrfs: zlib: make the compression path to handle sector size < page size
Date: Sun, 24 Nov 2024 07:38:44 -0500
Message-ID: <20241124123912.3335344-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124123912.3335344-1-sashal@kernel.org>
References: <20241124123912.3335344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit f6ebedb09bb276256e084196e2322562dc4aac10 ]

Inside zlib_compress_folios(), each time we switch the input page cache,
the @start is increased by PAGE_SIZE.

But for the incoming compression support for sector size < page size
(previously we support compression only when the range is fully page
aligned), this is not going to handle the following case:

    0          32K         64K          96K
    |          |///////////||///////////|

@start has the initial value 32K, indicating the start filepos of the
to-be-compressed range.

And when grabbing the first page as input, we always call "start +=
PAGE_SIZE;".

But since @start is starting at 32K, it will be increased by 64K,
resulting it to be 96K for the next range, causing incorrect input range
and corruption for the future subpage compression.

Fix it by only increase @start by the input size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/zlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 100abc00b794c..ddf0d5a448a74 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -194,7 +194,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 				pg_off = offset_in_page(start);
 				cur_len = btrfs_calc_input_length(orig_end, start);
 				data_in = kmap_local_folio(in_folio, pg_off);
-				start += PAGE_SIZE;
+				start += cur_len;
 				workspace->strm.next_in = data_in;
 				workspace->strm.avail_in = cur_len;
 			}
-- 
2.43.0


