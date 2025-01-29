Return-Path: <linux-btrfs+bounces-11141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F208DA21ED1
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6314A162544
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABDD1AAA1F;
	Wed, 29 Jan 2025 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sGEQobN0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35EE13D503
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159853; cv=none; b=cj6vDxtfh1Z20Ucq20Tylwk9YiT9NBUAHRq8sFMC66pkJndA/krp4/YvcdcSXTXsmLHELR3hOO+blTYErhpOuvIX39UTEnPrA0ipY3EqG0PN7Ol2Gyp6FEV7hMsOmZJLuuNRsrE1nRJ7LfZOv/saTDLUYWEuE0MXYqL0ZjzPbR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159853; c=relaxed/simple;
	bh=AdkfWA6lJaUIlOkpVnTFbRzROWLDA1Mk/RYZC8J2drY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=sxuRW3ORU4mpq8JxUx0VMoGWzGK3YnT1g1geggfH214BVmxlqQ9JebSNPjlTsM19exZiuCCS9R1y7b+NwT6r8xDxb/xY7GbvwmnCCUkCEP8QmoJliIhalo0E1X5akL14or3fshXZKH6v7rlEP9uiwvFOfh5xS8S3YZJca5r2MB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sGEQobN0; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250129141047epoutp012f0564925d3d5d2406f811f0e3958e99~fLywek-Qk0306003060epoutp01J
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 14:10:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250129141047epoutp012f0564925d3d5d2406f811f0e3958e99~fLywek-Qk0306003060epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738159847;
	bh=ST7TI/y+PLKSL5LRzxWbv6tzS6BXzdbRGX2mF/YjYwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGEQobN0AF2XCIM9GZZwNH3d70TGLDWzdaOoplRnKiRs7rzPEHqQCxns2nq4tsi30
	 z25p4SHy1zFyZ67e1xTdH4CPYbNpkzD0sZ3sFSyDcBXSMkYxyj1m1bEhHbTE2pE2xM
	 mW5u8ZesysBNr8wdpkt0Y8ueyj0zp7xjS9Jm60Ck=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250129141046epcas5p35eaafd908a19ad7c36fcdc9a75542852~fLyvdQ5lh2837028370epcas5p3U;
	Wed, 29 Jan 2025 14:10:46 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YjkZs31rfz4x9Pp; Wed, 29 Jan
	2025 14:10:45 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	30.9F.29212.5E63A976; Wed, 29 Jan 2025 23:10:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250129141044epcas5p422461bd3630814884c91fc0f4207edde~fLyt7beoy1416814168epcas5p4m;
	Wed, 29 Jan 2025 14:10:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250129141044epsmtrp1ab9dd28959447241d4bccf0273e947d4~fLyt6hsYP0553305533epsmtrp18;
	Wed, 29 Jan 2025 14:10:44 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-8a-679a36e51763
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E2.F5.18949.4E63A976; Wed, 29 Jan 2025 23:10:44 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250129141043epsmtip2f7ed1e3bfa59072eb1baeff6ac801a89~fLysVmGYX2314623146epsmtip2R;
	Wed, 29 Jan 2025 14:10:43 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de
