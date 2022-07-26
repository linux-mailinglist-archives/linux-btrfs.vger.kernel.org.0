Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F468580A92
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 06:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiGZE5B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 00:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiGZE5A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 00:57:00 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2176A1EAE6
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 21:56:59 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id v130so10682750oie.13
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 21:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AeTJgCtHW/QR5TCRoLOY9g/pe46PhJNG6QZwhgydKjg=;
        b=D6BT4iT3fRi5vYcKzKmqprZh+th/Qan9udjaR/D2JbRHe/DauZpoHUwX9BUBvVIiXw
         ZDoBjsIjA1ADouMo+px82wb2X8auWpeoJkjc0iVT5wSMg1fkkthudKupR+KESzc92EcG
         A594gQvbNBsN2Iv9FFcMiSOFn1gqd0JZyXYeXx98J5MjKWc1GaAiCSSvIjLzjf2zbYko
         E5+4Dp/D8eIFvjS1mC/YCtE9addH0O3HXAfElzub8AtLFmMbL6Poh0pQt2nNlWj8n9MP
         JAaRjI6+S5vVnfJiXiGmemEWbH1yPZZ0kRUE01EzPSq4gYMmo24TBL08WJKXs/m46Jl4
         CVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=AeTJgCtHW/QR5TCRoLOY9g/pe46PhJNG6QZwhgydKjg=;
        b=ihOrQxMizr88JvnOZmriKJ17FrugfhKKwlKHjKLUdgl+RZXZjvgy98Jmdw39VsGLn/
         JUEf8wTomOL0Z8GzFXiOv28ID9/zoQqJ38r0a8sNqIM05U651/1ujygWhs45Ws6QLHkl
         +UtywrqJuxVYYSyyBcAGi1u9BLZidVfRR3sPqdk/W/izTsLHj6m02Kp6h2tDsGABa+Dw
         UJGFZBXUhjdzwpG5UEDcvB8kHRP9XOcG5/YxxJOUmso+05WMJUKv/hxKbQqMxsa4UpYO
         epOvGcxfAWHzwhwJQxfW0e55Ljv+fpqh3ePXest5tYf6Vp+LdAhhHlV+XitO5KsAylYb
         yQhA==
X-Gm-Message-State: AJIora8X713sZFqFcQSjenXaBsfRULKKjxb08Ws5kdBYn+GUrGvVkf1B
        JNwGGrhmS7IooVu8YXQ3Ck5uvejjOy0K+eO/gZDD/YBFF7xxEQ==
X-Google-Smtp-Source: AGRyM1ss2HRtwoqBFHlHSWGo/H8HrXVeeF/WkJqvlTslmS4xtKqw81tfG100BWKQHekUYkgKFYl+rRPXcOwSZmDvsdU=
X-Received: by 2002:a05:6808:1287:b0:33a:c629:f063 with SMTP id
 a7-20020a056808128700b0033ac629f063mr7126296oiw.158.1658811418299; Mon, 25
 Jul 2022 21:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <1658767574-16160-1-git-send-email-zhanglikernel@gmail.com> <d8fea112-ca92-ca08-0d26-405ca8f75ccc@gmx.com>
In-Reply-To: <d8fea112-ca92-ca08-0d26-405ca8f75ccc@gmx.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Tue, 26 Jul 2022 12:56:47 +0800
Message-ID: <CAAa-AGkTjLmy2VssSfEdbjCExKPkrdMe7nn4bXe37FSZZ9fv=A@mail.gmail.com>
Subject: Re: [PATCH V4] btrfs-progs: fix btrfs resize failed.
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I have another question, issue 471, extending resizing to support
the parameter all to represent all devices, I agree this should
iterate over all devices in userspace as it works on older kernel
versions. But what happens if the command fails? For example, if the
filesystem contains 3 devices, 2 of them resize successfully and the
last one fails, in this case I mean the whole command should fail,
which means it's better to put these 3 resize subcommands in a
transaction. So I'm stuck in a dilemma whether to implement all device
resizing in user space or kernel space.

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=8C 09:28=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2022/7/26 00:46, Li Zhang wrote:
> > Issue: 470
>
> This should be moved AFTER the SOB line.
> >
> > [BUG]
> > 1. If there is no devid=3D1, when the user uses the btrfs file system t=
ool,
> > the following error will be reported,
> >
> > $ sudo btrfs filesystem show /mnt/1
> > Label: none  uuid: 64dc0f68-9afa-4465-9ea1-2bbebfdb6cec
> >      Total devices 2 FS bytes used 704.00KiB
> >      devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
> >      devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> > $ sudo btrfs filesystem resize -1G /mnt/1
> > ERROR: cannot find devid: 1
> > ERROR: unable to resize '/mnt/1': No such device
> >
> > 2. Function check_resize_args, if get_fs_info is successful,
> > check_resize_args always returns 0, Even if the parameter
> > passed to kernel space is longer than the size allowed to
> > be passed to kernel space (BTRFS_VOL_NAME_MAX).
> >
> > [CAUSE]
> > 1. If the user does not specify the devid id explicitly,
> > btrfs will use the default devid 1, so it will report an error when dev=
 1 is missing.
> >
> > 2. The last line of the function check_resize_args is return 0.
> >
> > [FIX]
> > 1. If the file system contains multiple devices, output an error messag=
e to the user.
> > If the filesystem has only one device, resize should automatically add =
the unique devid.
> >
> > 2. The function check_resize_args should not return 0 on the last line,
> > it should return ret representing the return value.
> >
> > 3. Update the "btrfs-filesystem" man page
> >
> > [RESULT]
> >
> > $ sudo btrfs filesystem resize --help
> > usage: btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMgGt=
TpPeE]|[devid:]max <path>
> >
> >      Resize a filesystem
> >
> >      If the filesystem contains only one device, devid can be ignored.
> >      If 'max' is passed, the filesystem will occupy all available space
> >      on the device 'devid'.
> >      [kK] means KiB, which denotes 1KiB =3D 1024B, 1MiB =3D 1024KiB, et=
c.
> >
> >      --enqueue         wait if there's another exclusive operation runn=
ing,
> >                        otherwise continue
> >
> > $ sudo btrfs filesystem show /mnt/1/
> > Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
> >          Total devices 2 FS bytes used 144.00KiB
> >          devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
> >          devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> >
> > $ sudo btrfs filesystem resize -1G /mnt/1
> > ERROR: The file system has multiple devices, please specify devid exact=
ly.
> > ERROR: The device information list is as follows.
> >          devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
> >          devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> >
> > $ sudo btrfs device delete 2 /mnt/1/
> >
> > $ sudo btrfs filesystem show /mnt/1/
> > Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
> >          Total devices 1 FS bytes used 144.00KiB
> >          devid    3 size 15.00GiB used 1.28GiB path /dev/loop3
> >
> > $ sudo btrfs filesystem resize -1G /mnt/1
> > Resize device id 3 (/dev/loop3) from 15.00GiB to 14.00GiB
> >
> > $ sudo btrfs filesystem show /mnt/1/
> > Label: none  uuid: cc6e1beb-255b-431f-baf5-02e8056fd0b6
> >          Total devices 1 FS bytes used 144.00KiB
> >          devid    3 size 14.00GiB used 1.28GiB path /dev/loop3
> >
> > Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
>
> AKA, there should be where the "Issue:" tag is.
>
> Other than that, looks fine to me.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu
> > ---
> > V1:
> >   * Automatically add devid if device is not specific
> >
> > V2:
> >   * resize fails if filesystem has multiple devices
> >
> > V3:
> >   * Fix incorrect behavior of function check_resize_args
> >
> >   * Updated resize help information
> >
> > V4:
> >   * Update man pages
> >   Documentation/btrfs-filesystem.rst | 22 ++++++++++++------
> >   cmds/filesystem.c                  | 47 +++++++++++++++++++++++++++++=
+++------
> >   2 files changed, 55 insertions(+), 14 deletions(-)
> >
> > diff --git a/Documentation/btrfs-filesystem.rst b/Documentation/btrfs-f=
ilesystem.rst
> > index fe98597..5b3f2e2 100644
> > --- a/Documentation/btrfs-filesystem.rst
> > +++ b/Documentation/btrfs-filesystem.rst
> > @@ -197,8 +197,11 @@ resize [options] [<devid>:][+/-]<size>[kKmMgGtTpPe=
E]|[<devid>:]max <path>
> >                   as expected and does not resize the image. This would=
 resize the underlying
