Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25BF11A263F
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 17:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgDHPtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 11:49:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42462 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbgDHPsv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Apr 2020 11:48:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 038FeCFm088097;
        Wed, 8 Apr 2020 15:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=h7GEoPQocYqMF7PThgWxrJwEIMu1FXG8nI5uzaQke0Y=;
 b=iFbE5jH9Nk4EoujHw642/Isk0Al8qMz8sbu/QPVWBtI+Mqm9V2OtmRDrLaE2hAQvBdZv
 YlBLvLfa48X8+2AXxeYjnSizPVPnX9mUuL1lrTX6ps1o9ycalVo8H5n6okmqEGFMdJdu
 /ZNYztpstc66Y7u2JPPKcUMdJAm1/UYBePdyuHrS14b3dCEoxMYK9ypXk+/+INJe3PdY
 kiySLlGs4/xoAzZm1VFuJHzUnzJiVECzedfWuVPXQ4JuB/unwBABMt0zu4b45lVWnM/E
 aFdp3avTSAaZ44RxhNLbQry2NCaq2pJVLbNxMFALB3ECJCYELk9ql7moImjx4X7dGE5R Pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3091m3cd6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Apr 2020 15:48:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 038FapGn102926;
        Wed, 8 Apr 2020 15:48:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 309ag23f32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Apr 2020 15:48:45 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 038Fmikf009158;
        Wed, 8 Apr 2020 15:48:44 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Apr 2020 08:48:44 -0700
Date:   Wed, 8 Apr 2020 08:48:43 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 4/4] fsx: move range generation logic into a common helper
Message-ID: <20200408154843.GC6740@magnolia>
References: <20200408103627.11514-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408103627.11514-1-fdmanana@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004080124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080124
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 08, 2020 at 11:36:27AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have very similar code that generates the destination range for clone,
> dedupe and copy_file_range operations, so avoid duplicating the code three
> times and move it into a helper function.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  ltp/fsx.c | 91 +++++++++++++++++++++++++--------------------------------------
>  1 file changed, 36 insertions(+), 55 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 89a5f60e..8873cd01 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1930,6 +1930,36 @@ range_overlaps(
>  	return llabs((unsigned long long)off1 - off0) < size;
>  }
>  
> +static void generate_dest_range(unsigned long op,
> +				unsigned long max_range_end,
> +				unsigned long *src_offset,
> +				unsigned long *size,
> +				unsigned long *dst_offset)
> +{
> +	int tries = 0;
> +
> +	TRIM_OFF_LEN(*src_offset, *size, file_size);
> +	if (op == OP_COPY_RANGE) {

It feels funny that we pass in @op just to let COPY RANGE relax the
block size alignment requirements.  How about passing a block_align
parameter (instead of op) which would be the subject of the if test?
This way we concentrate the alignment requirement knowlege of each type
of call in the "case OP_FOO" part of the code instead of scattering it?

--D

> +		*src_offset -= *src_offset % readbdy;
> +		if (o_direct)
> +			*size -= *size % readbdy;
> +	} else {
> +		*src_offset = *src_offset & ~(block_size - 1);
> +		*size = *size & ~(block_size - 1);
> +	}
> +
> +	do {
> +		if (tries++ >= 30) {
> +			*size = 0;
> +			break;
> +		}
> +		*dst_offset = random();
> +		TRIM_OFF(*dst_offset, max_range_end);
> +		*dst_offset = *dst_offset & ~(block_size - 1);
> +	} while (range_overlaps(*src_offset, *dst_offset, *size) ||
> +		 *dst_offset + *size > max_range_end);
> +}
> +
>  int
>  test(void)
>  {
> @@ -2004,63 +2034,14 @@ test(void)
>  			keep_size = random() % 2;
>  		break;
>  	case OP_CLONE_RANGE:
> -		{
> -			int tries = 0;
> -
> -			TRIM_OFF_LEN(offset, size, file_size);
> -			offset = offset & ~(block_size - 1);
> -			size = size & ~(block_size - 1);
> -			do {
> -				if (tries++ >= 30) {
> -					size = 0;
> -					break;
> -				}
> -				offset2 = random();
> -				TRIM_OFF(offset2, maxfilelen);
> -				offset2 = offset2 & ~(block_size - 1);
> -			} while (range_overlaps(offset, offset2, size) ||
> -				 offset2 + size > maxfilelen);
> -			break;
> -		}
> +		generate_dest_range(op, maxfilelen, &offset, &size, &offset2);
> +		break;
>  	case OP_DEDUPE_RANGE:
> -		{
> -			int tries = 0;
> -
> -			TRIM_OFF_LEN(offset, size, file_size);
> -			offset = offset & ~(block_size - 1);
> -			size = size & ~(block_size - 1);
> -			do {
> -				if (tries++ >= 30) {
> -					size = 0;
> -					break;
> -				}
> -				offset2 = random();
> -				TRIM_OFF(offset2, file_size);
> -				offset2 = offset2 & ~(block_size - 1);
> -			} while (range_overlaps(offset, offset2, size) ||
> -				 offset2 + size > file_size);
> -			break;
> -		}
> +		generate_dest_range(op, file_size, &offset, &size, &offset2);
> +		break;
>  	case OP_COPY_RANGE:
> -		{
> -			int tries = 0;
> -
> -			TRIM_OFF_LEN(offset, size, file_size);
> -			offset -= offset % readbdy;
> -			if (o_direct)
> -				size -= size % readbdy;
> -			do {
> -				if (tries++ >= 30) {
> -					size = 0;
> -					break;
> -				}
> -				offset2 = random();
> -				TRIM_OFF(offset2, maxfilelen);
> -				offset2 -= offset2 % writebdy;
> -			} while (range_overlaps(offset, offset2, size) ||
> -				 offset2 + size > maxfilelen);
> -			break;
> -		}
> +		generate_dest_range(op, maxfilelen, &offset, &size, &offset2);
> +		break;
>  	}
>  
>  have_op:
> -- 
> 2.11.0
> 
