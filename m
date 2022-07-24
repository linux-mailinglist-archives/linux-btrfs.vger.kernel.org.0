Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C794B57F471
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 11:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiGXJdU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jul 2022 05:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiGXJdS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jul 2022 05:33:18 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081902A5
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 02:33:17 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso6538046otv.3
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=s69uCkzREqQDrjfElFjuLsEwDnS2Azar0ZMH7Fo2zkM=;
        b=g+UEWhc8iuehVkDbQTbdQDcMR0857dYkAfrBg/EXRKbftelxiPT6v3D0dffF09lnbO
         EzKElT21vvALgFylsGjadd6VTBVatB0CyH21Tifrwr2eqfu3ang5klW5U40MKnqULsEc
         61X3/S0YdfF7XrAvZu0reopkuGzdRfswKCwqoFA0CuQts4RBGjzAkDPhrnwjWySS31VX
         iOS/gtvE1/VVC+IEURo1KWXur5978K/ijhLJMJ6MiMgRUlS0UkQ7GId+RsNFGElJ3h3Y
         WHq9NMv9+qp/O0dgRdi0fAcFbvJvgpYgHRnNoYkXp3GAcs2j1MG1+3kceNulBnUrUfMP
         aCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=s69uCkzREqQDrjfElFjuLsEwDnS2Azar0ZMH7Fo2zkM=;
        b=xgssNmCK4H7KsULuudHbVsSCFk+4NvYFLrKOTGlr4UrSOhbrdfHqfO7qlIHvWIr56r
         NRuIEnsCgrVha2yK9NHCQrhDodarpwpuJRdW4Yw0JAbv7HtvUZK60J3Ki1Wl0wMEAOH1
         RnZcZMfYxNN1Fo8D2kEZKJKcmJoUkCsjpQD7QpnoypchO0WOo5Vpq7C6BMh7961g6X9f
         RFFN68xRaUcih4Ika0XYBaALW0HfS5CFnaeQChYnLnQgqrJxvwnLF+s9Ykrh7GoEGc+C
         2CNSiIaTubumvee3zkZUaV2jO2qBXGN1OICKlhW9lYsVesGDBi24Nb68HrJGsOueMyoK
         jalg==
X-Gm-Message-State: AJIora/dCas4MPEr9xGUZeN/2F0Lnv0Bs7Af0dAG0SUoh3zgwYwHH/XJ
        ZtpoowlsyqBHyMmQ1W64DpElRh8ArLRBRvQbWIs5fdy7hG9RB9fV
X-Google-Smtp-Source: AGRyM1tm/Nb0OnFB2ReAuerz/ADxS1ujac2/3lLBKs7pLQY60p2W6EPvSm2urft1FdMlhib8UWRFzq3sgisW/ZTgOSA=
X-Received: by 2002:a05:6830:25c2:b0:61c:c3ab:ca5f with SMTP id
 d2-20020a05683025c200b0061cc3abca5fmr3008119otu.117.1658655195932; Sun, 24
 Jul 2022 02:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <1658577730-11447-1-git-send-email-zhanglikernel@gmail.com> <68debb4f-cc9f-ee01-71c5-ab5e7dff59ab@suse.com>
In-Reply-To: <68debb4f-cc9f-ee01-71c5-ab5e7dff59ab@suse.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Sun, 24 Jul 2022 17:33:04 +0800
Message-ID: <CAAa-AGmPLNOg8Y2Sg-iuZJAE-wxSk3xSRh8rj4SqQucAzbWW0w@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: fix btrfs resize failed.
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
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

sorry, my fault, this code
@@ -1200,10 +1223,11 @@ static int check_resize_args(const char
*amount, const char *path) {
                di_args[dev_idx].path,
                pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFAUL=
T),
                res_str);
+       ret =3D 1;

should be
ret =3D 0


And for new label out, I think you are right, it doesn't need a label
that does nothing, I will correct my patch.

thanks,
Li

Qu Wenruo <wqu@suse.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8824=E6=97=A5=E5=91=
=A8=E6=97=A5 07:21=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2022/7/23 20:02, Li Zhang wrote:
> > related issuse:
> > https://github.com/kdave/btrfs-progs/issues/470
> >
> > V1 link:
> > https://www.spinics.net/lists/linux-btrfs/msg126661.html
> >
> > [BUG]
> > If there is no devid=3D1, when the user uses the btrfs file system tool=
,
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
> > [CAUSE]
> > If the user does not specify the devid id explicitly,
> > btrfs will use the default devid 1, so it will report an error when dev=
 1 is missing.
