Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660692B7AC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 10:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgKRJyz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 04:54:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38614 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKRJyz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 04:54:55 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AI9eWuQ127169;
        Wed, 18 Nov 2020 09:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=h5FuxwNh5V9GuoxuiWKIycz0XOeyUqsK9043Ar1O0N8=;
 b=Ddc5jGPbRsbQ8IzTDqLkHsyIIEQ1Ej4UI2HXdMb1XsuUmOSclU1KS1kbW2L08qyBkvbv
 x/jpblLNSG3RJx9al3pIY8NH97n2VYQkaPh6jqQwzuDKF5B2SKv8bGnHtYpPP/ocO1JN
 kGJz2qLXFjUqEPsOrjJfzjC+gbnw87ynKd7WKDheBk+P+FBz+UZ0OE/LevtCegvDwZlo
 +hhwm2eJA7JctL8uCsGS0TM/36zb0n7WpBssBClxbRAH3XNRS2+zdqHGsmt3PacJfvfp
 cywsd1BrYSaGH6FSafzaaEDqWX2YlkQ7+WeKcD8itpRh07JZtDjisRzSO0fkVfLVyLPc NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34t4rayahw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 09:53:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AI9fB3o047748;
        Wed, 18 Nov 2020 09:53:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34ts5xa490-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 09:53:32 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AI9rQIK024397;
        Wed, 18 Nov 2020 09:53:26 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Nov 2020 01:53:26 -0800
Subject: Re: [PATCH v2] btrfs: return EAGAIN when receiving a pending signal
 in the defrag loops
To:     xiakaixu1987@gmail.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
References: <1605672156-29051-1-git-send-email-kaixuxia@tencent.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4d25ee0c-ba57-cd3f-7a6a-981a21c0967d@oracle.com>
Date:   Wed, 18 Nov 2020 17:53:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <1605672156-29051-1-git-send-email-kaixuxia@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180065
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/11/20 12:02 pm, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The variable ret is overwritten by the following variable defrag_count.
> Actually the code should return EAGAIN when receiving a pending signal
> in the defrag loops.
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
> v2
>   -return EAGAIN instead of remove the EAGAIN error.

  Sorry I might have missed in v1. Why was EAGAIN needed here?
  Return of defrag_count rather makes sense to me as of now.

Thanks, Anand

> 
>   fs/btrfs/ioctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 69a384145dc6..6f13db6d30bd 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1519,7 +1519,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
>   		if (btrfs_defrag_cancelled(fs_info)) {
>   			btrfs_debug(fs_info, "defrag_file cancelled");
>   			ret = -EAGAIN;
> -			break;
> +			goto out_ra;
>   		}
>   
>   		if (!should_defrag_range(inode, (u64)i << PAGE_SHIFT,
> 

