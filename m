Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF43932ED55
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 15:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCEOmO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 09:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhCEOmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Mar 2021 09:42:10 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBB4C061574
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Mar 2021 06:42:09 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id x19so2208728ybe.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Mar 2021 06:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieD7NLXCfmYmYTzoXvB74GHAKz29/MobgN/hPAIHgXo=;
        b=e84W6eZDAHK2R7H7rmgmed/P9LAZZKcPyyCXX7QiekfxuBJvLszjQdSFZJJBiGW9hL
         PaWjpAISZ5Pv47VX2xCsKeCjKP0SSjpL3dln5TSgTeiCU0UiLJJxp3PfRhSfl8hxGRxR
         by3lxWq50fVgmsCsira22qPwaD4P9JANrkrDr9yTmzk0H70IwTmYdhzsAgt0MQy/QSWW
         0GaLZNnZz8eqn5Radtrri7RTUH6yFYf5UdpS8anS+0oXZmr1CZ1w+IZdei0YWb5UVfJY
         LopYafI5P1oDPvaQuGa+uanTwELbq6vzetU4sheN+Rp90WnWBKD/piXIZqQaXO3ZBIW9
         D0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieD7NLXCfmYmYTzoXvB74GHAKz29/MobgN/hPAIHgXo=;
        b=i99XgYx3yZ+f2XxB6jL+uBEEc8Hv6QpIS69WJAeL+lANink27ZaSc+myDUaUhFrrB0
         Y2UefyEYfesnTHevTzrxsAiV828ATPxTpFWY8ZJOGjtHvzcsyZVBkiZRNIFO6K4Ngi6U
         gjdt2lbZJKKQb6524BFTaferTyOFF1yjd7yYZXrCViSn4e8VkqOTQqfKKar9qjVz5KVt
         9xy/nhxDv2TyaeoPtVAMlV7ss+KlyXJYyL0QZtHfXX2LdlcSPfT9RUEAv+UbbEKp7Lcl
         vJyD/843KDHm8WmGvqNathP14i7WQ9ovmS5Uy0NglzvrXx0eg4pWVWo0DGzoAbcu1ROg
         Qwwg==
X-Gm-Message-State: AOAM532HzRo+oPQaUB6aPWUjJvOHzqBi9lGdSkoBbSWM1YvFZ7zdkTKr
        J2N0tGgjdnHlTcglF3w2X7QtaOQQ8+Xr6DuxYUu3AZtF4gI=
X-Google-Smtp-Source: ABdhPJxZU4HhD72seZNrrXOkrGMaYauDD17AfQ5+uvHL94gUXdBwM2NzEeKy6AR4XE0vwwH0erfXdoULM8wLGS8s+UU=
X-Received: by 2002:a05:6902:727:: with SMTP id l7mr14213714ybt.184.1614955328985;
 Fri, 05 Mar 2021 06:42:08 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <56747283-fe34-51c5-9dbf-930bdafffaed@toxicpanda.com> <CAEg-Je_=jUMJfAqwtuZwcPE4+HOAJB7JC5gKSw4EeZrutxk5kA@mail.gmail.com>
 <58f4fe54-a462-b256-df60-17b1084235f6@toxicpanda.com> <CAEg-Je-_r3_AsLHa_HDDOUwVs+Jtty5roFvEyF4K-T2D7oEayA@mail.gmail.com>
 <58246f4c-4e26-c89c-a589-376cfe23d783@toxicpanda.com> <CAEg-Je-yPqueyW3JqSWrAE_9ckc1KTyaNoFwjbozNLrvb7_tEg@mail.gmail.com>
 <a9561d44-24a3-fa87-e292-98feb4846ab9@toxicpanda.com> <CAEg-Je8o2GiAH2wC9DXiMdMSCFnAjeV6UH-qaobk_0qYLNsPsQ@mail.gmail.com>
 <95e8db7d-eff3-e694-c315-f7984b5f49e0@toxicpanda.com> <CAEg-Je_s6EAHwj2LWYRLdMHF_kRuY_JQoLfWMqDgcROZatnP+g@mail.gmail.com>
 <ef2ec021-52d3-2da4-f59a-fa7016c95d90@toxicpanda.com> <CAEg-Je_HKgGLnF6F_3dXd+9NFa9cTceWWtTUhSSjNovsze_wQg@mail.gmail.com>
 <d2c7b501-f2f1-c471-4b1b-38e6731682ba@toxicpanda.com> <CAEg-Je_TN04fnE2Bg46Nysm2_fG7dcni-7c6wbfZQZqXhDhbnA@mail.gmail.com>
 <e5b5409b-0e34-abd5-81c9-48ef59c3fa03@toxicpanda.com>