> >
> > [FIX]
> > If the file system contains multiple devices, output an error message t=
o the user.
> >
> > If the filesystem has only one device, resize should automatically add =
the unique devid.
> >
> > [RESULT]
> >
> > $ sudo btrfs filesystem show /mnt/1/
> > Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
> >       Total devices 2 FS bytes used 144.00KiB
> >       devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
> >       devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> >
> > $ sudo btrfs filesystem resize -1G /mnt/1
> > ERROR: The file system has multiple devices, please specify devid exact=
ly.
> > ERROR: The device information list is as follows.
> >       devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
> >       devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> >
> > $ sudo btrfs device delete 2 /mnt/1/
> >
> > $ sudo btrfs filesystem show /mnt/1/
> > Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
> >       Total devices 1 FS bytes used 144.00KiB
> >       devid    3 size 15.00GiB used 1.28GiB path /dev/loop3
> >
> > $ sudo btrfs filesystem resize -1G /mnt/1
> > Resize device id 3 (/dev/loop3) from 15.00GiB to 14.00GiB
>
> The new output and logic looks pretty good to me, but still some small
> nitpicks.
>
> >
> > Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> > ---
> >   cmds/filesystem.c | 63 ++++++++++++++++++++++++++++++++++++++++++++--=
---------
>
> Shouldn't we also update the man page of "btrfs-filesystem"?
> Mostly to make it explicit when we can skip the devid/device path argumen=
t.
>
> >   1 file changed, 51 insertions(+), 12 deletions(-)
> >
> > diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> > index 7cd08fc..c26ba2b 100644
> > --- a/cmds/filesystem.c
> > +++ b/cmds/filesystem.c
> > @@ -1087,7 +1087,8 @@ static const char * const cmd_filesystem_resize_u=
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
> > @@ -1102,7 +1103,8 @@ static int check_resize_args(const char *amount, =
const char *path) {
> >
> >       if (ret) {
> >               error("unable to retrieve fs info");
> > -             return 1;
> > +             ret =3D 1;
> > +             goto out;
> >       }
> >
> >       if (!fi_args.num_devices) {
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
> > +     ret =3D 1;
>
> Previously if we reach this path, we should have everything prepared and
> return 0.
>
> But now it always return 1, is that expected? Especially the only caller
> will just error out if the return value is not 0.
>
> >
> >   out:
> >       free(di_args);
> > -     return 0;
> > +     return ret;
>
> In fact, this turns out to be an existing bug, there are quite a lot of
> existing paths setting ret to 1, and goto out to return error.
>
> Those error paths are not properly handled previously.
>
> Thus changing the out: label to return @ret is in fact a bug fix.
>
> Not sure if we need to split the patch into two, one to fix the return
> value first, then introduce the new behavior.
>
> >   }
> >
> >   static int cmd_filesystem_resize(const struct cmd_struct *cmd,
> > @@ -1235,8 +1259,10 @@ static int cmd_filesystem_resize(const struct cm=
d_struct *cmd,
> >               }
> >       }
> >
> > -     if (check_argc_exact(argc - optind, 2))
> > -             return 1;
> > +     if (check_argc_exact(argc - optind, 2)) {
> > +             ret =3D 1;
> > +             goto out;
> > +     }
> >
> >       amount =3D argv[optind];
> >       path =3D argv[optind + 1];
> > @@ -1244,7 +1270,8 @@ static int cmd_filesystem_resize(const struct cmd=
_struct *cmd,
> >       len =3D strlen(amount);
> >       if (len =3D=3D 0 || len >=3D BTRFS_VOL_NAME_MAX) {
> >               error("resize value too long (%s)", amount);
> > -             return 1;
> > +             ret =3D 1;
> > +             goto out;
>
> This change doesn't look necessary, the new out label is just returning
> the @ret value, not really worthy a new label.
>
> >       }
> >
> >       cancel =3D (strcmp("cancel", amount) =3D=3D 0);
> > @@ -1258,7 +1285,8 @@ static int cmd_filesystem_resize(const struct cmd=
_struct *cmd,
> >               "directories as argument. Passing file containing a btrfs=
 image\n"
> >               "would resize the underlying filesystem instead of the im=
age.\n");
> >               }
> > -             return 1;
> > +             ret =3D 1;
> > +             goto out;
>
> The same here.
>
> >       }
> >
> >       /*
> > @@ -1273,14 +1301,22 @@ static int cmd_filesystem_resize(const struct c=
md_struct *cmd,
> >                               error(
> >                       "unable to check status of exclusive operation: %=
m");
> >                       close_file_or_dir(fd, dirstream);
> > -                     return 1;
> > +                     goto out;
>
> And here.
>
> >               }
> >       }
> >
> > +     amount =3D (char *)malloc(BTRFS_VOL_NAME_MAX);
>
> No need to do the type cast, (void *) can be assigned to any pointer
> type without the need to type cast.
>
> > +     if (!amount) {
> > +             ret =3D -ENOMEM;
> > +             goto out;
>
> The same here too.
>
> Thanks,
> Qu
>
> > +     }
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
> > @@ -1298,7 +1334,7 @@ static int cmd_filesystem_resize(const struct cmd=
_struct *cmd,
> >                       error("unable to resize '%s': %m", path);
> >                       break;
> >               }
> > -             return 1;
> > +             ret =3D 1;
> >       } else if (res > 0) {
> >               const char *err_str =3D btrfs_err_str(res);
> >
> > @@ -1308,9 +1344,12 @@ static int cmd_filesystem_resize(const struct cm=
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
> > +out:
> > +     return ret;
> >   }
> >   static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
> >
