Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B1858097C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 04:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiGZC3m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 22:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiGZC3l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 22:29:41 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D38E28E30
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 19:29:40 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id l188so3997303oia.4
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 19:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IRV7SbG29ROff0gQtVI0Wa7wDkf7v1DX8oy+0HMqQU4=;
        b=lulTPyv7vJQeDE2FPnK1IL+mpbbjcuwE2ziHR+zq5EwnhMZSCmExbmrawVyU67yZm8
         IfTt8Eef0atsJYfKkFoXAtdc1o0FiSxgZ5Dio9uhSsEBtOjWFHspQi0ySbolYtG+gN8J
         8AmW3IHteC64m0SxK4q9zVC8vtgap94HOykuzEEsso8gejDGLMdekWF6lkuzqgOJIrfL
         Pthv4heckaGqlcxtUuLl/CGpV0dCD6UBOhsEfG838YwQg3rztQA1kJiimEioNpeSugAj
         Z4R8VwxlAGGpLsa2cF4zpiz1zqikjEtc387qf1prUFMJDJ/r3phiiqVzGRXdaqGmvhq7
         hjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IRV7SbG29ROff0gQtVI0Wa7wDkf7v1DX8oy+0HMqQU4=;
        b=qFefpR3cJ0TCb1jLA/iX9JbuuQarB0jbwdDxuH2uqHfhjiqTsbShDcgPlwU7bvfack
         tQJ34v2Mq3WTP56ULDeo7bE2uslM4HiNaJsjizf/lvcxrSsJvI5FRClyedQhkuWc0au0
         URfJno/4FjKpOT4LDVPiMRYuYyHRP7Sh0o+ggLjznVYOOCl0dcoYVcLfWLMexZ28vTaW
         9UzBnKH0Ao//6GKfEeM16MYElmX1O+dPfELeBS5UqgXykXrf/W1+iy2ONv47Wp600JhA
         UAZlcJH9NV68AYopxAYG4iTQdbcDx4+B3mCu1kkS+hbrFsd01M03HLJhAXwaw6l/4xId
         z8yQ==
X-Gm-Message-State: AJIora+de/nh+SiVRhQgEFYAtcF8KvMrvRCSqQnoJ3BvyLmnNwbwNy57
        oIBWyWLw14+/0v0J5yS2nMdPGQjVFWU71CalfpvxgV7NeYc=
X-Google-Smtp-Source: AGRyM1tK1bwQJO2VyvDgBlaIj4ysgWMCEo4Yn+QlhJlowLHfasHWXLBav9ywu57Joj/FB/NvCUEpOMTytlX/PkknPQk=
X-Received: by 2002:a05:6808:13c5:b0:33a:f347:9d9f with SMTP id
 d5-20020a05680813c500b0033af3479d9fmr1514322oiw.42.1658802579792; Mon, 25 Jul
 2022 19:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <1658666627-27889-1-git-send-email-zhanglikernel@gmail.com>
 <d6a18603-6bba-0eb3-a8d0-e341afaf37f5@gmx.com> <CAAa-AG=Wqa06Y6rQM2PO17T3qz2FgxqfM3K=sZ6v-QA8LfvYZQ@mail.gmail.com>
 <b978960c-3cf3-777e-ce62-e9935455d638@gmx.com>
In-Reply-To: <b978960c-3cf3-777e-ce62-e9935455d638@gmx.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Tue, 26 Jul 2022 10:29:27 +0800
Message-ID: <CAAa-AGkWfJi0hjgGpNEUJevRMdp+g1f20KKPFi0V193GTC472Q@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs-progs: fix btrfs resize failed.
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
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

Got it, thanks!

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=8C 10:08=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2022/7/26 09:38, li zhang wrote:
> > Sorry, I'm a little confused, does the SOB line mean the "--" line?
>
> SOB =3D Signed-of-by line.
>
> The correct example for that tag for btrfs-progs can be found here:
>
> https://lore.kernel.org/linux-btrfs/20220114005123.19426-4-wqu@suse.com/
>
> Thanks,
> Qu
>
> >
> > Thanks,
> > Li
> >
> > Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8825=
=E6=97=A5=E5=91=A8=E4=B8=80 08:34=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >>
> >>
> >> On 2022/7/24 20:43, Li Zhang wrote:
> >>> related issuse:
> >>> https://github.com/kdave/btrfs-progs/issues/470
> >>
> >> Something I forgot to mention is related to the changelog part.
> >>
> >> This can be replaced by the following tag before SOB line:
> >>
> >> Issue: 470
> >>
> >>>
> >>> V1 link:
> >>> https://www.spinics.net/lists/linux-btrfs/msg126661.html
> >>>
> >>> V2 link:
> >>> https://www.spinics.net/lists/linux-btrfs/msg126853.html
> >>
> >> Changelog for single patch can be put after all the tags, and with a
> >> line of "---", so at apply time git will discard the extra info.
> >>
> >> One example can be found here:
> >>
> >> https://lore.kernel.org/linux-btrfs/20220617151133.GO20633@twin.jikos.=
cz/T/
> >>
> >>>
> >>> [BUG]
> >>> 1. If there is no devid=3D1, when the user uses the btrfs file system=
 tool,
