Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D688D256865
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Aug 2020 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgH2OqN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Aug 2020 10:46:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52560 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2OqM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Aug 2020 10:46:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TEi39o183653;
        Sat, 29 Aug 2020 14:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=d3HjcTKfvVfXpH7awmZ+6HUxAJek1cc0Im2YMBRVhPs=;
 b=tvUj2bseqk7T3GONZD/YQMml7b7if4GHLcHhM7iSIYbVv73D7JzBvjl3fo5PRY41Y80S
 cava9ZAFeA1RCIdEY2VLBJ+IBK2Vt0sCVe7tFHB+D0iToKzMoFTpNqyb4dZ1DEOMm3mM
 UklXCAzdgzWat0GZfaNvq9n28Ypm5iWNDH24vPXC29WsnsqWcifiU+WhfGWnRIl9xtPD
 F+aAKBGaipbf/WGYTyyLrJtH68PEB48aEXEVXO55w+Ctl9LsMxZPdzTT4ug8e14nSK6Z
 Ijl+/16GmT0QwzhZb4C9vabpRNlajXzGBZiiBSzmxsGsZesksoK6G9u7Yt8wBgqfz3ZN oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eyks0fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Aug 2020 14:46:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TEitx1095625;
        Sat, 29 Aug 2020 14:46:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 337ebh52tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Aug 2020 14:46:08 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07TEk71N003436;
        Sat, 29 Aug 2020 14:46:07 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 Aug 2020 07:46:07 -0700
Subject: Re: [PATCH] btrfs: hold the uuid_mutex for all close_fs_devices calls
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <e45e00c3d31286c86b76693262266e702ed7f1a3.1598624685.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c04069a9-67b9-e531-35f4-3d8199ef6c0d@oracle.com>
Date:   Sat, 29 Aug 2020 22:46:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <e45e00c3d31286c86b76693262266e702ed7f1a3.1598624685.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=2 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008290120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008290120
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/8/20 10:24 pm, Josef Bacik wrote:
> My recent change to not take the device_list_mutex for closing devices
> added a lockdep_assert_held(&uuid_mutex) to close_fs_devices.  I then
> went and verified all calls had that, except I overlooked
> btrfs_close_devices() where we close seed devices.  Fix this by holding
> the uuid_mutex for this entire operation.
> 
> 20cc6d129252 ("btrfs: do not hold device_list_mutex when closing devices")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6f489245eec6..3f8bd1af29eb 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1183,13 +1183,13 @@ void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
>   	close_fs_devices(fs_devices);
>   	if (!fs_devices->opened)
>   		list_splice_init(&fs_devices->seed_list, &list);
> -	mutex_unlock(&uuid_mutex);
>   
>   	list_for_each_entry_safe(fs_devices, tmp, &list, seed_list) {
>   		close_fs_devices(fs_devices);
>   		list_del(&fs_devices->seed_list);
>   		free_fs_devices(fs_devices);
>   	}
> +	mutex_unlock(&uuid_mutex);
>   }
>   
>   static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Thanks, Anand
