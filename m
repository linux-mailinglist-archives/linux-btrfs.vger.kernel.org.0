Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D7557F7CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 02:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiGYAeu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jul 2022 20:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYAet (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jul 2022 20:34:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D76511A1E
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658709282;
        bh=5L143YGpDhqmwJraZzyGgAeIwjTrfTFBV5JP95Xv7TA=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=MdSlLkGvedD/fsHu2C5q17uCBKC0IBxVdoeAxwlhJftTgvtTOJEdAZ7syqqoKqTJU
         fk2BSCLyr9MSEL0pxP8GXSok8WtUzA+qbKRAukg63PqQhbI81DTcosXUdv1Tgl17sT
         rR+ElI80nrYKM96FQYUZSlNKw6bgsL7iCOj0y1ww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9g4-1oGrS10vxE-00GdS2; Mon, 25
 Jul 2022 02:34:41 +0200
Message-ID: <d6a18603-6bba-0eb3-a8d0-e341afaf37f5@gmx.com>
Date:   Mon, 25 Jul 2022 08:34:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1658666627-27889-1-git-send-email-zhanglikernel@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3] btrfs-progs: fix btrfs resize failed.
In-Reply-To: <1658666627-27889-1-git-send-email-zhanglikernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G+B6lyj/urNOypkZvpLj7KAPliazc2XqGGvvZWvVUJfY44Aai1X
 SOlWvfRC70cEKy+C/8gyjc/1rDjF4EBP8IKmxF2n622V4jYK6XLtBnl7h7y8R5XZ7FNWzTW
 /NlqhsCIxUXhOnxbvu84osk34xkDeZuFpZbP+NrRXaBucKlL0urEK+CXU3O3axgwFTtmi5f
 +D5o/JLwOkoEDGAi9828w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ar/5AY406Ak=:/165mkwgwj2CzqHS+cVC/e
 4RqIx7Z7Ad4E4fVjG/7dPpWY2vBmECqOZaPU4GcuoneiF783Cw+Vu1P1c36hvHuAySVMCklpR
 LBydZ/jkiJ+9JKCOZVgkHPJxn35Q88+KkjDJ6M78mKigPy9hZagdueS72L6vItstJY4/IgYs1
 sydpwo1Dbi/2twwDjKxmhFd+SvPAre8M6wyKd2FbvhgZJ5owMtGkVBBi3ks7I0CIAWQLDOQAf
 /7kXEptfmrijWoPXInj+fJY7eUQnaq6TQthTHquRF/j7P1NEF6h9Uq0LjfDYkWDsYRGxtGu3m
 gfr5piwFlQWntfI9dKDVK6I0w2UflBlS5Lw9k5bUuEaU1LPfP1T9nTNwgbLPh4BWwXvqm0Bn5
 9ga5uV7XJjZmYZTZx2KtQhbEZ4D4xDvZcZnm3IxM4GylxRRp2k/AGe7ImWIWAf46pt/WPjigw
 MBjQBfgjG5yvD4f2p625FXLJDh3kfsjnYiGh8blHq2yHiSlxFHt/MCdlOsphK+USiKpmtQRwK
 jmBh2xk1Qr7TYUmU4JOmvuDjGaJiAoaAlXLjNvbaBhL/Zjy5Oe+q+/sEf5B/5YLUsN/CzPM6h
 QQofSasUH0LhzHIBEQOY+YPjCiwC8pCQXjSYK9mR1vzreQzNm0pLrfNUgNAHSpkZTwbFlcqu9
 wToH/1NjYAtVM1YWSmC4W55Az6qaNM2Bkit6NmK4ywQGWwg36MIURXBV+UkzhFiZbW4t1oMjX
 ulR52defYQYMFrQxKIOo64pqk+A43Zl6tZgZyM3Sqze5c8LcEcvF+xjjFeKcOp36oUanLX0cb
 AzP40HfF37rutDM27V1Yzk6A5bYlPlDTpiv12/TFn6EAh0yXJ6ohbEcxC+9T9y8RA0F4/EHuK
 tQpYXjGABFt/KlI3x2VMym+G2jNvlOrnZ+GVvT98vVmiHg/ls4OTIDbyduiC360y3os0kijsy
 XjVNyvPkXuZ6QcqIU28SfGlusADQxeubwzNr3cvrW/7xsl1CNgjZtRLiqKMkakZhpOV6DfGXA
 NZ/mk9uRvvuVrFZKe6ref7tHxR2VwGqp/iouheBuIfhXy7g5bq1VpNiVw5NoPa+EM5maYhc83
 QVJaGDQVfJrv01nxRtQA0zWP6X0UIL4dqMLfLTbJrVqsbRPVFyTQRtZ7w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/24 20:43, Li Zhang wrote:
> related issuse:
> https://github.com/kdave/btrfs-progs/issues/470

Something I forgot to mention is related to the changelog part.

This can be replaced by the following tag before SOB line:

Issue: 470

>
> V1 link:
> https://www.spinics.net/lists/linux-btrfs/msg126661.html
>
> V2 link:
> https://www.spinics.net/lists/linux-btrfs/msg126853.html

Changelog for single patch can be put after all the tags, and with a
line of "---", so at apply time git will discard the extra info.

One example can be found here:

https://lore.kernel.org/linux-btrfs/20220617151133.GO20633@twin.jikos.cz/T=
/

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

Although help string is updated, the manpage is still not updated.

Thanks,
Qu

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
> 	Total devices 1 FS bytes used 144.00KiB
> 	devid    3 size 14.00GiB used 1.28GiB path /dev/loop3
>
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
>   cmds/filesystem.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 40 insertions(+), 7 deletions(-)
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
