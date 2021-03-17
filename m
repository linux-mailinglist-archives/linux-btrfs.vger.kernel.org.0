Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B023E33F9C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 21:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhCQUHS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 16:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhCQUGp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 16:06:45 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404F6C06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 13:06:44 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id c131so204714ybf.7
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pgZJm2mwust/lWYp28t0kU5O7mKQUtNWjwu7HmjoeOI=;
        b=KgmOcZcwacr+9BSuGePZkg5wOBNPil5yfFpCj8qgst4Fjd/3R5Gq+t4DJIFFToHr0Q
         trwQJ6uHTZTW7DNzI71h/8HLBRZjEbfnvQMhCfP+CkIxJl0qhymeKuiiY4Ig3Xc0lQ/+
         RPnAucwDffsSKbdCYoTZRP3cwvv9cQ8JBK3Fka+vUuuodHJrt0Bi6lLklp6aeJk2a8/W
         ck+t/XTgrX6Y+LHQNptTOSG6AHcfcX5NVpYvebCAgSRd8sKfqme99U3ADGYBgVCXxHiE
         LrnU8E3x871J/ZPJZpv9Wla8d7HVwsDj0fHm5+E0G5R/HzgEX5QzsKphLPXPOoJ+LlaD
         FEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=pgZJm2mwust/lWYp28t0kU5O7mKQUtNWjwu7HmjoeOI=;
        b=ClW8IkITGz7jCsTn/c0/1/y7zqLoWryD/pSJHRfyRmRek237EEIq5SuTlt27C4DDom
         PaYSbkwwx4Nm2b9vnB61+VTOa4E9zqLxQa9sJYWq5B94CxQf+FNFCWJ8Iq6h+Ksu2KJI
         hPomX3n8vnPflgtRn0Y1t3D/BEVLqar2uabLDITIz+A5HHXsDhd1PsRzsUzxKeuKG9lL
         e5htWuSs8lCqPtZKZ/sbWhShhJ1ZCHW9rqf+vMNWdJQvP0PZUlQjFgx/3c/z0L91GSrj
         WLDBG1TAiblQYlCw9JQd9dsRgp/Bgxn/SCyPoMwO1Si8pVuu4/YQhMVl5Onjt2JCoUTh
         aL+g==
X-Gm-Message-State: AOAM5337WiYvU37ZHf6jjC6rhZBMGogElVVltuX340+6fwm0aDsM6Vnh
        zJqkEGUSClu5GxUplxIXuom5lX4JTOL9m3pncV0=
X-Google-Smtp-Source: ABdhPJz0hXssI9zo5SI2/0FhrZ9qh+Xi3unHs70act/vGrIFbsqr65rTKQmPQThpg4C3qIij/TJrQ6+SLTy12/fp+MM=
X-Received: by 2002:a25:7bc7:: with SMTP id w190mr7354474ybc.184.1616011603609;
 Wed, 17 Mar 2021 13:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <YFHtnGvRH+QlwRN6@angband.pl> <20210317141733.GR7604@twin.jikos.cz>
In-Reply-To: <20210317141733.GR7604@twin.jikos.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 17 Mar 2021 16:06:07 -0400
Message-ID: <CAEg-Je93K1d3U0Gvaff4cESReTexw3X4U_t3wQ5_tO5+DMfOYQ@mail.gmail.com>
Subject: Re: Fwd: btrfs-progs: libbtrfsutil is under LGPL-3.0 and statically
 liked into btrfs
To:     dsterba@suse.cz, Adam Borowski <kilobyte@angband.pl>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Stefano Babic <sbabic@denx.de>,
        King InuYasha <ngompa13@gmail.com>,
        Claudius Heine <ch@denx.de>,
        Omar Sandoval <osandov@osandov.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 17, 2021 at 10:19 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Mar 17, 2021 at 12:53:00PM +0100, Adam Borowski wrote:
> > This is https://bugs.debian.org/985400
> >
> > ----- Forwarded message from Claudius Heine <ch@denx.de> -----
> >
> > Dear Maintainer,
> >
> > I looked into the licenses of the btrfs-progs project and found that th=
e
> > libbtrfsutils library is licensed under LGPL-3.0-or-later [1]
> >
> > The `copyright` file does not show this this.
> >
> > IANAL, but I think since `btrfs` (under GPL-2.0-only [2]) links to `lib=
btrfsutil`
> > statically this might cause a license conflict. See [3]. This would be =
the part
> > that might require upstream fixing.
>
> Thanks for bringing it up.
>
> > [1] https://github.com/kdave/btrfs-progs/blob/master/libbtrfsutil/btrfs=
util.h
> > [2] https://github.com/kdave/btrfs-progs/blob/master/btrfs.c
> > [3] http://gplv3.fsf.org/dd3-faq#gpl-compat-matrix
>
> As explained in that link
>
>  "Use a library" means that you're not copying any source directly, but
>  instead interacting with it through linking, importing, or other
>  typical mechanisms that bind the sources together when you compile or
>  run the code.
>
> the static link applies and the licenses do not allow that. So what are
> the options:
>
> - relicense libbtrfsutil to LGPL v2.1 or later
> - relicense libbtrfsutil to LGPL v2.1 only
>
> There was another request to relicense it
> https://lore.kernel.org/linux-btrfs/b927ca28-e280-4d79-184f-b72867dbdaa8@=
denx.de/
>
> I'm not aware of any objections to relicensing, it hasn't happend in
> 5.11 due to time reasons but I think 5.12 is feasible.
>
> If there's anybody willing to drive the process please let me know. The
> mpv project did relicensing as well and we can draw some inspiration
> from there https://github.com/mpv-player/mpv/issues/2033 . It took them
> like 5 years but the number of contributors we'd need to ask is small and
> most of them are known so it should not take more than a month.

Relicensing request has been sent to the mailing list:
https://lore.kernel.org/linux-btrfs/20210317200144.1067314-1-ngompa@fedorap=
roject.org/T/


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