> >                   filesystem instead.
> >
> > -        The *devid* can be found in the output of **btrfs filesystem s=
how** and
> > -        defaults to 1 if not specified.
> > +        The *devid* can be found in the output of **btrfs filesystem s=
how**.
> > +
> > +        If the filesystem contains only one device, it can be
> > +        resized without specifying a specific device.
> > +
> >           The *size* parameter specifies the new size of the filesystem=
.
> >           If the prefix *+* or *-* is present the size is increased or =
decreased
> >           by the quantity *size*.
> > @@ -208,7 +211,7 @@ resize [options] [<devid>:][+/-]<size>[kKmMgGtTpPeE=
]|[<devid>:]max <path>
> >           KiB, MiB, GiB, TiB, PiB, or EiB, respectively (case does not =
matter).
> >
> >           If *max* is passed, the filesystem will occupy all available =
space on the
> > -        device respecting *devid* (remember, devid 1 by default).
> > +        device respecting *devid*.
> >
> >           The resize command does not manipulate the size of underlying
> >           partition.  If you wish to enlarge/reduce a filesystem, you m=
ust make sure you
> > @@ -413,14 +416,19 @@ even if run repeatedly.
> >
> >   **$ btrfs filesystem resize -1G /path**
> >
> > +Let's assume that filesystem contains only one device.
> > +Shrink size of the filesystem's single-device by 1GiB.
> > +
> > +
> >   **$ btrfs filesystem resize 1:-1G /path**
> >
> > -Shrink size of the filesystem's device id 1 by 1GiB. The first syntax =
expects a
> > -device with id 1 to exist, otherwise fails. The second is equivalent a=
nd more
> > -explicit. For a single-device filesystem it's typically not necessary =
to
> > -specify the devid though.
> > +Shrink size of the filesystem's device id 1 by 1GiB. This command expe=
cts a
> > +device with id 1 to exist, otherwise fails.
> >
> >   **$ btrfs filesystem resize max /path**
> > +Let's assume that filesystem contains only one device and the filesyst=
em
> > +does not occupy the whole block device,By simply using *max* as size w=
e
> > +will achieve that.
> >
> >   **$ btrfs filesystem resize 1:max /path**
> >
> > diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> > index 7cd08fc..e641fcb 100644
> > --- a/cmds/filesystem.c
> > +++ b/cmds/filesystem.c
> > @@ -1078,6 +1078,7 @@ static DEFINE_SIMPLE_COMMAND(filesystem_defrag, "=
defragment");
> >   static const char * const cmd_filesystem_resize_usage[] =3D {
> >       "btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMgGt=
TpPeE]|[devid:]max <path>",
> >       "Resize a filesystem",
> > +     "If the filesystem contains only one device, devid can be ignored=
.",
> >       "If 'max' is passed, the filesystem will occupy all available spa=
ce",
> >       "on the device 'devid'.",
> >       "[kK] means KiB, which denotes 1KiB =3D 1024B, 1MiB =3D 1024KiB, =
etc.",
> > @@ -1087,7 +1088,8 @@ static const char * const cmd_filesystem_resize_u=
sage[] =3D {
> >       NULL
> >   };
> >
> > -static int check_resize_args(const char *amount, const char *path) {
> > +static int check_resize_args(char * const amount, const char *path)
> > +{
> >       struct btrfs_ioctl_fs_info_args fi_args;
> >       struct btrfs_ioctl_dev_info_args *di_args =3D NULL;
> >       int ret, i, dev_idx =3D -1;
> > @@ -1112,11 +1114,14 @@ static int check_resize_args(const char *amount=
, const char *path) {
> >       }
> >
> >       ret =3D snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%s", amount);
> > +check:
> >       if (strlen(amount) !=3D ret) {
> >               error("newsize argument is too long");
> >               ret =3D 1;
> >               goto out;
> >       }
> > +     if (strcmp(amount, amount_dup) !=3D 0)
> > +             strcpy(amount, amount_dup);
> >
> >       sizestr =3D amount_dup;
> >       devstr =3D strchr(sizestr, ':');
> > @@ -1133,6 +1138,24 @@ static int check_resize_args(const char *amount,=
 const char *path) {
> >                       ret =3D 1;
> >                       goto out;
> >               }
> > +     } else if (fi_args.num_devices !=3D 1) {
> > +             error("The file system has multiple devices, please speci=
fy devid exactly.");
> > +             error("The device information list is as follows.");
> > +             for (i =3D 0; i < fi_args.num_devices; i++) {
> > +                     fprintf(stderr, "\tdevid %4llu size %s used %s pa=
th %s\n",
> > +                             di_args[i].devid,
> > +                             pretty_size_mode(di_args[i].total_bytes, =
UNITS_DEFAULT),
> > +                             pretty_size_mode(di_args[i].bytes_used, U=
NITS_DEFAULT),
> > +                             di_args[i].path);
> > +             }
> > +             ret =3D 1;
> > +             goto out;
> > +     } else {
> > +             memset(amount_dup, 0, BTRFS_VOL_NAME_MAX);
> > +             ret =3D snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%llu:",=
 di_args[0].devid);
> > +             ret =3D snprintf(amount_dup + strlen(amount_dup),
> > +                     BTRFS_VOL_NAME_MAX - strlen(amount_dup), "%s", am=
ount);
> > +             goto check;
> >       }
> >
> >       dev_idx =3D -1;
> > @@ -1200,10 +1223,11 @@ static int check_resize_args(const char *amount=
, const char *path) {
> >               di_args[dev_idx].path,
> >               pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFA=
ULT),
> >               res_str);
> > +     ret =3D 0;
> >
> >   out:
> >       free(di_args);
> > -     return 0;
> > +     return ret;
> >   }
> >
> >   static int cmd_filesystem_resize(const struct cmd_struct *cmd,
> > @@ -1213,7 +1237,7 @@ static int cmd_filesystem_resize(const struct cmd=
_struct *cmd,
> >       int     fd, res, len, e;
> >       char    *amount, *path;
> >       DIR     *dirstream =3D NULL;
> > -     int ret;
> > +     int ret =3D 0;
> >       bool enqueue =3D false;
> >       bool cancel =3D false;
> >
> > @@ -1277,10 +1301,17 @@ static int cmd_filesystem_resize(const struct c=
md_struct *cmd,
> >               }
> >       }
> >
> > +     amount =3D (char *)malloc(BTRFS_VOL_NAME_MAX);
> > +     if (!amount)
> > +             return -ENOMEM;
> > +
> > +     strcpy(amount, argv[optind]);
> > +
> >       ret =3D check_resize_args(amount, path);
> >       if (ret !=3D 0) {
> >               close_file_or_dir(fd, dirstream);
> > -             return 1;
> > +             ret =3D 1;
> > +             goto free_amount;
> >       }
> >
> >       memset(&args, 0, sizeof(args));
> > @@ -1298,7 +1329,7 @@ static int cmd_filesystem_resize(const struct cmd=
_struct *cmd,
> >                       error("unable to resize '%s': %m", path);
> >                       break;
> >               }
> > -             return 1;
> > +             ret =3D 1;
> >       } else if (res > 0) {
> >               const char *err_str =3D btrfs_err_str(res);
> >
> > @@ -1308,9 +1339,11 @@ static int cmd_filesystem_resize(const struct cm=
d_struct *cmd,
> >                       error("resizing of '%s' failed: unknown error %d"=
,
> >                               path, res);
> >               }
> > -             return 1;
> > +             ret =3D 1;
> >       }
> > -     return 0;
> > +free_amount:
> > +     free(amount);
> > +     return ret;
> >   }
> >   static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
> >
