Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299CF3224CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 05:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhBWEE1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 23:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBWEEY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 23:04:24 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA9AC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Feb 2021 20:03:42 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id u3so15161986ybk.6
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Feb 2021 20:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SeykFUE3yXwSv1JV1hY7rnYhSo9jmjBPoU3cEfJTvg8=;
        b=dDOBC3ipJShrqzQ5knkAC3qZNkWRut7EorzBWINOFp59mVfxKn74nvLLt2AEiETdpY
         iww9ilGBqovLv3fjJT0aXzVko+JjWFL/9qOLvMD19cd0cWsV9W8/9CruZKWzTLgabevX
         LyDVgU6inv8GREEshuEVL5/anT1RgvgKZMTy7GOdR7Qa4S0OebwMdvAVPv7BZO/wo5d/
         THmrL9i8/WF0v1SygBcel2gVn0lw5R/9uPA9el9b1vnX4/003tJ6noJ/nzcwsvtrbZT6
         c64kVjqS8DpvW2BOdD2mVw6Cpyv7fOsN8JN5BfprrZ8ez87ch5K5MbabdLFW3p9pd3nA
         dy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SeykFUE3yXwSv1JV1hY7rnYhSo9jmjBPoU3cEfJTvg8=;
        b=YqtabgjWicavijGSpWjjNyy8MbWFpKtWbdDFKszd4jXEBJaVXHn114KzGe0X2uZCTb
         SmzyyS0V3JWLiQ63XmOFLtIax7M5Gtr9+x4nWaiTqdq8MNOLm9QSak7lzYUIH2mOqLXZ
         0qakm3WoscGNvGRuaxCO1ReFQBN1Kyasx0szGYcStHAejyDLU7Fd9iht+HjpjWWElGaE
         goWxFq5cGiRmF3qkJZA6rhewAZTiPk3V+gojI0Eop0F0KvJS8MBY+h9bD7RV+QccCObh
         pHGLH2wDM/5JxcgpjIilIavVVX/ltGByLq4/ktg4DjSUJxn38HOEGwLzXveprWvjrbeQ
         xZaQ==
X-Gm-Message-State: AOAM532vsnxmgwjZY91p9HuB1g6mhwcPiFHOfPwia4R/0U/rzT/GjAHo
        YTkfZ752rZXD+Boap1P+etObQWjTlrVYHV3rce/nT/Ue6eeNCA==
X-Google-Smtp-Source: ABdhPJyxQu0n3UXe8iKKTBrsCV730qYEs81A5eVH3YHIIXZmEvcxRLS2PXQQq468+ZHEx+DrYFYJWKe3UZfR9n5rgIQ=
X-Received: by 2002:a25:46d6:: with SMTP id t205mr34136646yba.47.1614053021743;
 Mon, 22 Feb 2021 20:03:41 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com> <CAEg-Je9NGV0Mvhw7v8CwcyAZ9zd9T5Fmk2iQyZ1PFWVUOXaP+Q@mail.gmail.com>
 <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com> <CAEg-Je-zRWrkKOQM-Y_Y17eHhUrJe+d1_H9iLzQB4w7T+Een=w@mail.gmail.com>
 <74ca64e1-3933-c12b-644a-21745cf2d849@toxicpanda.com> <CAEg-Je9FZhLMx0MuxhyhTDUsRzfbi2_VZsHa3Bs+46jY8F82ZA@mail.gmail.com>
 <ab38ba5a-f684-0634-c5d8-d317541e37b9@toxicpanda.com> <CAEg-Je-cxaM3SuoLfHL6cGv0-0r7s-hccS4ixs66oO6YYOtbwg@mail.gmail.com>
 <56747283-fe34-51c5-9dbf-930bdafffaed@toxicpanda.com> <CAEg-Je_=jUMJfAqwtuZwcPE4+HOAJB7JC5gKSw4EeZrutxk5kA@mail.gmail.com>
 <58f4fe54-a462-b256-df60-17b1084235f6@toxicpanda.com> <CAEg-Je-_r3_AsLHa_HDDOUwVs+Jtty5roFvEyF4K-T2D7oEayA@mail.gmail.com>
 <58246f4c-4e26-c89c-a589-376cfe23d783@toxicpanda.com>
