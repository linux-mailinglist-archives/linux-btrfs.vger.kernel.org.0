Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42E232C54E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450715AbhCDAT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245619AbhCCTlu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Mar 2021 14:41:50 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6552C061760
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Mar 2021 11:39:33 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id n195so25798869ybg.9
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Mar 2021 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1xFxlimKfdwid+zjBCdmzYbsfDZtFyDi1tGd3Nob7VE=;
        b=VgVYkLe08E8Anej4AVn7Tsgczpk9ci/rPsdX9fsiER03i6w5kQ/Rl4PMZwi23P5G1D
         Bluve13luqGRF6oqa7JHQIzeuPBQI+W5EI/ZF04/tVqwt78X/x7f2hNtw9vqujqh7a4W
         iRU8nw16BbT0CBOokSFiNcn0Hgymcru846H298gmG/n6TMNgBSootdY2f8RCjFCJD5D6
         Ry/8VX4li5IunYWEAMrpd1Qkz0bozz5OyMKlpZ16hARsQjGCgP/hTFc55eLVjDLKXpIp
         V62xIojsxpgEuteY/IySpVd+1cMf9wiqKmfUkSk3cwQDLBkZSQP2/EEyBNndG7WA0B0u
         4Gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1xFxlimKfdwid+zjBCdmzYbsfDZtFyDi1tGd3Nob7VE=;
        b=Cl4FwYlGMiXQv/AbIXig3ZXLhhyFF+ul3S4pSkr4lhq7pXkY6PkC9KHpJK2D/wECQw
         1IfNNFRXK5YJ28tyDitlq1f+Cqt4himK7BWNVGakxeN5mDN3LCxSno7G9csaGoEgDOVg
         LeonzINcL9mCYFza6B/4ZkEaLlswszWSb/BmKiJEIICy539EyWfB2HXZt2SIbKKvIPNn
         exj2XQoPs5rn8QNVv01xOUWvCpzF8pKIqc+4+JyHBTNMoehS5akgBtVp2s0xL2bioHvW
         gTRpW6D29Wp/eUEHKjDVGECKddi0DsFCqqwJBj3ZyAdbU7UgyyIcxP6gf8E9921lRIHa
         3sbA==
X-Gm-Message-State: AOAM531gWYhKm0fOOAW8IwJKvOukkQHEli+8xokYNmWggSGYrl9bu92v
        kVX622UJZcT1TLEzYcsg4Ao3EkNFWmPPAAfN1EExhuK6CMB68w==
X-Google-Smtp-Source: ABdhPJxnVkpQgv7foTJBoXbwlNDokuR0/GokQSn2NFBKxQUtuXJho6F5pNd5mAnY2LXpQ7isb4GU8ABjxMkBrjoEcAQ=
X-Received: by 2002:a05:6902:727:: with SMTP id l7mr1300123ybt.184.1614800372824;
 Wed, 03 Mar 2021 11:39:32 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <74ca64e1-3933-c12b-644a-21745cf2d849@toxicpanda.com> <CAEg-Je9FZhLMx0MuxhyhTDUsRzfbi2_VZsHa3Bs+46jY8F82ZA@mail.gmail.com>
 <ab38ba5a-f684-0634-c5d8-d317541e37b9@toxicpanda.com> <CAEg-Je-cxaM3SuoLfHL6cGv0-0r7s-hccS4ixs66oO6YYOtbwg@mail.gmail.com>
 <56747283-fe34-51c5-9dbf-930bdafffaed@toxicpanda.com> <CAEg-Je_=jUMJfAqwtuZwcPE4+HOAJB7JC5gKSw4EeZrutxk5kA@mail.gmail.com>
 <58f4fe54-a462-b256-df60-17b1084235f6@toxicpanda.com> <CAEg-Je-_r3_AsLHa_HDDOUwVs+Jtty5roFvEyF4K-T2D7oEayA@mail.gmail.com>
 <58246f4c-4e26-c89c-a589-376cfe23d783@toxicpanda.com> <CAEg-Je-yPqueyW3JqSWrAE_9ckc1KTyaNoFwjbozNLrvb7_tEg@mail.gmail.com>
 <a9561d44-24a3-fa87-e292-98feb4846ab9@toxicpanda.com> <CAEg-Je8o2GiAH2wC9DXiMdMSCFnAjeV6UH-qaobk_0qYLNsPsQ@mail.gmail.com>
 <95e8db7d-eff3-e694-c315-f7984b5f49e0@toxicpanda.com> <CAEg-Je_s6EAHwj2LWYRLdMHF_kRuY_JQoLfWMqDgcROZatnP+g@mail.gmail.com>
 <ef2ec021-52d3-2da4-f59a-fa7016c95d90@toxicpanda.com>
