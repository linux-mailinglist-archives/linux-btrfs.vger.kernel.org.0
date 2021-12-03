Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF1467D7A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 19:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343511AbhLCSv1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 13:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhLCSv1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 13:51:27 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F1C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 10:48:03 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id f186so12018738ybg.2
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=irB/TBOeiy4LP0q5AC4F6/+qe3qwsWSNrjzp79E3FVA=;
        b=xRt8HYnAGYoNiOWZaJr3ZDONSphHp0LB5UDBnYjWmCFT4V/mnBftQZ/571BXhrKJoH
         dnrOvfp5jtTvK16CZWTEwblmskx72K0RXSUZ7nlwEaohaSsCdeqjUqzUGYFisjMdZOYv
         QM8fDf6woyAl7lSLIEKc0RXAMFlRPpNtdG+JiP8uaIADL6NdzL4WwJwHoAAX1XH7rl/w
         d9+VWT18b1LPac/tegJy8HA0xhQGSn0mnBYpkrz9p3kLIHliVRSkjcL6ZqSg7lovy3Qe
         DeBGsy3SaO3aG3mLSQJaXGcstMh/P0yYf6JRAv2Wsf/2Ehou9AV0xzDQV0ozEgwPveiD
         ikUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=irB/TBOeiy4LP0q5AC4F6/+qe3qwsWSNrjzp79E3FVA=;
        b=PDIhGIk/MNCetUZcSvl7T6ye+UuFLGQmAcG5pbwZE7wDTkGgFXjGtnvM1d8lxUfolb
         Gr6kFQLvFA4az+cD3oqTccI+wsTBjluCUdFgcAdbx25L/DmrBYSf0imtnArGR9VvgJ+B
         O91UdKETgsHinrv+n2U+Kj6JRCGk1IE079aBskLFE47rMQsYyq7pG2uLBuvjc+2WMYsb
         xQN47t9R4xO0rmtDOf6V0y3kI7EcQazHHY5OAgkeGhBiFmXr5eX0gJeLzf0XZV958oiv
         Z+Bnan5hqPp53vBlxU34wy/LhHN8fHwrnRwYCxN1n5jVRxqPqZlZx29unkG18lM/g8x1
         1rNg==
X-Gm-Message-State: AOAM533NwbXHlYFwN7L9LCsggYi6GbIhbX73nBCmYXMZvceFkDSWbhD4
        v17tC2D3gOJNd+u6PV38ZKsjeCqscc5c+HpjATro0w==
X-Google-Smtp-Source: ABdhPJwhkXJtit+ViHrQuttrmVO0uH8R7lH5hV4vr1HS2G3yFA/fbgh/J6hxyFnynuzBfV2l+/KeQZ7d83b2r8M7uwQ=
X-Received: by 2002:a25:e543:: with SMTP id c64mr23107676ybh.239.1638557282375;
 Fri, 03 Dec 2021 10:48:02 -0800 (PST)
MIME-Version: 1.0
References: <MpesPIt--3-2@tutanota.com> <87r1azashl.fsf@vps.thesusis.net> <MpgNwtq--3-2@tutanota.com>
In-Reply-To: <MpgNwtq--3-2@tutanota.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 3 Dec 2021 13:47:46 -0500
Message-ID: <CAJCQCtSdahBGz1c4B4Lm2kp+=a+P_zkqnxz7b4yMuLunw7oS8w@mail.gmail.com>
Subject: Re: Connection lost during BTRFS move + resize
To:     Borden <borden_c@tutanota.com>
Cc:     Phillip Susi <phill@thesusis.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 29, 2021 at 10:52 AM Borden <borden_c@tutanota.com> wrote:
>
> 29 Nov 2021, 10:26 by phill@thesusis.net:
> > The only tool I know of that can do this is gparted, so I assume you ar=
e
> > using that.  In this case, it has to umount the filesystem and manually
> > copy data from the old start of the partition to the new start.  Being
> > interrupted in the middle leaves part of the filesystem in the wrong
> > place ( and which parts is unknowable ), and so it is toast.  This is
> > one area where LVM has a significant advantage as its moves are
> > interruption safe and automatically resumed on the next activation of
> > the volume.
> >
> This is the answer that I anticipated, and it's good to know now so I don=
't destroy data that I _cannot_ afford to lose later. So thank you.
>
> For my own education/curiosity/intellectual banter: ddrescue, badblocks, =
rsync and other utilities have log files that track progress and allow it t=
o resume if it's interrupted. Since resize operations work in the linear pr=
ocess you described, how hard would it be, theoretically, to implement a "n=
eedle position" in a move operation to allow a move to pick up where it lef=
t off?

Trivial as a thought exercise, and not difficult for someone who can
do some scripting or coding. Do a block by block comparison to find
out where the "forward" (new location) writes ended. You can make a
bunch of assumptions that at the moment of failure, only a specific
contiguous set of sectors were in the process of receiving writes. So
it's just a matter of finding where it left off. Optimization:
probably some minimal sampling you could do to get in the ballpark
then tighten it up to a block by block to find out exactly where it
stopped.

Instead of resuming the move, you can just use some device mapper
commands to create a range (offset+length) for the two segments and
make the two appear in a single virtual device (i.e. you delete the
gap between the new range and old range). And now you can mount it and
do whatever you want, back it up somewhere.

> Obviously, it wouldn't be 100% perfect, but if a recovery utility could l=
ook at the disk and say "partition starts here, skip a bit somewhere in the=
 middle, continue here, stop there," surely that would be more efficient th=
an trying to recover files with a low-level utility?

Yes.


--=20
Chris Murphy
