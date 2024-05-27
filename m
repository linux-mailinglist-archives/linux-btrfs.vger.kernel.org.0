Return-Path: <linux-btrfs+bounces-5303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCA58D0876
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 18:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274C72928D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 16:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F69215A84A;
	Mon, 27 May 2024 16:25:54 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ECE61FCE;
	Mon, 27 May 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827154; cv=none; b=EfohZxFadz7G8CcWhmKMJqnRBw9Dz4A3mYfvGIV0qJKSRSg921/EJH1TaMViJahdCdYpEzY1B4z+C3FTgQSFIPqVp8UAHxjxlpSFht/xGHFxeQCBJdaQzc4Xg+2QKPxxJdxlI68WPYwPb6UbJJz89cTYAtycsMA+L6MSiURsHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827154; c=relaxed/simple;
	bh=InTW6Q7xA172IXX3azBRIICl2vRwoYq+ghJReXbYMHI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yhbqwr+Zl5EpEpLLoKxVr+9edxiPTqMmOvyrDt5asuYdmRbhsu6e3JHUduULMMiS90crshctMnIYZJuJxTdHXQJNiGSU9wYhRO4ouEdbVHOXL5u3z7XYL0AQRIgCvG73g4cLH4LgNrndwhjZWfNRsiPqrHEQwRbE1otDsdLxhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RGBCFx003654;
	Mon, 27 May 2024 16:25:50 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dibm.com;_h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3Dh5a?=
 =?UTF-8?Q?KP/QHALNaOd3RVdNfi4/sfaER5RQjNJ6Q7sO5UGU=3D;_b=3DsAN0Mw9geZThRo?=
 =?UTF-8?Q?ddqcHojPIT/aG4iWFtCPMwv57qLv0b3CrGOnbKDdQGhiGifFd895sN_7qpMaJSW?=
 =?UTF-8?Q?11LXe56y1UBqAf/ZxGovqCxCWfoAcWaem3NIrHchW2H65JndABHhh955b0HZ_gP?=
 =?UTF-8?Q?He4HC6m9jWXOAq3+z9yckATjns3QCVbE9cciBJjbHCirJkLYi/xyZwiCE+dr1GG?=
 =?UTF-8?Q?ds7_a8U0Fe39Ec2UX11XI6IrfH8N6wriPGEVoXPpvodAyEMzac2fZRea0YY9fwg?=
 =?UTF-8?Q?+4En96QNI_CcBWsFyMTVcEbkx7P8GKaWgvV1EvILdWP1XbnkTC6ERb94tc/HbyC?=
 =?UTF-8?Q?LK/lqV+to7F5fy2_tA=3D=3D_?=
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yctsfrfd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 16:25:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44RETlQo011090;
	Mon, 27 May 2024 16:25:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ybtq02799-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 16:25:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44RGPkiJ21103240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 16:25:48 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 075315803F;
	Mon, 27 May 2024 16:25:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C25858056;
	Mon, 27 May 2024 16:25:45 +0000 (GMT)
Received: from [9.171.28.120] (unknown [9.171.28.120])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 May 2024 16:25:44 +0000 (GMT)
Message-ID: <08aca5cf-f259-4963-bb2a-356847317d94@linux.ibm.com>
Date: Mon, 27 May 2024 18:25:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zlib: do not do unnecessary page copying for
 compression
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
References: <0a24cc8a48821e8cf3bd01263b453c4cbc22d832.1716801849.git.wqu@suse.com>
Content-Language: en-US
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
In-Reply-To: <0a24cc8a48821e8cf3bd01263b453c4cbc22d832.1716801849.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ypisxxeH1MEe85-RlsGOyKuV-TEfuSVd
X-Proofpoint-GUID: ypisxxeH1MEe85-RlsGOyKuV-TEfuSVd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405270134

Hello Qu,

I remember implementing btrfs zlib changes related to s390 dfltcc compression support a while ago:
https://lwn.net/Articles/808809/

The workspace buffer size was indeed enlarged for performance reasons.

Please see my comments below.