In-Reply-To: <e5b5409b-0e34-abd5-81c9-48ef59c3fa03@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Fri, 5 Mar 2021 09:41:32 -0500
Message-ID: <CAEg-Je-oOnnCd=Vc65yTam6-jxHr2rEr9yrzi_xv79ziys0TjA@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b68a4405bccb167a"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000b68a4405bccb167a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 5, 2021 at 9:12 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 3/4/21 6:54 PM, Neal Gompa wrote:
> > On Thu, Mar 4, 2021 at 3:25 PM Josef Bacik <josef@toxicpanda.com> wrote=
:
> >>
> >> On 3/3/21 2:38 PM, Neal Gompa wrote:
> >>> On Wed, Mar 3, 2021 at 1:42 PM Josef Bacik <josef@toxicpanda.com> wro=
te:
> >>>>
> >>>> On 2/24/21 10:47 PM, Neal Gompa wrote:
> >>>>> On Wed, Feb 24, 2021 at 10:44 AM Josef Bacik <josef@toxicpanda.com>=
 wrote:
> >>>>>>
> >>>>>> On 2/24/21 9:23 AM, Neal Gompa wrote:
> >>>>>>> On Tue, Feb 23, 2021 at 10:05 AM Josef Bacik <josef@toxicpanda.co=
m> wrote:
> >>>>>>>>
> >>>>>>>> On 2/22/21 11:03 PM, Neal Gompa wrote:
> >>>>>>>>> On Mon, Feb 22, 2021 at 2:34 PM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2/21/21 1:27 PM, Neal Gompa wrote:
> >>>>>>>>>>> On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef@toxicpand=
a.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2/17/21 11:29 AM, Neal Gompa wrote:
> >>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@toxicpan=
da.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 2/17/21 9:50 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicp=
anda.com> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxi=
cpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@to=
xicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef=
@toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>> Hey all,
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>> So one of my main computers recently had a disk c=
ontroller failure
> >>>>>>>>>>>>>>>>>>>>>>> that caused my machine to freeze. After rebooting=
, Btrfs refuses to
> >>>>>>>>>>>>>>>>>>>>>>> mount. I tried to do a mount and the following er=
rors show up in the
> >>>>>>>>>>>>>>>>>>>>>>> journal:
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS inf=
o (device sda3): disk space caching is enabled
> >>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS inf=
o (device sda3): has skinny extents
> >>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS cri=
tical (device sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 i=
no=3D203657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS err=
or (device sda3): block=3D796082176 read time tree block corruption detecte=
d
> >>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS cri=
tical (device sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 i=
no=3D203657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS err=
or (device sda3): block=3D796082176 read time tree block corruption detecte=
d
> >>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS war=
ning (device sda3): couldn't read tree root
> >>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS err=
or (device sda3): open_ctree failed
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>> I've tried to do -o recovery,ro mount and get the=
 same issue. I can't
> >>>>>>>>>>>>>>>>>>>>>>> seem to find any reasonably good information on h=
ow to do recovery in
> >>>>>>>>>>>>>>>>>>>>>>> this scenario, even to just recover enough to cop=
y data off.
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>> I'm on Fedora 33, the system was on Linux kernel =
version 5.9.16 and
> >>>>>>>>>>>>>>>>>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel=
 version 5.10.14. I'm
> >>>>>>>>>>>>>>>>>>>>>>> using btrfs-progs v5.10.
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>> Can anyone help?
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> Can you try
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> That should fix the inode generation thing so it's=
 sane, and then the tree
> >>>>>>>>>>>>>>>>>>>>>> checker will allow the fs to be read, hopefully.  =
If not we can work out some
> >>>>>>>>>>>>>>>>>>>>>> other magic.  Thanks,
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> Josef
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> I got the same error as I did with btrfs-check --re=
adonly...
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Oh lovely, what does btrfs check --readonly --backup=
 do?
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> No dice...
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> # btrfs check --readonly --backup /dev/sda3
> >>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888=
893 found 888895
> >>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888=
893 found 888895
> >>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888=
893 found 888895
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Hey look the block we're looking for, I wrote you some=
 magic, just pull
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> https://github.com/josefbacik/btrfs-progs/tree/for-nea=
l
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> build, and then run
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> This will force us to point at the old root with (hope=
fully) the right bytenr
> >>>>>>>>>>>>>>>>>> and gen, and then hopefully you'll be able to recover =
from there.  This is kind
> >>>>>>>>>>>>>>>>>> of saucy, so yolo, but I can undo it if it makes thing=
s worse.  Thanks,
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> # btrfs check --readonly /dev/sda3
> >>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>>>>>> # btrfs check --clear-space-cache v1 /dev/sda3
> >>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> It's better, but still no dice... :(
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Hmm it's not telling us what's wrong with the extent tre=
e, which is annoying.
> >>>>>>>>>>>>>>>> Does mount -o rescue=3Dall,ro work now that the root tre=
e is normal?  Thanks,
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Nope, I see this in the journal:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (devic=
e sda3): enabling all of the rescue options
> >>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (devic=
e sda3): ignoring data csums
> >>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (devic=
e sda3): ignoring bad roots
> >>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (devic=
e sda3): disabling log replay at mount time
> >>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (devic=
e sda3): disk space caching is enabled
> >>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (devic=
e sda3): has skinny extents
> >>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (devi=
ce sda3): tree level mismatch detected, bytenr=3D791281664 level expected=
=3D1 has=3D2
> >>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (devi=
ce sda3): tree level mismatch detected, bytenr=3D791281664 level expected=
=3D1 has=3D2
> >>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (de=
vice sda3): couldn't read tree root
> >>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (devi=
ce sda3): open_ctree failed
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Ok git pull for-neal, rebuild, then run
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895 2
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I thought of this yesterday but in my head was like "naaah=
hhh, whats the chances
> >>>>>>>>>>>>>> that the level doesn't match??".  Thanks,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Tried rescue mount again after running that and got a stack=
 trace in
> >>>>>>>>>>>>> the kernel, detailed in the following attached log.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Huh I wonder how I didn't hit this when testing, I must have=
 only tested with
> >>>>>>>>>>>> zero'ing the extent root and the csum root.  You're going to=
 have to build a
> >>>>>>>>>>>> kernel with a fix for this
> >>>>>>>>>>>>
> >>>>>>>>>>>> https://paste.centos.org/view/7b48aaea
> >>>>>>>>>>>>
> >>>>>>>>>>>> and see if that gets you further.  Thanks,
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> I built a kernel build as an RPM with your patch[1] and tried=
 it.
> >>>>>>>>>>>
> >>>>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 =
/mnt
> >>>>>>>>>>> Killed
> >>>>>>>>>>>
> >>>>>>>>>>> The log from the journal is attached.
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Ahh crud my bad, this should do it
> >>>>>>>>>>
> >>>>>>>>>> https://paste.centos.org/view/ac2e61ef
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Patch doesn't apply (note it is patch 667 below):
> >>>>>>>>
> >>>>>>>> Ah sorry, should have just sent you an iterative patch.  You can=
 take the above
> >>>>>>>> patch and just delete the hunk from volumes.c as you already hav=
e that applied
> >>>>>>>> and then it'll work.  Thanks,
> >>>>>>>>
> >>>>>>>
> >>>>>>> Failed with a weird error...?
> >>>>>>>
> >>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sda3 /mnt
> >>>>>>> mount: /mnt: mount(2) system call failed: No such file or directo=
ry.
> >>>>>>>
> >>>>>>> Journal log with traceback attached.
> >>>>>>
> >>>>>> Last one maybe?
> >>>>>>
> >>>>>> https://paste.centos.org/view/80edd6fd
> >>>>>>
> >>>>>
> >>>>> Similar weird failure:
> >>>>>
> >>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 /mnt
> >>>>> mount: /mnt: mount(2) system call failed: No such file or directory=
.
> >>>>>
> >>>>> No crash in the journal this time, though:
> >>>>>
> >>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): enabling =
all of the rescue options
> >>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignoring =
data csums
> >>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignoring =
bad roots
> >>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disabling=
 log replay at mount time
> >>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disk spac=
e caching is enabled
> >>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): has skinn=
y extents
> >>>>>> Feb 24 22:43:19 fedora kernel: BTRFS warning (device sdb3): failed=
 to read fs tree: -2
