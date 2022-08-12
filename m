Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CB7590D0D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 09:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbiHLH51 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 03:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiHLH5Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 03:57:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D2A9C227
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660291031;
        bh=kX8U9x5B3kcdhgc75xx0E/a0MnSF/k2FNA7dIL227wg=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=I3nh2I+J8M0YK4U/4qHiJRdANkgwPbE3iQopj+EQo6CVfE0Mr5FcyQu+fjGx17YNS
         oSTrt5/5xXaRcNe2IZ+z4+Pn7KOwPy0INP0LQuUXR6iHInoSyB+d9edxnOiLu3/6gH
         YC8BfHMsFqrgXy+3KVh0mhqJm3iJ4dM0K5GD4XX8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3DM-1oBTJu0T7I-00FS3G; Fri, 12
 Aug 2022 09:57:10 +0200
Message-ID: <86230e46-efcf-b30b-c2ab-566608690f5d@gmx.com>
Date:   Fri, 12 Aug 2022 15:57:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     "Flint.Wang" <hmsjwzb@zoho.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        anand.jain@oracle.com, clm@fb.com, strongbox8@zoho.com
References: <20220812072635.10979-1-hmsjwzb@zoho.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v1] btrfs-progs: chunk tree search solution for btrfs249
In-Reply-To: <20220812072635.10979-1-hmsjwzb@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P8VZWwZhyUnpLhaZNf3s4S7Jmum/uTRJZRyejZ/gaeZRfnmzFxf
 seQ2Q0MN7GFh4eNXcV4g6MU6OZTdTTEO6V8G33qqcL4Pp4izhBj21FoDVBZZOdzRjuVKYuc
 yy3PVjQNQQlKt4M2EywKJUCpplEiOTqwjnwwiw6uTxmDdvaMa74LVgffcnPALSNEgsPgAru
 1ze8mTR9joleJgaCiTVVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4brfyDnsuB8=:d+sKTmjcjb2FcMUrsSmA31
 qE0V342Y1j2GVrXsI+XEX1w1QWVA3YJxS+qzTalW9Ak+keU8cZ1mIyvxXTyFBPKixUZvniIi+
 Yyn3cvHmlALAtGPvnIKSmF/mmGC2BAFz4NAUrICo4DI4JfBn01jeniTjZZXZgd8xMlOHT2358
 ZEXIU0iGRfjM+ThcqEZcgFqj85+loD1w3gCqHI8Oi7OjF7v5eROZC3qSbJ04+WzKyzBp0BfU4
 G5feyP5NFhLhJFddjW8+xC87qqcZ4waAXZ4Ei9ft37mbrIAuwYbMXur/XGN/uZGtIaLg7IjeE
 +005M13tWlYzrH/I5wA/7WKYvC4rJG1Rs85e/+vcCul5+l9Cb6DAC+XXtgRuhpPjXoaxkamKy
 +BwIMcrhvNmjiksV89zCBA8qM6UozXEqAmGCld/AS9gHdysIdP1dHoL9UcHWVlMKnEsOo8/I7
 rxE2ICX6C+L8NURERdmybnskDtx4LGmDeWRL50ddZIHni/4x9EXZFmBZf8QgUODhC1jxqksfP
 c1QnJri2D8Uq7pFU7Fds8dEE8eAIUJunP22Qj7F5yzor1gvXyeM74sDoH5w25wTo0KIwNLLGI
 9hSDaw1UD9hGKHFyIartt1BJg6xbVCwEI8xpXbH6oDJnhqTaoVg1yxI+2C5pkSod1SAqPlLGz
 Piyi7EPQ3VWLX5AftLqsA4FYtXQ8hPnBAlYKajtv6sSYoke8OVKe+0wvcEZbgf6+AP7V0Gc82
 BPpTO3+utfIbz/NL2f8udMatTlWUq7GdLaHw1ggwJqJXQEH2wWyISJGD4TPK0DKcIZMj1OBd1
 sZr4VqMyXmx/coVFvyTrHCUOZLhVSI70oa+53gjtjLstyWhqFa0C6vZ5U4+bwy+PuAiBlZb10
 3LLDDLR9y4FKs1JVlS1wmjrXg4MXwB4neavqiPFfiFWwGINM1hooQbCuBZaYJKiPFNXW3WK7C
 En9vxhcnefB/HmZbiSPaksoY4pfXaxD3KBJeWVoEv9CtDN8XXZF9+rjE2JMnrOfKzLrqTtOAm
 QgNNHflLVEEDcPAyzuwreVH3lpAB6RetSDXLMGQi40zVA81luMl3kAgLwlgv/g0LzwWm7L1UM
 l9jfuZkbRzBvpUR4+dF+DPxSJtfky0BXM1EXqjJ9RibV4/bxmIN2sh3Sw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/12 15:26, Flint.Wang wrote:
> Hi Qu,
> Thanks for your proposal. I have implemented the first edition of chunk
> tree search solution.
> But it seems chunk tree search solution need root privilege.

Yes, and that's expected.

For a more elegant and less confusing solution, we either need to expand
the fs_info ioctl to return extra member indicating all devices, or go
sysfs to find out all devices.

Either solution needs certain kernel version, thus the tree search ioctl
based is needed as a fallback anyway.

>
> Btrfs249 failed due to btrfs_ioctl_fs_info() return RW devices for
> fi_args->num_devices. This patch search chunk tree to find no seed devic=
e.

I didn't understand the "to find no seed device" line.

Did you mean "to find any seed device" ?

>
> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
> ---
>   cmds/filesystem-usage.c | 89 +++++++++++++++++++++++++++++++++--------
>   cmds/filesystem-usage.h |  5 +++
>   common/utils.c          | 11 +++--
>   common/utils.h          |  2 +-
>   4 files changed, 85 insertions(+), 22 deletions(-)
>
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 01729e18..ef022ae4 100644
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
> @@ -689,6 +690,59 @@ out:
>   	return ret;
>   }
>
> +static int load_devid_uuid(int fd, struct devid_uuid *pair,
> +			    int ndev, u8 *noseed_fsid)
> +{
> +	struct btrfs_ioctl_search_args_v2 *args2;
> +	struct btrfs_ioctl_search_key *sk;
> +	struct btrfs_ioctl_search_header *sh;
> +	struct btrfs_dev_item *dev_item;
> +	int args2_size =3D 1024;
> +	char args2_buf[args2_size];
> +	int ret, i, num, noseed_dev =3D 0, pidx =3D 0;

This doesn't look like the common style we go.

Normally we go one variable per line.


Another thing is, noseed_* related naming, can we just rename
@noseed_dev to @rw_devs, and @noseed_fsid to @fsid?

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
> +
> +	sh =3D (struct btrfs_ioctl_search_header *) args2->buf;
> +	num =3D sk->nr_items;
> +
> +	dev_item =3D (struct btrfs_dev_item *) (sh + 1);
> +	for (i =3D 0; i < num; i++) {
> +		if (!uuid_compare(dev_item->fsid, noseed_fsid)) {
> +			noseed_dev +=3D 1;
> +			pair[pidx].devid =3D dev_item->devid;

I don't think we need to bother a new struct devid_uuid, can't we just
reuse device_info structure?

Personally speaking, we can completely fill the device_info array inside
the function, we have total size, used bytes, devid, the only thing we
need from the dev_info ioctl is the path.

Which can be later handled by that for () loop inside load_device_info().

Thus to me, we can do the device_info_ptr allocation (and later
enlarge), fill devid/device_size/size members.
Then re-use the for loop just to grab the path.

> +			memcpy(&pair[pidx++].uuid, dev_item->uuid, BTRFS_UUID_SIZE);
> +		}
> +		if (pidx > ndev) {
> +			error("unexpected number of devices: %d >=3D %d", pidx, ndev);
> +			return -1;
> +		}
> +		sh =3D (struct btrfs_ioctl_search_header *) dev_item + 1;
> +		dev_item =3D (struct btrfs_dev_item *) sh + 1;
> +	}
> +
> +	if (ndev !=3D noseed_dev)
> +		error("unexpected number of devices: %d !=3D %d", ndev, noseed_dev);
> +
> +	return 0;
> +}
> +
>   /*
>    *  This function loads the device_info structure and put them in an a=
rray
>    */
> @@ -699,6 +753,7 @@ static int load_device_info(int fd, struct device_in=
fo **device_info_ptr,
>   	struct btrfs_ioctl_fs_info_args fi_args;
>   	struct btrfs_ioctl_dev_info_args dev_info;
>   	struct device_info *info;
> +	struct devid_uuid *pair;
>   	u8 fsid[BTRFS_UUID_SIZE];
>
>   	*device_info_count =3D 0;
> @@ -718,19 +773,23 @@ static int load_device_info(int fd, struct device_=
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
> +	pair =3D malloc(sizeof(struct devid_uuid) * fi_args.num_devices);
> +	if (!pair) {
> +		error("not enough memory");
> +		return 1;
> +	}
> +
> +	ret =3D load_devid_uuid(fd, pair, fi_args.num_devices, fi_args.fsid);
> +	if (ret =3D=3D -1)
> +		goto out;
> +
> +	for (i =3D 0, ndevs =3D 0 ; i < fi_args.num_devices ; i++) {
>   		memset(&dev_info, 0, sizeof(dev_info));
> -		ret =3D get_device_info(fd, i, &dev_info);
> +		ret =3D get_device_info(fd, pair[i].devid, pair[i].uuid, &dev_info);
>
> -		if (ret =3D=3D -ENODEV)
> -			continue;
> +		if (ret =3D=3D -ENODEV) {
> +			error("device not found\n");
> +		}
>   		if (ret) {
>   			error("cannot get info about device devid=3D%d", i);
>   			goto out;
> @@ -759,21 +818,17 @@ static int load_device_info(int fd, struct device_=
info **device_info_ptr,
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
>   	*device_info_count =3D fi_args.num_devices;
>   	*device_info_ptr =3D info;
> +	free(pair);
>
>   	return 0;
>
>   out:
> +	free(pair);
>   	free(info);
>   	return ret;
>   }
> diff --git a/cmds/filesystem-usage.h b/cmds/filesystem-usage.h
> index cab38462..f78b2f2e 100644
> --- a/cmds/filesystem-usage.h
> +++ b/cmds/filesystem-usage.h
> @@ -44,6 +44,11 @@ struct chunk_info {
>   	u64	num_stripes;
>   };
>
> +struct devid_uuid {
> +	__le64 devid;
> +	u8 uuid[BTRFS_UUID_SIZE];
> +};
> +
>   int load_chunk_and_device_info(int fd, struct chunk_info **chunkinfo,
>   		int *chunkcount, struct device_info **devinfo, int *devcount);
>   void print_device_chunks(struct device_info *devinfo,
> diff --git a/common/utils.c b/common/utils.c
> index 1ed5571f..d09177ef 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -284,13 +284,16 @@ void btrfs_format_csum(u16 csum_type, const u8 *da=
ta, char *output)
>   	}
>   }
>
> -int get_device_info(int fd, u64 devid,
> +int get_device_info(int fd, u64 devid, u8 *uuid,
>   		struct btrfs_ioctl_dev_info_args *di_args)
>   {
>   	int ret;
>
>   	di_args->devid =3D devid;
> -	memset(&di_args->uuid, '\0', sizeof(di_args->uuid));
> +	if (!uuid)
> +		memset(&di_args->uuid, '\0', sizeof(di_args->uuid));
> +	else
> +		memcpy(&di_args->uuid, uuid, sizeof(di_args->uuid));

Any reason we need this new @uuid argument?

I know it's to make btrfs_ioctl_dev_info() to have the correct uuid to
do the search, but shouldn't the devid is enough to locate the seed device=
?

IIRC btrfs shouldn't have conflicting devid, even for seed devices.

Thus I doubt if we need the new @uuid arugment at all.

Thanks,
Qu

>
>   	ret =3D ioctl(fd, BTRFS_IOC_DEV_INFO, di_args);
>   	return ret < 0 ? -errno : 0;
> @@ -498,7 +501,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl=
_fs_info_args *fi_args,
>   		 * search_chunk_tree_for_fs_info() will lacks the devid 0
>   		 * so manual probe for it here.
>   		 */
> -		ret =3D get_device_info(fd, 0, &tmp);
> +		ret =3D get_device_info(fd, 0, NULL, &tmp);
>   		if (!ret) {
>   			fi_args->num_devices++;
>   			ndevs++;
> @@ -521,7 +524,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl=
_fs_info_args *fi_args,
>   		memcpy(di_args, &tmp, sizeof(tmp));
>   	for (; last_devid <=3D fi_args->max_id && ndevs < fi_args->num_device=
s;
>   	     last_devid++) {
> -		ret =3D get_device_info(fd, last_devid, &di_args[ndevs]);
> +		ret =3D get_device_info(fd, last_devid, NULL, &di_args[ndevs]);
>   		if (ret =3D=3D -ENODEV)
>   			continue;
>   		if (ret)
> diff --git a/common/utils.h b/common/utils.h
> index ea05fe5b..f1bbd807 100644
> --- a/common/utils.h
> +++ b/common/utils.h
> @@ -67,7 +67,7 @@ int ask_user(const char *question);
>   int lookup_path_rootid(int fd, u64 *rootid);
>   int find_mount_fsroot(const char *subvol, const char *subvolid, char *=
*mount);
>   int find_mount_root(const char *path, char **mount_root);
> -int get_device_info(int fd, u64 devid,
> +int get_device_info(int fd, u64 devid, u8 *uuid,
>   		struct btrfs_ioctl_dev_info_args *di_args);
>   int get_df(int fd, struct btrfs_ioctl_space_args **sargs_ret);
>
