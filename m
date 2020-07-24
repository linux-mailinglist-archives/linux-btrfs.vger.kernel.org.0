Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC322CB90
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 18:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGXQ7W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 12:59:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47872 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgGXQ7W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 12:59:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OGqbxS170377;
        Fri, 24 Jul 2020 16:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=58J/7eQb9zaXGGG8o6ESUFvKscUvTCN3dP9VqogPcUQ=;
 b=ZSKtHiZnww0WnlWwNoXC+3543XHeT0V0kfoST/0RArbbH3UnxSmnz/OW+mJ02m0GYjEg
 QSEcx1i7HvmPJKmDCS7ixjw8TAgDWX0QG1qCWCiI6QJAV7XDofWVQccDjsjEHuWQYR/T
 +nobMtGMrt8nFnbfSvHyrJW5a91SAmFSea2Om5PQskhPC2I1qmVqkS+Ho3DSUG+OAZR1
 Bqhxt1/1m6ygBveyT1B+gh1O3MorxaBy8uv/xVA1zqirefmN5ILx1AdIsX9E1b+1Y8vG
 Xku3CGT4rqdVTVTHfVfqD1ZOkuZG02xRBu+laDyHdY2OJ9ookEFVecTmSf1ZYWbP52vb ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32brgs07hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 16:59:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OGqSWB033202;
        Fri, 24 Jul 2020 16:57:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32g3hug4ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 16:57:18 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06OGvG4w016810;
        Fri, 24 Jul 2020 16:57:16 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jul 2020 09:57:16 -0700
Date:   Fri, 24 Jul 2020 09:57:15 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not evaluate the expression with
 !CONFIG_BTRFS_ASSERT
Message-ID: <20200724165715.GA7591@magnolia>
References: <20200724164147.39925-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724164147.39925-1-josef@toxicpanda.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=1 adultscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240129
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 24, 2020 at 12:41:47PM -0400, Josef Bacik wrote:
> While investigating a performance issue I noticed that turning off
> CONFIG_BTRFS_ASSERT had no effect in what I was seeing in perf,
> specifically check_setget_bounds() was around 5% for this workload.
> Upon investigation I realized that I made a mistake when I added
> ASSERT(), I would still evaluate the expression, but simply ignore the
> result.
> 
> This is useless, and has a marked impact on performance.  This
> microbenchmark is the watered down version of an application that is
> experiencing performance issues, and does renames and creates over and
> over again.  Doing these operations 200k times without this patch takes
> 13 seconds on my machine.  With this patch it takes 7 seconds.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

lolz,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/btrfs/ctree.h        | 2 +-
>  fs/btrfs/struct-funcs.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 9c7e466f27a9..b0fe8cca7e86 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3238,7 +3238,7 @@ static inline void assertfail(const char *expr, const char *file, int line)
>  
>  #else
>  static inline void assertfail(const char *expr, const char* file, int line) { }
> -#define ASSERT(expr)	(void)(expr)
> +#define ASSERT(expr)	((void)0)
>  #endif
>  
>  /*
> diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
> index 079b059818e9..f44dc1207792 100644
> --- a/fs/btrfs/struct-funcs.c
> +++ b/fs/btrfs/struct-funcs.c
> @@ -17,6 +17,7 @@ static inline void put_unaligned_le8(u8 val, void *p)
>         *(u8 *)p = val;
>  }
>  
> +#ifdef CONFIG_BTRFS_ASSERT
>  static bool check_setget_bounds(const struct extent_buffer *eb,
>  				const void *ptr, unsigned off, int size)
>  {
> @@ -37,6 +38,7 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
>  
>  	return true;
>  }
> +#endif
>  
>  /*
>   * Macro templates that define helpers to read/write extent buffer data of a
> -- 
> 2.24.1
> 
