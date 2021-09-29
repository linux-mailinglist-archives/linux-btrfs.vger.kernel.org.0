Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063B741C227
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 11:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245238AbhI2KB0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 06:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245211AbhI2KBZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 06:01:25 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFFFC06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 02:59:44 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id gs10so1090588qvb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LqAH8ZIP9dqYS/xVKthFhp3Mvyq3SV734PnRiOVUT/I=;
        b=EsHEPPl7g8hQ/p7Ov6Tq2KABGtglC5BsaiYLT7hRUdJhejxCYm5MCYV6SZTMI9jt+x
         VQAVyofq1ID/GHgwjE0VYy7uE4SjPyOSuN4uuYPJTkX3eGJv3fXfW4nXWUYYxw2I9L04
         5Y1v5bg7Bru8K/naH0/Si7fNhWnkXm2TJJXz8tXTB4/lYkf+yZc3BoxXiA4ChkboXER1
         kx7IBC9FapgLiyJEWTk6IEkDyTd5jMdjb60qwC5OQWQ1e59yYxhbW9hUZFzrSJ4LjxxT
         zjHoK/jOfNQrZa1lYegVFbL/WZo2npS3O3kQS+OFmvM2zgtGor2a7wG8m8yFhTMPo1K2
         tgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LqAH8ZIP9dqYS/xVKthFhp3Mvyq3SV734PnRiOVUT/I=;
        b=kZIvAdhlTtdKAsxfb01j6Rb2KcCmdWssm+tAGrz+hpBJYk7W6d18B2PUfDrK/g9Do0
         ky/LfVajbITLMAWfnJJ/v8sEa3PL59CtLFhVMOTIEKcBauiOqF45jjxX9pvBgJlVrfKE
         BxletSZlsLyn0wpObdtsBy2MA2BtvFMoA4gc5UE28oq1WP0VW4pX61SUhWIvsdPiVPgp
         S5qos5usgASc99K3E4tfF3Z1mgdWuK3z7iv7y0iK+yvNTRTUWCmSr26EpbY5nuprK/rk
         PCuOeG0y+wF0WEqdRD9dyKWkGUQXsJeGlKLsYaFBpSINjvkOtUyK2khjLdDPgaDjeBgc
         1T3A==
X-Gm-Message-State: AOAM532AfzyKHkWlqQQHlCiGVeIwbidE6Wsv0E26kILUrCA/bWitm/Fv
        ww7f4ltXygpN6YdxEeMHZ6pglRg6j0gDN78/yhA=
X-Google-Smtp-Source: ABdhPJxLEzE/FCotP1BNl/dcs6X+vwlYahGDtGoI8qDdZoFXFqzjn2P4VPK7nU5Q5vcZfg/QQHwOHexWjq/wrC6Ewsc=
X-Received: by 2002:a05:6214:1430:: with SMTP id o16mr10092726qvx.66.1632909583808;
 Wed, 29 Sep 2021 02:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210928235159.9440-1-wqu@suse.com> <CAL3q7H4OqEpAEWhGUH4okvOedhdK0dChYHdJkYrv-1vsAqKAow@mail.gmail.com>
 <99b58a1c-7cae-5311-1747-d51c4b5415a5@gmx.com>
