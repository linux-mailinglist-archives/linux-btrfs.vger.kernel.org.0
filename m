Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92453580AA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 07:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiGZFEs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 01:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiGZFEr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 01:04:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A30F27B1B
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 22:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658811883;
        bh=u13SbHS+ze27c9GftvIoCmhQkhaXONRjEP+gRPA0g1c=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=VN+PBdy6v8lopsZxk/lY4D0m1h0Qj6C2fdlPO073EpKcNlVtssMqd+UHRELeItQaB
         QFWQPJf52DC6KLNgkPuOarYMnSMtxG2X7vKKyjJABQwYOLPTq6LPq+BlvNThGX3/+1
         VQO8/M6PvAiywu8qniRNT42wQdBIb0vBW0KfJWtg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTzf6-1o6knY0ELK-00R0aP; Tue, 26
 Jul 2022 07:04:42 +0200
Message-ID: <c806c638-a02b-3bd6-f9cc-d3acb147cd63@gmx.com>
Date:   Tue, 26 Jul 2022 13:04:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4] btrfs-progs: fix btrfs resize failed.
Content-Language: en-US
To:     li zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1658767574-16160-1-git-send-email-zhanglikernel@gmail.com>
 <d8fea112-ca92-ca08-0d26-405ca8f75ccc@gmx.com>
 <CAAa-AGkTjLmy2VssSfEdbjCExKPkrdMe7nn4bXe37FSZZ9fv=A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAAa-AGkTjLmy2VssSfEdbjCExKPkrdMe7nn4bXe37FSZZ9fv=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QDUGTTl8rS+LfY1WtjxXMIpschvNCiNUz+0bduP9gUZ3naBqX9E
 63DuUQwMBiqjGW8GPuoEHeImH3V3QVEYyNZ/UQ4sGkqKx0aNGU7ltW+pOcKt1tDlEN/T+bO
 VfYKytPHb8uMoVpxa1T7URTl3rma1OesIXtwCp3mHPixaTqyMAaMm5JFFSRJpL1WKJZdBVU
 tOOVGaiJvJn9tdPRdD0zA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jgOFOM6t0gA=:bxQF/Ib7txnLqHj+tIlMZF
 vFNRT9J1cDi3Y03CoT4/H9EnRX0sKhQ+VMHMznNSNqLYlwQWnytZfiW5iHNDUtsUt8lCbaiqN
 lHbM1ohZ8bNYjDA8vFugnjX0arWE1+eqBNUeHyR21DCt8RXtj0gPe9pEca5fOe5bZxWK+D8M1
 dLegsOLErMcvQ1wev2aXNny7/YO9uOu/XyC41UV5aWc0drM3BAaWVaJL+6nRWHuQ+e4yQGkLd
 kynpkFaikLi1zmC40hBm3INe5gu0uEJZzE7GDCJcOcwuXPEfPRA7Ym/HiZ62tD1czjhbMpjK0
 xEF6V40JNOBEijVp3jTW0HuQYQzBdRMHLqp3fmm4xS/rfHqi6VdsiynC2XLOdvK+QiPYNbTFG
 sGy9jT6YWi61aglA7mHUwDV5VroP5Sw3uwKksmlWQT5xvRVn21yjKHN9ep/GvmmhqyLFykS6F
 9q936sSBbLN4dn1Kg4CAe72wM/Ynrx9Ftstapwr7H9UGbsuR3gusn3P7K6JeMMfpduHD5eeId
 lXHb4M0J16djwEUJHHtRiEpSPWfRpJCZBFehFyF+Go6JevoYdPBg0UznB4SR/G8Hxg7sOrRTm
 7WB7xRPH2a65P4nMQBgw6SGsRCgkLb7HE+qVUJx4/2sTdMW6VVHbLdWb6UAugZmN+s7nw1VdB
 IsZNE06KGD9Rs3ChabGutH/cyMEnK3avkLowZlzkQDdGplBp9Lr+7/u9LnGd6Rv9udaY8Mm1x
 KBhxR6ItlzH4sVSkabPCttIJjHF9dv1PokMfa0D3HAENrsgq8bipj7AE6gurMYl1Z3tYg6Vj5
 6MljVOXsoCdGgQC2yACJ6/SwubtWl8USeSqgc1iKwgEWPCr3I0SEOpsIwa6y8aQEzMSg0Pm2J
 8gVkXIPZRlgQVprF3uWV4agkwMhaj195uXTqHNQYZqivUuB+9m8ibCypgmw4QdvxYsXDigUX7
 ixnjEPBvV567B3QoOejvENJFDU9ln3AiEupECy4byVkejyrVnqBb1OEYYnQJE2BDFu4j3bLs0
 fDbu0UadncdScEWmJS37emcR25empbsLKW2o8F+GYc5eoUKsUtcz+58x9broRONauxDrsOVUr
 7QH5wD8YjI4UOq2y3FHunEwlu8QdroVcoR9Nk7M3c8e5RSR25lZgT3iGQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/26 12:56, li zhang wrote:
> Hi, I have another question, issue 471, extending resizing to support
> the parameter all to represent all devices, I agree this should
> iterate over all devices in userspace as it works on older kernel
> versions. But what happens if the command fails?

Just error out at the failed device, and print a proper error message.

> For example, if the
> filesystem contains 3 devices, 2 of them resize successfully and the
> last one fails, in this case I mean the whole command should fail,

Yes, the command should fail, even if some devices have been resized
successfully.

> which means it's better to put these 3 resize subcommands in a
> transaction. So I'm stuck in a dilemma whether to implement all device
> resizing in user space or kernel space.

I still prefer to do it inside user space.

I don't think there is anything wrong if we resized some devices but not
all, we still return an error.

Sure, it's better to output some messages to indicate that some devices
have been resized, other than that, I see no problem at all.

Thanks,
Qu

>
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=BA=8C 09:28=E5=86=99=E9=81=93=EF=BC=9A
>>
>>
>>
>> On 2022/7/26 00:46, Li Zhang wrote:
>>> Issue: 470
>>
>> This should be moved AFTER the SOB line.
>>>
>>> [BUG]
>>> 1. If there is no devid=3D1, when the user uses the btrfs file system =
tool,
>>> the following error will be reported,
>>>
>>> $ sudo btrfs filesystem show /mnt/1
>>> Label: none  uuid: 64dc0f68-9afa-4465-9ea1-2bbebfdb6cec
>>>       Total devices 2 FS bytes used 704.00KiB
>>>       devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>>>       devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
>>> $ sudo btrfs filesystem resize -1G /mnt/1
>>> ERROR: cannot find devid: 1
>>> ERROR: unable to resize '/mnt/1': No such device
>>>
>>> 2. Function check_resize_args, if get_fs_info is successful,
>>> check_resize_args always returns 0, Even if the parameter
>>> passed to kernel space is longer than the size allowed to
>>> be passed to kernel space (BTRFS_VOL_NAME_MAX).
>>>
>>> [CAUSE]
>>> 1. If the user does not specify the devid id explicitly,
>>> btrfs will use the default devid 1, so it will report an error when de=
v 1 is missing.
>>>
>>> 2. The last line of the function check_resize_args is return 0.
>>>
>>> [FIX]
>>> 1. If the file system contains multiple devices, output an error messa=
ge to the user.
>>> If the filesystem has only one device, resize should automatically add=
 the unique devid.
