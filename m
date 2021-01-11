Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E7E2F11EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 12:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbhAKLuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 06:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbhAKLui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 06:50:38 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517BEC061794
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 03:49:58 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id p14so14282537qke.6
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 03:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1bZbbfaqeiSkIwPi3QoEr7oqAZegvsEBuBiYfR/X6BA=;
        b=CVJHuWC9UOkQPAhApDfh6CApkuF27hc3Vhn4CDbyEbm6YT0GpFwKtbxS2Ysm1fvRva
         wS45+i58AHqXg9wzhNbwPFcBySFa4CvSH5xdow1KzoRpvBqYH9NxGtylnni/lGW49JKV
         oaO5QAp1m5ngnIYtlv6qKvTxvXgR8Fk/1Xl+/buSu7/RR+YPy/rXaNadb4uUFK3WA7PQ
         QgqnSJhsOnoJ2E4XanPJ+nwYJYLnhJyHecAGWVyoofXgs17fJ+5xojC86KpMrXBbsMY7
         KfaT2fMna9UdvWheGJ98gYOAV6aFQQ8JvKZv0bz8YfpMN1BhfhZ5jhUjwVRc30J/Sx8o
         DPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1bZbbfaqeiSkIwPi3QoEr7oqAZegvsEBuBiYfR/X6BA=;
        b=rh3nvFjk4uoOypWPUDXmeFtuLPGvKeZh9mnm5vI6uAukQHFR9NhOLl0+A5LORb3ODk
         2UR36qssRIx/6bd3ihJhTyog1WfhHsQRpAWILhjSPNVOKk8DaqHAkVBsPhnGuWudCo8k
         8YYDxqRTvn/B/o+8i8cnO8DzC05k0yqhMpLTxPKaDZI3K77qqsV7mw+uhD2oP9vVgqNq
         oDBN5+pIQzZdsBuvOwkhi3fvY4EV4wBao5+gKjWaeklF7afFeYta09WS+QZPXFL3e4po
         d5x40lBFKxdR7tMSV2584Bi9tWn6+Ki8ijMoYVr8Dt+1pkTMfRChffG6pO+UoFdeENAc
         uVdg==
X-Gm-Message-State: AOAM5334sDWsrD+RYw4g2uWC40uhiOI7cwwxRsT0yQrd4Xi8bHsJlWJJ
        Q8wU1rj/KGLQimq7BryGD6YaPpLuAmLWeievPh8=
X-Google-Smtp-Source: ABdhPJzl4MMnW3EY3OcWJOXlRlLoxM2xRegB/CiroyN/rmKXHSJ1w4LUdRaaeaU+tlgIXVbrfTIbIIHT05ReDAi3BiY=
X-Received: by 2002:a37:bc07:: with SMTP id m7mr15724132qkf.438.1610365797537;
 Mon, 11 Jan 2021 03:49:57 -0800 (PST)
MIME-Version: 1.0
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
 <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
 <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net> <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
 <40b352dfa84e0f22d76e9b4f47111117549fa3bb.camel@gmx.net> <CAL3q7H7oLWGWJcg0Gfa+RKRGNf+d4mv0R9FQi2j=xLL1RNPTGA@mail.gmail.com>
 <1f78cd5d635b360e03468740608f3b02aea76b5d.camel@gmx.net> <CAL3q7H4r-EtnMc=VD2EP01HsLCqg-z8LfMnFseHrNEv=rjPT_g@mail.gmail.com>
 <c0aa48c7db8c00efe8dd9a2c72c425ffe57df49c.camel@gmx.net> <CAL3q7H7LCaRE_28RRY0zfHiJo5G1EkDHKCuue3-052AeuXmG4w@mail.gmail.com>
 <cd8e521bcf1e8d999d39ddae61b61fc45492e2c8.camel@gmx.net> <CAL3q7H7EoyQ+_kf0R04TwDZHSWnDH6fojYviryYTjgPuRc4HfA@mail.gmail.com>
