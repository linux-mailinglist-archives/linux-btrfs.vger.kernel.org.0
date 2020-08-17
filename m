Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0122464C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 12:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHQKsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 06:48:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53796 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgHQKsO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 06:48:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HAlNSq183472;
        Mon, 17 Aug 2020 10:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=dmN4AqLl+bvSZznC2o35sQ+il41dDzugkzWY93cit68=;
 b=Iwffj/zgPF+W3kV9k7pmKxbWjFxZO5dKXFcIHD9UgGFr0Mao5W0ggS9UHjMteIl7Lk/c
 PS1c0i3B/GW4NSf64M5kHaJEHoJw7QaAcepuN+rFwrJOa+b+pMSsuhlv4lYjUIJVNFVY
 fgHHXjWm92pz8TrgkaFFrmEwkMfiPScyVO94uDwbRheAKqJvSRzR1oEhtbxf9RStAtW8
 Hv0dPm4PXtayg549yWUryH7BrgbtaWhUweasxQDTK4ze+/6t9NDz/Gy967d67Rkcq/Tg
 dWvuC90VdJkBIYIESQZ7TO4hEdRyTUjrBs+XeSPzB1xxhetn+JCCRvGtQkIkV13YVEcY Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32x7nm64kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Aug 2020 10:48:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HAm5Q0177514;
        Mon, 17 Aug 2020 10:48:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32xsfqcw92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 10:48:07 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07HAlwZf000352;
        Mon, 17 Aug 2020 10:47:59 GMT
Received: from [192.168.1.145] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Aug 2020 03:47:58 -0700
Subject: Re: [PATCH 2/3] btrfs/173: Adjust compress file check
To:     Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20200817103718.10239-1-nborisov@suse.com>
 <20200817103718.10239-2-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0c7ab04e-c93b-1033-aad9-bc76a56de619@oracle.com>
Date:   Mon, 17 Aug 2020 18:47:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817103718.10239-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170081
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/8/20 6:37 pm, Nikolay Borisov wrote:
> Following kernel commit "btrfs: add missing check for nocow and
> compression inode flags" 

  Can you add this to the test case header.

  Otherwise looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>



> the enforcement of "can't set +c on a +C" file
> has been moved to the ioctl code. Modify the test to account for this.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   tests/btrfs/173     | 4 +---
>   tests/btrfs/173.out | 2 +-
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/btrfs/173 b/tests/btrfs/173
> index 515d8cfa0994..c427320ad664 100755
> --- a/tests/btrfs/173
> +++ b/tests/btrfs/173
> @@ -48,9 +48,7 @@ swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
>   echo "Compressed file"
>   rm -f "$SCRATCH_MNT/swap"
>   _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> -$CHATTR_PROG +c "$SCRATCH_MNT/swap"
> -swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
> -swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
> +$CHATTR_PROG +c "$SCRATCH_MNT/swap" 2>&1 | grep -o "Invalid argument while setting flags"



>   
>   status=0
>   exit
> diff --git a/tests/btrfs/173.out b/tests/btrfs/173.out
> index 6d7856bf9e02..2920384045ad 100644
> --- a/tests/btrfs/173.out
> +++ b/tests/btrfs/173.out
> @@ -2,4 +2,4 @@ QA output created by 173
>   COW file
>   swapon: SCRATCH_MNT/swap: swapon failed: Invalid argument
>   Compressed file
> -swapon: SCRATCH_MNT/swap: swapon failed: Invalid argument
> +Invalid argument while setting flags
> 


