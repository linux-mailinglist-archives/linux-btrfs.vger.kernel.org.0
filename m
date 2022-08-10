Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191BE58E7DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 09:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiHJH1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 03:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiHJH0y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 03:26:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E446554E;
        Wed, 10 Aug 2022 00:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660116400;
        bh=TsAaZ6+236c6BGUjMDaDhdnHKlAtqbtIbHlEJd11Wsw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KdChqPpA5xt7D6OmXYuhtVfNfuSOB2h9xBFSmsMIkvA/VTSLdp6lSFyUWEgSs1agp
         UX8QfuNNETQdpVpfgMlrVYe9NJQz13Hg7PmTVFtQGxX2LWwNtgZugF7ihgyxTToCqv
         HCaA3rELRcv+pVNIwUnaSXrnboxqt9eBuuMdhRV0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMXUN-1o4HaC1Oat-00JbXf; Wed, 10
 Aug 2022 09:26:40 +0200
Message-ID: <2eb7e3e4-1efb-3489-f2e0-c5f4357ceb3e@gmx.com>
Date:   Wed, 10 Aug 2022 15:26:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs: Fix btrfs_find_device for btrfs/249
Content-Language: en-US
To:     "Flint.Wang" <hmsjwzb@zoho.com>
Cc:     anand.jain@oracle.com, nborisov@suse.com, strongbox8@zoho.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220810072021.4539-1-hmsjwzb@zoho.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220810072021.4539-1-hmsjwzb@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6gMWKzmazFA7lo+jx9wIaOIu9EPJKQStlWsjwVMO6XF3G/2IiLn
 PRdYK9NgQh2bGA9tWBxsMaWF5XaDMPFTwEYzk8pFN1uNYaV7RpiHg7FQ7QNFw9/YRXThB7Q
 /MrCHqtH+Pat5M5sLeC/OEhffRBE+GHbjILAIvYUm/8BSlOhvC/xV7I7WTsO3fkraMUC5GV
 UiXUwe9iISaZEnoyqBDSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5tbZU9LNyy8=:fMU6u7vBlaYtuJjvb1Lm2S
 J/XM7l7hWFhctOOE5g5CFvrTHDjVIvWGsxHIwmdNTalWvjCwAr8d2wRiYaWCAmyWcaVb58t2G
 T9FLXwo7IHq1Are4neRqra7yGXFe2Q7Vfc1U89tTvwebkStV2GWF50feRj8oBvpjeT7qhYzyI
 ovTGbV4yIdVDNjYb3fLaAfHttrd8z11lko1iwqk9bQQxY4B4c/wgU3V+2TMGP7mgrfXmdK13E
 cu/5QXnUCWIANsHGmIivXd9kqXfeonHV8hWNobGkaIrYl0DiJ2cvJ0uUMtlGlfCRv1+0/Juxm
 p/KIZvt7zitM2Jb8KccWLaKdKGRg2/BH0lPA6ozdp61T/DR/xiLwl8S2Q75t1cSoSiFRZgLV4
 gNmm41lwuzzXtLrwgUpbPtU3OItpua6s1bXQTcZ28NN8jm06/cDTXXSssuDbIUj46jPIlEMPg
 jf9QEawGeh3gvNcZttmzdTWi9+jZpS2oXYQnK3iTW+HYOzF5f1WIkRX5NKDldg5azizwQjOfp
 ZBIwC6XhqaRIDcr9eerm0ATZxCqRtm0Wdvp+2/OiLXzh5pXtwncFHgMcA+K11o6FAfojTGCl1
 s0IMFXoduSekCNDWSnl6H33fIT/2KlpNPSPf67uS0mdimjHGBoDzmXqu/Ji0PERk1MvpC1pmy
 z6Q31EpQPEPbtiXUOxuVaC7rWOlqbIWF88DG8MElgCavjNqDTrx4XCHcxcvf202Q27AugtZah
 2eMcmsByR0kgonDOghtlFVKPzudGxe4QDvt9fu/tQ99OicCg4dV6vZx5rlCjiMMEJiZCHCUk4
 B4DZcLOMNTTdMAK78j+kbL7JEaG03tDjXowq2Hhn840IZPd8z0rGeq+c1yzaaDy5uhrA1rgpb
 32wo3DdEXlRKCewEvM9K9TslRQbZ0JxsByKg5e71x00b4F89vMjsR/w/yoIVh7Amv7w+Vx9LJ
 d+FvCQrQ6oqFhHwlYkospgGHlrIp8JkZW+/YA0Lam/LBM0IBuJDO1XygAxUiMxEKdxzPP4vFD
 P8hbeD4i2fb7LVXEx/rh7wPtsOvMISheaosCeNHnvxzI8LQVwt2fV0oYECiqGfUAdeAhWMjUW
 ivITII85tjCLebdxsXYSaR2FM4WHCHUy9Ln5rnkKrgDyBKA5bmHC5nQwmJq3UAtazG8tCAdPm
 DeMVdZXcb9HvI5Xo/KLI8Y9yLhP3uiffZ2HoEeeeryAbGHCAQh72OH2UDq7jcJr1BhojC1iZj
 NcBMVgEOvNwfJ5CjWTHwwwHIqp4GJUe1cK+aNp4weHwY8IygW8OGuC/CyGaV5624wM4znW12h
 IYcWA65C09XqvNqO67psGGC59C9pIA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/10 15:20, Flint.Wang wrote:
> testcase btrfs249 failed.
> [How to reproduce]
> mkfs.btrfs -f -d raid1 -m raid1 /dev/sdb /dev/sdc
> btrfstune -S 1 /dev/sdb

IIRC I have submitted a patch to reject seed creation on multiple devices:
https://www.spinics.net/lists/linux-btrfs/msg123545.html

I think this would be a much simpler solution, if we just don't support
that use-case at all.

Thanks,
Qu

> wipefs -a /dev/sdb
> mount -o degraded /dev/sdc /mnt/scratch
> btrfs device add -f /dev/sdd /mnt/scratch
> btrfs filesystem usage /mnt/scratch
>
> [Root cause]
> mkfs.btrfs -f -d raid1 -m raid1 /dev/sdb /dev/sdc
> btrfstune -S 1 /dev/sdb
> wipefs -a /dev/sdb
> mount -o degraded /dev/sdc /mnt/scratch
>
> In the above commands, btrfstune command set the sdb and sdc to seeding =
device.
> After that you wipe the filesystem on sdb. After mount, you will find th=
e status of sdb is missing.
>
> btrfs device add -f /dev/sdd /mnt/scratch:
> This command will invoke btrfs_setup_sprout to do the job.
> It put the devices on fs_devices->devices to seed_devices list.
> So only sdd is on the fs_devices->devices list. sdb(missing), sdc on the=
 seed_devices list.
