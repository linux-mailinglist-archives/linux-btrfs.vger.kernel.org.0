Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB23225688C
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Aug 2020 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgH2PNr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Aug 2020 11:13:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44788 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgH2PNq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Aug 2020 11:13:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TFAGKx077205;
        Sat, 29 Aug 2020 15:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=hhwNf6haHzJElW/Ihl3u9bXy5YBoFkMzFUtaSu0TP00=;
 b=b6/B66EMF8Hesp/+QcB0wZNEd06Z38D/rPVzxDYwmZg7Xzt/hztbRpdr/ZMfjnXov7x/
 1bJKtf7N3kEZi9ws2aHcfLxUNbxu0MKNLn+B9JG4xqE9apob3YuAzdSFRqQy//xEiXk/
 ddQUXb4g3saa12juxGQdIIMGN533sE2pRIgrKlMDHiN3kGyACAcvN/iHI+DwXt4BPJ1y
 a3aFPwOb79aN9Ih+EUUYpM30BDv1D7yWdAzrgRdCwbbPZjOcDZY4xT4VDyVtdA2Viajl
 sjgvWDnxdlEdO0iYrlEusxzV/H2xFcwWQAHBgIJ05j0LchNABdtuaz0gZVye0K+Dp3xE rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 337qrh8509-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Aug 2020 15:13:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TF5WR7111913;
        Sat, 29 Aug 2020 15:13:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 337c4sg739-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Aug 2020 15:13:41 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07TFDeIx014869;
        Sat, 29 Aug 2020 15:13:41 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 Aug 2020 08:13:40 -0700
Subject: Re: [PATCH v2] btrfs: Factor out loop logic from
 btrfs_free_extra_devids
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200715104850.19071-3-nborisov@suse.com>
 <20200716071704.29960-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f067e536-1dec-9781-b706-fa48e9a84279@oracle.com>
Date:   Sat, 29 Aug 2020 23:13:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200716071704.29960-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=2 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008290123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=2 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008290123
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/7/20 3:17 pm, Nikolay Borisov wrote:
> This prepares the code to switching seeds devices to a proper list.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> V2:
>   * Added missing static modifier to the factored out function. Reported by
>   kernel test robot
> 
>   fs/btrfs/volumes.c | 34 +++++++++++++++++++++-------------
>   1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index ce01e44f8134..76a68edb3127 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1024,28 +1024,24 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>   	return ERR_PTR(ret);
>   }
> 
> -/*
> - * After we have read the system tree and know devids belonging to
> - * this filesystem, remove the device which does not belong there.
> - */
> -void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step)
> +
> +
> +static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
> +				      int step, struct btrfs_device **latest_dev)

David doesn't prefer __ prefix for helpers.

>   {
>   	struct btrfs_device *device, *next;
> -	struct btrfs_device *latest_dev = NULL;
> 
> -	mutex_lock(&uuid_mutex);
> -again:
>   	/* This is the initialized path, it is safe to release the devices. */
>   	list_for_each_entry_safe(device, next, &fs_devices->devices, dev_list) {
>   		if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
> -							&device->dev_state)) {
> +			     &device->dev_state)) {
>   			if (!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
> -			     &device->dev_state) &&
> +				      &device->dev_state) &&
>   			    !test_bit(BTRFS_DEV_STATE_MISSING,
>   				      &device->dev_state) &&
> -			     (!latest_dev ||
> -			      device->generation > latest_dev->generation)) {
> -				latest_dev = device;
> +			    (!*latest_dev ||
> +			     device->generation > (*latest_dev)->generation)) {
> +				*latest_dev = device;
>   			}
>   			continue;
>   		}
> @@ -1083,6 +1079,18 @@ void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step)
>   		btrfs_free_device(device);
>   	}
> 
> +}
> +/*
> + * After we have read the system tree and know devids belonging to
> + * this filesystem, remove the device which does not belong there.
> + */
> +void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step)
> +{
> +	struct btrfs_device *latest_dev = NULL;
> +
> +	mutex_lock(&uuid_mutex);
> +again:
> +	__btrfs_free_extra_devids(fs_devices, step, &latest_dev);


>   	if (fs_devices->seed) {
>   		fs_devices = fs_devices->seed;
>   		goto again;
> --
> 2.17.1
> 


Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