>>>
>>> 2. The function check_resize_args should not return 0 on the last line=
,
>>> it should return ret representing the return value.
>>>
>>> 3. Update the "btrfs-filesystem" man page
>>>
>>> [RESULT]
>>>
>>> $ sudo btrfs filesystem resize --help
>>> usage: btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMgG=
tTpPeE]|[devid:]max <path>
>>>
>>>       Resize a filesystem
>>>
>>>       If the filesystem contains only one device, devid can be ignored=
.
>>>       If 'max' is passed, the filesystem will occupy all available spa=
ce
>>>       on the device 'devid'.
>>>       [kK] means KiB, which denotes 1KiB =3D 1024B, 1MiB =3D 1024KiB, =
etc.
>>>
>>>       --enqueue         wait if there's another exclusive operation ru=
nning,
>>>                         otherwise continue
>>>
>>> $ sudo btrfs filesystem show /mnt/1/
>>> Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
>>>           Total devices 2 FS bytes used 144.00KiB
>>>           devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>>>           devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
>>>
>>> $ sudo btrfs filesystem resize -1G /mnt/1
>>> ERROR: The file system has multiple devices, please specify devid exac=
tly.
>>> ERROR: The device information list is as follows.
>>>           devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>>>           devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
>>>
>>> $ sudo btrfs device delete 2 /mnt/1/
>>>
>>> $ sudo btrfs filesystem show /mnt/1/
>>> Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
>>>           Total devices 1 FS bytes used 144.00KiB
>>>           devid    3 size 15.00GiB used 1.28GiB path /dev/loop3
>>>
>>> $ sudo btrfs filesystem resize -1G /mnt/1
>>> Resize device id 3 (/dev/loop3) from 15.00GiB to 14.00GiB
>>>
>>> $ sudo btrfs filesystem show /mnt/1/
>>> Label: none  uuid: cc6e1beb-255b-431f-baf5-02e8056fd0b6
>>>           Total devices 1 FS bytes used 144.00KiB
>>>           devid    3 size 14.00GiB used 1.28GiB path /dev/loop3
>>>
>>> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
>>
>> AKA, there should be where the "Issue:" tag is.
>>
>> Other than that, looks fine to me.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks,
>> Qu
>>> ---
>>> V1:
>>>    * Automatically add devid if device is not specific
>>>
>>> V2:
>>>    * resize fails if filesystem has multiple devices
>>>
>>> V3:
>>>    * Fix incorrect behavior of function check_resize_args
>>>
>>>    * Updated resize help information
>>>
>>> V4:
>>>    * Update man pages
>>>    Documentation/btrfs-filesystem.rst | 22 ++++++++++++------
>>>    cmds/filesystem.c                  | 47 +++++++++++++++++++++++++++=
+++++------
>>>    2 files changed, 55 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/Documentation/btrfs-filesystem.rst b/Documentation/btrfs-=
filesystem.rst
>>> index fe98597..5b3f2e2 100644
>>> --- a/Documentation/btrfs-filesystem.rst
>>> +++ b/Documentation/btrfs-filesystem.rst
>>> @@ -197,8 +197,11 @@ resize [options] [<devid>:][+/-]<size>[kKmMgGtTpP=
eE]|[<devid>:]max <path>
>>>                    as expected and does not resize the image. This wou=
ld resize the underlying
>>>                    filesystem instead.
>>>
>>> -        The *devid* can be found in the output of **btrfs filesystem =
show** and
>>> -        defaults to 1 if not specified.
>>> +        The *devid* can be found in the output of **btrfs filesystem =
show**.
>>> +
>>> +        If the filesystem contains only one device, it can be
>>> +        resized without specifying a specific device.
>>> +
>>>            The *size* parameter specifies the new size of the filesyst=
em.
>>>            If the prefix *+* or *-* is present the size is increased o=
r decreased
>>>            by the quantity *size*.
>>> @@ -208,7 +211,7 @@ resize [options] [<devid>:][+/-]<size>[kKmMgGtTpPe=
E]|[<devid>:]max <path>
>>>            KiB, MiB, GiB, TiB, PiB, or EiB, respectively (case does no=
t matter).
>>>
>>>            If *max* is passed, the filesystem will occupy all availabl=
e space on the
>>> -        device respecting *devid* (remember, devid 1 by default).
>>> +        device respecting *devid*.
>>>
>>>            The resize command does not manipulate the size of underlyi=
ng
>>>            partition.  If you wish to enlarge/reduce a filesystem, you=
 must make sure you
>>> @@ -413,14 +416,19 @@ even if run repeatedly.
>>>
>>>    **$ btrfs filesystem resize -1G /path**
>>>
>>> +Let's assume that filesystem contains only one device.
>>> +Shrink size of the filesystem's single-device by 1GiB.
>>> +
>>> +
>>>    **$ btrfs filesystem resize 1:-1G /path**
>>>
>>> -Shrink size of the filesystem's device id 1 by 1GiB. The first syntax=
 expects a
>>> -device with id 1 to exist, otherwise fails. The second is equivalent =
and more
>>> -explicit. For a single-device filesystem it's typically not necessary=
 to
