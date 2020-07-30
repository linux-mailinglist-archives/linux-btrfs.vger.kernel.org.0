Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7313B232B28
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 07:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgG3FIH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 01:08:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35148 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3FIH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 01:08:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06U57uKw062855;
        Thu, 30 Jul 2020 05:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RztMEwgebktGZgWGQ3GzhhftHW1vt0XcrSwvYnLyZfY=;
 b=i2zEKj2ASp2tSd1VLdvTcr3GccOYqKg/GJdYS3BYtwqSUI2QFTC7zH4L1fGyuxcDzLvl
 vlPgPaLykpRio14v6vuMRBzBQznKjYTU8LORjBOtI6sTWcqbSIgs4EjM02s/4fMf6qPB
 JXGoo4fjjZl42nyH5wOo5TxLyOzhPLUiebc7eK/VdEakvUPzVNRU/3cpY3hoxP60QOvH
 kGq8hXLa7DA9laWXxF0UK29c/BYiR8gD3vmAn9SlOq45OJhFIvUGvkZkHFKU1wTnazil
 AsRTSkHECkObYqvLMO8PVv6ohJPBLmFfQwtaXi2hObfYe7agfzisDCk28ya3HH4BRtjM Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32hu1jsg5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 05:08:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06U52mAu002411;
        Thu, 30 Jul 2020 05:08:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32hu5wurdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 05:08:03 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06U581ST007615;
        Thu, 30 Jul 2020 05:08:02 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 22:08:00 -0700
Subject: Re: [PATCH] btrfs: open-code remount flag setting in btrfs_remount
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <20200722090039.17402-1-johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <83fd1439-1322-ba84-8eb9-9309f95ab6d5@oracle.com>
Date:   Thu, 30 Jul 2020 13:07:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200722090039.17402-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300038
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> -static inline void btrfs_remount_prepare(struct btrfs_fs_info *fs_info)
> -{
> -	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
> -}
> -
>   static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,
>   				       unsigned long old_opts, int flags)
>   {
> @@ -1837,7 +1832,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>   	int ret;
>   
>   	sync_filesystem(sb);
> -	btrfs_remount_prepare(fs_info);
> +	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
>   

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

