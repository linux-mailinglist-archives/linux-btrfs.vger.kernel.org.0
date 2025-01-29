Return-Path: <linux-btrfs+bounces-11142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC82A21ECA
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3535D3A839E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A711922F5;
	Wed, 29 Jan 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TQLU2r7+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82961152160
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159854; cv=none; b=pMZiIAkjbr6s1DyNH5vme5UGOvAs1qX+YQ5fTxdLHL2gkDF2WnqjfK8/A4iMRbr8/xQF3rzUHeLATdL3O4b9hWa+dNzA5k8VbdUbIxODo8La9WrnDzg54ZemV8swDefFDckJ5/TrVOJtD/RZZDWBwDcjXDzP0J+NXMh7DFyG+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159854; c=relaxed/simple;
	bh=ajn1j+0tB+pF1R0+jI46+yhVfWhQDnPwmhHlxKBlxiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bqJgga13oGm71WecxKwI7puDHaSrkLLJYaWci1CMLK7NqVoS0K9boQ/M1zZ+cp7h9JwVbM/kkH/022yu9bpLru2WVyRTRMf+l2zdj+vqrZvJv7Lh57wxBNlKc8kmXgMfTZMvNv2HdavRMdaLSyJ5BXhMiO8mqxqof5C6HO9nfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TQLU2r7+; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250129141044epoutp0424c957d9825dffb4ce9a9c9c079a36b8~fLytZcMUH1691216912epoutp04b
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 14:10:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250129141044epoutp0424c957d9825dffb4ce9a9c9c079a36b8~fLytZcMUH1691216912epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738159844;
	bh=AMUYor/IDGZ7ZFAsT4Kc2pGHG8vzwbC6ZzYXNLikuqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQLU2r7+p+TvwAKCfn/V8OWd5TzJ5y3w2QQ3q5jJvwrE9BHB2o+hYRLzN8Jbzzrrc
	 DBIQBt5hZoaMN4IJkEvDJnHoRU4AvDwT6dGfRKNcCzuIhkwu7VknYZvmhUmD0HDDZT
	 qfqcTvU8bJJpQMbkqsfIRZASdwseJjuIw15h++EY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250129141043epcas5p2e62587576b16e52a71f8b4be4d30e192~fLys1vr541652016520epcas5p27;
	Wed, 29 Jan 2025 14:10:43 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YjkZp04zVz4x9Pr; Wed, 29 Jan
	2025 14:10:42 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	78.E1.19933.1E63A976; Wed, 29 Jan 2025 23:10:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250129141041epcas5p4f2a5c78d6abfc3190b174cc1a32b0b12~fLyqr7nzf1416814168epcas5p4g;
	Wed, 29 Jan 2025 14:10:41 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250129141041epsmtrp2a9ef58e027346b3a4e486623bd99a331~fLyqrKfp51194411944epsmtrp2K;
	Wed, 29 Jan 2025 14:10:41 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-9a-679a36e12706
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.8F.23488.1E63A976; Wed, 29 Jan 2025 23:10:41 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250129141039epsmtip2abab78014ef8e4aa09be4d98b0930f73~fLyo0STZi2237422374epsmtip2c;
	Wed, 29 Jan 2025 14:10:39 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de
Cc: linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: [RFC 1/3] block: add integrity offload
Date: Wed, 29 Jan 2025 19:32:05 +0530
Message-Id: <20250129140207.22718-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmuu5Ds1npBovPWVo0TfjLbLH6bj+b
	xaT+GewWF340MlncPLCTyWLl6qNMFn8eGloc/f8WKHnoGqPF3lvaFpcer2C3mL/sKbsDj8fE
	5nfsHpfPlnpsWtXJ5rF5Sb3H7psNbB59W1YxeqzfcpXFY8LmjawenzfJBXBGZdtkpCampBYp
	pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAN2rpFCWmFMKFApILC5W
	0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOeLH4GFPBYu2K
	5//3sjUwflXuYuTkkBAwkeg+/Y2pi5GLQ0hgN6PEqTvLWEESQgKfGCWebPaGsL8xSpy4WQzT
	cHvRdDaIhr2MEvMWLmGHcD4zSmyYf5ixi5GDg01AU+LC5FKQBhGBDInjp2cxg9QwC+xjlHi8
	4wQbSEJYQF/i4N8XrCD1LAKqEu2vrEHCvAIWEu8WvWCCWCYvMfPSd3YQm1PAUmL3u7lMEDWC
	EidnPmEBsZmBapq3zgabLyGwlEPi0vuvLCAzJQRcJC78zYCYIyzx6vgWdghbSuLzu71sEHa2
	xINHD1gg7BqJHZv7WCFse4mGPzfATmMGemX9Ln2IVXwSvb+fMEFM55XoaBOCqFaUuDfpKVSn
	uMTDGUugbA+Jt5tgQdXDKLF/9Tz2CYzys5B8MAvJB7MQti1gZF7FKJlaUJybnlpsWmCUl1oO
	j9Xk/NxNjOA0q+W1g/Hhgw96hxiZOBgPMUpwMCuJ8Maem5EuxJuSWFmVWpQfX1Sak1p8iNEU
	GMITmaVEk/OBiT6vJN7QxNLAxMzMzMTS2MxQSZy3eWdLupBAemJJanZqakFqEUwfEwenVAOT
	+rPlyRV1j96HXE4+0ymqcILt4f2nrl13ZTJMesS2PDuwhethjf3rCxNDzVbmec1ZEvzlaMve
	Ow8+u8YcdPm2zcv/ucsS44T1yUqBH43uCz7Lc74h0/ck7IPfm1vsHs+2vtqgr84n/7fo5Nab
	K/c92zBvu4jynu7oz6LHd1/wWPX41LkFb467acl/LKq7tczJ+dVn22m7XIsvuW/QdPwallJZ
	I1XNYRRrsKYxaIlwOl/ep12LppfuqZib4L2ytDwzaeup49w9Ys90bjd/fJR71in2xZ6Zi8wO
	RUgZu3zd4JdlmlnvtLW3eceiOAZdg7TjRy+3zZnBmC8r+or9xgVG13199Ynz9lm+6ivbsfNC
	uRJLcUaioRZzUXEiAOV+6Rk8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvO5Ds1npBg83i1o0TfjLbLH6bj+b
	xaT+GewWF340MlncPLCTyWLl6qNMFn8eGloc/f8WKHnoGqPF3lvaFpcer2C3mL/sKbsDj8fE
	5nfsHpfPlnpsWtXJ5rF5Sb3H7psNbB59W1YxeqzfcpXFY8LmjawenzfJBXBGcdmkpOZklqUW
	6dslcGW8WHyMqWCxdsXz/3vZGhi/KncxcnJICJhI3F40na2LkYtDSGA3o8S9Uw9ZIRLiEs3X
	frBD2MISK/89Z4co+sgo0d86jamLkYODTUBT4sLkUpAaEYECiYn7n7CA1DALHGGU+DGtHaxZ
	WEBf4uDfF6wg9SwCqhLtr6xBwrwCFhLvFr1ggpgvLzHz0newck4BS4nd7+aCjRcCqtkwJQmi
	XFDi5EyQ8ZxA4+UlmrfOZp7AKDALSWoWktQCRqZVjJKpBcW56bnJhgWGeanlesWJucWleel6
	yfm5mxjBUaKlsYPx3bcm/UOMTByMhxglOJiVRHhjz81IF+JNSaysSi3Kjy8qzUktPsQozcGi
	JM670jAiXUggPbEkNTs1tSC1CCbLxMEp1cBk6T6H71OEo0j86WS7btZvU/Tr5qbfsPuwLTxM
	4P7NnHKBnj2d2389qLh1Wdgt+PIkhYqzfVzpPzZ5HTjG+YxRNeLb9Ql6rfM8nu9eHHBM8n/Z
	x/uzUy/fk17GXsQs8j82zPe23LrpE7LX+XhOfXQ8ctazCWb51f++f/OZ4G1U0n1q9ay+N27O
	p9U0Z7D1ebMsYzL5t5fn2HPdbfZ6yac8ZtT0x8RkFU+JvZeyPrD+a7PttbYbepHdV2+sW/9A
	Qfyc+a/Ctw+emq5+VTtRiI95WYyW3qkZto8n/OUTqmt0dJu1O/vkG8Pzi1OfLXt16GlLTdsv
	g332R/8cXuzN498xX1P6BJc3g5/CtGOS05+/UGIpzkg01GIuKk4EAPbj7qwBAwAA
X-CMS-MailID: 20250129141041epcas5p4f2a5c78d6abfc3190b174cc1a32b0b12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141041epcas5p4f2a5c78d6abfc3190b174cc1a32b0b12
References: <20250129140207.22718-1-joshi.k@samsung.com>
	<CGME20250129141041epcas5p4f2a5c78d6abfc3190b174cc1a32b0b12@epcas5p4.samsung.com>

Add a 'offload_type' that is populated by the integrity providers
(e.g., drivers) based on the underlying capability/configuration.

- BLK_INTEGRITY_OFFLOAD_NONE: indicates offload capability is absent.
- BLK_INTEGRITY_OFFLOAD_NO_BUF: offload for which integrity buffer is
not needed.
- BLK_INTEGRITY_OFFLOAD_BUF: offload for which integrity buffer is
needed.

Make block layer skip certain processing (checksum generate/verify,
reftag remapping) that is not compatible with the offload.

Users (e.g., filesystems) can send the flag REQ_INTEGRITY_OFFLOAD to
ask for the offload.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Co-developed-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio-integrity.c     | 42 ++++++++++++++++++++++++++++++++++++++-
 block/t10-pi.c            |  7 +++++++
 include/linux/blk_types.h |  3 +++
 include/linux/blkdev.h    |  7 +++++++
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 5d81ad9a3d20..05872b5ad9aa 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -413,6 +413,41 @@ int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta)
 	return ret;
 }
 
