Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ED73331E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 00:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhCIXdB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 18:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCIXcl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Mar 2021 18:32:41 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08EBC06174A
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Mar 2021 15:32:40 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id p186so15840715ybg.2
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Mar 2021 15:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mZcXjQGhiaVN6RUr+L6VimD0S7svQGls1PmESrZD6Bw=;
        b=tvCWL5dV8xb1UGqadjbtnBWKBBcWWpr8qUmH7d2T2dVytazQdKXi6Z6fl7AqaScP3c
         XGmcxe0d8/Rs/mt0ROqezNhX4j55RFzFuP/5Ok7IVpqN79zUTIORRge+CP+Rrz8ysh2S
         FUlLld5u/P1IGiMiZryNx/Cdv08QYtcR8ANnBuW18Neg9+GFJEbEPAnM9YcWJ1DayWaK
         aEViG0lXChwIezXMEqESZ1oCm7a6S6ig1zi2IVVWeZz8hFX9jDwtudgGYA0jkNqe2/WH
         bVunUdL6l8lBGjZ982H6inOGJDNETzQ+GAzbzVaezf1VQz+IXWm35dHCp1QG9sDA2Khj
         oClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mZcXjQGhiaVN6RUr+L6VimD0S7svQGls1PmESrZD6Bw=;
        b=r5+lbCaQNXR3Rr+8tkXqF6FJG8aQX4idj26NutTed1ohCLUyj1oUOBwuJqktTvLwva
         4pG1cj+9+dDCQkVf2vFj/J8viq8h0i8WwZuaQt42wLm+gr1DJz8CaFbotQIqkiP+izNn
         W6gq9L2QVTHWXm4CHWjXMao888N/j9JLn/D8USAG+Sz6FPA2fFAJjgy83TgZIQw2zqtA
         pFgoDUfd9gQlOY9yEPOM3DUYu+vk907PX5DZDtFWah7w8rkm2gqvPwIkblYuCBUPA4FG
         aFDuBmFfN+oYthWGnPxO1HnKEifytwYwi1zC0FIS6YlHeTfpCkye1RRyWjLbNbMHZhM1
         4hqQ==
X-Gm-Message-State: AOAM531UCNHVxIkBXOyVzxsA0zP8rwrCet6nQ/qqAM4sZoKtigR9dLaT
        2TeXf4p/iavdIpQXoEt9SCK88gPDgUKVbpidZ5o=
X-Google-Smtp-Source: ABdhPJyT+toJeWBh1b2EY4oEgv2ITLR5of+Kc+nhQJgjctbVGq+I/1b18UM+WbYRYHGEyqzwH9AkP5iXRkWv/dSNhLo=
X-Received: by 2002:a5b:847:: with SMTP id v7mr367142ybq.354.1615332754518;
 Tue, 09 Mar 2021 15:32:34 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <ef2ec021-52d3-2da4-f59a-fa7016c95d90@toxicpanda.com> <CAEg-Je_HKgGLnF6F_3dXd+9NFa9cTceWWtTUhSSjNovsze_wQg@mail.gmail.com>
 <d2c7b501-f2f1-c471-4b1b-38e6731682ba@toxicpanda.com> <CAEg-Je_TN04fnE2Bg46Nysm2_fG7dcni-7c6wbfZQZqXhDhbnA@mail.gmail.com>
 <e5b5409b-0e34-abd5-81c9-48ef59c3fa03@toxicpanda.com> <CAEg-Je-oOnnCd=Vc65yTam6-jxHr2rEr9yrzi_xv79ziys0TjA@mail.gmail.com>
 <346098b8-3d89-1497-ada3-e8317888ee61@toxicpanda.com> <CAEg-Je9-88GOrHqqwsvAhxR_1BB-6nFLVd3r-kidCP4APLEEFw@mail.gmail.com>
 <c71ba7e4-28d5-1307-c8d7-4e1bb398ef08@toxicpanda.com> <CAEg-Je9dvb5d7nh=pS=_uR5dWe1YBNJTyzzBX=H2_NY=L7DZ9Q@mail.gmail.com>
 <36af1204-bd8a-ebb6-ca21-a469780ed147@toxicpanda.com> <CAEg-Je8XM1zfrvu9m61_rrmnRftsksKdQZ_Lz_Km=0vhsfwj4A@mail.gmail.com>
 <ad9bbba6-5630-ce66-a8e3-344215d9478f@toxicpanda.com> <CAEg-Je9zDbSSbJaJaA6B1Q-Mf_2JRea=Ci3UG2kdGP1zM7+QXQ@mail.gmail.com>
 <0584bf34-a93f-6e84-cedb-8806083a83f4@toxicpanda.com>
