Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68645A0867
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Aug 2022 07:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiHYFUb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Aug 2022 01:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiHYFU3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Aug 2022 01:20:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA559DB72
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 22:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661404825;
        bh=E8QYio2aovRzN6qEbqb0Ax2OBFJs17DXUe5AOzZyUjY=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=ibA8Fd8bSLdns8k4PguEmx/M2cjmDlyeco7nX+AwJ1ZHfIX0yGA81r/snC//l7Z/i
         7s2eOtnxczk1Xyas/8U4g9OGpWg8Q4DA5ARLoVZidv5eAnAteCSIev9AHjAJZjcHBG
         sTxgknYqItTClHzTWGIP/30GSHupTOLD/3k0iEOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmDEg-1p9FkG1AAK-00i96n; Thu, 25
 Aug 2022 07:20:24 +0200
Message-ID: <c3dc352c-8393-c564-4366-42fb9ece021e@gmx.com>
Date:   Thu, 25 Aug 2022 13:20:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1661357103-22735-1-git-send-email-zhanglikernel@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
In-Reply-To: <1661357103-22735-1-git-send-email-zhanglikernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vsP4mZ4hbbhXG/E3HRh7KMTCPhS0zdXCgblZyVAzr4L4TpB4M6z
 8oLp1Pu+E9yS4YLC5G+0D/lkgIO9pGuLhVZJ99yLD0SIG9+WcgjGjYeFo9+Tzvz3mmXz/J4
 ZVkvv/RTm/Q4VcX4NYbL8TGC7erY7u+3vnAP/2p4MULxgqTj0P5Mjs9ixepxGSxc3hcaUMA
 NP0tvVtEn2AqXrE4vjXMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Le3licDkjRE=:vvtuyz1K5v0Vk/YnpBmHTn
 wUynbsJ8SeipvGROmpXkJaO1z65t2/CndFdgVJ3Y4ZaC4GWfClEEn/IGS/kYbtOcXu4PaBqw+
 cADZ2SDYCOPylb4IXh5eM2kgTDo/c6pd+QAa6d7q6pzVnat4UAYM9izwMnNow1f0e+zV7ailA
 qJnEGFkDG7cmOQBO5Epx4fZJ5fTdZ7agDLUO9P41U5vagn45Wzzf47Pk300x3IDz6c7oZAtFo
 0UxM816f2C52KoySU7rhLOZjrRduUeiX/FFv+2IjM9PQ5JEsHdpny1JEIyOK+AwcHm6X+5OwV
 j/J1BK7tNiapW7pUuvXd2QwOigqF7bP63cB9vRMtbHVC3AxHLfqmNoUJMP1Bp+9NK4eW3n8WO
 A+Z70rfZ6i8bCTs+L1PqcfwH6kID+5HnxpX/WF97La0jHisd3cHoq4D9F2VHUi08hbgqMT7Cy
 8eo8z9vJFtbpix32jOMAWrOGJH095tze+0h+tp1njkYklU1r8zybVxi3CaAnzevTGfujfepSa
 mauddDv73Uq6ihQLv6D3wAASpAgAyGKBRIKD1rYLUsQBMTkN7CT0nwFN3mOMFXMNP7/AATBo/
 jZwoR/8S7cKo+iqF3UriyNz8p+kRDQBVFvREZ2MU+tPTmq8X6LrG68wUIUZ9ZoNESFwWA12q2
 JbRl1+RrBSJ7hcSyt9cjtcXJk0Rf2cgmcrpF4HR0lTp8P+4F9cFcOsTY7gw/RxHdoCb4UpCxH
 dWOcOXja5iL7MkpP53wY2qp2ov5o3rVWy03VWG0oNHZWE6XOlLjtkQhJFyKfnvahcGsZ+DO6g
 2NiPE3Vkwk5Sk8PU2RmGsCjRECTPxiVVIraqj9RHiULs4bIRyem2mxoYb6mMLGV0ehA111+R+
 5f/SK6k9j+u4n2UVCJL5nrXy6hUUsMxdhQ+6ubsniyAQbERZkwU2RWvIqYm843BM6deCpw0KA
 oM0TCMYUj3wBog4JaSfgwMkwFYNjd+MF5Wcde4fafL65CzaEwhZ5vJK5pwDRy/g/eIzn6zxrx
 pdymXXJJlJWT0J/pCMq/Kgfd1i6pE6F5RrRebPea94yrtNp4BiCfYkQVd1dvUQ/UkMq58dkLP
 HdwwKZc06yBea4Hq7Z7NsOikoYjhjy4r6a2fi98y5y/SmvBVUP+aR+lbg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/25 00:05, Li Zhang wrote:
> [enhancement]
> When a disk is formatted as btrfs, it calls
> btrfs_prepare_device for each device, which takes too much time.

The idea is awesome.