Cc: linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [RFC 3/3] btrfs: add checksum offload
Date: Wed, 29 Jan 2025 19:32:07 +0530
Message-Id: <20250129140207.22718-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmlu5Ts1npBh/+CVqsvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWR/+/BUoeusZosfeWtsWlxyvYLeYve8ruwO0xsfkdu8fl
	s6Uem1Z1snlsXlLvsftmA5tH35ZVjB7rt1xl8ZiweSOrx+dNcgGcUdk2GamJKalFCql5yfkp
	mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCnKimUJeaUAoUCEouLlfTtbIry
	S0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM/qnHWEpuCNf0bJjJ3sD
	4xmpLkZODgkBE4lzzYfYuhi5OIQE9jBKvN54nxHC+cQo8WX5OTaQKiGBb4wSf3ZxwHQsPHuA
	BaJoL6PEtb75UO2fGSWm3twDlOHgYBPQlLgwuRSkQUQgQ+L46VnMIDXMArMZJda1/mcGSQgL
	6En0zmhkArFZBFQlGi6+B9vGK2Ah8WvSEyaIbfISMy99ZwexOQUsJXa/m8sEUSMocXLmExYQ
	mxmopnnrbLAFEgJzOSRutn1gh2h2kZh0fz0zhC0s8er4Fqi4lMTL/jYoO1viwaMHLBB2jcSO
	zX2sELa9RMOfG6wgzzADPbN+lz7ELj6J3t8gt3EAlfBKdLQJQVQrStyb9BSqU1zi4YwlULaH
	xOM/DayQ8OlhlDi9uYttAqP8LCQvzELywiyEbQsYmVcxSqUWFOempyabFhjq5qWWw2M2OT93
	EyM4yWoF7GBcveGv3iFGJg7GQ4wSHMxKIryx52akC/GmJFZWpRblxxeV5qQWH2I0BQbyRGYp
	0eR8YJrPK4k3NLE0MDEzMzOxNDYzVBLnbd7Zki4kkJ5YkpqdmlqQWgTTx8TBKdXAlOFT8n/Z
	y6X8wmItK73umop+NDsy3/C1ouje6as4DlSqr1jDOy9n4rrAhCjBNt+PN5s3MRn+bio2YzxY
	b+N2+2Pu0ezCAIZ+EY1C91P8+/iDd5m8s8zhYHeNqInLYE7xn5L38OJj5+3cP56d2nclbpXB
	hP/by/o3vtteeZvXdkPTYYUj3FObAqw1XTvCbjV3q6zdJWm1Lsmx6v4UVqHdc9/lX69lfO1X
	HPA1o6z754sHcgvirGbvWCzAzcU8s1at+4t61psF8UH8K+QUtzqwrr/d8/W4i+Az51PL9znb
	37R484Fxv1HClPONh1N8bnH1q3n5t2w1uGixcqL95a/Lc7zdWZV4r4hNZHy0QOO9EktxRqKh
	FnNRcSIABOScPTsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvO4Ts1npBk+Pm1msvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWR/+/BUoeusZosfeWtsWlxyvYLeYve8ruwO0xsfkdu8fl
	s6Uem1Z1snlsXlLvsftmA5tH35ZVjB7rt1xl8ZiweSOrx+dNcgGcUVw2Kak5mWWpRfp2CVwZ
	/dOOsBTcka9o2bGTvYHxjFQXIyeHhICJxMKzB1i6GLk4hAR2M0rsfPicFSIhLtF87Qc7hC0s
	sfLfc3aIoo+MEvPm7AVyODjYBDQlLkwuBakRESiQmLj/CdggZoH5jBLHN+xiAUkIC+hJ9M5o
	ZAKxWQRUJRouvmcDsXkFLCR+TXrCBLFAXmLmpe9gyzgFLCV2v5vLBDJfCKhmw5QkiHJBiZMz
	n4CNZAYqb946m3kCo8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIE
	R4eW1g7GPas+6B1iZOJgPMQowcGsJMIbe25GuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697
	U4QE0hNLUrNTUwtSi2CyTBycUg1Mwn6M7zQPie1OerCqzidX6an866Y87ddtMr7vW+YFxxn+
	jjDgWXf67dFXc+f8UTmkV8gprq1/4uPy+c/LYhLOWnke9QnaErjG80d735rJBSG+ExWmNn52
	PxEjuPXpqXdbL2VciywO03h7R7frRb50+UnjXn6zhG2VIQcXZfwLiStIUdZxYQn6lGXZfuWF
	orLVxJPqSZZ56lUbnrUpKBy0ed58lfPnrSUTJQ5Nby5MXT2NK+L7eiX2ZZ8/l/GtF5xzQ0px
	33mTxf6vJL+k3rz24NG6iIfRrft0nj9aXbR8dpX8tlcmG4ur9Wc8ik9/e/botvPnGdmuHzG8
	uWUGR/CUOGs74+8av0QK561asb3TX4mlOCPRUIu5qDgRACWg5cX9AgAA
