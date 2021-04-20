Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0F365614
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 12:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhDTKXD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 06:23:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33774 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhDTKXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 06:23:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13KAK9h8058776;
        Tue, 20 Apr 2021 10:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bPuzElpjiOo1zRjSEnYwkdbLNwWPB/1sGrCY1L0+/nk=;
 b=SK2yp54Mm5hj2vNEO49W79IuvChvxXimdFLZNUAZotP5gRPO/oBaVGdbMQo+1bcmhin6
 1xp0K8AH2//Q0Kmcxl90woLQ34FEqIwCfMx1loyveBMLcOjGiZYZVeUbB0J8mB7EJAgx
 42To4eMxdLW9hQFwMO68k32g88pZNaFYM0bgTaocjT8krFc4/R6jb40ojrqEnuRggZ+s
 CSTOdkQRsakWK8qHU8oqzf2aTZkLhUL88Yu+NuRThnQ/+HzviHk2TpsMjwMmqKYUBFmp
 jq9gK9nnrbcqOW7lwqBGSqPj5IDakFgpzNmoL69op9HyV+0NZWO3kpnKZgQzJjmcvWUJ lA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37yveaea4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 10:22:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13KAKmrr022570;
        Tue, 20 Apr 2021 10:22:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3809kxskwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 10:22:23 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13KAMN7r027505;
        Tue, 20 Apr 2021 10:22:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3809kxskwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 10:22:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13KAMLKX021192;
        Tue, 20 Apr 2021 10:22:21 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Apr 2021 03:22:21 -0700
Date:   Tue, 20 Apr 2021 13:22:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Khaled ROMDHANI <khaledromdhani216@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] fs/btrfs: Fix uninitialized variable
Message-ID: <20210420102214.GA1981@kadam>
References: <20210417153616.25056-1-khaledromdhani216@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417153616.25056-1-khaledromdhani216@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: apFXcdx82eJ5clMeWqsNsBlKtdoJAoHu
X-Proofpoint-ORIG-GUID: apFXcdx82eJ5clMeWqsNsBlKtdoJAoHu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104200079
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 17, 2021 at 04:36:16PM +0100, Khaled ROMDHANI wrote:
> As reported by the Coverity static analysis.
> The variable zone is not initialized which
> may causes a failed assertion.
> 
> Addresses-Coverity: ("Uninitialized variables")
> Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> ---
> v2: add a default case as proposed by David Sterba
> ---
>  fs/btrfs/zoned.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index eeb3ebe11d7a..82527308d165 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -143,6 +143,9 @@ static inline u32 sb_zone_number(int shift, int mirror)
>  	case 0: zone = 0; break;
>  	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
>  	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;

It took me a while to spot these break statements.

> +	default:
> +		zone = 0;
> +	break;

This break needs to be indented one more tab.

>  	}
>  
>  	ASSERT(zone <= U32_MAX);

regards,
dan carpenter
