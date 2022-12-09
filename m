Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BE2647DBD
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Dec 2022 07:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLIGYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Dec 2022 01:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIGYd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Dec 2022 01:24:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB339D8B9
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Dec 2022 22:24:31 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatRT-1oW8452pz9-00cNDk; Fri, 09
 Dec 2022 07:24:23 +0100
Message-ID: <f8043322-7a70-80ac-4a19-3945df839d9b@gmx.com>
Date:   Fri, 9 Dec 2022 14:24:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] btrfs-progs: chunk tree search solution for btrfs249
To:     "Flint.Wang" <hmsjwzb@zoho.com>
Cc:     linux-btrfs@vger.kernel.org, anand.jain@oracle.com
References: <20220815024341.4677-1-hmsjwzb@zoho.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220815024341.4677-1-hmsjwzb@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:C2u7Gd/VP2BX7CnvzyU8MXqTiy5HbjNxNhEXYXV23Jgdnzmfv3W
 qmJvA40AdfwVrnnP2uvxMXB7WxSHk4AiUJrwlw/GgRY0oC7Aauh2GPNtkf0P0DXhdO+o1sH
 EukIRSQutXRYGr57Lu8X+aMFxwrHq2328nSYuti0iaZ28e56eqAaa8FJrVFO3XskxorlIqq
 r4Ci/ucZfFuDy5S/CVaDg==
UI-OutboundReport: notjunk:1;M01:P0:T+jfDevEMbA=;GQWZvAk7B1uiRdhuusnfj422M71
 0d9QhjXf6g2J1hiKGBJ9mbspYCXsdEvkyFLxIVF/UY3uQmbU4oFUHMjI2KQ2Xn8XnDuqMNi4J
 MelJA3ak02hxsNzKX8g0aLw6in36eCZt1ssiqVB3oLjgHmGL4lA53VqGi/ml+q1eRF0PHMv0t
 fgHTsGcYXN7CKBnXsX5/kdl6wu8Xm34Tyij0DWrC4E7/5fHKHXb3Go7Y2f/Kl6vI2umFKdfeo
 YnDgP3K6v71mKpgfKurJ2pOCfJdkdXV69XxQ1TNjmP1PNfQzaxFemdmtluPtXr06PnwYktUE9
 vZm5+fqLXzYX1rLB2mS8RTq70PO1nGbpMpkxRMbSGBKi6n2kgO4bIjsD8A01iaSaXa9AKhRj+
 6LLx4J2IYVxJbd/vFj64iDPwMZQVf3foHKL7lvJWnkryN89Cd4G2rBEe+8EcptkNL55r0TIS2
 0NmmAyTyIgtkY91k18rfHu/P4pKuS3CpbjTvjnGlC7eYG61W2qosvGdvpn43X4SOU3xzTrmql
 e3rh4w6mnfp6XSAOErmF+GmG+JYiOqZtEsjTZFtsADl+GDFQaCE+g8FZDxh83KOZZovAQmjuv
 y/6jWJ0HWtqiJQIBhnlqvI2jZHo1FifArB50V0ieHhJMf8T+W/GB6Jq45d1osXXV2E7QHtbQK
 lRM94ZZa7kzl5VNv8mXJnmjnFTIjHafjxDQiVfmDjU6QC7Cr6/g3ThN/JvITQRb9uSRBPa+bt
 GTfYT8X1VejsFA62Rx7GKTd1z8fqY0T0mBB2GPrStjWNUAhVvqetx4nlZh3G42gG61xU8eTLa
 KHpefS3mT6LoIDLLNaHStziPS+mFVEIs9eDWm/if0uwtJB5volNyLoUliDKoRGEP8yFdeNFsX
 61r4itqAs9d10wLryzuUPjQhAMrGmiy+Cl58p1EfgMRsWgmn9UThIneslqtOg7+rsXwuS8Xdq
 DHYzP96B3TwDF5f79ePy2Xa4kp4=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/15 10:43, Flint.Wang wrote:
> Hi Qu,
> 
> Thanks for your comment. I fix the issue you suggest.
> It is much clean now.
> 
> Btrfs249 failed due to btrfs_ioctl_fs_info() return RW devices for fi_args->num_devices.
> This patch search chunk tree to find rw devices.
> 
> v2 change:
> 1. code style fix.
> 2. noseed_dev => rw_devs, noseed_fsid => fsid.
> 3. remove redundant structure devid_uuid.
> 4. reuse the dev_info structure.
> 5. remove redundant uuid argument.
> 
> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>

Any update on this patch? IIRC btrfs/249 still fails without this patch.

Although Anand Jain has a similar patchset, but his solution requires a 
new kernel sysfs, which can still cause compatibility problems.