In-Reply-To: <58246f4c-4e26-c89c-a589-376cfe23d783@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 22 Feb 2021 23:03:05 -0500
Message-ID: <CAEg-Je-yPqueyW3JqSWrAE_9ckc1KTyaNoFwjbozNLrvb7_tEg@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 22, 2021 at 2:34 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/21/21 1:27 PM, Neal Gompa wrote:
> > On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef@toxicpanda.com> wro=
te:
> >>
> >> On 2/17/21 11:29 AM, Neal Gompa wrote:
> >>> On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@toxicpanda.com> wr=
ote:
> >>>>
> >>>> On 2/17/21 9:50 AM, Neal Gompa wrote:
> >>>>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicpanda.com> =
wrote:
> >>>>>>
> >>>>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
> >>>>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >>>>>>>>
> >>>>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
> >>>>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>>>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpand=
a.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>>>>>>>>>> Hey all,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> So one of my main computers recently had a disk controller =
failure
> >>>>>>>>>>>>> that caused my machine to freeze. After rebooting, Btrfs re=
fuses to
> >>>>>>>>>>>>> mount. I tried to do a mount and the following errors show =
up in the
> >>>>>>>>>>>>> journal:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device =
sda3): disk space caching is enabled
> >>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device =
sda3): has skinny extents
> >>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (dev=
ice sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D20365=
7, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device=
 sda3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (dev=
ice sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D20365=
7, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device=
 sda3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (devi=
ce sda3): couldn't read tree root
> >>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device=
 sda3): open_ctree failed
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I've tried to do -o recovery,ro mount and get the same issu=
e. I can't
> >>>>>>>>>>>>> seem to find any reasonably good information on how to do r=
ecovery in
> >>>>>>>>>>>>> this scenario, even to just recover enough to copy data off=
.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I'm on Fedora 33, the system was on Linux kernel version 5.=
9.16 and
> >>>>>>>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel version 5=
.10.14. I'm
> >>>>>>>>>>>>> using btrfs-progs v5.10.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Can anyone help?
> >>>>>>>>>>>>
> >>>>>>>>>>>> Can you try
> >>>>>>>>>>>>
> >>>>>>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
> >>>>>>>>>>>>
> >>>>>>>>>>>> That should fix the inode generation thing so it's sane, and=
 then the tree
> >>>>>>>>>>>> checker will allow the fs to be read, hopefully.  If not we =
can work out some
> >>>>>>>>>>>> other magic.  Thanks,
> >>>>>>>>>>>>
> >>>>>>>>>>>> Josef
> >>>>>>>>>>>
> >>>>>>>>>>> I got the same error as I did with btrfs-check --readonly...
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Oh lovely, what does btrfs check --readonly --backup do?
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> No dice...
> >>>>>>>>>
> >>>>>>>>> # btrfs check --readonly --backup /dev/sda3
> >>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 found =
888895
> >>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 found =
888895
> >>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 found =
888895
> >>>>>>>>
> >>>>>>>> Hey look the block we're looking for, I wrote you some magic, ju=
st pull
> >>>>>>>>
> >>>>>>>> https://github.com/josefbacik/btrfs-progs/tree/for-neal
> >>>>>>>>
> >>>>>>>> build, and then run
> >>>>>>>>
> >>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
> >>>>>>>>
> >>>>>>>> This will force us to point at the old root with (hopefully) the=
 right bytenr
> >>>>>>>> and gen, and then hopefully you'll be able to recover from there=
.  This is kind
> >>>>>>>> of saucy, so yolo, but I can undo it if it makes things worse.  =
Thanks,
> >>>>>>>>
> >>>>>>>
> >>>>>>> # btrfs check --readonly /dev/sda3
> >>>>>>>> Opening filesystem to check...
> >>>>>>>> ERROR: could not setup extent tree
> >>>>>>>> ERROR: cannot open file system
> >>>>>>> # btrfs check --clear-space-cache v1 /dev/sda3
> >>>>>>>> Opening filesystem to check...
> >>>>>>>> ERROR: could not setup extent tree
> >>>>>>>> ERROR: cannot open file system
> >>>>>>>
> >>>>>>> It's better, but still no dice... :(
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> Hmm it's not telling us what's wrong with the extent tree, which i=
s annoying.
> >>>>>> Does mount -o rescue=3Dall,ro work now that the root tree is norma=
l?  Thanks,
> >>>>>>
> >>>>>
> >>>>> Nope, I see this in the journal:
> >>>>>
> >>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): e=
nabling all of the rescue options
> >>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): i=
gnoring data csums
> >>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): i=
gnoring bad roots
> >>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): d=
isabling log replay at mount time
> >>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): d=
isk space caching is enabled
> >>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): h=
as skinny extents
> >>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): =
tree level mismatch detected, bytenr=3D791281664 level expected=3D1 has=3D2
> >>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): =
tree level mismatch detected, bytenr=3D791281664 level expected=3D1 has=3D2
> >>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (device sda3)=
: couldn't read tree root
> >>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): =
open_ctree failed
> >>>>>
> >>>>>
> >>>>
> >>>> Ok git pull for-neal, rebuild, then run
> >>>>
> >>>> btrfs-neal-magic /dev/sda3 791281664 888895 2
> >>>>
> >>>> I thought of this yesterday but in my head was like "naaahhhh, whats=
 the chances
