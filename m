Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2595AC379
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 10:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiIDIkp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Sep 2022 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDIkm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Sep 2022 04:40:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC1431DFE
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Sep 2022 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662280838;
        bh=9e+WknYJDe1PfwZRhcHOIGtFXH/OID+/FVar9EWjiF0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=gkoVMThpu2EAPJLRZTiekwzlUoB4COBKkuqhsTI3jTR/0TaVpG+zHl3DskUYOFx3s
         XEZ1KDOTYzCbNJ8NuV+/xnqTMfb5G9mKvcCAOaqPbUGcofjKW/O8z5zzOGeMSgoLbz
         02FCMNtrOlCuia5KDh+fKm6tLSMQrkqXtV1GGVoQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mgeo8-1p0ogL1suy-00h6bJ; Sun, 04
 Sep 2022 10:40:38 +0200
Message-ID: <c4aa8e99-1613-e453-4a3a-be9d0de4b021@gmx.com>
Date:   Sun, 4 Sep 2022 16:40:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH V4] btrfs-progs: Make btrfs_prepare_device parallel during
 mkfs.btrfs
Content-Language: en-US
To:     Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1662279863-17114-1-git-send-email-zhanglikernel@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <1662279863-17114-1-git-send-email-zhanglikernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/a9O3oD2b9D+SJ4i3EjDhkkjNiQBUZ2R7LmDKyRftlyK0vXbmvC
 Pj8tt/QD5gHexAni5r8gztvtYLKG688rt/xC5KNKWOGe4J3DIX65xnc271k9ka56WJXCF2w
 Sa8yHXsgZwdOi85Y8aiGMWYGZrpoDhNKF8ZZwmgIS9l+81IICMgTKEDdormQl0bEftHOrHm
 SKdiMisFDeM+CJwr/sPrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4IQQFHlkAF4=:VqjGfqa4EcErof7r/IwrSi
 Rw0OY+J9kPzAHoDVyF2akBTc+EXqRk8kFPgPZh1ez2Txlq4apMiUwiqDkJk157P8QNWVrJGiH
 svBCgVcu5EM/kCzMTKBLnXV+S9vimPStrULX2Jc4/euP7qHo2lXvuZ43RrtKJKzoPuUIalWbj
 mBbSCvuQRbAQnh/DaWeK9d6omKc/GKMaZ6q/DWND1dM8ONfH/O1RWL8kUMzcOvY3si4IYYZ60
 qCHPxjpzla0Urk3CQpPvfmCeKOK1+u0tYJJ5Ya8sEWZ398X/4/YlLE8xU22BaHlVP+vA8aTe4
 IDdcVw2FU1Tr8v4/F5sw+LB8MsYf6HMqOb4oBa3m88uSc1VsqmAlAWcPY2erJ8qWndz5mfWVg
 ndGVcYrdaDYJfwstagrJTu5wccTtF/9lR6r2CRFDZ3gV8R3muWYRT8lCFWcasd30eLGgKukfs
 6tNNt5S37Nw3YBbg4jgQ1nG63xyJZKpHV4DG19Ov0mQze1y7+JT7XwKsDq7loSt6eccG9sraM
 ruYWk6ONRAqZZcwj0cB6JvO3cQ/OlLXmN3Dtul/37b1fhwghIc2yWp2CRWXT8oOkCRQy8FNxl
 xqfuG7wybWu6gej5WWeLODiG5TwuieCreA5lCFTMRoXQ3sqTVYH49Xs26HZ6gvr57DP/XJFAl
 UPFNAkK2lpUii+qY63WJFHlyV5ShQ5E9Wt8evqS22IyG68acGz3tLsAAA9Tig+LfWY/vtBD3t
 Fc5zT9r9XGKO7bU636Tc3QNmCIelp0UdMqKOO/RSMmYdGcHT+pXa6yNFzQtOYO27i8cbCj4HG
 QqHf/9yMBvPhb9m4MBbNWjUdOjImIATtJrR7Uxd4x1lGDLzyh07uKd9pXNEQw3knqBhIhpWit
 PMcfvug/hKeMKB/NlCgAq6Sgu6sxFrtTEdymlx5ye7+NANAAi4B6RutdHremv1HP+rqaaZfEj
 ifJxknJ85360085iSg9i9aQj5oFjHW1rihvVGFuoVRCRUVLYuovQt2+DMgCWz8W3/KMTY0zLX
 ZM+003Ebz23Gr69SBz/Xhdy5QdK/7btMhgGXpMc/LtPF+745DsIYIDW1h6kyRgO+pU8X2uuca
 A8ZphRFLgB4LH0gTPfFYFY8wr57A6ZtT8hhf9UdR0HqpwApQJ9ONfxJk5byfVhA+P/xWFxz84
 tgmPsKQZvzn5VfKjpgj3aFq0/a
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/4 16:24, Li Zhang wrote:
> [enhancement]
> When a disk is formatted as btrfs, it calls
> btrfs_prepare_device for each device, which takes too much time.
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
> Use tcmu-runner emulation to simulate two devices for testing.
> Each device is 2000G (about 19.53 TiB), the region size is 4MB,
> Use the following parameters for targetcli
> create name=3Dzbc0 size=3D20000G cfgstring=3Dmodel-HM/zsize-4/conv-100@~=
/zbc0.raw
>
> Call difftime to calculate the running time of the function btrfs_prepar=
e_device.
> Calculate the time from thread creation to completion of all threads aft=
er
> patching (time calculation is not included in patch submission)
> The test results are as follows.
>
> $ lsscsi -p
> [10:0:1:0]   (0x14)  LIO-ORG  TCMU ZBC device  0002  /dev/sdb   -       =
   none
