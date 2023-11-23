Return-Path: <linux-btrfs+bounces-323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625227F6349
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 16:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9479F1C20DB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 15:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D83E484;
	Thu, 23 Nov 2023 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P9EkNK4F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518B7D48;
	Thu, 23 Nov 2023 07:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700754486; x=1732290486;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vE95KoUEUEVqVM2tCNXr7cBWfNJDvBLd3iEA6GxxuoA=;
  b=P9EkNK4Fyxefg8Nh9xZheLqRAzjo1ZK4VNhQDMHH61KV5IBmK7T0Xodh
   G5Ei9E3eNkSVidZQIFlKyjlVZW66MmaczkmRR45GSeVZCXy2n2aggSqJB
   id/Foqx2N27YHT4bWJf4jXxfCLZOmKnAj+23dQSF3LJZOiXnpGx57gEsj
   EV/kheFJhACIEFepUrKZyax2G8Iublty/j4hzFY+C+oyGRcnycsN5Zi3P
   P+G+nBZIFpnLdWPePqK7pv/JKA4fSIEleEuUdSaS9BdedRo5TukZtx6mb
   roPX/eQ5khZWcYvpkKlg9xigs+X+bFm0m0rwPp6z5VCrugbBtmUOvgl9K
   Q==;
X-CSE-ConnectionGUID: vSiKT64CRkSzXsD+cCFD9w==
X-CSE-MsgGUID: JbJTO0MlRye4ZiuVbGwA9Q==
X-IronPort-AV: E=Sophos;i="6.04,222,1695657600"; 
   d="scan'208";a="3129203"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2023 23:47:32 +0800
IronPort-SDR: Z7q65LVjTCH7EXeHHT7IptpGvmzIi2G7osYAHqE64cMT4u32kzGfFPHKTUinyp2CyKOOv209zY
 ur2iDFgzICKmCe7xOid7EkMkbIMSxPPshfnXGSE2uEGZMTcjfhSz1wTtxC2B/BXiKD197fC9pj
 p6mjFXBNYRYgYHjMWYpFAgQA6AbKsyuVWyxV1YzfsevMTQtRR3S5nSA5c9LRRtnlOqQafohhaz
 4sidaBqF48gFZS1A20OB6envJSFNjGpkKVghW4i2D4CL5qVjhyWBp/yj4JHtGMvXNrK78buGjX
 JvE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 06:58:48 -0800
IronPort-SDR: gkVSIe/USso4kaxtBj74U9WtW20W9HtzS5y0cPCf4P5av6WUtxN02k2Y05XzJ8A64gsSWzKdfW
 LoVxtCD8HDxOFtXB51dBnxYl1lbxXNYJ1HaW7hyx5z9v9ciB+w5CazhjurvOUq3SkWFVTs8d/G
 nCAUVbMqFxH+B1DdDjPOTzNaqDnPK3mESlziLPhR1L+5Y8PxE/iR6cwjYzk2Pd0mwrVpZXthrs
 3VUnQwVXUuxoJ2wsc31rebxXPTso+V2iHOdK4slndG1h94pjbEJp+j4wk831skmZlJSs9pfBUk
 Nsc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2023 07:47:29 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 23 Nov 2023 07:47:18 -0800
Subject: [PATCH v2 4/5] btrfs: use memset_page instead of opencoding it
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-josef-generic-163-v2-4-ed1a79a8e51e@wdc.com>
References: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
In-Reply-To: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700754443; l=836;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=vE95KoUEUEVqVM2tCNXr7cBWfNJDvBLd3iEA6GxxuoA=;
 b=YSp9DFeqHURIML2/TvPPdaOoHQ8vExnmR6thl23Knk6cdcnLsOpQafOiB4KrzeJhrnb9xhqpd
 U8H7KAaTp7YCNmiTquGZIEx5wSB1bNInUPch3TZFNmOQvnz/qTsLzhA
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Use memset_page() in memset_extent_buffer() instead of opencoding it.

This does not not change any functionality.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c378094b5cc8..defe0fa04572 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4195,7 +4195,7 @@ static void memset_extent_buffer(const struct extent_buffer *eb, int c,
 		struct page *page = eb->pages[index];
 
 		assert_eb_page_uptodate(eb, page);
-		memset(page_address(page) + offset, c, cur_len);
+		memset_page(page, offset, c, cur_len);
 
 		cur += cur_len;
 	}

-- 
2.41.0


