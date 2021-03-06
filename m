Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDA532F76B
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Mar 2021 02:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhCFBEh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 20:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCFBEP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Mar 2021 20:04:15 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02AAC06175F
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Mar 2021 17:04:14 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id h82so3812550ybc.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Mar 2021 17:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fG9P6La4F2NWsyxsnTq7tr4Y6l7SzE+Ud6yBqjGBkJQ=;
        b=kAm09C5FXCQPkEWXZypJzpwn/yuPj8yKpbo4y9Rg9Ii+v/qXR7pBrNIB0jS1JAM/V+
         yepdGWz2c8R9ebRf8LZ+VBNBzLd90F215vzoyQzaFAsMFmCj3wOFD3WOvQSXaOkT7Kt2
         F/o8PL7PnBUT3AiOtwjywQT1mZXUSZozS9SvsOnbr8dLfCmIiAhQtmQ0GNrNk8SEN60q
         k4JbwYkk+loYZRS0Qqu9wP3aZjUV3IpdKPHfSu47a5XQd+wgrRX/VmZ1LjUcfO9TZivh
         d8WKOaJxf8qk4eYeUGQaopFWaobMXEpe8gHxgOhGdJ30ymu6LtuIOne9MiOJIP+k+5nR
         1Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fG9P6La4F2NWsyxsnTq7tr4Y6l7SzE+Ud6yBqjGBkJQ=;
        b=bXKp3uYaRAKSkFH3YcMtZ9esnVbj0JexOjk/lm3L6pcs74Zap9wOPlWtTKcECxgk+P
         BMtTfxxmjdxRKGjgeFK5SsTNHAeXzBT2Fu5GG0ncbwZDNQh8+XiaonN1yTUWHte4g2De
         AOoGyY1Q9IDAAsxxOoVQtGTPSYOtClWFooW3azbsQQ0hE8i7p4xViS9cDD3n7e9VQRJg
         1O/wRyvAzbwNPD1qQIX87Yt/lqoKFNz+FL6CR3dGZyfs4qMMOxdaA1VSv3WBg59Dk0ww
         HK9f0cPRan+XW5/eKTm7vFVKIBEnN0oVk12W2hkugIBvU4Hz/K7SlSBiPzka6wQnoyA3
         QX2Q==
X-Gm-Message-State: AOAM533PHd821FAFvl572wuF8tyx1vcOqrE5HVcHPGnmkW8xNu+mGehd
        7k9gL0SW12AwfaZ4BRtebKrrwuzpR+s7nwjI8hTz1zhc7gA=
X-Google-Smtp-Source: ABdhPJw7lP7wSrsUc5HetgA6RDbZr9vE4AIMMOFRvNvl7AzANPNpUNG5VVFi7t9tp4WRAbgO3DF0QawNqwIPRhkgqI4=
X-Received: by 2002:a05:6902:1001:: with SMTP id w1mr18108109ybt.176.1614992654002;
 Fri, 05 Mar 2021 17:04:14 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <58f4fe54-a462-b256-df60-17b1084235f6@toxicpanda.com> <CAEg-Je-_r3_AsLHa_HDDOUwVs+Jtty5roFvEyF4K-T2D7oEayA@mail.gmail.com>
 <58246f4c-4e26-c89c-a589-376cfe23d783@toxicpanda.com> <CAEg-Je-yPqueyW3JqSWrAE_9ckc1KTyaNoFwjbozNLrvb7_tEg@mail.gmail.com>
 <a9561d44-24a3-fa87-e292-98feb4846ab9@toxicpanda.com> <CAEg-Je8o2GiAH2wC9DXiMdMSCFnAjeV6UH-qaobk_0qYLNsPsQ@mail.gmail.com>
 <95e8db7d-eff3-e694-c315-f7984b5f49e0@toxicpanda.com> <CAEg-Je_s6EAHwj2LWYRLdMHF_kRuY_JQoLfWMqDgcROZatnP+g@mail.gmail.com>
 <ef2ec021-52d3-2da4-f59a-fa7016c95d90@toxicpanda.com> <CAEg-Je_HKgGLnF6F_3dXd+9NFa9cTceWWtTUhSSjNovsze_wQg@mail.gmail.com>
 <d2c7b501-f2f1-c471-4b1b-38e6731682ba@toxicpanda.com> <CAEg-Je_TN04fnE2Bg46Nysm2_fG7dcni-7c6wbfZQZqXhDhbnA@mail.gmail.com>
 <e5b5409b-0e34-abd5-81c9-48ef59c3fa03@toxicpanda.com> <CAEg-Je-oOnnCd=Vc65yTam6-jxHr2rEr9yrzi_xv79ziys0TjA@mail.gmail.com>
 <346098b8-3d89-1497-ada3-e8317888ee61@toxicpanda.com>
In-Reply-To: <346098b8-3d89-1497-ada3-e8317888ee61@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Fri, 5 Mar 2021 20:03:37 -0500
Message-ID: <CAEg-Je9-88GOrHqqwsvAhxR_1BB-6nFLVd3r-kidCP4APLEEFw@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000075281805bcd3c75e"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--00000000000075281805bcd3c75e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 5, 2021 at 5:01 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 3/5/21 9:41 AM, Neal Gompa wrote:
> > On Fri, Mar 5, 2021 at 9:12 AM Josef Bacik <josef@toxicpanda.com> wrote=
:
> >>
> >> On 3/4/21 6:54 PM, Neal Gompa wrote:
> >>> On Thu, Mar 4, 2021 at 3:25 PM Josef Bacik <josef@toxicpanda.com> wro=
te:
> >>>>
> >>>> On 3/3/21 2:38 PM, Neal Gompa wrote:
> >>>>> On Wed, Mar 3, 2021 at 1:42 PM Josef Bacik <josef@toxicpanda.com> w=
rote:
> >>>>>>
> >>>>>> On 2/24/21 10:47 PM, Neal Gompa wrote:
> >>>>>>> On Wed, Feb 24, 2021 at 10:44 AM Josef Bacik <josef@toxicpanda.co=
m> wrote:
> >>>>>>>>
> >>>>>>>> On 2/24/21 9:23 AM, Neal Gompa wrote:
> >>>>>>>>> On Tue, Feb 23, 2021 at 10:05 AM Josef Bacik <josef@toxicpanda.=
com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2/22/21 11:03 PM, Neal Gompa wrote:
> >>>>>>>>>>> On Mon, Feb 22, 2021 at 2:34 PM Josef Bacik <josef@toxicpanda=
.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2/21/21 1:27 PM, Neal Gompa wrote:
> >>>>>>>>>>>>> On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef@toxicpa=
nda.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 2/17/21 11:29 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@toxicp=
anda.com> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On 2/17/21 9:50 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxi=
cpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@to=
xicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@=
toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <jos=
ef@toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>> Hey all,
> >>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>> So one of my main computers recently had a disk=
 controller failure
