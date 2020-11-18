Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECD62B7A69
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 10:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgKRJbT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 04:31:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42484 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgKRJbT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 04:31:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AI9NeCW158645;
        Wed, 18 Nov 2020 09:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wJBw3csDJcjBsODnofl08mo5F7uV3hNRDS597VMbXOs=;
 b=KRe4ZNi4uF2dKngISw2hxSDlEghOMbbsxai25EKzG8mpSOUYcU4O5NoBKdeU98o06X1w
 Vc9ARprAIJnpAwylsGUIWESGgSMU115ti33XokI0oNDpLktH2DPnaMixnyXyRs5Kx2kJ
 3IAyIZR6H3FKlHPfAcrcewq75CS/e/QQgM6NcFAPQo/YNjeO56sDuxRhd6ZAIzQ3oDld
 2CaUmGcTozwXq0JN+emEz64YL6cIn6r5MyX7eOoKE8dlm5p0lb5+5O0SB0XcFjEESICH
 EH/wKewSJNN/yGjUeiox3A2eJBf2C+hhlnGuaEBNek6mwJboqeRWa2dD03OpNa48tMcK kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34t7vn6y14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 09:31:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AI9TAtu173980;
        Wed, 18 Nov 2020 09:29:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34uspuhs9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 09:29:11 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AI9T1wd002633;
        Wed, 18 Nov 2020 09:29:01 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Nov 2020 01:29:01 -0800
Subject: Re: [PATCH v3] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
References: <e639c7a057653c1947b3a4acf2fba6c7798000b5.1605690144.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <64eb0192-1997-89ee-25d0-94cc0ec93bfb@oracle.com>
Date:   Wed, 18 Nov 2020 17:28:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <e639c7a057653c1947b3a4acf2fba6c7798000b5.1605690144.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180064
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180064
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/11/20 5:03 pm, Johannes Thumshirn wrote:
> Syzbot reported a possible use-after-free when printing a duplicate device
> warning device_list_add().
> 
> At this point it can happen that a btrfs_device::fs_info is not correctly
> setup yet, so we're accessing stale data, when printing the warning
> message using the btrfs_printk() wrappers.
> 
> The syzkaller reproducer for this use-after-free crafts a filesystem image
> and loop mounts it twice in a loop. The mount will fail as the crafted
> image has an invalid chunk tree. When this happens btrfs_mount_root() will
> call deactivate_locked_super(), which then cleans up fs_info and
> fs_info::sb. If a second thread now adds the same block-device to the
> file-system, it will get detected as a duplicate device and
> device_list_add() will reject the duplicate and print a warning. But as
> the fs_info pointer passed in is non-NULL this will result in a
> use-after-free.
> 
> Instead of printing possibly uninitialized or already freed memory in
> btrfs_printk(), explicitly pass in a NULL fs_info so the printing of the
> device name will be skipped altogether.
> 
> Link: https://lore.kernel.org/linux-btrfs/000000000000c9e14b05afcc41ba@google.com
> Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to v2:
> - Add comment why we're passing NULL to btrfs_warn_in_rcu()
> - Clarify commit message
> 
> Changes to v1:
> - Use btrfs_warn_in_rcu(NULL,) instead of pr_warn()
> ---
>   fs/btrfs/volumes.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bb1aa96e1233..3f2af8106d5b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -940,7 +940,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   			if (device->bdev != path_bdev) {
>   				bdput(path_bdev);
>   				mutex_unlock(&fs_devices->device_list_mutex);
> -				btrfs_warn_in_rcu(device->fs_info,
> +				/*
> +				 * device->fs_info may not be reliable here, so
> +				 * pass in a NULL fs_info. This avoids a
> +				 * possible use-after-free when the fs_info and
> +				 * fs_info->sb are already torn down.
> +				 */
> +				btrfs_warn_in_rcu(NULL,
>   	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",
>   						  path, devid, found_transid,
>   						  current->comm,
> 

Few lines below, there is btrfs_info_in_rcu() and, we won't have
reliable device->fs_info even there. But we have seen those info
quite a lot of times. And so far, it's been ok. So

  Reviewed-by: Anand Jain <anand.jain@oracle.com>


