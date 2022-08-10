Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2953858E84C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 09:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiHJH5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 03:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiHJH5T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 03:57:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6FF7171A
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 00:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660118225;
        bh=y6FK87L/55sSzyl64981IkbGI6au+sWVsP3gr30pbAU=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=koExaEoyKBDxGgm8SpOfaQkCkx4s3arb4fCjXPqZ3YHFeE2aOAfIVXr+MIk9M4fe5
         xX/zj6gBzrHj2I0XBubmmoNdDph65PBIa+BGr57jGgUbs643iHXN5Plp1BOHzFIwKZ
         f2krf+rhcsvdCeHlcDaxHazIbOT+HGZ+FpgjtqgE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MeU0k-1nnikO3U0a-00aYX1; Wed, 10
 Aug 2022 09:57:05 +0200
Message-ID: <d410d2f3-497c-d79b-f413-fbacc9211fac@gmx.com>
Date:   Wed, 10 Aug 2022 15:56:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     "Flint.Wang" <hmsjwzb@zoho.com>, anand.jain@oracle.com,
        nborisov@suse.com
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, clm@fb.com
References: <20220810073347.4998-1-hmsjwzb@zoho.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs-progs: Fix seed device bug for btrfs249
In-Reply-To: <20220810073347.4998-1-hmsjwzb@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N7p57C5neIpO4g8NNt5fTUdp3kBwsUwo+7axzieWB0W3Ia4Mc6G
 b8g8VGwqy0EbNvHldzneeI5bri0SybierwnBcHxbhAqJaRRACG0yXNkbCBC0CPEDvRRDmV2
 /S+EvaiR7/z1YdP1pxu1uDsI1d7C/3WtM+6jlX8wYGakWN4vJd9wsZgNBEWjs4QRtM9/BV3
 V7WB0eQ4Lp8Htd+KbHNhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TdxDz1GTtOs=:FZXZvFKRnv7fd+9gAMoP9g
 w5rzcT1meeRhEunkc8/FEgver61NQSykjJc4RSEZEo19IcBYxKcfVt+bgAw0Hjsq6GV+lxFst
 xPddz3kaqYRGUqc+4hNlMR3HnDzCHNwXAOHn/xZPik5PRJnbqoBhBDPfMhybsf0uZj16Dakh7
 0Wb9qPxXyMdd6JMCS27LFibP+EzSdSc/Yr2WFV4otA9Wmtd6v2/6pzCW8emB3irTczY1mfJWg
 Y15CeHeBFwqO+6TUzYx/EVtujQ2dVNwgLkfGfhg1bTJTxCRRxVKILZXIOCM8nnGICgUFEQUud
 eZQNdaT0K1UdaGrr1KItsJtwyWzZbVBrvmiZCdAluYRBtWfApWEnQtqPDn/L8s26k3/rIUHVS
 i6NqixJdRo7DtTdYbGiGGvvy4+nrlx0/QkjEGFLlizLrBuxhRHRM8UZz8kdRHiV8232uA81L9
 c6saeBJxpV+fEPkytZ1JymBqVFI0lY9VAq0bv2WGCDPPW2GGvRPmJx3kNhApqX7aVAE4WgK8g
 3xVG5rfeJdkp+RNd5Iy5u3rGpb/tfdN8BNpxW1C74YuOvvSMKUzhSmwWLXnzcYxn8TkxesrNN
 FoukjQRji4yLhSRZ05Zs81npLov2JQk1ydfehT1xKrotlxk1f1ReV1RbJeBxo6uvmzeJtl6HQ
 Pd+ftS79bcjNimop2ywlzGFA6Q25zPTgXq/awEQZv2xMjjBH1oS2iFGAN5y1+L6SzSRiLwTo9
 UqM8rwljFuMecRCZznSgkhqHVICYFSuaakzr60b4DTyk4bY+aKJU2A/rlRVltWDJCvSF019i0
 8a+0uBoGSYl5yEBg6HDCQMZAf6CM0FV9c5b41aduj6wL+ckfBhgY3TSbFKTcpztJcz8yyp2jC
 8nuCy2v1eaOs7YHRDeCVeNJ5wRuq1mLi9nw/SeaZgAiZXzFSk5j+mwLbmxEyjPubi0TNCIt3j
 Dk9T3H+HI5poOj7clMbS0n9p8eHkm1W2K/D3bSsTwhVtskDEVSY62eAjWZEHyUQSA9y9kRn4u
 GYRBO+342WyfLDKonU2/i9Xx2XcPAGBPO5d1Qg2gp2M8Ji184wWMuWicJrxcA4CyPjA1KnXoq
 IdAUGlsyLGZafV2XQea9lxtJ4KMQ6V/QygMG+w8snPB8DA+jg7k7RZB6A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit message please.

