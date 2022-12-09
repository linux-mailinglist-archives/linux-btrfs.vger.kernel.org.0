Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E9364804C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Dec 2022 10:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLIJoA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Dec 2022 04:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLIJn6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Dec 2022 04:43:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8EA5E9FE
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Dec 2022 01:43:55 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6bk4-1otOjY1lx0-0182bH; Fri, 09
 Dec 2022 10:43:43 +0100
Message-ID: <129c749d-09d9-3cb3-0f2b-de55b95ac13f@gmx.com>
Date:   Fri, 9 Dec 2022 17:43:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] btrfs-progs: change load_device_info to chunk tree search
 solution
Content-Language: en-US
To:     "Flint.Wang" <hmsjwzb@zoho.com>, linux-btrfs@vger.kernel.org,
        anand.jain@oracle.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        sunzhipeng.scsmile@bytedance.com, strongbox8@zoho.com, wqu@suse.com
References: <20221209090825.2900-1-hmsjwzb@zoho.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221209090825.2900-1-hmsjwzb@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zr2ddkp+UDZd1vPC/OQ8rqjHRUV2VLBuGS8YmyaDBoxNHChoz/v
 Se6ogloROYaqBZQ001BM4Sryoqupyfe+W2aOYWhLFT6sYtFLrmVuzkbIhqvwYCpqMgOMeEw
 ign+WNYehRU7gmW8x0ppZ2PKALOdg8Tt1YRkmTSBcimSOYozPXBBG2Gvkhsqu4pqe6+dizp
 GN6CxE9wcvEGiEqIbdNpA==
UI-OutboundReport: notjunk:1;M01:P0:xiJDFY1BYwc=;kr/BTSWmjbdFGvUyw36HK+lyP+w
 cqE3Q10CVGnq1Gfg2owj7I6lemjAQqvFKwRpp3ptcJUK1ekYkA5F4ZEZF+nO/m0jB0auL18Wm
 KONX4XWJlEevn7DwYN5b8wyZphi02jpjIx9rh/lHRjrMN7cUsNL6oL2t8fIwUcRqPXqKXxJbn
 BU5lCx9xn++bUs8A32979asiQSXJVQCxctzzJSVSFfmEazaX2I1EmfctehYK8kat+ead041I+
 gr15e58h162OFsTS3QwyhxJO7FFwkkOWnqWh6HI191K9RKFoSQE7SjRn/bGKYWK2lMUE1H4Pg
 lfaGMjsORf8NhmTl8PQ/CVhZSzVJc7pxGbJ2BO9ZbsBD2PjXAs4N9/HtXsSM1jO0ph6Le8HhZ
 jr49idv55I/BVfmxFwj3pBU1LZNNUm/upiOerSfOk+efPo9kM2yc+BPlxtfqB0WAH+sLnXI68
 BkoUFaSmn6+v8bfX0BTpLPHuM/OHpaHq75Bu8o7ZJss3RrcZQ45uMQrCeWbpAJScrF18YTVwO
 5owDCFxPRAa1JUlyLFQYUI2G0GWuKKyqe3711b2AQsehwdLMua2WDpZG+04D6MQ98J3nQzwFs
 IM1RNf0ntXpLk0dLOXZsPCDc+Sl7Q7uDdmD+E+BBgXHFu5YJUGU7sSAa5m6wJYsTTKU7RElby
 aMNN/2vVH4yyP56Sw7Gww8ZGKQk/Os+swYGYo09hOkbJ6DsMlkNHXXoyd8OkjN/UOgB2KNZy8
 O6As8RR0x3mOKpumTlSN559031DVHe8HnBdB3sARzhd1M7quFI/45nYRw9Zj9uvrla1vdd907
 u0MkBbTl+vriYVNs5D9XyejeEXOY/1anAdbidgIN8LkFo4jnrd7dYsFBe9B9vNZrMARmgllAQ
 NwFTu2noVK34qLG+yzbZiCL2M46vj3FGdUaVawsLUnjdAHMl1fLMiC40pM1+XiS0RdEP081x0
 YTmmFAC9NTqt1Uolcvg4SkHNCHs=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/9 17:08, Flint.Wang wrote:
> btrfs/249 failed due to btrfs_ioctl_fs_info() return RW devices for fi_args->num_devices.
> This patch change load_device_info to chunk tree search solution.

The commit message is still far from ideal.

At least you need to explain why the test case failed (in details).

And how your fix is going to change the situation.

> 
> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
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
