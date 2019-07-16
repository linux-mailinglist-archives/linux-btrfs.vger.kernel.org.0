Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD636AA55
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbfGPOIv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 10:08:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGPOIv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 10:08:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GE3wn9084632;
        Tue, 16 Jul 2019 14:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=mTnmIQweDM9AoYeIkocV1y7Epb+g4+9Dfn8HM08SA+w=;
 b=zVMf4ncPFqWuJPW0km1qCFiisIlCJsIJOrc0NamfwnyPgZP04LO8rp4064jAShQAmSrc
 OlsAAUKPRQQ34Y7c8bRx+yQYRe+5L9qvUwRk9VJofy6dO7V5JpqWNmhpXdm0sdHBQcrt
 FnvYL1+2DjnxTiBHIClr2dOFzgpiGyD7r9Peao0Lm5sHn4iC0v+MprLiOHhgZ/jNLz6Y
 NPhUoTk7ZUSU0DzCsJeWQF4t1M5ZNl8S8gAf6KVbJ47JSlxIhVUFV/4baMMq+7JXRVJf
 XiaHp5l2999q9Ul812odMciksyY0ajCOX96dlap9iDVaWeaWLeryJXog+1uymGNqZCvZ xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtmugj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:08:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GE7pR3010294;
        Tue, 16 Jul 2019 14:08:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tq4dtxvsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:08:40 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GE8dJS028967;
        Tue, 16 Jul 2019 14:08:39 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 14:08:39 +0000
Subject: Re: [PATCH] btrfs: ratelimit device path change info on mounted
 device
From:   Anand Jain <anand.jain@oracle.com>
To:     g.btrfs@cobb.uk.net, calestyo@scientia.net
Cc:     linux-btrfs@vger.kernel.org
References: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
 <20190716135910.848-1-anand.jain@oracle.com>
Message-ID: <f6cf1499-baf4-087a-0778-305aa1fcf2bc@oracle.com>
Date:   Tue, 16 Jul 2019 22:08:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190716135910.848-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160173
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Graham, Chris,

  I am unable to reproduce, would you be able to try this patch and let 
me know if this fixes the problem?

Thanks, Anand


On 16/7/19 9:59 PM, Anand Jain wrote:
> If there are more than one path to a device, the last scanned path
> will map to the mounted FS. In some Linux based os there appears to be a
> system script (autofs?) which fails to notice that a device's alternative
> path is already mounted, and so the change in device-path gets logged
> every ~2mins whenever such a script is active.
> 
> kernel: [33017.407252] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
> kernel: [33017.522242] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
> kernel: [33018.797161] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
> kernel: [33019.061631] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
> 
> Fix this by using the ratelimit printk.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reported-by: g.btrfs@cobb.uk.net
> Reported-by: calestyo@scientia.net
> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a13ddba1ebc3..b4c4add7b5e7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1086,7 +1086,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   				return ERR_PTR(-EEXIST);
>   			}
>   			bdput(path_bdev);
> -			btrfs_info_in_rcu(device->fs_info,
> +			btrfs_info_rl_in_rcu(device->fs_info,
>   				"device fsid %pU devid %llu moved old:%s new:%s",
>   				disk_super->fsid, devid,
>   				rcu_str_deref(device->name), path);
> 