> >>> the following error will be reported,
> >>>
> >>> $ sudo btrfs filesystem show /mnt/1
> >>> Label: none  uuid: 64dc0f68-9afa-4465-9ea1-2bbebfdb6cec
> >>>       Total devices 2 FS bytes used 704.00KiB
> >>>       devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
> >>>       devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> >>> $ sudo btrfs filesystem resize -1G /mnt/1
> >>> ERROR: cannot find devid: 1
> >>> ERROR: unable to resize '/mnt/1': No such device
> >>>
> >>> 2. Function check_resize_args, if get_fs_info is successful,
> >>> check_resize_args always returns 0, Even if the parameter
> >>> passed to kernel space is longer than the size allowed to
> >>> be passed to kernel space (BTRFS_VOL_NAME_MAX).
> >>>
> >>> [CAUSE]
> >>> 1. If the user does not specify the devid id explicitly,
> >>> btrfs will use the default devid 1, so it will report an error when d=
ev 1 is missing.
> >>>
> >>> 2. The last line of the function check_resize_args is return 0.
> >>>
> >>> [FIX]
> >>> 1. If the file system contains multiple devices, output an error mess=
age to the user.
> >>> If the filesystem has only one device, resize should automatically ad=
d the unique devid.
> >>>
> >>> 2. The function check_resize_args should not return 0 on the last lin=
e,
> >>> it should return ret representing the return value.
> >>>
> >>> 3. Update the "btrfs-filesystem" man page
> >>>
> >>> [RESULT]
> >>>
> >>> $ sudo btrfs filesystem resize --help
> >>> usage: btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMg=
GtTpPeE]|[devid:]max <path>
> >>>
> >>>       Resize a filesystem
> >>>
> >>>       If the filesystem contains only one device, devid can be ignore=
d.
> >>>       If 'max' is passed, the filesystem will occupy all available sp=
ace
> >>>       on the device 'devid'.
> >>>       [kK] means KiB, which denotes 1KiB =3D 1024B, 1MiB =3D 1024KiB,=
 etc.
> >>>
> >>>       --enqueue         wait if there's another exclusive operation r=
unning,
> >>>                         otherwise continue
> >>
> >> Although help string is updated, the manpage is still not updated.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> $ sudo btrfs filesystem show /mnt/1/
> >>> Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
> >>>           Total devices 2 FS bytes used 144.00KiB
> >>>           devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
> >>>           devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> >>>
> >>> $ sudo btrfs filesystem resize -1G /mnt/1
> >>> ERROR: The file system has multiple devices, please specify devid exa=
ctly.
> >>> ERROR: The device information list is as follows.
> >>>           devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
> >>>           devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> >>>
> >>> $ sudo btrfs device delete 2 /mnt/1/
> >>>
> >>> $ sudo btrfs filesystem show /mnt/1/
> >>> Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
> >>>           Total devices 1 FS bytes used 144.00KiB
> >>>           devid    3 size 15.00GiB used 1.28GiB path /dev/loop3
> >>>
> >>> $ sudo btrfs filesystem resize -1G /mnt/1
> >>> Resize device id 3 (/dev/loop3) from 15.00GiB to 14.00GiB
> >>>
> >>> $ sudo btrfs filesystem show /mnt/1/
> >>> Label: none  uuid: cc6e1beb-255b-431f-baf5-02e8056fd0b6
> >>>        Total devices 1 FS bytes used 144.00KiB
> >>>        devid    3 size 14.00GiB used 1.28GiB path /dev/loop3
> >>>
> >>> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> >>> ---
> >>>    cmds/filesystem.c | 47 ++++++++++++++++++++++++++++++++++++++++---=
----
> >>>    1 file changed, 40 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> >>> index 7cd08fc..e641fcb 100644
> >>> --- a/cmds/filesystem.c
> >>> +++ b/cmds/filesystem.c
> >>> @@ -1078,6 +1078,7 @@ static DEFINE_SIMPLE_COMMAND(filesystem_defrag,=
 "defragment");