On 2022/8/10 15:33, Flint.Wang wrote:
> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
> ---
>   cmds/device.c           |  2 +-
>   cmds/filesystem-usage.c | 10 +++++-----
>   cmds/filesystem-usage.h |  2 +-
>   common/utils.c          |  9 +++++----
>   common/utils.h          |  2 +-
>   ioctl.h                 |  2 ++
>   6 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/cmds/device.c b/cmds/device.c
> index 7d3febff..81559110 100644
> --- a/cmds/device.c
> +++ b/cmds/device.c
> @@ -752,7 +752,7 @@ static int _cmd_device_usage(int fd, const char *pat=
h, unsigned unit_mode)
>   	int devcount =3D 0;
>
>   	ret =3D load_chunk_and_device_info(fd, &chunkinfo, &chunkcount, &devi=
nfo,
> -			&devcount);
> +			&devcount, false);
>   	if (ret)
>   		goto out;
>
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 01729e18..b2ed3212 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -693,7 +693,7 @@ out:
>    *  This function loads the device_info structure and put them in an a=
rray
>    */
>   static int load_device_info(int fd, struct device_info **device_info_p=
tr,
> -			   int *device_info_count)
> +			   int *device_info_count, bool noseed)
>   {
>   	int ret, i, ndevs;
>   	struct btrfs_ioctl_fs_info_args fi_args;
> @@ -727,7 +727,7 @@ static int load_device_info(int fd, struct device_in=
fo **device_info_ptr,
>   			goto out;
>   		}
>   		memset(&dev_info, 0, sizeof(dev_info));
> -		ret =3D get_device_info(fd, i, &dev_info);
> +		ret =3D get_device_info(fd, i, &dev_info, noseed);
>
>   		if (ret =3D=3D -ENODEV)
>   			continue;
> @@ -779,7 +779,7 @@ out:
>   }
>
>   int load_chunk_and_device_info(int fd, struct chunk_info **chunkinfo,
> -		int *chunkcount, struct device_info **devinfo, int *devcount)
> +		int *chunkcount, struct device_info **devinfo, int *devcount, bool no=
seed)
>   {
>   	int ret;
>
> @@ -791,7 +791,7 @@ int load_chunk_and_device_info(int fd, struct chunk_=
info **chunkinfo,
>   		return ret;
>   	}
>
> -	ret =3D load_device_info(fd, devinfo, devcount);
> +	ret =3D load_device_info(fd, devinfo, devcount, noseed);
>   	if (ret =3D=3D -EPERM) {
>   		warning(
>   		"cannot get filesystem info from ioctl(FS_INFO), run as root");
> @@ -1172,7 +1172,7 @@ static int cmd_filesystem_usage(const struct cmd_s=
truct *cmd,
>   			printf("\n");
>
>   		ret =3D load_chunk_and_device_info(fd, &chunkinfo, &chunkcount,
> -				&devinfo, &devcount);
> +				&devinfo, &devcount, true);
>   		if (ret)
>   			goto cleanup;
>
> diff --git a/cmds/filesystem-usage.h b/cmds/filesystem-usage.h
> index cab38462..6fd04172 100644
> --- a/cmds/filesystem-usage.h
> +++ b/cmds/filesystem-usage.h
> @@ -45,7 +45,7 @@ struct chunk_info {
>   };
>
>   int load_chunk_and_device_info(int fd, struct chunk_info **chunkinfo,
> -		int *chunkcount, struct device_info **devinfo, int *devcount);
> +		int *chunkcount, struct device_info **devinfo, int *devcount, bool no=
seed);
>   void print_device_chunks(struct device_info *devinfo,
>   		struct chunk_info *chunks_info_ptr,
>   		int chunks_info_count, unsigned unit_mode);
> diff --git a/common/utils.c b/common/utils.c
> index 1ed5571f..72d50885 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -285,14 +285,15 @@ void btrfs_format_csum(u16 csum_type, const u8 *da=
ta, char *output)
>   }
>
>   int get_device_info(int fd, u64 devid,
> -		struct btrfs_ioctl_dev_info_args *di_args)
> +		struct btrfs_ioctl_dev_info_args *di_args, bool noseed)
>   {
>   	int ret;
> +	unsigned long req =3D noseed ? BTRFS_IOC_DEV_INFO_NOSEED : BTRFS_IOC_D=
EV_INFO;
>
>   	di_args->devid =3D devid;
>   	memset(&di_args->uuid, '\0', sizeof(di_args->uuid));
>
> -	ret =3D ioctl(fd, BTRFS_IOC_DEV_INFO, di_args);
> +	ret =3D ioctl(fd, req, di_args);
>   	return ret < 0 ? -errno : 0;
>   }
>
> @@ -498,7 +499,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl=
_fs_info_args *fi_args,
>   		 * search_chunk_tree_for_fs_info() will lacks the devid 0
>   		 * so manual probe for it here.
>   		 */
> -		ret =3D get_device_info(fd, 0, &tmp);
> +		ret =3D get_device_info(fd, 0, &tmp, false);

No, I don't think we should go that complex.

The root cause is pretty simple, btrfs_ioctl_fs_info() just return RW
devices for its fi_args->num_devices.

This is fine for most cases, but for seed devices cases, we can not rely
on that.


Knowing that, it's much easier to fix in user space, do a tree-search
ioctl to grab the device items from chunk tree, then we can easily check
the total number of devices (including RW and seed devices).

With that info, we even have the FSID of each devices, then we can call
btrfs_ioctl_dev_info() to get each device.


I'd like to have a better optimization, to skip above chunk tree search,
but I don't have a quick idea on how to determine if a fs has seed devices=
.


Another more elegant solution is to make btrfs_ioctl_fs_info_args to
include one new member, total_devs, so that we can get rid of all the
problems.

But for compatibility reasons, above tree-search based solution is still
needed as a fallback.

Thanks,
Qu

>   		if (!ret) {
>   			fi_args->num_devices++;
>   			ndevs++;
> @@ -521,7 +522,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl=
_fs_info_args *fi_args,
>   		memcpy(di_args, &tmp, sizeof(tmp));
>   	for (; last_devid <=3D fi_args->max_id && ndevs < fi_args->num_device=
s;
>   	     last_devid++) {
> -		ret =3D get_device_info(fd, last_devid, &di_args[ndevs]);
> +		ret =3D get_device_info(fd, last_devid, &di_args[ndevs], false);
>   		if (ret =3D=3D -ENODEV)
>   			continue;
>   		if (ret)
> diff --git a/common/utils.h b/common/utils.h
> index ea05fe5b..de4f93ca 100644
> --- a/common/utils.h
> +++ b/common/utils.h
> @@ -68,7 +68,7 @@ int lookup_path_rootid(int fd, u64 *rootid);
>   int find_mount_fsroot(const char *subvol, const char *subvolid, char *=
*mount);
>   int find_mount_root(const char *path, char **mount_root);
>   int get_device_info(int fd, u64 devid,
> -		struct btrfs_ioctl_dev_info_args *di_args);
> +		struct btrfs_ioctl_dev_info_args *di_args, bool noseed);
>   int get_df(int fd, struct btrfs_ioctl_space_args **sargs_ret);
>
>   const char *subvol_strip_mountpoint(const char *mnt, const char *full_=
path);
> diff --git a/ioctl.h b/ioctl.h
> index 368a87b2..e68fe58d 100644
> --- a/ioctl.h
> +++ b/ioctl.h
> @@ -883,6 +883,8 @@ static inline char *btrfs_err_str(enum btrfs_err_cod=
e err_code)
>   					struct btrfs_ioctl_scrub_args)
>   #define BTRFS_IOC_DEV_INFO _IOWR(BTRFS_IOCTL_MAGIC, 30, \
>   					struct btrfs_ioctl_dev_info_args)
> +#define BTRFS_IOC_DEV_INFO_NOSEED _IOR(BTRFS_IOCTL_MAGIC, 30, \
> +				       struct btrfs_ioctl_dev_info_args)
>   #define BTRFS_IOC_FS_INFO _IOR(BTRFS_IOCTL_MAGIC, 31, \
>                                    struct btrfs_ioctl_fs_info_args)
>   #define BTRFS_IOC_BALANCE_V2 _IOWR(BTRFS_IOCTL_MAGIC, 32, \