> >>>>>> Feb 24 22:43:19 fedora kernel: BTRFS error (device sdb3): open_ctr=
ee failed
> >>>>>
> >>>>>
> >>>>
> >>>> Sorry Neal, you replied when I was in the middle of something and pr=
omptly
> >>>> forgot about it.  I figured the fs root was fine, can you do the fol=
lowing so I
> >>>> can figure out from the error messages what might be wrong
> >>>>
> >>>> btrfs check --readonly
> >>>> btrfs restore -D
> >>>> btrfs restore -l
> >>>>
> >>>
> >>> It didn't work.. Here's the output:
> >>>
> >>> [root@fedora ~]# btrfs check --readonly /dev/sdb3
> >>> Opening filesystem to check...
> >>> ERROR: could not setup extent tree
> >>> ERROR: cannot open file system
> >>> [root@fedora ~]# btrfs restore -D /dev/sdb3 /mnt
> >>> WARNING: could not setup extent tree, skipping it
> >>> Couldn't setup device tree
> >>> Could not open root, trying backup super
> >>> parent transid verify failed on 796082176 wanted 888894 found 888896
> >>> parent transid verify failed on 796082176 wanted 888894 found 888896
> >>> parent transid verify failed on 796082176 wanted 888894 found 888896
> >>> Ignoring transid failure
> >>> WARNING: could not setup extent tree, skipping it
> >>> Couldn't setup device tree
> >>> Could not open root, trying backup super
> >>> ERROR: superblock bytenr 274877906944 is larger than device size 2631=
32807168
> >>> Could not open root, trying backup super
> >>> [root@fedora ~]# btrfs restore -l /dev/sdb3 /mnt
> >>> WARNING: could not setup extent tree, skipping it
> >>> Couldn't setup device tree
> >>> Could not open root, trying backup super
> >>> parent transid verify failed on 796082176 wanted 888894 found 888896
> >>> parent transid verify failed on 796082176 wanted 888894 found 888896
> >>> parent transid verify failed on 796082176 wanted 888894 found 888896
> >>> Ignoring transid failure
> >>> WARNING: could not setup extent tree, skipping it
> >>> Couldn't setup device tree
> >>> Could not open root, trying backup super
> >>> ERROR: superblock bytenr 274877906944 is larger than device size 2631=
32807168
> >>> Could not open root, trying backup super
> >>>
> >>>
> >>
> >> Hmm OK I think we want the neal magic for this one too, but before we =
go doing
> >> that can I get a
> >>
> >> btrfs inspect-internal -f /dev/whatever
> >>
> >> so I can make sure I'm not just blindly clobbering something.  Thanks,
> >>
> >
> > Doesn't work, did you mean some other command?
> >
> > [root@fedora ~]#  btrfs inspect-internal -f /dev/sdb3
> > btrfs inspect-internal: unknown token '-f'
>
> Sigh, sorry, btrfs inspect-internal dump-super -f /dev/sdb3
>

