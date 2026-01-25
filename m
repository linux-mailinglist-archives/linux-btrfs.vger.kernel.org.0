Return-Path: <linux-btrfs+bounces-20997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF4YFx0admnXLgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-20997-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 14:26:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA7A80B6D
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 14:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 005A4300821A
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 13:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E6531BCAE;
	Sun, 25 Jan 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tHI2f8Ym"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D33161AE
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769347309; cv=none; b=gM6mzg1Jg71etaRTxE1DDIvIz/f5222UD08lO3YutFr8ofaVVDdjUo1wjAP+FqXBGH3vJG7TAF1Nk55EXSZ1R895epELVEPsihh2ZOvq8QSfxY7VsSt1XovVukTAV1w7NDmb5UDMzPkwiPGNG0BJygsU6H3WU0i6riWHgjHrkGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769347309; c=relaxed/simple;
	bh=slJ8/lcwHZ2AEUfL9EG242FYz/FP01j/Bhsy0r5fpuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XC5Sn/shhxwwY9yVe6Qz1yg5IoKlMldb28B9bPNKoh8Dd+r3f6lGbSK1Kfwxxwd5638AqvbsrkrvRHlp3F840xm2Ou+aWp4fh2whzRZyt783b3VY0H4UitLCyoEQOHuIKQHT0s9lWG0g+cZgafFeen7gDsnN/b+Ihv/qvt/p5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tHI2f8Ym; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60P4jnwk1624870;
	Sun, 25 Jan 2026 05:21:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=843EY/AWPb3+9c937X6eUKRVZMVuBJaqzgJ+YUBYHbI=; b=tHI2f8YmlWPQ
	3Z384Hc6A7AFxmfnEGK/jdvF1RPA9HNf+h9Bc/fNSx85lPQRqrKr2QPMj8+bezwD
	1clbdUYgeU+4Pk6mm7zllM4mLMe7suADShHMeUY5MJqvmx9j8/FoKFuxy4hF0JM8
	R6xpNKhZTMCYvAtv7+2NJOjsntBjFK7yXl34vVNMEAYIwV23WBdX1TH035kdjlEA
	07bhdMeSQ9XTOtPebDefAKZqGSMqkecd1HtGIQ+YZNG2e/YbRIUBO0rfpEIAQuCD
	ndlTl3Ys6O5TDbs98dvwrUH9sf+97PDZ6E1QRaq4gQRMNDaqgXGoxN46CZTIKSd1
	L7H46kEcbA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bvvfex1s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Jan 2026 05:21:43 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sun, 25 Jan 2026 13:21:42 +0000
From: Chris Mason <clm@meta.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
CC: <linux-btrfs@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Naohiro
 Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 1/5] btrfs: zoned: don't zone append to conventional zone
Date: Sun, 25 Jan 2026 05:12:11 -0800
Message-ID: <20260125132120.2525146-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204124227.431678-2-johannes.thumshirn@wdc.com>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com> <20251204124227.431678-2-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZxGzBRqwc5hcgyI8T1SbEXnEJPrDTNxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI1MDExMSBTYWx0ZWRfX9vlHHJ5W4q05
 8Yn+lYyuw6W9XohDU5HN4HnC5bCtwG7BRz4pDgXweQNAtW+yW7YTNrskTzPbO1qvM6DclZ5ILkX
 QSSMZNKZcVChifLlHe8OOMhicCEovIMknWH5X+zVCCXilMdNyb01QXnSDGIr+udFwWeDw7VrsGF
 oAR/989XaewWu55YGr4hbcEroiYFZAuoj4FfOnFVVhUM2hHii6b3B1+P/aBDt3S4fS8BWpGMs3t
 HK3G4E/XzLyOreNDBuXzq3NvF+yIdayktEBS4FD+HGsOZkuIQfNgGUaISGe1rputeVPGpncCFgS
 l2Cy8y6I4LhukkP8aJn2rNtsVIVnEjtW+gsvzjXUPml5pcoCIvpN95Wbt+sfwzh1YMGUer3cIY0
 50rtqKN3Uu1UbsklArRwhSg02Exa6z0YXGEnp1/Ozo9GqteL3mGl/03WcYkb1Mfm1IAiGbibrn0
 iz8Tx0GlWunhM81bpoQ==
X-Authority-Analysis: v=2.4 cv=AsfjHe9P c=1 sm=1 tr=0 ts=697618e7 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=JF9118EUAAAA:8
 a=TLjGChBewIIjui6yeJkA:9 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: ZxGzBRqwc5hcgyI8T1SbEXnEJPrDTNxz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-25_03,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20997-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: CFA7A80B6D
X-Rspamd-Action: no action

Johannes Thumshirn <johannes.thumshirn@wdc.com> wrote:
> In case of a zoned RAID, it can happen that a data write is targeting a
> sequential write required zone and a conventional zone. In this case the
> bio will be marked as REQ_OP_ZONE_APPEND but for the conventional zone,
> this needs to be REQ_OP_WRITE.
> 
> The setting of REQ_OP_ZONE_APPEND is deferred to the last possible time in
> btrfs_submit_dev_bio(), but the decision if we can use zone append is
> cached in btrfs_bio.

Hi everyone,

I ran linux-next through some AI patch review, and this one was flagged.

Apologies in advance if this is wonky, the text below is based on the
linux-next version of the commit and the mailing list has something slightly
different.  But I think the overall result is still valid, it doesn't look
like btrfs_split_bio() properly copies can_append?

It still seems valid after the enum bit transition later in this thread.

> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c

[ ... ]

> @@ -747,7 +750,6 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  	u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>  	u64 length = bio->bi_iter.bi_size;
>  	u64 map_length = length;
> -	bool use_append = btrfs_use_zone_append(bbio);
>  	struct btrfs_io_context *bioc = NULL;
>  	struct btrfs_io_stripe smap;
>  	blk_status_t status;
> @@ -775,8 +777,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  	if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
>  		bbio->orig_logical = logical;
>
> +	bbio->can_use_append = btrfs_use_zone_append(bbio);
> +
>  	map_length = min(map_length, length);
> -	if (use_append)
> +	if (bbio->can_use_append)
>  		map_length = btrfs_append_map_length(bbio, map_length);
>
>  	if (map_length < length) {
>  		struct btrfs_bio *split;
>
>  		split = btrfs_split_bio(fs_info, bbio, map_length);

When a bio is split here, btrfs_split_bio() creates the new split bio via
btrfs_bio_init() which zeroes the struct with memset. Looking at
btrfs_split_bio(), it copies csum_search_commit_root from the original but
does not copy can_use_append.

After the split, the code does:

    bbio = split;
    bio = &bbio->bio;

This means the split bio (with can_use_append = false) gets submitted, not
the original. In btrfs_submit_dev_bio(), the condition:

    if (btrfs_bio(bio)->can_use_append && btrfs_dev_is_sequential(...))

Will be false for the split bio even when writing to a sequential zone.
Does the split bio need to inherit can_use_append from the original? The
old code used a local variable use_append which persisted across the split.

> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -92,6 +92,9 @@ struct btrfs_bio {
>  	/* Whether the csum generation for data write is async. */
>  	bool async_csum;
>
> +	/* Whether the bio is written using zone append. */
> +	bool can_use_append;


