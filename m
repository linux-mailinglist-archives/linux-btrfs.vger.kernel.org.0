Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58A532DE20
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 00:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhCDXzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Mar 2021 18:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhCDXzN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Mar 2021 18:55:13 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D916DC061574
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Mar 2021 15:55:11 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id f4so30471840ybk.11
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Mar 2021 15:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZAJOCdbG0FtOpwMCR7xkZHV2pza1W9H3HQwtFcHr7kU=;
        b=VUFAaPB9Zrv4Yimc5xat1wM1+Z2io58ifWJWdWxJEObeH09m2rLP/v/LuMWKRjm4Vc
         apZUDRiBR2TDJeqV14ScD4DxNHRWhAhIB+ATr+r/L5CaGDTSv9iiViblsUITSETnM2cg
         arDaLgpPq8lYcW2plsjzpIafr7gf3ebK+6hrg83PNCPmKywADaqR2lAYGSzECLmUWCsQ
         gUio4Ql3hjmwtUa++K1DZF/G/8ZvGPEFW2+4Pk2iXnvEYgRujwGO1VST0zLnHzSNFBFk
         gOFaBL9CuE54lsP2tNO7QJVmb5ju2valbBlEJzpCSGnVpurPuDzOUEgCA1kqiwXhUd1I
         rtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZAJOCdbG0FtOpwMCR7xkZHV2pza1W9H3HQwtFcHr7kU=;
        b=hjcbQlpDrKGeZRLwfRVIqEeAeVm/WmGrV3/6OYhYDWVpdSnt2P7Ersk5h/k7QeSId0
         PnnxCZBJ9NFzhE3JU3JoLzEorKdrJ3IfegqVJYuIU85zayL6p5is0051JqfVepEfbEr3
         b+K1HGo2KGt7hY4BwbfcjzhsYuTjcZD95VGmnil5r0Atn7pPyfaoP+tpkADp4oe4mR1F
         M3O4rhlqZKjrAH5LRCREbGUvNK/sA8Rl9VbMJ4EUVp/vpfHf4cy8WqER+y8AWbKNBe0E
         Y4M1bIM/1/Z+1wAr75Jsc6oLDMz2pL8s8TrT+dMa+Oxh0+e80cDN9ANrrOkx351eMJV3
         6mRg==
X-Gm-Message-State: AOAM530UHHqOyIK0rKS/DJGItMOweHryZjuastwnckrs4Wevuf2Gb1I6
        WG8z08H4QrxXohanjt3wmjiTy0SKGCsXnatTqF5k+lbyRXpS5g==
X-Google-Smtp-Source: ABdhPJyW54rBT2sHDcPQyhDnrR3S4rZJPXvusn0+Bv4fqlaoO8G2TZNdhgdi7/xw2lP5YlJ659/3oq4TmogerzTLnAg=
X-Received: by 2002:a05:6902:1001:: with SMTP id w1mr10196496ybt.176.1614902111076;
 Thu, 04 Mar 2021 15:55:11 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <ab38ba5a-f684-0634-c5d8-d317541e37b9@toxicpanda.com> <CAEg-Je-cxaM3SuoLfHL6cGv0-0r7s-hccS4ixs66oO6YYOtbwg@mail.gmail.com>
 <56747283-fe34-51c5-9dbf-930bdafffaed@toxicpanda.com> <CAEg-Je_=jUMJfAqwtuZwcPE4+HOAJB7JC5gKSw4EeZrutxk5kA@mail.gmail.com>
 <58f4fe54-a462-b256-df60-17b1084235f6@toxicpanda.com> <CAEg-Je-_r3_AsLHa_HDDOUwVs+Jtty5roFvEyF4K-T2D7oEayA@mail.gmail.com>
 <58246f4c-4e26-c89c-a589-376cfe23d783@toxicpanda.com> <CAEg-Je-yPqueyW3JqSWrAE_9ckc1KTyaNoFwjbozNLrvb7_tEg@mail.gmail.com>
 <a9561d44-24a3-fa87-e292-98feb4846ab9@toxicpanda.com> <CAEg-Je8o2GiAH2wC9DXiMdMSCFnAjeV6UH-qaobk_0qYLNsPsQ@mail.gmail.com>
 <95e8db7d-eff3-e694-c315-f7984b5f49e0@toxicpanda.com> <CAEg-Je_s6EAHwj2LWYRLdMHF_kRuY_JQoLfWMqDgcROZatnP+g@mail.gmail.com>
 <ef2ec021-52d3-2da4-f59a-fa7016c95d90@toxicpanda.com> <CAEg-Je_HKgGLnF6F_3dXd+9NFa9cTceWWtTUhSSjNovsze_wQg@mail.gmail.com>
 <d2c7b501-f2f1-c471-4b1b-38e6731682ba@toxicpanda.com>
