Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75AA324995
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 04:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhBYDsW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 22:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhBYDsT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 22:48:19 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DBFC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 19:47:39 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id u75so4053838ybi.10
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 19:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nwGXhBYEkHM2Zqaw6ajoeaFmPl4LOZFkcjzI1ymDJGc=;
        b=GffwBIkkUrSI5kqG7xlHUFQlXxjnMrRiAjYraw4T3qkrgtX25WT7n+93M539xnpL9O
         Ln9Ph6OPfwq8dbKyZHwqLGvUCpgp+9TMYPkRA8rBK1pM9nQ9gONOaKrCN0W7nG5+myBv
         1ynR9bPfeSGEtsIGfXzf3XRazXCfDD6NC1+kCFd8hvXJHgkqNnebQ438VOeeFMkddIIt
         cuA6sCZygvBKc0jC1zMCiVaG/kDu3FnlU6NiLOgCnm5nY3IGxg5p2AUZZ4rRElWkOHRT
         KeqZQI5fCciXq2YilAyuM4h/FwWzDZYdSzEB/nQ2VXABa1ryG10isMR9WSF1s56vnJAQ
         jpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nwGXhBYEkHM2Zqaw6ajoeaFmPl4LOZFkcjzI1ymDJGc=;
        b=oR2hdGtVFVR+XH+dpn5wo6FcxrBK/qyM94C7KJUSE1cSAAWQDNTQhnrSeYyVkzG3mN
         Qw9UYpinc5DSZSoYHEoagVOBml2crswuC2NBz2RfyArbGOZXTEmJuooDCtNIvhXdouc8
         rUKhH08ou4BnAT3Srct/6G1NEEeLQoZGjbd95PK46LN3Q6TINMMJwYA+Xn7FDdJYbFYR
         hqv5g0Q+zwPNB1B3g0i2uJ92v/yh/gbRnF7Ms5udl/T3GoiJr7ZzwB9ToQP06Vj50D2v
         6uf+ydtdl7IFwVegijnriigLZugdloh6HwDaKRczNcD9AGxjls3qfWsI9iparDOuY1Yk
         Mnew==
X-Gm-Message-State: AOAM533cPejtFFbXzvmfDF3K+ThNWVbjqRVoNwS3okdLTZYKzIjHZKB3
        xkkNZMzt041Xhe/cNvGYhNLRunx+mB1Cd06xny+Udh4OLYnDyQ==
X-Google-Smtp-Source: ABdhPJxubyf2nV9/zjU1854sYkWZDszAuwYA4wXI/L4FKkrhDr/y+9y5ao3a8PiL8Y7jET/8xsINJMz+9wa5SuyppGM=
X-Received: by 2002:a05:6902:4b0:: with SMTP id r16mr1312733ybs.184.1614224858187;
 Wed, 24 Feb 2021 19:47:38 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com> <CAEg-Je-zRWrkKOQM-Y_Y17eHhUrJe+d1_H9iLzQB4w7T+Een=w@mail.gmail.com>
 <74ca64e1-3933-c12b-644a-21745cf2d849@toxicpanda.com> <CAEg-Je9FZhLMx0MuxhyhTDUsRzfbi2_VZsHa3Bs+46jY8F82ZA@mail.gmail.com>
 <ab38ba5a-f684-0634-c5d8-d317541e37b9@toxicpanda.com> <CAEg-Je-cxaM3SuoLfHL6cGv0-0r7s-hccS4ixs66oO6YYOtbwg@mail.gmail.com>
 <56747283-fe34-51c5-9dbf-930bdafffaed@toxicpanda.com> <CAEg-Je_=jUMJfAqwtuZwcPE4+HOAJB7JC5gKSw4EeZrutxk5kA@mail.gmail.com>
 <58f4fe54-a462-b256-df60-17b1084235f6@toxicpanda.com> <CAEg-Je-_r3_AsLHa_HDDOUwVs+Jtty5roFvEyF4K-T2D7oEayA@mail.gmail.com>
 <58246f4c-4e26-c89c-a589-376cfe23d783@toxicpanda.com> <CAEg-Je-yPqueyW3JqSWrAE_9ckc1KTyaNoFwjbozNLrvb7_tEg@mail.gmail.com>
 <a9561d44-24a3-fa87-e292-98feb4846ab9@toxicpanda.com> <CAEg-Je8o2GiAH2wC9DXiMdMSCFnAjeV6UH-qaobk_0qYLNsPsQ@mail.gmail.com>
 <95e8db7d-eff3-e694-c315-f7984b5f49e0@toxicpanda.com>
