Return-Path: <linux-btrfs+bounces-18969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18090C5B583
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 05:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D2EC355236
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 04:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBE42C235B;
	Fri, 14 Nov 2025 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q/AQgVwf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ADF1B0439
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763095958; cv=none; b=jZ1zV+tlNOgam6SDzvqi2RPvqfniDgLb1e1+vFTey1YM9q0UMH/fFEzu4HV0aFUrP0PbzKACNNUItP871uSH8XbMLuF5NxGg3qaSjvkfx6jlyCIDNzXsjJ68zr3b8rbNII7O4zwpvl8QDUv3gR5KovYm9nJL3vnplcUUoDu5G00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763095958; c=relaxed/simple;
	bh=NnDTeTHI0HqHragJNAo5nLmWodzou2YM9DyRD6X7UZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n8wS/2berWFf/pgO9gbirtQArzALlVUOLVD6z0e2vrUrDN33citW49elYCkCC+X+uFLbwAEs6by2hThp2d0wUfLNSUK/sqPIfV2aN1rwrW0sNldPPF4XMTfPB5LrPgGJiJRjOY5Vvb5U9WlDlrWxAhcVsASWG5g1/zBmcwFSSp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q/AQgVwf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADMmmfv029217;
	Fri, 14 Nov 2025 04:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v1KvxF
	6Yfm5SuRdcohk+tE9GL5PlxhWilP2QL14a9Hk=; b=Q/AQgVwflTQyMZHqG0+MfZ
	Ce3LNgviFycSkFfcigWvecH6IRoyOxvvH2ubsUn54KROOFQRP4po0YzuCUIFmvFI
	oCMtCpURX9W0MP1yrk3MKQ+9iGaI9AtuyPTVrVGlj8q4OyH14vTFl+13Q4e+JV7P
	U9CRBRB4REL16OLQvC2L1Sz9Hlc1ulnRNU8TDbKCggTWaAXF2vZxTTo09bWjy54O
	VJFt6Wo4RyzaEa0Co8w6/UGCVOeG/kn4roQvB1zibILhB5Mtgly+8l7TClztGVKw
	8rm2jba7n9NrxXM26W1RwAFfrhV1RG72bCFJSaTy4ed73TDOG2UZjxyXoPt8akcA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adrevgv16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 04:52:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AE4IwxV007325;
	Fri, 14 Nov 2025 04:52:34 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjscb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 04:52:34 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AE4qXKL30999138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 04:52:34 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4E8958057;
	Fri, 14 Nov 2025 04:52:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01FBD58058;
	Fri, 14 Nov 2025 04:52:33 +0000 (GMT)
Received: from [9.61.240.52] (unknown [9.61.240.52])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Nov 2025 04:52:32 +0000 (GMT)
Message-ID: <9c0261dc-e838-42f0-9a70-5b351e7a90ce@linux.ibm.com>
Date: Fri, 14 Nov 2025 10:22:31 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: raid56: fix a out-of-boundary access for sub-page
 systems
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <bbd1a41c70c0f37da9e3e82aa89784e831b0e889.1763069997.git.wqu@suse.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <bbd1a41c70c0f37da9e3e82aa89784e831b0e889.1763069997.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GIlFlmu2ygap3wpNQm8wPeglK5z85Tag
X-Authority-Analysis: v=2.4 cv=E9nAZKdl c=1 sm=1 tr=0 ts=6916b593 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=Ud-UmWk43w0TWpTgmO0A:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OSBTYWx0ZWRfX58+02eqaPmk0
 4YwCzCcKww3KrvY4YNMZMMA77MHsMgIfuwuOfJtuR7UyJ0JA96xrv3bd23njyojiP8nPMH4uxM+
 JXma+tnJr31fey2ck0jDV0+Cbrap8wlddEEdgrKDz6HWjzcnLYTy8RFVDwPZoLU3UMWVa7qvgLt
 eiOPDE+TkFg4Baly+mN+jKVxGabOU1fm1AliVpiyPjLeZxccFdRCe7Ra1x4DJXLLcd2i1XgcTrn
 Jdhq9ENGph5EpEGqoWwZ6YCM/14eu2d8q3l++rzr9oHmEPZc2s+3S+5+nzOAusc4IyLMXW6c23p
 E8Z/T9ojWI9gUFuZb6iMrTRXel7X+wNnAto+fc0dgWkL57PtxTkmm8hGpefSBJatP0thbrZ7tGo
 ULo6WiUTn4K8HfhLwuamTfwwSdad7w==
X-Proofpoint-GUID: GIlFlmu2ygap3wpNQm8wPeglK5z85Tag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130179


On 14/11/25 3:09 am, Qu Wenruo wrote:
> [BUG]
> There is a bug report from IBM that on Power11 the test case btrfs/023
> crashed.
>
> The call trace itself is not useful as this particular case is a wild
> memory write, which corrupted the SLUB system.
>
> [CAUSE]
> Inside index_stripe_sectors() we will update rbio->stripe_paddrs[] array
> to reflect the latest stripe_pages[].
>
> We use the physical address of the corresponding page, add an offset
> inside the page to represent the sector.
>
> However in patch "btrfs: raid56: remove sector_ptr structure", the
> offset is added to the stripe_pages[] array, not the result of
> page_to_phys().
>
> This makes the stripe_paddrs[] to be hugely incorrect for subpage
> systems.
>
> [FIX]
> Fix the calculation by adding the offset after page_to_phys().
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>


Tested this patch, by applying on top of next-20251113 and this fixes 
the reported issue. Hence,

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.

> ---
> The fix will be folded into the offending patch.
> ---
>   fs/btrfs/raid56.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index ad3d5e789158..7cb756ac19ba 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -331,8 +331,8 @@ static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
>   		if (!rbio->stripe_pages[page_index])
>   			continue;
>   
> -		rbio->stripe_paddrs[i] = page_to_phys(rbio->stripe_pages[page_index] +
> -						      offset_in_page(offset));
> +		rbio->stripe_paddrs[i] = page_to_phys(rbio->stripe_pages[page_index]) +
> +						      offset_in_page(offset);
>   	}
>   }
>   