> >>>> that the level doesn't match??".  Thanks,
> >>>>
> >>>
> >>> Tried rescue mount again after running that and got a stack trace in
> >>> the kernel, detailed in the following attached log.
> >>
> >> Huh I wonder how I didn't hit this when testing, I must have only test=
ed with
> >> zero'ing the extent root and the csum root.  You're going to have to b=
uild a
> >> kernel with a fix for this
> >>
> >> https://paste.centos.org/view/7b48aaea
> >>
> >> and see if that gets you further.  Thanks,
> >>
> >
> > I built a kernel build as an RPM with your patch[1] and tried it.
> >
> > [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 /mnt
> > Killed
> >
> > The log from the journal is attached.
>
>
> Ahh crud my bad, this should do it
>
> https://paste.centos.org/view/ac2e61ef
>

Patch doesn't apply (note it is patch 667 below):

ngompa@fedora-rawhide-skuldvm ~/f/kernel (rawhide)> fedpkg prep

setting SOURCE_DATE_EPOCH=3D1613347200
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.f5LOt6
+ umask 022
+ cd /home/ngompa/fedora-scm/kernel
+ patch_command=3D'patch -p1 -F1 -s'
+ cd /home/ngompa/fedora-scm/kernel
+ rm -rf kernel-5.11
+ /usr/bin/mkdir -p kernel-5.11
+ cd kernel-5.11
+ /usr/bin/xz -dc /home/ngompa/fedora-scm/kernel/linux-5.11.tar.xz
+ /usr/bin/tar -xof -
+ STATUS=3D0
+ '[' 0 -ne 0 ']'
+ /usr/bin/chmod -Rf a+rX,u+w,g-w,o-w .
+ mv linux-5.11 linux-5.11.0-155.nealbtrfstest.1.fc35.x86_64
+ cd linux-5.11.0-155.nealbtrfstest.1.fc35.x86_64
+ cp -a /home/ngompa/fedora-scm/kernel/Makefile.rhelver .
+ ApplyOptionalPatch patch-5.11.0-redhat.patch
+ local patch=3Dpatch-5.11.0-redhat.patch
+ shift
+ '[' '!' -f /home/ngompa/fedora-scm/kernel/patch-5.11.0-redhat.patch ']'
++ awk '{print $1}'
++ wc -l /home/ngompa/fedora-scm/kernel/patch-5.11.0-redhat.patch
+ local C=3D3166
+ '[' 3166 -gt 9 ']'
+ ApplyPatch patch-5.11.0-redhat.patch
+ local patch=3Dpatch-5.11.0-redhat.patch
+ shift
+ '[' '!' -f /home/ngompa/fedora-scm/kernel/patch-5.11.0-redhat.patch ']'
+ case "$patch" in
+ patch -p1 -F1 -s
+ echo 'Patch #666 (linux-5.11-btrfs-handle-null-roots.diff):'
Patch #666 (linux-5.11-btrfs-handle-null-roots.diff):
+ /usr/bin/patch --no-backup-if-mismatch -p1 --fuzz=3D0
patching file fs/btrfs/ctree.c
Hunk #1 succeeded at 2594 (offset -4 lines).
patching file fs/btrfs/volumes.c
Hunk #1 succeeded at 7282 (offset -166 lines).
+ echo 'Patch #667 (linux-5.11-btrfs-init-devices-more-gracefully.diff):'
Patch #667 (linux-5.11-btrfs-init-devices-more-gracefully.diff):
+ /usr/bin/patch --no-backup-if-mismatch -p1 --fuzz=3D0
patching file fs/btrfs/disk-io.c
patching file fs/btrfs/volumes.c
Hunk #1 FAILED at 7282.
1 out of 1 hunk FAILED -- saving rejects to file fs/btrfs/volumes.c.rej
error: Bad exit status from /var/tmp/rpm-tmp.f5LOt6 (%prep)


RPM build errors:
   Bad exit status from /var/tmp/rpm-tmp.f5LOt6 (%prep)
Could not execute prep: Failed to execute command.





--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