> [11:0:1:0]   (0x14)  LIO-ORG  TCMU ZBC device  0002  /dev/sdc   -       =
   none
>
> $ sudo mkfs.btrfs -d single -m single -O zoned /dev/sdc /dev/sdb -f
> ....
> time for prepare devices:4.000000.
> ....
>
> $ sudo mkfs.btrfs -d single -m single -O zoned /dev/sdc /dev/sdb -f
> ...
> time for prepare devices:2.000000.
> ...
>
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
> Issue: 496
>
> V1:
> * Put btrfs_prepare_device into threads and make them parallel
>
> V2:
> * Set the 4 variables used by btrfs_prepare_device as global variables.
> * Use pthread_mutex to ensure error messages are not messed up.
> * Correct the error message
> * Wait for all threads to exit in a loop
>
> V3:
> * Add prefix opt to the global variables
> * Format code
> * Add error handler for open
>
> V4:
> * initialize the global options
>
>   mkfs/main.c | 154 +++++++++++++++++++++++++++++++++++++++++-----------=
--------
>   1 file changed, 107 insertions(+), 47 deletions(-)
>
> diff --git a/mkfs/main.c b/mkfs/main.c
> index ce096d3..3e16a0e 100644
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
> @@ -60,6 +61,20 @@ struct mkfs_allocation {
>   	u64 system;
>   };
>
> +static bool opt_zero_end =3D true;
> +static bool opt_discard =3D true;
> +static bool opt_zoned =3D true;
> +static int opt_oflags =3D O_RDONLY;

Isn't the default one should be O_RDWR?

