Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7C5331C27
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 02:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCIBNL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 20:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhCIBMo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Mar 2021 20:12:44 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D36FC06174A
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Mar 2021 17:12:44 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id c131so12193188ybf.7
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Mar 2021 17:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4mkQNFPuTW2aqMCVxAQ52VgLNIqle/ZBRJKXVBzsldk=;
        b=LPVFw2g8CEUKp4gVLQbRK68EUQ1wYAuMIR+qQj5tcM1rD1flzboRK2qkTAoN6SDF0A
         F1qOkqUdphRLjRXx01nx06gGmHTRBOBpP3riAZhyvbXWqIxA3wd457pDhLpcKIYHD9h6
         j/AVBOK2CDvIlVVqDDwuTu1aHXTN22452c8L59gcAui7BL9AgQBQPwhaWLMzxLUDf2X1
         6uRICt3cRvMC0P/DGN/YaTmDT0CS/4h4Z56tKDP4KTcw8q/AQ8pV7bxmVEHO2hl9zBJL
         yK54avn9XJOkdGssn5MrYQzXgR5XbyYKyE+R2IllDJVQHA0b0XKqXHTBSYwRw8cmz0fE
         Gi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4mkQNFPuTW2aqMCVxAQ52VgLNIqle/ZBRJKXVBzsldk=;
        b=k1urbqlbjJ//OqYCEk0/n8TcGj1RcK348IWPYfkMHHZ9zp8zVztZ5L+ZyuAszqYacl
         BQu3rwVbvzf22Pivji7dwV1H2OS7tEKD1cqhPYCj9Cn/WMZVuHshLfxIg6YDDn8R6ru3
         6sGEPpdzFnRX9wruUX/Hyy7UbCtwq0L87pU5N+8wmn3YM5k387fZQdkM0xlO5MB6k+La
         a+E1jmHs30tYrZm5zNt4Xkwyyljb+ozB5MhyWrWpDyXfR4/KfYgoCkaFVnCUIyuYuF+Z
         X+FEwycci3pMFdZ4Q4Jmaj1237DIzcGuaXRAMKlM6OKoX0MdnHuCxi/JQyHw2njDn/va
         amGQ==
X-Gm-Message-State: AOAM530xmTtf5uqLVKR4gz9CqZlk8GXbch6sywM6d6jYqnZMlFiPC+GR
        nrk1SW+oHZUn1UsyQ8LbizFmM0sMc5nyK6WgYjQ=
X-Google-Smtp-Source: ABdhPJyV09Zal/Y3aOoMn3Ma8ZhQxY2jFtHz3obVDVB8jKMGmdF1IfFIyn9es5m9mKLhp7HSwXp0JbJAJNn6ARTZk40=
X-Received: by 2002:a25:cc13:: with SMTP id l19mr37008713ybf.260.1615252363616;
 Mon, 08 Mar 2021 17:12:43 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <a9561d44-24a3-fa87-e292-98feb4846ab9@toxicpanda.com> <CAEg-Je8o2GiAH2wC9DXiMdMSCFnAjeV6UH-qaobk_0qYLNsPsQ@mail.gmail.com>
 <95e8db7d-eff3-e694-c315-f7984b5f49e0@toxicpanda.com> <CAEg-Je_s6EAHwj2LWYRLdMHF_kRuY_JQoLfWMqDgcROZatnP+g@mail.gmail.com>
 <ef2ec021-52d3-2da4-f59a-fa7016c95d90@toxicpanda.com> <CAEg-Je_HKgGLnF6F_3dXd+9NFa9cTceWWtTUhSSjNovsze_wQg@mail.gmail.com>
 <d2c7b501-f2f1-c471-4b1b-38e6731682ba@toxicpanda.com> <CAEg-Je_TN04fnE2Bg46Nysm2_fG7dcni-7c6wbfZQZqXhDhbnA@mail.gmail.com>
 <e5b5409b-0e34-abd5-81c9-48ef59c3fa03@toxicpanda.com> <CAEg-Je-oOnnCd=Vc65yTam6-jxHr2rEr9yrzi_xv79ziys0TjA@mail.gmail.com>
 <346098b8-3d89-1497-ada3-e8317888ee61@toxicpanda.com> <CAEg-Je9-88GOrHqqwsvAhxR_1BB-6nFLVd3r-kidCP4APLEEFw@mail.gmail.com>
 <c71ba7e4-28d5-1307-c8d7-4e1bb398ef08@toxicpanda.com> <CAEg-Je9dvb5d7nh=pS=_uR5dWe1YBNJTyzzBX=H2_NY=L7DZ9Q@mail.gmail.com>
 <36af1204-bd8a-ebb6-ca21-a469780ed147@toxicpanda.com>
In-Reply-To: <36af1204-bd8a-ebb6-ca21-a469780ed147@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 8 Mar 2021 20:12:06 -0500
Message-ID: <CAEg-Je8XM1zfrvu9m61_rrmnRftsksKdQZ_Lz_Km=0vhsfwj4A@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000005b472a05bd103f89"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--0000000000005b472a05bd103f89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 8, 2021 at 5:04 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 3/8/21 3:01 PM, Neal Gompa wrote:
> > On Mon, Mar 8, 2021 at 1:38 PM Josef Bacik <josef@toxicpanda.com> wrote=
:
> >>
> >> On 3/5/21 8:03 PM, Neal Gompa wrote:
> >>> On Fri, Mar 5, 2021 at 5:01 PM Josef Bacik <josef@toxicpanda.com> wro=
te:
> >>>>
> >>>> On 3/5/21 9:41 AM, Neal Gompa wrote:
> >>>>> On Fri, Mar 5, 2021 at 9:12 AM Josef Bacik <josef@toxicpanda.com> w=
rote:
> >>>>>>
> >>>>>> On 3/4/21 6:54 PM, Neal Gompa wrote:
> >>>>>>> On Thu, Mar 4, 2021 at 3:25 PM Josef Bacik <josef@toxicpanda.com>=
 wrote:
> >>>>>>>>
> >>>>>>>> On 3/3/21 2:38 PM, Neal Gompa wrote:
> >>>>>>>>> On Wed, Mar 3, 2021 at 1:42 PM Josef Bacik <josef@toxicpanda.co=
m> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2/24/21 10:47 PM, Neal Gompa wrote:
> >>>>>>>>>>> On Wed, Feb 24, 2021 at 10:44 AM Josef Bacik <josef@toxicpand=
a.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2/24/21 9:23 AM, Neal Gompa wrote:
> >>>>>>>>>>>>> On Tue, Feb 23, 2021 at 10:05 AM Josef Bacik <josef@toxicpa=
nda.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 2/22/21 11:03 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>> On Mon, Feb 22, 2021 at 2:34 PM Josef Bacik <josef@toxicp=
anda.com> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On 2/21/21 1:27 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef@tox=
icpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> On 2/17/21 11:29 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@to=
xicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> On 2/17/21 9:50 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@=
toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <jose=
f@toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <jo=
sef@toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik =
<josef@toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> Hey all,
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> So one of my main computers recently had a =
disk controller failure
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> that caused my machine to freeze. After reb=
ooting, Btrfs refuses to
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> mount. I tried to do a mount and the follow=
ing errors show up in the
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> journal:
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTR=
FS info (device sda3): disk space caching is enabled
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTR=
FS info (device sda3): has skinny extents
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTR=
FS critical (device sda3): corrupt leaf: root=3D401 block=3D796082176 slot=
=3D15 ino=3D203657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTR=
FS error (device sda3): block=3D796082176 read time tree block corruption d=
etected
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTR=
FS critical (device sda3): corrupt leaf: root=3D401 block=3D796082176 slot=
=3D15 ino=3D203657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTR=
FS error (device sda3): block=3D796082176 read time tree block corruption d=
etected
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTR=
FS warning (device sda3): couldn't read tree root
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTR=
FS error (device sda3): open_ctree failed
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> I've tried to do -o recovery,ro mount and g=
et the same issue. I can't
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> seem to find any reasonably good informatio=
n on how to do recovery in
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> this scenario, even to just recover enough =
to copy data off.
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> I'm on Fedora 33, the system was on Linux k=
ernel version 5.9.16 and
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> the Fedora 33 live ISO I'm using has Linux =
kernel version 5.10.14. I'm
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> using btrfs-progs v5.10.
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> Can anyone help?
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> Can you try
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> btrfs check --clear-space-cache v1 /dev/what=
ever
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> That should fix the inode generation thing s=
o it's sane, and then the tree
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> checker will allow the fs to be read, hopefu=
lly.  If not we can work out some
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> other magic.  Thanks,
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> Josef
> >>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>> I got the same error as I did with btrfs-chec=
k --readonly...
> >>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>> Oh lovely, what does btrfs check --readonly --=
backup do?
> >>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>> No dice...
> >>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>> # btrfs check --readonly --backup /dev/sda3
> >>>>>>>>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 want=
ed 888893 found 888895
> >>>>>>>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 want=
ed 888893 found 888895
> >>>>>>>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 want=
ed 888893 found 888895
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> Hey look the block we're looking for, I wrote yo=
u some magic, just pull
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> https://github.com/josefbacik/btrfs-progs/tree/f=
or-neal
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> build, and then run
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> This will force us to point at the old root with=
 (hopefully) the right bytenr
> >>>>>>>>>>>>>>>>>>>>>>>> and gen, and then hopefully you'll be able to re=
cover from there.  This is kind
> >>>>>>>>>>>>>>>>>>>>>>>> of saucy, so yolo, but I can undo it if it makes=
 things worse.  Thanks,
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>> # btrfs check --readonly /dev/sda3
> >>>>>>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>>>>>>>>>>>> # btrfs check --clear-space-cache v1 /dev/sda3
> >>>>>>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>> It's better, but still no dice... :(
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> Hmm it's not telling us what's wrong with the exte=
nt tree, which is annoying.
> >>>>>>>>>>>>>>>>>>>>>> Does mount -o rescue=3Dall,ro work now that the ro=
ot tree is normal?  Thanks,
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> Nope, I see this in the journal:
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info =
(device sda3): enabling all of the rescue options
> >>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info =
(device sda3): ignoring data csums
> >>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info =
(device sda3): ignoring bad roots
> >>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info =
(device sda3): disabling log replay at mount time
> >>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info =
(device sda3): disk space caching is enabled
> >>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info =
(device sda3): has skinny extents
> >>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error=
 (device sda3): tree level mismatch detected, bytenr=3D791281664 level expe=
cted=3D1 has=3D2
> >>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error=
 (device sda3): tree level mismatch detected, bytenr=3D791281664 level expe=
cted=3D1 has=3D2
> >>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS warni=
ng (device sda3): couldn't read tree root
> >>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error=
 (device sda3): open_ctree failed
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Ok git pull for-neal, rebuild, then run
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895 2
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> I thought of this yesterday but in my head was like =
"naaahhhh, whats the chances
> >>>>>>>>>>>>>>>>>>>> that the level doesn't match??".  Thanks,
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> Tried rescue mount again after running that and got a=
 stack trace in
> >>>>>>>>>>>>>>>>>>> the kernel, detailed in the following attached log.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Huh I wonder how I didn't hit this when testing, I mus=
t have only tested with
> >>>>>>>>>>>>>>>>>> zero'ing the extent root and the csum root.  You're go=
ing to have to build a
> >>>>>>>>>>>>>>>>>> kernel with a fix for this
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> https://paste.centos.org/view/7b48aaea
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> and see if that gets you further.  Thanks,
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> I built a kernel build as an RPM with your patch[1] and=
 tried it.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev=
/sdb3 /mnt
> >>>>>>>>>>>>>>>>> Killed
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> The log from the journal is attached.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Ahh crud my bad, this should do it
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> https://paste.centos.org/view/ac2e61ef
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Patch doesn't apply (note it is patch 667 below):
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Ah sorry, should have just sent you an iterative patch.  Y=
ou can take the above
> >>>>>>>>>>>>>> patch and just delete the hunk from volumes.c as you alrea=
dy have that applied
> >>>>>>>>>>>>>> and then it'll work.  Thanks,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Failed with a weird error...?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sda=
3 /mnt
> >>>>>>>>>>>>> mount: /mnt: mount(2) system call failed: No such file or d=
irectory.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Journal log with traceback attached.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Last one maybe?
> >>>>>>>>>>>>
> >>>>>>>>>>>> https://paste.centos.org/view/80edd6fd
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Similar weird failure:
> >>>>>>>>>>>
> >>>>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 =
/mnt
> >>>>>>>>>>> mount: /mnt: mount(2) system call failed: No such file or dir=
ectory.
> >>>>>>>>>>>
> >>>>>>>>>>> No crash in the journal this time, though:
> >>>>>>>>>>>
> >>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ena=
bling all of the rescue options
> >>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ign=
oring data csums
> >>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ign=
oring bad roots
> >>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): dis=
abling log replay at mount time
> >>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): dis=
k space caching is enabled
> >>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): has=
 skinny extents
