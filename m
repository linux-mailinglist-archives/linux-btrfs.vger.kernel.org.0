Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75C0256888
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Aug 2020 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgH2PIn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Aug 2020 11:08:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41900 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgH2PIm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Aug 2020 11:08:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TExeaU070282;
        Sat, 29 Aug 2020 15:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KkCTYg1IW+KOIjxLHCmYtPZbokLGtMHjTq0lMr8EiHc=;
 b=hAl1M8M0CIxyzWLkCEp019dNUPwXfW0Ias5w7Bv5FGPMm4ASiNzPwhShfUQdB4LC8HNt
 DR8dNtoqo2kMR0CSdedDlZg2DU8PI0EsQ4Wiib+r0lpvkgwHEuBGxjy1xTQJdFagesI2
 0uC60jE8GRSfNrmhggEZ74F7zjAd0qXL1dCQKIr2Ba8Q5liOBtHLNJcsl6jKYgtNBXpa
 Ca7421NzvL81BVCMzi8IB6PzGxUpN/W+rw/Cw+SOtIv6AgAaUwBo8VSxcB0635+LKuKj
 dnhKsbCxT+m5p5592pAGuNrFdr8JKSC9BtzcW2GbE5AaISRoyn7ug6Ub+O/bjhgdYDru 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 337qrh84pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Aug 2020 15:08:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TF5Wjl111924;
        Sat, 29 Aug 2020 15:06:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 337c4sg33m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Aug 2020 15:06:37 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07TF6aDw017579;
        Sat, 29 Aug 2020 15:06:36 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 Aug 2020 08:06:36 -0700
Subject: Re: [PATCH 1/5] btrfs: Factor out reada loop in __reada_start_machine
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
 <20200715104850.19071-2-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e4da26dc-5a45-96ca-ed7b-ab8e8ec2abaf@oracle.com>
Date:   Sat, 29 Aug 2020 23:06:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200715104850.19071-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008290123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008290122
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/7/20 6:48 pm, Nikolay Borisov wrote:
> This is in preparation for moving fs_devices to proper lists.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/reada.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
> index 243a2e44526e..aa9d24ed56d7 100644
> --- a/fs/btrfs/reada.c
> +++ b/fs/btrfs/reada.c
> @@ -767,15 +767,14 @@ static void reada_start_machine_worker(struct btrfs_work *work)
>   	kfree(rmw);
>   }
>   
> -static void __reada_start_machine(struct btrfs_fs_info *fs_info)
> +
> +/* Try to start up to 10k READA requests for a group of devices. */
> +static int __reada_start_for_fsdevs(struct btrfs_fs_devices *fs_devices)

  In my experience David doesn't prefer __ prefix for helper functions.

>   {
> -	struct btrfs_device *device;
> -	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>   	u64 enqueued;
>   	u64 total = 0;
> -	int i;
> +	struct btrfs_device *device;
>   
> -again:
>   	do {
>   		enqueued = 0;
>   		mutex_lock(&fs_devices->device_list_mutex);
> @@ -787,6 +786,18 @@ static void __reada_start_machine(struct btrfs_fs_info *fs_info)
>   		mutex_unlock(&fs_devices->device_list_mutex);
>   		total += enqueued;
>   	} while (enqueued && total < 10000);
> +
> +	return total;
> +}
> +
> +static void __reada_start_machine(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	int i;
> +	u64 enqueued = 0;
> +
> +again:
> +	enqueued += __reada_start_for_fsdevs(fs_devices);
>   	if (fs_devices->seed) {
>   		fs_devices = fs_devices->seed;
>   		goto again;
> 

There wasn't any need to create another helper function here IMO.

Anyway changes looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