In-Reply-To: <95e8db7d-eff3-e694-c315-f7984b5f49e0@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 24 Feb 2021 22:47:02 -0500
Message-ID: <CAEg-Je_s6EAHwj2LWYRLdMHF_kRuY_JQoLfWMqDgcROZatnP+g@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 24, 2021 at 10:44 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/24/21 9:23 AM, Neal Gompa wrote:
> > On Tue, Feb 23, 2021 at 10:05 AM Josef Bacik <josef@toxicpanda.com> wro=
te:
> >>
> >> On 2/22/21 11:03 PM, Neal Gompa wrote:
> >>> On Mon, Feb 22, 2021 at 2:34 PM Josef Bacik <josef@toxicpanda.com> wr=
ote:
> >>>>
> >>>> On 2/21/21 1:27 PM, Neal Gompa wrote:
> >>>>> On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef@toxicpanda.com>=
 wrote:
> >>>>>>
> >>>>>> On 2/17/21 11:29 AM, Neal Gompa wrote:
> >>>>>>> On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >>>>>>>>
> >>>>>>>> On 2/17/21 9:50 AM, Neal Gompa wrote:
> >>>>>>>>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
> >>>>>>>>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpanda=
.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
> >>>>>>>>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpan=
da.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxic=
panda.com> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>> Hey all,
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> So one of my main computers recently had a disk control=
ler failure
> >>>>>>>>>>>>>>>>> that caused my machine to freeze. After rebooting, Btrf=
s refuses to
> >>>>>>>>>>>>>>>>> mount. I tried to do a mount and the following errors s=
how up in the
> >>>>>>>>>>>>>>>>> journal:
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (dev=
ice sda3): disk space caching is enabled
> >>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (dev=
ice sda3): has skinny extents
> >>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical =
(device sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D2=
03657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (de=
vice sda3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical =
(device sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D2=
03657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (de=
vice sda3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (=
device sda3): couldn't read tree root
> >>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (de=
vice sda3): open_ctree failed
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> I've tried to do -o recovery,ro mount and get the same =
issue. I can't
> >>>>>>>>>>>>>>>>> seem to find any reasonably good information on how to =
do recovery in
> >>>>>>>>>>>>>>>>> this scenario, even to just recover enough to copy data=
 off.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> I'm on Fedora 33, the system was on Linux kernel versio=
n 5.9.16 and
> >>>>>>>>>>>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel versi=
on 5.10.14. I'm
> >>>>>>>>>>>>>>>>> using btrfs-progs v5.10.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Can anyone help?
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Can you try
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> That should fix the inode generation thing so it's sane,=
 and then the tree
> >>>>>>>>>>>>>>>> checker will allow the fs to be read, hopefully.  If not=
 we can work out some
> >>>>>>>>>>>>>>>> other magic.  Thanks,
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Josef
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I got the same error as I did with btrfs-check --readonly=
...
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Oh lovely, what does btrfs check --readonly --backup do?
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> No dice...
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> # btrfs check --readonly --backup /dev/sda3
> >>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 fo=
und 888895
> >>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 fo=
und 888895
> >>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 fo=
und 888895
> >>>>>>>>>>>>
> >>>>>>>>>>>> Hey look the block we're looking for, I wrote you some magic=
, just pull
> >>>>>>>>>>>>
> >>>>>>>>>>>> https://github.com/josefbacik/btrfs-progs/tree/for-neal
> >>>>>>>>>>>>
> >>>>>>>>>>>> build, and then run
> >>>>>>>>>>>>
> >>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
> >>>>>>>>>>>>
> >>>>>>>>>>>> This will force us to point at the old root with (hopefully)=
 the right bytenr
> >>>>>>>>>>>> and gen, and then hopefully you'll be able to recover from t=
here.  This is kind
> >>>>>>>>>>>> of saucy, so yolo, but I can undo it if it makes things wors=
e.  Thanks,
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> # btrfs check --readonly /dev/sda3
> >>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>> # btrfs check --clear-space-cache v1 /dev/sda3
> >>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>
> >>>>>>>>>>> It's better, but still no dice... :(
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Hmm it's not telling us what's wrong with the extent tree, whi=
ch is annoying.
> >>>>>>>>>> Does mount -o rescue=3Dall,ro work now that the root tree is n=
ormal?  Thanks,
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Nope, I see this in the journal:
> >>>>>>>>>
> >>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3=
): enabling all of the rescue options
> >>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3=
): ignoring data csums
> >>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3=
): ignoring bad roots
> >>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3=
): disabling log replay at mount time
> >>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3=
): disk space caching is enabled
> >>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3=
): has skinny extents
> >>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda=
3): tree level mismatch detected, bytenr=3D791281664 level expected=3D1 has=
=3D2
> >>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda=
3): tree level mismatch detected, bytenr=3D791281664 level expected=3D1 has=
=3D2
> >>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (device s=
da3): couldn't read tree root
> >>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda=
3): open_ctree failed
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Ok git pull for-neal, rebuild, then run
> >>>>>>>>
> >>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895 2
> >>>>>>>>
> >>>>>>>> I thought of this yesterday but in my head was like "naaahhhh, w=
hats the chances
> >>>>>>>> that the level doesn't match??".  Thanks,
> >>>>>>>>
> >>>>>>>
> >>>>>>> Tried rescue mount again after running that and got a stack trace=
 in
