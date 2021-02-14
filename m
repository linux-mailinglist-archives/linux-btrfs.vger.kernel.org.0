Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0DA31B382
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Feb 2021 00:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBNX5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Feb 2021 18:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhBNX5a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Feb 2021 18:57:30 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E561C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 15:56:50 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id c131so694386ybf.7
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aF8Jet7OjA/5vEA2RJvfWIPanGM5i9fHX+CWfX0ZEu4=;
        b=DfsbgHXFUNJ2dqAwFyI2BYd76m/jmgzSUeGQGFKtcHhEjfCJSqXlL7MWhSonMsMXoP
         XH74R9lmMsbIw11/9POtzIv1X6JcbWQYxM8ZGz6SaNRsVyn9GiJAE+mpZ7CMW2m61FKp
         KISswzJCyxbv1A1duOC0EaKYWDnzjJSFyGKpxS+sB1Pp+AXG1BtFGdi8zt5FQzofuoO+
         I9HAa/KjCe2vM0nILPj9MMHzQI52tJQYjp98k81ezhpmzCBrsXHUI7WSYtRV3+q2KCdU
         9NyE1cEXXk0kNeKLmmIey71PskOrzjH6vbzFBu3B7zE4GAZPwiWTIe855k7mE6g3L+n/
         Z0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aF8Jet7OjA/5vEA2RJvfWIPanGM5i9fHX+CWfX0ZEu4=;
        b=GUcwkEzFoNERHvjNXP+XW1py56qFMma99+2b9ZeWDbhHwdqtx+KEB/zdQWComyHCuC
         IY3xqK7OsJGe0eqoQT1Tki9teCwPm3Rz5lIwoz9ZxdApexcmatwbkmQL3oW9cVxPal6s
         49JMkEHMr1briKV9CuyivRKAjBYOtLEsEuhP3HA+zfvKM1VEdYx6nkprpk5S7SQl3ECc
         pu6SBwDb7mARPCJrdUjTKi0ToQBgsiHOygWuVnb1AkQ4XdyFdK76dMAp3tTXsj8WnjOR
         gdBaa6IL6n1YitS9VH8WHaBHOLMD7SF4tIA4VOcHTXnUxs86puk3w8dxtDDPSBV6jEbR
         1VtA==
X-Gm-Message-State: AOAM533tC967wMOs+itqSxV3r86KlngYFDNBGlezVeMMarNE6DHIwIgv
        eJaVD8zUsQFEOLVxvBOarzmf/1TQ9eHOFsQYb28=
X-Google-Smtp-Source: ABdhPJyHjKmkRGCvmCdFUj5e4nr235CnNRkgHRCHfP9yjidL9pLFhdP9TfiiCR+NegPSDY2rb4UakVbdjgxmMk/e7ng=
X-Received: by 2002:a25:424f:: with SMTP id p76mr10242519yba.109.1613347009502;
 Sun, 14 Feb 2021 15:56:49 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <CAJCQCtRhxUx3R5_VgWGN0hvpJ=ET6j4Wr73Ph0jKWcCizA=CgQ@mail.gmail.com>
 <CAEg-Je_Yu3NVyaT7EDBHaQsLJZfL7he5bzri3HbgaDoYKFKKDQ@mail.gmail.com> <CAJCQCtTZs5Ygym4W1M6RPaz7BaxSEysYpSQiUOcc3OyxBKbbLw@mail.gmail.com>
