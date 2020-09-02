Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C4225A99C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 12:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIBKlX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 06:41:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59966 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBKlU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 06:41:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082AYsoY158463;
        Wed, 2 Sep 2020 10:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kY+JqqgBiFwc4mngqjmMZy9OIE5lTE1D+qr6V9keIho=;
 b=J9pw6yvAhmsYjD29lpDQeyfc2S0i0MIzYd188PqKq/R+lJ6GrdEX92PcxPHc3NADSTcM
 pp4i2COXfXy6l9DzstZagpT9CI++IyjqwF8tRi0RaxNv34OdJ77ScnQGiwSaPGxA/uz2
 vjP0UMPU8KU6Pzdel58itob9wKPXcM2f9u2/n0q0JgzcCCXiNWblvC+al4IIFMd9AiWV
 v+lI3PsPxhzAXLFYPQIftjD08wG1c0+bidGulRnuGwZDPUEctQV6Itzsj+e5UOT0ATAX
 AHMDMHETDCbX5G0cRMHkX0x3Rd+LVvUn00UUItDxag/9KvWuSh1UPzJwqhOOxpCAuoGQ fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eer1t66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 10:41:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082AfC7m123660;
        Wed, 2 Sep 2020 10:41:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3380kpshpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 10:41:15 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 082AfEA6012498;
        Wed, 2 Sep 2020 10:41:14 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 03:41:13 -0700
Subject: Re: [PATCH] btrfs: allow single disk devices to mount with older
 generations
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Daan De Meyer <daandemeyer@fb.com>
References: <6b1f037344cd8d24566f3d9873b820a73384242c.1598995167.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <779c5224-6726-9a8d-8eab-ffb610cd5ad1@oracle.com>
Date:   Wed, 2 Sep 2020 18:41:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <6b1f037344cd8d24566f3d9873b820a73384242c.1598995167.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020100
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/9/20 5:19 am, Josef Bacik wrote:
> We have this check to make sure we don't accidentally add older devices
> that may have disappeared and re-appeared with an older generation from
> being added to an fs_devices.  This makes sense, we don't want stale
> disks in our file system.  However for single disks this doesn't really
> make sense.  I've seen this in testing, but I was provided a reproducer
> from a project that builds btrfs images on loopback devices.  The
> loopback device gets cached with the new generation, and then if it is
> re-used to generate a new file system we'll fail to mount it because the
> new fs is "older" than what we have in cache.
> 
> Fix this by simply ignoring this check if we're a single disk file
> system, as we're not going to cause problems for the fs by allowing the
> disk to be mounted with an older generation than what is in our cache.
> 
> I've also added a error message for this case, as it was kind of
> annoying to find originally.
> 
> Reported-by: Daan De Meyer <daandemeyer@fb.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 77b7da42c651..eb2cc27ef602 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -786,6 +786,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   	struct rcu_string *name;
>   	u64 found_transid = btrfs_super_generation(disk_super);
>   	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
> +	bool multi_disk = btrfs_super_num_devices(disk_super) > 1;
>   	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
>   		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
>   	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
> @@ -914,7 +915,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		 * tracking a problem where systems fail mount by subvolume id
>   		 * when we reject replacement on a mounted FS.
>   		 */
> -		if (!fs_devices->opened && found_transid < device->generation) {
> +		if (multi_disk && !fs_devices->opened &&
> +		    found_transid < device->generation) {
>   			/*
>   			 * That is if the FS is _not_ mounted and if you
>   			 * are here, that means there is more than one
> @@ -922,6 +924,10 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   			 * with larger generation number or the last-in if
>   			 * generation are equal.
>   			 */
> +			btrfs_warn_in_rcu(device->fs_info,
> +		  "old device %s not being added for fsid:devid for %pU:%llu",
> +					  rcu_str_deref(device->name),
> +					  disk_super->fsid, devid);
>   			mutex_unlock(&fs_devices->device_list_mutex);
>   			return ERR_PTR(-EEXIST);
>   		}
> 

After the patch - that means if there are two identical but different
generation images/disks and if the systemd auto-scans both of them,
the scan will race and the last scanned disk/image will mount
successfully. Whereas before the patch- the disk/image with the larger
generation always won (even in single disk FS).

Are we ok with this? IMO the last scanned gets mounted is also kind of fair.

Internally I had a similar reported. I just told them to use
  btrfs device scan --forget
and try. It worked.


Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thanks, Anand



