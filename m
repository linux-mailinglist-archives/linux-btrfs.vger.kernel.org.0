Return-Path: <linux-btrfs+bounces-11143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F38A21EBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7D97A2729
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412451C5F25;
	Wed, 29 Jan 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XTt+YwcR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5271814A635
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159855; cv=none; b=qLFPyMtPlojyxgpInqGr2VdoR7OQj3AcOPKimsPUfQJgKEzaVWPT74gEr2STcN6rZdN82b+TS5V77JZHicAUCBpsR4NV3bQfaKvnZeV6TvyNyyPs0e7xS+zNs182cCAHTXP64NH6Rker+BeSgZUFdMQidrtZ/IVqBkJEDXqIaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159855; c=relaxed/simple;
	bh=RwATSeYpEaFd9Xwcv/hMns0UMj49n44jf+AHHNL0c/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=i4Gg3dASfP5Laku+9tq4YVCcHJiAVFtjOu3HzFuj6ap/DmC4Pb0ek/JFeDm2/OmiGGkV8jrzD1e7u2sjPy6pDNypUw0FRFrWr3qH7b6X0EOSr6qddOKaf5bzF4NgwBIJ6RoYqXadM9j5c1KRIrfXo3IAccc9Gbwe38DOTQX44vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XTt+YwcR; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250129141045epoutp0261ffc2d69b9c6a33367f1663854edf76~fLyuIDHFR1148811488epoutp02W
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 14:10:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250129141045epoutp0261ffc2d69b9c6a33367f1663854edf76~fLyuIDHFR1148811488epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738159845;
	bh=Fl4Rb8PzwWj7kcAlJT0UhpUfE7+NyjqHaHIxLHkLbzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTt+YwcR3T3azIu1cVklbCeJUDdjAE65uZ7Pd9ObmOzMJfkRxQMMhdYfLHyOycCzh
	 Gpj2SEDtugpnDlnsPxQBS7C2Fuxe98tigt4mJIQYB2cRDbUeP1jw5q/I4AcrevTjVy
	 RF7EWtrcY24lYnOWvlfPT7W35wW6p4PHYkMc/xuk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250129141044epcas5p176546b9b902af22da2182bc0d81b6cae~fLytwGLo91214312143epcas5p1c;
	Wed, 29 Jan 2025 14:10:44 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YjkZq4PjWz4x9Pq; Wed, 29 Jan
	2025 14:10:43 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.E1.19933.3E63A976; Wed, 29 Jan 2025 23:10:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250129141043epcas5p3676d3c9dcf9f70939056cab89e24cca4~fLysUSG3N2144421444epcas5p36;
	Wed, 29 Jan 2025 14:10:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250129141043epsmtrp2e609f30144db30a1ddb5c31fc626a3c8~fLysTmTVM1194411944epsmtrp2L;
	Wed, 29 Jan 2025 14:10:43 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-a0-679a36e3a8f4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	12.F5.18949.3E63A976; Wed, 29 Jan 2025 23:10:43 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250129141041epsmtip27a53dcffcf25ca7a51363a5391580a6e~fLyqq5WuM2314623146epsmtip2Q;
	Wed, 29 Jan 2025 14:10:41 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de
