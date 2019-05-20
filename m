Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63230243B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 00:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfETWu7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 18:50:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41075 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfETWu6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 18:50:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so11513524lfb.8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 15:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EShZiUiXXZWendVz3SjhfCEv6drI6u0gc+ucoW0fkfE=;
        b=RunNugyjLTOqo1bA4tNL1uu7vvIHnhnXfx8ruj7iOeyFCrkdVpEbp1cH4/iBisF7bz
         RTw8mbmFdTDiiyHkZNVlqtMykgpAkAx6ka7pexoJxeV/2o+S6ywBVreN4/1FY23qT+lG
         sWHJpofdvboMiTef+nVslPIBPbbYYIZuTPvhhpB3kN12Qg5iIg8oehyvlEwrJw+0yl3h
         7K9PV7unwh0mb+PgAxj/FumfqU+xJkjnBnCdRtxZ/OVcFEPvvvoPtvtYtNBa+OLoSDzW
         r3SVa8+XvEs09TKaSN5XH2fXauqN9hYrzIcnOgycyr5sFk/zq1Sy17qttZ0L2uYyex/B
         giSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EShZiUiXXZWendVz3SjhfCEv6drI6u0gc+ucoW0fkfE=;
        b=WE1EsV2U0Rn4aoUetWWxiPKb9g2GDibqCb37HI4QLqVj/k+YIh5ZKqX+9CytnipTCJ
         enpHhcPpG2gsFdQzw31nujui91w7C9SXBsfsiIVdZbHTMYG2YbASOQ047izVAnjXbn0P
         RB7Tu7Zlom+Zk4r6j270qqZOkrJ7DOok4VFrI/tfyQ89+RRfoRjcoeN0Vr9sj6T2h/mu
         xsWjlOS6zHwjYHc1rFmxiDqd54dd2/M42kG6dsvaZM+zwaAa1HlYkkQIS6PuIGXY+4Jm
         s7aAiOQwchQpLheHFh7TJV1cW52IYXdx65nohCiwfxa521GkXuMsScWwKT3hfJaAgAD2
         D/PA==
X-Gm-Message-State: APjAAAVd76GoqHe0WD5nmxlSNa9OVtB/UysqLQAXlPuTF7Tz0oc702PN
        TTHGqJD+tmNYfJhz8RChJ210sYIuTb40mU7vOnICH4K2YAE=
X-Google-Smtp-Source: APXvYqwpl2pQ3IITEi/cTjK2tsMoYmbVGcnQvB+sPfMZdOzQikQlZ6vv60yaLKX8FLn7yc6FUUE+nJt8b+UuLjMGgt8=
X-Received: by 2002:a19:711e:: with SMTP id m30mr35330366lfc.106.1558392655939;
 Mon, 20 May 2019 15:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <clzY4RoSOURzgBtua3TjQ4WXJzgY3EwTyiaYwt49zFAPIi_jO2nAQ8O2saTwpqHH9x0ISw9AVbWOvVR4hFDIx8_dzlWKAzHwcOtEuwaXzJ8=@protonmail.com>
 <275f7add-382c-bf6d-4cf8-f9823cf55daf@gmail.com> <CAA7pwKM_1uWbu9ECgkqAMXMWTOJm5xH1wvHKFwq+7w=JeQQ7xg@mail.gmail.com>
 <ZBp4TxX3BVubLSjbbtXjztW20HT6YFrXCMMV6IX3xamgZbnpU4KJvO5vs0tcF5po8Ay4KdgGyffZ2DHitm4X4Hm0CFMPCjC2g_HHS9CR51M=@protonmail.com>
 <56ee6d38-d4a8-a62b-4e0d-7568030cdcad@gmail.com> <CAA7pwKPZrwKcpPRvvuhgqxZk6KzC871Pa0gusTCa6oz=W=fqGw@mail.gmail.com>
 <20190520144036.7295329f@samba.org> <CAA7pwKNg18aFZEdgBeTzz7UgVm=bFVVNcHD2Ns_75kGqrGf9xQ@mail.gmail.com>
In-Reply-To: <CAA7pwKNg18aFZEdgBeTzz7UgVm=bFVVNcHD2Ns_75kGqrGf9xQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 20 May 2019 16:50:44 -0600
Message-ID: <CAJCQCtQkb4apb261GrDbDvRB-n1n5gdgeTAE=vyRwoCyOz9aiA@mail.gmail.com>
Subject: Re: Btrfs remote reflink with Samba
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     Samba Technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 20, 2019 at 2:35 PM Patrik Lundquist
<patrik.lundquist@gmail.com> wrote:
>
> On Mon, 20 May 2019 at 14:40, David Disseldorp <ddiss@samba.org> wrote:
> >
> > On Mon, 20 May 2019 14:14:48 +0200, Patrik Lundquist wrote:
> >
> > > On Mon, 20 May 2019 at 13:58, Austin S. Hemmelgarn <ahferroin7@gmail.com> wrote:
> > > >
> > > > On 2019-05-20 07:15, Newbugreport wrote:
> > > > > Patrik, thank you. I've enabled the SAMBA module, which may help in the future. Does the GUI file manager (i.e. Nautilus) need special support?
> > > > It shouldn't (Windows' default file manager doesn't, and most stuff on
> > > > Linux uses Samba so it shouldn't either, not sure about macOS though).
> > >
> > > The client side needs support for FSCTL_SRV_COPYCHUNK. Nautilus uses
> > > gvfsd-smb which in turn uses the Samba libs, but I have no idea if it
> > > works. Maybe David Disseldorp knows?
> >
> > libsmbclient copychunk functionality was added via:
> > https://git.samba.org/?p=samba.git;a=commit;h=f73bcf4934be
> > IIRC, it was added with the intention of being used by Nautilus.
> > That said, I've not tried it myself, and I don't see any reference to
> > splice in:
> > https://gitlab.gnome.org/GNOME/gvfs/blob/master/daemon/gvfsbackendsmb.c
> > (Perhaps I'm looking in the wrong place?).
>
> https://gitlab.gnome.org/GNOME/gvfs/issues/286 is unfortunately
> blocked by https://bugzilla.samba.org/show_bug.cgi?id=11413
>
> I don't know if Nautilus tries reflink copying on a cifs mounted Samba
> share but Mr. Newbugreport can at least move around (ctrl-x, ctrl-v)
> files in Nautilus within the same share without making new copies.


I just did ctrl-c, ctrl-v for a file in one dir to another dir, and it
takes forever. It's clearly being copied over the network to my local
machine and then pushed back to the server. Three minutes to copy a
2GiB file.

Server side:
kernel 5.1.0-1.fc31.x86_64
samba-4.9.5-0.fc29.x86_64
smb.conf contains 'vfs objects = btrfs' for this share

Client side:
samba-client-4.10.2-1.1.fc30.x86_64
gvfs-smb-1.40.1-2.fc30.x86_64
nautilus-3.32.1-1.fc30.x86_64



-- 
Chris Murphy
