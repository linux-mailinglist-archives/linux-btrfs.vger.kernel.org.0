Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA98727739
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjFHGYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjFHGYe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:24:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7601FDE
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686205468; x=1686810268; i=quwenruo.btrfs@gmx.com;
 bh=xd3/08PK0n5SN876fu8IzRQsvZhktrLUygO5cHq2p24=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=CnU5/jTsRPUSHUieWm0Zmw4VGNda+nU7XhZILGwx5xFpH89vrmKwIFNVeqHAk+bdRYEBlTz
 LLdpoN1I8CUO8dQJhFl7xeSZnNQKWWjVk0xMwHLGVEwC84wcZcfIqOUQzp2h7n/KsVRp4+XFL
 luCRzT5y3WoZakSgXhl+MRDOZ10IRJYScYe6JoiiFfZnmHa7Y2jvQPTNRfYJpVcZOOdEYvyJx
 JScE/jS1Ihat9epU2Z/GfKnqTawAPOfXRFgftZGmWP3arMJyfbK+LOZZFWUm6fuIZpfvUVWSx
 hWHXRorHfXeeK1k1I2xxhnn4UWcsC6eiz+uyYL4UdJzeyvPM/emA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRCOK-1qU9b53J8m-00NDru; Thu, 08
 Jun 2023 08:24:28 +0200
Message-ID: <c51752d1-c4c6-a906-a4f1-415b6209463f@gmx.com>
Date:   Thu, 8 Jun 2023 14:24:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 6/7] btrfs-progs: factor out btrfs_scan_stdin_devices
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1686202417.git.anand.jain@oracle.com>
 <3c660a0d48f5e8d50fb932dee473fc1d86c0838e.1686202417.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3c660a0d48f5e8d50fb932dee473fc1d86c0838e.1686202417.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3soDomkXclSqfyVdEHGPekoii80NUPeg9YX74sYtf2/358dhUwf
 spyGp2DJO+ikHYh+/VVvndbKypJkYKA8Km7Gf4AilAUAgGdCSTsWbWDoa2lEkU7HYyJ4erN
 UBRSNWpl+soX5oLwR4lTbUV0DibNjvyUwwu1Yp+Vp+quaeEz/UPKv2zMN0Z5UQl3JDD9MDi
 Hgsyurbz9CKLcyx0NxnKw==
UI-OutboundReport: notjunk:1;M01:P0:PYxOKLj6Z5s=;nlr3+FbROV42oKx+GcItACJev8A
 Yml9hBc/aTBozpVlGL2tKvC5RxzawW2jwxNVgTI9BZTs934Fu5R2Ss/STusrZI5W3XIWR7H0O
 JIbwQiM0fAM6mP0NSIkIXPWXUUhofiPH1J4lFI13yVqRmFiXeqE+NfEHAQQGumlDC/lSaKLp9
 KdsOqyljUX8+cAriJ6aIyumQRvKfJ+uQ2bzBlKbzlmO5wAbfvdpuFU4Ie9bxDuiTyh/n3FaGF
 VWtybhaVpTLHoYtEurzASlfg+FG2gY1oLu67bZI59hhX9UXz0T1G5mOtiMFHfUNq/yM0evRXq
 KXu0bKss8vkIvU4pln5pysNtFCE8z3DCrt/u1aauot/zg3+72oYQLUCbE71x3/mtYfGZ0GGSC
 FJIfjX1S6zPcELgFIrfSlqtTkwaYqg1HvGIl4E4yYLl1OaCIF2KrKWucvKdju5U6I9SycvIYE
 D0RBklcQrGcuObrvicyH5BpYApigmCj9+JENNToKJryYrJlUagW5UbZ+ASZfbKORJYzWGgCN7
 UBfkFVojNTu1syPirBretv9d0RE+dQ4y+NEMA7Q6UEFpxpVScby0HeuL7IXaxPDocooY21u6E
 DVuRfk8yydZ4FcEPFtfI+2ovTeIsVWNHfStgRrOulMGf3ryts8BagUBrReyPSzC7ZO5/fznQU
 Xp/+vyO+Iv6ID1M0BQKcJyq37rEDZDBamRj9L1d6TNuvfk+bJX6eo2w+HHwus9TZ3PiRXrS+7
 tblpUkBoz8mCWzABkLQa6aLAnkZRN8mSWAh1uMF0DsvsjeDwUMpKV+ieacjRf79rAenyVW+4D
 ZLwAwsFkwlfvLajuyFTFo04M7j9yiKRgzw1i/tidtWwfTwVqhbRQEk5pysLQjqIb1AtMNYyvx
 gr+IoPEMZu2tqLUolAIu+baN8ZM3sZ8MjWpxUAt09M8f42yBxyZC6SS3VvgPuxg8sNr1v2iey
 PBsYzHrgyytnepVEseWowOzEOaI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 14:01, Anand Jain wrote:
> To prepare for handling command line given devices factor out
> btrfs_scan_stdin_devices().
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   cmds/inspect-dump-tree.c | 37 +++----------------------------------
>   common/device-scan.c     | 39 +++++++++++++++++++++++++++++++++++++++
>   common/device-scan.h     |  1 +
>   3 files changed, 43 insertions(+), 34 deletions(-)
>
> diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
> index 35920d14b7e9..311dfbfddab6 100644
> --- a/cmds/inspect-dump-tree.c
> +++ b/cmds/inspect-dump-tree.c
> @@ -327,7 +327,6 @@ static int cmd_inspect_dump_tree(const struct cmd_st=
ruct *cmd,
>   	bool roots_only =3D false;
>   	bool root_backups =3D false;
>   	int traverse =3D BTRFS_PRINT_TREE_DEFAULT;
> -	int dev_optind;
>   	unsigned open_ctree_flags;
>   	u64 block_bytenr;
>   	struct btrfs_root *tree_root_scan;
> @@ -456,39 +455,9 @@ static int cmd_inspect_dump_tree(const struct cmd_s=
truct *cmd,
>   	if (check_argc_min(argc - optind, 1))
>   		return 1;
>
> -	dev_optind =3D optind;
> -	while (dev_optind < argc) {
> -		int fd;
> -		struct btrfs_fs_devices *fs_devices;
> -		u64 num_devices;
> -
> -		ret =3D check_arg_type(argv[optind]);
> -		if (ret !=3D BTRFS_ARG_BLKDEV && ret !=3D BTRFS_ARG_REG) {
> -			if (ret < 0) {
> -				errno =3D -ret;
> -				error("invalid argument %s: %m", argv[dev_optind]);
> -			} else {
> -				error("not a block device or regular file: %s",
> -				       argv[dev_optind]);
> -			}
> -		}
> -		fd =3D open(argv[dev_optind], O_RDONLY);
> -		if (fd < 0) {
> -			error("cannot open %s: %m", argv[dev_optind]);
> -			return -EINVAL;
> -		}
> -		ret =3D btrfs_scan_one_device(fd, argv[dev_optind], &fs_devices,
> -					    &num_devices,
> -					    BTRFS_SUPER_INFO_OFFSET,
> -					    SBREAD_DEFAULT);
> -		close(fd);
> -		if (ret < 0) {
> -			errno =3D -ret;
> -			error("device scan %s: %m", argv[dev_optind]);
> -			return ret;
> -		}
> -		dev_optind++;
> -	}
> +	ret =3D btrfs_scan_stdin_devices(optind, argc, argv);
> +	if (ret)
> +		return ret;
>
>   	pr_verbose(LOG_DEFAULT, "%s\n", PACKAGE_STRING);
>
> diff --git a/common/device-scan.c b/common/device-scan.c
> index 515481a6efa9..38f986df810f 100644
> --- a/common/device-scan.c
> +++ b/common/device-scan.c
> @@ -500,3 +500,42 @@ int btrfs_scan_devices(int verbose)
>   	return 0;
>   }
>
> +int btrfs_scan_stdin_devices(int dev_optind, int argc, char **argv)
> +{
> +	int ret;
> +
> +	while (dev_optind < argc) {

In this case, I believe "--device dev1 --device dev2" would be much
easier to parse, and would not lead to any confusion between the device
scan and target fs.

Thanks,
Qu
> +		int fd;
> +		u64 num_devices;
> +		struct btrfs_fs_devices *fs_devices;
> +
> +		ret =3D check_arg_type(argv[optind]);
> +		if (ret !=3D BTRFS_ARG_BLKDEV && ret !=3D BTRFS_ARG_REG) {
> +			if (ret < 0) {
> +				errno =3D -ret;
> +				error("invalid argument %s: %m", argv[dev_optind]);
> +			} else {
> +				error("not a block device or regular file: %s",
> +				       argv[dev_optind]);
> +			}
> +		}
> +		fd =3D open(argv[dev_optind], O_RDONLY);
> +		if (fd < 0) {
> +			error("cannot open %s: %m", argv[dev_optind]);
> +			return -EINVAL;
> +		}
> +		ret =3D btrfs_scan_one_device(fd, argv[dev_optind], &fs_devices,
> +					    &num_devices,
> +					    BTRFS_SUPER_INFO_OFFSET,
> +					    SBREAD_DEFAULT);
> +		close(fd);
> +		if (ret < 0) {
> +			errno =3D -ret;
> +			error("device scan %s: %m", argv[dev_optind]);
> +			return ret;
> +		}
> +		dev_optind++;
> +	}
> +
> +	return 0;
> +}
> diff --git a/common/device-scan.h b/common/device-scan.h
> index f805b489f595..e2480d3eb168 100644
> --- a/common/device-scan.h
> +++ b/common/device-scan.h
> @@ -58,5 +58,6 @@ int add_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsi=
d_hash[],
>   		int fd, DIR *dirstream);
>   void free_seen_fsid(struct seen_fsid *seen_fsid_hash[]);
>   int test_uuid_unique(const char *uuid_str);
> +int btrfs_scan_stdin_devices(int dev_optind, int argc, char **argv);
>
>   #endif