>>> -specify the devid though.
>>> +Shrink size of the filesystem's device id 1 by 1GiB. This command exp=
ects a
>>> +device with id 1 to exist, otherwise fails.
>>>
>>>    **$ btrfs filesystem resize max /path**
>>> +Let's assume that filesystem contains only one device and the filesys=
tem
>>> +does not occupy the whole block device,By simply using *max* as size =
we
>>> +will achieve that.
>>>
>>>    **$ btrfs filesystem resize 1:max /path**
>>>
>>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
>>> index 7cd08fc..e641fcb 100644
>>> --- a/cmds/filesystem.c
>>> +++ b/cmds/filesystem.c
>>> @@ -1078,6 +1078,7 @@ static DEFINE_SIMPLE_COMMAND(filesystem_defrag, =
"defragment");
>>>    static const char * const cmd_filesystem_resize_usage[] =3D {
>>>        "btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMg=
GtTpPeE]|[devid:]max <path>",
>>>        "Resize a filesystem",
>>> +     "If the filesystem contains only one device, devid can be ignore=
d.",
>>>        "If 'max' is passed, the filesystem will occupy all available s=
pace",
>>>        "on the device 'devid'.",
>>>        "[kK] means KiB, which denotes 1KiB =3D 1024B, 1MiB =3D 1024KiB=
, etc.",
>>> @@ -1087,7 +1088,8 @@ static const char * const cmd_filesystem_resize_=
usage[] =3D {
>>>        NULL
>>>    };
>>>
>>> -static int check_resize_args(const char *amount, const char *path) {
>>> +static int check_resize_args(char * const amount, const char *path)
>>> +{
>>>        struct btrfs_ioctl_fs_info_args fi_args;
>>>        struct btrfs_ioctl_dev_info_args *di_args =3D NULL;
>>>        int ret, i, dev_idx =3D -1;
>>> @@ -1112,11 +1114,14 @@ static int check_resize_args(const char *amoun=
t, const char *path) {
>>>        }
>>>
>>>        ret =3D snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%s", amount);
>>> +check:
>>>        if (strlen(amount) !=3D ret) {
>>>                error("newsize argument is too long");
>>>                ret =3D 1;
>>>                goto out;
>>>        }
>>> +     if (strcmp(amount, amount_dup) !=3D 0)
>>> +             strcpy(amount, amount_dup);
>>>
>>>        sizestr =3D amount_dup;
>>>        devstr =3D strchr(sizestr, ':');
>>> @@ -1133,6 +1138,24 @@ static int check_resize_args(const char *amount=
, const char *path) {
>>>                        ret =3D 1;
>>>                        goto out;
>>>                }
>>> +     } else if (fi_args.num_devices !=3D 1) {
>>> +             error("The file system has multiple devices, please spec=
ify devid exactly.");
>>> +             error("The device information list is as follows.");
>>> +             for (i =3D 0; i < fi_args.num_devices; i++) {
>>> +                     fprintf(stderr, "\tdevid %4llu size %s used %s p=
ath %s\n",
>>> +                             di_args[i].devid,
>>> +                             pretty_size_mode(di_args[i].total_bytes,=
 UNITS_DEFAULT),
>>> +                             pretty_size_mode(di_args[i].bytes_used, =
UNITS_DEFAULT),
>>> +                             di_args[i].path);
>>> +             }
>>> +             ret =3D 1;
>>> +             goto out;
>>> +     } else {
>>> +             memset(amount_dup, 0, BTRFS_VOL_NAME_MAX);
>>> +             ret =3D snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%llu:"=
, di_args[0].devid);
>>> +             ret =3D snprintf(amount_dup + strlen(amount_dup),
>>> +                     BTRFS_VOL_NAME_MAX - strlen(amount_dup), "%s", a=
mount);
>>> +             goto check;
>>>        }
>>>
>>>        dev_idx =3D -1;
>>> @@ -1200,10 +1223,11 @@ static int check_resize_args(const char *amoun=
t, const char *path) {
>>>                di_args[dev_idx].path,
>>>                pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DE=
FAULT),
>>>                res_str);
>>> +     ret =3D 0;
>>>
>>>    out:
>>>        free(di_args);
>>> -     return 0;
>>> +     return ret;
>>>    }
>>>
>>>    static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>>> @@ -1213,7 +1237,7 @@ static int cmd_filesystem_resize(const struct cm=
d_struct *cmd,
>>>        int     fd, res, len, e;
>>>        char    *amount, *path;
>>>        DIR     *dirstream =3D NULL;
>>> -     int ret;
>>> +     int ret =3D 0;
>>>        bool enqueue =3D false;
>>>        bool cancel =3D false;
>>>
>>> @@ -1277,10 +1301,17 @@ static int cmd_filesystem_resize(const struct =
cmd_struct *cmd,
>>>                }
>>>        }
>>>
>>> +     amount =3D (char *)malloc(BTRFS_VOL_NAME_MAX);
>>> +     if (!amount)
>>> +             return -ENOMEM;
>>> +
>>> +     strcpy(amount, argv[optind]);
>>> +
>>>        ret =3D check_resize_args(amount, path);
>>>        if (ret !=3D 0) {
>>>                close_file_or_dir(fd, dirstream);
>>> -             return 1;
>>> +             ret =3D 1;
>>> +             goto free_amount;
>>>        }
>>>
>>>        memset(&args, 0, sizeof(args));
>>> @@ -1298,7 +1329,7 @@ static int cmd_filesystem_resize(const struct cm=
d_struct *cmd,
>>>                        error("unable to resize '%s': %m", path);
>>>                        break;
>>>                }
>>> -             return 1;
>>> +             ret =3D 1;
>>>        } else if (res > 0) {
>>>                const char *err_str =3D btrfs_err_str(res);
>>>
>>> @@ -1308,9 +1339,11 @@ static int cmd_filesystem_resize(const struct c=
md_struct *cmd,
>>>                        error("resizing of '%s' failed: unknown error %=
d",
>>>                                path, res);
>>>                }
>>> -             return 1;
>>> +             ret =3D 1;
>>>        }
>>> -     return 0;
>>> +free_amount:
>>> +     free(amount);
>>> +     return ret;
>>>    }
>>>    static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
>>>
