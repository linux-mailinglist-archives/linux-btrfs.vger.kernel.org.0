Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6305AC282
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 06:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiIDE15 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Sep 2022 00:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiIDE1y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Sep 2022 00:27:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7523412AC7
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 21:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662265669;
        bh=OijG28UnGrnrBNAPyiUPtNQuvJU3329+Dd46Mdmm4TE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=kVReblhLcqlF7+CxgPcU8vLGpIZV1rxzHoC6b+h0ii0mBIma/7keuhy3+vHPRFipX
         KDFfKtaZtbRAMaOBKvx/Rk7XN5a8tsn9xFJZE4cF+S7z/XY4Dxhq+7knVpxCmgYUAA
         lrPglv5hVvWGoWg43z6kyFBmYxP31Z5hnRiDQmFI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9kC-1oaAtU2j6a-00GXPu; Sun, 04
 Sep 2022 06:27:49 +0200
Message-ID: <5d2d4cf0-a0ff-fd86-0824-54a42e94076c@gmx.com>
Date:   Sun, 4 Sep 2022 12:27:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH V3] Make btrfs_prepare_device parallel during mkfs.btrfs
Content-Language: en-US
To:     Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1662264857-11347-1-git-send-email-zhanglikernel@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <1662264857-11347-1-git-send-email-zhanglikernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VP/S5ZbYHdbUPLQ1mPJCqY9u2cNQCaWYnusRl7QKl9GBRj4TImy
 LBwmAqFq1frwzx3wHUPezWaFCnk2ydlUZvGIQ9g5YntdU8OCoHWficAgCn2te+V79DEGfHS
 3b58s2STDxHvIG9s+zIXb0ILeUxddkXsrJKpAej/U3XxQfpHcceupmg1ZuENDHiFjfCgXPU
 Pji/MWV0UVYf+sgHWs5Wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OrtGLVIh5So=:d0VLFvsHn0XYbBaQaFN1S1
 NCDQOkIX95Y14nu3UWxF2rdmxy4LqOWzuMMXmcviOCyaGPtxam0c3S6+ZOPciM+1rnCR1ZRGZ
 aq+NaaDXRnHNkj2pQZe8lQsbRmbSgn1N6gb3AyUoAhDJht2Jcxr5JTs4sy3LqSIb0nBfG4xNN
 yoydeWyAit+uqGgFH+jax4OH1dUhQ/dr0bWErV0oO4Kl7Q5dpKjGMlnFiOcjZWFaBgN/WmuK4
 xVOjC33cF1YOIAykCt+OHQsRwuhB0lGj3ud2vuY6rklcil8L01JYoMxCLXSIon9HATseimhe3
 cvFaChVPcnddwIVn1D+gWFRV0Aunyyla3RcgIxHLbMBYn572gMYgRqat6Nm7F2/ZeyN/CK1us
 TR7OblBzdrvAUcyG/XrT+64Hw8eDTy0Ks9ri3uL60jO3kyBcAP8SM3UYjfi9DwO85/LWKfRmC
 ofmg11nF7YsVZ+UTO1O5x6/hflq2MdFBmXkusmXLNJ+xOF2s6Xc2XWvxxOGqHaBBGgvj2mp2f
 E3/2Oltnte8MEAbYUQBixkOIc1usXDAVoBxKj5gmI09jXCN4NvLyGEaX0FfKvSKlmD8j8MYsL
 VsjRQ/imrpTJde8wjN9dS1MOBl+iukld4mu/B7xVm5VgcX3a+nPSxSu509ONFY2gxzM2Rpzab
 upJ6qIn3WlCNGqxKBHqJxLdMkA9E9xxGSL7QeDgD4a68KxvG5Fn6gJOO5Ez/dTzB8VuNR0/93
 kSCilfPp6I4ZgPuPFj1rxTuK/q+ZqZHxiW+v3zoV7lVAIbR4vVXL7roBmPUWNfjAJysxgwpWw
 Li0jpYprebK9yvRTpLOLSBLa7Iu9PJ52I+gGFdwshsm9rqyfDbZNO+XEucyu+1DYZ7zQRvlo7
 Mz8AITdJBqUBmyG3s9nEpZZaHCTyolzxgkFfoAL/zl4VsKFazRD7MUTemS3rH/9uRspxYHwRz
 Hh816g+N95K+s7IpOZL4M9OsM0HY8o8UloSPr5CK4DTxAmkwZ9R9uVhqIhjoApYurdjd9l3XX
 7iNolmvbroz/43QES3+KlVjSWSS2t1B7z/etWDvsqL4ktGQr46Qon7pWh+gi++eBXOxKzo2k0
 LtpOVKnDkDvxKKH06uaRZxfmC3ipGbnK1vo5nTmOwiL/LJswYP1Jxl3siMVpGZ8cwOTYfoe28
 2pceLfmjb7HJetMBJgM0IyClP6
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/4 12:14, Li Zhang wrote:
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
>   mkfs/main.c | 157 ++++++++++++++++++++++++++++++++++++++++++----------=
--------
>   1 file changed, 110 insertions(+), 47 deletions(-)
>
> diff --git a/mkfs/main.c b/mkfs/main.c
> index ce096d3..2c681f2 100644
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
> +static bool opt_zero_end;
> +static bool opt_discard;
> +static bool opt_zoned;
> +static int opt_oflags;

These global options can have default values.

[...]
> @@ -984,7 +1024,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	u32 nodesize =3D 0;
>   	u32 sectorsize =3D 0;
>   	u32 stripesize =3D 4096;
> -	bool zero_end =3D true;
> +	opt_zero_end =3D true;

I'm mentioning this because if you mix code and declaration here, IIRC
compiler would give you some warning.

That's why you'd better just initialize the global options, other than
giving them default value here.

With that fixed, looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>   	int fd =3D -1;
>   	int ret =3D 0;
>   	int close_ret;
> @@ -993,11 +1033,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	bool nodesize_forced =3D false;
>   	bool data_profile_opt =3D false;
>   	bool metadata_profile_opt =3D false;
> -	bool discard =3D true;
> +	opt_discard =3D true;
>   	bool ssd =3D false;
> -	bool zoned =3D false;
> +	opt_zoned =3D false;
>   	bool force_overwrite =3D false;
> -	int oflags;
>   	char *source_dir =3D NULL;
>   	bool source_dir_set =3D false;
>   	bool shrink_rootdir =3D false;
> @@ -1006,6 +1045,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	u64 shrink_size;
>   	int dev_cnt =3D 0;
>   	int saved_optind;
> +	pthread_t *t_prepare =3D NULL;
> +	struct prepare_device_progress *prepare_ctx =3D NULL;
>   	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] =3D { 0 };
>   	u64 features =3D BTRFS_MKFS_DEFAULT_FEATURES;
>   	u64 runtime_features =3D BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
> @@ -1126,7 +1167,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   				break;
>   			case 'b':
>   				block_count =3D parse_size_from_string(optarg);
> -				zero_end =3D false;
> +				opt_zero_end =3D false;
>   				break;
>   			case 'v':
>   				bconf_be_verbose();
> @@ -1144,7 +1185,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   					BTRFS_UUID_UNPARSED_SIZE - 1);
>   				break;
>   			case 'K':
> -				discard =3D false;
> +				opt_discard =3D false;
>   				break;
>   			case 'q':
>   				bconf_be_quiet();
> @@ -1183,7 +1224,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	if (dev_cnt =3D=3D 0)
>   		print_usage(1);
>
> -	zoned =3D !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
> +	opt_zoned =3D !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
>
>   	if (source_dir_set && dev_cnt > 1) {
>   		error("the option -r is limited to a single device");
> @@ -1225,7 +1266,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>
>   	file =3D argv[optind++];
>   	ssd =3D is_ssd(file);
> -	if (zoned) {
> +	if (opt_zoned) {
>   		if (!zone_size(file)) {
>   			error("zoned: %s: zone size undefined", file);
>   			exit(1);
> @@ -1235,7 +1276,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   			printf(
>   	"Zoned: %s: host-managed device detected, setting zoned feature\n",
>   			       file);
> -		zoned =3D true;
> +		opt_zoned =3D true;
>   		features |=3D BTRFS_FEATURE_INCOMPAT_ZONED;
>   	}
>
> @@ -1302,7 +1343,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		}
>   	}
>
> -	if (zoned) {
> +	if (opt_zoned) {
>   		if (source_dir_set) {
>   			error("the option -r and zoned mode are incompatible");
>   			exit(1);
> @@ -1392,7 +1433,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	 * 1 zone for a metadata block group
>   	 * 1 zone for a data block group
>   	 */
> -	if (zoned && block_count && block_count < 5 * zone_size(file)) {
> +	if (opt_zoned && block_count && block_count < 5 * zone_size(file)) {
>   		error("size %llu is too small to make a usable filesystem",
>   			block_count);
>   		error("minimum size for a zoned btrfs filesystem is %llu",
> @@ -1422,35 +1463,58 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
> @@ -1459,7 +1523,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
> @@ -1487,7 +1551,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	mkfs_cfg.runtime_features =3D runtime_features;
>   	mkfs_cfg.csum_type =3D csum_type;
>   	mkfs_cfg.leaf_data_size =3D __BTRFS_LEAF_DATA_SIZE(nodesize);
> -	if (zoned)
> +	if (opt_zoned)
>   		mkfs_cfg.zone_size =3D zone_size(file);
>   	else
>   		mkfs_cfg.zone_size =3D 0;
> @@ -1558,14 +1622,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
> @@ -1578,13 +1638,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
> @@ -1714,8 +1773,8 @@ raid_groups:
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
> @@ -1763,12 +1822,16 @@ out:
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