>
> [implementation]
> Put each btrfs_prepare_device into a thread,
> wait for the first thread to complete to mkfs.btrfs,
> and wait for other threads to complete before adding
> other devices to the file system.
>
> [test]
> Using the btrfs-progs test case mkfs-tests, mkfs.btrfs works fine.
>
> But I don't have an actual zoed device,
> so I don't know how much time it saves, If you guys
> have a way to test it, please let me know.
>
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
> Issue: 496
>
>   mkfs/main.c | 113 +++++++++++++++++++++++++++++++++++++++++++++-------=
--------
>   1 file changed, 86 insertions(+), 27 deletions(-)
>
> diff --git a/mkfs/main.c b/mkfs/main.c
> index ce096d3..35fefe2 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -31,6 +31,7 @@
>   #include <uuid/uuid.h>
>   #include <ctype.h>
>   #include <blkid/blkid.h>
> +#include <pthread.h>
>   #include "kernel-shared/ctree.h"
>   #include "kernel-shared/disk-io.h"
>   #include "kernel-shared/free-space-tree.h"
> @@ -60,6 +61,18 @@ struct mkfs_allocation {
>   	u64 system;
>   };
>
> +
> +struct prepare_device_progress {
> +	char *file;
> +	u64 dev_block_count;
> +	u64 block_count;

> +	bool zero_end;
> +	bool discard;
> +	bool zoned;
> +	int oflags;

A small nitpick.

Aren't those 4 values the same shared by all devices?
Thus I'm not sure if they need to be put into prepare_device_progress at
all.

IIRC, we may want some shared memory between all the threads:

- A pthread_mutex
   Will be explained later

- All the other shared infos like above flags/oflags

It can be global or passed by some pointers.

> +	int ret;
> +};
> +
>   static int create_metadata_block_groups(struct btrfs_root *root, bool =
mixed,
>   				struct mkfs_allocation *allocation)
>   {
> @@ -969,6 +982,28 @@ fail:
>   	return ret;
>   }
>
> +static void *prepare_one_dev(void *ctx)
> +{
> +	struct prepare_device_progress *prepare_ctx =3D ctx;
> +	int fd;
> +
> +	fd =3D open(prepare_ctx->file, prepare_ctx->oflags);
> +	if (fd < 0) {
> +		error("unable to open %s: %m", prepare_ctx->file);

If we have no permission for all devices (pretty common in fact, e.g.
forgot to use sudo), we will have multiple threads printing out the same
time.

Without a lock, the output will be a mess.

Thus we may want a mutex, even it's just for synchronizing the output.

> +		prepare_ctx->ret =3D fd;
> +		return NULL;
> +	}
> +	prepare_ctx->ret =3D btrfs_prepare_device(fd,
> +		prepare_ctx->file, &prepare_ctx->dev_block_count,
> +		prepare_ctx->block_count,
> +		(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> +		(prepare_ctx->zero_end ? PREP_DEVICE_ZERO_END : 0) |
> +		(prepare_ctx->discard ? PREP_DEVICE_DISCARD : 0) |
> +		(prepare_ctx->zoned ? PREP_DEVICE_ZONED : 0));
> +	close(fd);
> +	return NULL;
> +}
> +
>   int BOX_MAIN(mkfs)(int argc, char **argv)
>   {
>   	char *file;
> @@ -997,7 +1032,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	bool ssd =3D false;
>   	bool zoned =3D false;
>   	bool force_overwrite =3D false;
> -	int oflags;
>   	char *source_dir =3D NULL;
>   	bool source_dir_set =3D false;
>   	bool shrink_rootdir =3D false;
> @@ -1006,6 +1040,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	u64 shrink_size;
>   	int dev_cnt =3D 0;
>   	int saved_optind;
> +	pthread_t *t_prepare =3D NULL;
> +	struct prepare_device_progress *prepare_ctx =3D NULL;
>   	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] =3D { 0 };
>   	u64 features =3D BTRFS_MKFS_DEFAULT_FEATURES;
>   	u64 runtime_features =3D BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
> @@ -1428,29 +1464,45 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		goto error;
>   	}
>
> -	dev_cnt--;
> -
> -	oflags =3D O_RDWR;
> -	if (zoned && zoned_model(file) =3D=3D ZONED_HOST_MANAGED)
> -		oflags |=3D O_DIRECT;
> +	t_prepare =3D malloc(dev_cnt * sizeof(*t_prepare));
> +	prepare_ctx =3D malloc(dev_cnt * sizeof(*prepare_ctx));
>
> -	/*
> -	 * Open without O_EXCL so that the problem should not occur by the
> -	 * following operation in kernel:
> -	 * (btrfs_register_one_device() fails if O_EXCL is on)
> -	 */
> -	fd =3D open(file, oflags);
> -	if (fd < 0) {
> -		error("unable to open %s: %m", file);
> +	if (!t_prepare || !prepare_ctx) {
> +		error("unable to prepare dev");

Isn't this ENOMEM? The message doesn't seem to match the situation.

>   		goto error;
>   	}
> -	ret =3D btrfs_prepare_device(fd, file, &dev_block_count, block_count,
> -			(zero_end ? PREP_DEVICE_ZERO_END : 0) |
> -			(discard ? PREP_DEVICE_DISCARD : 0) |
> -			(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> -			(zoned ? PREP_DEVICE_ZONED : 0));
> +
> +	for (i =3D 0; i < dev_cnt; i++) {
> +		prepare_ctx[i].file =3D argv[optind + i - 1];
> +		prepare_ctx[i].block_count =3D block_count;
> +		prepare_ctx[i].dev_block_count =3D block_count;
> +		prepare_ctx[i].zero_end =3D zero_end;
> +		prepare_ctx[i].discard =3D discard;
> +		prepare_ctx[i].zoned =3D zoned;
> +		if (i =3D=3D 0) {
> +			prepare_ctx[i].oflags =3D O_RDWR;
> +			/*
> +			 * Open without O_EXCL so that the problem should
> +			 * not occur by the following operation in kernel:
> +			 * (btrfs_register_one_device() fails if O_EXCL is on)
> +			 */

The comment seems out-dated, no O_EXCL involved anywhere.

> +			if (zoned && zoned_model(file) =3D=3D ZONED_HOST_MANAGED)
> +				prepare_ctx[i].oflags =3D O_RDWR | O_DIRECT;

Do we need to treat the initial and other devices differently?

Can't we use the same flags for all devices?


> +		} else {
> +			prepare_ctx[i].oflags =3D O_RDWR;
> +		}
> +		ret =3D pthread_create(&t_prepare[i], NULL,
> +			prepare_one_dev, &prepare_ctx[i]);
> +	}
> +	pthread_join(t_prepare[0], NULL);
> +	ret =3D prepare_ctx[0].ret; > +

Can't we just wait for all devices?

I don't think treating them different could have much benefit.

Yes, we can have multiple-devices with different performance
characteristics, thus if the first device is the fastest one, it may
finish before all the others.

But this also means, the first one can be the slowest.

To me, parallel initialization is already a big enough improvement, and
for the most common case, all the devices should have the same or
similar performance characteristics, thus waiting for them all shouldn't
cause much difference.

>   	if (ret)
>   		goto error;
> +
> +	dev_cnt--;
> +	fd =3D open(file, prepare_ctx[0].oflags);
> +	dev_block_count =3D prepare_ctx[0].dev_block_count;
>   	if (block_count && block_count > dev_block_count) {
>   		error("%s is smaller than requested size, expected %llu, found %llu"=
,
>   		      file, (unsigned long long)block_count,
> @@ -1459,7 +1511,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	}
>
>   	/* To create the first block group and chunk 0 in make_btrfs */
> -	system_group_size =3D zoned ?  zone_size(file) : BTRFS_MKFS_SYSTEM_GRO=
UP_SIZE;
> +	system_group_size =3D zoned ? zone_size(file) : BTRFS_MKFS_SYSTEM_GROU=
P_SIZE;
>   	if (dev_block_count < system_group_size) {
>   		error("device is too small to make filesystem, must be at least %llu=
",
>   				(unsigned long long)system_group_size);
> @@ -1557,6 +1609,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	if (dev_cnt =3D=3D 0)
>   		goto raid_groups;
>
> +	for (i =3D 0 ; i < dev_cnt; i++) {
> +		pthread_join(t_prepare[i+1], NULL);
> +		if (prepare_ctx[i+1].ret) {
> +			goto error;
> +		}
> +	}
>   	while (dev_cnt-- > 0) {
>   		file =3D argv[optind++];
>
> @@ -1578,12 +1636,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   			close(fd);
>   			continue;
>   		}
> -		ret =3D btrfs_prepare_device(fd, file, &dev_block_count,
> -				block_count,
> -				(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> -				(zero_end ? PREP_DEVICE_ZERO_END : 0) |
> -				(discard ? PREP_DEVICE_DISCARD : 0) |
> -				(zoned ? PREP_DEVICE_ZONED : 0));
> +		dev_block_count =3D prepare_ctx[argc - saved_optind - dev_cnt - 1]
> +			.dev_block_count;
> +
>   		if (ret) {
>   			goto error;
>   		}

This goto error is a dead code now.

Thanks for the great idea on reducing the preparation time!
Qu

> @@ -1763,12 +1818,16 @@ out:
>
>   	btrfs_close_all_devices();
>   	free(label);
> -
> +	free(t_prepare);
> +	free(prepare_ctx);
>   	return !!ret;
> +
>   error:
>   	if (fd > 0)
>   		close(fd);
>
> +	free(t_prepare);
> +	free(prepare_ctx);
>   	free(label);
>   	exit(1);
>   success:
