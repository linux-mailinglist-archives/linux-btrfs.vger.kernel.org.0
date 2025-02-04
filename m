Return-Path: <linux-btrfs+bounces-11274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 720C8A27DD0
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 22:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6293A604D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 21:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B01E21A446;
	Tue,  4 Feb 2025 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kFA85lnS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985342B9BB
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706152; cv=none; b=cFQy3Cd9xS9lZfMotuS8nhGPZ3E32Jq4qQpUvpuPPscJMRyQu3kKgSAP01qe5pXE6ASz+05r2WgPWjLAuzhO9kfS5z0Eu+UeVuELHNFi5rN9y5Pqr5xMtU0l0MpTFzZ1pWe+czFWiNJlJLQYO4CJdTZVHkd8yqW6muZxcfiORiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706152; c=relaxed/simple;
	bh=oOJF9GdCBnYUdv+TJH7O3IN3WLOT8+Lj8FqiyCEZUkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=bUNkhQrppaJLKcANEVcZRFqAU6n/42Vzdr4FRer/WbhP6k80F2xHjazviQ0bOcTjsN7pWbDEyzB1/3yFpP9WY82GORM1Q2Emx4vvsU/SuTIGzscfuXPqcW4jCE3NHIi6G/Mj59ofBO3j2ZeX7Junu6zuFRhDd0tadwxDXEsNzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kFA85lnS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEnah023258;
	Tue, 4 Feb 2025 21:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vw5fns
	fXTJTXgmBtB5hTaakpvy7ucSzhcAmvyZN+yT0=; b=kFA85lnS7yuRZvotvpdwCH
	pxCqIw8jMmn6xepaGvRIH8rMiWf75U86uhQJXcXH8wW6tJTe10PFu1GbX5dMhXNe
	9yb7tq4xvYdQTGTt4LFmavs+tLcycKVA7TiXgud3naLXU8bJJtjzHoYDS4M26gi7
	F7Mt5xQU1lt2X14bC72q8bQ/94hoa8eu/uT/Sbaa8ZCm8BqWxUgslE7b2x7EdGBp
	J5uJGUCtfTj2SeuPZKtAWMAT1bGTUqMOUhvKHz0J0hcTz27dx/D4C+5uiF0HDG9/
	junT2wR+z+4VXuY+IgAWCykKu6GC/itI/Xlz7jzMBJgfEe9OeFUsOLZFEZvM2n/Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kn62j21h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 21:55:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514J73Au007150;
	Tue, 4 Feb 2025 21:55:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxaynrf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 21:55:47 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514Ltj7S30343934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 21:55:46 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A8F558057;
	Tue,  4 Feb 2025 21:55:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8756358058;
	Tue,  4 Feb 2025 21:55:44 +0000 (GMT)
Received: from [9.171.49.40] (unknown [9.171.49.40])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Feb 2025 21:55:44 +0000 (GMT)
Message-ID: <1a5d5830-c284-4a4b-8df5-929ff4b58b5e@linux.ibm.com>
Date: Tue, 4 Feb 2025 22:55:43 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zlib: refactor S390x HW acceleration buffer
 preparation
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <bee6ac5945df3db876a553dbf6d0dd546f145aa7.1737701962.git.wqu@suse.com>
Content-Language: en-US
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
In-Reply-To: <bee6ac5945df3db876a553dbf6d0dd546f145aa7.1737701962.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c3wvxaFd5W04ng1URjazFLXQIUM-C2V9
X-Proofpoint-ORIG-GUID: c3wvxaFd5W04ng1URjazFLXQIUM-C2V9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_09,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040159

Hello Qu,

Sorry for the long silence.
I've tested this patch on s390 using our hardware compression test suite. 
No issues discovered.

Here is my
Acked-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>


