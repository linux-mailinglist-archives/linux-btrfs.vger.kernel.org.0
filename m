Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02C42529C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 11:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHZJNd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 05:13:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39002 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgHZJNd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 05:13:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07Q9AYVc103338;
        Wed, 26 Aug 2020 09:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8h+zH2kESwQ77jzqrRmO8BxPKLT+GRwZ7qeZDe2BOHY=;
 b=D5k8vecquShQaUgwG3OmIqf3Ie09VndeH+IDcKJxGOPweIF7zMF+RKjBbl3tLXCfV75C
 ag4jWRt+0gy3/ysx/+Sf16CYzsxrJhT67HuTGqD+8EYZLjmptBB8WpBmhJrrUgzIINDl
 l5MU2M5tywXiJ4CICgDfXkTljCLP6uzI+gcZ4uLa9Acx7A5mL66LvFfcH9GrbHZluN7k
 V1gCKxmvqElS+NPbR3s19+vlnBjsDMKNPHKYGBYeBxmg2YoqGgKy1zejWM15AXYSEnal
 Bhqq9dKMd8QQo/Br76qcT/8SswupKv03Jo30KzdjLlN8MEOcgns7U+IwLDYn5FgXCIDN fQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 335gw8145m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 09:13:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07Q9BK4w084384;
        Wed, 26 Aug 2020 09:13:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 333r9kn7tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 09:13:28 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07Q9DQw4002705;
        Wed, 26 Aug 2020 09:13:27 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 02:13:26 -0700
Subject: Re: [PATCH] btrfs: Document some invariants of seed code
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200812140436.11749-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3bcbd334-7b8d-dcd4-7ec2-41672ea35960@oracle.com>
Date:   Wed, 26 Aug 2020 17:13:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200812140436.11749-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260073
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/8/20 10:04 pm, Nikolay Borisov wrote:
> Without good understanding of how seed devices works it's hard to grok
> some of what the code in open_seed_devices or btrfs_prepare_sprout does.
> 
> Add comments hopefully reducing some of the cognitive load.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/volumes.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 631cb03b3513..f7ee7837e6bc 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2361,10 +2361,20 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>   	if (!fs_devices->seeding)
>   		return -EINVAL;
>   
> +	/*
> +	 * Private copy of the seed devices, anchored at
> +	 * fs_info->fs_devices->seed_list
> +	 */
>   	seed_devices = alloc_fs_devices(NULL, NULL);
>   	if (IS_ERR(seed_devices))
>   		return PTR_ERR(seed_devices);
>   
> +	/*
> +	 * It's necessary to retain a copy of the original seed fs_devices in
> +	 * fs_uuids so that filesystems which have been seeded can be
> +	 * successfully reference the seed device from open_seed_devices. This
> +	 * also supports multiple fs seed.
> +	 */
 >
>   	old_devices = clone_fs_devices(fs_devices);
>   	if (IS_ERR(old_devices)) {
>   		kfree(seed_devices);
> @@ -6713,6 +6723,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
>   	lockdep_assert_held(&uuid_mutex);
>   	ASSERT(fsid);
>   
> +	/* This will match only for multi-device seed fs */
>   	list_for_each_entry(fs_devices, &fs_info->fs_devices->seed_list, seed_list)
>   		if (!memcmp(fs_devices->fsid, fsid, BTRFS_FSID_SIZE))
>   			return fs_devices;
> @@ -6732,6 +6743,10 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
>   		return fs_devices;
>   	}
>   
> +	/*
> +	 * Upon first call for a seed fs fsid just create a private copy of the
> +	 * respective fs_devices and anchor it at fs_info->fs_devices->seed_list
> +	 */
>   	fs_devices = clone_fs_devices(fs_devices);
>   	if (IS_ERR(fs_devices))
>   		return fs_devices;
> 


Looks good. Thanks

Reviewed-by: Anand Jain <anand.jain@oracle.com>