In-Reply-To: <d2c7b501-f2f1-c471-4b1b-38e6731682ba@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 4 Mar 2021 18:54:34 -0500
Message-ID: <CAEg-Je_TN04fnE2Bg46Nysm2_fG7dcni-7c6wbfZQZqXhDhbnA@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 4, 2021 at 3:25 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 3/3/21 2:38 PM, Neal Gompa wrote:
> > On Wed, Mar 3, 2021 at 1:42 PM Josef Bacik <josef@toxicpanda.com> wrote=
:
> >>
> >> On 2/24/21 10:47 PM, Neal Gompa wrote:
> >>> On Wed, Feb 24, 2021 at 10:44 AM Josef Bacik <josef@toxicpanda.com> w=
rote:
> >>>>
> >>>> On 2/24/21 9:23 AM, Neal Gompa wrote:
> >>>>> On Tue, Feb 23, 2021 at 10:05 AM Josef Bacik <josef@toxicpanda.com>=
 wrote:
> >>>>>>
> >>>>>> On 2/22/21 11:03 PM, Neal Gompa wrote:
> >>>>>>> On Mon, Feb 22, 2021 at 2:34 PM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >>>>>>>>
> >>>>>>>> On 2/21/21 1:27 PM, Neal Gompa wrote:
> >>>>>>>>> On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef@toxicpanda.=
com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2/17/21 11:29 AM, Neal Gompa wrote:
> >>>>>>>>>>> On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@toxicpanda=
.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2/17/21 9:50 AM, Neal Gompa wrote:
> >>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicpan=
da.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicp=
anda.com> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxi=
cpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@t=
oxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>> Hey all,
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> So one of my main computers recently had a disk con=
troller failure
> >>>>>>>>>>>>>>>>>>>>> that caused my machine to freeze. After rebooting, =
Btrfs refuses to
> >>>>>>>>>>>>>>>>>>>>> mount. I tried to do a mount and the following erro=
rs show up in the
> >>>>>>>>>>>>>>>>>>>>> journal:
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info =
(device sda3): disk space caching is enabled
> >>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info =
(device sda3): has skinny extents
> >>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS criti=
cal (device sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=
=3D203657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error=
 (device sda3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS criti=
cal (device sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=
=3D203657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error=
 (device sda3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warni=
ng (device sda3): couldn't read tree root
> >>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error=
 (device sda3): open_ctree failed
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> I've tried to do -o recovery,ro mount and get the s=
ame issue. I can't
> >>>>>>>>>>>>>>>>>>>>> seem to find any reasonably good information on how=
 to do recovery in
> >>>>>>>>>>>>>>>>>>>>> this scenario, even to just recover enough to copy =
data off.
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> I'm on Fedora 33, the system was on Linux kernel ve=
rsion 5.9.16 and
> >>>>>>>>>>>>>>>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel v=
ersion 5.10.14. I'm
> >>>>>>>>>>>>>>>>>>>>> using btrfs-progs v5.10.
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> Can anyone help?
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Can you try
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> That should fix the inode generation thing so it's s=
ane, and then the tree
> >>>>>>>>>>>>>>>>>>>> checker will allow the fs to be read, hopefully.  If=
 not we can work out some
> >>>>>>>>>>>>>>>>>>>> other magic.  Thanks,
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Josef
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> I got the same error as I did with btrfs-check --read=
only...
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Oh lovely, what does btrfs check --readonly --backup d=
o?
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> No dice...
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> # btrfs check --readonly --backup /dev/sda3
> >>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 88889=
3 found 888895
> >>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 88889=
3 found 888895
> >>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 88889=
3 found 888895
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Hey look the block we're looking for, I wrote you some m=
agic, just pull
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> https://github.com/josefbacik/btrfs-progs/tree/for-neal
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> build, and then run
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> This will force us to point at the old root with (hopefu=
lly) the right bytenr
> >>>>>>>>>>>>>>>> and gen, and then hopefully you'll be able to recover fr=
om there.  This is kind
> >>>>>>>>>>>>>>>> of saucy, so yolo, but I can undo it if it makes things =
worse.  Thanks,
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> # btrfs check --readonly /dev/sda3
> >>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>>>> # btrfs check --clear-space-cache v1 /dev/sda3
> >>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> It's better, but still no dice... :(
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Hmm it's not telling us what's wrong with the extent tree,=
 which is annoying.
> >>>>>>>>>>>>>> Does mount -o rescue=3Dall,ro work now that the root tree =
is normal?  Thanks,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Nope, I see this in the journal:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device =
sda3): enabling all of the rescue options
> >>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device =
sda3): ignoring data csums
> >>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device =
sda3): ignoring bad roots
> >>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device =
sda3): disabling log replay at mount time
> >>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device =
sda3): disk space caching is enabled
> >>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device =
sda3): has skinny extents
> >>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device=
 sda3): tree level mismatch detected, bytenr=3D791281664 level expected=3D1=
 has=3D2
> >>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device=
 sda3): tree level mismatch detected, bytenr=3D791281664 level expected=3D1=
 has=3D2