On 24.01.2025 07:59, Qu Wenruo wrote:
> Currently for s390x HW zlib compression, to get the best performance we
> need a buffer size which is larger than a page.
> 
> This means we need to copy multiple pages into workspace->buf, then use
> that buffer as zlib compression input.
> 
> Currently it's hardcoded using page sized folio, and all the handling
> are deep inside a loop.
> 
> Refactor the code by:
> 
> - Introduce a dedicated helper to do the buffer copy
>   The new helper will be called copy_data_into_buffer().
> 
> - Add extra ASSERT()s
>   * Make sure we only go into the function for hardware acceleration
>   * Make sure we still get page sized folio
> 
> - Prepare for future larger folios
>   This means we will rely on the folio size, other than PAGE_SIZE to do
>   the copy.
> 
> - Handle the folio mapping and unmapping inside the helper function
>   For S390x hardware acceleration case, it never utilize the @data_in
>   pointer, thus we can do folio mapping/unmapping all inside the function.
> 
> Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Hi Mikhail,
> 
> Mind to give this patch a test on S390x? As I do not have easy access to
> such system.
> 
> And I hope I won't need to bother you again when we enable larger folios
> for btrfs in the near future.
> 
> Thanks,
> Qu
> ---
>  fs/btrfs/zlib.c | 82 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 54 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index c9e92c6941ec..7d81d9a0b3a0 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -94,6 +94,47 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> +/*
> + * Helper for S390x with hardware zlib compression support.
> + *
> + * That hardware acceleration requires a buffer size larger than a single page
> + * to get ideal performance, thus we need to do the memory copy other than
> + * use the page cache directly as input buffer.
> + */
> +static int copy_data_into_buffer(struct address_space *mapping,
> +				 struct workspace *workspace, u64 filepos,
> +				 unsigned long length)
> +{
> +	u64 cur = filepos;
> +
> +	/* It's only for hardware accelerated zlib code. */
> +	ASSERT(zlib_deflate_dfltcc_enabled());
> +
> +	while (cur < filepos + length) {
> +		struct folio *folio;
> +		void *data_in;
> +		unsigned int offset;
> +		unsigned long copy_length;
> +		int ret;
> +
> +		ret = btrfs_compress_filemap_get_folio(mapping, cur, &folio);
> +		if (ret < 0)
> +			return ret;
> +		/* No larger folio support yet. */
> +		ASSERT(!folio_test_large(folio));
> +
> +		offset = offset_in_folio(folio, cur);
> +		copy_length = min(folio_size(folio) - offset,
> +				  filepos + length - cur);
> +
> +		data_in = kmap_local_folio(folio, offset);
> +		memcpy(workspace->buf + cur - filepos, data_in, copy_length);
> +		kunmap_local(data_in);
> +		cur += copy_length;
> +	}
> +	return 0;
> +}
> +
>  int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>  			 u64 start, struct folio **folios, unsigned long *out_folios,
>  			 unsigned long *total_in, unsigned long *total_out)
> @@ -105,8 +146,6 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>  	int nr_folios = 0;
>  	struct folio *in_folio = NULL;
>  	struct folio *out_folio = NULL;
> -	unsigned long bytes_left;
> -	unsigned int in_buf_folios;
>  	unsigned long len = *total_out;
>  	unsigned long nr_dest_folios = *out_folios;
>  	const unsigned long max_out = nr_dest_folios * PAGE_SIZE;
> @@ -150,34 +189,21 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>  		 * the workspace buffer if required.
>  		 */
>  		if (workspace->strm.avail_in == 0) {
> -			bytes_left = len - workspace->strm.total_in;
> -			in_buf_folios = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
> -					    workspace->buf_size / PAGE_SIZE);
> -			if (in_buf_folios > 1) {
> -				int i;
> +			unsigned long bytes_left = len - workspace->strm.total_in;
> +			unsigned int copy_length = min(bytes_left, workspace->buf_size);
>  
> -				/* S390 hardware acceleration path, not subpage. */
> -				ASSERT(!btrfs_is_subpage(
> -						inode_to_fs_info(mapping->host),
> -						mapping));
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
> +			/*
> +			 * This can only happen when hardware zlib compression is
> +			 * enabled.
> +			 */
> +			if (copy_length > PAGE_SIZE) {
> +				ret = copy_data_into_buffer(mapping, workspace,
> +							    start, copy_length);
> +				if (ret < 0)
> +					goto out;
> +				start += copy_length;
>  				workspace->strm.next_in = workspace->buf;
> -				workspace->strm.avail_in = min(bytes_left,
> -							       in_buf_folios << PAGE_SHIFT);
> +				workspace->strm.avail_in = copy_length;
>  			} else {
>  				unsigned int pg_off;
>  				unsigned int cur_len;