> >>>>>>>>>>>>>>>>>>>>>>>>> that caused my machine to freeze. After rebooti=
ng, Btrfs refuses to
> >>>>>>>>>>>>>>>>>>>>>>>>> mount. I tried to do a mount and the following =
errors show up in the
> >>>>>>>>>>>>>>>>>>>>>>>>> journal:
> >>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS i=
nfo (device sda3): disk space caching is enabled
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS i=
nfo (device sda3): has skinny extents
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS c=
ritical (device sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15=
 ino=3D203657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS e=
rror (device sda3): block=3D796082176 read time tree block corruption detec=
ted
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS c=
ritical (device sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15=
 ino=3D203657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS e=
rror (device sda3): block=3D796082176 read time tree block corruption detec=
ted
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS w=
arning (device sda3): couldn't read tree root
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS e=
rror (device sda3): open_ctree failed
> >>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>> I've tried to do -o recovery,ro mount and get t=
he same issue. I can't
> >>>>>>>>>>>>>>>>>>>>>>>>> seem to find any reasonably good information on=
 how to do recovery in
> >>>>>>>>>>>>>>>>>>>>>>>>> this scenario, even to just recover enough to c=
opy data off.
> >>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>> I'm on Fedora 33, the system was on Linux kerne=
l version 5.9.16 and
> >>>>>>>>>>>>>>>>>>>>>>>>> the Fedora 33 live ISO I'm using has Linux kern=
el version 5.10.14. I'm
> >>>>>>>>>>>>>>>>>>>>>>>>> using btrfs-progs v5.10.
> >>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>> Can anyone help?
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> Can you try
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> That should fix the inode generation thing so it=
's sane, and then the tree
> >>>>>>>>>>>>>>>>>>>>>>>> checker will allow the fs to be read, hopefully.=
  If not we can work out some
> >>>>>>>>>>>>>>>>>>>>>>>> other magic.  Thanks,
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> Josef
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>> I got the same error as I did with btrfs-check --=
readonly...
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> Oh lovely, what does btrfs check --readonly --back=
up do?
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> No dice...
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> # btrfs check --readonly --backup /dev/sda3
> >>>>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 8=
88893 found 888895
> >>>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 8=
88893 found 888895
> >>>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 8=
88893 found 888895
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Hey look the block we're looking for, I wrote you so=
me magic, just pull
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> https://github.com/josefbacik/btrfs-progs/tree/for-n=
eal
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> build, and then run
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> This will force us to point at the old root with (ho=
pefully) the right bytenr
> >>>>>>>>>>>>>>>>>>>> and gen, and then hopefully you'll be able to recove=
r from there.  This is kind
> >>>>>>>>>>>>>>>>>>>> of saucy, so yolo, but I can undo it if it makes thi=
ngs worse.  Thanks,
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> # btrfs check --readonly /dev/sda3
> >>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>>>>>>>> # btrfs check --clear-space-cache v1 /dev/sda3
> >>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> It's better, but still no dice... :(
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Hmm it's not telling us what's wrong with the extent t=
ree, which is annoying.
> >>>>>>>>>>>>>>>>>> Does mount -o rescue=3Dall,ro work now that the root t=
ree is normal?  Thanks,
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Nope, I see this in the journal:
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (dev=
ice sda3): enabling all of the rescue options
> >>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (dev=
ice sda3): ignoring data csums
> >>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (dev=
ice sda3): ignoring bad roots
> >>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (dev=
ice sda3): disabling log replay at mount time
> >>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (dev=
ice sda3): disk space caching is enabled
> >>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (dev=
ice sda3): has skinny extents
> >>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (de=
vice sda3): tree level mismatch detected, bytenr=3D791281664 level expected=
=3D1 has=3D2
> >>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (de=
vice sda3): tree level mismatch detected, bytenr=3D791281664 level expected=
=3D1 has=3D2
> >>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (=
device sda3): couldn't read tree root
> >>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (de=
vice sda3): open_ctree failed
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Ok git pull for-neal, rebuild, then run
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895 2
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> I thought of this yesterday but in my head was like "naa=
ahhhh, whats the chances
> >>>>>>>>>>>>>>>> that the level doesn't match??".  Thanks,
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Tried rescue mount again after running that and got a sta=
ck trace in
> >>>>>>>>>>>>>>> the kernel, detailed in the following attached log.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Huh I wonder how I didn't hit this when testing, I must ha=
ve only tested with
> >>>>>>>>>>>>>> zero'ing the extent root and the csum root.  You're going =
to have to build a
> >>>>>>>>>>>>>> kernel with a fix for this
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> https://paste.centos.org/view/7b48aaea
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> and see if that gets you further.  Thanks,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I built a kernel build as an RPM with your patch[1] and tri=
ed it.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb=
3 /mnt
> >>>>>>>>>>>>> Killed
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The log from the journal is attached.
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Ahh crud my bad, this should do it
> >>>>>>>>>>>>
> >>>>>>>>>>>> https://paste.centos.org/view/ac2e61ef
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Patch doesn't apply (note it is patch 667 below):
> >>>>>>>>>>
> >>>>>>>>>> Ah sorry, should have just sent you an iterative patch.  You c=
an take the above
> >>>>>>>>>> patch and just delete the hunk from volumes.c as you already h=
ave that applied
> >>>>>>>>>> and then it'll work.  Thanks,
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Failed with a weird error...?
> >>>>>>>>>
> >>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sda3 /m=
nt
> >>>>>>>>> mount: /mnt: mount(2) system call failed: No such file or direc=
tory.
> >>>>>>>>>
> >>>>>>>>> Journal log with traceback attached.
> >>>>>>>>
> >>>>>>>> Last one maybe?
> >>>>>>>>
> >>>>>>>> https://paste.centos.org/view/80edd6fd
> >>>>>>>>
> >>>>>>>
> >>>>>>> Similar weird failure:
> >>>>>>>
> >>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 /mnt
> >>>>>>> mount: /mnt: mount(2) system call failed: No such file or directo=
ry.
> >>>>>>>
> >>>>>>> No crash in the journal this time, though:
> >>>>>>>
> >>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): enablin=
g all of the rescue options
> >>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignorin=
g data csums
> >>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignorin=
g bad roots
> >>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disabli=
ng log replay at mount time
> >>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disk sp=
ace caching is enabled
> >>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): has ski=
nny extents
> >>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS warning (device sdb3): fail=
ed to read fs tree: -2
> >>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS error (device sdb3): open_c=
tree failed
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> Sorry Neal, you replied when I was in the middle of something and =
promptly
> >>>>>> forgot about it.  I figured the fs root was fine, can you do the f=
ollowing so I
> >>>>>> can figure out from the error messages what might be wrong
> >>>>>>
> >>>>>> btrfs check --readonly
> >>>>>> btrfs restore -D
> >>>>>> btrfs restore -l
> >>>>>>
> >>>>>
> >>>>> It didn't work.. Here's the output:
> >>>>>
> >>>>> [root@fedora ~]# btrfs check --readonly /dev/sdb3
> >>>>> Opening filesystem to check...
> >>>>> ERROR: could not setup extent tree
> >>>>> ERROR: cannot open file system
> >>>>> [root@fedora ~]# btrfs restore -D /dev/sdb3 /mnt
> >>>>> WARNING: could not setup extent tree, skipping it
> >>>>> Couldn't setup device tree
> >>>>> Could not open root, trying backup super
> >>>>> parent transid verify failed on 796082176 wanted 888894 found 88889=
6
> >>>>> parent transid verify failed on 796082176 wanted 888894 found 88889=
6
> >>>>> parent transid verify failed on 796082176 wanted 888894 found 88889=
6
> >>>>> Ignoring transid failure
> >>>>> WARNING: could not setup extent tree, skipping it
> >>>>> Couldn't setup device tree
> >>>>> Could not open root, trying backup super
> >>>>> ERROR: superblock bytenr 274877906944 is larger than device size 26=
3132807168
> >>>>> Could not open root, trying backup super
> >>>>> [root@fedora ~]# btrfs restore -l /dev/sdb3 /mnt
> >>>>> WARNING: could not setup extent tree, skipping it
> >>>>> Couldn't setup device tree
> >>>>> Could not open root, trying backup super
> >>>>> parent transid verify failed on 796082176 wanted 888894 found 88889=
6
> >>>>> parent transid verify failed on 796082176 wanted 888894 found 88889=
6
> >>>>> parent transid verify failed on 796082176 wanted 888894 found 88889=
6
> >>>>> Ignoring transid failure
> >>>>> WARNING: could not setup extent tree, skipping it
> >>>>> Couldn't setup device tree
> >>>>> Could not open root, trying backup super
> >>>>> ERROR: superblock bytenr 274877906944 is larger than device size 26=
3132807168
> >>>>> Could not open root, trying backup super
> >>>>>
> >>>>>
> >>>>
> >>>> Hmm OK I think we want the neal magic for this one too, but before w=
e go doing
> >>>> that can I get a
> >>>>
> >>>> btrfs inspect-internal -f /dev/whatever
> >>>>
> >>>> so I can make sure I'm not just blindly clobbering something.  Thank=
s,
> >>>>
> >>>
> >>> Doesn't work, did you mean some other command?
> >>>
> >>> [root@fedora ~]#  btrfs inspect-internal -f /dev/sdb3
> >>> btrfs inspect-internal: unknown token '-f'
> >>
> >> Sigh, sorry, btrfs inspect-internal dump-super -f /dev/sdb3
> >>
> >
>
> Ok I've pushed to the for-neal branch in my btrfs-progs, can you pull and=
 make