+static bool bio_integrity_offload(struct bio *bio)
+{
+	struct bio_integrity_payload *bip;
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	unsigned int len;
+	void *buf;
+	gfp_t gfp = GFP_NOIO;
+
+	if (bi->offload_type == BLK_INTEGRITY_OFFLOAD_NO_BUF)
+		return true;
+
+	/* Allocate kernel buffer for protection data */
+	len = bio_integrity_bytes(bi, bio_sectors(bio));
+	buf = kmalloc(len, gfp | __GFP_ZERO);
+	if (unlikely(buf == NULL))
+		goto err_end_io;
+
+	bip = bio_integrity_alloc(bio, gfp, 1);
+	if (IS_ERR(bip)) {
+		kfree(buf);
+		goto err_end_io;
+	}
+
+	bip->bip_flags |= BIP_BLOCK_INTEGRITY;
+	if (bio_integrity_add_page(bio, virt_to_page(buf), len,
+			offset_in_page(buf)) < len)
+		goto err_end_io;
+
+	return true;
+
+err_end_io:
+	bio->bi_status = BLK_STS_RESOURCE;
+	bio_endio(bio);
+	return false;
+}
 /**
  * bio_integrity_prep - Prepare bio for integrity I/O
  * @bio:	bio to prepare
@@ -443,6 +478,10 @@ bool bio_integrity_prep(struct bio *bio)
 	if (bio_integrity(bio))
 		return true;
 
+	if (bio->bi_opf & REQ_INTEGRITY_OFFLOAD &&
+	    bi->offload_type != BLK_INTEGRITY_OFFLOAD_NONE)
+		return  bio_integrity_offload(bio);
+
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 		if (bi->flags & BLK_INTEGRITY_NOVERIFY)
@@ -522,7 +561,8 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 		container_of(work, struct bio_integrity_payload, bip_work);
 	struct bio *bio = bip->bip_bio;
 
-	blk_integrity_verify(bio);
+	if (!(bio->bi_opf & REQ_INTEGRITY_OFFLOAD))
+		blk_integrity_verify(bio);
 
 	kfree(bvec_virt(bip->bip_vec));
 	bio_integrity_free(bio);
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 2d05421f0fa5..9eca1ad5d5e6 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -452,6 +452,9 @@ void blk_integrity_prepare(struct request *rq)
 
 	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
 		return;
+	if ((rq->cmd_flags & REQ_INTEGRITY_OFFLOAD) &&
+	    (bi->offload_type != BLK_INTEGRITY_OFFLOAD_NONE))
+		return;
 
 	if (bi->csum_type == BLK_INTEGRITY_CSUM_CRC64)
 		ext_pi_type1_prepare(rq);
@@ -466,6 +469,10 @@ void blk_integrity_complete(struct request *rq, unsigned int nr_bytes)
 	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
 		return;
 
+	if ((rq->cmd_flags & REQ_INTEGRITY_OFFLOAD) &&
+	    (bi->offload_type != BLK_INTEGRITY_OFFLOAD_NONE))
+		return;
+
 	if (bi->csum_type == BLK_INTEGRITY_CSUM_CRC64)
 		ext_pi_type1_complete(rq, nr_bytes);
 	else
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dce7615c35e7..65615dbc3e2d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -378,6 +378,7 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
+	__REQ_INTEGRITY_OFFLOAD,/* I/O that wants HW integrity offload */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -399,6 +400,8 @@ enum req_flag_bits {
 #define REQ_NOMERGE	(__force blk_opf_t)(1ULL << __REQ_NOMERGE)
 #define REQ_IDLE	(__force blk_opf_t)(1ULL << __REQ_IDLE)
 #define REQ_INTEGRITY	(__force blk_opf_t)(1ULL << __REQ_INTEGRITY)
+#define REQ_INTEGRITY_OFFLOAD \
+			(__force blk_opf_t)(1ULL << __REQ_INTEGRITY_OFFLOAD)
 #define REQ_FUA		(__force blk_opf_t)(1ULL << __REQ_FUA)
 #define REQ_PREFLUSH	(__force blk_opf_t)(1ULL << __REQ_PREFLUSH)
 #define REQ_RAHEAD	(__force blk_opf_t)(1ULL << __REQ_RAHEAD)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7ac153e4423a..ef061eb4cb73 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -113,6 +113,12 @@ enum blk_integrity_checksum {
 	BLK_INTEGRITY_CSUM_CRC64	= 3,
 } __packed ;
 
+enum blk_integrity_offload {
+	BLK_INTEGRITY_OFFLOAD_NONE	= 0,
+	BLK_INTEGRITY_OFFLOAD_NO_BUF	= 1,
+	BLK_INTEGRITY_OFFLOAD_BUF	= 2,
+} __packed;
+
 struct blk_integrity {
 	unsigned char				flags;
 	enum blk_integrity_checksum		csum_type;
@@ -120,6 +126,7 @@ struct blk_integrity {
 	unsigned char				pi_offset;
 	unsigned char				interval_exp;
 	unsigned char				tag_size;
+	unsigned char				offload_type;
 };
 
 typedef unsigned int __bitwise blk_mode_t;
-- 
2.25.1


