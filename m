Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BAF580901
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 03:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiGZB25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 21:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiGZB24 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 21:28:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A9CBE27
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658798932;
        bh=n03AiL08S2XyAf6sz9zI9ARG+yrW83nPuJPjFSFV3tU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Cl2Zx+YW8gZCddnX7LiQjH/OUac0F25rZPAf88SOKwaV4JmIncuWOfJCEb8hYcTXk
         AgTtQj9+ajRFy/Lr6twa43QgNt4OCmRyIwB3FWy2IcnIDptl6tRCCQ7+m//fZ+L82Q
         eiLWF+vNJgmbK7yJ1qB8fIaLBY0N6RtdCqQzzuuA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrQEn-1njcNn05hv-00oZmA; Tue, 26
 Jul 2022 03:28:52 +0200
Message-ID: <d8fea112-ca92-ca08-0d26-405ca8f75ccc@gmx.com>
Date:   Tue, 26 Jul 2022 09:28:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4] btrfs-progs: fix btrfs resize failed.
Content-Language: en-US
To:     Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1658767574-16160-1-git-send-email-zhanglikernel@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <1658767574-16160-1-git-send-email-zhanglikernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eWtm8NyxBToB4j9RNLeWisf0OPi8NQ4rEEFlGJFEh+6FFTUjqG7
 a/SqSTwqnaldaO/lD4S9ryHfkzYx4P/TD87DersNXZ5rS+/WAIEjAOYLu9Lhna80HKpnvWJ
 FnoEFB/hUQmuw/1753ATKcq1VflErnchGbdFMN7ZB2zHea6PZTSM6gWaMktmZKyuYpUPSqf
 ooOMwHo02jzTd77l3Jhsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+nlg/EAl3NA=:NH88Wkk0rJhAq/IzQQHl0u
 xiTExxCa1T5VfTxaCgqtSNHqqjoReyUspvs3dGJqa8w3bmh0WEYCSHZiUhlnkmAxUTRU4dMRf
 pAJnHPO/JPbVskXoZ2T+wscO5dXq6VNrEFg6axp7VdDyesifShVrlAv/Y2SE84mG+/k7lfKLZ
 5TsMi+xJfjeXMsiA5vfYwM/kMBg5hUdjc1+kCCnXOWBBd6mudkJFVc/wBDH28whMF55XExtci
 UXfiKeTWouz7ETEsXOUnKuZkpPx+etPXenElO8Baa2wOuJPTdfKgcibWhiC+/tBhpUKh9vMIQ
 ym5oGaChMTCLRubrt08OIkY6NIpHVRr2J41XdL6p7zx6K5B3/1N2HKAHTTK47yDLpb7zBwxJh
 lG7Bpboc3rjrjoSqI5Gf/m85S1D0eqlQLUtCqd+litFYjoaSru6bXosslQnkmV+Y72kJ4QNsA
 O/O97su5wq82LikbT415kFqEgx5lbjrMTcGK4Q09xAcqmweQHzVG430zHLtJDRC2TS2zrmP9D
 J7k8EMX105ANtsm70+SADiDJy0dkoTYbmVQyYrLbgmlhPb3yuWHma9iqDml1oMv7OAfenNY2J
 Z9yl43w9ts45BIekENz1ruait3zfq1BdPCOdIX5BDl0V1rML0va+opv5zmnCfdydDHJQU8ylm
 F+tOQvGBjafOCuiQVJxqjePPcrnnSyzc3cPNwEMJLKV1YKlarW9uM4c5ECPaPEuRTjRfaaT4C
 I1LlP8nBal94rvUCGS2A8Iqn2ykGhk5WDtn4vV4Uwbyl+cV4+rlxO74HvJNiSPqoxJ/yXUVxq
 BJz4YVvDOCgHrkpL+Y4TnKWYJOFHXC9odnckBSSwUG3TSNRsoionMn/XRJ4nzLcKhHnf/4ZeF
 AQTUld8ZCuSy8BZN46E4NuWbbrfxHzJTwo017/sScNZI2uvXgQ5OqhfeCMEVayLrRLrLmVk3Z
 cfmm8cQSacaI1neuIS7wU2aTSmQOV2ZJMh0jnt8EmTfqbhqJa2QOTnJCI8cyFw/SVLUDyksQg
 1esIZ1oopRtERvcbfXtqOI5FrQkdXZemUuDy3P/fQRKOCHJYEM6aas1QscdLLmdXYi35qPrT0
 j6IUPpEn4S0zg5Hf3RbJP4oQYBlr/P93gB4edmytt5tYAmf/E6gJhIHzw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/26 00:46, Li Zhang wrote:
> Issue: 470

This should be moved AFTER the SOB line.
>
> [BUG]
> 1. If there is no devid=3D1, when the user uses the btrfs file system to=
ol,
> the following error will be reported,
>
> $ sudo btrfs filesystem show /mnt/1
> Label: none  uuid: 64dc0f68-9afa-4465-9ea1-2bbebfdb6cec
>      Total devices 2 FS bytes used 704.00KiB
>      devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>      devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> $ sudo btrfs filesystem resize -1G /mnt/1
> ERROR: cannot find devid: 1
> ERROR: unable to resize '/mnt/1': No such device
>
> 2. Function check_resize_args, if get_fs_info is successful,
> check_resize_args always returns 0, Even if the parameter
> passed to kernel space is longer than the size allowed to
> be passed to kernel space (BTRFS_VOL_NAME_MAX).
>
> [CAUSE]
> 1. If the user does not specify the devid id explicitly,
> btrfs will use the default devid 1, so it will report an error when dev =
1 is missing.
>
> 2. The last line of the function check_resize_args is return 0.
>
> [FIX]
> 1. If the file system contains multiple devices, output an error message=
 to the user.
> If the filesystem has only one device, resize should automatically add t=
he unique devid.
>
> 2. The function check_resize_args should not return 0 on the last line,
> it should return ret representing the return value.
>
> 3. Update the "btrfs-filesystem" man page
>
> [RESULT]
>
> $ sudo btrfs filesystem resize --help
> usage: btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMgGtT=
pPeE]|[devid:]max <path>
>
>      Resize a filesystem
>
>      If the filesystem contains only one device, devid can be ignored.
>      If 'max' is passed, the filesystem will occupy all available space
>      on the device 'devid'.
>      [kK] means KiB, which denotes 1KiB =3D 1024B, 1MiB =3D 1024KiB, etc=
.
>
>      --enqueue         wait if there's another exclusive operation runni=
ng,
>                        otherwise continue
>
> $ sudo btrfs filesystem show /mnt/1/
> Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
>          Total devices 2 FS bytes used 144.00KiB
>          devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>          devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
>
> $ sudo btrfs filesystem resize -1G /mnt/1
> ERROR: The file system has multiple devices, please specify devid exactl=
y.
> ERROR: The device information list is as follows.
>          devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>          devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
>
> $ sudo btrfs device delete 2 /mnt/1/
>
> $ sudo btrfs filesystem show /mnt/1/
> Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
>          Total devices 1 FS bytes used 144.00KiB
>          devid    3 size 15.00GiB used 1.28GiB path /dev/loop3
>
> $ sudo btrfs filesystem resize -1G /mnt/1
> Resize device id 3 (/dev/loop3) from 15.00GiB to 14.00GiB
>
> $ sudo btrfs filesystem show /mnt/1/
> Label: none  uuid: cc6e1beb-255b-431f-baf5-02e8056fd0b6
>          Total devices 1 FS bytes used 144.00KiB
>          devid    3 size 14.00GiB used 1.28GiB path /dev/loop3
>
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>

AKA, there should be where the "Issue:" tag is.

