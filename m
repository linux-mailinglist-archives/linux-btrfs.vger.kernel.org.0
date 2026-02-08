Return-Path: <linux-btrfs+bounces-21493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPquNobYiGkCxQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21493-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:40:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 626E5109E74
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63935301992B
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E332F9D9A;
	Sun,  8 Feb 2026 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="iIvCNNPC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB51C3C1F
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770575937; cv=none; b=W0TzWNzPPicgu+mJhqZGKZuZS5SBKuTxI1wMG+8vRzryKdW+LyV5ofDmguQ+6KvyP07OyYEBI5Rfs0MIz1AOHNC1EWmHbLvvOJ9bCvQl9iwjIhRxlegCV2Ql7xukF3sSpBTlpOKNEJDHwt4g1ZZ8pJvm8S+YsSbE8QjvGMv1uuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770575937; c=relaxed/simple;
	bh=0+SdzJuA7jJaLCRHdTQPiiZweQQqKl7ebWx521/Eblc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSMsWGAHEFRm3mxeUAc/cd8nvsHN64fg9W5zWChSAVBcRmrjor+H8evPva+qyKBaWgxVK981yn3JsuoYC2IGADY6wMk+Pi1rKRgpIGmPu3VWY1lHYGdx2H+186Ew9vQooCzWFcdat5YXcQpDKZRHpL6O2drwuJQoF79VewQEPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=iIvCNNPC; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 618GVaoD1283895;
	Sun, 8 Feb 2026 10:38:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=c4SMInCxSEMe4A6nYRNuE3KQcBtJyCKBHTFI/40Ixh0=; b=iIvCNNPCZYX7
	8OUf/Qk1RoeKJHDSM4/eKtOJTFYsD714XtPwP24raj2L3gy6wFvjiNEmyB+vqOmx
	1ZltSaBbVJrVHNMlfkZmg8me6pqpDKbvYDgJ1EIylMkbk3bIuk9Se343cBGTV5VB
	O8w+rI6aTpwC4IjcA7mJWO5vQLzb0dj3wjn1f06lEdqqRIUof9Foiha0XU6nSaGJ
	Gjl8sqGarITalUeGi3k4hqsfN2B0T5S5SQLJEhNnMQT8WPadjBpZqmTyZ+hdfRqb
	svIPi7dq9HpeQ53CnXOqeUq3R0iRK84HXx1moF8hjKXBbVK8XaeP+GvUaCvHKiki
	ZyxB2/VBhw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4c6x33rnh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Feb 2026 10:38:55 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 8 Feb 2026 18:38:54 +0000
From: Chris Mason <clm@meta.com>
To: Qu Wenruo <wqu@suse.com>
CC: <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: reject single block sized compression early
Date: Sun, 8 Feb 2026 10:34:24 -0800
Message-ID: <20260208183840.975975-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <89c6eb7756051dbe2e63693b5051394b16a9080b.1767667652.git.wqu@suse.com>
References: <89c6eb7756051dbe2e63693b5051394b16a9080b.1767667652.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4QKknRWvkrcPFgkf5mEsKrzLNW6m8Qc3
X-Proofpoint-GUID: 4QKknRWvkrcPFgkf5mEsKrzLNW6m8Qc3
X-Authority-Analysis: v=2.4 cv=KbnfcAYD c=1 sm=1 tr=0 ts=6988d83f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=lIM-JIJdq4LJHzknk1IA:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDE2MSBTYWx0ZWRfX7b0Ax63qnib8
 qar8QTBzl9vbR6YYbXzWF5sgAPj+d7A8xbnBxXX1vAJMnHFsu1+TuTwtNtcj1e9v2mopeRE+0OS
 CmLC54RTFe27GIFaZceeJbE0ZWeZKWyX5dsXpjxfxxBHqw0eURajGbJ7aR/xBpmFCqjYdq7saDz
 4GZHlncp9giEv6QgdOMBii/0i0BKktJYeWgbxCqvosxTxK+hr4wPWbLLm1tkSnUq4On4UdaAtp5
 ZO7bgqeIp85r9obEZiM+9mc2zFM63xXyDFKQ8orCnwBYpWjcEnI2RFpDLhlQiCOWkiR7KWtUhtm
 S1lpMMGeRDt5m4GcIk9sucFJa7GNCocigJWQuSQ1JrSZoPBjaQESLmdazpj1Vgd7qMRBg+DVRuv
 rYbttOvnGihOAvWYutwdZ31UD/OLlv6aL1Uo0RdNhkI+ab7wVRehfVJmRYI0HeOJyUa/PrAqccW
 3hHH8nRmZry5VJyq9ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21493-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 626E5109E74