On 27.05.2024 11:24, Qu Wenruo wrote:
> [BUG]
> In function zlib_compress_folios(), we handle the input by:
> 
> - If there are multiple pages left
>   We copy the page content into workspace->buf, and use workspace->buf
>   as input for compression.
> 
>   But on x86_64 (which doesn't support dfltcc), that buffer size is just
>   one page, so we're wasting our CPU time copying the page for no
>   benefit.
> 
> - If there is only one page left
>   We use the mapped page address as input for compression.
> 
> The problem is, this means we will copy the whole input range except the
> last page (can be as large as 124K), without much obvious benefit.
> 
> Meanwhile the cost is pretty obvious.

Actually, the behavior for kernels w/o dfltcc support (currently available on s390
only) should not be affected. 
We copy input pages to the workspace->buf only if the buffer size is larger than 1 page.
At least it worked this way after my original btrfs zlib patch:
https://lwn.net/ml/linux-kernel/20200108105103.29028-1-zaslonko@linux.ibm.com/

Has this behavior somehow changed after your page->folio conversion performed for btrfs? 
https://lore.kernel.org/all/cover.1706521511.git.wqu@suse.com/

Am I missing something?

> 
> [POSSIBLE REASON]
> The possible reason may be related to the support of S390 hardware zlib
> decompression acceleration.
> 
> As we allocate 4 pages (4 * 4K) as workspace input buffer just for s390.
> 
> [FIX]
> I checked the dfltcc code, there seems to be no requirement on the
> input buffer size.
> The function dfltcc_can_deflate() only checks:
> 
> - If the compression settings are supported
>   Only level/w_bits/strategy/level_mask is checked.
> 
> - If the hardware supports
> 
> No mention at all on the input buffer size, thus I believe there is no
> need to waste time doing the page copying.
> 
> Maybe the hardware acceleration is so good for s390 that they can offset
> the page copying cost, but it's definitely a penalty for non-s390
> systems.
> 
> So fix the problem by:
> 
> - Use the same buffer size
>   No matter if dfltcc support is enabled or not
> 
> - Always use page address as input
> 
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/zlib.c | 67 +++++++++++--------------------------------------
>  1 file changed, 14 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index d9e5c88a0f85..9c88a841a060 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -65,21 +65,8 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
>  			zlib_inflate_workspacesize());
>  	workspace->strm.workspace = kvzalloc(workspacesize, GFP_KERNEL | __GFP_NOWARN);
>  	workspace->level = level;
> -	workspace->buf = NULL;
> -	/*
> -	 * In case of s390 zlib hardware support, allocate lager workspace
> -	 * buffer. If allocator fails, fall back to a single page buffer.
> -	 */
> -	if (zlib_deflate_dfltcc_enabled()) {
> -		workspace->buf = kmalloc(ZLIB_DFLTCC_BUF_SIZE,
> -					 __GFP_NOMEMALLOC | __GFP_NORETRY |
> -					 __GFP_NOWARN | GFP_NOIO);
> -		workspace->buf_size = ZLIB_DFLTCC_BUF_SIZE;
> -	}
> -	if (!workspace->buf) {
> -		workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> -		workspace->buf_size = PAGE_SIZE;
> -	}
> +	workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	workspace->buf_size = PAGE_SIZE;
>  	if (!workspace->strm.workspace || !workspace->buf)
>  		goto fail;
>  
> @@ -103,7 +90,6 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>  	struct folio *in_folio = NULL;
>  	struct folio *out_folio = NULL;
>  	unsigned long bytes_left;
> -	unsigned int in_buf_folios;
>  	unsigned long len = *total_out;
>  	unsigned long nr_dest_folios = *out_folios;
>  	const unsigned long max_out = nr_dest_folios * PAGE_SIZE;
> @@ -130,7 +116,6 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>  	folios[0] = out_folio;
>  	nr_folios = 1;
>  
> -	workspace->strm.next_in = workspace->buf;
>  	workspace->strm.avail_in = 0;
>  	workspace->strm.next_out = cfolio_out;
>  	workspace->strm.avail_out = PAGE_SIZE;
> @@ -142,43 +127,19 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>  		 */
>  		if (workspace->strm.avail_in == 0) {
>  			bytes_left = len - workspace->strm.total_in;
> -			in_buf_folios = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
> -					    workspace->buf_size / PAGE_SIZE);

	doesn't this always set *in_buf_folios* to 1 in case no dfltcc support (single page workspace buffer)?

> -			if (in_buf_folios > 1) {
> -				int i;
> -
> -				for (i = 0; i < in_buf_folios; i++) {
> -					if (data_in) {
> -						kunmap_local(data_in);
> -						folio_put(in_folio);
> -						data_in = NULL;
> -					}
> -					ret = btrfs_compress_filemap_get_folio(mapping,
> -							start, &in_folio);
> -					if (ret < 0)
> -						goto out;
> -					data_in = kmap_local_folio(in_folio, 0);
> -					copy_page(workspace->buf + i * PAGE_SIZE,
> -						  data_in);
> -					start += PAGE_SIZE;
> -				}
> -				workspace->strm.next_in = workspace->buf;
> -			} else {
> -				if (data_in) {
> -					kunmap_local(data_in);
> -					folio_put(in_folio);
> -					data_in = NULL;
> -				}
> -				ret = btrfs_compress_filemap_get_folio(mapping,
> -						start, &in_folio);
> -				if (ret < 0)
> -					goto out;
> -				data_in = kmap_local_folio(in_folio, 0);
> -				start += PAGE_SIZE;
> -				workspace->strm.next_in = data_in;
> +			if (data_in) {
> +				kunmap_local(data_in);
> +				folio_put(in_folio);
> +				data_in = NULL;
>  			}
> -			workspace->strm.avail_in = min(bytes_left,
> -						       (unsigned long) workspace->buf_size);
> +			ret = btrfs_compress_filemap_get_folio(mapping,
> +					start, &in_folio);
> +			if (ret < 0)
> +				goto out;
> +			data_in = kmap_local_folio(in_folio, 0);
> +			start += PAGE_SIZE;
> +			workspace->strm.next_in = data_in;
> +			workspace->strm.avail_in = min(bytes_left, PAGE_SIZE);
>  		}
>  
>  		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);

Thanks,
Mikhail