> >>>    static const char * const cmd_filesystem_resize_usage[] =3D {
> >>>        "btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmM=
gGtTpPeE]|[devid:]max <path>",
> >>>        "Resize a filesystem",
> >>> +     "If the filesystem contains only one device, devid can be ignor=
ed.",
> >>>        "If 'max' is passed, the filesystem will occupy all available =
space",
> >>>        "on the device 'devid'.",
> >>>        "[kK] means KiB, which denotes 1KiB =3D 1024B, 1MiB =3D 1024Ki=
B, etc.",
> >>> @@ -1087,7 +1088,8 @@ static const char * const cmd_filesystem_resize=
_usage[] =3D {
> >>>        NULL
> >>>    };
> >>>
> >>> -static int check_resize_args(const char *amount, const char *path) {
> >>> +static int check_resize_args(char * const amount, const char *path)
> >>> +{
> >>>        struct btrfs_ioctl_fs_info_args fi_args;
> >>>        struct btrfs_ioctl_dev_info_args *di_args =3D NULL;
> >>>        int ret, i, dev_idx =3D -1;
> >>> @@ -1112,11 +1114,14 @@ static int check_resize_args(const char *amou=
nt, const char *path) {
> >>>        }
> >>>
> >>>        ret =3D snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%s", amount)=
;
> >>> +check:
> >>>        if (strlen(amount) !=3D ret) {
> >>>                error("newsize argument is too long");
> >>>                ret =3D 1;
> >>>                goto out;
> >>>        }
> >>> +     if (strcmp(amount, amount_dup) !=3D 0)
> >>> +             strcpy(amount, amount_dup);
> >>>
> >>>        sizestr =3D amount_dup;
> >>>        devstr =3D strchr(sizestr, ':');
> >>> @@ -1133,6 +1138,24 @@ static int check_resize_args(const char *amoun=
t, const char *path) {
> >>>                        ret =3D 1;
> >>>                        goto out;
> >>>                }
> >>> +     } else if (fi_args.num_devices !=3D 1) {
> >>> +             error("The file system has multiple devices, please spe=
cify devid exactly.");
> >>> +             error("The device information list is as follows.");
> >>> +             for (i =3D 0; i < fi_args.num_devices; i++) {
> >>> +                     fprintf(stderr, "\tdevid %4llu size %s used %s =
path %s\n",
> >>> +                             di_args[i].devid,
> >>> +                             pretty_size_mode(di_args[i].total_bytes=
, UNITS_DEFAULT),
> >>> +                             pretty_size_mode(di_args[i].bytes_used,=
 UNITS_DEFAULT),
> >>> +                             di_args[i].path);
> >>> +             }
> >>> +             ret =3D 1;
> >>> +             goto out;
> >>> +     } else {
> >>> +             memset(amount_dup, 0, BTRFS_VOL_NAME_MAX);
> >>> +             ret =3D snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%llu:=
", di_args[0].devid);
> >>> +             ret =3D snprintf(amount_dup + strlen(amount_dup),
> >>> +                     BTRFS_VOL_NAME_MAX - strlen(amount_dup), "%s", =
amount);
> >>> +             goto check;
> >>>        }
> >>>
> >>>        dev_idx =3D -1;
> >>> @@ -1200,10 +1223,11 @@ static int check_resize_args(const char *amou=
nt, const char *path) {
> >>>                di_args[dev_idx].path,
> >>>                pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_D=
EFAULT),
> >>>                res_str);
> >>> +     ret =3D 0;
> >>>
> >>>    out:
> >>>        free(di_args);
> >>> -     return 0;
> >>> +     return ret;
> >>>    }
> >>>
> >>>    static int cmd_filesystem_resize(const struct cmd_struct *cmd,
> >>> @@ -1213,7 +1237,7 @@ static int cmd_filesystem_resize(const struct c=
md_struct *cmd,
> >>>        int     fd, res, len, e;
> >>>        char    *amount, *path;
> >>>        DIR     *dirstream =3D NULL;
> >>> -     int ret;
> >>> +     int ret =3D 0;
> >>>        bool enqueue =3D false;
> >>>        bool cancel =3D false;
> >>>
> >>> @@ -1277,10 +1301,17 @@ static int cmd_filesystem_resize(const struct=
 cmd_struct *cmd,
> >>>                }
> >>>        }
> >>>
> >>> +     amount =3D (char *)malloc(BTRFS_VOL_NAME_MAX);
> >>> +     if (!amount)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     strcpy(amount, argv[optind]);
> >>> +
> >>>        ret =3D check_resize_args(amount, path);
> >>>        if (ret !=3D 0) {
> >>>                close_file_or_dir(fd, dirstream);
> >>> -             return 1;
> >>> +             ret =3D 1;
> >>> +             goto free_amount;
> >>>        }
> >>>
> >>>        memset(&args, 0, sizeof(args));
> >>> @@ -1298,7 +1329,7 @@ static int cmd_filesystem_resize(const struct c=
md_struct *cmd,
> >>>                        error("unable to resize '%s': %m", path);
> >>>                        break;
> >>>                }
> >>> -             return 1;
> >>> +             ret =3D 1;
> >>>        } else if (res > 0) {
> >>>                const char *err_str =3D btrfs_err_str(res);
> >>>
> >>> @@ -1308,9 +1339,11 @@ static int cmd_filesystem_resize(const struct =
cmd_struct *cmd,
> >>>                        error("resizing of '%s' failed: unknown error =
%d",
> >>>                                path, res);
> >>>                }
> >>> -             return 1;
> >>> +             ret =3D 1;
> >>>        }
> >>> -     return 0;
> >>> +free_amount:
> >>> +     free(amount);
> >>> +     return ret;
> >>>    }
> >>>    static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
> >>>
