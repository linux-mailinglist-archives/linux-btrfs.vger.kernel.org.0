Return-Path: <linux-btrfs+bounces-8100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFA897B66A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 02:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61B51C2355D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 00:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4054C74;
	Wed, 18 Sep 2024 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UglvJjkD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEF23CB
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 00:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726618569; cv=none; b=uiKWg5oN2BAo+V60FTPHdwYWb4ANC4smNy24MeMm4AXKtkEAoR2ld9ekFZJJK+6ZBukWotqVZPOgjwyqQpaUpeCPwUE+okTMBHwUgozEnAMp/j4FYxTSB0Sjj0dviCeYKdlPCyUtOETESBDthKVTFacOX3ApHVL429sAIZXWdiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726618569; c=relaxed/simple;
	bh=WzYzXh/ioGIra89BwHJquRf+y3TrPkDZvjxZb30PCD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ES1TNHRoM6iXUnk+F85CsS67fokV8tgIlPZURJEuN5lLAqWDxQdaz+7hVO8HyOVHeEUVKmgKVlngLVuS5anozVp4KyaT37dexDP9U3bx63aLsuzaNeUSmFnicpRH+lJt5EKnddnk4j0Px4FpxRz8pEHXr5fMBd0HSeJOy5bzc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UglvJjkD; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240918001603epoutp02a3866c1ed143ad06b0a49ac3e1147879~2Lm9pxq1p1426914269epoutp02f
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 00:16:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240918001603epoutp02a3866c1ed143ad06b0a49ac3e1147879~2Lm9pxq1p1426914269epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726618563;
	bh=xarkktzL2Hamc1ormKEoTUmM/Y8eTsQP6TdBr9+VQEk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=UglvJjkDV+QM6j5XqBjqLbmh90J0E5NXpK/6MQv3TvLzrqaIA42j/HiwsmH5OTIv3
	 MBPIG5eam87pH4CxX8Pbh+wnQCBHl9ogsB3JZ+UXtB0aLQiFlNYSBWQqRkQiyaPxmi
	 SgMqrQobQURy2aubGOj4dWWsPOWjn1Lclv0Hx9f0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240918001602epcas5p47e69e295b27088d9988054f3eb8a38d9~2Lm87ggXM0602906029epcas5p4H;
	Wed, 18 Sep 2024 00:16:02 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4X7fM51Ws5z4x9Pt; Wed, 18 Sep
	2024 00:16:01 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F7.33.09743.1CB1AE66; Wed, 18 Sep 2024 09:16:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240903054032epcas5p41a43b67314c727e07a049344adbca480~xpXAP7JOo0116501165epcas5p4X;
	Tue,  3 Sep 2024 05:40:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240903054032epsmtrp213098798aed55a982891e5261219bb68~xpXAOdmuA2893428934epsmtrp29;
	Tue,  3 Sep 2024 05:40:32 +0000 (GMT)
