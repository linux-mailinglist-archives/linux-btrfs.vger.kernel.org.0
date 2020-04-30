Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4131C0571
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 20:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD3S7C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 14:59:02 -0400
Received: from mail-40137.protonmail.ch ([185.70.40.137]:10479 "EHLO
        mail-40137.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgD3S7B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 14:59:01 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 14:58:59 EDT
Date:   Thu, 30 Apr 2020 18:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1588272033;
        bh=rCVj53QwszqZZr8EVUCceN7F1ONvTFvgMsssjv5OVzI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=cfdpLp4qK8LyWnHEoES6KmT8vSsw2g3n8vVimw7xh8Dafb/gS2ZcrMDKkiRwU3vyQ
         O91pTc5QzFBkYTYHgQ5dqAP35BJ3oDQZN/GZ2rfvgS2KDYfeBFbnxP/4kq9C3SOoyU
         GY0G0M6CXD1znlWVTdsGpVRv4gFw5X0FGVgV0090=
To:     Chris Murphy <lists@colorremedies.com>
From:   Nouts <nouts@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: Nouts <nouts@protonmail.com>
Subject: Re: Troubleshoot help needed - RAID1 not mounting : failed to read block groups
Message-ID: <NmjvBWGDb0a1ZnPep0UnBmeFG4uSUMrxyiYDCir6RRsMyZzizVtCH_8tdd6Y_glmPbbusrKtVBCgGvV7Cc5UFCDqcvJ1PTgWi87x-0FacQ4=@protonmail.com>
In-Reply-To: <CAJCQCtT0mSYvN7FeCavsmKP9j_69JmZ0JdGz8ommhqag=GiM=Q@mail.gmail.com>
References: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
 <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
 <CAJCQCtT0mSYvN7FeCavsmKP9j_69JmZ0JdGz8ommhqag=GiM=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for your help. I compiled btrfs-progs v5.6 from github.

Here is the dump from /dev/sda : https://pastebin.com/e3YZxxsZ

And btrfs check returned an error instantly :
Opening filesystem to check...
ERROR: child eb corrupted: parent bytenr=3D5923702292480 item=3D2 parent le=
vel=3D2 child level=3D0
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system


=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, April 30, 2020 7:38 PM, Chris Murphy <lists@colorremedies.com>=
 wrote:

> On Thu, Apr 30, 2020 at 5:57 AM Nouts nouts@protonmail.com wrote:
>
> > > [ 4645.402880] BTRFS info (device sdb): disk space caching is enabled
> > > [ 4645.405687] BTRFS info (device sdb): has skinny extents
> > > [ 4645.451484] BTRFS error (device sdb): failed to read block groups:=
 -117
> > > [ 4645.472062] BTRFS error (device sdb): open_ctree failed
> > > mount: wrong fs type, bad option, bad superblock on /dev/sdb,missing =
codepage or helper program, or other error
> > > In some cases useful info is found in syslog - trydmesg | tail or so.
>
> > > I attached you the smartctl result from the day before and the last s=
crub report I got from a month ago. From my understanding, it was ok.
> > > I use hardlink (on the same partition/pool) and I deleted some data j=
ust the day before. I suspect my daily scrub routine triggered something th=
at night and next day /home was gone.
> > > I can't scrub anymore as it's not mounted. Mounting with usebackuproo=
t or degraded or ro produce the same error.
> > > I tried "btrfs check /dev/sda" :
> > > checking extents
> > > leaf parent key incorrect 5909107507200
> > > bad block 5909107507200
> > > Errors found in extent allocation tree or chunk allocation
> > > Checking filesystem on /dev/sda
> > > UUID: 3720251f-ef92-4e21-bad0-eae1c97cff03
>
> What do you get for:
>
> btrfs insp dump-t -b 5909107507200 /dev/sda
>
> > > Then "btrfs rescue zero-log /dev/sda", which produced a weird stacktr=
ace...
>
> btrfs-progs is really old
>
> > > Finally I tried "btrfs rescue chunk-recover /dev/sda", which run on a=
ll 3 drives at the same time during 8+ hours...
> > > It asks to rebuild some metadata tree, which I accepted (I did not sa=
ved the full output sorry) and it ended with the same stacktrace as above.
> > > The only command left is "btrfs check --repair" but I afraid it might=
 do more bad than good.
>
> With that version of btrfs-progs it's not advised.
>
> > > I'm running Debian 9 (still, because of some dependencies). My kernel=
 is already backported : 4.19.0-0.bpo.6-amd64 #1 SMP Debian 4.19.67-2+deb10=
u2~bpo9+1 (2019-11-12) x86_64 GNU/Linux
> > > btrfs version : v4.7.3
>
> I suggest finding newer btrfs-progs, 5.4 or better, or compiling it from =
git.
> https://github.com/kdave//btrfs-progs
>
> And then run:
>
> btrfs check /dev/sda
>
> Let's see what that says.
>
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------------------
>
> Chris Murphy