> and then run
>
> ./btrfs-print-block /dev/sdb3 791281664
>
> and capture everything it prints out?  Thanks,
>

Here's the output from the command.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

--00000000000075281805bcd3c75e
Content-Type: text/x-log; charset="US-ASCII"; name="output-print-block.log"
Content-Disposition: attachment; filename="output-print-block.log"
Content-Transfer-Encoding: base64
Content-ID: <f_klx0wgdp0>
X-Attachment-Id: f_klx0wgdp0

bGVhZiA3ODI4OTMwNTYgaXRlbXMgMzYgZnJlZSBzcGFjZSA3MTQgZ2VuZXJhdGlvbiA4ODg4OTEg
b3duZXIgNDAxCmxlYWYgNzgyODkzMDU2IGZsYWdzIDB4MShXUklUVEVOKSBiYWNrcmVmIHJldmlz
aW9uIDEKZnMgdXVpZCBmOTkzZmZhNC04ODAxLTRkNTctYTA4Ny0xYzM1ZmQ2ZWNlMDAKY2h1bmsg
dXVpZCA3ZWZmMTU0Yi0zNTUwLTQyN2UtOThjYi03MzAwYjNkNjlhYjMKCWl0ZW0gMCBrZXkgKDIw
Mzc0OSBFWFRFTlRfREFUQSAwKSBpdGVtb2ZmIDE0ODQ3IGl0ZW1zaXplIDE0MzYKCQlnZW5lcmF0
aW9uIDc1ODAxNyB0eXBlIDAgKGlubGluZSkKCQlpbmxpbmUgZXh0ZW50IGRhdGEgc2l6ZSAxNDE1
IHJhbV9ieXRlcyAxNDE1IGNvbXByZXNzaW9uIDAgKG5vbmUpCglpdGVtIDEga2V5ICgyMDM3NTAg
SU5PREVfSVRFTSAwKSBpdGVtb2ZmIDE0Njg3IGl0ZW1zaXplIDE2MAoJCWdlbmVyYXRpb24gNzU4
MDE3IHRyYW5zaWQgNzU4MDE3IHNpemUgMTQxNyBuYnl0ZXMgMTQxNwoJCWJsb2NrIGdyb3VwIDAg
bW9kZSAxMDA2NDQgbGlua3MgMyB1aWQgMCBnaWQgMCByZGV2IDAKCQlzZXF1ZW5jZSAyNSBmbGFn
cyAweDAobm9uZSkKCQlhdGltZSAxNjA3NDM5NjYwLjAgKDIwMjAtMTItMDggMTA6MDE6MDApCgkJ
Y3RpbWUgMTYwOTU1NTIwMy44MDk3ODM0MCAoMjAyMS0wMS0wMSAyMTo0MDowMykKCQltdGltZSAx
NjA3NDM5NjYwLjAgKDIwMjAtMTItMDggMTA6MDE6MDApCgkJb3RpbWUgMTYwOTU1NTIwMy44MDk3
ODM0MCAoMjAyMS0wMS0wMSAyMTo0MDowMykKCWl0ZW0gMiBrZXkgKDIwMzc1MCBJTk9ERV9SRUYg
MzU3NjcpIGl0ZW1vZmYgMTQ1NzkgaXRlbXNpemUgMTA4CgkJaW5kZXggNDM5IG5hbWVsZW4gMjgg
bmFtZTogZ2IxODAzMC5jcHl0aG9uLTM5Lm9wdC0xLnB5YwoJCWluZGV4IDQ0MSBuYW1lbGVuIDI4
IG5hbWU6IGdiMTgwMzAuY3B5dGhvbi0zOS5vcHQtMi5weWMKCQlpbmRleCA0NDMgbmFtZWxlbiAy
MiBuYW1lOiBnYjE4MDMwLmNweXRob24tMzkucHljCglpdGVtIDMga2V5ICgyMDM3NTAgWEFUVFJf
SVRFTSAzODE3NzUzNjY3KSBpdGVtb2ZmIDE0NTA2IGl0ZW1zaXplIDczCgkJbG9jYXRpb24ga2V5
ICgwIFVOS05PV04uMCAwKSB0eXBlIFhBVFRSCgkJdHJhbnNpZCA3NTgwMTcgZGF0YV9sZW4gMjcg
bmFtZV9sZW4gMTYKCQluYW1lOiBzZWN1cml0eS5zZWxpbnV4CgkJZGF0YSBzeXN0ZW1fdTpvYmpl
Y3RfcjpsaWJfdDpzMAoJaXRlbSA0IGtleSAoMjAzNzUwIEVYVEVOVF9EQVRBIDApIGl0ZW1vZmYg
MTMwNjggaXRlbXNpemUgMTQzOAoJCWdlbmVyYXRpb24gNzU4MDE3IHR5cGUgMCAoaW5saW5lKQoJ
CWlubGluZSBleHRlbnQgZGF0YSBzaXplIDE0MTcgcmFtX2J5dGVzIDE0MTcgY29tcHJlc3Npb24g
MCAobm9uZSkKCWl0ZW0gNSBrZXkgKDIwMzc1MSBJTk9ERV9JVEVNIDApIGl0ZW1vZmYgMTI5MDgg
aXRlbXNpemUgMTYwCgkJZ2VuZXJhdGlvbiA3NTgwMTcgdHJhbnNpZCA3NTgwMTcgc2l6ZSAxNDE1
IG5ieXRlcyAxNDE1CgkJYmxvY2sgZ3JvdXAgMCBtb2RlIDEwMDY0NCBsaW5rcyAzIHVpZCAwIGdp
ZCAwIHJkZXYgMAoJCXNlcXVlbmNlIDEzIGZsYWdzIDB4MChub25lKQoJCWF0aW1lIDE2MDc0Mzk2
NjAuMCAoMjAyMC0xMi0wOCAxMDowMTowMCkKCQljdGltZSAxNjA5NTU1MjAzLjgyOTc4MzcxICgy
MDIxLTAxLTAxIDIxOjQwOjAzKQoJCW10aW1lIDE2MDc0Mzk2NjAuMCAoMjAyMC0xMi0wOCAxMDow
MTowMCkKCQlvdGltZSAxNjA5NTU1MjAzLjgxOTc4MzU2ICgyMDIxLTAxLTAxIDIxOjQwOjAzKQoJ
aXRlbSA2IGtleSAoMjAzNzUxIElOT0RFX1JFRiAzNTc2NykgaXRlbW9mZiAxMjgwMyBpdGVtc2l6
ZSAxMDUKCQlpbmRleCA0NDUgbmFtZWxlbiAyNyBuYW1lOiBnYjIzMTIuY3B5dGhvbi0zOS5vcHQt
MS5weWMKCQlpbmRleCA0NDcgbmFtZWxlbiAyNyBuYW1lOiBnYjIzMTIuY3B5dGhvbi0zOS5vcHQt
Mi5weWMKCQlpbmRleCA0NDkgbmFtZWxlbiAyMSBuYW1lOiBnYjIzMTIuY3B5dGhvbi0zOS5weWMK
CWl0ZW0gNyBrZXkgKDIwMzc1MSBYQVRUUl9JVEVNIDM4MTc3NTM2NjcpIGl0ZW1vZmYgMTI3MzAg
aXRlbXNpemUgNzMKCQlsb2NhdGlvbiBrZXkgKDAgVU5LTk9XTi4wIDApIHR5cGUgWEFUVFIKCQl0
cmFuc2lkIDc1ODAxNyBkYXRhX2xlbiAyNyBuYW1lX2xlbiAxNgoJCW5hbWU6IHNlY3VyaXR5LnNl
bGludXgKCQlkYXRhIHN5c3RlbV91Om9iamVjdF9yOmxpYl90OnMwCglpdGVtIDgga2V5ICgyMDM3
NTEgRVhURU5UX0RBVEEgMCkgaXRlbW9mZiAxMTI5NCBpdGVtc2l6ZSAxNDM2CgkJZ2VuZXJhdGlv
biA3NTgwMTcgdHlwZSAwIChpbmxpbmUpCgkJaW5saW5lIGV4dGVudCBkYXRhIHNpemUgMTQxNSBy
YW1fYnl0ZXMgMTQxNSBjb21wcmVzc2lvbiAwIChub25lKQoJaXRlbSA5IGtleSAoMjAzNzUyIElO
T0RFX0lURU0gMCkgaXRlbW9mZiAxMTEzNCBpdGVtc2l6ZSAxNjAKCQlnZW5lcmF0aW9uIDc1ODAx
NyB0cmFuc2lkIDc1ODAxNyBzaXplIDE0MDkgbmJ5dGVzIDE0MDkKCQlibG9jayBncm91cCAwIG1v
ZGUgMTAwNjQ0IGxpbmtzIDMgdWlkIDAgZ2lkIDAgcmRldiAwCgkJc2VxdWVuY2UgMTMgZmxhZ3Mg
MHgwKG5vbmUpCgkJYXRpbWUgMTYwNzQzOTY2MC4wICgyMDIwLTEyLTA4IDEwOjAxOjAwKQoJCWN0
aW1lIDE2MDk1NTUyMDMuODI5NzgzNzEgKDIwMjEtMDEtMDEgMjE6NDA6MDMpCgkJbXRpbWUgMTYw
NzQzOTY2MC4wICgyMDIwLTEyLTA4IDEwOjAxOjAwKQoJCW90aW1lIDE2MDk1NTUyMDMuODI5Nzgz
NzEgKDIwMjEtMDEtMDEgMjE6NDA6MDMpCglpdGVtIDEwIGtleSAoMjAzNzUyIElOT0RFX1JFRiAz
NTc2NykgaXRlbW9mZiAxMTAzOCBpdGVtc2l6ZSA5NgoJCWluZGV4IDQ1MSBuYW1lbGVuIDI0IG5h
bWU6IGdiay5jcHl0aG9uLTM5Lm9wdC0xLnB5YwoJCWluZGV4IDQ1MyBuYW1lbGVuIDI0IG5hbWU6
IGdiay5jcHl0aG9uLTM5Lm9wdC0yLnB5YwoJCWluZGV4IDQ1NSBuYW1lbGVuIDE4IG5hbWU6IGdi
ay5jcHl0aG9uLTM5LnB5YwoJaXRlbSAxMSBrZXkgKDIwMzc1MiBYQVRUUl9JVEVNIDM4MTc3NTM2
NjcpIGl0ZW1vZmYgMTA5NjUgaXRlbXNpemUgNzMKCQlsb2NhdGlvbiBrZXkgKDAgVU5LTk9XTi4w
IDApIHR5cGUgWEFUVFIKCQl0cmFuc2lkIDc1ODAxNyBkYXRhX2xlbiAyNyBuYW1lX2xlbiAxNgoJ
CW5hbWU6IHNlY3VyaXR5LnNlbGludXgKCQlkYXRhIHN5c3RlbV91Om9iamVjdF9yOmxpYl90OnMw
CglpdGVtIDEyIGtleSAoMjAzNzUyIEVYVEVOVF9EQVRBIDApIGl0ZW1vZmYgOTUzNSBpdGVtc2l6
ZSAxNDMwCgkJZ2VuZXJhdGlvbiA3NTgwMTcgdHlwZSAwIChpbmxpbmUpCgkJaW5saW5lIGV4dGVu
dCBkYXRhIHNpemUgMTQwOSByYW1fYnl0ZXMgMTQwOSBjb21wcmVzc2lvbiAwIChub25lKQoJaXRl
bSAxMyBrZXkgKDIwMzc1MyBJTk9ERV9JVEVNIDApIGl0ZW1vZmYgOTM3NSBpdGVtc2l6ZSAxNjAK
CQlnZW5lcmF0aW9uIDc1ODAxNyB0cmFuc2lkIDc1ODAxNyBzaXplIDE0MDcgbmJ5dGVzIDE0MDcK
CQlibG9jayBncm91cCAwIG1vZGUgMTAwNjQ0IGxpbmtzIDMgdWlkIDAgZ2lkIDAgcmRldiAwCgkJ
c2VxdWVuY2UgMTMgZmxhZ3MgMHgwKG5vbmUpCgkJYXRpbWUgMTYwNzQzOTY2MC4wICgyMDIwLTEy
LTA4IDEwOjAxOjAwKQoJCWN0aW1lIDE2MDk1NTUyMDMuODQ5Nzg0MDEgKDIwMjEtMDEtMDEgMjE6
NDA6MDMpCgkJbXRpbWUgMTYwNzQzOTY2MC4wICgyMDIwLTEyLTA4IDEwOjAxOjAwKQoJCW90aW1l
IDE2MDk1NTUyMDMuODI5NzgzNzEgKDIwMjEtMDEtMDEgMjE6NDA6MDMpCglpdGVtIDE0IGtleSAo
MjAzNzUzIElOT0RFX1JFRiAzNTc2NykgaXRlbW9mZiA5MjgyIGl0ZW1zaXplIDkzCgkJaW5kZXgg
NDU3IG5hbWVsZW4gMjMgbmFtZTogaHouY3B5dGhvbi0zOS5vcHQtMS5weWMKCQlpbmRleCA0NTkg
bmFtZWxlbiAyMyBuYW1lOiBoei5jcHl0aG9uLTM5Lm9wdC0yLnB5YwoJCWluZGV4IDQ2MSBuYW1l
bGVuIDE3IG5hbWU6IGh6LmNweXRob24tMzkucHljCglpdGVtIDE1IGtleSAoMjAzNzUzIFhBVFRS
X0lURU0gMzgxNzc1MzY2NykgaXRlbW9mZiA5MjA5IGl0ZW1zaXplIDczCgkJbG9jYXRpb24ga2V5
ICgwIFVOS05PV04uMCAwKSB0eXBlIFhBVFRSCgkJdHJhbnNpZCA3NTgwMTcgZGF0YV9sZW4gMjcg
bmFtZV9sZW4gMTYKCQluYW1lOiBzZWN1cml0eS5zZWxpbnV4CgkJZGF0YSBzeXN0ZW1fdTpvYmpl
Y3RfcjpsaWJfdDpzMAoJaXRlbSAxNiBrZXkgKDIwMzc1MyBFWFRFTlRfREFUQSAwKSBpdGVtb2Zm
IDc3ODEgaXRlbXNpemUgMTQyOAoJCWdlbmVyYXRpb24gNzU4MDE3IHR5cGUgMCAoaW5saW5lKQoJ
CWlubGluZSBleHRlbnQgZGF0YSBzaXplIDE0MDcgcmFtX2J5dGVzIDE0MDcgY29tcHJlc3Npb24g
MCAobm9uZSkKCWl0ZW0gMTcga2V5ICgyMDM3NTQgSU5PREVfSVRFTSAwKSBpdGVtb2ZmIDc2MjEg
aXRlbXNpemUgMTYwCgkJZ2VuZXJhdGlvbiA3NTgwMTcgdHJhbnNpZCA4ODg4OTEgc2l6ZSA1NTk5
IG5ieXRlcyA4MTkyCgkJYmxvY2sgZ3JvdXAgMCBtb2RlIDEwMDY0NCBsaW5rcyAzIHVpZCAwIGdp
ZCAwIHJkZXYgMAoJCXNlcXVlbmNlIDEzIGZsYWdzIDB4MChub25lKQoJCWF0aW1lIDE2MTMzMjA1
NzAuODYwODE4MDk4ICgyMDIxLTAyLTE0IDExOjM2OjEwKQoJCWN0aW1lIDE2MDk1NTUyMDMuODU5
Nzg0MTcgKDIwMjEtMDEtMDEgMjE6NDA6MDMpCgkJbXRpbWUgMTYwNzQzOTY2MC4wICgyMDIwLTEy
LTA4IDEwOjAxOjAwKQoJCW90aW1lIDE2MDk1NTUyMDMuODQ5Nzg0MDEgKDIwMjEtMDEtMDEgMjE6
NDA6MDMpCglpdGVtIDE4IGtleSAoMjAzNzU0IElOT0RFX1JFRiAzNTc2NykgaXRlbW9mZiA3NTIy
IGl0ZW1zaXplIDk5CgkJaW5kZXggNDYzIG5hbWVsZW4gMjUgbmFtZTogaWRuYS5jcHl0aG9uLTM5
Lm9wdC0xLnB5YwoJCWluZGV4IDQ2NSBuYW1lbGVuIDI1IG5hbWU6IGlkbmEuY3B5dGhvbi0zOS5v
cHQtMi5weWMKCQlpbmRleCA0NjcgbmFtZWxlbiAxOSBuYW1lOiBpZG5hLmNweXRob24tMzkucHlj
CglpdGVtIDE5IGtleSAoMjAzNzU0IFhBVFRSX0lURU0gMzgxNzc1MzY2NykgaXRlbW9mZiA3NDQ5
IGl0ZW1zaXplIDczCgkJbG9jYXRpb24ga2V5ICgwIFVOS05PV04uMCAwKSB0eXBlIFhBVFRSCgkJ
dHJhbnNpZCA3NTgwMTcgZGF0YV9sZW4gMjcgbmFtZV9sZW4gMTYKCQluYW1lOiBzZWN1cml0eS5z
ZWxpbnV4CgkJZGF0YSBzeXN0ZW1fdTpvYmplY3RfcjpsaWJfdDpzMAoJaXRlbSAyMCBrZXkgKDIw
Mzc1NCBFWFRFTlRfREFUQSAwKSBpdGVtb2ZmIDczOTYgaXRlbXNpemUgNTMKCQlnZW5lcmF0aW9u
IDc1ODAxNyB0eXBlIDEgKHJlZ3VsYXIpCgkJZXh0ZW50IGRhdGEgZGlzayBieXRlIDU3OTM1MjE2
NjQgbnIgODE5MgoJCWV4dGVudCBkYXRhIG9mZnNldCAwIG5yIDgxOTIgcmFtIDgxOTIKCQlleHRl
bnQgY29tcHJlc3Npb24gMCAobm9uZSkKCWl0ZW0gMjEga2V5ICgyMDM3NTUgSU5PREVfSVRFTSAw
KSBpdGVtb2ZmIDcyMzYgaXRlbXNpemUgMTYwCgkJZ2VuZXJhdGlvbiA3NTgwMTcgdHJhbnNpZCA3
NTgwMTcgc2l6ZSAxNDI4IG5ieXRlcyAxNDI4CgkJYmxvY2sgZ3JvdXAgMCBtb2RlIDEwMDY0NCBs
aW5rcyAzIHVpZCAwIGdpZCAwIHJkZXYgMAoJCXNlcXVlbmNlIDEzIGZsYWdzIDB4MChub25lKQoJ
CWF0aW1lIDE2MDc0Mzk2NjAuMCAoMjAyMC0xMi0wOCAxMDowMTowMCkKCQljdGltZSAxNjA5NTU1
MjAzLjg2OTc4NDMyICgyMDIxLTAxLTAxIDIxOjQwOjAzKQoJCW10aW1lIDE2MDc0Mzk2NjAuMCAo
MjAyMC0xMi0wOCAxMDowMTowMCkKCQlvdGltZSAxNjA5NTU1MjAzLjg1OTc4NDE3ICgyMDIxLTAx
LTAxIDIxOjQwOjAzKQoJaXRlbSAyMiBrZXkgKDIwMzc1NSBJTk9ERV9SRUYgMzU3NjcpIGl0ZW1v
ZmYgNzExOSBpdGVtc2l6ZSAxMTcKCQlpbmRleCA0NjkgbmFtZWxlbiAzMSBuYW1lOiBpc28yMDIy
X2pwLmNweXRob24tMzkub3B0LTEucHljCgkJaW5kZXggNDcxIG5hbWVsZW4gMzEgbmFtZTogaXNv
MjAyMl9qcC5jcHl0aG9uLTM5Lm9wdC0yLnB5YwoJCWluZGV4IDQ3MyBuYW1lbGVuIDI1IG5hbWU6
IGlzbzIwMjJfanAuY3B5dGhvbi0zOS5weWMKCWl0ZW0gMjMga2V5ICgyMDM3NTUgWEFUVFJfSVRF
TSAzODE3NzUzNjY3KSBpdGVtb2ZmIDcwNDYgaXRlbXNpemUgNzMKCQlsb2NhdGlvbiBrZXkgKDAg
VU5LTk9XTi4wIDApIHR5cGUgWEFUVFIKCQl0cmFuc2lkIDc1ODAxNyBkYXRhX2xlbiAyNyBuYW1l
X2xlbiAxNgoJCW5hbWU6IHNlY3VyaXR5LnNlbGludXgKCQlkYXRhIHN5c3RlbV91Om9iamVjdF9y
OmxpYl90OnMwCglpdGVtIDI0IGtleSAoMjAzNzU1IEVYVEVOVF9EQVRBIDApIGl0ZW1vZmYgNTU5
NyBpdGVtc2l6ZSAxNDQ5CgkJZ2VuZXJhdGlvbiA3NTgwMTcgdHlwZSAwIChpbmxpbmUpCgkJaW5s
aW5lIGV4dGVudCBkYXRhIHNpemUgMTQyOCByYW1fYnl0ZXMgMTQyOCBjb21wcmVzc2lvbiAwIChu
b25lKQoJaXRlbSAyNSBrZXkgKDIwMzc1NiBJTk9ERV9JVEVNIDApIGl0ZW1vZmYgNTQzNyBpdGVt
c2l6ZSAxNjAKCQlnZW5lcmF0aW9uIDc1ODAxNyB0cmFuc2lkIDc1ODAxNyBzaXplIDE0MzIgbmJ5
dGVzIDE0MzIKCQlibG9jayBncm91cCAwIG1vZGUgMTAwNjQ0IGxpbmtzIDMgdWlkIDAgZ2lkIDAg
cmRldiAwCgkJc2VxdWVuY2UgMTMgZmxhZ3MgMHgwKG5vbmUpCgkJYXRpbWUgMTYwNzQzOTY2MC4w
ICgyMDIwLTEyLTA4IDEwOjAxOjAwKQoJCWN0aW1lIDE2MDk1NTUyMDMuODc5Nzg0NDcgKDIwMjEt
MDEtMDEgMjE6NDA6MDMpCgkJbXRpbWUgMTYwNzQzOTY2MC4wICgyMDIwLTEyLTA4IDEwOjAxOjAw
KQoJCW90aW1lIDE2MDk1NTUyMDMuODY5Nzg0MzIgKDIwMjEtMDEtMDEgMjE6NDA6MDMpCglpdGVt
IDI2IGtleSAoMjAzNzU2IElOT0RFX1JFRiAzNTc2NykgaXRlbW9mZiA1MzE0IGl0ZW1zaXplIDEy
MwoJCWluZGV4IDQ3NSBuYW1lbGVuIDMzIG5hbWU6IGlzbzIwMjJfanBfMS5jcHl0aG9uLTM5Lm9w
dC0xLnB5YwoJCWluZGV4IDQ3NyBuYW1lbGVuIDMzIG5hbWU6IGlzbzIwMjJfanBfMS5jcHl0aG9u
LTM5Lm9wdC0yLnB5YwoJCWluZGV4IDQ3OSBuYW1lbGVuIDI3IG5hbWU6IGlzbzIwMjJfanBfMS5j
cHl0aG9uLTM5LnB5YwoJaXRlbSAyNyBrZXkgKDIwMzc1NiBYQVRUUl9JVEVNIDM4MTc3NTM2Njcp
IGl0ZW1vZmYgNTI0MSBpdGVtc2l6ZSA3MwoJCWxvY2F0aW9uIGtleSAoMCBVTktOT1dOLjAgMCkg
dHlwZSBYQVRUUgoJCXRyYW5zaWQgNzU4MDE3IGRhdGFfbGVuIDI3IG5hbWVfbGVuIDE2CgkJbmFt
ZTogc2VjdXJpdHkuc2VsaW51eAoJCWRhdGEgc3lzdGVtX3U6b2JqZWN0X3I6bGliX3Q6czAKCWl0
ZW0gMjgga2V5ICgyMDM3NTYgRVhURU5UX0RBVEEgMCkgaXRlbW9mZiAzNzg4IGl0ZW1zaXplIDE0
NTMKCQlnZW5lcmF0aW9uIDc1ODAxNyB0eXBlIDAgKGlubGluZSkKCQlpbmxpbmUgZXh0ZW50IGRh
dGEgc2l6ZSAxNDMyIHJhbV9ieXRlcyAxNDMyIGNvbXByZXNzaW9uIDAgKG5vbmUpCglpdGVtIDI5
IGtleSAoMjAzNzU3IElOT0RFX0lURU0gMCkgaXRlbW9mZiAzNjI4IGl0ZW1zaXplIDE2MAoJCWdl
bmVyYXRpb24gNzU4MDE3IHRyYW5zaWQgNzU4MDE3IHNpemUgMTQzMiBuYnl0ZXMgMTQzMgoJCWJs
b2NrIGdyb3VwIDAgbW9kZSAxMDA2NDQgbGlua3MgMyB1aWQgMCBnaWQgMCByZGV2IDAKCQlzZXF1
ZW5jZSAxMyBmbGFncyAweDAobm9uZSkKCQlhdGltZSAxNjA3NDM5NjYwLjAgKDIwMjAtMTItMDgg
MTA6MDE6MDApCgkJY3RpbWUgMTYwOTU1NTIwMy44ODk3ODQ2MyAoMjAyMS0wMS0wMSAyMTo0MDow
MykKCQltdGltZSAxNjA3NDM5NjYwLjAgKDIwMjAtMTItMDggMTA6MDE6MDApCgkJb3RpbWUgMTYw
OTU1NTIwMy44Nzk3ODQ0NyAoMjAyMS0wMS0wMSAyMTo0MDowMykKCWl0ZW0gMzAga2V5ICgyMDM3
NTcgSU5PREVfUkVGIDM1NzY3KSBpdGVtb2ZmIDM1MDUgaXRlbXNpemUgMTIzCgkJaW5kZXggNDgx
IG5hbWVsZW4gMzMgbmFtZTogaXNvMjAyMl9qcF8yLmNweXRob24tMzkub3B0LTEucHljCgkJaW5k
ZXggNDgzIG5hbWVsZW4gMzMgbmFtZTogaXNvMjAyMl9qcF8yLmNweXRob24tMzkub3B0LTIucHlj
CgkJaW5kZXggNDg1IG5hbWVsZW4gMjcgbmFtZTogaXNvMjAyMl9qcF8yLmNweXRob24tMzkucHlj
CglpdGVtIDMxIGtleSAoMjAzNzU3IFhBVFRSX0lURU0gMzgxNzc1MzY2NykgaXRlbW9mZiAzNDMy
IGl0ZW1zaXplIDczCgkJbG9jYXRpb24ga2V5ICgwIFVOS05PV04uMCAwKSB0eXBlIFhBVFRSCgkJ
dHJhbnNpZCA3NTgwMTcgZGF0YV9sZW4gMjcgbmFtZV9sZW4gMTYKCQluYW1lOiBzZWN1cml0eS5z
ZWxpbnV4CgkJZGF0YSBzeXN0ZW1fdTpvYmplY3RfcjpsaWJfdDpzMAoJaXRlbSAzMiBrZXkgKDIw
Mzc1NyBFWFRFTlRfREFUQSAwKSBpdGVtb2ZmIDE5NzkgaXRlbXNpemUgMTQ1MwoJCWdlbmVyYXRp
b24gNzU4MDE3IHR5cGUgMCAoaW5saW5lKQoJCWlubGluZSBleHRlbnQgZGF0YSBzaXplIDE0MzIg
cmFtX2J5dGVzIDE0MzIgY29tcHJlc3Npb24gMCAobm9uZSkKCWl0ZW0gMzMga2V5ICgyMDM3NTgg
SU5PREVfSVRFTSAwKSBpdGVtb2ZmIDE4MTkgaXRlbXNpemUgMTYwCgkJZ2VuZXJhdGlvbiA3NTgw
MTcgdHJhbnNpZCA3NTgwMTcgc2l6ZSAxNDM4IG5ieXRlcyAxNDM4CgkJYmxvY2sgZ3JvdXAgMCBt
b2RlIDEwMDY0NCBsaW5rcyAzIHVpZCAwIGdpZCAwIHJkZXYgMAoJCXNlcXVlbmNlIDEzIGZsYWdz
IDB4MChub25lKQoJCWF0aW1lIDE2MDc0Mzk2NjAuMCAoMjAyMC0xMi0wOCAxMDowMTowMCkKCQlj
dGltZSAxNjA5NTU1MjAzLjg4OTc4NDYzICgyMDIxLTAxLTAxIDIxOjQwOjAzKQoJCW10aW1lIDE2
MDc0Mzk2NjAuMCAoMjAyMC0xMi0wOCAxMDowMTowMCkKCQlvdGltZSAxNjA5NTU1MjAzLjg4OTc4
NDYzICgyMDIxLTAxLTAxIDIxOjQwOjAzKQoJaXRlbSAzNCBrZXkgKDIwMzc1OCBJTk9ERV9SRUYg
MzU3NjcpIGl0ZW1vZmYgMTY4NyBpdGVtc2l6ZSAxMzIKCQlpbmRleCA0ODcgbmFtZWxlbiAzNiBu
YW1lOiBpc28yMDIyX2pwXzIwMDQuY3B5dGhvbi0zOS5vcHQtMS5weWMKCQlpbmRleCA0ODkgbmFt
ZWxlbiAzNiBuYW1lOiBpc28yMDIyX2pwXzIwMDQuY3B5dGhvbi0zOS5vcHQtMi5weWMKCQlpbmRl
eCA0OTEgbmFtZWxlbiAzMCBuYW1lOiBpc28yMDIyX2pwXzIwMDQuY3B5dGhvbi0zOS5weWMKCWl0
ZW0gMzUga2V5ICgyMDM3NTggWEFUVFJfSVRFTSAzODE3NzUzNjY3KSBpdGVtb2ZmIDE2MTQgaXRl
bXNpemUgNzMKCQlsb2NhdGlvbiBrZXkgKDAgVU5LTk9XTi4wIDApIHR5cGUgWEFUVFIKCQl0cmFu
c2lkIDc1ODAxNyBkYXRhX2xlbiAyNyBuYW1lX2xlbiAxNgoJCW5hbWU6IHNlY3VyaXR5LnNlbGlu
dXgKCQlkYXRhIHN5c3RlbV91Om9iamVjdF9yOmxpYl90OnMwCg==
--00000000000075281805bcd3c75e--