Despite that, feel free to addd my reviewed by tag:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> +
> +static pthread_mutex_t prepare_mutex;
> +
> +struct prepare_device_progress {
> +	char *file;
> +	u64 dev_block_count;
> +	u64 block_count;
> +	int ret;
> +};
> +
>   static int create_metadata_block_groups(struct btrfs_root *root, bool =
mixed,
>   				struct mkfs_allocation *allocation)
>   {
> @@ -969,6 +984,31 @@ fail:
>   	return ret;
>   }
>
> +static void *prepare_one_dev(void *ctx)
> +{
> +	struct prepare_device_progress *prepare_ctx =3D ctx;
> +	int fd;
> +
> +	fd =3D open(prepare_ctx->file, opt_oflags);
> +	if (fd < 0) {
> +		pthread_mutex_lock(&prepare_mutex);
> +		error("unable to open %s: %m", prepare_ctx->file);
> +		pthread_mutex_unlock(&prepare_mutex);
> +		prepare_ctx->ret =3D fd;
> +		return NULL;
> +	}
> +	prepare_ctx->ret =3D btrfs_prepare_device(fd,
> +			prepare_ctx->file,
> +			&prepare_ctx->dev_block_count,
> +			prepare_ctx->block_count,
> +			(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> +			(opt_zero_end ? PREP_DEVICE_ZERO_END : 0) |
> +			(opt_discard ? PREP_DEVICE_DISCARD : 0) |
> +			(opt_zoned ? PREP_DEVICE_ZONED : 0));
> +	close(fd);
> +	return NULL;
> +}
> +
>   int BOX_MAIN(mkfs)(int argc, char **argv)
>   {
>   	char *file;
> @@ -984,7 +1024,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	u32 nodesize =3D 0;
>   	u32 sectorsize =3D 0;
>   	u32 stripesize =3D 4096;
> -	bool zero_end =3D true;
>   	int fd =3D -1;
>   	int ret =3D 0;
>   	int close_ret;
> @@ -993,11 +1032,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	bool nodesize_forced =3D false;
>   	bool data_profile_opt =3D false;
>   	bool metadata_profile_opt =3D false;
> -	bool discard =3D true;
>   	bool ssd =3D false;
> -	bool zoned =3D false;
>   	bool force_overwrite =3D false;
> -	int oflags;
>   	char *source_dir =3D NULL;
>   	bool source_dir_set =3D false;
>   	bool shrink_rootdir =3D false;
> @@ -1006,6 +1042,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	u64 shrink_size;
>   	int dev_cnt =3D 0;
>   	int saved_optind;
> +	pthread_t *t_prepare =3D NULL;
> +	struct prepare_device_progress *prepare_ctx =3D NULL;
>   	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] =3D { 0 };
>   	u64 features =3D BTRFS_MKFS_DEFAULT_FEATURES;
>   	u64 runtime_features =3D BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
> @@ -1126,7 +1164,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   				break;
>   			case 'b':
>   				block_count =3D parse_size_from_string(optarg);
> -				zero_end =3D false;
> +				opt_zero_end =3D false;
>   				break;
>   			case 'v':
>   				bconf_be_verbose();
> @@ -1144,7 +1182,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   					BTRFS_UUID_UNPARSED_SIZE - 1);
>   				break;
>   			case 'K':
> -				discard =3D false;
> +				opt_discard =3D false;
>   				break;
>   			case 'q':
>   				bconf_be_quiet();
> @@ -1183,7 +1221,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	if (dev_cnt =3D=3D 0)
>   		print_usage(1);
>
> -	zoned =3D !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
> +	opt_zoned =3D !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
>
>   	if (source_dir_set && dev_cnt > 1) {
>   		error("the option -r is limited to a single device");
> @@ -1225,7 +1263,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>
>   	file =3D argv[optind++];
>   	ssd =3D is_ssd(file);
> -	if (zoned) {
> +	if (opt_zoned) {
>   		if (!zone_size(file)) {
>   			error("zoned: %s: zone size undefined", file);
>   			exit(1);
> @@ -1235,7 +1273,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   			printf(
>   	"Zoned: %s: host-managed device detected, setting zoned feature\n",
>   			       file);
> -		zoned =3D true;
> +		opt_zoned =3D true;
>   		features |=3D BTRFS_FEATURE_INCOMPAT_ZONED;
>   	}
>
> @@ -1302,7 +1340,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		}
>   	}
>
> -	if (zoned) {
> +	if (opt_zoned) {
>   		if (source_dir_set) {
>   			error("the option -r and zoned mode are incompatible");
>   			exit(1);
> @@ -1392,7 +1430,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	 * 1 zone for a metadata block group
>   	 * 1 zone for a data block group
>   	 */
> -	if (zoned && block_count && block_count < 5 * zone_size(file)) {
> +	if (opt_zoned && block_count && block_count < 5 * zone_size(file)) {
>   		error("size %llu is too small to make a usable filesystem",
>   			block_count);
>   		error("minimum size for a zoned btrfs filesystem is %llu",
> @@ -1422,35 +1460,58 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	if (ret)
>   		goto error;
>
> -	if (zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADATA | me=
tadata_profile) ||
> +	if (opt_zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADATA =
| metadata_profile) ||
>   		      !zoned_profile_supported(BTRFS_BLOCK_GROUP_DATA | data_profile=
))) {
>   		error("zoned mode does not yet support RAID/DUP profiles, please spe=
cify '-d single -m single' manually");
>   		goto error;
>   	}
>
> -	dev_cnt--;
> +	t_prepare =3D calloc(dev_cnt, sizeof(*t_prepare));
> +	prepare_ctx =3D calloc(dev_cnt, sizeof(*prepare_ctx));
>
> -	oflags =3D O_RDWR;
> -	if (zoned && zoned_model(file) =3D=3D ZONED_HOST_MANAGED)
> -		oflags |=3D O_DIRECT;
> +	if (!t_prepare || !prepare_ctx) {
> +		error("unable to alloc thread for preparing dev");
> +		goto error;
> +	}
>
> -	/*
> -	 * Open without O_EXCL so that the problem should not occur by the
> -	 * following operation in kernel:
> -	 * (btrfs_register_one_device() fails if O_EXCL is on)
> -	 */
> -	fd =3D open(file, oflags);
> +	pthread_mutex_init(&prepare_mutex, NULL);
> +	opt_oflags =3D O_RDWR;
> +	for (i =3D 0; i < dev_cnt; i++) {
> +		if (opt_zoned && zoned_model(argv[optind + i - 1]) =3D=3D
> +			ZONED_HOST_MANAGED) {
> +			opt_oflags |=3D O_DIRECT;
> +			break;
> +		}
> +	}
> +	for (i =3D 0; i < dev_cnt; i++) {
> +		prepare_ctx[i].file =3D argv[optind + i - 1];
> +		prepare_ctx[i].block_count =3D block_count;
> +		prepare_ctx[i].dev_block_count =3D block_count;
> +		ret =3D pthread_create(&t_prepare[i], NULL,
> +			prepare_one_dev, &prepare_ctx[i]);
> +		if (ret) {
> +			error("create thread for prepare devices: %s failed, "
> +					"errno: %d",
> +					prepare_ctx[i].file, ret);
> +			goto error;
> +		}
> +	}
> +	for (i =3D 0; i < dev_cnt; i++)
> +		pthread_join(t_prepare[i], NULL);
> +	ret =3D prepare_ctx[0].ret;
> +
> +	if (ret) {
> +		error("unable prepare device: %s\n", prepare_ctx[0].file);
> +		goto error;
> +	}
> +
> +	dev_cnt--;
> +	fd =3D open(file, opt_oflags);
>   	if (fd < 0) {
>   		error("unable to open %s: %m", file);
>   		goto error;
>   	}
> -	ret =3D btrfs_prepare_device(fd, file, &dev_block_count, block_count,
> -			(zero_end ? PREP_DEVICE_ZERO_END : 0) |
> -			(discard ? PREP_DEVICE_DISCARD : 0) |
> -			(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> -			(zoned ? PREP_DEVICE_ZONED : 0));
> -	if (ret)
> -		goto error;
> +	dev_block_count =3D prepare_ctx[0].dev_block_count;
>   	if (block_count && block_count > dev_block_count) {
>   		error("%s is smaller than requested size, expected %llu, found %llu"=
,
>   		      file, (unsigned long long)block_count,
> @@ -1459,7 +1520,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	}
>
>   	/* To create the first block group and chunk 0 in make_btrfs */
> -	system_group_size =3D zoned ?  zone_size(file) : BTRFS_MKFS_SYSTEM_GRO=
UP_SIZE;
> +	system_group_size =3D opt_zoned ? zone_size(file) : BTRFS_MKFS_SYSTEM_=
GROUP_SIZE;
>   	if (dev_block_count < system_group_size) {
>   		error("device is too small to make filesystem, must be at least %llu=
",
>   				(unsigned long long)system_group_size);
> @@ -1487,7 +1548,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	mkfs_cfg.runtime_features =3D runtime_features;
>   	mkfs_cfg.csum_type =3D csum_type;
>   	mkfs_cfg.leaf_data_size =3D __BTRFS_LEAF_DATA_SIZE(nodesize);
> -	if (zoned)
> +	if (opt_zoned)
>   		mkfs_cfg.zone_size =3D zone_size(file);
>   	else
>   		mkfs_cfg.zone_size =3D 0;
> @@ -1558,14 +1619,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		goto raid_groups;
>
>   	while (dev_cnt-- > 0) {
> +		int dev_index =3D argc - saved_optind - dev_cnt - 1;
>   		file =3D argv[optind++];
>
> -		/*
> -		 * open without O_EXCL so that the problem should not
> -		 * occur by the following processing.
> -		 * (btrfs_register_one_device() fails if O_EXCL is on)
> -		 */
> -		fd =3D open(file, O_RDWR);
> +		fd =3D open(file, opt_oflags);
>   		if (fd < 0) {
>   			error("unable to open %s: %m", file);
>   			goto error;
> @@ -1578,13 +1635,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   			close(fd);
>   			continue;
>   		}
> -		ret =3D btrfs_prepare_device(fd, file, &dev_block_count,
> -				block_count,
> -				(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> -				(zero_end ? PREP_DEVICE_ZERO_END : 0) |
> -				(discard ? PREP_DEVICE_DISCARD : 0) |
> -				(zoned ? PREP_DEVICE_ZONED : 0));
> -		if (ret) {
> +		dev_block_count =3D prepare_ctx[dev_index]
> +			.dev_block_count;
> +
> +		if (prepare_ctx[dev_index].ret) {
> +			error("unable prepare device: %s.\n",
> +					prepare_ctx[dev_index].file);
>   			goto error;
>   		}
>
> @@ -1714,8 +1770,8 @@ raid_groups:
>   			btrfs_group_profile_str(metadata_profile),
>   			pretty_size(allocation.system));
>   		printf("SSD detected:       %s\n", ssd ? "yes" : "no");
> -		printf("Zoned device:       %s\n", zoned ? "yes" : "no");
> -		if (zoned)
> +		printf("Zoned device:       %s\n", opt_zoned ? "yes" : "no");
> +		if (opt_zoned)
>   			printf("  Zone size:        %s\n",
>   			       pretty_size(fs_info->zone_size));
>   		btrfs_parse_fs_features_to_string(features_buf, features);
> @@ -1763,12 +1819,16 @@ out:
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
