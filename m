Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A69108571
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 00:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfKXXC4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Nov 2019 18:02:56 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:37915 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfKXXC4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Nov 2019 18:02:56 -0500
Received: by mail-wm1-f46.google.com with SMTP id z19so13681694wmk.3
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2019 15:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vXV1A+sWj2UjrsjRNGom/tFpvSQNM7NO+kTC8mgKUCE=;
        b=oqnEzZord8L5Pa/Cv4RZEuHJIJglKRYalyOOE0WMJ/5rRAAK9mmNky67J2KhWT1nFg
         N8SPoLSQTcK01NpE1rx/XIsMjB9QMSO8iRnNLHDR3G8ibS5cQCbCdIpSFm74bwijq5rA
         wod6opOWkkqufVbmRe00PaTdeJHnVopcdJNfM8iWY5/e23//SCx/zH4bjFGCKGKd186H
         GCm3b6cETyA5HRsnPsz6LXez1Z9kx82bYS0mevIL83r6nU5b/YvmzTN9rSc6ohMP4gCa
         qlLs1cYy5lM8BfSRbV37114JYAkkLk6Yrt3uKKpHUTJRB8wYQYucTzBT31rvQo72sXaR
         vJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vXV1A+sWj2UjrsjRNGom/tFpvSQNM7NO+kTC8mgKUCE=;
        b=SRG4ojd4HGwn1teZg4/RDd3MHigA+xMMPuxDDI3JXYKPiOeL0ANntonzDYVxY0XCS+
         smVvIsaYeKfCgc9xjSwHlSY+2poUz22V8h2QSN9PQxPFRKIhLV+/YLgkxg02pJDYm+Cz
         x7TNJ+RuKdZ4tfz/HwscCvRnqgTbJUjdcCqX6M3kk75aLwL9pzSDE+Y5sGyow/4iJ4KC
         8oAEFv7Y9hSUb/BzCYmnLWvkRrv6tBKcOM04UcIB8aA9ZO57oJ95Ys4We8kRNBDUy/or
         WmYZ+p01mZkpHfo6XueBQwo3bbkVAopl2+hCnOJN+Y23BYBXWokHfVtcyXufP8cwG7uS
         BGeg==
X-Gm-Message-State: APjAAAVq1lfW0lheg+neUXD0DDoULS3WvjOwKGkJetzD4gpjTgMmC8fw
        MTEdOq2zYjhkMJPN95bZHhVMQ9RFTsrX0K6dRPU=
X-Google-Smtp-Source: APXvYqwc2/2KD6vd1lQXtY5MwlCpIcLv8nl4MIttMelYEEIE5nhmtxhNYxdovT4cES30OYeuBQQPTw8y7lEcFRMqpbw=
X-Received: by 2002:a1c:7519:: with SMTP id o25mr25391869wmc.70.1574636573521;
 Sun, 24 Nov 2019 15:02:53 -0800 (PST)
MIME-Version: 1.0
References: <CAEEhgEt_hNzY7Y3oct767TGGOHpqvOn4V_xWoOOB0NfYi1cswg@mail.gmail.com>
 <58154d62-7f6e-76ee-94d5-00bfcd255e59@gmx.com> <d9cc411e-804d-d1c4-f65f-60a9c383b690@gmx.com>
In-Reply-To: <d9cc411e-804d-d1c4-f65f-60a9c383b690@gmx.com>
From:   Nathan Dehnel <ncdehnel@gmail.com>
Date:   Sun, 24 Nov 2019 17:02:41 -0600
Message-ID: <CAEEhgEvGA5o4W5q_P-0a+AW_Aze4L8BKmrSDzdAtJDBvfPgKsA@mail.gmail.com>
Subject: Re: How to replace a missing device with a smaller one
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The patch worked. Thanks for the help.

On Mon, Nov 18, 2019 at 1:08 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/11/18 =E4=B8=8B=E5=8D=881:32, Qu Wenruo wrote:
> >
> >
> > On 2019/11/18 =E4=B8=8A=E5=8D=8810:09, Nathan Dehnel wrote:
> >> I have a 10-disk raid10 with a missing device I'm trying to replace. I
> >> get this error when doing it though:
> >>
> >> btrfs replace start 1 /dev/bcache0 /mnt
> >> ERROR: target device smaller than source device (required 100020309196=
8 bytes)
> >>
> >> I see that people recommend resizing a disk before replacing it, which
> >> isn't an option for me because it's gone.
> >
> > Oh, that's indeed a problem.
> >
> > We should allow to change missing device's size.
>
> I have CCed you with a patch to allow user to *shrink* the missing device=
.
>
> You can also get the patch from patchwork:
> https://patchwork.kernel.org/patch/11249009/
>
> Please give a try, since the device size is pretty small, I believe with
> that patch, we can go quick shrink, that means "btrfs fi resize" command
> should return immediately.
>
> Then you can go regular replace, this should save you a lot of IO by
> avoiding the IO/time consuming device removal.
>
> Thanks,
> Qu
>
> >
> >> I'm replacing the drive by
> >> copying from its mirror, so can I resize the mirror and then replace?
> >> How do I do that? Do I need to run "btrfs fi res" on each of the
> >> remaining drives in the array?
> >>
> > As a workaround, you could remove that missing device (which would
> > relocate all chunks using it, so it can be slow).
> >
> > Then add the new device to the fs.
> >
> > With that done, it's recommended to do a convert to take full use the
> > two added devices.
> >
> > Thanks,
> > Qu
> >
>