In-Reply-To: <ef2ec021-52d3-2da4-f59a-fa7016c95d90@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 3 Mar 2021 14:38:56 -0500
Message-ID: <CAEg-Je_HKgGLnF6F_3dXd+9NFa9cTceWWtTUhSSjNovsze_wQg@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 3, 2021 at 1:42 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/24/21 10:47 PM, Neal Gompa wrote:
> > On Wed, Feb 24, 2021 at 10:44 AM Josef Bacik <josef@toxicpanda.com> wro=
te:
> >>
> >> On 2/24/21 9:23 AM, Neal Gompa wrote:
> >>> On Tue, Feb 23, 2021 at 10:05 AM Josef Bacik <josef@toxicpanda.com> w=
rote:
> >>>>
> >>>> On 2/22/21 11:03 PM, Neal Gompa wrote:
> >>>>> On Mon, Feb 22, 2021 at 2:34 PM Josef Bacik <josef@toxicpanda.com> =
wrote:
> >>>>>>
> >>>>>> On 2/21/21 1:27 PM, Neal Gompa wrote:
> >>>>>>> On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef@toxicpanda.co=
m> wrote:
> >>>>>>>>
> >>>>>>>> On 2/17/21 11:29 AM, Neal Gompa wrote:
> >>>>>>>>> On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2/17/21 9:50 AM, Neal Gompa wrote:
> >>>>>>>>>>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicpanda=
.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
> >>>>>>>>>>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpan=
da.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicp=
anda.com> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@tox=
icpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>> Hey all,
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> So one of my main computers recently had a disk contr=
oller failure
> >>>>>>>>>>>>>>>>>>> that caused my machine to freeze. After rebooting, Bt=
rfs refuses to
> >>>>>>>>>>>>>>>>>>> mount. I tried to do a mount and the following errors=
 show up in the
> >>>>>>>>>>>>>>>>>>> journal:
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (d=
evice sda3): disk space caching is enabled
> >>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (d=
evice sda3): has skinny extents
> >>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critica=
l (device sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=
=3D203657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (=
device sda3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critica=
l (device sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=
=3D203657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (=
device sda3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning=
 (device sda3): couldn't read tree root
> >>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (=
device sda3): open_ctree failed
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> I've tried to do -o recovery,ro mount and get the sam=
e issue. I can't
> >>>>>>>>>>>>>>>>>>> seem to find any reasonably good information on how t=
o do recovery in
> >>>>>>>>>>>>>>>>>>> this scenario, even to just recover enough to copy da=
ta off.
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> I'm on Fedora 33, the system was on Linux kernel vers=
ion 5.9.16 and
> >>>>>>>>>>>>>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel ver=
sion 5.10.14. I'm
> >>>>>>>>>>>>>>>>>>> using btrfs-progs v5.10.
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> Can anyone help?
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Can you try
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> That should fix the inode generation thing so it's san=
e, and then the tree
> >>>>>>>>>>>>>>>>>> checker will allow the fs to be read, hopefully.  If n=
ot we can work out some
> >>>>>>>>>>>>>>>>>> other magic.  Thanks,
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Josef
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> I got the same error as I did with btrfs-check --readon=
ly...
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Oh lovely, what does btrfs check --readonly --backup do?
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> No dice...
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> # btrfs check --readonly --backup /dev/sda3
> >>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 =
found 888895
> >>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 =
found 888895
> >>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 =
found 888895
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Hey look the block we're looking for, I wrote you some mag=
ic, just pull
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> https://github.com/josefbacik/btrfs-progs/tree/for-neal
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> build, and then run
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> This will force us to point at the old root with (hopefull=
y) the right bytenr
> >>>>>>>>>>>>>> and gen, and then hopefully you'll be able to recover from=
 there.  This is kind
> >>>>>>>>>>>>>> of saucy, so yolo, but I can undo it if it makes things wo=
rse.  Thanks,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> # btrfs check --readonly /dev/sda3
> >>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>> # btrfs check --clear-space-cache v1 /dev/sda3
> >>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> It's better, but still no dice... :(
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Hmm it's not telling us what's wrong with the extent tree, w=
hich is annoying.
> >>>>>>>>>>>> Does mount -o rescue=3Dall,ro work now that the root tree is=
 normal?  Thanks,
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Nope, I see this in the journal:
> >>>>>>>>>>>
> >>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sd=
a3): enabling all of the rescue options
> >>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sd=
a3): ignoring data csums
> >>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sd=
a3): ignoring bad roots
> >>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sd=
a3): disabling log replay at mount time
> >>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sd=
a3): disk space caching is enabled
> >>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sd=
a3): has skinny extents
> >>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device s=
da3): tree level mismatch detected, bytenr=3D791281664 level expected=3D1 h=
as=3D2
> >>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device s=
da3): tree level mismatch detected, bytenr=3D791281664 level expected=3D1 h=
as=3D2
> >>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (device=
 sda3): couldn't read tree root