> >>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS warning (device sdb3): =
failed to read fs tree: -2
> >>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS error (device sdb3): op=
en_ctree failed
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Sorry Neal, you replied when I was in the middle of something =
and promptly
> >>>>>>>>>> forgot about it.  I figured the fs root was fine, can you do t=
he following so I
> >>>>>>>>>> can figure out from the error messages what might be wrong
> >>>>>>>>>>
> >>>>>>>>>> btrfs check --readonly
> >>>>>>>>>> btrfs restore -D
> >>>>>>>>>> btrfs restore -l
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> It didn't work.. Here's the output:
> >>>>>>>>>
> >>>>>>>>> [root@fedora ~]# btrfs check --readonly /dev/sdb3
> >>>>>>>>> Opening filesystem to check...
> >>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>> ERROR: cannot open file system
> >>>>>>>>> [root@fedora ~]# btrfs restore -D /dev/sdb3 /mnt
> >>>>>>>>> WARNING: could not setup extent tree, skipping it
> >>>>>>>>> Couldn't setup device tree
> >>>>>>>>> Could not open root, trying backup super
> >>>>>>>>> parent transid verify failed on 796082176 wanted 888894 found 8=
88896
> >>>>>>>>> parent transid verify failed on 796082176 wanted 888894 found 8=
88896
> >>>>>>>>> parent transid verify failed on 796082176 wanted 888894 found 8=
88896
> >>>>>>>>> Ignoring transid failure
> >>>>>>>>> WARNING: could not setup extent tree, skipping it
> >>>>>>>>> Couldn't setup device tree
> >>>>>>>>> Could not open root, trying backup super
> >>>>>>>>> ERROR: superblock bytenr 274877906944 is larger than device siz=
e 263132807168
> >>>>>>>>> Could not open root, trying backup super
> >>>>>>>>> [root@fedora ~]# btrfs restore -l /dev/sdb3 /mnt
> >>>>>>>>> WARNING: could not setup extent tree, skipping it
> >>>>>>>>> Couldn't setup device tree
> >>>>>>>>> Could not open root, trying backup super
> >>>>>>>>> parent transid verify failed on 796082176 wanted 888894 found 8=
88896
> >>>>>>>>> parent transid verify failed on 796082176 wanted 888894 found 8=
88896
> >>>>>>>>> parent transid verify failed on 796082176 wanted 888894 found 8=
88896
> >>>>>>>>> Ignoring transid failure
> >>>>>>>>> WARNING: could not setup extent tree, skipping it
> >>>>>>>>> Couldn't setup device tree
> >>>>>>>>> Could not open root, trying backup super
> >>>>>>>>> ERROR: superblock bytenr 274877906944 is larger than device siz=
e 263132807168
> >>>>>>>>> Could not open root, trying backup super
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Hmm OK I think we want the neal magic for this one too, but befo=
re we go doing
> >>>>>>>> that can I get a
> >>>>>>>>
> >>>>>>>> btrfs inspect-internal -f /dev/whatever
> >>>>>>>>
> >>>>>>>> so I can make sure I'm not just blindly clobbering something.  T=
hanks,
> >>>>>>>>
> >>>>>>>
> >>>>>>> Doesn't work, did you mean some other command?
> >>>>>>>
> >>>>>>> [root@fedora ~]#  btrfs inspect-internal -f /dev/sdb3
> >>>>>>> btrfs inspect-internal: unknown token '-f'
> >>>>>>
> >>>>>> Sigh, sorry, btrfs inspect-internal dump-super -f /dev/sdb3
> >>>>>>
> >>>>>
> >>>>
> >>>> Ok I've pushed to the for-neal branch in my btrfs-progs, can you pul=
l and make
> >>>> and then run
> >>>>
> >>>> ./btrfs-print-block /dev/sdb3 791281664
> >>>>
> >>>> and capture everything it prints out?  Thanks,
> >>>>
> >>>
> >>> Here's the output from the command.
> >>>
> >>>
> >>
> >> Hmm looks like the fs is offset a bit, can you do
> >>
> >> ./btrfs-print-block /dev/sdb3 799670272
> >>
> >
> > This command caused my session to crash, but I do have a log of what
> > was captured before it crashed and attached it.
> >
> >> also while we're here can I get
> >>
> >> btrfs-find-root /dev/sdb3
> >>
> >
> > This ran successfully and I've attached the output.
> >
>
> Ok we're going to try this again, and if it doesn't work it looks like yo=
ur
> chunk root is ok, so I'll rig something up to make the translation work r=
ight,
> but for now lets do
>
> ./btrfs-print-block /dev/sdb3 792395776
>

I've attached the output from that command, which did run successfully.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

--0000000000005b472a05bd103f89
Content-Type: text/x-log; charset="US-ASCII"; name="output-print-block3.log"
Content-Disposition: attachment; filename="output-print-block3.log"
Content-Transfer-Encoding: base64
Content-ID: <f_km1bj1dq0>
X-Attachment-Id: f_km1bj1dq0

