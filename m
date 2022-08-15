Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389C7592D52
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiHOIGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 04:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiHOIGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 04:06:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176B355A6
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660550803;
        bh=ajUd3aPilN48VKnGloyzW8PK1oyKrAJV/0ll3EEhLro=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=VKYWP8X616OUQLcrE5exLd7ZCcG188CQStyW3xkIxnqn9aUdLirPKGOkTfTGYy6ku
         8PCTjnxfBo29Nf1fhbiHVB6VgDjk2a7828rEp1tuvNiVtcjzg79NN55mRUa4HqEHD1
         OiyuvyvHt0n2cI+YGmNW6SqiNA0J+zw4SqVrj8Ho=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtwYu-1nVNvy0Rky-00uMEq; Mon, 15
 Aug 2022 10:06:42 +0200
Message-ID: <65c8f002-eef7-365a-8f1f-53a4d8b216c4@gmx.com>
Date:   Mon, 15 Aug 2022 16:06:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     "Flint.Wang" <hmsjwzb@zoho.com>
Cc:     linux-btrfs@vger.kernel.org, anand.jain@oracle.com
References: <20220815024341.4677-1-hmsjwzb@zoho.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs-progs: chunk tree search solution for btrfs249
In-Reply-To: <20220815024341.4677-1-hmsjwzb@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vl12y41Ny/rmIVO+eB9o8I83jxIgyICqwaeFxe/GjFUlHWFpFnO
 p/bqdDqgPpRQdlS7Gv277Nnomeohhfd98h+EV1lb4KlQArxyTE51GzuYSDtuEXWqmUoH5QI
 Oms//9XQm6HEuEvG6cM7PPpB4DInQS5XtdoU15QDDJq7tYlrt8pGnOlkvmauLrPhlZS9Q4F
 jFvIUpLveKReOxC/4c7Lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:soC9/gZC5vc=:Ps56/pzZC3iJxFqnNJIihR
 Z/QgtJnw6DfirRtc/8OFZVTeEXt6/IAk22l9W2ofSDYotYQa1ER2pFIM9fUW1/Yu00uUKOG76
 a5Ca1+Sau4JlV367L7miQ9F3AG8z84GoQs26Fj338uvNSgslIw5bwNOvDfZxB6ctLkAdAx29R
 cIuSAtigrtTWUKC4pYvT+VlDYEziv8B5cYADF6AGjHAHCJIIA+QYzWC+Gv1wJC1upjPtum6Og
 9XFx34vDU2zeplv2iTRnidLXf3LOpuXIzc0HoN5uddg0QowJUczGcAd0hsNAwX1piZX7XnO/x
 Gdf2JsZcQJ8XwjFwl/GAU0FRBndaqpbcs7kIo3IauhBsGd/yweuLL0IpTn42CdrTyGFLACA76
 kgRrBvsrB41WFlO0Aap9yVcyEGnubLmyFvuPQAB1mFOE8VflR8Xsfi9qp3c37s+PTaHpRUmKu
 RMxkjeIIONlqo9wKH1Eq3UOVXaD9KM8Sm20TEfKh5Z1Rq+EEh3TD/ZutuSv8SitcQaUjfOfcP
 78/ackMZNT7r7fsog0Qv9fXcq8V/2N2RhxTLeANM19kl+qBWdLUvxTtdCb1hg/fyRvcBTBKbl
 KZkULi256AfCNoqHW6SWjq6QCUM4kUq3M4SrLWlQGgTYdog3CkICD+cW7Sul/a3MBSR4vNmdq
 JQRmBJO3h0Zg5kbfUfSTTtDkvX525gveCp/SoYgZ75cpf4J6OPQW4tTNPzFrnfX3aDCzEMjDG
 LTVSWuhXfzHgoBz1ih3FhfkKodLA7PnAVKv8h54rPIuPCRJgQPMo0sQbDu41eW+BL6ojAztbh
 +ztygutQrdPPIDlmRE6QgE8oFxLoJSzEIfRxFU3Of2psSGWCQSwu1KoHIO0GghDUZ6+JrefYH
 amSAZUToKourLD8nuLybnd6axnqoAKV7Z9x3MRJ0fiH3J1aPZtPXLclqPFkyQHQc5GpIAbExp
 094440FFSre3gNvWKqia3z0O6/FN6zDyPRy1g+IYeNfk4v0Ktc7eHP+6d6MMQ5flPA+i0wUfJ
 dtKB6hJQdUpYBorpxPVywoKMKHTU2tsRPlR4lhZZffnDRzA0QLEXzF+yz9w4Swl26bwrDEcO1
 PhavGhp7KkEp+kgHpKX7w0b+cUv8VDZuaxt9rKjD/vxj/L22sBUQwEV6Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
> Btrfs249 failed due to btrfs_ioctl_fs_info() return RW devices for fi_ar=
gs->num_devices.
> This patch search chunk tree to find rw devices.
The commit message needs some improvement.

Firstly, the commit message should only explain what the problem is and
how this patch is going to solve it.

Currently there are tons of unnecessary things in the commit message,
including the first paragraph and the changelog.

Those things should go after the "---" line, so at apply time those
unnecessary lines will be ignored by git directly.

Secondly the subject can be more specific.

I would go something like the following:

Subject: [PATCH v2] btrfs-progs: search chunk tree to get correct device
info

