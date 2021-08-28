Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F21D3FA66B
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Aug 2021 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhH1PRc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Aug 2021 11:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhH1PRb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Aug 2021 11:17:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FE7C061756
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Aug 2021 08:16:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j4so21020403lfg.9
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Aug 2021 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qCiUfC4/MDAYg02wQKjMVQOjhacHjNbDOESgYL1wS1g=;
        b=qZDWleblyvfjPINz1GikYO5jVX/Z7xYfQaBTT4dAH2AEQ9uhukAArt4KPf/xVnE0cR
         l04+UK2TPtIJDn1Kql7ai430a5iBFYAa6Ntm5JiG0Ipd1CJV00iojC9Vjlkb558NQSu5
         TWw90dkUvjUvzNP1jV4NNw6+lO75Y4v9+UO6HZDP8ZQ0BYD+45ZuK2Pzto+HTb8ZkhJw
         yQaWtsctp5XNQjoPSykef7+ujM3wQRsvEFKAo8tfVBBIauY6oDeKH97R+ct1RP00Us8/
         52XxBVuJBOdGmOruN0TSBYb+1lEEa6juZauWl6B0QreU3w9TCKn3tcmGkYTfUJYf27IV
         Miww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=qCiUfC4/MDAYg02wQKjMVQOjhacHjNbDOESgYL1wS1g=;
        b=MtLn51HKKeU52itF0p3fmQw+NwRlu04y+ml9FwY8eWs+rzUzuS2W1CgTXaptJ5UjSq
         HZsNee2hP/1RapSHDm95qQOfG1177mC2GHfGf6CsLFCMWbVWP6SkAwuKAuFqxwV+74pN
         IfwFfXd6k/m9uUBk1eAM1aj6ugxYE8DODIx8CZQc9EJWi4D6J5M2MgLbeCwMEU/6PP/F
         QICQT6fBPFFR/4LsX0cDgvnjpELAxsZsDh80LGJVn0L2EoPe6WLWOVqul0QiXqh5+TtS
         3ztoMsej4VvvIE9BT9D9XDEYHyjilJLz3wkpoDttGw1l34Mfwd+IMcBUmH9nONZfxV6O
         kTIQ==
X-Gm-Message-State: AOAM53107/Kv+aEgvLYU5bMaUlFKJNKW7/5EA5alTHkIXiDi3JMj1I+C
        trMe+Xq7XsCWooBcKchYGYEf+ik4UiFfugQ6wYY=
X-Google-Smtp-Source: ABdhPJyVRmTzf3q4WgV1JDRnXcZymbY7pxi3AMyA9MEWM3mmbn2Z2P1PhCpTfiSxmU8s90HEfsASQMlsc24DMAYu0us=
X-Received: by 2002:ac2:4e62:: with SMTP id y2mr11209223lfs.9.1630163799463;
 Sat, 28 Aug 2021 08:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <1629824687-21014-1-git-send-email-zhanglikernel@gmail.com> <20210826183406.GQ3379@twin.jikos.cz>
In-Reply-To: <20210826183406.GQ3379@twin.jikos.cz>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Sat, 28 Aug 2021 23:16:28 +0800
Message-ID: <CAAa-AG=sS_4siP0Jgb_-C_j4oc7JHY98GxXr2KfY+FN-pYJtnQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: Fix the issues btrfs-convert don't
 recognition ext4 i_{a,c,a}time_extra
To:     David Sterba <dsterba@suse.cz>, Li Zhang <zhanglikernel@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Cool, thanks!

Is there any possibility that the version of the GNU build system caused
the ./configure error
to be generated? On my machine, I produced a valid ./configure, and my
compilation
environment is as follows:
aclocal:    aclocal (GNU automake) 1.13.4
autoconf:   autoconf (GNU Autoconf) 2.69
autoheader: autoheader (GNU Autoconf) 2.69
automake:   automake (GNU automake) 1.13.4
OS: centos 7.6