X-CMS-MailID: 20250129141044epcas5p422461bd3630814884c91fc0f4207edde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141044epcas5p422461bd3630814884c91fc0f4207edde
References: <20250129140207.22718-1-joshi.k@samsung.com>
	<CGME20250129141044epcas5p422461bd3630814884c91fc0f4207edde@epcas5p4.samsung.com>

Add new mount option 'datsum_offload'.

When passed
- Data checksumming at the FS level is disabled.
- Data checksumming at the device level is enabled. This is done by
setting REQ_INTEGRITY_OFFLOAD flag for data I/O if the underlying device is
capable.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/btrfs/bio.c   | 12 ++++++++++++
 fs/btrfs/fs.h    |  1 +
 fs/btrfs/super.c |  9 +++++++++
 3 files changed, 22 insertions(+)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 7ea6f0b43b95..811d89c64991 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bio.h>
+#include <linux/blk-integrity.h>
 #include "bio.h"
 #include "ctree.h"
 #include "volumes.h"
@@ -424,6 +425,15 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
+static void btrfs_prep_csum_offload_hw(struct btrfs_device *dev, struct bio *bio)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+
+	if (btrfs_test_opt(dev->fs_info, DATASUM_OFFLOAD) &&
+	    bi && bi->offload_type != BLK_INTEGRITY_OFFLOAD_NONE)
+		bio->bi_opf |= REQ_INTEGRITY_OFFLOAD;
+}
+
 static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 {
 	if (!dev || !dev->bdev ||
@@ -435,6 +445,8 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 	}
 
 	bio_set_dev(bio, dev->bdev);
+	if (!(bio->bi_opf & REQ_META))
+		btrfs_prep_csum_offload_hw(dev, bio);
 
 	/*
 	 * For zone append writing, bi_sector must point the beginning of the
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 79a1a3d6f04d..88e493967100 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -228,6 +228,7 @@ enum {
 	BTRFS_MOUNT_NOSPACECACHE		= (1ULL << 30),
 	BTRFS_MOUNT_IGNOREMETACSUMS		= (1ULL << 31),
 	BTRFS_MOUNT_IGNORESUPERFLAGS		= (1ULL << 32),
+	BTRFS_MOUNT_DATASUM_OFFLOAD		= (1ULL << 33),
 };
 
 /*
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7dfe5005129a..d0d5b35c2df9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -121,6 +121,7 @@ enum {
 	Opt_treelog,
 	Opt_user_subvol_rm_allowed,
 	Opt_norecovery,
+	Opt_datasum_offload,
 
 	/* Rescue options */
 	Opt_rescue,
@@ -223,6 +224,7 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	fsparam_string("compress-force", Opt_compress_force_type),
 	fsparam_flag_no("datacow", Opt_datacow),
 	fsparam_flag_no("datasum", Opt_datasum),
+	fsparam_flag_no("datasum_offload", Opt_datasum_offload),
 	fsparam_flag("degraded", Opt_degraded),
 	fsparam_string("device", Opt_device),
 	fsparam_flag_no("discard", Opt_discard),
@@ -323,6 +325,10 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
 		}
 		break;
+	case Opt_datasum_offload:
+		btrfs_set_opt(ctx->mount_opt, NODATASUM);
+		btrfs_set_opt(ctx->mount_opt, DATASUM_OFFLOAD);
+		break;
 	case Opt_datacow:
 		if (result.negated) {
 			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
@@ -1057,6 +1063,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",degraded");
 	if (btrfs_test_opt(info, NODATASUM))
 		seq_puts(seq, ",nodatasum");
+	if (btrfs_test_opt(info, DATASUM_OFFLOAD))
+		seq_puts(seq, ",datasum_offload");
 	if (btrfs_test_opt(info, NODATACOW))
 		seq_puts(seq, ",nodatacow");
 	if (btrfs_test_opt(info, NOBARRIER))
@@ -1434,6 +1442,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
 	btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
 	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
+	btrfs_info_if_set(info, old, DATASUM_OFFLOAD, "setting datasum offload to the device");
 	btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
 	btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
 	btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");
-- 
2.25.1


