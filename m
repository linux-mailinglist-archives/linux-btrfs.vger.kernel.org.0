Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EFC57792F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 03:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiGRBQ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jul 2022 21:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiGRBQ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jul 2022 21:16:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D411806
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jul 2022 18:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658107010;
        bh=8I3ip1Rp21+OI5dl4lDtpSNo8jjMFoYbb9MEVrSojUA=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=cnY0HZ8gMThf+4lWBAHpWO2cCpK2NG13EesP04ZcV7u0d9nvZwxL0zOyJjTIKIW/l
         HcjUYRoqYTHHq5giAqo8aezAO2p7+WY3F7cklDEME1kriXkpK+QmikwvpT6DcaKQTm
         QHkkpOmtVKCMWIUdEkGe6/Wkv2lsO87ikNFHag24=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtfJX-1nOJWI2RlH-00v7aD; Mon, 18
 Jul 2022 03:16:50 +0200
Message-ID: <42fe2853-87a5-625c-7808-3f7af8c7ec37@gmx.com>
Date:   Mon, 18 Jul 2022 09:16:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Li Zhang <zhanglikernel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <1658070503-25238-1-git-send-email-zhanglikernel@gmail.com>
 <YtRJT+J2W/Z4G/gS@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs-progs: resize: automatically add devid if device is
 not specifically
In-Reply-To: <YtRJT+J2W/Z4G/gS@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s9SgSHV6cVKcVqGCLjz6sYu9vbcks00atnIeOxFwRprgC2ANogv
 ECDdCXLcE8agfwC73pXYkmPln0S5x98pe/QjoyB6AqXD0G2fYeXHGN/VXw269y0C/rSLAbb
 tkfvgVLNOf3vI/F8l6ox1qb7eZQaVoy38MhgMxcEHIsVRLjWAtX/TPZ0BG7YzKR9xjglorx
 kEijEUJ5JGrtuhI5xr8TQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AFLydae3jh8=:BNmaanZi4D7v+Vame1f4Uz
 dmyyRBfuoEO0F9TTZ8aXgf1aOiWCv/IR8FSaqzG6cn9+l1csPWcPNGa0BF8FfcHAL1IJ0UuPr
 4Oxsns610uMN24tcG5tZ5DEhiGIlf4J+Jw3kEUt4KpWFRy1+7R73ud5uPK0CgnqhZ5sgvgZOf
 adHK+Uxt9ehxHW8By+JfWB26UwZ84kwfPOICGHJ4d8o6rtX8kG3w5OZnDeF4ziUfOZuar0bt5
 0g4E64GaY7McDQ+DAjNHiTXqhZliUy/6F4dYriroVs9MC7doMxru1ampUwGYGY3igXdxUJsX9
 I6ZyNY4AmetHFRxQczgl9uSTxMHQ3nJ7NnOVkaZcj4aYw60/s80hgkyEvYEu84EXyR4PNuSWK
 Sn7KKn5fsSCYaBoiPh3ZxXbtulqtM+reYnLhNig+lYYa55h+DlVMcsRMI1y2OFXZHtH/81T7i
 OHX3yiyI/ZZLfVovR+Bi5ugxLQocGmJOHKB7sS+eHTjwXr8/cM/vqJ8TcDbsdP+zQvruLQPDc
 T4ck5BCmfzPC+LBTHs4jLNNP/yYQG3PLCKtts/pfUs1T82EaXMULTKSEAR6qIq9WvapzSkqHP
 itU6qoPIInPprKdB0EcFD/itb/YTKL/dM8BhtVXyp1LVJX/vdFQG4SGHMfdUo8ywauOuh5Eln
 tp5aa+rbj+jp7fICKxuTLXV3zkmO57K8FCr6neZUDATBOI9xanSPakNbezyAoToCbDzuHnxDT
 6n/aeSdXmH5dtyN0tM9jhLGRJmnfohFDYUA0mn0mIVQKRbb4ElkcREHDhROtE1izuOUCp+oyC
 aXNoDhA2TU+h3cpIV8oFMnIAb9gPA9rCcZYo5o8oqekZGVm1cKuQ5/lZ+XXQnuqzSeXcDWuGU
 PmC5h5KHCHQxmPwISQWDTY04JutmtYvd14SCm/Zz6o4DQAs4oMkBfNjfnjZIf1OGVgvZ59NQv
 6kS3SGzf2CwyzS1zEe926W9fCQBRBpQLJuGkzjRWiKE/of7QLOq3cOZ3H/CQ/Ck4KRUw3+c43
 MyYrFgXgQNVUPpwc+W6tNYQWyVqap/DGKXMhosX3kfVqGE+5VckczN+R6YPfruEnD6u5ne49d
 01X4+4JM97UUuzccnA6qJcchHCXCMBKQvddnhSoBfxkHONcyVNTBz/Tdg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/18 01:39, Zygo Blaxell wrote:
> On Sun, Jul 17, 2022 at 11:08:23PM +0800, Li Zhang wrote:
>> related issues:
>> https://github.com/kdave/btrfs-progs/issues/470
>>
>> [BUG]
>> If there is no devid=3D1, when the user uses the btrfs file system tool=
, the following error will be reported,
>>
>> $ sudo btrfs filesystem show /mnt/1
>> Label: none  uuid: 64dc0f68-9afa-4465-9ea1-2bbebfdb6cec
>>      Total devices 2 FS bytes used 704.00KiB
>>      devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>>      devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
>> $ sudo btrfs filesystem resize -1G /mnt/1
>> ERROR: cannot find devid: 1
>> ERROR: unable to resize '/mnt/1': No such device
>>
>> [CAUSE]
>> If the user does not specify the devid id explicitly, btrfs will use th=
e default devid 1, so it will report an error when dev 1 is missing.
>>
>> [FIX]
>> If there is no special devid, the first devid is added automatically an=
d check the maximum length of args passed to kernel space.
>> After patch, when resize filesystem without specified, it would resize =
the first device, the result is list as following.
>>
>> $ sudo btrfs filesystem show /mnt/1/
>> Label: none  uuid: 7b4827da-bc6e-42aa-b03d-52c2533dfe94
>>      Total devices 2 FS bytes used 144.00KiB
>>      devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>>      devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
>>
>> $ sudo btrfs filesystem resize -1G /mnt/1
>> Resize device id 2 (/dev/loop2) from 15.00GiB to 14.00GiB
>> $ sudo btrfs filesystem show /mnt/1/
>> Label: none  uuid: 7b4827da-bc6e-42aa-b03d-52c2533dfe94
>>      Total devices 2 FS bytes used 144.00KiB
>>      devid    2 size 14.00GiB used 1.16GiB path /dev/loop2
>>      devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
>
> Is that desirable behavior?  I'd expect that if there are multiple
> devices present, and I haven't specified which one to resize, that the
> command would fail with an error, requiring me to specify which device I
> want resized.  Under that expectation, the current behavior of resizing
> devid 1 by default is also incorrect.

I agree with Zygo.

If there is only one device, then we can definitely use the first device
we find.

If there are multiple devices, then it's better to output an error
message, provide candidate devids, and error out.

Thanks,
Qu

>
> If there's only one device, then 'btrfs fi resize -1G' should resize
> that device, since no ambiguity is possible.
>
>> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
>> ---
>>   cmds/filesystem.c | 49 ++++++++++++++++++++++++++++++++++++++--------=
---
>>   1 file changed, 38 insertions(+), 11 deletions(-)
>>
>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
>> index 7cd08fc..2e2414d 100644
>> --- a/cmds/filesystem.c
>> +++ b/cmds/filesystem.c
>> @@ -1087,7 +1087,8 @@ static const char * const cmd_filesystem_resize_u=
sage[] =3D {
>>   	NULL
>>   };
>>
>> -static int check_resize_args(const char *amount, const char *path) {
>> +static int check_resize_args(char * const amount, const char *path)
>> +{
>>   	struct btrfs_ioctl_fs_info_args fi_args;
>>   	struct btrfs_ioctl_dev_info_args *di_args =3D NULL;
>>   	int ret, i, dev_idx =3D -1;
>> @@ -1102,7 +1103,8 @@ static int check_resize_args(const char *amount, =
const char *path) {
>>
>>   	if (ret) {
>>   		error("unable to retrieve fs info");
>> -		return 1;
>> +		ret =3D 1;
>> +		goto out;
>>   	}
>>
>>   	if (!fi_args.num_devices) {
>> @@ -1112,11 +1114,14 @@ static int check_resize_args(const char *amount=
, const char *path) {
>>   	}
>>
>>   	ret =3D snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%s", amount);
>> +check:
>>   	if (strlen(amount) !=3D ret) {
>>   		error("newsize argument is too long");
>>   		ret =3D 1;
>>   		goto out;
>>   	}
>> +	if (strcmp(amount, amount_dup) !=3D 0)
>> +		strcpy(amount, amount_dup);
>>
>>   	sizestr =3D amount_dup;
>>   	devstr =3D strchr(sizestr, ':');
>> @@ -1137,6 +1142,13 @@ static int check_resize_args(const char *amount,=
 const char *path) {
>>
>>   	dev_idx =3D -1;
>>   	for(i =3D 0; i < fi_args.num_devices; i++) {
>> +		if (!devstr) {
>> +			memset(amount_dup, 0, BTRFS_VOL_NAME_MAX);
>> +			ret =3D snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%llu:", di_args[i=
].devid);
>> +			ret =3D snprintf(amount_dup + strlen(amount_dup),
>> +				BTRFS_VOL_NAME_MAX - strlen(amount_dup), "%s", amount);
>> +			goto check;
>> +		}
>>   		if (di_args[i].devid =3D=3D devid) {
>>   			dev_idx =3D i;
>>   			break;
>> @@ -1235,8 +1247,10 @@ static int cmd_filesystem_resize(const struct cm=
d_struct *cmd,
>>   		}
>>   	}
>>
>> -	if (check_argc_exact(argc - optind, 2))
>> -		return 1;
>> +	if (check_argc_exact(argc - optind, 2)) {
>> +		ret =3D 1;
>> +		goto out;
>> +	}
>>
>>   	amount =3D argv[optind];
>>   	path =3D argv[optind + 1];
>> @@ -1244,7 +1258,8 @@ static int cmd_filesystem_resize(const struct cmd=
_struct *cmd,
>>   	len =3D strlen(amount);
>>   	if (len =3D=3D 0 || len >=3D BTRFS_VOL_NAME_MAX) {
>>   		error("resize value too long (%s)", amount);
>> -		return 1;
>> +		ret =3D 1;
>> +		goto out;
>>   	}
>>
>>   	cancel =3D (strcmp("cancel", amount) =3D=3D 0);
>> @@ -1258,7 +1273,8 @@ static int cmd_filesystem_resize(const struct cmd=
_struct *cmd,
>>   		"directories as argument. Passing file containing a btrfs image\n"
>>   		"would resize the underlying filesystem instead of the image.\n");
>>   		}
>> -		return 1;
>> +		ret =3D 1;
>> +		goto out;
>>   	}
>>
>>   	/*
>> @@ -1273,14 +1289,22 @@ static int cmd_filesystem_resize(const struct c=
md_struct *cmd,
>>   				error(
>>   			"unable to check status of exclusive operation: %m");
>>   			close_file_or_dir(fd, dirstream);
>> -			return 1;
>> +			goto out;
>>   		}
>>   	}
>>
>> +	amount =3D (char *)malloc(BTRFS_VOL_NAME_MAX);
>> +	if (!amount) {
>> +		ret =3D -ENOMEM;
>> +		goto out;
>> +	}
>> +	strcpy(amount, argv[optind]);
>> +
>>   	ret =3D check_resize_args(amount, path);
>>   	if (ret !=3D 0) {
>>   		close_file_or_dir(fd, dirstream);
>> -		return 1;
>> +		ret =3D 1;
>> +		goto free_amount;
>>   	}
>>
>>   	memset(&args, 0, sizeof(args));
>> @@ -1298,7 +1322,7 @@ static int cmd_filesystem_resize(const struct cmd=
_struct *cmd,
>>   			error("unable to resize '%s': %m", path);
>>   			break;
>>   		}
>> -		return 1;
>> +		ret =3D 1;
>>   	} else if (res > 0) {
>>   		const char *err_str =3D btrfs_err_str(res);
>>
>> @@ -1308,9 +1332,12 @@ static int cmd_filesystem_resize(const struct cm=
d_struct *cmd,
>>   			error("resizing of '%s' failed: unknown error %d",
>>   				path, res);
>>   		}
>> -		return 1;
>> +		ret =3D 1;
>>   	}
>> -	return 0;
>> +free_amount:
>> +	free(amount);
>> +out:
>> +	return ret;
>>   }
>>   static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
>>
>> --
>> 1.8.3.1
>>
