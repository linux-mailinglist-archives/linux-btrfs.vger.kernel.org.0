Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF9E848AB
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfHGJdb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 05:33:31 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:45953 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfHGJdb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 05:33:31 -0400
Received: by mail-ua1-f45.google.com with SMTP id v18so34773103uad.12
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2019 02:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=68dQ8DZwexQ2XPpE3eeeWQs9+e6hC59SFvct/0e6aeQ=;
        b=ZBujlxqPuccgAtLgp62jOFnxOw8PecQhtqxb7h5HWcebOYHH0et7Apj4HwFAQtKL6X
         TL0lHUT1Of/+XFhNdPWYnN7IEfiJ26Xy6lPZfwYlXt4Bn9H2K1ACOmaXcRFYCcrR5uny
         gHJJiq4sOAF/BqemtOC3Q5Yf1RIBlUZBHiiXIRrCxOXdQKiS3PfFLIbMpv8z+yQ0/pWY
         ORWcRtHvsY4PEU7lXjhE4Lkgej5k9SjAoWFf+E8UxIOLBmAy+udhbTpccvkDpoqMDfhn
         25BSmpB2iLsiVrKKlI4GTFqqlmaVBzR9h46xlzmTgvhwbIUSpdF8nqC8cCpSJTjTau19
         8ASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=68dQ8DZwexQ2XPpE3eeeWQs9+e6hC59SFvct/0e6aeQ=;
        b=nYNtOV/25VaXSNCQw2JYkmd0spMPUH5AoKtEZmwggDCfsNk5VW8WVVd1833OSd+0wy
         8HiugsxzaLn/z90u5xO1iI92/mXLtsBTsdFlCl+R4TUoImrRHYW1V4WSA5S6vQ7rdzIC
         6ooTHLMFL9D8TNn/NvrkewhOcfRKka9WyLK+xVPX19EeRNic18ETyAJdbjFi3+QTFIAy
         mdIkt/cGC0dyZJ0RGlpu9Eznbeqx88CFUMzlDKfbQW2Kecnfie3Dgqnp5kfIIyICzKQU
         Zn8a5lN0IdiSfUdpOK7zNeT/rPHvc9hIrzmDn5J1Gw/O0Axymtu4MHmeMDZi6Eq/IZIc
         cXlA==
X-Gm-Message-State: APjAAAU1fEtu/J5fYi0wLUe0jKhKh0ptG+JD7WJJDUeqvoiA+NCCoCIc
        frLMHGmG4iEVX2Z2iyIDaTQDmbbjuSd7Wd7EOaWRGg==
X-Google-Smtp-Source: APXvYqzUT/RqlVWDCxQCJDkXSpUOyWFs/OdPrc9Hku3WKxIHyzeEwDHOTCerl/M1HzskQozzByKgWaLwxjD7Vp1uw68=
X-Received: by 2002:ab0:3359:: with SMTP id h25mr5168276uap.132.1565170410393;
 Wed, 07 Aug 2019 02:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <CACa3q1zdz9XHGzkrhyfACo58iRBWMRGPzbQTebaN3aU0HLJxgw@mail.gmail.com>
 <20190807090426.GH24125@savella.carfax.org.uk>
In-Reply-To: <20190807090426.GH24125@savella.carfax.org.uk>
From:   Jon Ander MB <jonandermonleon@gmail.com>
Date:   Wed, 7 Aug 2019 11:33:19 +0200
Message-ID: <CACa3q1yonNJY+74XfwoUxq_8ahcTjaSgO76auMt7Oe9NT2TpFg@mail.gmail.com>
Subject: Re: Unable to delete or change ro flag on subvolume/snapshot
To:     Hugo Mills <hugo@carfax.org.uk>,
        Jon Ander MB <jonandermonleon@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi! Thanks for the reply!
First: I am (g)root,, yes :)
Second: The snapshot was taken in ro mode, the fs is not ro and the
rest of the snapshots and volumes work as intended (rw)

Thanks

On Wed, Aug 7, 2019 at 11:04 AM Hugo Mills <hugo@carfax.org.uk> wrote:
>
> On Wed, Aug 07, 2019 at 10:37:43AM +0200, Jon Ander MB wrote:
> > Hi!
> > I have a snapshot with the read only flag set and I'm currently unable
> > to delete it or change the ro setting
> > btrfs property set -ts /path/t/snapshot ro false
> > ERROR: failed to set flags for /path/t/snapshot: Operation not permitte=
d
> >
> > Deleting the snapshot is also a no-go:
> >
> > btrfs subvolume delete /path/t/snapshot
> > Delete subvolume (no-commit): '/path/t/snapshot'
> > ERROR: cannot delete '/path/t/snapshot': Operation not permitted
>
>    First question: are you running those commands as root?
>
>    Second question: has the FS itself gone read-only for some reason?
> (e.g. corruption detected).
>
>    Hugo.
>
> >
> > The snapshot information:
> >
> > btrfs subvolume show /path/t/snapshot
> > /path/t/snapshot
> >         Name:                   snapshot
> >         UUID:                   66a145da-a20d-a44e-bb7a-3535da400f5d
> >         Parent UUID:            f1866638-f77f-e34e-880d-e2e3bec1c88b
> >         Received UUID:          66a145da-a20d-a44e-bb7a-3535da400f5d
> >         Creation time:          2019-07-31 12:00:30 +0200
> >         Subvolume ID:           23786
> >         Generation:             1856068
> >         Gen at creation:        1840490
> >         Parent ID:              517
> >         Top level ID:           517
> >         Flags:                  readonly
> >         Snapshot(s):
> >
> >
> > Any idea of what can I do?
> >
> > Regards!
> >
>
> --
> Hugo Mills             | I'm all for giving people enough rope to shoot
> hugo@... carfax.org.uk | themselves in the foot.
> http://carfax.org.uk/  |
> PGP: E2AB1DE4          |                                        Andreas D=
ilger



--=20
--- Jon Ander Monle=C3=B3n Besteiro ---