Output from the command attached.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

--000000000000b68a4405bccb167a
Content-Type: text/x-log; charset="US-ASCII"; name="output-inspect-internal.log"
Content-Disposition: attachment; filename="output-inspect-internal.log"
Content-Transfer-Encoding: base64
Content-ID: <f_klweogbu0>
X-Attachment-Id: f_klweogbu0

c3VwZXJibG9jazogYnl0ZW5yPTY1NTM2LCBkZXZpY2U9L2Rldi9zZGIzCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpjc3VtX3R5cGUJCTAg
KGNyYzMyYykKY3N1bV9zaXplCQk0CmNzdW0JCQkweDVmZDFkYTBiIFttYXRjaF0KYnl0ZW5yCQkJ
NjU1MzYKZmxhZ3MJCQkweDEKCQkJKCBXUklUVEVOICkKbWFnaWMJCQlfQkhSZlNfTSBbbWF0Y2hd
CmZzaWQJCQlmOTkzZmZhNC04ODAxLTRkNTctYTA4Ny0xYzM1ZmQ2ZWNlMDAKbWV0YWRhdGFfdXVp
ZAkJZjk5M2ZmYTQtODgwMS00ZDU3LWEwODctMWMzNWZkNmVjZTAwCmxhYmVsCQkJZmVkb3JhX2Yz
Mi1yeW8tb2hraS13aW52bQpnZW5lcmF0aW9uCQk4ODg4OTUKcm9vdAkJCTc5MTI4MTY2NApzeXNf
YXJyYXlfc2l6ZQkJMTI5CmNodW5rX3Jvb3RfZ2VuZXJhdGlvbgk3ODcyODQKcm9vdF9sZXZlbAkJ
MgpjaHVua19yb290CQkyMjAzNjQ4MApjaHVua19yb290X2xldmVsCTAKbG9nX3Jvb3QJCTAKbG9n
X3Jvb3RfdHJhbnNpZAkwCmxvZ19yb290X2xldmVsCQkwCnRvdGFsX2J5dGVzCQkyNjMxMzI4MDcx
NjgKYnl0ZXNfdXNlZAkJMTE0OTI4Njc2ODY0CnNlY3RvcnNpemUJCTQwOTYKbm9kZXNpemUJCTE2
Mzg0CmxlYWZzaXplIChkZXByZWNhdGVkKQkxNjM4NApzdHJpcGVzaXplCQk0MDk2CnJvb3RfZGly
CQk2Cm51bV9kZXZpY2VzCQkxCmNvbXBhdF9mbGFncwkJMHgwCmNvbXBhdF9yb19mbGFncwkJMHgw
CmluY29tcGF0X2ZsYWdzCQkweDE2MQoJCQkoIE1JWEVEX0JBQ0tSRUYgfAoJCQkgIEJJR19NRVRB
REFUQSB8CgkJCSAgRVhURU5ERURfSVJFRiB8CgkJCSAgU0tJTk5ZX01FVEFEQVRBICkKY2FjaGVf
Z2VuZXJhdGlvbgk4ODg4OTQKdXVpZF90cmVlX2dlbmVyYXRpb24JODg4ODk0CmRldl9pdGVtLnV1
aWQJCWJmNTBmN2YxLWJiOTgtNDkzMi04Mzg4LTkzNWU0ODM4Y2I2MwpkZXZfaXRlbS5mc2lkCQlm
OTkzZmZhNC04ODAxLTRkNTctYTA4Ny0xYzM1ZmQ2ZWNlMDAgW21hdGNoXQpkZXZfaXRlbS50eXBl
CQkwCmRldl9pdGVtLnRvdGFsX2J5dGVzCTI2MzEzMjgwNzE2OApkZXZfaXRlbS5ieXRlc191c2Vk
CTEzMTAyMTY2ODM1MgpkZXZfaXRlbS5pb19hbGlnbgk0MDk2CmRldl9pdGVtLmlvX3dpZHRoCTQw
OTYKZGV2X2l0ZW0uc2VjdG9yX3NpemUJNDA5NgpkZXZfaXRlbS5kZXZpZAkJMQpkZXZfaXRlbS5k
ZXZfZ3JvdXAJMApkZXZfaXRlbS5zZWVrX3NwZWVkCTAKZGV2X2l0ZW0uYmFuZHdpZHRoCTAKZGV2
X2l0ZW0uZ2VuZXJhdGlvbgkwCnN5c19jaHVua19hcnJheVsyMDQ4XToKCWl0ZW0gMCBrZXkgKEZJ
UlNUX0NIVU5LX1RSRUUgQ0hVTktfSVRFTSAyMjAyMDA5NikKCQlsZW5ndGggODM4ODYwOCBvd25l
ciAyIHN0cmlwZV9sZW4gNjU1MzYgdHlwZSBTWVNURU18RFVQCgkJaW9fYWxpZ24gNjU1MzYgaW9f
d2lkdGggNjU1MzYgc2VjdG9yX3NpemUgNDA5NgoJCW51bV9zdHJpcGVzIDIgc3ViX3N0cmlwZXMg
MQoJCQlzdHJpcGUgMCBkZXZpZCAxIG9mZnNldCAyMjAyMDA5NgoJCQlkZXZfdXVpZCBiZjUwZjdm
MS1iYjk4LTQ5MzItODM4OC05MzVlNDgzOGNiNjMKCQkJc3RyaXBlIDEgZGV2aWQgMSBvZmZzZXQg
MzA0MDg3MDQKCQkJZGV2X3V1aWQgYmY1MGY3ZjEtYmI5OC00OTMyLTgzODgtOTM1ZTQ4MzhjYjYz
CmJhY2t1cF9yb290c1s0XToKCWJhY2t1cCAwOgoJCWJhY2t1cF90cmVlX3Jvb3Q6CTc5MTI4MTY2
NAlnZW46IDg4ODg5MwlsZXZlbDogMQoJCWJhY2t1cF9jaHVua19yb290OgkyMjAzNjQ4MAlnZW46
IDc4NzI4NAlsZXZlbDogMAoJCWJhY2t1cF9leHRlbnRfcm9vdDoJNzkwNjQyNjg4CWdlbjogODg4
ODkzCWxldmVsOiAyCgkJYmFja3VwX2ZzX3Jvb3Q6CQk0ODQzMTEwNAlnZW46IDc1NzI3NglsZXZl
bDogMAoJCWJhY2t1cF9kZXZfcm9vdDoJMjkwOTc5ODQwCWdlbjogODg4NTM5CWxldmVsOiAwCgkJ
YmFja3VwX2NzdW1fcm9vdDoJNzg5NzQxNTY4CWdlbjogODg4ODkzCWxldmVsOiAyCgkJYmFja3Vw
X3RvdGFsX2J5dGVzOgkyNjMxMzI4MDcxNjgKCQliYWNrdXBfYnl0ZXNfdXNlZDoJMTE0OTI4Njg5
MTUyCgkJYmFja3VwX251bV9kZXZpY2VzOgkxCgoJYmFja3VwIDE6CgkJYmFja3VwX3RyZWVfcm9v
dDoJNzk2MDgyMTc2CWdlbjogODg4ODk0CWxldmVsOiAxCgkJYmFja3VwX2NodW5rX3Jvb3Q6CTIy
MDM2NDgwCWdlbjogNzg3Mjg0CWxldmVsOiAwCgkJYmFja3VwX2V4dGVudF9yb290Ogk3OTQ5NTE2
ODAJZ2VuOiA4ODg4OTQJbGV2ZWw6IDIKCQliYWNrdXBfZnNfcm9vdDoJCTQ4NDMxMTA0CWdlbjog
NzU3Mjc2CWxldmVsOiAwCgkJYmFja3VwX2Rldl9yb290OgkyOTA5Nzk4NDAJZ2VuOiA4ODg1MzkJ
bGV2ZWw6IDAKCQliYWNrdXBfY3N1bV9yb290Ogk3OTE0NjE4ODgJZ2VuOiA4ODg4OTQJbGV2ZWw6
IDIKCQliYWNrdXBfdG90YWxfYnl0ZXM6CTI2MzEzMjgwNzE2OAoJCWJhY2t1cF9ieXRlc191c2Vk
OgkxMTQ5Mjg2NzY4NjQKCQliYWNrdXBfbnVtX2RldmljZXM6CTEKCgliYWNrdXAgMjoKCQliYWNr
dXBfdHJlZV9yb290Ogk3OTEyNDg4OTYJZ2VuOiA4ODg4OTEJbGV2ZWw6IDEKCQliYWNrdXBfY2h1
bmtfcm9vdDoJMjIwMzY0ODAJZ2VuOiA3ODcyODQJbGV2ZWw6IDAKCQliYWNrdXBfZXh0ZW50X3Jv
b3Q6CTc4OTcyNTE4NAlnZW46IDg4ODg5MQlsZXZlbDogMgoJCWJhY2t1cF9mc19yb290OgkJNDg0
MzExMDQJZ2VuOiA3NTcyNzYJbGV2ZWw6IDAKCQliYWNrdXBfZGV2X3Jvb3Q6CTI5MDk3OTg0MAln
ZW46IDg4ODUzOQlsZXZlbDogMAoJCWJhY2t1cF9jc3VtX3Jvb3Q6CTc4OTYyNjg4MAlnZW46IDg4
ODg5MQlsZXZlbDogMgoJCWJhY2t1cF90b3RhbF9ieXRlczoJMjYzMTMyODA3MTY4CgkJYmFja3Vw
X2J5dGVzX3VzZWQ6CTExNDkyODY5MzI0OAoJCWJhY2t1cF9udW1fZGV2aWNlczoJMQoKCWJhY2t1
cCAzOgoJCWJhY2t1cF90cmVlX3Jvb3Q6CTc5NTIzMDIwOAlnZW46IDg4ODg5MglsZXZlbDogMQoJ
CWJhY2t1cF9jaHVua19yb290OgkyMjAzNjQ4MAlnZW46IDc4NzI4NAlsZXZlbDogMAoJCWJhY2t1
cF9leHRlbnRfcm9vdDoJNzkzMDM0NzUyCWdlbjogODg4ODkyCWxldmVsOiAyCgkJYmFja3VwX2Zz
X3Jvb3Q6CQk0ODQzMTEwNAlnZW46IDc1NzI3NglsZXZlbDogMAoJCWJhY2t1cF9kZXZfcm9vdDoJ
MjkwOTc5ODQwCWdlbjogODg4NTM5CWxldmVsOiAwCgkJYmFja3VwX2NzdW1fcm9vdDoJNzg5Njky
NDE2CWdlbjogODg4ODkyCWxldmVsOiAyCgkJYmFja3VwX3RvdGFsX2J5dGVzOgkyNjMxMzI4MDcx
NjgKCQliYWNrdXBfYnl0ZXNfdXNlZDoJMTE0OTI4Njg5MTUyCgkJYmFja3VwX251bV9kZXZpY2Vz
OgkxCgoK
--000000000000b68a4405bccb167a--
