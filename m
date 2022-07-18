Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8953578790
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 18:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiGRQjK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 12:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiGRQio (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 12:38:44 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D362B1A2
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 09:38:42 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso25139424fac.7
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=72lRW7pYXTsQPaXUJJZSIIDZLTBvqZs+zI+75Q6MGvg=;
        b=oOgdkKwcrIMCkhp8jrqMUq5j7X6H2YQeibocgOuDot65VDY+Wx/UmmF83i4w/f2C+K
         tPPflKq3k9nr/dnyRmWE7DpZP54+b6aPU8PJN0YtvIIqTESdR+BJm4yYH1DEWf+CueCH
         SWkuvBefB7FbWcFVka+WSFuqhdk9LcT49CIJTZ3Ouz8w8HlLIuzleV+mhUJ+Xu+PZnKl
         d3t1EgSVzjcs/7TjmS8npywRxQAym5gKir5jVt/NxwtyGbIZwu4OXsfcqvdLvHe+LleT
         xcRgGz01aOm8InNHimplx20iT0xfrzkFKIEb1yjJ824RePuyYPsodArN08g4r9++iPnv
         JmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=72lRW7pYXTsQPaXUJJZSIIDZLTBvqZs+zI+75Q6MGvg=;
        b=YEBQ4smbOrrjO1aDaPeFdwHbSUQs+guscXJRm1MkLcxNbMbmS7iB43fdAxWVnY9Trz
         5wFm4oS66Bl+ZksSwdSnQHtLMxW4ydzkZlYnH44NC3xJIX2fT+dgahjyWW0qXPsovbqj
         LoIa9wSR2vIqb40P3omg1xzyBsBM1lhJ34Jhq8ZE+x5qQi/iLC6P74RGFBvkMONltW3F
         kTNOdnFfXJatw1wJq9TjZeZwfS8mbgLY9E2DOLVnRc2y83s0FxMhj/P3Tw+Kxu/ktD/8
         tdHuzEzqXWxzGABYrz+UomV3Ox93Ss6NZSNuisOfx7Moi5auKpq8nWiE/VNGPtcB3xXK
         Ufbg==
X-Gm-Message-State: AJIora/AhMdai5Nb2o6+H1t8C5wIn9ZZ6GsKroqlwtYoGXotLnTkibGu
        Ee2LGlEhIusPPkfe4kvb/tFS09p2KgNE7h8J6/Kouutb9KgQNw==
X-Google-Smtp-Source: AGRyM1tYJOVsFJs4UoPJMh0HC7UgrUARSJa+rGLT+zdpu9FxGsNQMFsFH4h/sXZYIydjiz8p/HmOaHyK54cRUCWys0E=
X-Received: by 2002:a05:6870:2111:b0:e6:8026:8651 with SMTP id
 f17-20020a056870211100b000e680268651mr14769887oae.42.1658162321898; Mon, 18
 Jul 2022 09:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <1658070503-25238-1-git-send-email-zhanglikernel@gmail.com>
 <YtRJT+J2W/Z4G/gS@hungrycats.org> <42fe2853-87a5-625c-7808-3f7af8c7ec37@gmx.com>
 <bd729dba-1517-dada-5073-da1d5ea5fdc7@gmx.com> <CAAa-AGnn4ryjOW+LDVNrPjw2O2gZfGxLG_axzCXDvQZKKp+Qzw@mail.gmail.com>
In-Reply-To: <CAAa-AGnn4ryjOW+LDVNrPjw2O2gZfGxLG_axzCXDvQZKKp+Qzw@mail.gmail.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Tue, 19 Jul 2022 00:38:30 +0800
Message-ID: <CAAa-AGkRfdBnSCBtxqv0TTFKVeaYThsurGeDYge7MrdytX+7uw@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: resize: automatically add devid if device is
 not specifically
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, ce3g8jdj@umail.furryterror.org
Cc:     linux-btrfs@vger.kernel.org
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

Yes, that makes sense, I'll correct this patch later.
I'll also try to fix this:
https://github.com/kdave/btrfs-progs/issues/471, add parameter all to
resize all devices.

li zhang <zhanglikernel@gmail.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C 00:34=E5=86=99=E9=81=93=EF=BC=9A
>
> Yes, that makes sense, I'll correct this patch later.
> I'll also try to fix this:
> https://github.com/kdave/btrfs-progs/issues/471, add parameter all to
> resize all devices.
>
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=B8=80 09:44=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> >
> > On 2022/7/18 09:16, Qu Wenruo wrote:
> > >
> > >
> > > On 2022/7/18 01:39, Zygo Blaxell wrote:
> > >> On Sun, Jul 17, 2022 at 11:08:23PM +0800, Li Zhang wrote:
> > >>> related issues:
> > >>> https://github.com/kdave/btrfs-progs/issues/470
> > >>>
> > >>> [BUG]
> > >>> If there is no devid=3D1, when the user uses the btrfs file system
> > >>> tool, the following error will be reported,
> > >>>
> > >>> $ sudo btrfs filesystem show /mnt/1
> > >>> Label: none  uuid: 64dc0f68-9afa-4465-9ea1-2bbebfdb6cec
> > >>>      Total devices 2 FS bytes used 704.00KiB
> > >>>      devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
> > >>>      devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> > >>> $ sudo btrfs filesystem resize -1G /mnt/1
> > >>> ERROR: cannot find devid: 1
> > >>> ERROR: unable to resize '/mnt/1': No such device
> > >>>
> > >>> [CAUSE]
> > >>> If the user does not specify the devid id explicitly, btrfs will us=
e
> > >>> the default devid 1, so it will report an error when dev 1 is missi=
ng.
> > >>>
> > >>> [FIX]
> > >>> If there is no special devid, the first devid is added automaticall=
y
> > >>> and check the maximum length of args passed to kernel space.
> > >>> After patch, when resize filesystem without specified, it would
> > >>> resize the first device, the result is list as following.
> > >>>
> > >>> $ sudo btrfs filesystem show /mnt/1/
> > >>> Label: none  uuid: 7b4827da-bc6e-42aa-b03d-52c2533dfe94
> > >>>      Total devices 2 FS bytes used 144.00KiB
> > >>>      devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
> > >>>      devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> > >>>
> > >>> $ sudo btrfs filesystem resize -1G /mnt/1
> > >>> Resize device id 2 (/dev/loop2) from 15.00GiB to 14.00GiB
> > >>> $ sudo btrfs filesystem show /mnt/1/
> > >>> Label: none  uuid: 7b4827da-bc6e-42aa-b03d-52c2533dfe94
> > >>>      Total devices 2 FS bytes used 144.00KiB
> > >>>      devid    2 size 14.00GiB used 1.16GiB path /dev/loop2
> > >>>      devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> > >>
> > >> Is that desirable behavior?  I'd expect that if there are multiple
> > >> devices present, and I haven't specified which one to resize, that t=
he
> > >> command would fail with an error, requiring me to specify which devi=
ce I
> > >> want resized.  Under that expectation, the current behavior of resiz=
ing
> > >> devid 1 by default is also incorrect.
> > >
> > > I agree with Zygo.
> > >
> > > If there is only one device, then we can definitely use the first dev=
ice
> > > we find.
> > >
> > > If there are multiple devices, then it's better to output an error
> > > message, provide candidate devids, and error out.
> >
> > And forgot to mention, after all these changes, we also need to update
> > the man page of "btrfs-filesystem" subcommand.
> >
> > Thanks,
> > Qu
> >
> > >
> > > Thanks,
> > > Qu
> > >
> > >>
> > >> If there's only one device, then 'btrfs fi resize -1G' should resize
> > >> that device, since no ambiguity is possible.
> > >>
> > >>> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> > >>> ---
> > >>>   cmds/filesystem.c | 49
> > >>> ++++++++++++++++++++++++++++++++++++++-----------
> > >>>   1 file changed, 38 insertions(+), 11 deletions(-)
> > >>>
> > >>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> > >>> index 7cd08fc..2e2414d 100644
> > >>> --- a/cmds/filesystem.c
> > >>> +++ b/cmds/filesystem.c
> > >>> @@ -1087,7 +1087,8 @@ static const char * const
> > >>> cmd_filesystem_resize_usage[] =3D {
> > >>>       NULL
> > >>>   };
> > >>>
> > >>> -static int check_resize_args(const char *amount, const char *path)=
 {
> > >>> +static int check_resize_args(char * const amount, const char *path=
)
> > >>> +{
> > >>>       struct btrfs_ioctl_fs_info_args fi_args;
> > >>>       struct btrfs_ioctl_dev_info_args *di_args =3D NULL;
> > >>>       int ret, i, dev_idx =3D -1;
> > >>> @@ -1102,7 +1103,8 @@ static int check_resize_args(const char
> > >>> *amount, const char *path) {
> > >>>
> > >>>       if (ret) {
> > >>>           error("unable to retrieve fs info");
> > >>> -        return 1;
> > >>> +        ret =3D 1;
> > >>> +        goto out;
> > >>>       }
> > >>>
> > >>>       if (!fi_args.num_devices) {
> > >>> @@ -1112,11 +1114,14 @@ static int check_resize_args(const char
> > >>> *amount, const char *path) {
> > >>>       }
> > >>>
> > >>>       ret =3D snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%s", amount=
);
> > >>> +check:
> > >>>       if (strlen(amount) !=3D ret) {
> > >>>           error("newsize argument is too long");
> > >>>           ret =3D 1;
> > >>>           goto out;
> > >>>       }
> > >>> +    if (strcmp(amount, amount_dup) !=3D 0)
> > >>> +        strcpy(amount, amount_dup);
> > >>>
> > >>>       sizestr =3D amount_dup;
> > >>>       devstr =3D strchr(sizestr, ':');
> > >>> @@ -1137,6 +1142,13 @@ static int check_resize_args(const char
> > >>> *amount, const char *path) {
> > >>>
> > >>>       dev_idx =3D -1;
> > >>>       for(i =3D 0; i < fi_args.num_devices; i++) {
> > >>> +        if (!devstr) {
> > >>> +            memset(amount_dup, 0, BTRFS_VOL_NAME_MAX);
> > >>> +            ret =3D snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%llu=
:",
> > >>> di_args[i].devid);
> > >>> +            ret =3D snprintf(amount_dup + strlen(amount_dup),
> > >>> +                BTRFS_VOL_NAME_MAX - strlen(amount_dup), "%s", amo=
unt);
> > >>> +            goto check;
> > >>> +        }
> > >>>           if (di_args[i].devid =3D=3D devid) {
> > >>>               dev_idx =3D i;
> > >>>               break;
> > >>> @@ -1235,8 +1247,10 @@ static int cmd_filesystem_resize(const struc=
t
> > >>> cmd_struct *cmd,
> > >>>           }
> > >>>       }
> > >>>
> > >>> -    if (check_argc_exact(argc - optind, 2))
> > >>> -        return 1;
> > >>> +    if (check_argc_exact(argc - optind, 2)) {
> > >>> +        ret =3D 1;
> > >>> +        goto out;
> > >>> +    }
> > >>>
> > >>>       amount =3D argv[optind];
> > >>>       path =3D argv[optind + 1];
> > >>> @@ -1244,7 +1258,8 @@ static int cmd_filesystem_resize(const struct
> > >>> cmd_struct *cmd,
> > >>>       len =3D strlen(amount);
> > >>>       if (len =3D=3D 0 || len >=3D BTRFS_VOL_NAME_MAX) {
> > >>>           error("resize value too long (%s)", amount);
> > >>> -        return 1;
> > >>> +        ret =3D 1;
> > >>> +        goto out;
> > >>>       }
> > >>>
> > >>>       cancel =3D (strcmp("cancel", amount) =3D=3D 0);
> > >>> @@ -1258,7 +1273,8 @@ static int cmd_filesystem_resize(const struct
> > >>> cmd_struct *cmd,
> > >>>           "directories as argument. Passing file containing a btrfs
> > >>> image\n"
> > >>>           "would resize the underlying filesystem instead of the
> > >>> image.\n");
> > >>>           }
> > >>> -        return 1;
> > >>> +        ret =3D 1;
> > >>> +        goto out;
> > >>>       }
> > >>>
> > >>>       /*
> > >>> @@ -1273,14 +1289,22 @@ static int cmd_filesystem_resize(const stru=
ct
> > >>> cmd_struct *cmd,
> > >>>                   error(
> > >>>               "unable to check status of exclusive operation: %m");
> > >>>               close_file_or_dir(fd, dirstream);
> > >>> -            return 1;
> > >>> +            goto out;
> > >>>           }
> > >>>       }
> > >>>
> > >>> +    amount =3D (char *)malloc(BTRFS_VOL_NAME_MAX);
> > >>> +    if (!amount) {
> > >>> +        ret =3D -ENOMEM;
> > >>> +        goto out;
> > >>> +    }
> > >>> +    strcpy(amount, argv[optind]);
> > >>> +
> > >>>       ret =3D check_resize_args(amount, path);
> > >>>       if (ret !=3D 0) {
> > >>>           close_file_or_dir(fd, dirstream);
> > >>> -        return 1;
> > >>> +        ret =3D 1;
> > >>> +        goto free_amount;
> > >>>       }
> > >>>
> > >>>       memset(&args, 0, sizeof(args));
> > >>> @@ -1298,7 +1322,7 @@ static int cmd_filesystem_resize(const struct
> > >>> cmd_struct *cmd,
> > >>>               error("unable to resize '%s': %m", path);
> > >>>               break;
> > >>>           }
> > >>> -        return 1;
> > >>> +        ret =3D 1;
> > >>>       } else if (res > 0) {
> > >>>           const char *err_str =3D btrfs_err_str(res);
> > >>>
> > >>> @@ -1308,9 +1332,12 @@ static int cmd_filesystem_resize(const struc=
t
> > >>> cmd_struct *cmd,
> > >>>               error("resizing of '%s' failed: unknown error %d",
> > >>>                   path, res);
> > >>>           }
> > >>> -        return 1;
> > >>> +        ret =3D 1;
> > >>>       }
> > >>> -    return 0;
> > >>> +free_amount:
> > >>> +    free(amount);
> > >>> +out:
> > >>> +    return ret;
> > >>>   }
> > >>>   static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
> > >>>
> > >>> --
> > >>> 1.8.3.1
> > >>>