David Sterba <dsterba@suse.cz> =E4=BA=8E2021=E5=B9=B48=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Aug 25, 2021 at 01:04:47AM +0800, Li Zhang wrote:
> > Hi, I ran convert-tests.sh, and it reported that the
> > 019-ext4-copy-timestamps test failed. The log  is as
> > follows
> >
> > ...
> > mount -o loop -t ext4 btrfs-progs/tests/test.img btrfs-progs/tests/mnt
> > =3D=3D=3D=3D=3D=3D RUN CHECK touch btrfs-progs/tests/mnt/file
> > =3D=3D=3D=3D=3D=3D RUN CHECK stat btrfs-progs/tests/mnt/file
> > File: 'btrfs-progs/tests/mnt/file'
> > Size: 0           Blocks: 0          IO Block: 4096   regular empty fil=
e
> > Device: 700h/1792d  Inode: 13          Links: 1
> > Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root=
)
> > Context: unconfined_u:object_r:unlabeled_t:s0
> > Access: 2021-08-24 22:10:21.999209679 +0800
> > Modify: 2021-08-24 22:10:21.999209679 +0800
> > Change: 2021-08-24 22:10:21.999209679 +0800
> > ...
> > btrfs-progs/btrfs-convert btrfs-progs/tests/test.img
> > ...
> > =3D=3D=3D=3D=3D=3D RUN CHECK mount -t btrfs -o loop btrfs-progs/tests/t=
est.img btrfs-progs/tests/mnt
> > =3D=3D=3D=3D=3D=3D RUN CHECK stat btrfs-progs/tests/mnt/file
> > File: 'btrfs-progs/tests/mnt/file'
> > Size: 0           Blocks: 0          IO Block: 4096   regular empty fil=
e
> > Device: 2ch/44d Inode: 267         Links: 1
> > Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root=
)
> > Context: unconfined_u:object_r:unlabeled_t:s0
> > Access: 2021-08-24 22:10:21.000000000 +0800
> > Modify: 2021-08-24 22:10:21.000000000 +0800
> > Change: 2021-08-24 22:10:21.000000000 +0800
> > ...
> > atime on converted inode does not match
> > test failed for case 019-ext4-copy-timestamps
> >
> > Obviously, the log says that btrfs-convert does not
> > support nanoseconds. I looked at the source code and
> > found that only if ext2_fs.h defines EXT4_EPOCH_MASK
> > btrfs-convert to support nanoseconds. But in e2fsprogs,
> > EXT4_EPOCH_MASK was introduced in v1.43, but in some
> > older versions, such as v1.40, e2fsprogs actually
> > supports nanoseconds. It seems that if struct ext2_inode_large
> > contains the i_atime_extra member, ext4 is supports
> > nanoseconds, so I updated the logic to determine whether the
> > current ext4 file system supports nanosecond precision.
> > In addition, I imported some definitions to encode and
> > decode tv_nsec (copied from e2fsprogs source code).
>
> So it's supportable even up to the old versions (1.40 was released in
> 2007) with the updated detection, nice.
>
> > ---
> >  configure.ac | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure.ac b/configure.ac
> > index c4fa461..20297c5 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -253,7 +253,21 @@ AX_CHECK_DEFINE([linux/fiemap.h], [FIEMAP_EXTENT_S=
HARED], [],
> >  AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK],
> >               [AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1],
> >                          [Define to 1 if e2fsprogs defines EXT4_EPOCH_M=
ASK])],
> > -             [AC_MSG_WARN([no definition of EXT4_EPOCH_MASK found, pro=
bably old e2fsprogs, no 64bit time precision of converted images])])
> > +        [have_ext4_epoch_mask_define=3Dno])
> > +
> > +AS_IF([test "x$have_ext4_epoch_mask_define" =3D xno], [
> > +    AC_CHECK_MEMBERS([struct ext2_inode_large.i_atime_extra],
> > +        [
> > +            AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1], [Define to 1=
 if ext2_inode_large includes i_atime_extra]),
> > +            AC_DEFINE([EXT4_EPOCH_BITS], [2],[for encode and decode tv=
_nsec in ext2 inode]),
> > +            AC_DEFINE([EXT4_EPOCH_MASK], [((1 << EXT4_EPOCH_BITS) - 1)=
], [For encode and decode tv_nsec info in ext2 inode]),
> > +            AC_DEFINE([EXT4_NSEC_MASK],  [(~0UL << EXT4_EPOCH_BITS)], =
[For encode and decode tv_nsec info in ext2 inode]),
> > +            AC_DEFINE([inode_includes(size, field)],[m4_normalize[(siz=
e >=3D (sizeof(((struct ext2_inode_large *)0)->field) + offsetof(struct ext=
2_inode_large, field)))]],
>
> The "," can't be at the end of the AC_DEFINE lines, this does not
> produce valid ./configure and fails with
>
> checking for FIEMAP_EXTENT_SHARED defined in linux/fiemap.h... yes
> checking for EXT4_EPOCH_MASK defined in ext2fs/ext2_fs.h... yes
> checking for struct ext2_inode_large.i_atime_extra... yes
> ./configure: line 6487: ,: command not found
> ./configure: line 6490: ,: command not found
> ./configure: line 6493: ,: command not found
> ./configure: line 6496: ,: command not found
>
> because the "," appear in the final file as separate commands. Removing t=
hem
> produces valid script and the detection works.
>
> Added to devel, thanks.
