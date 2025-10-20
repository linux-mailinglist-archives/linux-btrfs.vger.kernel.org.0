Return-Path: <linux-btrfs+bounces-18061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB63ABF1E64
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 16:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B833E421A0F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB6220F5E;
	Mon, 20 Oct 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="njgosrKv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1307FDDC5
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971452; cv=none; b=USlw9y1Puo6pBiAY3AD7rAUYgg3qHVenqb3piXEktcOadh1heGay/OM2i2SQV9iGVY1DdN8dKVkdz5tfR1TspQr7R+vGT8E0kfoIVNGYYH47phQtVXUiWW2eWN1OGwAkxMK6qrO03RYYWwHVZ7AkB/fWsq6HH733d+IgeIlfR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971452; c=relaxed/simple;
	bh=k9KvN0OFKCJUWJxD40CcRTTuH6NiWMBudZAyF6pCvY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OznBSgAGbd3u/KTmfevIGzQhqXABVeWmbSTiKoQ7cir1l2dxuNgXzYJped7WWKofiYMURV1jEMsrXAVk2spieCvYJPK4sVjrox6xslMU/ZN+H6pd2sGyblcw/bic7/1mlsLM/c8y+edjWeNZjxGsnkywDYWoXyS5jld37NFkVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=njgosrKv; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59K4gjPu133176
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 07:44:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Ok47DknFlhtWA7VtVhZOhx9DX/WpTLnuDg2vmf+PDL0=; b=njgosrKvEvdF
	e8kzUBKtuKA+fMQCdjgclLTxz/USh0upm75T8eMZS6bRAeP1njFV7uYtSDjj11Rq
	f8dSce7aokKXtdHDnN6+VPkR0QOD9X0C7oPzY7ezy8CgexrOA0I1CaWSBqWFXpbz
	PZuR2XoLen8ECfNQWgxsUA41vNxgCcWI2msHCB8ZelPQwL5jjiyOjmF8gTp2VTv0
	7J71Z/8zyWO42H38EKD3NZZMzJJ8Bv8LU6jC3lIXoisoD4tkRKco83yiIaxvxbpU
	8W3/p9kkQyum3D7++UuDhZ8nkDQhF3xAzUZSN5meuDAtzSfYbiQKiS762yzLoZgI
	61PVJDUYDg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49we9xamrb-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 07:44:07 -0700 (PDT)
Received: from twshared10560.01.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 20 Oct 2025 14:43:59 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id F1AA62E64BDB; Mon, 20 Oct 2025 07:43:56 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <dsterba@suse.com>, <cem@kernel.org>, <linux-btrfs@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Chris Mason <clm@fb.com>
Subject: [PATCH 2/2] btrfs: handle bio split errors for append
Date: Mon, 20 Oct 2025 07:43:56 -0700
Message-ID: <20251020144356.693288-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020144356.693288-1-kbusch@meta.com>
References: <20251020144356.693288-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jIQIoo6QjIP9HpU96fWY8LZbQ9mTAEBV
X-Authority-Analysis: v=2.4 cv=UoJu9uwB c=1 sm=1 tr=0 ts=68f64ab8 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8
 a=ABllRBBG4x9hLAaS6EQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDEyMiBTYWx0ZWRfX2bhO0Il9KH5m
 9B6dirpidwRdETNitgf2u8iRBPmvKaJ2EltZId4IuLQPqY6WvuI3w8kSwKSeK1rgbXNXgC5v9sw
 MZlxpU1DtZljqZp9DgxV+2h5/Q5mfFX5ue1PpgFolxfA+gTIP8LOKK0x1tUVegexFaWnF7zpHOg
 IAytR3gpy9IMHzpz0yqiaxztqDWShDxoF4hH8Kw3/i1dqJy1aqLVV23MMHzXPGYIErlSaIid22Z
 xzjFKl8955UXgMUEFjrQm8Fmr1faAS4jb8ZaZ1eDjF5FmVPBkbuOI75C+x97cg+Lnn+rgQN5vqB
 /LnQUqUMSiuuVn5Imboa9lnMDm1d4ZMEDchlgzUiw7K0X838fakS5yUJ+WZaLF/67r608z23jwJ
 QWBq6SR6IlDWZ/dm7WwBT9lSQj17gQ==
X-Proofpoint-GUID: jIQIoo6QjIP9HpU96fWY8LZbQ9mTAEBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

bio_split_rw_at may return a negative error value if the bio can not be
split into anything that adheres to the block device's queue limits.
Check for that condition and fail the bio accordingly.

Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/btrfs/bio.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 21df48e6c4fa2..0ca86526a8bd8 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -646,6 +646,8 @@ static u64 btrfs_append_map_length(struct btrfs_bio *=
bbio, u64 map_length)
 	sector_offset =3D bio_split_rw_at(&bbio->bio, &bbio->fs_info->limits,
 					&nr_segs, map_length);
 	if (sector_offset) {
+		if (unlikely(sector_offset < 0))
+			return sector_offset;
 		/*
 		 * bio_split_rw_at() could split at a size smaller than our
 		 * sectorsize and thus cause unaligned I/Os.  Fix that by
@@ -685,8 +687,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbi=
o, int mirror_num)
 	}
=20
 	map_length =3D min(map_length, length);
-	if (use_append)
+	if (use_append) {
 		map_length =3D btrfs_append_map_length(bbio, map_length);
+		if (IS_ERR_VALUE(map_length)) {
+			status =3D errno_to_blk_status(map_length);
+			btrfs_bio_counter_dec(fs_info);
+			goto end_bbio;
+		}
+	}
=20
 	if (map_length < length) {
 		struct btrfs_bio *split;
--=20
2.47.3


