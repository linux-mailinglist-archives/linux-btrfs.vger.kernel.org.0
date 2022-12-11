Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5202649736
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 00:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiLKXcp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Dec 2022 18:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiLKXco (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Dec 2022 18:32:44 -0500
Received: from sender4-pp-o91.zoho.com (sender4-pp-o91.zoho.com [136.143.188.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0C81122
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 15:32:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670801554; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fWq37E4gT620m+YH2c3VB3d9XBd+U62XYREEl4oMfr9X8cr33O9FyI06fpfnc5hY5bsIpE/dW9f3V3XWg+l+g/6rQRAzlRshSvjeoTMaCQuk+bjY0rejtl80DbJz7eiursoQfwg93nXB1xoM/lRzasYDX0qWlHPhuKBlX/vuLyg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670801554; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=aToaDLpeQ9QFEcs/mJm5QPysmpqP9YC12g0FB7ukUi8=; 
        b=Fz7o1U9kjgiB1rrp7/De0CGaDvSpy233czT6AR3ECtcTfbUrEZQVP2mVQXXk2rHGbJs1xe81gII04VzQJSsNf7G/1yXQ2husFpiVOo4FxV6xSAsDcZfPdCs9+XzseO1C9nRabXB8P45CXMEm6p/H4rvXXmCfQEZG2p1oJahwMxc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670801554;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=aToaDLpeQ9QFEcs/mJm5QPysmpqP9YC12g0FB7ukUi8=;
        b=I/sXi4qQTCOEND6zYH+liyP+uvq67JW7DarSwhEhny+L0ZvJE+kbkIq856lG3dUC
        aZs/n72mSRC+l15qWi4/tYWrfOroLB3qf4RtgCqHX0FWz++/DHqej5TfIIMvPoAr6+m
        0RZsMzYnuOCARoMuW2FcF3LUsS3b5sXsUOk4KChg=
Received: from [192.168.3.2] (117.143.174.243 [117.143.174.243]) by mx.zohomail.com
        with SMTPS id 1670801553352186.03816161569534; Sun, 11 Dec 2022 15:32:33 -0800 (PST)
Message-ID: <85bf68a8-27c9-5fcd-36b4-d731c4340dbb@zoho.com>
Date:   Sun, 11 Dec 2022 23:32:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] btrfs-progs: change load_device_info to chunk tree search
 solution
To:     quwenruo.btrfs@gmx.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        sunzhipeng.scsmile@bytedance.com, strongbox8@zoho.com,
        wqu@suse.com, mabruce@micron.com
References: <20221211232011.20388-1-hmsjwzb@zoho.com>
From:   hmsjwzb <hmsjwzb@zoho.com>
In-Reply-To: <20221211232011.20388-1-hmsjwzb@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thanks for your coaching. I have updated the commit message.


Thanks,

Flint

在 2022/12/12 7:20, hmsjwzb 写道:
> From: "Flint.Wang" <hmsjwzb@zoho.com>
>
> btrfs/249 fails due to unexpected number of devices
>
> [How to reproduce]
> mkfs.btrfs -f -d raid1 -m raid1 /dev/sdb /dev/sdc
> btrfstune -S 1 /dev/sdb
> wipefs -a /dev/sdb
> mount -o degrade /dev/sdc /mnt/scratch
> btrfs device add -f /dev/sdd /mnt/scratch
> btrfs filesystem usage /mnt/scratch
>
> [Root cause]
> ioctl call BTRFS_IOC_FS_INFO returns both rw device and seed device.
> It will cause device number mismatch issues.
>
> [How to Fix]
> This patch introduce function load_devid which only return the information
> of rw devices.
>
> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
> ---
>   cmds/filesystem-usage.c | 81 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 70 insertions(+), 11 deletions(-)
>
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 5810324f..887fe034 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -27,6 +27,7 @@
>   #include <fcntl.h>
>   #include <dirent.h>
>   #include <limits.h>
> +#include <uuid/uuid.h>
>   #include "kernel-lib/sizes.h"
>   #include "kernel-shared/ctree.h"
>   #include "kernel-shared/disk-io.h"
> @@ -700,6 +701,65 @@ out:
>   	return ret;
>   }
>   
> +/*
> + * This function searches chunk tree to find rw_devs
> + */
> +static int load_devid(int fd, struct device_info *info,
> +		int ndev, u8 *fsid)
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
> +		return -1;
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
> @@ -729,19 +789,18 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>   		return 1;
>   	}
>   
> -	for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
> -		if (ndevs >= fi_args.num_devices) {
> -			error("unexpected number of devices: %d >= %llu", ndevs,
> -				fi_args.num_devices);
> -			error(
> -		"if seed device is used, try running this command as root");
> -			goto out;
> -		}
> +	ret = load_devid(fd, info, fi_args.num_devices, fi_args.fsid);
> +	if (ret == -1)
> +		goto out;
> +
> +	for (i = 0, ndevs = 0; i < fi_args.num_devices; i++) {
>   		memset(&dev_info, 0, sizeof(dev_info));
> -		ret = get_device_info(fd, i, &dev_info);
> +		ret = get_device_info(fd, info[i].devid, &dev_info);
> +
> +		if (ret == -ENODEV) {
> +			error("device not found\n");
> +		}
>   
> -		if (ret == -ENODEV)
> -			continue;
>   		if (ret) {
>   			error("cannot get info about device devid=%d", i);
>   			goto out;
