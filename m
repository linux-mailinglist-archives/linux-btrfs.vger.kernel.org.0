Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93C7232B24
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 07:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgG3FF5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 01:05:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41572 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3FF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 01:05:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06U51pO7058492;
        Thu, 30 Jul 2020 05:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZmG5jSOAkYrmQaRX/7sJ0dCvZpFYFDBGVRGn5mEisxM=;
 b=NZ1TvgbRBaHKk1aZGjU7NHmXHNqKnpVx98jMDVMKiHBBkzO6tkvIfmG2woQvr+DsCAEO
 kdqtAOGDTFzx4AOoZMqhh3Jok+ogfzja1USRyKPnYhOxkXDtxm72aBG3XWNLvrZKvNNv
 Ej06hZMBAQ38pSPJZ5xBMdxsJ3QzE5c32Ll7GqdlgS2bSS+pYv/n2ovBtVCPLI/ockXc
 qb2tLdUQB07Xs6tMcv2bKNWdvG2mFIAwFfrk5RkAxMVb/hv6XBlhY4u7p/o6zdr/z8vm
 5VlSC0y8rBMvxCo+9SneYOizAAgzRweTq2IlT22oGbiYxPO5eXvgQNfC2sissqCrVLMW UQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32hu1jhgdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 05:05:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06U52n9Z002517;
        Thu, 30 Jul 2020 05:05:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32hu5wun93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 05:05:52 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06U55qxS021481;
        Thu, 30 Jul 2020 05:05:52 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 22:05:51 -0700
Subject: Re: [PATCH 4/4] btrfs: Don't opencode sync_blockdev
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200722080925.6802-1-nborisov@suse.com>
 <20200722080925.6802-5-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <024f5ef0-2d97-adc0-a65b-c8ed6e4afeb8@oracle.com>
Date:   Thu, 30 Jul 2020 13:05:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200722080925.6802-5-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300037
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/7/20 4:09 pm, Nikolay Borisov wrote:
> Instead of opencoding filemap_write_and_wait simply call syncblockdev as
> it makes it abundandtly clear what's going on and why this is used. No
> semantics changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 17047c118969..d42571f36fcf 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2499,7 +2499,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   		locked = true;
>   	}
>   
> -	filemap_write_and_wait(bdev->bd_inode->i_mapping);
> +	sync_blockdev(bdev);

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

>   
>   	rcu_read_lock();
>   	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
> 