Thus your patch is still the better one, but your commit message still 
needs some update.

Thanks,
Qu
> ---
>   cmds/filesystem-usage.c | 83 ++++++++++++++++++++++++++++++++---------
>   1 file changed, 66 insertions(+), 17 deletions(-)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 01729e18..71f0e14c 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -25,6 +25,7 @@
>   #include <getopt.h>
>   #include <fcntl.h>
>   #include <linux/limits.h>
> +#include <uuid/uuid.h>
>   
>   #include "common/utils.h"
>   #include "kerncompat.h"
> @@ -689,6 +690,62 @@ out:
>   	return ret;
>   }
>   
> +static int load_devid(int fd, struct device_info *info,
> +			    int ndev, u8 *fsid)
> +{
> +	struct btrfs_ioctl_search_args_v2 *args2;
> +	struct btrfs_ioctl_search_key *sk;
> +	struct btrfs_ioctl_search_header *sh;
> +	struct btrfs_dev_item *dev_item;
> +	int args2_size = 1024;
> +	char args2_buf[args2_size];
> +	int ret = 0;
> +	int i = 0;
> +	int num = 0;
> +	int rw_devs = 0;
> +	int idx = 0;
> +
> +	args2 = (struct btrfs_ioctl_search_args_v2 *) args2_buf;
> +	sk = &(args2->key);
> +
> +	sk->tree_id = BTRFS_CHUNK_TREE_OBJECTID;
> +	sk->min_objectid = BTRFS_DEV_ITEMS_OBJECTID;
> +	sk->max_objectid = BTRFS_DEV_ITEMS_OBJECTID;
> +	sk->min_type = BTRFS_DEV_ITEM_KEY;
> +	sk->max_type = BTRFS_DEV_ITEM_KEY;
> +	sk->min_offset = 0;
> +	sk->max_offset = (u64)-1;
> +	sk->min_transid = 0;
> +	sk->max_transid = (u64)-1;
> +	sk->nr_items = -1;
> +	args2->buf_size = args2_size - sizeof(struct btrfs_ioctl_search_args_v2);
> +	ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH_V2, args2);
> +	if (ret != 0)
> +	       return -1;
> +
> +	sh = (struct btrfs_ioctl_search_header *) args2->buf;
> +	num = sk->nr_items;
> +
> +	dev_item = (struct btrfs_dev_item *) (sh + 1);
> +	for (i = 0; i < num; i++) {
> +		if (!uuid_compare(dev_item->fsid, fsid)) {
> +			rw_devs += 1;
> +			info[idx++].devid = dev_item->devid;
> +		}
> +		if (idx > ndev) {
> +			error("unexpected number of devices: %d >= %d", idx, ndev);
> +			return -1;
> +		}
> +		sh = (struct btrfs_ioctl_search_header *) dev_item + 1;
> +		dev_item = (struct btrfs_dev_item *) sh + 1;
> +	}
> +
> +	if (ndev != rw_devs)
> +		error("unexpected number of devices: %d != %d", ndev, rw_devs);
> +
> +	return 0;
> +}
> +
>   /*
>    *  This function loads the device_info structure and put them in an array
>    */
> @@ -718,19 +775,17 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
>   		return 1;
>   	}
>   
> -	for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
> -		if (ndevs >= fi_args.num_devices) {
> -			error("unexpected number of devices: %d >= %llu", ndevs,
> -				(unsigned long long)fi_args.num_devices);
> -			error(
> -		"if seed device is used, try running this command as root");
> -			goto out;
> -		}
> +	ret = load_devid(fd, info, fi_args.num_devices, fi_args.fsid);
> +	if (ret == -1)
> +		goto out;
> +
> +	for (i = 0, ndevs = 0 ; i < fi_args.num_devices ; i++) {
>   		memset(&dev_info, 0, sizeof(dev_info));
> -		ret = get_device_info(fd, i, &dev_info);
> +		ret = get_device_info(fd, info[i].devid, &dev_info);
>   
> -		if (ret == -ENODEV)
> -			continue;
> +		if (ret == -ENODEV) {
> +			error("device not found\n");
> +		}
>   		if (ret) {
>   			error("cannot get info about device devid=%d", i);
>   			goto out;
> @@ -759,12 +814,6 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
>   		++ndevs;
>   	}
>   
> -	if (ndevs != fi_args.num_devices) {
> -		error("unexpected number of devices: %d != %llu", ndevs,
> -				(unsigned long long)fi_args.num_devices);
> -		goto out;
> -	}
> -
>   	qsort(info, fi_args.num_devices,
>   		sizeof(struct device_info), cmp_device_info);
>   