> >>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device s=
da3): open_ctree failed
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Ok git pull for-neal, rebuild, then run
> >>>>>>>>>>
> >>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895 2
> >>>>>>>>>>
> >>>>>>>>>> I thought of this yesterday but in my head was like "naaahhhh,=
 whats the chances
> >>>>>>>>>> that the level doesn't match??".  Thanks,
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Tried rescue mount again after running that and got a stack tra=
ce in
> >>>>>>>>> the kernel, detailed in the following attached log.
> >>>>>>>>
> >>>>>>>> Huh I wonder how I didn't hit this when testing, I must have onl=
y tested with
> >>>>>>>> zero'ing the extent root and the csum root.  You're going to hav=
e to build a
> >>>>>>>> kernel with a fix for this
> >>>>>>>>
> >>>>>>>> https://paste.centos.org/view/7b48aaea
> >>>>>>>>
> >>>>>>>> and see if that gets you further.  Thanks,
> >>>>>>>>
> >>>>>>>
> >>>>>>> I built a kernel build as an RPM with your patch[1] and tried it.
> >>>>>>>
> >>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 /mnt
> >>>>>>> Killed
> >>>>>>>
> >>>>>>> The log from the journal is attached.
> >>>>>>
> >>>>>>
> >>>>>> Ahh crud my bad, this should do it
> >>>>>>
> >>>>>> https://paste.centos.org/view/ac2e61ef
> >>>>>>
> >>>>>
> >>>>> Patch doesn't apply (note it is patch 667 below):
> >>>>
> >>>> Ah sorry, should have just sent you an iterative patch.  You can tak=
e the above
> >>>> patch and just delete the hunk from volumes.c as you already have th=
at applied
> >>>> and then it'll work.  Thanks,
> >>>>
> >>>
> >>> Failed with a weird error...?
> >>>
> >>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sda3 /mnt
> >>> mount: /mnt: mount(2) system call failed: No such file or directory.
> >>>
> >>> Journal log with traceback attached.
> >>
> >> Last one maybe?
> >>
> >> https://paste.centos.org/view/80edd6fd
> >>
> >
> > Similar weird failure:
> >
> > [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 /mnt
> > mount: /mnt: mount(2) system call failed: No such file or directory.
> >
> > No crash in the journal this time, though:
> >
> >> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): enabling all =
of the rescue options
> >> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignoring data=
 csums
> >> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignoring bad =
roots
> >> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disabling log=
 replay at mount time
> >> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disk space ca=
ching is enabled
> >> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): has skinny ex=
tents
> >> Feb 24 22:43:19 fedora kernel: BTRFS warning (device sdb3): failed to =
read fs tree: -2
> >> Feb 24 22:43:19 fedora kernel: BTRFS error (device sdb3): open_ctree f=
ailed
> >
> >
>
> Sorry Neal, you replied when I was in the middle of something and promptl=
y
> forgot about it.  I figured the fs root was fine, can you do the followin=
g so I
> can figure out from the error messages what might be wrong
>
> btrfs check --readonly
> btrfs restore -D
> btrfs restore -l
>

It didn't work.. Here's the output:

[root@fedora ~]# btrfs check --readonly /dev/sdb3
Opening filesystem to check...
ERROR: could not setup extent tree
ERROR: cannot open file system
[root@fedora ~]# btrfs restore -D /dev/sdb3 /mnt
WARNING: could not setup extent tree, skipping it
Couldn't setup device tree
Could not open root, trying backup super
parent transid verify failed on 796082176 wanted 888894 found 888896
parent transid verify failed on 796082176 wanted 888894 found 888896
parent transid verify failed on 796082176 wanted 888894 found 888896
Ignoring transid failure
WARNING: could not setup extent tree, skipping it
Couldn't setup device tree
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 2631328071=
68
Could not open root, trying backup super
[root@fedora ~]# btrfs restore -l /dev/sdb3 /mnt
WARNING: could not setup extent tree, skipping it
Couldn't setup device tree
Could not open root, trying backup super
parent transid verify failed on 796082176 wanted 888894 found 888896
parent transid verify failed on 796082176 wanted 888894 found 888896
parent transid verify failed on 796082176 wanted 888894 found 888896
Ignoring transid failure
WARNING: could not setup extent tree, skipping it
Couldn't setup device tree
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 2631328071=
68
Could not open root, trying backup super




--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