bGVhZiA3ODQwMDcxNjggaXRlbXMgNTMgZnJlZSBzcGFjZSA3NDE0IGdlbmVyYXRpb24gNzU3Mjg2
IG93bmVyIDQwMQpsZWFmIDc4NDAwNzE2OCBmbGFncyAweDEoV1JJVFRFTikgYmFja3JlZiByZXZp
c2lvbiAxCmZzIHV1aWQgZjk5M2ZmYTQtODgwMS00ZDU3LWEwODctMWMzNWZkNmVjZTAwCmNodW5r
IHV1aWQgN2VmZjE1NGItMzU1MC00MjdlLTk4Y2ItNzMwMGIzZDY5YWIzCglpdGVtIDAga2V5ICgx
NDc1OTEgWEFUVFJfSVRFTSAzODE3NzUzNjY3KSBpdGVtb2ZmIDE2MjA3IGl0ZW1zaXplIDc2CgkJ
bG9jYXRpb24ga2V5ICgwIFVOS05PV04uMCAwKSB0eXBlIFhBVFRSCgkJdHJhbnNpZCA3NTcyODYg
ZGF0YV9sZW4gMzAgbmFtZV9sZW4gMTYKCQluYW1lOiBzZWN1cml0eS5zZWxpbnV4CgkJZGF0YSBz
eXN0ZW1fdTpvYmplY3Rfcjpsb2NhbGVfdDpzMAoJaXRlbSAxIGtleSAoMTQ3NTkxIEVYVEVOVF9E
QVRBIDApIGl0ZW1vZmYgMTYxNTQgaXRlbXNpemUgNTMKCQlnZW5lcmF0aW9uIDc1NzI4NiB0eXBl
IDEgKHJlZ3VsYXIpCgkJZXh0ZW50IGRhdGEgZGlzayBieXRlIDU3OTgwNzY0MTYgbnIgODE5MgoJ
CWV4dGVudCBkYXRhIG9mZnNldCAwIG5yIDgxOTIgcmFtIDgxOTIKCQlleHRlbnQgY29tcHJlc3Np
b24gMCAobm9uZSkKCWl0ZW0gMiBrZXkgKDE0NzU5MiBJTk9ERV9JVEVNIDApIGl0ZW1vZmYgMTU5
OTQgaXRlbXNpemUgMTYwCgkJZ2VuZXJhdGlvbiA3NTcyODYgdHJhbnNpZCA3NTcyODYgc2l6ZSA2
MjQ4IG5ieXRlcyA4MTkyCgkJYmxvY2sgZ3JvdXAgMCBtb2RlIDEwMDY0NCBsaW5rcyAxIHVpZCAw
IGdpZCAwIHJkZXYgMAoJCXNlcXVlbmNlIDE0IGZsYWdzIDB4MChub25lKQoJCWF0aW1lIDE2MDk1
NTQyMDMuMjI2MTU4ODMzICgyMDIxLTAxLTAxIDIxOjIzOjIzKQoJCWN0aW1lIDE2MDk1NTQyMDMu
MjI2MTU4ODMzICgyMDIxLTAxLTAxIDIxOjIzOjIzKQoJCW10aW1lIDE2MDM4MzEwNDMuMCAoMjAy
MC0xMC0yNyAxNjozNzoyMykKCQlvdGltZSAxNjA5NTU0MjAzLjIyNjE1ODgzMyAoMjAyMS0wMS0w
MSAyMToyMzoyMykKCWl0ZW0gMyBrZXkgKDE0NzU5MiBJTk9ERV9SRUYgMTQ2MDIwKSBpdGVtb2Zm
IDE1OTY2IGl0ZW1zaXplIDI4CgkJaW5kZXggNDk4IG5hbWVsZW4gMTggbmFtZToga2NvcmVhZGRv
bnM1X3F0LnFtCglpdGVtIDQga2V5ICgxNDc1OTIgWEFUVFJfSVRFTSAzODE3NzUzNjY3KSBpdGVt
b2ZmIDE1ODkwIGl0ZW1zaXplIDc2CgkJbG9jYXRpb24ga2V5ICgwIFVOS05PV04uMCAwKSB0eXBl
IFhBVFRSCgkJdHJhbnNpZCA3NTcyODYgZGF0YV9sZW4gMzAgbmFtZV9sZW4gMTYKCQluYW1lOiBz
ZWN1cml0eS5zZWxpbnV4CgkJZGF0YSBzeXN0ZW1fdTpvYmplY3Rfcjpsb2NhbGVfdDpzMAoJaXRl
bSA1IGtleSAoMTQ3NTkyIEVYVEVOVF9EQVRBIDApIGl0ZW1vZmYgMTU4MzcgaXRlbXNpemUgNTMK
CQlnZW5lcmF0aW9uIDc1NzI4NiB0eXBlIDEgKHJlZ3VsYXIpCgkJZXh0ZW50IGRhdGEgZGlzayBi
eXRlIDU3OTgwODQ2MDggbnIgODE5MgoJCWV4dGVudCBkYXRhIG9mZnNldCAwIG5yIDgxOTIgcmFt
IDgxOTIKCQlleHRlbnQgY29tcHJlc3Npb24gMCAobm9uZSkKCWl0ZW0gNiBrZXkgKDE0NzU5MyBJ
Tk9ERV9JVEVNIDApIGl0ZW1vZmYgMTU2NzcgaXRlbXNpemUgMTYwCgkJZ2VuZXJhdGlvbiA3NTcy
ODYgdHJhbnNpZCA3NTcyODYgc2l6ZSAxMjIyIG5ieXRlcyAxMjIyCgkJYmxvY2sgZ3JvdXAgMCBt
b2RlIDEwMDY0NCBsaW5rcyAxIHVpZCAwIGdpZCAwIHJkZXYgMAoJCXNlcXVlbmNlIDE0IGZsYWdz
IDB4MChub25lKQoJCWF0aW1lIDE2MDk1NTQyMDMuMjI2MTU4ODMzICgyMDIxLTAxLTAxIDIxOjIz
OjIzKQoJCWN0aW1lIDE2MDk1NTQyMDMuMjI2MTU4ODMzICgyMDIxLTAxLTAxIDIxOjIzOjIzKQoJ
CW10aW1lIDE2MDM4MzEwMzAuMCAoMjAyMC0xMC0yNyAxNjozNzoxMCkKCQlvdGltZSAxNjA5NTU0
MjAzLjIyNjE1ODgzMyAoMjAyMS0wMS0wMSAyMToyMzoyMykKCWl0ZW0gNyBrZXkgKDE0NzU5MyBJ
Tk9ERV9SRUYgMTQ2MDIwKSBpdGVtb2ZmIDE1NjQ5IGl0ZW1zaXplIDI4CgkJaW5kZXggNTAwIG5h
bWVsZW4gMTggbmFtZToga2RidXNhZGRvbnM1X3F0LnFtCglpdGVtIDgga2V5ICgxNDc1OTMgWEFU
VFJfSVRFTSAzODE3NzUzNjY3KSBpdGVtb2ZmIDE1NTczIGl0ZW1zaXplIDc2CgkJbG9jYXRpb24g
a2V5ICgwIFVOS05PV04uMCAwKSB0eXBlIFhBVFRSCgkJdHJhbnNpZCA3NTcyODYgZGF0YV9sZW4g
MzAgbmFtZV9sZW4gMTYKCQluYW1lOiBzZWN1cml0eS5zZWxpbnV4CgkJZGF0YSBzeXN0ZW1fdTpv
YmplY3Rfcjpsb2NhbGVfdDpzMAoJaXRlbSA5IGtleSAoMTQ3NTkzIEVYVEVOVF9EQVRBIDApIGl0
ZW1vZmYgMTQzMzAgaXRlbXNpemUgMTI0MwoJCWdlbmVyYXRpb24gNzU3Mjg2IHR5cGUgMCAoaW5s
aW5lKQoJCWlubGluZSBleHRlbnQgZGF0YSBzaXplIDEyMjIgcmFtX2J5dGVzIDEyMjIgY29tcHJl
c3Npb24gMCAobm9uZSkKCWl0ZW0gMTAga2V5ICgxNDc1OTQgSU5PREVfSVRFTSAwKSBpdGVtb2Zm
IDE0MTcwIGl0ZW1zaXplIDE2MAoJCWdlbmVyYXRpb24gNzU3Mjg2IHRyYW5zaWQgNzU3Mjg2IHNp
emUgNTgzMCBuYnl0ZXMgODE5MgoJCWJsb2NrIGdyb3VwIDAgbW9kZSAxMDA2NDQgbGlua3MgMSB1
aWQgMCBnaWQgMCByZGV2IDAKCQlzZXF1ZW5jZSAxNCBmbGFncyAweDAobm9uZSkKCQlhdGltZSAx
NjA5NTU0MjAzLjIyNjE1ODgzMyAoMjAyMS0wMS0wMSAyMToyMzoyMykKCQljdGltZSAxNjA5NTU0
MjAzLjIyNjE1ODgzMyAoMjAyMS0wMS0wMSAyMToyMzoyMykKCQltdGltZSAxNjAzODMxMDQ0LjAg
KDIwMjAtMTAtMjcgMTY6Mzc6MjQpCgkJb3RpbWUgMTYwOTU1NDIwMy4yMjYxNTg4MzMgKDIwMjEt
MDEtMDEgMjE6MjM6MjMpCglpdGVtIDExIGtleSAoMTQ3NTk0IElOT0RFX1JFRiAxNDYwMjApIGl0
ZW1vZmYgMTQxMzkgaXRlbXNpemUgMzEKCQlpbmRleCA1MDIgbmFtZWxlbiAyMSBuYW1lOiBrZGU1
X3htbF9taW1ldHlwZXMucW0KCWl0ZW0gMTIga2V5ICgxNDc1OTQgWEFUVFJfSVRFTSAzODE3NzUz
NjY3KSBpdGVtb2ZmIDE0MDYzIGl0ZW1zaXplIDc2CgkJbG9jYXRpb24ga2V5ICgwIFVOS05PV04u
MCAwKSB0eXBlIFhBVFRSCgkJdHJhbnNpZCA3NTcyODYgZGF0YV9sZW4gMzAgbmFtZV9sZW4gMTYK
CQluYW1lOiBzZWN1cml0eS5zZWxpbnV4CgkJZGF0YSBzeXN0ZW1fdTpvYmplY3Rfcjpsb2NhbGVf
dDpzMAoJaXRlbSAxMyBrZXkgKDE0NzU5NCBFWFRFTlRfREFUQSAwKSBpdGVtb2ZmIDE0MDEwIGl0
ZW1zaXplIDUzCgkJZ2VuZXJhdGlvbiA3NTcyODYgdHlwZSAxIChyZWd1bGFyKQoJCWV4dGVudCBk
YXRhIGRpc2sgYnl0ZSA1Nzk4MDkyODAwIG5yIDgxOTIKCQlleHRlbnQgZGF0YSBvZmZzZXQgMCBu
ciA4MTkyIHJhbSA4MTkyCgkJZXh0ZW50IGNvbXByZXNzaW9uIDAgKG5vbmUpCglpdGVtIDE0IGtl
eSAoMTQ3NTk1IElOT0RFX0lURU0gMCkgaXRlbW9mZiAxMzg1MCBpdGVtc2l6ZSAxNjAKCQlnZW5l
cmF0aW9uIDc1NzI4NiB0cmFuc2lkIDc1NzI4NiBzaXplIDgzNDkgbmJ5dGVzIDEyMjg4CgkJYmxv
Y2sgZ3JvdXAgMCBtb2RlIDEwMDY0NCBsaW5rcyAxIHVpZCAwIGdpZCAwIHJkZXYgMAoJCXNlcXVl
bmNlIDE0IGZsYWdzIDB4MChub25lKQoJCWF0aW1lIDE2MDk1NTQyMDMuMjI2MTU4ODMzICgyMDIx
LTAxLTAxIDIxOjIzOjIzKQoJCWN0aW1lIDE2MDk1NTQyMDMuMjI2MTU4ODMzICgyMDIxLTAxLTAx
IDIxOjIzOjIzKQoJCW10aW1lIDE2MDY0NTM3MzMuMCAoMjAyMC0xMS0yNyAwMDowODo1MykKCQlv
dGltZSAxNjA5NTU0MjAzLjIyNjE1ODgzMyAoMjAyMS0wMS0wMSAyMToyMzoyMykKCWl0ZW0gMTUg
a2V5ICgxNDc1OTUgSU5PREVfUkVGIDE0NjAyMCkgaXRlbW9mZiAxMzgyNCBpdGVtc2l6ZSAyNgoJ
CWluZGV4IDUwNCBuYW1lbGVuIDE2IG5hbWU6IGtkZWNsYXJhdGl2ZTUubW8KCWl0ZW0gMTYga2V5
ICgxNDc1OTUgWEFUVFJfSVRFTSAzODE3NzUzNjY3KSBpdGVtb2ZmIDEzNzQ4IGl0ZW1zaXplIDc2
CgkJbG9jYXRpb24ga2V5ICgwIFVOS05PV04uMCAwKSB0eXBlIFhBVFRSCgkJdHJhbnNpZCA3NTcy
ODYgZGF0YV9sZW4gMzAgbmFtZV9sZW4gMTYKCQluYW1lOiBzZWN1cml0eS5zZWxpbnV4CgkJZGF0
YSBzeXN0ZW1fdTpvYmplY3Rfcjpsb2NhbGVfdDpzMAoJaXRlbSAxNyBrZXkgKDE0NzU5NSBFWFRF
TlRfREFUQSAwKSBpdGVtb2ZmIDEzNjk1IGl0ZW1zaXplIDUzCgkJZ2VuZXJhdGlvbiA3NTcyODYg
dHlwZSAxIChyZWd1bGFyKQoJCWV4dGVudCBkYXRhIGRpc2sgYnl0ZSA1Nzk4MTAwOTkyIG5yIDEy
Mjg4CgkJZXh0ZW50IGRhdGEgb2Zmc2V0IDAgbnIgMTIyODggcmFtIDEyMjg4CgkJZXh0ZW50IGNv
bXByZXNzaW9uIDAgKG5vbmUpCglpdGVtIDE4IGtleSAoMTQ3NTk2IElOT0RFX0lURU0gMCkgaXRl
bW9mZiAxMzUzNSBpdGVtc2l6ZSAxNjAKCQlnZW5lcmF0aW9uIDc1NzI4NiB0cmFuc2lkIDc1NzI4
NiBzaXplIDI2MDEgbmJ5dGVzIDQwOTYKCQlibG9jayBncm91cCAwIG1vZGUgMTAwNjQ0IGxpbmtz
IDEgdWlkIDAgZ2lkIDAgcmRldiAwCgkJc2VxdWVuY2UgMTQgZmxhZ3MgMHgwKG5vbmUpCgkJYXRp
bWUgMTYwOTU1NDIwMy4yMjYxNTg4MzMgKDIwMjEtMDEtMDEgMjE6MjM6MjMpCgkJY3RpbWUgMTYw
OTU1NDIwMy4yMjYxNTg4MzMgKDIwMjEtMDEtMDEgMjE6MjM6MjMpCgkJbXRpbWUgMTYwMTY1MzY2
Ny4wICgyMDIwLTEwLTAyIDExOjQ3OjQ3KQoJCW90aW1lIDE2MDk1NTQyMDMuMjI2MTU4ODMzICgy
MDIxLTAxLTAxIDIxOjIzOjIzKQoJaXRlbSAxOSBrZXkgKDE0NzU5NiBJTk9ERV9SRUYgMTQ2MDIw
KSBpdGVtb2ZmIDEzNTA4IGl0ZW1zaXplIDI3CgkJaW5kZXggNTA2IG5hbWVsZW4gMTcgbmFtZTog
a2RlY29ubmVjdC1hcHAubW8KCWl0ZW0gMjAga2V5ICgxNDc1OTYgWEFUVFJfSVRFTSAzODE3NzUz
NjY3KSBpdGVtb2ZmIDEzNDMyIGl0ZW1zaXplIDc2CgkJbG9jYXRpb24ga2V5ICgwIFVOS05PV04u
MCAwKSB0eXBlIFhBVFRSCgkJdHJhbnNpZCA3NTcyODYgZGF0YV9sZW4gMzAgbmFtZV9sZW4gMTYK
CQluYW1lOiBzZWN1cml0eS5zZWxpbnV4CgkJZGF0YSBzeXN0ZW1fdTpvYmplY3Rfcjpsb2NhbGVf
dDpzMAoJaXRlbSAyMSBrZXkgKDE0NzU5NiBFWFRFTlRfREFUQSAwKSBpdGVtb2ZmIDEzMzc5IGl0
ZW1zaXplIDUzCgkJZ2VuZXJhdGlvbiA3NTcyODYgdHlwZSAxIChyZWd1bGFyKQoJCWV4dGVudCBk
YXRhIGRpc2sgYnl0ZSA1Nzk4MTEzMjgwIG5yIDQwOTYKCQlleHRlbnQgZGF0YSBvZmZzZXQgMCBu
ciA0MDk2IHJhbSA0MDk2CgkJZXh0ZW50IGNvbXByZXNzaW9uIDAgKG5vbmUpCglpdGVtIDIyIGtl
eSAoMTQ3NTk3IElOT0RFX0lURU0gMCkgaXRlbW9mZiAxMzIxOSBpdGVtc2l6ZSAxNjAKCQlnZW5l
cmF0aW9uIDc1NzI4NiB0cmFuc2lkIDc1NzI4NiBzaXplIDU2OTMgbmJ5dGVzIDgxOTIKCQlibG9j
ayBncm91cCAwIG1vZGUgMTAwNjQ0IGxpbmtzIDEgdWlkIDAgZ2lkIDAgcmRldiAwCgkJc2VxdWVu
Y2UgMTQgZmxhZ3MgMHgwKG5vbmUpCgkJYXRpbWUgMTYwOTU1NDIwMy4yMjYxNTg4MzMgKDIwMjEt
MDEtMDEgMjE6MjM6MjMpCgkJY3RpbWUgMTYwOTU1NDIwMy4yMjcxNTkwOTEgKDIwMjEtMDEtMDEg
MjE6MjM6MjMpCgkJbXRpbWUgMTYwMTY1MzY2Ny4wICgyMDIwLTEwLTAyIDExOjQ3OjQ3KQoJCW90
aW1lIDE2MDk1NTQyMDMuMjI2MTU4ODMzICgyMDIxLTAxLTAxIDIxOjIzOjIzKQoJaXRlbSAyMyBr
ZXkgKDE0NzU5NyBJTk9ERV9SRUYgMTQ2MDIwKSBpdGVtb2ZmIDEzMTkyIGl0ZW1zaXplIDI3CgkJ
aW5kZXggNTA4IG5hbWVsZW4gMTcgbmFtZToga2RlY29ubmVjdC1jbGkubW8KCWl0ZW0gMjQga2V5
ICgxNDc1OTcgWEFUVFJfSVRFTSAzODE3NzUzNjY3KSBpdGVtb2ZmIDEzMTE2IGl0ZW1zaXplIDc2
CgkJbG9jYXRpb24ga2V5ICgwIFVOS05PV04uMCAwKSB0eXBlIFhBVFRSCgkJdHJhbnNpZCA3NTcy
ODYgZGF0YV9sZW4gMzAgbmFtZV9sZW4gMTYKCQluYW1lOiBzZWN1cml0eS5zZWxpbnV4CgkJZGF0
YSBzeXN0ZW1fdTpvYmplY3Rfcjpsb2NhbGVfdDpzMAoJaXRlbSAyNSBrZXkgKDE0NzU5NyBFWFRF
TlRfREFUQSAwKSBpdGVtb2ZmIDEzMDYzIGl0ZW1zaXplIDUzCgkJZ2VuZXJhdGlvbiA3NTcyODYg
dHlwZSAxIChyZWd1bGFyKQoJCWV4dGVudCBkYXRhIGRpc2sgYnl0ZSA1Nzk4MTE3Mzc2IG5yIDgx
OTIKCQlleHRlbnQgZGF0YSBvZmZzZXQgMCBuciA4MTkyIHJhbSA4MTkyCgkJZXh0ZW50IGNvbXBy
ZXNzaW9uIDAgKG5vbmUpCglpdGVtIDI2IGtleSAoMTQ3NTk4IElOT0RFX0lURU0gMCkgaXRlbW9m
ZiAxMjkwMyBpdGVtc2l6ZSAxNjAKCQlnZW5lcmF0aW9uIDc1NzI4NiB0cmFuc2lkIDc1NzI4NiBz
aXplIDMxMjIgbmJ5dGVzIDQwOTYKCQlibG9jayBncm91cCAwIG1vZGUgMTAwNjQ0IGxpbmtzIDEg
dWlkIDAgZ2lkIDAgcmRldiAwCgkJc2VxdWVuY2UgMTQgZmxhZ3MgMHgwKG5vbmUpCgkJYXRpbWUg
MTYwOTU1NDIwMy4yMjcxNTkwOTEgKDIwMjEtMDEtMDEgMjE6MjM6MjMpCgkJY3RpbWUgMTYwOTU1
NDIwMy4yMjcxNTkwOTEgKDIwMjEtMDEtMDEgMjE6MjM6MjMpCgkJbXRpbWUgMTYwMTY1MzY2Ny4w
ICgyMDIwLTEwLTAyIDExOjQ3OjQ3KQoJCW90aW1lIDE2MDk1NTQyMDMuMjI3MTU5MDkxICgyMDIx
LTAxLTAxIDIxOjIzOjIzKQoJaXRlbSAyNyBrZXkgKDE0NzU5OCBJTk9ERV9SRUYgMTQ2MDIwKSBp
dGVtb2ZmIDEyODc1IGl0ZW1zaXplIDI4CgkJaW5kZXggNTEwIG5hbWVsZW4gMTggbmFtZToga2Rl
Y29ubmVjdC1jb3JlLm1vCglpdGVtIDI4IGtleSAoMTQ3NTk4IFhBVFRSX0lURU0gMzgxNzc1MzY2
NykgaXRlbW9mZiAxMjc5OSBpdGVtc2l6ZSA3NgoJCWxvY2F0aW9uIGtleSAoMCBVTktOT1dOLjAg
MCkgdHlwZSBYQVRUUgoJCXRyYW5zaWQgNzU3Mjg2IGRhdGFfbGVuIDMwIG5hbWVfbGVuIDE2CgkJ
bmFtZTogc2VjdXJpdHkuc2VsaW51eAoJCWRhdGEgc3lzdGVtX3U6b2JqZWN0X3I6bG9jYWxlX3Q6
czAKCWl0ZW0gMjkga2V5ICgxNDc1OTggRVhURU5UX0RBVEEgMCkgaXRlbW9mZiAxMjc0NiBpdGVt
c2l6ZSA1MwoJCWdlbmVyYXRpb24gNzU3Mjg2IHR5cGUgMSAocmVndWxhcikKCQlleHRlbnQgZGF0
YSBkaXNrIGJ5dGUgNTc5ODEyNTU2OCBuciA0MDk2CgkJZXh0ZW50IGRhdGEgb2Zmc2V0IDAgbnIg
NDA5NiByYW0gNDA5NgoJCWV4dGVudCBjb21wcmVzc2lvbiAwIChub25lKQoJaXRlbSAzMCBrZXkg
KDE0NzU5OSBJTk9ERV9JVEVNIDApIGl0ZW1vZmYgMTI1ODYgaXRlbXNpemUgMTYwCgkJZ2VuZXJh
dGlvbiA3NTcyODYgdHJhbnNpZCA3NTcyODYgc2l6ZSA2MDggbmJ5dGVzIDYwOAoJCWJsb2NrIGdy
b3VwIDAgbW9kZSAxMDA2NDQgbGlua3MgMSB1aWQgMCBnaWQgMCByZGV2IDAKCQlzZXF1ZW5jZSAx
NCBmbGFncyAweDAobm9uZSkKCQlhdGltZSAxNjA5NTU0MjAzLjIyNzE1OTA5MSAoMjAyMS0wMS0w
MSAyMToyMzoyMykKCQljdGltZSAxNjA5NTU0MjAzLjIyNzE1OTA5MSAoMjAyMS0wMS0wMSAyMToy
MzoyMykKCQltdGltZSAxNjAxNjUzNjY3LjAgKDIwMjAtMTAtMDIgMTE6NDc6NDcpCgkJb3RpbWUg
MTYwOTU1NDIwMy4yMjcxNTkwOTEgKDIwMjEtMDEtMDEgMjE6MjM6MjMpCglpdGVtIDMxIGtleSAo
MTQ3NTk5IElOT0RFX1JFRiAxNDYwMjApIGl0ZW1vZmYgMTI1NDggaXRlbXNpemUgMzgKCQlpbmRl
eCA1MTIgbmFtZWxlbiAyOCBuYW1lOiBrZGVjb25uZWN0LWZpbGVpdGVtYWN0aW9uLm1vCglpdGVt
IDMyIGtleSAoMTQ3NTk5IFhBVFRSX0lURU0gMzgxNzc1MzY2NykgaXRlbW9mZiAxMjQ3MiBpdGVt
c2l6ZSA3NgoJCWxvY2F0aW9uIGtleSAoMCBVTktOT1dOLjAgMCkgdHlwZSBYQVRUUgoJCXRyYW5z
aWQgNzU3Mjg2IGRhdGFfbGVuIDMwIG5hbWVfbGVuIDE2CgkJbmFtZTogc2VjdXJpdHkuc2VsaW51
eAoJCWRhdGEgc3lzdGVtX3U6b2JqZWN0X3I6bG9jYWxlX3Q6czAKCWl0ZW0gMzMga2V5ICgxNDc1
OTkgRVhURU5UX0RBVEEgMCkgaXRlbW9mZiAxMTg0MyBpdGVtc2l6ZSA2MjkKCQlnZW5lcmF0aW9u
IDc1NzI4NiB0eXBlIDAgKGlubGluZSkKCQlpbmxpbmUgZXh0ZW50IGRhdGEgc2l6ZSA2MDggcmFt
X2J5dGVzIDYwOCBjb21wcmVzc2lvbiAwIChub25lKQoJaXRlbSAzNCBrZXkgKDE0NzYwMCBJTk9E
RV9JVEVNIDApIGl0ZW1vZmYgMTE2ODMgaXRlbXNpemUgMTYwCgkJZ2VuZXJhdGlvbiA3NTcyODYg
dHJhbnNpZCA3NTcyODYgc2l6ZSAyMjQzIG5ieXRlcyA0MDk2CgkJYmxvY2sgZ3JvdXAgMCBtb2Rl
IDEwMDY0NCBsaW5rcyAxIHVpZCAwIGdpZCAwIHJkZXYgMAoJCXNlcXVlbmNlIDE0IGZsYWdzIDB4
MChub25lKQoJCWF0aW1lIDE2MDk1NTQyMDMuMjI3MTU5MDkxICgyMDIxLTAxLTAxIDIxOjIzOjIz
KQoJCWN0aW1lIDE2MDk1NTQyMDMuMjI3MTU5MDkxICgyMDIxLTAxLTAxIDIxOjIzOjIzKQoJCW10
aW1lIDE2MDE2NTM2NjcuMCAoMjAyMC0xMC0wMiAxMTo0Nzo0NykKCQlvdGltZSAxNjA5NTU0MjAz
LjIyNzE1OTA5MSAoMjAyMS0wMS0wMSAyMToyMzoyMykKCWl0ZW0gMzUga2V5ICgxNDc2MDAgSU5P
REVfUkVGIDE0NjAyMCkgaXRlbW9mZiAxMTY1MCBpdGVtc2l6ZSAzMwoJCWluZGV4IDUxNCBuYW1l
bGVuIDIzIG5hbWU6IGtkZWNvbm5lY3QtaW5kaWNhdG9yLm1vCglpdGVtIDM2IGtleSAoMTQ3NjAw
IFhBVFRSX0lURU0gMzgxNzc1MzY2NykgaXRlbW9mZiAxMTU3NCBpdGVtc2l6ZSA3NgoJCWxvY2F0
aW9uIGtleSAoMCBVTktOT1dOLjAgMCkgdHlwZSBYQVRUUgoJCXRyYW5zaWQgNzU3Mjg2IGRhdGFf
bGVuIDMwIG5hbWVfbGVuIDE2CgkJbmFtZTogc2VjdXJpdHkuc2VsaW51eAoJCWRhdGEgc3lzdGVt
X3U6b2JqZWN0X3I6bG9jYWxlX3Q6czAKCWl0ZW0gMzcga2V5ICgxNDc2MDAgRVhURU5UX0RBVEEg
MCkgaXRlbW9mZiAxMTUyMSBpdGVtc2l6ZSA1MwoJCWdlbmVyYXRpb24gNzU3Mjg2IHR5cGUgMSAo
cmVndWxhcikKCQlleHRlbnQgZGF0YSBkaXNrIGJ5dGUgNTc5ODEyOTY2NCBuciA0MDk2CgkJZXh0
ZW50IGRhdGEgb2Zmc2V0IDAgbnIgNDA5NiByYW0gNDA5NgoJCWV4dGVudCBjb21wcmVzc2lvbiAw
IChub25lKQoJaXRlbSAzOCBrZXkgKDE0NzYwMSBJTk9ERV9JVEVNIDApIGl0ZW1vZmYgMTEzNjEg
aXRlbXNpemUgMTYwCgkJZ2VuZXJhdGlvbiA3NTcyODYgdHJhbnNpZCA3NTcyODYgc2l6ZSA2Njgg
bmJ5dGVzIDY2OAoJCWJsb2NrIGdyb3VwIDAgbW9kZSAxMDA2NDQgbGlua3MgMSB1aWQgMCBnaWQg
MCByZGV2IDAKCQlzZXF1ZW5jZSAxNCBmbGFncyAweDAobm9uZSkKCQlhdGltZSAxNjA5NTU0MjAz
LjIyNzE1OTA5MSAoMjAyMS0wMS0wMSAyMToyMzoyMykKCQljdGltZSAxNjA5NTU0MjAzLjIyNzE1
OTA5MSAoMjAyMS0wMS0wMSAyMToyMzoyMykKCQltdGltZSAxNjAxNjUzNjY3LjAgKDIwMjAtMTAt
MDIgMTE6NDc6NDcpCgkJb3RpbWUgMTYwOTU1NDIwMy4yMjcxNTkwOTEgKDIwMjEtMDEtMDEgMjE6
MjM6MjMpCglpdGVtIDM5IGtleSAoMTQ3NjAxIElOT0RFX1JFRiAxNDYwMjApIGl0ZW1vZmYgMTEz
MjcgaXRlbXNpemUgMzQKCQlpbmRleCA1MTYgbmFtZWxlbiAyNCBuYW1lOiBrZGVjb25uZWN0LWlu
dGVyZmFjZXMubW8KCWl0ZW0gNDAga2V5ICgxNDc2MDEgWEFUVFJfSVRFTSAzODE3NzUzNjY3KSBp
dGVtb2ZmIDExMjUxIGl0ZW1zaXplIDc2CgkJbG9jYXRpb24ga2V5ICgwIFVOS05PV04uMCAwKSB0
eXBlIFhBVFRSCgkJdHJhbnNpZCA3NTcyODYgZGF0YV9sZW4gMzAgbmFtZV9sZW4gMTYKCQluYW1l
OiBzZWN1cml0eS5zZWxpbnV4CgkJZGF0YSBzeXN0ZW1fdTpvYmplY3Rfcjpsb2NhbGVfdDpzMAoJ
aXRlbSA0MSBrZXkgKDE0NzYwMSBFWFRFTlRfREFUQSAwKSBpdGVtb2ZmIDEwNTYyIGl0ZW1zaXpl
IDY4OQoJCWdlbmVyYXRpb24gNzU3Mjg2IHR5cGUgMCAoaW5saW5lKQoJCWlubGluZSBleHRlbnQg
ZGF0YSBzaXplIDY2OCByYW1fYnl0ZXMgNjY4IGNvbXByZXNzaW9uIDAgKG5vbmUpCglpdGVtIDQy
IGtleSAoMTQ3NjAyIElOT0RFX0lURU0gMCkgaXRlbW9mZiAxMDQwMiBpdGVtc2l6ZSAxNjAKCQln
ZW5lcmF0aW9uIDc1NzI4NiB0cmFuc2lkIDc1NzI4NiBzaXplIDMyNzYgbmJ5dGVzIDQwOTYKCQli
bG9jayBncm91cCAwIG1vZGUgMTAwNjQ0IGxpbmtzIDEgdWlkIDAgZ2lkIDAgcmRldiAwCgkJc2Vx
dWVuY2UgMTQgZmxhZ3MgMHgwKG5vbmUpCgkJYXRpbWUgMTYwOTU1NDIwMy4yMjcxNTkwOTEgKDIw
MjEtMDEtMDEgMjE6MjM6MjMpCgkJY3RpbWUgMTYwOTU1NDIwMy4yMjcxNTkwOTEgKDIwMjEtMDEt
MDEgMjE6MjM6MjMpCgkJbXRpbWUgMTYwMTY1MzY2Ny4wICgyMDIwLTEwLTAyIDExOjQ3OjQ3KQoJ
CW90aW1lIDE2MDk1NTQyMDMuMjI3MTU5MDkxICgyMDIxLTAxLTAxIDIxOjIzOjIzKQoJaXRlbSA0
MyBrZXkgKDE0NzYwMiBJTk9ERV9SRUYgMTQ2MDIwKSBpdGVtb2ZmIDEwMzc1IGl0ZW1zaXplIDI3
CgkJaW5kZXggNTE4IG5hbWVsZW4gMTcgbmFtZToga2RlY29ubmVjdC1rY20ubW8KCWl0ZW0gNDQg
a2V5ICgxNDc2MDIgWEFUVFJfSVRFTSAzODE3NzUzNjY3KSBpdGVtb2ZmIDEwMjk5IGl0ZW1zaXpl
IDc2CgkJbG9jYXRpb24ga2V5ICgwIFVOS05PV04uMCAwKSB0eXBlIFhBVFRSCgkJdHJhbnNpZCA3
NTcyODYgZGF0YV9sZW4gMzAgbmFtZV9sZW4gMTYKCQluYW1lOiBzZWN1cml0eS5zZWxpbnV4CgkJ
ZGF0YSBzeXN0ZW1fdTpvYmplY3Rfcjpsb2NhbGVfdDpzMAoJaXRlbSA0NSBrZXkgKDE0NzYwMiBF
WFRFTlRfREFUQSAwKSBpdGVtb2ZmIDEwMjQ2IGl0ZW1zaXplIDUzCgkJZ2VuZXJhdGlvbiA3NTcy
ODYgdHlwZSAxIChyZWd1bGFyKQoJCWV4dGVudCBkYXRhIGRpc2sgYnl0ZSA1Nzk4MTMzNzYwIG5y
IDQwOTYKCQlleHRlbnQgZGF0YSBvZmZzZXQgMCBuciA0MDk2IHJhbSA0MDk2CgkJZXh0ZW50IGNv
bXByZXNzaW9uIDAgKG5vbmUpCglpdGVtIDQ2IGtleSAoMTQ3NjAzIElOT0RFX0lURU0gMCkgaXRl
bW9mZiAxMDA4NiBpdGVtc2l6ZSAxNjAKCQlnZW5lcmF0aW9uIDc1NzI4NiB0cmFuc2lkIDc1NzI4
NiBzaXplIDk1OSBuYnl0ZXMgOTU5CgkJYmxvY2sgZ3JvdXAgMCBtb2RlIDEwMDY0NCBsaW5rcyAx
IHVpZCAwIGdpZCAwIHJkZXYgMAoJCXNlcXVlbmNlIDE0IGZsYWdzIDB4MChub25lKQoJCWF0aW1l
IDE2MDk1NTQyMDMuMjI3MTU5MDkxICgyMDIxLTAxLTAxIDIxOjIzOjIzKQoJCWN0aW1lIDE2MDk1
NTQyMDMuMjI3MTU5MDkxICgyMDIxLTAxLTAxIDIxOjIzOjIzKQoJCW10aW1lIDE2MDE2NTM2Njcu
MCAoMjAyMC0xMC0wMiAxMTo0Nzo0NykKCQlvdGltZSAxNjA5NTU0MjAzLjIyNzE1OTA5MSAoMjAy
MS0wMS0wMSAyMToyMzoyMykKCWl0ZW0gNDcga2V5ICgxNDc2MDMgSU5PREVfUkVGIDE0NjAyMCkg
aXRlbW9mZiAxMDA1OCBpdGVtc2l6ZSAyOAoJCWluZGV4IDUyMCBuYW1lbGVuIDE4IG5hbWU6IGtk
ZWNvbm5lY3Qta2RlZC5tbwoJaXRlbSA0OCBrZXkgKDE0NzYwMyBYQVRUUl9JVEVNIDM4MTc3NTM2
NjcpIGl0ZW1vZmYgOTk4MiBpdGVtc2l6ZSA3NgoJCWxvY2F0aW9uIGtleSAoMCBVTktOT1dOLjAg
MCkgdHlwZSBYQVRUUgoJCXRyYW5zaWQgNzU3Mjg2IGRhdGFfbGVuIDMwIG5hbWVfbGVuIDE2CgkJ
bmFtZTogc2VjdXJpdHkuc2VsaW51eAoJCWRhdGEgc3lzdGVtX3U6b2JqZWN0X3I6bG9jYWxlX3Q6
czAKCWl0ZW0gNDkga2V5ICgxNDc2MDMgRVhURU5UX0RBVEEgMCkgaXRlbW9mZiA5MDAyIGl0ZW1z
aXplIDk4MAoJCWdlbmVyYXRpb24gNzU3Mjg2IHR5cGUgMCAoaW5saW5lKQoJCWlubGluZSBleHRl
bnQgZGF0YSBzaXplIDk1OSByYW1fYnl0ZXMgOTU5IGNvbXByZXNzaW9uIDAgKG5vbmUpCglpdGVt
IDUwIGtleSAoMTQ3NjA0IElOT0RFX0lURU0gMCkgaXRlbW9mZiA4ODQyIGl0ZW1zaXplIDE2MAoJ
CWdlbmVyYXRpb24gNzU3Mjg2IHRyYW5zaWQgNzU3Mjg2IHNpemUgMTAzMyBuYnl0ZXMgMTAzMwoJ
CWJsb2NrIGdyb3VwIDAgbW9kZSAxMDA2NDQgbGlua3MgMSB1aWQgMCBnaWQgMCByZGV2IDAKCQlz
ZXF1ZW5jZSAxNCBmbGFncyAweDAobm9uZSkKCQlhdGltZSAxNjA5NTU0MjAzLjIyNzE1OTA5MSAo
MjAyMS0wMS0wMSAyMToyMzoyMykKCQljdGltZSAxNjA5NTU0MjAzLjIyNzE1OTA5MSAoMjAyMS0w
MS0wMSAyMToyMzoyMykKCQltdGltZSAxNjAxNjUzNjY3LjAgKDIwMjAtMTAtMDIgMTE6NDc6NDcp
CgkJb3RpbWUgMTYwOTU1NDIwMy4yMjcxNTkwOTEgKDIwMjEtMDEtMDEgMjE6MjM6MjMpCglpdGVt
IDUxIGtleSAoMTQ3NjA0IElOT0RFX1JFRiAxNDYwMjApIGl0ZW1vZmYgODgxNSBpdGVtc2l6ZSAy
NwoJCWluZGV4IDUyMiBuYW1lbGVuIDE3IG5hbWU6IGtkZWNvbm5lY3Qta2lvLm1vCglpdGVtIDUy
IGtleSAoMTQ3NjA0IFhBVFRSX0lURU0gMzgxNzc1MzY2NykgaXRlbW9mZiA4NzM5IGl0ZW1zaXpl
IDc2CgkJbG9jYXRpb24ga2V5ICgwIFVOS05PV04uMCAwKSB0eXBlIFhBVFRSCgkJdHJhbnNpZCA3
NTcyODYgZGF0YV9sZW4gMzAgbmFtZV9sZW4gMTYKCQluYW1lOiBzZWN1cml0eS5zZWxpbnV4CgkJ
ZGF0YSBzeXN0ZW1fdTpvYmplY3Rfcjpsb2NhbGVfdDpzMAo=
--0000000000005b472a05bd103f89--
