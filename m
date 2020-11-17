Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCCD2B5A33
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Nov 2020 08:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgKQHUg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Nov 2020 02:20:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58788 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKQHUg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Nov 2020 02:20:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH7K86E102502;
        Tue, 17 Nov 2020 07:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9KuU0W4G7Mkr9B5pxQRC3FiJXYFb3wCOxNReXZlAJ6A=;
 b=WDCuesXssyP/sD9BVdYMF3dPhLNPtsKdEj8GJMOcUrlIoiMhFJUkLeJqp7aixA1rJPEP
 PDpW4BV+u0lTwCFh0VAqKej8OF5vRl5rbSDrx1y7SDj2y8MCGA6WUXr2+BN5w3Qs7X3/
 VYMHI0t1HI9qDQjeP5WbA8Ul/dGKBKbjAXUVHXKVfL/UGiXswjzV/cxwb6xbH8ZTMmaF
 Q+uZ44filDJEUrnzjyW+fSnJyUPvpVR8tq0VFCcHVRK7eQVGdQ1nww8poX4CuluQsQC3
 ZaKQnAHRaMK3t7pTFXO/BsosRw/6FshOxK4+6zFXqNaNHII3xCfA8DuoaTaPallMZYWz Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34t76kry54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 07:20:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH7FGih164632;
        Tue, 17 Nov 2020 07:20:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34umcxt4xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 07:20:30 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AH7KQbU011627;
        Tue, 17 Nov 2020 07:20:27 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 23:20:23 -0800
Subject: Re: [PATCH v2] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
References: <0e9eb675e0a199bf034f13c58fbe5678f4e94a3c.1605513154.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <58b88874-7ca0-cb0c-1752-315a3fb5bab2@oracle.com>
Date:   Tue, 17 Nov 2020 15:20:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <0e9eb675e0a199bf034f13c58fbe5678f4e94a3c.1605513154.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170051
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org





On 16/11/20 3:52 pm, Johannes Thumshirn wrote:
> Syzbot reported a possible use-after-free when printing a duplicate device
> warning device_list_add().
> 
> At this point it can happen that a btrfs_device::fs_info is not correctly
> setup yet, so we're accessing stale data, when printing the warning
> message using the btrfs_printk() wrappers.
> 
> Instead of printing possibly uninitialized or already freed memory in
> btrfs_printk(), explicitly pass in a NULL fs_info so the printing of the
> device name will be skipped altogether.
> 
> Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


Sorry for the delay due to my vacation.

  Johannes,

  This patch fixes the issue in a very gross way, as I mentioned.

  Instead, do we know more about what/how threads were racing,
  leading to the access of the freed fs_info?

Thanks, Anand


> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bb1aa96e1233..507f6f17b3a9 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -940,7 +940,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   			if (device->bdev != path_bdev) {
>   				bdput(path_bdev);
>   				mutex_unlock(&fs_devices->device_list_mutex);
> -				btrfs_warn_in_rcu(device->fs_info,
> +				btrfs_warn_in_rcu(NULL,
>   	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",
>   						  path, devid, found_transid,
>   						  current->comm,
> 
