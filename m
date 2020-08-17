Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D32464CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHQKta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 06:49:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48936 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgHQKtY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 06:49:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HAkqtE090085;
        Mon, 17 Aug 2020 10:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=B/d2dl3Jl0LNaT7CO2YFy+j8oS+0XHnLof0ar63JDFU=;
 b=a2sQQCNvfLi+ERGDcqV6gUVyOw2muJQrie81PDVTxxan0mpg5EsqNVzPvknCfYZtETtS
 NY+31MthUyO42AKovxXXBmXuFYHVXqXNhppiyloHiyJ67K7yfzM4+uByPlJEdJAFi1YB
 SKzXOjlG+J01vzPmwSSKp74UydIrJSI3KWyfFC7JDLZSrvlXYD9dHQYN8VAnL0deNwVD
 gPl0v6Fn3xLL0RtU3s5gklWJQGvRn3ifUlvSrcgHOtNIRx89nu6lbDcw+q6QmkDdkLBq
 R6h8twFhZtfNmQv38/1qg8crRRby4P1v20K02VlRVP8p0so+240HfRblB0psRyMBQ4Fr Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32x8bmx1kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Aug 2020 10:49:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HAm3GJ136427;
        Mon, 17 Aug 2020 10:49:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32xs9kjw5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 10:49:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07HAnHdN004643;
        Mon, 17 Aug 2020 10:49:17 GMT
Received: from [192.168.1.145] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Aug 2020 03:49:17 -0700
Subject: Re: [PATCH 3/3] btrfs/174: Adjust error message when setting
 compressed flag
To:     Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20200817103718.10239-1-nborisov@suse.com>
 <20200817103718.10239-3-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <68ac2545-7f62-529c-2718-4f6a59e0587d@oracle.com>
Date:   Mon, 17 Aug 2020 18:49:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817103718.10239-3-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170081
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/8/20 6:37 pm, Nikolay Borisov wrote:
> Following kernel commit "btrfs: add missing check for nocow and
> compression inode flags"

  Here too, can you pls add this to the test case header.

  Otherwise looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> btrfs refuses setting +c on +C files during
> validation of the args. Account for this by adjusting the expected
> error message.
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   tests/btrfs/174     | 2 +-
>   tests/btrfs/174.out | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/174 b/tests/btrfs/174
> index af3352212170..bca1dc5c0b3b 100755
> --- a/tests/btrfs/174
> +++ b/tests/btrfs/174
> @@ -47,7 +47,7 @@ $LSATTR_PROG -l "$swapfile" | _filter_scratch | _filter_spaces
>   
>   # Compression we reject outright.
>   echo "Enable compression"
> -$CHATTR_PROG +c "$swapfile" 2>&1 | grep -o "Text file busy"
> +$CHATTR_PROG +c "$swapfile" 2>&1 | grep -o "Invalid argument while setting flags"
>   $LSATTR_PROG -l "$swapfile" | _filter_scratch | _filter_spaces
>   
>   echo "Snapshot"
> diff --git a/tests/btrfs/174.out b/tests/btrfs/174.out
> index bc24f1fb8be3..15bdf79e7bfb 100644
> --- a/tests/btrfs/174.out
> +++ b/tests/btrfs/174.out
> @@ -2,7 +2,7 @@ QA output created by 174
>   Disable nocow
>   SCRATCH_MNT/swapvol/swap No_COW
>   Enable compression
> -Text file busy
> +Invalid argument while setting flags
>   SCRATCH_MNT/swapvol/swap No_COW
>   Snapshot
>   Text file busy
> 

