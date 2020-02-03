Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625FC1507D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 14:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgBCN7a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 08:59:30 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37948 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgBCN7a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 08:59:30 -0500
Received: by mail-vs1-f66.google.com with SMTP id r18so8954417vso.5
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 05:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UHnDkpmS94mZfhtFBgiO14YIupiHFYwh4c5HTfHr1ac=;
        b=gK62ccyET0pb8p10oFmuCOBvxvad0ao7SmjagWxOeZ2A8reYfC2R+fTlaC5QRh0QtR
         +nHN3EaAp/diVO/nDppfaJ/Akpf0xYvTlbGxmy00oHb2LLil+OsdRPcOicqTaKQKovaN
         iCNQ6Qx4TsAdggBd9czhZdtlEhY0x8VVorFjhUPkQb0apsfm/jBBtuZDTq3j5lBO0Rn3
         sXyohhk56uvXWD/Go7k/WkHbSVTIgzLp9Bb31RCJ2UCuVQ6LScVM3KsuzUQOAasf4z4m
         ujRn/eYiOiT9l41Xo27bD9M2pdL3g7vPPao28n3+30KaTQhLQ4MA2ViSStKvz/NBub+h
         qs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=UHnDkpmS94mZfhtFBgiO14YIupiHFYwh4c5HTfHr1ac=;
        b=bGH+JWUmB1lX68v4ob+kjZhuoQa+0p+aQIDTHD0R0fLDPx1B8prSWScvRVZcyPaAbe
         sAtP2WKdUCIdwC8n0DRYD2YQFHhxvUW9jFZBftcAmnXKrvGLJwkXotn5xN9/lyEQA+Qy
         jhu5OaPF/g5l3nGUo7o92+ngN0xZa3h8hKmM/2TRwyTUMOxKEoCTHER3RzXaLDspeR0H
         P36D5jjfzwbl5c4+xy8sjzunObphzjKgS2w8ypAFIaBM8Rhv4ED6/8VpRlpIUd927/Bt
         rD7J8Kk1m+HCyan22OWo3wyzJewQQlX+6FfD1Cq5YWJMzNmu0jLUuluf6/PV/T3z82r0
         vjvg==
X-Gm-Message-State: APjAAAWRqU1UTa+Qta1xGolJqqzv0Lmw8kuUN32bwWSM7MxoB9iaBUUD
        B9teae15cO2HBU8IflIuYRsUopQRnzD7OoM7JxKh4ifT
X-Google-Smtp-Source: APXvYqx3RBkLOFF0WXmo5RgOg6IXfqHD0PGlu909Clh8jZn4HQLYwU+Rb3FcTUL7LMoRA+LBbGmleu1IiI3WTgs0wZQ=
X-Received: by 2002:a67:fd0d:: with SMTP id f13mr15117635vsr.125.1580738368707;
 Mon, 03 Feb 2020 05:59:28 -0800 (PST)
MIME-Version: 1.0
References: <CAM9pMnP7PJNMCSabvPtM5hQ776uNfejjqPUhEEkoJFSeLVK2PA@mail.gmail.com>
 <9cff72cb-ef8e-2d12-45ad-3a224e86b07a@gmx.com>
In-Reply-To: <9cff72cb-ef8e-2d12-45ad-3a224e86b07a@gmx.com>
From:   Robert Klemme <shortcutter@googlemail.com>
Date:   Mon, 3 Feb 2020 14:58:52 +0100
Message-ID: <CAM9pMnOpSFnR9Dc_MyTyJevMRgiKBMPec-Y2W-iMbeyatTetog@mail.gmail.com>
Subject: Re: Root FS damaged
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey,

thank you! That was quick! Some comments inline below.

On Mon, Feb 3, 2020 at 2:44 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> On 2020/2/3 =E4=B8=8B=E5=8D=889:33, Robert Klemme wrote:

> > I have an issue with one of my desktop systems. Besides the usual
> > information below I have attached output of btrfsck and dmesg. The
> > system did not crash but was up for about a week.
> >
> > My questions:
> > 1. And ideas what is wrong?
>
> One data extent lost its backref in extent tree.
> So btrfs is unable to delete it, and will fallback to RO, to avoid
> further corruption.
>
> I have no idea how this happened, but I'm pretty confident it's caused
> by btrfs itself, not some hardware nor disk problems.

I would assume as much as there were no power outages or crashes. I
read about a bug recently (probably on
https://www.reddit.com/r/btrfs/) that had to do with btrfs on LUKS and
/ or LVM. Could this be an explanation?

> Any history about the fs? It may be caused by some older btrfs bug.
>
> > 2. Should I file a bug
>
> If you have an idea how to reproduce such problem.

Not at the moment as I did not observe any unusual circumstances.
Having the system up and running for a while is probably not a useful
test. :-)

> Or we can only help you to fix the fs, not really to locate the cause.

OK, let's take that route.

> > 3. can I safely repair with --repair or what else do I have to do to re=
pair?
>
> Btrfs check --repair should be able to repair that, but not recommended
> for your btrfs-progs version.
>
> There is a bug that any power loss or transaction abort in btrfs-progs
> can further screw up your fs.

That explains why a repair I recently attempted elsewhere did make
things worse...

> That bug is solved in v5.1 btrfs-progs.
> I doubt it's backported for any btrfs-progs at all.
>
> So please use latest btrfs-progs to fix it.
> A liveiso from some rolling distro would help.

Is there a PPA? I could not find one so far.

Thank you!

robert

>
> Thanks,
> Qu
>
> >
> > Thank you!
> >
> > Kind regards
> >
> > robert
> >
> > This is a Xubuntu and I am using btrfs on top of lvm on top of LUKS.
> >
> > $ lsb_release -a
> > No LSB modules are available.
> > Distributor ID: Ubuntu
> > Description:    Ubuntu 18.04.3 LTS
> > Release:        18.04
> > Codename:       bionic
> > $ uname -a
> > Linux robunt-01 4.15.0-76-generic #86-Ubuntu SMP Fri Jan 17 17:24:28
> > UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> > $ btrfs --version
> > btrfs-progs v4.15.1
> > $ sudo btrfs fi show
> > Label: none  uuid: 0da6c6f7-d42e-4096-8690-97daf14d70e7
> >         Total devices 1 FS bytes used 12.64GiB
> >         devid    1 size 30.00GiB used 15.54GiB path
> > /dev/mapper/main--vg-main--root
> >
> > Label: 'home'  uuid: cfb8c776-0dab-4596-af5b-276f0db46f79
> >         Total devices 1 FS bytes used 50.73GiB
> >         devid    1 size 161.57GiB used 53.07GiB path
> > /dev/mapper/main--vg-main--home
> >
> > $ sudo btrfs fi df /
> > Data, single: total=3D14.01GiB, used=3D11.83GiB
> > System, single: total=3D32.00MiB, used=3D16.00KiB
> > Metadata, single: total=3D1.50GiB, used=3D820.30MiB
> > GlobalReserve, single: total=3D39.19MiB, used=3D0.00B
> >
>


--=20
[guy, jim, charlie, sho].each {|him| remember.him do |as, often|
as.you_can - without end}
http://blog.rubybestpractices.com/