In-Reply-To: <0584bf34-a93f-6e84-cedb-8806083a83f4@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 9 Mar 2021 18:31:57 -0500
Message-ID: <CAEg-Je-fB5cO0n=GPZFuhq7021yucUNKtC6Y3Orb+TjbTW+3iw@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 9, 2021 at 4:56 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 3/9/21 4:06 PM, Neal Gompa wrote:
> > On Tue, Mar 9, 2021 at 2:04 PM Josef Bacik <josef@toxicpanda.com> wrote=
:
> >>
> >> On 3/8/21 8:12 PM, Neal Gompa wrote:
> >>> On Mon, Mar 8, 2021 at 5:04 PM Josef Bacik <josef@toxicpanda.com> wro=
te:
> >>>>
> >>>> On 3/8/21 3:01 PM, Neal Gompa wrote:
> >>>>> On Mon, Mar 8, 2021 at 1:38 PM Josef Bacik <josef@toxicpanda.com> w=
rote:
> >>>>>>
> >>>>>> On 3/5/21 8:03 PM, Neal Gompa wrote:
> >>>>>>> On Fri, Mar 5, 2021 at 5:01 PM Josef Bacik <josef@toxicpanda.com>=
 wrote:
> >>>>>>>>
> >>>>>>>> On 3/5/21 9:41 AM, Neal Gompa wrote:
> >>>>>>>>> On Fri, Mar 5, 2021 at 9:12 AM Josef Bacik <josef@toxicpanda.co=
m> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 3/4/21 6:54 PM, Neal Gompa wrote:
> >>>>>>>>>>> On Thu, Mar 4, 2021 at 3:25 PM Josef Bacik <josef@toxicpanda.=
com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 3/3/21 2:38 PM, Neal Gompa wrote:
> >>>>>>>>>>>>> On Wed, Mar 3, 2021 at 1:42 PM Josef Bacik <josef@toxicpand=
a.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 2/24/21 10:47 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>> On Wed, Feb 24, 2021 at 10:44 AM Josef Bacik <josef@toxic=
panda.com> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On 2/24/21 9:23 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>> On Tue, Feb 23, 2021 at 10:05 AM Josef Bacik <josef@tox=
icpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> On 2/22/21 11:03 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>> On Mon, Feb 22, 2021 at 2:34 PM Josef Bacik <josef@to=
xicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> On 2/21/21 1:27 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef=
@toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> On 2/17/21 11:29 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <jose=
f@toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> On 2/17/21 9:50 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <jo=
sef@toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <=
josef@toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik=
 <josef@toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Ba=
cik <josef@toxicpanda.com> wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Hey all,
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> So one of my main computers recently ha=
d a disk controller failure
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> that caused my machine to freeze. After=
 rebooting, Btrfs refuses to
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> mount. I tried to do a mount and the fo=
llowing errors show up in the
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> journal:
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel:=
 BTRFS info (device sda3): disk space caching is enabled
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel:=
 BTRFS info (device sda3): has skinny extents
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel:=
 BTRFS critical (device sda3): corrupt leaf: root=3D401 block=3D796082176 s=
lot=3D15 ino=3D203657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel:=
 BTRFS error (device sda3): block=3D796082176 read time tree block corrupti=
on detected
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel:=
 BTRFS critical (device sda3): corrupt leaf: root=3D401 block=3D796082176 s=
lot=3D15 ino=3D203657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel:=
 BTRFS error (device sda3): block=3D796082176 read time tree block corrupti=