> But when we look into the btrfs_find_devices function, it find devices b=
oth in devices list and seed_devices list.
>
> btrfs filesystem usage /mnt/scratch
> This command use ioctl to get device info. The assertion is triggered be=
cause it finds the number of devices is inconsistent.
>
> [My fix solution]
> 1. Add noseed argument to btrfs_find_device. It force the function only =
look into devices list.
> 2. Add a new ioctl request(BTRFS_IOC_DEV_INFO_NOSEED) in case some appli=
cation may depend the original ioctl behavior on BTRFS_IOC_DEV_INFO
> 3. Modify load_device_info and load_chunk_and_device_info in btrfs-prog =
for appropriate ioctl call.
>
> After the change, btrfs249 passed.
>
> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
> ---
>   fs/btrfs/dev-replace.c     |  8 ++++----
>   fs/btrfs/ioctl.c           | 10 ++++++----
>   fs/btrfs/scrub.c           |  4 ++--
>   fs/btrfs/volumes.c         | 22 ++++++++++++----------
>   fs/btrfs/volumes.h         |  5 ++++-
>   include/uapi/linux/btrfs.h |  2 ++
>   6 files changed, 30 insertions(+), 21 deletions(-)
>
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index f43196a893ca3..49d3c587c2948 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -101,7 +101,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_=
info)
>   		 * We don't have a replace item or it's corrupted.  If there is
>   		 * a replace target, fail the mount.
>   		 */
> -		if (btrfs_find_device(fs_info->fs_devices, &args)) {
> +		if (btrfs_find_device(fs_info->fs_devices, &args, false)) {
>   			btrfs_err(fs_info,
>   			"found replace target device without a valid replace item");
>   			ret =3D -EUCLEAN;
> @@ -163,7 +163,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_=
info)
>   		 * We don't have an active replace item but if there is a
>   		 * replace target, fail the mount.
>   		 */
> -		if (btrfs_find_device(fs_info->fs_devices, &args)) {
> +		if (btrfs_find_device(fs_info->fs_devices, &args, false)) {
>   			btrfs_err(fs_info,
>   			"replace devid present without an active replace item");
>   			ret =3D -EUCLEAN;
> @@ -174,9 +174,9 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_=
info)
>   		break;
>   	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
>   	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
> -		dev_replace->tgtdev =3D btrfs_find_device(fs_info->fs_devices, &args)=
;
> +		dev_replace->tgtdev =3D btrfs_find_device(fs_info->fs_devices, &args,=
 false);
>   		args.devid =3D src_devid;
> -		dev_replace->srcdev =3D btrfs_find_device(fs_info->fs_devices, &args)=
;
> +		dev_replace->srcdev =3D btrfs_find_device(fs_info->fs_devices, &args,=
 false);
>
>   		/*
>   		 * allow 'btrfs dev replace_cancel' if src/tgt device is
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index fe0cc816b4eba..bdf1578839c99 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2039,7 +2039,7 @@ static noinline int btrfs_ioctl_resize(struct file=
 *file,
>   	}
>
>   	args.devid =3D devid;
> -	device =3D btrfs_find_device(fs_info->fs_devices, &args);
> +	device =3D btrfs_find_device(fs_info->fs_devices, &args, false);
>   	if (!device) {
>   		btrfs_info(fs_info, "resizer unable to find device %llu",
>   			   devid);
> @@ -3721,7 +3721,7 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_in=
fo *fs_info,
>   }
>
>   static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
> -				 void __user *arg)
> +				 void __user *arg, bool noseed)
>   {
>   	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct btrfs_ioctl_dev_info_args *di_args;
> @@ -3737,7 +3737,7 @@ static long btrfs_ioctl_dev_info(struct btrfs_fs_i=
nfo *fs_info,
>   		args.uuid =3D di_args->uuid;
>
>   	rcu_read_lock();
> -	dev =3D btrfs_find_device(fs_info->fs_devices, &args);
> +	dev =3D btrfs_find_device(fs_info->fs_devices, &args, noseed);
>   	if (!dev) {
>   		ret =3D -ENODEV;
>   		goto out;
> @@ -5468,7 +5468,7 @@ long btrfs_ioctl(struct file *file, unsigned int
>   	case BTRFS_IOC_FS_INFO:
>   		return btrfs_ioctl_fs_info(fs_info, argp);
>   	case BTRFS_IOC_DEV_INFO:
> -		return btrfs_ioctl_dev_info(fs_info, argp);
> +		return btrfs_ioctl_dev_info(fs_info, argp, false);
>   	case BTRFS_IOC_TREE_SEARCH:
>   		return btrfs_ioctl_tree_search(inode, argp);
>   	case BTRFS_IOC_TREE_SEARCH_V2:
> @@ -5570,6 +5570,8 @@ long btrfs_ioctl(struct file *file, unsigned int
>   	case BTRFS_IOC_ENCODED_WRITE_32:
>   		return btrfs_ioctl_encoded_write(file, argp, true);
>   #endif
> +	case BTRFS_IOC_DEV_INFO_NOSEED:
> +		return btrfs_ioctl_dev_info(fs_info, argp, true);
>   	}
>
>   	return -ENOTTY;
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 3afe5fa50a631..4b734d76776ca 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -4143,7 +4143,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info,=
 u64 devid, u64 start,
>   		goto out_free_ctx;
>
>   	mutex_lock(&fs_info->fs_devices->device_list_mutex);
> -	dev =3D btrfs_find_device(fs_info->fs_devices, &args);
> +	dev =3D btrfs_find_device(fs_info->fs_devices, &args, false);
>   	if (!dev || (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) &&
>   		     !is_dev_replace)) {
>   		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> @@ -4321,7 +4321,7 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_=
info, u64 devid,
>   	struct scrub_ctx *sctx =3D NULL;
>
>   	mutex_lock(&fs_info->fs_devices->device_list_mutex);
> -	dev =3D btrfs_find_device(fs_info->fs_devices, &args);
> +	dev =3D btrfs_find_device(fs_info->fs_devices, &args, false);
>   	if (dev)
>   		sctx =3D dev->scrub_ctx;
>   	if (sctx)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 272901514b0c1..1abd75e90cd9e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -808,7 +808,7 @@ static noinline struct btrfs_device *device_list_add=
(const char *path,
>   		};
>
>   		mutex_lock(&fs_devices->device_list_mutex);
> -		device =3D btrfs_find_device(fs_devices, &args);
> +		device =3D btrfs_find_device(fs_devices, &args, false);
>
>   		/*
>   		 * If this disk has been pulled into an fs devices created by
> @@ -2075,7 +2075,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>   	if (ret)
>   		return ret;
>
> -	device =3D btrfs_find_device(fs_info->fs_devices, args);
> +	device =3D btrfs_find_device(fs_info->fs_devices, args, false);
>   	if (!device) {
>   		if (args->missing)
>   			ret =3D BTRFS_ERROR_DEV_MISSING_NOT_FOUND;
> @@ -2381,7 +2381,7 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>
>   	if (devid) {
>   		args.devid =3D devid;
> -		device =3D btrfs_find_device(fs_info->fs_devices, &args);
> +		device =3D btrfs_find_device(fs_info->fs_devices, &args, false);
>   		if (!device)
>   			return ERR_PTR(-ENOENT);
>   		return device;
> @@ -2390,7 +2390,7 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>   	ret =3D btrfs_get_dev_args_from_path(fs_info, &args, device_path);
>   	if (ret)
>   		return ERR_PTR(ret);
> -	device =3D btrfs_find_device(fs_info->fs_devices, &args);
> +	device =3D btrfs_find_device(fs_info->fs_devices, &args, false);
>   	btrfs_put_dev_args_from_path(&args);
>   	if (!device)
>   		return ERR_PTR(-ENOENT);
> @@ -2551,7 +2551,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_=
handle *trans)
>   				   BTRFS_FSID_SIZE);
>   		args.uuid =3D dev_uuid;
>   		args.fsid =3D fs_uuid;
> -		device =3D btrfs_find_device(fs_info->fs_devices, &args);
> +		device =3D btrfs_find_device(fs_info->fs_devices, &args, false);
>   		BUG_ON(!device); /* Logic error */
>
>   		if (device->fs_devices->seeding) {
> @@ -6821,7 +6821,7 @@ static bool dev_args_match_device(const struct btr=
fs_dev_lookup_args *args,
>    * only devid is used.
>    */
>   struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *=
fs_devices,
> -				       const struct btrfs_dev_lookup_args *args)
> +				       const struct btrfs_dev_lookup_args *args, bool noseed)
>   {
>   	struct btrfs_device *device;
>   	struct btrfs_fs_devices *seed_devs;
> @@ -6832,6 +6832,8 @@ struct btrfs_device *btrfs_find_device(const struc=
t btrfs_fs_devices *fs_devices
>   				return device;
>   		}
>   	}
> +	if (noseed)
> +		return NULL;
>
>   	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
>   		if (!dev_args_match_fs_devices(args, seed_devs))
> @@ -7095,7 +7097,7 @@ static int read_one_chunk(struct btrfs_key *key, s=
truct extent_buffer *leaf,
>   				   btrfs_stripe_dev_uuid_nr(chunk, i),
>   				   BTRFS_UUID_SIZE);
>   		args.uuid =3D uuid;
> -		map->stripes[i].dev =3D btrfs_find_device(fs_info->fs_devices, &args)=
;
> +		map->stripes[i].dev =3D btrfs_find_device(fs_info->fs_devices, &args,=
 false);
>   		if (!map->stripes[i].dev) {
>   			map->stripes[i].dev =3D handle_missing_device(fs_info,
>   								    devid, uuid);
> @@ -7226,7 +7228,7 @@ static int read_one_dev(struct extent_buffer *leaf=
,
>   			return PTR_ERR(fs_devices);
>   	}
>
> -	device =3D btrfs_find_device(fs_info->fs_devices, &args);
> +	device =3D btrfs_find_device(fs_info->fs_devices, &args, false);
>   	if (!device) {
>   		if (!btrfs_test_opt(fs_info, DEGRADED)) {
>   			btrfs_report_missing_device(fs_info, devid,
> @@ -7884,7 +7886,7 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_i=
nfo,
>
>   	mutex_lock(&fs_devices->device_list_mutex);
>   	args.devid =3D stats->devid;
> -	dev =3D btrfs_find_device(fs_info->fs_devices, &args);
> +	dev =3D btrfs_find_device(fs_info->fs_devices, &args, false);
>   	mutex_unlock(&fs_devices->device_list_mutex);
>
>   	if (!dev) {
> @@ -8026,7 +8028,7 @@ static int verify_one_dev_extent(struct btrfs_fs_i=
nfo *fs_info,
>   	}
>
>   	/* Make sure no dev extent is beyond device boundary */
> -	dev =3D btrfs_find_device(fs_info->fs_devices, &args);
> +	dev =3D btrfs_find_device(fs_info->fs_devices, &args, false);
>   	if (!dev) {
>   		btrfs_err(fs_info, "failed to find devid %llu", devid);
>   		ret =3D -EUCLEAN;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 5639961b3626f..4b6bcc777f752 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -609,7 +609,10 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info,=
 u64 logical, u64 len);
>   int btrfs_grow_device(struct btrfs_trans_handle *trans,
>   		      struct btrfs_device *device, u64 new_size);
>   struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *=
fs_devices,
> -				       const struct btrfs_dev_lookup_args *args);
> +				       const struct btrfs_dev_lookup_args *args,
> +				       bool noseed);
> +struct btrfs_device *btrfs_find_device_noseed(const struct btrfs_fs_dev=
ices *fs_devices,
> +					      const struct btrfs_dev_lookup_args *args);
>   int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
>   int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *p=
ath);
>   int btrfs_balance(struct btrfs_fs_info *fs_info,
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 7ada84e4a3ed1..880b565479a12 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -1078,6 +1078,8 @@ enum btrfs_err_code {
>   				       struct btrfs_ioctl_scrub_args)
>   #define BTRFS_IOC_DEV_INFO _IOWR(BTRFS_IOCTL_MAGIC, 30, \
>   				 struct btrfs_ioctl_dev_info_args)
> +#define BTRFS_IOC_DEV_INFO_NOSEED _IOR(BTRFS_IOCTL_MAGIC, 30, \
> +				       struct btrfs_ioctl_dev_info_args)
>   #define BTRFS_IOC_FS_INFO _IOR(BTRFS_IOCTL_MAGIC, 31, \
>   			       struct btrfs_ioctl_fs_info_args)
>   #define BTRFS_IOC_BALANCE_V2 _IOWR(BTRFS_IOCTL_MAGIC, 32, \