> >>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (devi=
ce sda3): couldn't read tree root
> >>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device=
 sda3): open_ctree failed
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Ok git pull for-neal, rebuild, then run
> >>>>>>>>>>>>
> >>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895 2
> >>>>>>>>>>>>
> >>>>>>>>>>>> I thought of this yesterday but in my head was like "naaahhh=
h, whats the chances
> >>>>>>>>>>>> that the level doesn't match??".  Thanks,
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Tried rescue mount again after running that and got a stack t=
race in
> >>>>>>>>>>> the kernel, detailed in the following attached log.
> >>>>>>>>>>
> >>>>>>>>>> Huh I wonder how I didn't hit this when testing, I must have o=
nly tested with
> >>>>>>>>>> zero'ing the extent root and the csum root.  You're going to h=
ave to build a
> >>>>>>>>>> kernel with a fix for this
> >>>>>>>>>>
> >>>>>>>>>> https://paste.centos.org/view/7b48aaea
> >>>>>>>>>>
> >>>>>>>>>> and see if that gets you further.  Thanks,
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> I built a kernel build as an RPM with your patch[1] and tried i=
t.
> >>>>>>>>>
> >>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 /m=
nt
> >>>>>>>>> Killed
> >>>>>>>>>
> >>>>>>>>> The log from the journal is attached.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Ahh crud my bad, this should do it
> >>>>>>>>
> >>>>>>>> https://paste.centos.org/view/ac2e61ef
> >>>>>>>>
> >>>>>>>
> >>>>>>> Patch doesn't apply (note it is patch 667 below):
> >>>>>>
> >>>>>> Ah sorry, should have just sent you an iterative patch.  You can t=
ake the above
> >>>>>> patch and just delete the hunk from volumes.c as you already have =
that applied
> >>>>>> and then it'll work.  Thanks,
> >>>>>>
> >>>>>
> >>>>> Failed with a weird error...?
> >>>>>
> >>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sda3 /mnt
> >>>>> mount: /mnt: mount(2) system call failed: No such file or directory=
.
> >>>>>
> >>>>> Journal log with traceback attached.
> >>>>
> >>>> Last one maybe?
> >>>>
> >>>> https://paste.centos.org/view/80edd6fd
> >>>>
> >>>
> >>> Similar weird failure:
> >>>
> >>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 /mnt
> >>> mount: /mnt: mount(2) system call failed: No such file or directory.
> >>>
> >>> No crash in the journal this time, though:
> >>>
> >>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): enabling al=
l of the rescue options
> >>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignoring da=
ta csums
> >>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignoring ba=
d roots
> >>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disabling l=
og replay at mount time
> >>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disk space =
caching is enabled
> >>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): has skinny =
extents
> >>>> Feb 24 22:43:19 fedora kernel: BTRFS warning (device sdb3): failed t=
o read fs tree: -2
> >>>> Feb 24 22:43:19 fedora kernel: BTRFS error (device sdb3): open_ctree=
 failed
> >>>
> >>>
> >>
> >> Sorry Neal, you replied when I was in the middle of something and prom=
ptly
> >> forgot about it.  I figured the fs root was fine, can you do the follo=
wing so I
> >> can figure out from the error messages what might be wrong
> >>
> >> btrfs check --readonly
> >> btrfs restore -D
> >> btrfs restore -l
> >>
> >
> > It didn't work.. Here's the output:
> >
> > [root@fedora ~]# btrfs check --readonly /dev/sdb3
> > Opening filesystem to check...
> > ERROR: could not setup extent tree
> > ERROR: cannot open file system
> > [root@fedora ~]# btrfs restore -D /dev/sdb3 /mnt
> > WARNING: could not setup extent tree, skipping it
> > Couldn't setup device tree
> > Could not open root, trying backup super
> > parent transid verify failed on 796082176 wanted 888894 found 888896
> > parent transid verify failed on 796082176 wanted 888894 found 888896
> > parent transid verify failed on 796082176 wanted 888894 found 888896
> > Ignoring transid failure
> > WARNING: could not setup extent tree, skipping it
> > Couldn't setup device tree
> > Could not open root, trying backup super
> > ERROR: superblock bytenr 274877906944 is larger than device size 263132=
807168
> > Could not open root, trying backup super
> > [root@fedora ~]# btrfs restore -l /dev/sdb3 /mnt
> > WARNING: could not setup extent tree, skipping it
> > Couldn't setup device tree
> > Could not open root, trying backup super
> > parent transid verify failed on 796082176 wanted 888894 found 888896
> > parent transid verify failed on 796082176 wanted 888894 found 888896
> > parent transid verify failed on 796082176 wanted 888894 found 888896
> > Ignoring transid failure
> > WARNING: could not setup extent tree, skipping it
> > Couldn't setup device tree
> > Could not open root, trying backup super
> > ERROR: superblock bytenr 274877906944 is larger than device size 263132=
807168
> > Could not open root, trying backup super
> >
> >
>
> Hmm OK I think we want the neal magic for this one too, but before we go =
doing
> that can I get a
>
> btrfs inspect-internal -f /dev/whatever
>
> so I can make sure I'm not just blindly clobbering something.  Thanks,
>

Doesn't work, did you mean some other command?

[root@fedora ~]#  btrfs inspect-internal -f /dev/sdb3
btrfs inspect-internal: unknown token '-f'




--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