In-Reply-To: <CAJCQCtTZs5Ygym4W1M6RPaz7BaxSEysYpSQiUOcc3OyxBKbbLw@mail.gmail.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Sun, 14 Feb 2021 18:56:13 -0500
Message-ID: <CAEg-Je8wXYBmBneKubg6eP5z5JF+myh8hoUBmP1L1pZuaze1aA@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 14, 2021 at 6:52 PM Chris Murphy <lists@colorremedies.com> wrot=
e:
>
> On Sun, Feb 14, 2021 at 4:24 PM Neal Gompa <ngompa13@gmail.com> wrote:
> >
> > On Sun, Feb 14, 2021 at 5:11 PM Chris Murphy <lists@colorremedies.com> =
wrote:
> > >
> > > On Sun, Feb 14, 2021 at 1:29 PM Neal Gompa <ngompa13@gmail.com> wrote=
:
> > > >
> > > > Hey all,
> > > >
> > > > So one of my main computers recently had a disk controller failure
> > > > that caused my machine to freeze. After rebooting, Btrfs refuses to
> > > > mount. I tried to do a mount and the following errors show up in th=
e
> > > > journal:
> > > >
> > > > > Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): =
disk space caching is enabled
> > > > > Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): =
has skinny extents
> > > > > Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda=
3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, inva=
lid inode transid: has 888896 expect [0, 888895]
> > > > > Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3):=
 block=3D796082176 read time tree block corruption detected
> > > > > Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda=
3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, inva=
lid inode transid: has 888896 expect [0, 888895]
> > > > > Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3):=
 block=3D796082176 read time tree block corruption detected
> > > > > Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3=
): couldn't read tree root
> > > > > Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3):=
 open_ctree failed
> > > >
> > > > I've tried to do -o recovery,ro mount and get the same issue. I can=
't
> > > > seem to find any reasonably good information on how to do recovery =
in
> > > > this scenario, even to just recover enough to copy data off.
> > > >
> > > > I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
> > > > the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. =
I'm
> > > > using btrfs-progs v5.10.
> > >
> > > Oh and also that block:
> > >
> > > btrfs insp dump-t -b 796082176 /dev/sda3
> > >
> >
> > So, I've attached the output of the dump-s and dump-t commands.
> >
> > As for the other commands:
> >
> > # btrfs check --readonly /dev/sda3
> > > Opening filesystem to check...
> > > parent transid verify failed on 796082176 wanted 888894 found 888896
>
> Not good. So three different transids in play.
>
> Super says generation 888894
>
> Leaf block says its generation is 888896, and two inodes have transid
> 888896 including the one the tree checker is complaining about.
> Somehow the super has an older generation than both what's in the leaf
> and what's expected.
>

Uhh, that's a lot of oddities there...

> > > parent transid verify failed on 796082176 wanted 888894 found 888896
> > > parent transid verify failed on 796082176 wanted 888894 found 888896
> > > Ignoring transid failure
> > > ERROR: could not setup extent tree
> > > ERROR: cannot open file system
> >
> > # mount -o ro,rescue=3Dall /dev/sda3 /mnt
> > > mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda3, =
missing codepage or helper program, or other error.
>
> Do you get the same kernel messages as originally reported? Or
> something different?
>

Not substantially different:

> Feb 14 18:54:06 localhost-live kernel: BTRFS info (device sda3): enabling=
 all of the rescue options
> Feb 14 18:54:06 localhost-live kernel: BTRFS info (device sda3): ignoring=
 data csums
> Feb 14 18:54:06 localhost-live kernel: BTRFS info (device sda3): ignoring=
 bad roots
> Feb 14 18:54:06 localhost-live kernel: BTRFS info (device sda3): disablin=
g log replay at mount time
> Feb 14 18:54:06 localhost-live kernel: BTRFS info (device sda3): disk spa=
ce caching is enabled
> Feb 14 18:54:06 localhost-live kernel: BTRFS info (device sda3): has skin=
ny extents
> Feb 14 18:54:06 localhost-live kernel: BTRFS critical (device sda3): corr=
upt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, invalid inod=
e transid: has 888896 expect [0, 888895]
> Feb 14 18:54:06 localhost-live kernel: BTRFS error (device sda3): block=
=3D796082176 read time tree block corruption detected
> Feb 14 18:54:06 localhost-live kernel: BTRFS critical (device sda3): corr=
upt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, invalid inod=
e transid: has 888896 expect [0, 888895]
> Feb 14 18:54:06 localhost-live kernel: BTRFS error (device sda3): block=
=3D796082176 read time tree block corruption detected
> Feb 14 18:54:06 localhost-live kernel: BTRFS warning (device sda3): could=
n't read tree root
> Feb 14 18:54:06 localhost-live kernel: BTRFS error (device sda3): open_ct=
ree failed


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