In-Reply-To: <99b58a1c-7cae-5311-1747-d51c4b5415a5@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 29 Sep 2021 10:59:07 +0100
Message-ID: <CAL3q7H7doRb75LRJGbuyEJu5V+DDhaq8qytWTnYr1wQ7Z-b_yA@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs-progs: receive: fallback to buffered copy if
 clone failed
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 29, 2021 at 10:33 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/9/29 17:27, Filipe Manana wrote:
> > On Wed, Sep 29, 2021 at 12:55 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BUG]
> >> There are two every basic send streams:
> >> (a/m/ctime and uuid omitted)
> >>
> >>    Stream 1: (Parent subvolume)
> >>    subvol   ./parent_subv           transid=3D8
> >>    chown    ./parent_subv/          gid=3D0 uid=3D0
> >>    chmod    ./parent_subv/          mode=3D755
> >>    utimes   ./parent_subv/
> >>    mkfile   ./parent_subv/o257-7-0
> >>    rename   ./parent_subv/o257-7-0  dest=3D./parent_subv/source
> >>    utimes   ./parent_subv/
> >>    write    ./parent_subv/source    offset=3D0 len=3D16384
> >>    chown    ./parent_subv/source    gid=3D0 uid=3D0
> >>    chmod    ./parent_subv/source    mode=3D600
> >>    utimes   ./parent_subv/source
> >>
> >>    Stream 2: (snapshot and clone)
> >>    snapshot ./dest_subv             transid=3D14 parent_transid=3D10
> >>    utimes   ./dest_subv/
> >>    mkfile   ./dest_subv/o258-14-0
> >>    rename   ./dest_subv/o258-14-0   dest=3D./dest_subv/reflink
> >>    utimes   ./dest_subv/
> >>    clone    ./dest_subv/reflink     offset=3D0 len=3D16384 from=3D./de=
st_subv/source clone_offset=3D0
> >>    chown    ./dest_subv/reflink     gid=3D0 uid=3D0
> >>    chmod    ./dest_subv/reflink     mode=3D600
> >>    utimes   ./dest_subv/reflink
> >>
> >> But if we receive the first stream with default mount options, then
> >> remount to nodatasum, and try to receive the second stream, it will fa=
il:
> >>
> >>   # mount /mnt/btrfs
> >>   # btrfs receive -f ~/parent_stream /mnt/btrfs/
> >>   At subvol parent_subv
> >>   # mount -o remount,nodatasum /mnt/btrfs
> >>   # btrfs receive -f ~/clone_stream /mnt/btrfs/
> >>   At snapshot dest_subv
> >>   ERROR: failed to clone extents to reflink: Invalid argument
> >>   # echo $?
> >>   1
> >>
> >> [CAUSE]
> >> Btrfs doesn't allow clone source and destination to have different NOD=
ATASUM
> >> flags.
> >> This is to prevent a data extent to be owned by both NODATASUM inode a=
nd
> >> regular DATASUM inode.
> >>
> >> For above receive operations, the clone destination is inheriting the
> >> NODATASUM flag from mount option, while the clone source has no
> >> NODATASUM flag, thus preventing us from doing the clone.
> >>
> >> [FIX]
> >> Btrfs send/receive doesn't require the underlying inode has the same
> >> flags (thus we can send from compressed extent and receive on a
> >> non-compressed filesystem).
> >>
> >> So here we can just fall back to buffered write to copy the data from
> >> the source file if we got an -EINVAL error.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Reason for RFC:
> >>
> >> Such fallback can lead to hidden bugs not being exposed, thus a new
> >> warning is added for such fallback case.
> >>
> >> Personally I really want to do more comprehensive check in user space =
to
> >> ensure it's only mismatching NODATASUM flags causing the problem.
> >> Then we can completely remove the warning message.
> >>
> >> But unfortunately that check can go out-of-sync with kernel and due to
> >> the lack of NODATASUM flags interface we're not really able to check
> >> that easily.
> >>
> >> So I took the advice from Filipe to just do a simple fall back.
> >>
> >> Any feedback on such maybe niche point would help.
> >> (Really hope it's me being paranoid again)
> >> ---
> >>   cmds/receive.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++=
--
> >>   1 file changed, 55 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/cmds/receive.c b/cmds/receive.c
> >> index 48c774cea587..4cb857a13cdf 100644
> >> --- a/cmds/receive.c
> >> +++ b/cmds/receive.c
> >> @@ -705,6 +705,51 @@ out:
> >>          return ret;
> >>   }
> >>
> >> +#define BUFFER_SIZE    SZ_32K
> >> +static int buffered_copy(int src_fd, int dst_fd, u64 src_offset, u64 =
len,
> >
> > At the very least leave a blank line between the #define and the
> > function's declaration.
> >
> >> +                        u64 dest_offset)
> >> +{
> >> +       unsigned char *buf;
> >> +       u64 cur_offset =3D 0;
> >> +       int ret =3D 0;
> >> +
> >> +       buf =3D calloc(BUFFER_SIZE, 1);
> >
> > It could be simpler:
> >
> > char buf[SZ_32K];
> >
> > then use ARRAY_SIZE() below.
> >
> >> +       if (!buf)
> >> +               return -ENOMEM;
> >> +
> >> +       while (cur_offset < len) {
> >
> > This is a bit confusing, comparing an offset to a length.
> > Renaming "cur_offset" to "copied" would be more logical imo.
> >
> >> +               u32 copy_len =3D min_t(u32, BUFFER_SIZE, len - cur_off=
set);
> >> +               u32 write_offset =3D 0;
> >> +               ssize_t read_size;
> >> +
> >> +               read_size =3D pread(src_fd, buf, copy_len, src_offset =
+ cur_offset);
> >> +               if (read_size < 0) {
> >> +                       ret =3D -errno;
> >> +                       error("failed to read source file: %m");
> >> +                       goto out;
> >> +               }
> >
> > Normally we should only exit if errno is not EINTR, and retry
> > (continue) on the EINTR case.
>
> For this, I'm a little concerned.
>
> EINTR means the operation is interrupted (by signal).
> In that case, doesn't it mean the user want to stop the receive?

There will be plenty of opportunities to be interrupted and still be respon=
sive.
But ok, you can leave it as it is.

>
> >
> >> +
> >> +               /* Write the buffer to dest file */
> >> +               while (write_offset < read_size) {
> >
> > Same here, like "write_offset" to "written".
> >
> >> +                       ssize_t write_size;
> >> +
> >> +                       write_size =3D pwrite(dst_fd, buf + write_offs=
et,
> >> +                                       read_size - write_offset,
> >> +                                       dest_offset + cur_offset + wri=
te_offset);
> >> +                       if (write_size < 0) {
> >> +                               ret =3D -errno;
> >> +                               error("failed to write source file: %m=
");
> >> +                               goto out;
> >> +                       }
> >
> > Same here regarding dealing with EINTR.
> >
> >> +                       write_offset +=3D write_size;
> >> +               }
> >> +               cur_offset +=3D read_size;
> >> +       }
> >> +out:
> >> +       free(buf);
> >> +       return ret;
> >> +}
> >> +
> >>   static int process_clone(const char *path, u64 offset, u64 len,
> >>                           const u8 *clone_uuid, u64 clone_ctransid,
> >>                           const char *clone_path, u64 clone_offset,
> >> @@ -788,8 +833,16 @@ static int process_clone(const char *path, u64 of=
fset, u64 len,
> >>          ret =3D ioctl(rctx->write_fd, BTRFS_IOC_CLONE_RANGE, &clone_a=
rgs);
> >>          if (ret < 0) {
> >>                  ret =3D -errno;
> >> -               error("failed to clone extents to %s: %m", path);
> >> -               goto out;
> >> +               if (ret !=3D -EINVAL) {
> >> +                       error("failed to clone extents to %s: %m", pat=
h);
> >> +                       goto out;
> >> +               }
> >> +
> >> +               warning(
> >> +               "failed to clone extents to %s, fallback to buffered w=
rite",
> >> +                       path);
> >
> > What if we have thousands of clone operations?
> > Is there any rate limited print() in progs like there is for kernel?
>
> Unfortunately we don't yet have.
>
> But the good news (that I didn't catch at time of writing) is, we now
> have global verbose/quite switch, so that we can easily hide those
> warning by default and only output such warning for verbose run.

The problem with this is that it will possibly hide future bugs with
the kernel sending incorrect clone operations.

Having this fallback-to-read-write behaviour by default would hide
some bugs we had in the past on the kernel side, and unless users
start running receive with the verbose switch, we won't know about it.
Even if they do run with the verbose switch, some might not notice the
warnings at all, and for those who notice it they might not bother to
report the warnings since the receive succeeded and they didn't find
any data corruption/loss.

Or we might start receiving reports about send/receive doing less
cloning/extent sharing than before, and we won't easily know that the
receive side has fallen back to this read-write behaviour due to some
bug on kernel.

That's why making the behaviour explicit through a new command line
flag would cause less surprises and make it harder to miss regressions
on the kernel. And add some documentation explaining on which cases
the flag is useful.

Thanks.

>
> Thanks,
> Qu
>
> >
> > That's one reason why my proposal had in mind an optional flag to
> > trigger this behaviour.
> >
> > Thanks for doing it, I was planning on doing something similar soon.
> >
> >> +               ret =3D buffered_copy(clone_fd, rctx->write_fd, clone_=
offset,
> >> +                                   len, offset);
> >>          }
> >>
> >>   out:
> >> --
> >> 2.33.0
> >>
> >
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