In-Reply-To: <CAL3q7H7EoyQ+_kf0R04TwDZHSWnDH6fojYviryYTjgPuRc4HfA@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 11 Jan 2021 11:49:46 +0000
Message-ID: <CAL3q7H5WX8wo=i_rPQ_kU+Qzup1qxQ7U=2LKO0BstrSkGCUfmw@mail.gmail.com>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file or directory
To:     "Massimo B." <massimo.b@gmx.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 18, 2020 at 11:44 AM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Fri, Dec 18, 2020 at 7:25 AM Massimo B. <massimo.b@gmx.net> wrote:
> >
> > On Mon, 2020-12-14 at 09:46 +0000, Filipe Manana wrote:
> >
> > > clone mb/Documents.AZ/0.SYNC/....pdf - source=3Dmb/Documents.AZ/0.SYN=
C/....pdf
> > > > source offset=3D20705280 offset=3D20709376 length=3D4096
> > > > clone mb/Documents.AZ/0.SYNC/....pdf - source=3Dmb/Documents.AZ/0.S=
YNC/....pdf
> > > > source offset=3D20713472 offset=3D20713472 length=3D4096
> > > > ERROR: failed to clone extents to mb/Documents.AZ/0.SYNC/....pdf: I=
nvalid
> > > > argument
> > >
> > > It's a different problem. This one because the kernel is sending an
> > > invalid clone operation - the source and destination offsets are the
> > > same, which makes the receiver fail.
> > > Can you tell what's the size (in bytes) of "mb/Documents.AZ/0.SYNC"
> > > after the receive fails? Both in the destination and source.
> >
> > Hi Filipe,
> >
> > I already deleted the failing subvolume, now I got the issue again. Her=
e are the
> > detailed information about the file:
> >
> >
> > # btrfs send /mnt/usb/mobiledata/snapshots/mobalindesk/vm/VirtualMachin=
es.20190621T140904+0200 | mbuffer -v 1 -m 2% | btrfs receive /mnt/local/dat=
a/snapshots/vm/
> > ...
> > write IE8 - Win7/IE8 - Win7-disk1.vmdk - offset=3D4742344704 length=3D4=
096
> > clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7=
-disk1.vmdk source offset=3D4742184960 offset=3D4742348800 length=3D16384
> > clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7=
-disk1.vmdk source offset=3D4742184960 offset=3D4742365184 length=3D28672
> > clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7=
-disk1.vmdk source offset=3D4742246400 offset=3D4742393856 length=3D8192
> > write IE8 - Win7/IE8 - Win7-disk1.vmdk - offset=3D4742402048 length=3D1=
2288
> > clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7=
-disk1.vmdk source offset=3D4742410240 offset=3D4742414336 length=3D4096
> > clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7=
-disk1.vmdk source offset=3D4742418432 offset=3D4742418432 length=3D4096
> > ERROR: failed to clone extents to IE8 - Win7/IE8 - Win7-disk1.vmdk: Inv=
alid argument
> >
> > summary: 4226 MiByte in 21min 11.4sec - average of 3404 kiB/s
> >
> >
> > # ls -al "/mnt/usb/mobiledata/snapshots/mobalindesk/vm/VirtualMachines.=
20190621T140904+0200/IE8 - Win7/IE8 - Win7-disk1.vmdk"
> > -rw------- 1 massimo massimo 17932222464 18. Dez 2018  '/mnt/usb/mobile=
data/snapshots/mobalindesk/vm/VirtualMachines.20190621T140904+0200/IE8 - Wi=
n7/IE8 - Win7-disk1.vmdk'
> >
> > # ls -al "/mnt/local/data/snapshots/vm/VirtualMachines.20190621T140904+=
0200/IE8 - Win7/IE8 - Win7-disk1.vmdk"
> > -rw------- 1 root root 4742418432 18. Dez 07:37 '/mnt/local/data/snapsh=
ots/vm/VirtualMachines.20190621T140904+0200/IE8 - Win7/IE8 - Win7-disk1.vmd=
k'
> >
> > # compsize "/mnt/usb/mobiledata/snapshots/mobalindesk/vm/VirtualMachine=
s.20190621T140904+0200/IE8 - Win7/IE8 - Win7-disk1.vmdk"
> > Type       Perc     Disk Usage   Uncompressed Referenced
> > TOTAL       45%      7.3G          16G          16G
> > none       100%      1.9G         1.9G         2.3G
> > zlib        38%      4.8G          12G          13G
> > zstd        34%      536M         1.5G         727M
> >
> > # compsize "/mnt/local/data/snapshots/vm/VirtualMachines.20190621T14090=
4+0200/IE8 - Win7/IE8 - Win7-disk1.vmdk"
> > Type       Perc     Disk Usage   Uncompressed Referenced
> > TOTAL       92%      4.1G         4.4G         4.3G
> > none       100%      3.8G         3.8G         3.8G
> > zlib        32%      7.3M          22M          22M
> > zstd        45%      264M         583M         560M
> >
> > Does that help you?
>
> It confirms what I suspected and narrows down a bit the possible causes.
> Are you able to run the send operation again with the following debug pat=
h?
>
> https://pastebin.com/raw/cEEy9A6W

Well, never mind, in the meanwhile after the holidays I find out why it hap=
pens.
The patch with the fix is at:

https://patchwork.kernel.org/project/linux-btrfs/patch/900493c40f7edbd42fe8=
61ccd9a68851ea952499.1610363502.git.fdmanana@suse.com/

Thanks.

>
> When the issue happens it should dump to dmesg/syslog a debug message
> that starts with the marker "HERE" and right before it,
> something that takes several lines to dump a metadata leaf, and with
> first line being something like this:
>
> "leaf <number> gen <number> total ptrs <number> free space <number>
> owner <number>"
>
> That way I can see the specific extent metadata layout that causes
> send to issue an invalid clone operation (attempting to clone 4096
> bytes from eof).
>
> Thanks a lot Massimo!
>
> >
> > Best regards,
> > Massimo
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