[BUG]
Test case btrfs/249 failed with the following output:

   <The failure output>

[CAUSE]
Function btrfs_ioctl_fs_info() only returns the number of RW devices for
its num_devices, not including the seed device(s).

Thus above test case will fail as we have two more seed devices,
exceeding the num_device returned by btrfs_ioctl_fs_info().

[FIX]
Fix the bug by doing a tree-search ioctl to grab all devices from chunk
tree, which includes all RW and seed devices.

=2D--
Changelog and other things should go here.
>
> v2 change:
> 1. code style fix.
> 2. noseed_dev =3D> rw_devs, noseed_fsid =3D> fsid.
> 3. remove redundant structure devid_uuid.
> 4. reuse the dev_info structure.
> 5. remove redundant uuid argument.
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
> +	int args2_size =3D 1024;
> +	char args2_buf[args2_size];
> +	int ret =3D 0;
> +	int i =3D 0;
> +	int num =3D 0;
> +	int rw_devs =3D 0;
> +	int idx =3D 0;
> +
> +	args2 =3D (struct btrfs_ioctl_search_args_v2 *) args2_buf;
> +	sk =3D &(args2->key);
> +
> +	sk->tree_id =3D BTRFS_CHUNK_TREE_OBJECTID;
> +	sk->min_objectid =3D BTRFS_DEV_ITEMS_OBJECTID;
> +	sk->max_objectid =3D BTRFS_DEV_ITEMS_OBJECTID;
> +	sk->min_type =3D BTRFS_DEV_ITEM_KEY;
> +	sk->max_type =3D BTRFS_DEV_ITEM_KEY;
> +	sk->min_offset =3D 0;
> +	sk->max_offset =3D (u64)-1;
> +	sk->min_transid =3D 0;
> +	sk->max_transid =3D (u64)-1;
> +	sk->nr_items =3D -1;
> +	args2->buf_size =3D args2_size - sizeof(struct btrfs_ioctl_search_args=
_v2);
> +	ret =3D ioctl(fd, BTRFS_IOC_TREE_SEARCH_V2, args2);
> +	if (ret !=3D 0)
> +	       return -1;

It's better to output an error message and return -errno instead.

-1 is -EINVAL, which is not really helpful to debug what's going wrong.

> +
> +	sh =3D (struct btrfs_ioctl_search_header *) args2->buf;
> +	num =3D sk->nr_items;
> +
> +	dev_item =3D (struct btrfs_dev_item *) (sh + 1);
> +	for (i =3D 0; i < num; i++) {
> +		if (!uuid_compare(dev_item->fsid, fsid)) {
> +			rw_devs +=3D 1;
> +			info[idx++].devid =3D dev_item->devid;
> +		}
> +		if (idx > ndev) {
> +			error("unexpected number of devices: %d >=3D %d", idx, ndev);
> +			return -1;
> +		}
> +		sh =3D (struct btrfs_ioctl_search_header *) dev_item + 1;
> +		dev_item =3D (struct btrfs_dev_item *) sh + 1;
> +	}
> +
> +	if (ndev !=3D rw_devs)
> +		error("unexpected number of devices: %d !=3D %d", ndev, rw_devs);
> +
> +	return 0;
> +}
> +
>   /*
>    *  This function loads the device_info structure and put them in an a=
rray
>    */
> @@ -718,19 +775,17 @@ static int load_device_info(int fd, struct device_=
info **device_info_ptr,
>   		return 1;
>   	}
>
> -	for (i =3D 0, ndevs =3D 0 ; i <=3D fi_args.max_id ; i++) {
> -		if (ndevs >=3D fi_args.num_devices) {
> -			error("unexpected number of devices: %d >=3D %llu", ndevs,
> -				(unsigned long long)fi_args.num_devices);
> -			error(
> -		"if seed device is used, try running this command as root");
> -			goto out;
> -		}
> +	ret =3D load_devid(fd, info, fi_args.num_devices, fi_args.fsid);

This will only load the device info for rw devices.

But no seed device will be populated, wouldn't this cause problem
showing missing seed devices?

Or is this always the case for the command from the very beginning?

Thanks,
Qu

> +	if (ret =3D=3D -1)
> +		goto out;
> +
> +	for (i =3D 0, ndevs =3D 0 ; i < fi_args.num_devices ; i++) {
>   		memset(&dev_info, 0, sizeof(dev_info));
> -		ret =3D get_device_info(fd, i, &dev_info);
> +		ret =3D get_device_info(fd, info[i].devid, &dev_info);
>
> -		if (ret =3D=3D -ENODEV)
> -			continue;
> +		if (ret =3D=3D -ENODEV) {
> +			error("device not found\n");
> +		}
>   		if (ret) {
>   			error("cannot get info about device devid=3D%d", i);
>   			goto out;
> @@ -759,12 +814,6 @@ static int load_device_info(int fd, struct device_i=
nfo **device_info_ptr,
>   		++ndevs;
>   	}
>
> -	if (ndevs !=3D fi_args.num_devices) {
> -		error("unexpected number of devices: %d !=3D %llu", ndevs,
> -				(unsigned long long)fi_args.num_devices);
> -		goto out;
> -	}
> -
>   	qsort(info, fi_args.num_devices,
>   		sizeof(struct device_info), cmp_device_info);
>
