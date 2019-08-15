Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3438E441
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 06:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfHOEy5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 00:54:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36098 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfHOEy4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 00:54:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F4sIkr023642;
        Thu, 15 Aug 2019 04:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=h+yQrmF0NYm8FZ6d/+TUFQEk0JK7OJdq6GpW0urzNfI=;
 b=GPsHAlVXhSm130Cjepythm61IC8OFF1RTHmQ/srFU57Xj+Ujtm5m6kkQoRes9G2FgOex
 hp3n15mPjsQA8FjdvgukbtEymxd2fP4uWlNgBYWlkFyWI6v0E4RsOL8HXbfHiSGRpiwq
 Uy3CecNVQkJZs8jQR0Vb6tveR0D+iiLGljcFOBlCXNFeY3nAQ2Sg44UVmh6pfH4msiA8
 WDD1dUXr5AEdCWKh0EIxJ29C1jjRhIwkKtfvClJaM9qOzFnYXyWdPICQ80IIcePNrV/U
 ShYk/sS6d8hVbRhCAgxvukQ045JXIji/1D02QDuUks6Tk8Pm7ghra9RFIB7nOWhX+U48 gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u9pjqrkus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 04:54:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F4sESS139617;
        Thu, 15 Aug 2019 04:54:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ucpys058n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 04:54:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7F4siJ1014054;
        Thu, 15 Aug 2019 04:54:44 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 21:54:44 -0700
Subject: Re: [PATCH 1/1] btrfs: Simplify parsing max_inline mount option
To:     Vladimir Panteleev <git@thecybershadow.net>
References: <20190815020453.25150-1-git@thecybershadow.net>
 <20190815020453.25150-2-git@thecybershadow.net>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3a375f8c-2d13-6f23-6731-85667c92c21c@oracle.com>
Date:   Thu, 15 Aug 2019 12:54:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190815020453.25150-2-git@thecybershadow.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150051
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/8/19 10:04 AM, Vladimir Panteleev wrote:
> - Avoid an allocation;
> - Properly handle non-numerical argument and garbage after numerical
>    argument.
> 
> Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
> ---
>   fs/btrfs/super.c | 24 +++++++++---------------
>   1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f56617dfb3cf..6fe8ef6667f3 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -426,7 +426,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>   			unsigned long new_flags)
>   {
>   	substring_t args[MAX_OPT_ARGS];
> -	char *p, *num;
> +	char *p, *retptr;
>   	u64 cache_gen;
>   	int intarg;
>   	int ret = 0;
> @@ -630,22 +630,16 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>   			info->thread_pool_size = intarg;
>   			break;
>   		case Opt_max_inline:
> -			num = match_strdup(&args[0]);
> -			if (num) {
> -				info->max_inline = memparse(num, NULL);
> -				kfree(num);
> -
> -				if (info->max_inline) {
> -					info->max_inline = min_t(u64,
> -						info->max_inline,
> -						info->sectorsize);
> -				}
> -				btrfs_info(info, "max_inline at %llu",
> -					   info->max_inline);
> -			} else {
> -				ret = -ENOMEM;
> +			info->max_inline = memparse(args[0].from, &retptr);


> +			if (retptr != args[0].to || info->max_inline == 0) {
> +				ret = -EINVAL;
>   				goto out;

  This causes regression, max_inline = 0 is a valid parameter.

Thanks, Anand


>   			}
> +			info->max_inline = min_t(u64,
> +				info->max_inline,
> +				info->sectorsize);
> +			btrfs_info(info, "max_inline at %llu",
> +				   info->max_inline);
>   			break;
>   		case Opt_alloc_start:
>   			btrfs_info(info,
> 