Other than that, looks fine to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> V1:
>   * Automatically add devid if device is not specific
>
> V2:
>   * resize fails if filesystem has multiple devices
>
> V3:
>   * Fix incorrect behavior of function check_resize_args
>
>   * Updated resize help information
>
> V4:
>   * Update man pages
>   Documentation/btrfs-filesystem.rst | 22 ++++++++++++------
>   cmds/filesystem.c                  | 47 ++++++++++++++++++++++++++++++=
++------
>   2 files changed, 55 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/btrfs-filesystem.rst b/Documentation/btrfs-fi=
lesystem.rst
> index fe98597..5b3f2e2 100644
> --- a/Documentation/btrfs-filesystem.rst
> +++ b/Documentation/btrfs-filesystem.rst
> @@ -197,8 +197,11 @@ resize [options] [<devid>:][+/-]<size>[kKmMgGtTpPeE=
]|[<devid>:]max <path>
>                   as expected and does not resize the image. This would =
resize the underlying
>                   filesystem instead.
>
> -        The *devid* can be found in the output of **btrfs filesystem sh=
ow** and
> -        defaults to 1 if not specified.
> +        The *devid* can be found in the output of **btrfs filesystem sh=
ow**.
> +
> +        If the filesystem contains only one device, it can be
> +        resized without specifying a specific device.
> +
>           The *size* parameter specifies the new size of the filesystem.
>           If the prefix *+* or *-* is present the size is increased or d=
ecreased
>           by the quantity *size*.
> @@ -208,7 +211,7 @@ resize [options] [<devid>:][+/-]<size>[kKmMgGtTpPeE]=
|[<devid>:]max <path>
>           KiB, MiB, GiB, TiB, PiB, or EiB, respectively (case does not m=
atter).
>
>           If *max* is passed, the filesystem will occupy all available s=
pace on the
> -        device respecting *devid* (remember, devid 1 by default).
> +        device respecting *devid*.
>
>           The resize command does not manipulate the size of underlying
>           partition.  If you wish to enlarge/reduce a filesystem, you mu=
st make sure you
> @@ -413,14 +416,19 @@ even if run repeatedly.
>
>   **$ btrfs filesystem resize -1G /path**
>
> +Let's assume that filesystem contains only one device.
> +Shrink size of the filesystem's single-device by 1GiB.
> +
> +
>   **$ btrfs filesystem resize 1:-1G /path**
>
> -Shrink size of the filesystem's device id 1 by 1GiB. The first syntax e=
xpects a
> -device with id 1 to exist, otherwise fails. The second is equivalent an=
d more
> -explicit. For a single-device filesystem it's typically not necessary t=
o
> -specify the devid though.
> +Shrink size of the filesystem's device id 1 by 1GiB. This command expec=
ts a
> +device with id 1 to exist, otherwise fails.
>
>   **$ btrfs filesystem resize max /path**
> +Let's assume that filesystem contains only one device and the filesyste=
m
> +does not occupy the whole block device,By simply using *max* as size we
> +will achieve that.
>
>   **$ btrfs filesystem resize 1:max /path**
>
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 7cd08fc..e641fcb 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -1078,6 +1078,7 @@ static DEFINE_SIMPLE_COMMAND(filesystem_defrag, "d=
efragment");
>   static const char * const cmd_filesystem_resize_usage[] =3D {
>   	"btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMgGtTpPe=
E]|[devid:]max <path>",
>   	"Resize a filesystem",
> +	"If the filesystem contains only one device, devid can be ignored.",
>   	"If 'max' is passed, the filesystem will occupy all available space",
>   	"on the device 'devid'.",
>   	"[kK] means KiB, which denotes 1KiB =3D 1024B, 1MiB =3D 1024KiB, etc.=
",
> @@ -1087,7 +1088,8 @@ static const char * const cmd_filesystem_resize_us=
age[] =3D {
>   	NULL
>   };
>
> -static int check_resize_args(const char *amount, const char *path) {
> +static int check_resize_args(char * const amount, const char *path)
> +{
>   	struct btrfs_ioctl_fs_info_args fi_args;
>   	struct btrfs_ioctl_dev_info_args *di_args =3D NULL;
>   	int ret, i, dev_idx =3D -1;
> @@ -1112,11 +1114,14 @@ static int check_resize_args(const char *amount,=
 const char *path) {
>   	}
>
>   	ret =3D snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%s", amount);
> +check:
>   	if (strlen(amount) !=3D ret) {
>   		error("newsize argument is too long");
>   		ret =3D 1;
>   		goto out;
>   	}
> +	if (strcmp(amount, amount_dup) !=3D 0)
> +		strcpy(amount, amount_dup);
>
>   	sizestr =3D amount_dup;
>   	devstr =3D strchr(sizestr, ':');
> @@ -1133,6 +1138,24 @@ static int check_resize_args(const char *amount, =
const char *path) {
>   			ret =3D 1;
>   			goto out;
>   		}
> +	} else if (fi_args.num_devices !=3D 1) {
> +		error("The file system has multiple devices, please specify devid exa=
ctly.");
> +		error("The device information list is as follows.");
> +		for (i =3D 0; i < fi_args.num_devices; i++) {
> +			fprintf(stderr, "\tdevid %4llu size %s used %s path %s\n",
> +				di_args[i].devid,
> +				pretty_size_mode(di_args[i].total_bytes, UNITS_DEFAULT),
> +				pretty_size_mode(di_args[i].bytes_used, UNITS_DEFAULT),
> +				di_args[i].path);
> +		}
> +		ret =3D 1;
> +		goto out;
> +	} else {
> +		memset(amount_dup, 0, BTRFS_VOL_NAME_MAX);
> +		ret =3D snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%llu:", di_args[0].=
devid);
> +		ret =3D snprintf(amount_dup + strlen(amount_dup),
> +			BTRFS_VOL_NAME_MAX - strlen(amount_dup), "%s", amount);
> +		goto check;
>   	}
>
>   	dev_idx =3D -1;
> @@ -1200,10 +1223,11 @@ static int check_resize_args(const char *amount,=
 const char *path) {
>   		di_args[dev_idx].path,
>   		pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFAULT),
>   		res_str);
> +	ret =3D 0;
>
>   out:
>   	free(di_args);
> -	return 0;
> +	return ret;
>   }
>
>   static int cmd_filesystem_resize(const struct cmd_struct *cmd,
> @@ -1213,7 +1237,7 @@ static int cmd_filesystem_resize(const struct cmd_=
struct *cmd,
>   	int	fd, res, len, e;
>   	char	*amount, *path;
>   	DIR	*dirstream =3D NULL;
> -	int ret;
> +	int ret =3D 0;
>   	bool enqueue =3D false;
>   	bool cancel =3D false;
>
> @@ -1277,10 +1301,17 @@ static int cmd_filesystem_resize(const struct cm=
d_struct *cmd,
>   		}
>   	}
>
> +	amount =3D (char *)malloc(BTRFS_VOL_NAME_MAX);
> +	if (!amount)
> +		return -ENOMEM;
> +
> +	strcpy(amount, argv[optind]);
> +
>   	ret =3D check_resize_args(amount, path);
>   	if (ret !=3D 0) {
>   		close_file_or_dir(fd, dirstream);
> -		return 1;
> +		ret =3D 1;
> +		goto free_amount;
>   	}
>
>   	memset(&args, 0, sizeof(args));
> @@ -1298,7 +1329,7 @@ static int cmd_filesystem_resize(const struct cmd_=
struct *cmd,
>   			error("unable to resize '%s': %m", path);
>   			break;
>   		}
> -		return 1;
> +		ret =3D 1;
>   	} else if (res > 0) {
>   		const char *err_str =3D btrfs_err_str(res);
>
> @@ -1308,9 +1339,11 @@ static int cmd_filesystem_resize(const struct cmd=
_struct *cmd,
>   			error("resizing of '%s' failed: unknown error %d",
>   				path, res);
>   		}
> -		return 1;
> +		ret =3D 1;
>   	}
> -	return 0;
> +free_amount:
> +	free(amount);
> +	return ret;
>   }
>   static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
>
