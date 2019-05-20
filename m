Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61EA224227
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 22:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfETUeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 16:34:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54743 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfETUeH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 16:34:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so666551wml.4
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2Yl5p6SJlDVyOlYBQh8YK93EPkZ4GSo/Fy98kA946E=;
        b=I7B+QE0Ff8ZzE5bx8r3wQLlKIpP+ysGV6G3vv3XLfUg0Qn6bFEuZ0WmeHy57ZPkj2J
         /HC+E3BKY/+Fk/trFXysdbh/1yTTTyY8JuUMZ2N1bfbIeSNPtbq8w56YnHDKEA0Fnr8Q
         tLuGsccMzh1taZdPmt+Ih+DOlyIXxc3kE7/K4lj+ybI21Xc6RTRuuh3ud9J3QGB1JIwh
         LCmDliObJN5FudIjnSag4swlaXpNzspC0bUpodCpKZlEhH2vq3eV8/j10ewEf41Aauln
         wwM9tGClrShC8XoHd8ImhTviTPDkXMV9uthw5MMFfYTKECPV/C6B3+Z9nAIfAjf+g9Ny
         6o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2Yl5p6SJlDVyOlYBQh8YK93EPkZ4GSo/Fy98kA946E=;
        b=sqoE23FDusTzZl/5gPBuW9AjSSxpv8YA2wNiMt7RE1r2w6M2VLkkrJB02UyTFTthBb
         zpxbyHTh5IeBZZ4CtAvGucen2tgXd0k03/U2A0oCJRMngyUsLyKKzI88fFLOtNJblGv4
         6Wg2LrUBVBL20AUa8dmYib3dsIbFY1dgMWNAL1z07Nmar+dcgcHXZYYsZM8XwGYJUZ6D
         KSlNw6h/AtcFbHgCN0HMBtqVM96R9jVn4Hcmjt8qR5IwYVQUc51Vqrk2ey0kSYOI6zT4
         fjJLRNSHreEGv7xsD8X0PUJotVzKn+CE+DilhAHIcn3jJ4RFt9QNjJdqP3ZZDQKLNMGM
         Bd0g==
X-Gm-Message-State: APjAAAW0HB89KgfsoUxkGOw/O3BUKMUf8WS1ps1Ur+31Kk09YrmBr6jW
        5LEgkfYRy99LJHR+roI3P7mdGV4Pwmyz8e74IG0=
X-Google-Smtp-Source: APXvYqwN/ynBixlzr3QVX6FvrG9aPNsgLCMjH3HOAdNDfK9R4OLMbDB9HXQFMZV95vcKCLL4SOiFBb4gppSDNCGzWJI=
X-Received: by 2002:a1c:9dc7:: with SMTP id g190mr644882wme.121.1558384445053;
 Mon, 20 May 2019 13:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <clzY4RoSOURzgBtua3TjQ4WXJzgY3EwTyiaYwt49zFAPIi_jO2nAQ8O2saTwpqHH9x0ISw9AVbWOvVR4hFDIx8_dzlWKAzHwcOtEuwaXzJ8=@protonmail.com>
 <275f7add-382c-bf6d-4cf8-f9823cf55daf@gmail.com> <CAA7pwKM_1uWbu9ECgkqAMXMWTOJm5xH1wvHKFwq+7w=JeQQ7xg@mail.gmail.com>
 <ZBp4TxX3BVubLSjbbtXjztW20HT6YFrXCMMV6IX3xamgZbnpU4KJvO5vs0tcF5po8Ay4KdgGyffZ2DHitm4X4Hm0CFMPCjC2g_HHS9CR51M=@protonmail.com>
 <56ee6d38-d4a8-a62b-4e0d-7568030cdcad@gmail.com> <CAA7pwKPZrwKcpPRvvuhgqxZk6KzC871Pa0gusTCa6oz=W=fqGw@mail.gmail.com>
 <20190520144036.7295329f@samba.org>
In-Reply-To: <20190520144036.7295329f@samba.org>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Mon, 20 May 2019 22:33:52 +0200
Message-ID: <CAA7pwKNg18aFZEdgBeTzz7UgVm=bFVVNcHD2Ns_75kGqrGf9xQ@mail.gmail.com>
Subject: Re: Btrfs remote reflink with Samba
To:     David Disseldorp <ddiss@samba.org>
Cc:     Newbugreport <newbugreport@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Samba Technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 20 May 2019 at 14:40, David Disseldorp <ddiss@samba.org> wrote:
>
> On Mon, 20 May 2019 14:14:48 +0200, Patrik Lundquist wrote:
>
> > On Mon, 20 May 2019 at 13:58, Austin S. Hemmelgarn <ahferroin7@gmail.com> wrote:
> > >
> > > On 2019-05-20 07:15, Newbugreport wrote:
> > > > Patrik, thank you. I've enabled the SAMBA module, which may help in the future. Does the GUI file manager (i.e. Nautilus) need special support?
> > > It shouldn't (Windows' default file manager doesn't, and most stuff on
> > > Linux uses Samba so it shouldn't either, not sure about macOS though).
> >
> > The client side needs support for FSCTL_SRV_COPYCHUNK. Nautilus uses
> > gvfsd-smb which in turn uses the Samba libs, but I have no idea if it
> > works. Maybe David Disseldorp knows?
>
> libsmbclient copychunk functionality was added via:
> https://git.samba.org/?p=samba.git;a=commit;h=f73bcf4934be
> IIRC, it was added with the intention of being used by Nautilus.
> That said, I've not tried it myself, and I don't see any reference to
> splice in:
> https://gitlab.gnome.org/GNOME/gvfs/blob/master/daemon/gvfsbackendsmb.c
> (Perhaps I'm looking in the wrong place?).

https://gitlab.gnome.org/GNOME/gvfs/issues/286 is unfortunately
blocked by https://bugzilla.samba.org/show_bug.cgi?id=11413

I don't know if Nautilus tries reflink copying on a cifs mounted Samba
share but Mr. Newbugreport can at least move around (ctrl-x, ctrl-v)
files in Nautilus within the same share without making new copies.
