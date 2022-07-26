Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF758091D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 03:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbiGZBix (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 21:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiGZBiu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 21:38:50 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8F028E0A
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 18:38:48 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u76so15556552oie.3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 18:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ab2SNaDhE3PbGD4d/9PjKnG6JUrQ8yvwtniDIFjqV8E=;
        b=bronChvZX4yVoM60+UA+wVqDv181r+Wk5wlBwVqOJpdj8uvvxAPWm0oLSJeUYA2Yni
         HtBxZU8JUavZWrmz+ZpwW95WiTQ2LYHIi7PLlWE4uWvmXeMvRhPZvsYv1++/R90zyoW1
         4UVD9VZOxJHmEJK+3TCu+413Z4biMPitYAVg+jseX7x9xhReIbrDUYBPxCV4sQtw2n1B
         sLAnXvjshdqJ/uzCmDrwrbO+ycd/yb0uA45wB0Y2Ft12FZ7OirF/IxpiWC4FC4LdQmSx
         +fptWwA7IoVqQf9Q64uDVJw94ytStOK95TbR7cgK460OoWjWaaZ5ef8yMZk78dDpDlN3
         oT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ab2SNaDhE3PbGD4d/9PjKnG6JUrQ8yvwtniDIFjqV8E=;
        b=NvCdMa8Op8bobf9iQw+i9572qFT9lfmTmiwdm8zGmp2UQccfRASqOx9uZH3qQFbi2v
         t4/fRb8B60DfktjyXcHp2C5BUGhwCUjQexGT3+Y7DH9ig42AN1YckZWTCw13/9zITMS6
         i3f80WpQPtb7yPvzeJpNL9yoxnnTCgjrdNw67C8E9R1kVFWenAm0jfusKnNkk2DIQPKo
         einbSOMl2ojBM8BQWqoC0lt8nJOdp+BxfB0HVdcBlOxShJ/0wp4eq5Esp8xEJu4GYG1I
         6JzqnyxfT4QNwo4to7BCIWiTL9/kR+KCBg26hLegDeD8pcgVy0IDCzUfNigIfyNH6CM3
         SCZA==
X-Gm-Message-State: AJIora8MD5nlQ/5MXSzMWmzrM/A3Yz25dplCL37/8hFmc8J9BQ9FIuke
        j09ZaJMFPSJ/jz4dWy8zGv3ukm+AW3U77oi+qttlrRnDVQTWvg==
X-Google-Smtp-Source: AGRyM1vgS/gEhwu9Frp1t7s69geKaLAyBhmTWY9sbiCEcjTqvqV4SaUKFe70wk3oMyIQm8xkv35hoWY2H4ViSsJ6YfU=
X-Received: by 2002:a05:6808:1287:b0:33a:c629:f063 with SMTP id
 a7-20020a056808128700b0033ac629f063mr6890732oiw.158.1658799528018; Mon, 25
 Jul 2022 18:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <1658666627-27889-1-git-send-email-zhanglikernel@gmail.com> <d6a18603-6bba-0eb3-a8d0-e341afaf37f5@gmx.com>
In-Reply-To: <d6a18603-6bba-0eb3-a8d0-e341afaf37f5@gmx.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Tue, 26 Jul 2022 09:38:35 +0800
Message-ID: <CAAa-AG=Wqa06Y6rQM2PO17T3qz2FgxqfM3K=sZ6v-QA8LfvYZQ@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs-progs: fix btrfs resize failed.
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

Sorry, I'm a little confused, does the SOB line mean the "--" line?

Thanks,
Li

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=B8=80 08:34=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2022/7/24 20:43, Li Zhang wrote:
> > related issuse:
> > https://github.com/kdave/btrfs-progs/issues/470
>
> Something I forgot to mention is related to the changelog part.
>
> This can be replaced by the following tag before SOB line:
>
> Issue: 470
>
> >
> > V1 link:
> > https://www.spinics.net/lists/linux-btrfs/msg126661.html
> >
> > V2 link:
> > https://www.spinics.net/lists/linux-btrfs/msg126853.html
>
> Changelog for single patch can be put after all the tags, and with a
> line of "---", so at apply time git will discard the extra info.
>
> One example can be found here:
>
> https://lore.kernel.org/linux-btrfs/20220617151133.GO20633@twin.jikos.cz/=
T/
>
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
>
> Although help string is updated, the manpage is still not updated.
>
> Thanks,
> Qu
>
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
> >       Total devices 1 FS bytes used 144.00KiB
> >       devid    3 size 14.00GiB used 1.28GiB path /dev/loop3
> >
> > Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> > ---
> >   cmds/filesystem.c | 47 ++++++++++++++++++++++++++++++++++++++++------=
-
> >   1 file changed, 40 insertions(+), 7 deletions(-)
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