on detected
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel:=
 BTRFS warning (device sda3): couldn't read tree root
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel:=
 BTRFS error (device sda3): open_ctree failed
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> I've tried to do -o recovery,ro mount a=
nd get the same issue. I can't
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> seem to find any reasonably good inform=
ation on how to do recovery in
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> this scenario, even to just recover eno=
ugh to copy data off.
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> I'm on Fedora 33, the system was on Lin=
ux kernel version 5.9.16 and
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> the Fedora 33 live ISO I'm using has Li=
nux kernel version 5.10.14. I'm
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> using btrfs-progs v5.10.
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Can anyone help?
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Can you try
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> btrfs check --clear-space-cache v1 /dev/=
whatever
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> That should fix the inode generation thi=
ng so it's sane, and then the tree
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> checker will allow the fs to be read, ho=
pefully.  If not we can work out some
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> other magic.  Thanks,
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Josef
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> I got the same error as I did with btrfs-=
check --readonly...
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Oh lovely, what does btrfs check --readonl=
y --backup do?
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> No dice...
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>> # btrfs check --readonly --backup /dev/sda3
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 =
wanted 888893 found 888895
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 =
wanted 888893 found 888895
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 =
wanted 888893 found 888895
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> Hey look the block we're looking for, I wrot=
e you some magic, just pull
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> https://github.com/josefbacik/btrfs-progs/tr=
ee/for-neal
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> build, and then run
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> This will force us to point at the old root =
with (hopefully) the right bytenr
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> and gen, and then hopefully you'll be able t=
o recover from there.  This is kind
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> of saucy, so yolo, but I can undo it if it m=
akes things worse.  Thanks,
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>> # btrfs check --readonly /dev/sda3
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>>>>>>>>>>>>>>>> # btrfs check --clear-space-cache v1 /dev/sda=
3
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>>>>>>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>> It's better, but still no dice... :(
> >>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>> Hmm it's not telling us what's wrong with the =
extent tree, which is annoying.
> >>>>>>>>>>>>>>>>>>>>>>>>>> Does mount -o rescue=3Dall,ro work now that th=
e root tree is normal?  Thanks,
> >>>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>> Nope, I see this in the journal:
> >>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS i=
nfo (device sda3): enabling all of the rescue options
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS i=
nfo (device sda3): ignoring data csums
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS i=
nfo (device sda3): ignoring bad roots
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS i=
nfo (device sda3): disabling log replay at mount time
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS i=
nfo (device sda3): disk space caching is enabled
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS i=
nfo (device sda3): has skinny extents
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS e=
rror (device sda3): tree level mismatch detected, bytenr=3D791281664 level =
expected=3D1 has=3D2
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS e=
rror (device sda3): tree level mismatch detected, bytenr=3D791281664 level =
expected=3D1 has=3D2
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS w=
arning (device sda3): couldn't read tree root
> >>>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS e=
rror (device sda3): open_ctree failed
> >>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> Ok git pull for-neal, rebuild, then run
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895 2
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>> I thought of this yesterday but in my head was l=
ike "naaahhhh, whats the chances
> >>>>>>>>>>>>>>>>>>>>>>>> that the level doesn't match??".  Thanks,
> >>>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>>> Tried rescue mount again after running that and g=
ot a stack trace in
> >>>>>>>>>>>>>>>>>>>>>>> the kernel, detailed in the following attached lo=
g.
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> Huh I wonder how I didn't hit this when testing, I=
 must have only tested with
> >>>>>>>>>>>>>>>>>>>>>> zero'ing the extent root and the csum root.  You'r=
e going to have to build a
> >>>>>>>>>>>>>>>>>>>>>> kernel with a fix for this
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> https://paste.centos.org/view/7b48aaea
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>> and see if that gets you further.  Thanks,
> >>>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> I built a kernel build as an RPM with your patch[1]=
 and tried it.
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro =
/dev/sdb3 /mnt
> >>>>>>>>>>>>>>>>>>>>> Killed
> >>>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>> The log from the journal is attached.
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Ahh crud my bad, this should do it
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> https://paste.centos.org/view/ac2e61ef
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> Patch doesn't apply (note it is patch 667 below):
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Ah sorry, should have just sent you an iterative patch=
.  You can take the above
> >>>>>>>>>>>>>>>>>> patch and just delete the hunk from volumes.c as you a=
lready have that applied
> >>>>>>>>>>>>>>>>>> and then it'll work.  Thanks,
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Failed with a weird error...?
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev=
/sda3 /mnt
> >>>>>>>>>>>>>>>>> mount: /mnt: mount(2) system call failed: No such file =
or directory.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Journal log with traceback attached.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Last one maybe?
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> https://paste.centos.org/view/80edd6fd
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Similar weird failure:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/s=
db3 /mnt
> >>>>>>>>>>>>>>> mount: /mnt: mount(2) system call failed: No such file or=
 directory.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> No crash in the journal this time, though:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3):=
 enabling all of the rescue options
> >>>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3):=
 ignoring data csums
> >>>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3):=
 ignoring bad roots
> >>>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3):=
 disabling log replay at mount time
> >>>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3):=
 disk space caching is enabled
> >>>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3):=
 has skinny extents
> >>>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS warning (device sdb=
3): failed to read fs tree: -2
> >>>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS error (device sdb3)=
: open_ctree failed
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Sorry Neal, you replied when I was in the middle of someth=
ing and promptly
> >>>>>>>>>>>>>> forgot about it.  I figured the fs root was fine, can you =
do the following so I
> >>>>>>>>>>>>>> can figure out from the error messages what might be wrong
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> btrfs check --readonly
> >>>>>>>>>>>>>> btrfs restore -D
> >>>>>>>>>>>>>> btrfs restore -l
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> It didn't work.. Here's the output:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> [root@fedora ~]# btrfs check --readonly /dev/sdb3
> >>>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>>>>> [root@fedora ~]# btrfs restore -D /dev/sdb3 /mnt
> >>>>>>>>>>>>> WARNING: could not setup extent tree, skipping it
> >>>>>>>>>>>>> Couldn't setup device tree
> >>>>>>>>>>>>> Could not open root, trying backup super
> >>>>>>>>>>>>> parent transid verify failed on 796082176 wanted 888894 fou=
nd 888896
> >>>>>>>>>>>>> parent transid verify failed on 796082176 wanted 888894 fou=
nd 888896
> >>>>>>>>>>>>> parent transid verify failed on 796082176 wanted 888894 fou=
nd 888896
> >>>>>>>>>>>>> Ignoring transid failure
> >>>>>>>>>>>>> WARNING: could not setup extent tree, skipping it
> >>>>>>>>>>>>> Couldn't setup device tree
> >>>>>>>>>>>>> Could not open root, trying backup super
> >>>>>>>>>>>>> ERROR: superblock bytenr 274877906944 is larger than device=
 size 263132807168
