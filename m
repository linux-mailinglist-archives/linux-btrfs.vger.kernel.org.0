Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D19D36EC2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbhD2ONR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 10:13:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52758 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbhD2ONQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 10:13:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TDtYAt137755;
        Thu, 29 Apr 2021 14:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7wO3S1awYKukxfXx/AgA8BN45wRenl6f8tRf1DRHcFo=;
 b=MIX3H+CEVlP5dw1fBFOyp2izPwL8FkgDd6T9ci1sXkthxSvFklK0NauWygvEvfkW9qhm
 /nNFrkG7HxhXO/4jF9RDGeR2X35VH76XSoycdBh7AL8lHpLopKLFwpVpOJe2mFKAc5xJ
 3Cay2sKYFkOXEhVhQGMd5MSL/CwUNLqrZIyVEBn5LK+o9zh93dIoDoffbqt2h/YKo+GJ
 S/V9kTPQuyeojadKHtAFiXqMxmRohYkMWpZYaf3cqgvZG2u1FTswL8csHFy2mx/ZYChv
 tIxapZ3Yxmu0pmmTBUMsk1b/6QV2kzENG/Oaod5rK9VPBGDi+QE2/m5S0TmardtPSKEh kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 385aft4gt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:12:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TDtxNO169381;
        Thu, 29 Apr 2021 14:12:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 384b5acmjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:12:08 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13TEC1LK092501;
        Thu, 29 Apr 2021 14:12:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 384b5acmhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:12:08 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13TEC7Hu011472;
        Thu, 29 Apr 2021 14:12:07 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Apr 2021 07:12:06 -0700
Date:   Thu, 29 Apr 2021 17:12:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Khaled ROMDHANI <khaledromdhani216@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH-V2] fs/btrfs: Fix uninitialized variable
Message-ID: <20210429141200.GB1981@kadam>
References: <20210427171627.32356-1-khaledromdhani216@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427171627.32356-1-khaledromdhani216@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 5XMmar-2JWd8WARv3s5ERz9mr6XXrbzN
X-Proofpoint-ORIG-GUID: 5XMmar-2JWd8WARv3s5ERz9mr6XXrbzN
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290093
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 27, 2021 at 06:16:27PM +0100, Khaled ROMDHANI wrote:
> The variable 'zone' is uninitialized which
> introduce some build warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> ---
> v2: catch the init as an assertion
> ---
>  fs/btrfs/zoned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 432509f4b3ac..70c0b1b2ff04 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -144,7 +144,7 @@ static inline u32 sb_zone_number(int shift, int mirror)
>  	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
>  	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
>  	default:
> -		ASSERT(zone);
> +		ASSERT(zone = 0);

I'm sorry but this doesn't make any kind of sense.

>  		break;
>  	}

regards,
dan carpenter