X-Rspamd-Action: no action

Qu Wenruo <wqu@suse.com> wrote:
> Currently for an inode that needs compression, even if there is a delalloc
> range that is single fs block sized and can not be inlined, we will
> still go through the compression path.
> 
> Then inside compress_file_range(), we have one extra check to reject
> single block sized range, and fall back to regular uncompressed write.
> 
> This rejection is in fact a little too late, we have already allocated
> memory to async_chunk, delayed the submission, just to fallback to the
> same uncompressed write.
> 
> Change the behavior to reject such cases earlier at
> inode_need_compress(), so for such single block sized range we won't
> even bother trying to go through compress path.
> 
> And since the inline small block check is inside inode_need_compress()
> and compress_file_range() also calls that function, we no longer need a
> dedicate check inside compress_file_range().
> 

Hi everyone,

I'm running the btrfs for-next branch, along with the encryption patch set
through my AI review prompts:

https://github.com/masoncl/review-prompts

I'm working on some btrfs specific instructions, but hopefully these reviews
are already useful.  I've kept the headers to make it easier to double check
that I'm actually replying to the right email, but please let me know if any
parts of this are incorrect:

commit 59615e2c1f63dfd65f74c166e803873d3362e51a
Author: Qu Wenruo <wqu@suse.com>

btrfs: reject single block sized compression early

This commit moves single block size rejection earlier from
compress_file_range() to inode_need_compress() to avoid allocating
async_chunk memory for ranges that will not be compressed anyway.

Link: https://git.kernel.org/linus/59615e2c1f63dfd65f74c166e803873d3362e51a

> diff --git fs/btrfs/inode.c fs/btrfs/inode.c
> index 247b373bf5cf0..be47aa58e944e 100644
> --- fs/btrfs/inode.c
> +++ fs/btrfs/inode.c
> @@ -816,6 +816,13 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
>  		return 0;
>  	}
>
> +	/*
> +	 * If the delalloc range is only one fs block and can not be inlined,
> +	 * do not even bother try compression, as there will be no space saving
> +	 * and will always fallback to regular write later.
> +	 */
> +	if (start != 0 && end + 1 - start <= fs_info->sectorsize)
> +		return 0;

Is the early rejection check in inode_need_compress() missing the
'end + 1 < inode->disk_i_size' condition from the original check?

The old code in compress_file_range() rejected single-block ranges with:

    if (total_compressed <= blocksize &&
       (start > 0 || end + 1 < inode->disk_i_size))
        goto cleanup_and_bail_uncompressed;

The new check only tests 'start != 0' but doesn't check whether the write
reaches EOF. This means a single-block write at offset 0 that doesn't reach
EOF will now go through compression, inline attempt, and ratio checking in
compress_file_range() before being rejected, when the old code rejected it
immediately.

Doesn't this cause MORE work for the case where start == 0 AND single block
AND end + 1 < disk_i_size?

>  	/* Defrag ioctl takes precedence over mount options and properties. */
>  	if (inode->defrag_compress == BTRFS_DEFRAG_DONT_COMPRESS)
>  		return 0;

[ ... ]

> @@ -953,18 +960,7 @@ static void compress_file_range(struct btrfs_work *work)
>  	if (actual_end <= start)
>  		goto cleanup_and_bail_uncompressed;
>
> -	total_compressed = actual_end - start;
> -
> -	/*
> -	 * Skip compression for a small file range(<=blocksize) that
> -	 * isn't an inline extent, since it doesn't save disk space at all.
> -	 */
> -	if (total_compressed <= blocksize &&
> -	   (start > 0 || end + 1 < inode->disk_i_size))
> -		goto cleanup_and_bail_uncompressed;
> -
> -	total_compressed = min_t(unsigned long, total_compressed,
> -			BTRFS_MAX_UNCOMPRESSED);
> +	total_compressed = min_t(unsigned long, actual_end - start, BTRFS_MAX_UNCOMPRESSED);
>  	total_in = 0;
>  	ret = 0;