> >>>>>>>>>>>>> Could not open root, trying backup super
> >>>>>>>>>>>>> [root@fedora ~]# btrfs restore -l /dev/sdb3 /mnt
> >>>>>>>>>>>>> WARNING: could not setup extent tree, skipping it
> >>>>>>>>>>>>> Couldn't setup device tree
> >>>>>>>>>>>>> Could not open root, trying backup super
> >>>>>>>>>>>>> parent transid verify failed on 796082176 wanted 888894 fou=
nd 888896
> >>>>>>>>>>>>> parent transid verify failed on 796082176 wanted 888894 fou=
nd 888896
> >>>>>>>>>>>>> parent transid verify failed on 796082176 wanted 888894 fou=
nd 888896
> >>>>>>>>>>>>> Ignoring transid failure
> >>>>>>>>>>>>> WARNING: could not setup extent tree, skipping it
> >>>>>>>>>>>>> Couldn't setup device tree
> >>>>>>>>>>>>> Could not open root, trying backup super
> >>>>>>>>>>>>> ERROR: superblock bytenr 274877906944 is larger than device=
 size 263132807168
> >>>>>>>>>>>>> Could not open root, trying backup super
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Hmm OK I think we want the neal magic for this one too, but =
before we go doing
> >>>>>>>>>>>> that can I get a
> >>>>>>>>>>>>
> >>>>>>>>>>>> btrfs inspect-internal -f /dev/whatever
> >>>>>>>>>>>>
> >>>>>>>>>>>> so I can make sure I'm not just blindly clobbering something=
.  Thanks,
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Doesn't work, did you mean some other command?
> >>>>>>>>>>>
> >>>>>>>>>>> [root@fedora ~]#  btrfs inspect-internal -f /dev/sdb3
> >>>>>>>>>>> btrfs inspect-internal: unknown token '-f'
> >>>>>>>>>>
> >>>>>>>>>> Sigh, sorry, btrfs inspect-internal dump-super -f /dev/sdb3
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Ok I've pushed to the for-neal branch in my btrfs-progs, can you=
 pull and make
> >>>>>>>> and then run
> >>>>>>>>
> >>>>>>>> ./btrfs-print-block /dev/sdb3 791281664
> >>>>>>>>
> >>>>>>>> and capture everything it prints out?  Thanks,
> >>>>>>>>
> >>>>>>>
> >>>>>>> Here's the output from the command.
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> Hmm looks like the fs is offset a bit, can you do
> >>>>>>
> >>>>>> ./btrfs-print-block /dev/sdb3 799670272
> >>>>>>
> >>>>>
> >>>>> This command caused my session to crash, but I do have a log of wha=
t
> >>>>> was captured before it crashed and attached it.
> >>>>>
> >>>>>> also while we're here can I get
> >>>>>>
> >>>>>> btrfs-find-root /dev/sdb3
> >>>>>>
> >>>>>
> >>>>> This ran successfully and I've attached the output.
> >>>>>
> >>>>
> >>>> Ok we're going to try this again, and if it doesn't work it looks li=
ke your
> >>>> chunk root is ok, so I'll rig something up to make the translation w=
ork right,
> >>>> but for now lets do
> >>>>
> >>>> ./btrfs-print-block /dev/sdb3 792395776
> >>>>
> >>>
> >>> I've attached the output from that command, which did run successfull=
y.
> >>>
> >>
> >> Definitely need the translation, I pushed a new patch to the btrfs-pro=
gs branch
> >> for-neal.  Pull, rebuild, and then run the same command again, hopeful=
ly this
> >> gives me what I want.  Thanks,
> >>
> >
> > Done and attached the output.
> >
> >
>
> Ok, lets go with
>
> ./btrfs-neal-magic /dev/sdb3 792395776 888895 1
>
> and see if that fixes everything.  Thanks,
>

That worked! I was able to mount the disk and recover pretty much all
of my user data to a backup drive.

Now I can set up a new machine with all my data again! :)

Thanks for all the assistance, even though it was pretty crazy.
Perhaps something good can come of this for making recovery easier in
the future?



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