Cc: linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [RFC 2/3] nvme: support integrity offload
Date: Wed, 29 Jan 2025 19:32:06 +0530
Message-Id: <20250129140207.22718-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmuu5js1npBu8PK1msvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWR/+/BUoeusZosfeWtsWlxyvYLeYve8ruwO0xsfkdu8fl
	s6Uem1Z1snlsXlLvsftmA5tH35ZVjB7rt1xl8ZiweSOrx+dNcgGcUdk2GamJKalFCql5yfkp
	mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCnKimUJeaUAoUCEouLlfTtbIry
	S0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM5Z232Mp2CBccXhnUAPj
	Sf4uRk4OCQETiQ/PZrF2MXJxCAnsZpRoeveNEcL5xCix6ewUJgjnG6PEsV93mGBapqw5yAaR
	2Msose3oBWYI5zOjxNs3LUAZDg42AU2JC5NLQRpEBDIkjp+eBVbDLDCbUWJd639mkISwgJFE
	y+d3bCA2i4CqxIUVJ1hBbF4BC4mrJ9+xQ2yTl5h56TuYzSlgKbH73VwmiBpBiZMzn7CA2MxA
	Nc1bZ4MtkBCYyyHx+Od/qGYXidMneqDOFpZ4dXwLVFxK4vO7vWwQdrbEg0cPWCDsGokdm/tY
	IWx7iYY/N1hBnmEGemb9Ln2IXXwSvb+fMIGEJQR4JTrahCCqFSXuTXoK1Sku8XDGEijbQ2Ll
	95cskPDpYZQ4uGMf0wRG+VlIXpiF5IVZCNsWMDKvYpRMLSjOTU8tNi0wyksth0dscn7uJkZw
	itXy2sH48MEHvUOMTByMhxglOJiVRHhjz81IF+JNSaysSi3Kjy8qzUktPsRoCgzjicxSosn5
	wCSfVxJvaGJpYGJmZmZiaWxmqCTO27yzJV1IID2xJDU7NbUgtQimj4mDU6qBqfvwhA17D3mt
	PLRop7R/zeklnx77+FZP+tmy8vldn411vcu7nhRuY636+zZxnbmVYdaJ8ynnmN7ZFOz4terT
	5jxRz7lrnkQFb+FRXnFvow7DGk2roHfGVckX98Q8MSibJdbcFvhtd9YDe8/pzEtzP4ml570s
	v/IgRPbIDNZ2A0mLPzWaC9bLtZ9wm5dQ03U41rwhZNEkq/xUbnVf/Svmt/J8tl7JDP6X/Geh
	9IHgXJfXd60ux1mYff4l+vUWu0bkm7S99+vFr9yb08RupCnNVaC+Il7supmbZeZvzkb/iM+P
	pqjFqWp7pX/49MldZvGhi9qdKRP1VMN9JoT6xHR8uvhcZtnl+zm2e9683hito8RSnJFoqMVc
	VJwIAAzbp+w6BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvO5js1npBs9uslqsvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWR/+/BUoeusZosfeWtsWlxyvYLeYve8ruwO0xsfkdu8fl
	s6Uem1Z1snlsXlLvsftmA5tH35ZVjB7rt1xl8ZiweSOrx+dNcgGcUVw2Kak5mWWpRfp2CVwZ
	S7vvsRRsEK44vDOogfEkfxcjJ4eEgInElDUH2boYuTiEBHYzSkzZOpUNIiEu0XztBzuELSyx
	8t9zdoiij4wSJ+YdZeli5OBgE9CUuDC5FKRGRKBAYuL+JywgNcwC8xkljm/YxQKSEBYwkmj5
	/A5sKIuAqsSFFSdYQWxeAQuJqyffQS2Ql5h56TuYzSlgKbH73VwmkPlCQDUbpiRBlAtKnJz5
	BGwkM1B589bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4
	NrS0djDuWfVB7xAjEwfjIUYJDmYlEd7YczPShXhTEiurUovy44tKc1KLDzFKc7AoifN+e92b
	IiSQnliSmp2aWpBaBJNl4uCUamBaOC8h7EHHrTD+gP9VyxkmFsTlHRMocpwnLadwM9b2c+T9
	ymC2Jvb6tM97Ze7ubds2Y5nSbYcLcwvypm9b2tL0iWFugc3HCpGOCbd6hQKWu856dPKGEy+X
	bq3w02NTCnafafhilanPui/3ROkEhRPT5Q7kiixf8fzv8x+qpfk5FRXRnydG2C18aG9em8yh
	OKP9bqx+iblIMo/N189xPp989MtZxP75P1u6KelEfIV0CPvs9boa2pqtuVvPHFql+dQvk/2X
	egd3zBs7tp8spzYoqJdM/JaYuSTyU4XKA4m1Gb80Dmf4Z369ZcMkJsGxK/e7cZwg/wLbSYL/
	t2/LuvS4eJ2O2br6yvxLJedkXiqxFGckGmoxFxUnAgCrqL8v/AIAAA==
X-CMS-MailID: 20250129141043epcas5p3676d3c9dcf9f70939056cab89e24cca4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141043epcas5p3676d3c9dcf9f70939056cab89e24cca4
References: <20250129140207.22718-1-joshi.k@samsung.com>
	<CGME20250129141043epcas5p3676d3c9dcf9f70939056cab89e24cca4@epcas5p3.samsung.com>

Register the integrity offload with the block layer if it is supported
by the device.

Serve incoming offload requests by setting PRACT and GUARD check.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 24 ++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f4b8d6a0984a..1fae0a6a932e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -984,6 +984,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 {
 	u16 control = 0;
 	u32 dsmgmt = 0;
+	u8  type;
 
 	if (req->cmd_flags & REQ_FUA)
 		control |= NVME_RW_FUA;
@@ -1022,7 +1023,21 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
 		}
+		if (req->cmd_flags & REQ_INTEGRITY_OFFLOAD) {
+			type = ns->head->pi_offload_type;
 
+			if (type == BLK_INTEGRITY_OFFLOAD_NONE ||
+			    (type == BLK_INTEGRITY_OFFLOAD_BUF &&
+			     !blk_integrity_rq(req))) {
+				WARN_ON_ONCE(1);
+				return BLK_STS_NOTSUPP;
+			}
+
+			control |= NVME_RW_PRINFO_PRACT |
+				   NVME_RW_PRINFO_PRCHK_GUARD;
+			/* skip redundant processing for offload */
+			goto out;
+		}
 		if (bio_integrity_flagged(req->bio, BIP_CHECK_GUARD))
 			control |= NVME_RW_PRINFO_PRCHK_GUARD;
 		if (bio_integrity_flagged(req->bio, BIP_CHECK_REFTAG)) {
@@ -1037,6 +1052,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		}
 	}
 
+out:
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
 	return 0;
@@ -1846,6 +1862,14 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 
 	bi->tuple_size = head->ms;
 	bi->pi_offset = info->pi_offset;
+	if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE) {
+		if (head->ms == head->pi_size)
+			bi->offload_type = BLK_INTEGRITY_OFFLOAD_NO_BUF;
+		else
+			bi->offload_type = BLK_INTEGRITY_OFFLOAD_BUF;
+		head->pi_offload_type = bi->offload_type;
+	}
+
 	return true;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7be92d07430e..add04583b040 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -476,6 +476,7 @@ struct nvme_ns_head {
 	u16			pi_size;
 	u8			pi_type;
 	u8			guard_type;
+	u8			pi_offload_type;
 	struct list_head	entry;
 	struct kref		ref;
 	bool			shared;
-- 
2.25.1


