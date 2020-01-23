Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CA1462FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 09:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAWIA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 03:00:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43130 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWIA2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 03:00:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00N7xdmL185807;
        Thu, 23 Jan 2020 08:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=pm2h81Z57yMqyFvyV66tYgRs65dne9OBDvQ2NSrz6DI=;
 b=rczLPm3n1Zhse2xK5XTwo8PtY6BuCLxlm0DL26vzosf9uK9csPxR6jhSpFR730owoAOw
 F7zxvqoetWo1YL2SKK4isN6mK6PN+L6bDPHxnOEn78EI1m1xYNw4nj4d6KUyI3o1h828
 5MgWjOzjUQR+TrjzzDLfeiodOhaNqYe3+wGufuTeF+aV6bKS1SfdxUwCd0qa12Es0uKN
 WLdniPqbOl9qKjj0hLbHpjMvmkz4uoK2X1scrCWC16LmvZO0hdBpgnrcFkrZL1mblDrj
 a/0ATEw09PatUEnUJBiVzx2tdiqEeneJT+U2f7GbD0QUM6kHG8fHm/pweg8tqkX2DMqF bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xkseurnn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 08:00:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00N7wpHc104606;
        Thu, 23 Jan 2020 08:00:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xppq53b6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 08:00:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00N80MHx007978;
        Thu, 23 Jan 2020 08:00:22 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 00:00:22 -0800
Subject: Re: [PATCH] btrfs: Add intrudoction to dev-replace.
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200123074450.24328-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <05118712-c5b2-f696-937a-5984be274ca4@oracle.com>
Date:   Thu, 23 Jan 2020 16:00:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200123074450.24328-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230068
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/23/20 3:44 PM, Qu Wenruo wrote:
> The overview of btrfs dev-replace is not that complex.
> But digging into the code directly can waste some extra time, so add
> such introduction to help later guys.
> 
> Also, it mentions some corner cases caused by the write duplication and
> scrub based data copy, to inform new comers not to get trapped by that
> pitfall.
> 

looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

nits below.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/dev-replace.c | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index f639dde2a679..5889c10ed8d2 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -22,6 +22,44 @@
>   #include "dev-replace.h"
>   #include "sysfs.h"
>   
> +/*
> + * Introduction for dev-replace.
> + *
> + * [Objective]
> + * To copy all extents (both runtime and on-disk) from source device
> + * to target device, while still keeps the fs RW.
> + *
> + * [Method]
> + * There are two main methods involved:
> + * - Write duplication
> + *   All newer write will to written to both target and source devices.
                           ^^^^^^^^^

> + *   So that even replace get canceled, old device is still valid.
> + *
> + *   Location:		handle_ops_on_dev_replace() from __btrfs_map_block()

Term Location is bit confusing, instead Functions will do?

Thanks, Anand

> + *   Start timing:	btrfs_dev_replace_start()
> + *   End timing:	btrfs_dev_replace_finishing()
> + *   Content:		Latest data/meta
> + *
> + * - Existing extents copy
> + *   This happens by re-using scrub facility, as scrub also iterates through
> + *   exiting extents from commit root.
> + *
> + *   Location:		scrub_write_block_to_dev_replace() from
> + *   			scrub_block_complete()
> + *   Content:		Data/meta from commit root.
> + *
> + * Due to the content difference, we need to avoid nocow write when dev-replace
> + * is happening.
> + * This is done by marking the block group RO and wait for nocow writes.
> + *
> + * After replace is done, the finishing part is done by:
> + * - Swap target and source device
> + *   When the scrub finishes, swap the source device with target device.
> + *
> + *   Location:		btrfs_dev_replace_update_device_in_mapping_tree() from
> + *   			btrfs_dev_replace_finishing()
> + */
> +
>   static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
>   				       int scrub_ret);
>   static void btrfs_dev_replace_update_device_in_mapping_tree(
> 