X-AuditID: b6c32a4a-3b1fa7000000260f-0a-66ea1bc1ac8f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.C2.08456.051A6D66; Tue,  3 Sep 2024 14:40:32 +0900 (KST)
Received: from dpss52-OptiPlex-9020.. (unknown [109.105.118.52]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240903054031epsmtip2ba33f3dcae49bb2ca5d941963f0c0bfc~xpW_3wd6k1824818248epsmtip2M;
	Tue,  3 Sep 2024 05:40:31 +0000 (GMT)
From: "j.xia" <j.xia@samsung.com>
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, "j.xia" <j.xia@samsung.com>
Subject: [PATCH] fs/btrfs: Pass write-hint for buffered IO
Date: Tue,  3 Sep 2024 13:40:12 +0800
Message-Id: <20240903054012.1238270-1-j.xia@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTXfeg9Ks0g6ePOCwm9c9gt7jwo5HJ
	4uaBnUwWO5etZbf4uGc1k8Wfh4YWR/+/ZbO49HgFu8XZCR9YHTg9Jja/Y/fo27KK0WP9lqss
	HhM2b2T1+LxJLoA1KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
	xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
	aomVoYGBkSlQYUJ2xsl3B9kLHrJXrL/0mK2B8RBbFyMnh4SAicSbQ6dZuhi5OIQEdjNK7H6z
	mhkkISTwiVFi4txciMQ3RolbP94zwnQcbZnPCJHYyygx/dJMKOcro8TeEx2sIFVsAooS52b+
	YQexRQTMJI5N3MwCYjML2EjcXDwZzBYWsJK40PQIbB2LgKrEu+ntYBt4BSwkZq6ZBLVNXmL/
	wbPMEHFBiZMzn0DNkZdo3jqbGWSxhMA1don9DaehGlwkZixexAxhC0u8Or6FHcKWkvj8bi/U
	08USzVNfs0A0NzBKNJz+BdVsLbFt/TqmLkYOoA2aEut36UOEZSWmngIJgyzmk+j9/YQJIs4r
	sWMejC0v8WjtDGaQVgkBUYm/qyQhwh4SPY+nskKCNFbifOsRpgmM8rOQvDMLyTuzEBYvYGRe
	xSiZWlCcm55abFpglJdaDo/Y5PzcTYzgZKnltYPx4YMPeocYmTgYDzFKcDArifCKf3iZJsSb
	klhZlVqUH19UmpNafIjRFBjGE5mlRJPzgek6ryTe0MTSwMTMzMzE0tjMUEmc93Xr3BQhgfTE
	ktTs1NSC1CKYPiYOTqkGpvSTJ/i9bTXDS71mFsfeK8u+3HS9UVTcQffj5dKZ8lPEZSW7DCMy
	P6xaExmalJ2m1F+4wyjCRV/4v2yzdflWq5lTeRK5gqWWZv5nMZqy5paP2B7diq+TkjND+R/s
	8LTfdH1lpsUM3uUz/y0xcRJatmH5RKduP8Zvqx5fldw/TTfz0Oxf666vdFp4Wm6R4sctE7p4
	lf5sqaj+lrs/5/yk1xs6tk112PuSr/blgizfWfP9RM+7B9xc03KuWUkv/vHkVb6cwYp5/+Xe
	bDCKebtE6PTGPx+3pT/yd3TIiSqb9Ux9etkaJy0Bx796FnMbdDhXVG65nJx++2rThMXLtRy2
	Tnc9aegn01i7LkglY77UXCWW4oxEQy3mouJEAP8mUmwfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWy7bCSvG7AwmtpBp3nzSwm9c9gt7jwo5HJ
	4uaBnUwWO5etZbf4uGc1k8Wfh4YWR/+/ZbO49HgFu8XZCR9YHTg9Jja/Y/fo27KK0WP9lqss
	HhM2b2T1+LxJLoA1issmJTUnsyy1SN8ugSvj5LuD7AUP2SvWX3rM1sB4iK2LkZNDQsBE4mjL
	fMYuRi4OIYHdjBJTeiaxQyREJa6cPQxVJCyx8t9zdoiiz4wS3290M4Mk2AQUJc7N/APWICJg
	JbHn5B0wm1nATuLCzy5WEFsYKH6h6RFYPYuAqsS76e2MIDavgIXEzDWTGCEWyEvsP3iWGSIu
	KHFy5hMWiDnyEs1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT8
	3E2M4MDV0trBuGfVB71DjEwcjIcYJTiYlUR4YzdeTRPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
	++11b4qQQHpiSWp2ampBahFMlomDU6qBKWL6zElh/7g+vX34/LG//72u9gSBo15hU/qVs0p0
	fycbTL23dfFFnfNdaxwW1wk/T/bRe7vWbPsJ1bUymmHSmczax/9PnrPDx1GQo6Ujq6TT+Ht0
	uooXR/qmqM8zM/wZf1rbiMzZ21jbLbhI4rWNtvEVw1dZ5rxbpVrEOO2tAgO2PNLe2vrgz8cA
	hdV3btS6675MWXI940E397Xvx3VqnvWr//y+eLlmRcHLLbUt603vvI+o3MYrznjb8cpvlml+
	axpu+T5YXsGRUOk5s9HpY4LFrW6+ZT8/tk9cfTFO7HQbZ7f3xdpJz6dHPN6z7m3V/EcZEVa7
	FkmlLxFVlrG6k8kdUa+6MGNhSArP09YwJZbijERDLeai4kQASKr8hMsCAAA=
X-CMS-MailID: 20240903054032epcas5p41a43b67314c727e07a049344adbca480
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240903054032epcas5p41a43b67314c727e07a049344adbca480
References: <CGME20240903054032epcas5p41a43b67314c727e07a049344adbca480@epcas5p4.samsung.com>

Commit 449813515d3e ("block, fs: Restore the per-bio/request data
lifetime fields") restored write-hint support in btrfs. But that is
applicable only for direct IO. This patch supports passing
write-hint for buffered IO from btrfs file system to block layer
by filling bi_write_hint of struct bio in alloc_new_bio().

Signed-off-by: j.xia <j.xia@samsung.com>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bd1a7b2fc71a..90413ae9c0ac 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -702,6 +702,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 	bbio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, fs_info,
 			       bio_ctrl->end_io_func, NULL);
 	bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
+	bbio->bio.bi_write_hint = inode->vfs_inode.i_write_hint;
 	bbio->inode = inode;
 	bbio->file_offset = file_offset;
 	bio_ctrl->bbio = bbio;
-- 
2.34.1


