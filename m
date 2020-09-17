Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE1C26D32A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 07:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIQFhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 01:37:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33978 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQFhr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 01:37:47 -0400
X-Greylist: delayed 13800 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 01:37:46 EDT
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08H1kKL7150971;
        Thu, 17 Sep 2020 01:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=YACpWeJWy4LHltrKxgba5kfoRSfcptXZK/mAzJLdVXM=;
 b=z83QzQfcZITi2F4T2SA/jRydig4u4ssPOuhpDDljnpjEaZ1bmn9fx+xUY3uDyI/ZwzJH
 6ZNz1CnTFEZ0FvWZYt0GiiKe3JAiJXJT+LlQNS5Wjqylf2xYOQRzZTHEYTZF6qvgmJrc
 ypot+0K19S/3aqp+kOZduIo49rUcFJnTijKiYP5zt3mK/xZU9Y5BpOm9nYlxz1lHpAEE
 hOsYOG6w6/1sCA/pUFTkV++u653pkzbjy49MIuPDabpCD9QRgZJaCWcTJ5/FIyTu259w
 pnPyRW2OxWIfeZqJYmlPdr0XfS5D0xdnYlFNSx6xlpBXfuR7d3HuqxhxKWQ+nfRxF3BQ 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33j91dqx6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 01:47:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08H1k2pw190202;
        Thu, 17 Sep 2020 01:47:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33khpmajsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 01:47:30 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08H1lTII010905;
        Thu, 17 Sep 2020 01:47:29 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Sep 2020 01:47:29 +0000
Subject: Re: [PATCH -next] btrfs: Make btrfs_sysfs_add_fs_devices static
To:     YueHaibing <yuehaibing@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200916142604.37744-1-yuehaibing@huawei.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <9d4c2521-338a-8bce-46a7-b48818ddad66@oracle.com>
Date:   Thu, 17 Sep 2020 09:47:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200916142604.37744-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170011
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




On 16/9/20 10:26 pm, YueHaibing wrote:
> Fix sparse warning:
> 
> fs/btrfs/sysfs.c:1386:5: warning:
>   symbol 'btrfs_sysfs_add_fs_devices' was not declared. Should it be static?


  misc-next branch has it declared static. It was fixed later.

Thanks, Anand


> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   fs/btrfs/sysfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index e7b0e10685d9..279d9262b676 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1383,7 +1383,7 @@ int btrfs_sysfs_add_device(struct btrfs_device *device)
>   	return ret;
>   }
>   
> -int btrfs_sysfs_add_fs_devices(struct btrfs_fs_devices *fs_devices)
> +static int btrfs_sysfs_add_fs_devices(struct btrfs_fs_devices *fs_devices)
>   {
>   	int ret;
>   	struct btrfs_device *device;
> 
