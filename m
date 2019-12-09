Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47001164C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 02:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfLIBby (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 20:31:54 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:32771 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfLIBby (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Dec 2019 20:31:54 -0500
Received: by mail-io1-f68.google.com with SMTP id 2so10150544ion.0
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2019 17:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tSXCH0HRTu/VhPmlTBbZvvA6z5XP9epsXVZgBTP9BZk=;
        b=D2tYpe/lS+g7usm9Ff+xaxR6Ef2fd5mnM0eMiJxDw7kEH29PNu8JStpnvP0Co+BemN
         Wk0hCi18gV32Ex43H/INDHYxbVUrCPg2dXidEZAOBC6Lj+XNjpuvJrdfL/c0CGDUuM14
         BswhW/CEGQhq8mRY2trVDXEto1sER05hRICbWa9ddcgHkUcQFSbUAkDHGv87bH5C7jPp
         z4oD6DSA3pfSKGCPBO7WZ8WqO0mG2ydW6MIR1W+DTwJLg+igXwb4+j6ENFTfBspzppWK
         LjSe0wJD8aXhfSMziLuhcH/7njB3S9pmw0de60VrlcNvProVJBKza2peer4c54wo5sC5
         koEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tSXCH0HRTu/VhPmlTBbZvvA6z5XP9epsXVZgBTP9BZk=;
        b=GTdP7tf+rAA3WG3eJAQk+78Tj8LH5nJPgBiU9uBPok2g0kFpuPBmBOJ+1614J2hmQj
         H4THthXbg8ZQ5adbm79VdNeDRV9jv1D+71haGwFKanG/PqtkB/azVEyGoIUPAdBl9NHq
         Wmf7mvfdxAbz6sPnTRGQWDOo4vpwiHys3wvv107bo9GCwKBcl/qIE84h+qAszN9MeAZG
         kOHo/GbC1ry4UQbqm+yH6oMcw157mB9hlHFp4ev24QhSWqPPhG9Ysk9OAzO/GDgHPiQ3
         Jfbh/OSGEeeHoNW5aNlm8t7PD36p55SHjGJo3KQBKi5A2Y443pD8BzdwsAuLY+Mk9LGM
         Htog==
X-Gm-Message-State: APjAAAVIRA2hTW6siw7kcl3hSD4H6nb7jlZzS0+4GM83b6bpaL89P0Xq
        2ydhCkv/lXdRHMjVimZ89MqIJXflGezyD9cQNp0=
X-Google-Smtp-Source: APXvYqziw7APzBxqXe2GiGfpXbOlx8TmfkU6JQnQ3k+Ptt+0uN1bJ0Jr+afvworN0cih+3qzdKQcdQWtmZ1qEaX28iI=
X-Received: by 2002:a6b:b606:: with SMTP id g6mr20173981iof.114.1575855113512;
 Sun, 08 Dec 2019 17:31:53 -0800 (PST)
MIME-Version: 1.0
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
 <5eae7d6d-a462-53f4-df0c-3b273426e2b2@gmx.com> <CAJ0EP40Wj59=CevVnn1rjxoc4CtGqbRjKFBSbU8BsrSjRC48ng@mail.gmail.com>
 <6c3454b9-cc23-d22b-c3a7-59697add9b88@gmx.com>
In-Reply-To: <6c3454b9-cc23-d22b-c3a7-59697add9b88@gmx.com>
From:   Mike Gilbert <floppymaster@gmail.com>
Date:   Sun, 8 Dec 2019 20:31:42 -0500
Message-ID: <CAJ0EP40a6DpTu1YmMtBezun58pfFXhWwYEXpnnGLkup0OvLQPw@mail.gmail.com>
Subject: Re: Unable to remove directory entry
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 8, 2019 at 7:41 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/9 =E4=B8=8A=E5=8D=888:30, Mike Gilbert wrote:
> > On Sun, Dec 8, 2019 at 7:11 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> On 2019/12/9 =E4=B8=8A=E5=8D=883:19, Mike Gilbert wrote:
> >>> Hello,
> >>>
> >>> I have a directory entry that cannot be stat-ed or unlinked. This
> >>> issue persists across reboots, so it seems there is something wrong o=
n
> >>> disk.
> >>>
> >>> % ls -l /var/cache/ccache.bad/2/c
> >>> ls: cannot access
> >>> '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manife=
st':
> >>> No such
> >>> file or directory
> >>> total 0
> >>> -????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351.m=
anifest
> >>
> >> Dmesg if any, please.
> >
> > There's nothing btrfs-related in the dmesg output.
> >
> >>>
> >>> % uname -a
> >>> Linux naomi 4.19.67 #4 SMP Sun Aug 18 14:35:39 EDT 2019 x86_64 AMD
> >>> Phenom(tm) II X6 1055T Processor
> >>> AuthenticAMD GNU/Linux
> >>
> >> The kernel is not new enough to btrfs' standard.
> >>
> >> For this possibility name hash mismatch bug, newer kernel will reporte=
d
> >> detailed problems.
> >
> > Would 4.19.88 suffice, or do I need to switch to a newer release branch=
?
> >
> I'd recommend to go at least latest LTS (v5.3.x).
>
> .88 is just backports, nothing really different. And sometimes big fixes
> won't get backported.

I upgraded to linux-5.4.2, and attempted to remove the file, with the
same results.

ls: cannot access
'/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manifest':
No such
file or directory
total 0
-????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351.manifes=
t

rm: cannot remove
'/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manifest':
No such
file or directory

I don't see any output in dmesg. Is there some option I need to enable?
