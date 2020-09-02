Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982DB25B06F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 17:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgIBP6t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 11:58:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35878 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbgIBP6s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 11:58:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082FoE2X011480;
        Wed, 2 Sep 2020 15:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fTZoZa+Ru+CEulHvikfGZj3hCzpj4EjtU23Jcamx35Q=;
 b=qKfbHMsEDZYJMLPmv0gSQniB8WJ5g1GbBRn0/egYJTdG+bAQVguaO6a46BtzNzuOnNc0
 SAMuWp7ZB/a3CVhx1RqnDWcKBnUZyErkdQqMEwdThjOyE3eXs8ZeOWlzXphNnaWGaPsy
 nvlE7VXg4GFRogxMWZI6yoYfOmYfVym6GWhDXgSETdrBe/zm562XWPLz3+1agKVMKGHC
 nponJ1pU44dhcSnNZVISALq+Zm68a0pzdHp3CkE1MgysT5QtBmEFesiYHENLSNFYP+BA
 VbL7H2OFRjLnZ//BKnFIjFklIjqBbMLzm9obRIHlip8CuD8umCdTu8TSZSWmUVwIfmoL wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 337eymbf8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 15:58:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082FseMl139869;
        Wed, 2 Sep 2020 15:58:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3380x722pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 15:58:44 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 082FwgV2010530;
        Wed, 2 Sep 2020 15:58:43 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 08:58:42 -0700
Subject: Re: [PATCH 5/5] btrfs: Switch seed device to list api
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
 <20200715104850.19071-6-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <09086e7f-a00d-a65f-e750-e833e7eba3cc@oracle.com>
Date:   Wed, 2 Sep 2020 23:58:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200715104850.19071-6-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020151
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



The seed of the current sprout should rather be at the head instead of 
at the bottom.


> @@ -2397,7 +2381,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>   	fs_devices->open_devices = 0;
>   	fs_devices->missing_devices = 0;
>   	fs_devices->rotating = false;
> -	fs_devices->seed = seed_devices;
> +	list_add_tail(&seed_devices->seed_list, &fs_devices->seed_list);

  It should be list_add_head.

>   
>   	generate_random_uuid(fs_devices->fsid);
>   	memcpy(fs_devices->metadata_uuid, fs_devices->fsid, BTRFS_FSID_SIZE);




> @@ -6728,8 +6718,8 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
>   		goto out;
>   	}
>   
> -	fs_devices->seed = fs_info->fs_devices->seed;
> -	fs_info->fs_devices->seed = fs_devices;
> +	ASSERT(list_empty(&fs_devices->seed_list));
> +	list_add_tail(&fs_devices->seed_list, &fs_info->fs_devices->seed_list);

  It should be list_add_head.

>   out:
>   	return fs_devices;
>   }


Thanks, Anand