> >>>>>>> the kernel, detailed in the following attached log.
> >>>>>>
> >>>>>> Huh I wonder how I didn't hit this when testing, I must have only =
tested with
> >>>>>> zero'ing the extent root and the csum root.  You're going to have =
to build a
> >>>>>> kernel with a fix for this
> >>>>>>
> >>>>>> https://paste.centos.org/view/7b48aaea
> >>>>>>
> >>>>>> and see if that gets you further.  Thanks,
> >>>>>>
> >>>>>
> >>>>> I built a kernel build as an RPM with your patch[1] and tried it.
> >>>>>
> >>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 /mnt
> >>>>> Killed
> >>>>>
> >>>>> The log from the journal is attached.
> >>>>
> >>>>
> >>>> Ahh crud my bad, this should do it
> >>>>
> >>>> https://paste.centos.org/view/ac2e61ef
> >>>>
> >>>
> >>> Patch doesn't apply (note it is patch 667 below):
> >>
> >> Ah sorry, should have just sent you an iterative patch.  You can take =
the above
> >> patch and just delete the hunk from volumes.c as you already have that=
 applied
> >> and then it'll work.  Thanks,
> >>
> >
> > Failed with a weird error...?
> >
> > [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sda3 /mnt
> > mount: /mnt: mount(2) system call failed: No such file or directory.
> >
> > Journal log with traceback attached.
>
> Last one maybe?
>
> https://paste.centos.org/view/80edd6fd
>

Similar weird failure:

[root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 /mnt
mount: /mnt: mount(2) system call failed: No such file or directory.

No crash in the journal this time, though:

> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): enabling all of =
the rescue options
> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignoring data cs=
ums
> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignoring bad roo=
ts
> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disabling log re=
play at mount time
> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disk space cachi=
ng is enabled
> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): has skinny exten=
ts
> Feb 24 22:43:19 fedora kernel: BTRFS warning (device sdb3): failed to rea=
d fs tree: -2
> Feb 24 22:43:19 fedora kernel: BTRFS error (device sdb3): open_ctree fail=
ed




--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
