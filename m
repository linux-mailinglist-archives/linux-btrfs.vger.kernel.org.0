Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA985095
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 18:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbfHGQFG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 12:05:06 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:54918 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbfHGQFG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 12:05:06 -0400
Received: by mail-wm1-f44.google.com with SMTP id p74so578048wme.4
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2019 09:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=os1j2v0OzqNyZP4Do8aOajz4ycm6D66TavoYbcZ1Do4=;
        b=BlOp5Zosld1UtHZBsOLRZmQhIO+jO4N8DPzD7aJrK9sa15jd7rbeVc+MxUIY8VPoyt
         CJTz18noIRZeymClSD2+7F+8ADhkDVxjw6dAwZGaKJ3ZyBO8klbc/hYruWnATYwgKeps
         ARhwJR67on0G+UGV33jsHrfAV+rAn949sCyL7VIeNdJc70IHSsyMUn9xA08PvkM2dXCE
         SFlhgNCVuzgnNMXaM2cwlmlWK/4MaFRsDCTtpygVQhQl2fOOMCklSzbciKzTSGFZzNKs
         PkD6hA2ayRk7KotRtqpj4NPyocxckI+QGUrqcL7s2SizjMYNk6GQrFyFidMcNrdpaYi0
         tT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=os1j2v0OzqNyZP4Do8aOajz4ycm6D66TavoYbcZ1Do4=;
        b=M2khar3Nm9Z9qApmzSlwxl1kxtfK38yVTCv5lchBYypLR0zjV1bJ4/TzYig8aG8L4g
         NuEKOB26R551RXqOtoIhG6qHjCrbcYxB6KUzkwp+rGGQfj7V3BZ64VSI3iTnMky71YDn
         9iYd1C0j/dHPezVZHT7MzX4kWLxRb3OaG+7bk3e09k9LXEJQ4nt5OPy+h/RaMX09PtzQ
         G/7cQRqJFuTKj26JKpSKR1ml4rP/30KFODpgrhQR3PZ5W71N/ieXADLPRwRz7+glKk9C
         flhlX/S/h3lM1JjJ9VcSiFRegXKo+MsmraUTa3T56YqK7ADebImxhy4nyOb/paKMWvVP
         jaSQ==
X-Gm-Message-State: APjAAAU1HO5EWpcxovUqa4Nu1/uylWkI95c+y+Q40AJAhez2AdFTIpo1
        i6IHv+cN2hvcSDxSzUuG3iElPe/mLgTM96rs+02MvQ==
X-Google-Smtp-Source: APXvYqxsvs+FEB3IceK5VZ1vZcPGaHeA/6+7hIK/qvBexA3MDURBet0DOCqwp6YfvfRLPIsbjbBYrLCERKRR9UDF/Tc=
X-Received: by 2002:a1c:f409:: with SMTP id z9mr653199wma.176.1565193904142;
 Wed, 07 Aug 2019 09:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACa3q1zdz9XHGzkrhyfACo58iRBWMRGPzbQTebaN3aU0HLJxgw@mail.gmail.com>
 <20190807090426.GH24125@savella.carfax.org.uk> <CACa3q1yonNJY+74XfwoUxq_8ahcTjaSgO76auMt7Oe9NT2TpFg@mail.gmail.com>
In-Reply-To: <CACa3q1yonNJY+74XfwoUxq_8ahcTjaSgO76auMt7Oe9NT2TpFg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 7 Aug 2019 10:04:53 -0600
Message-ID: <CAJCQCtTBSRQ-b2HudtzmR-XAaB7BuVR9=6CLdCf5EqBP0TWtFg@mail.gmail.com>
Subject: Re: Unable to delete or change ro flag on subvolume/snapshot
To:     Jon Ander MB <jonandermonleon@gmail.com>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 7, 2019 at 3:33 AM Jon Ander MB <jonandermonleon@gmail.com> wrote:
>
> Hi! Thanks for the reply!
> First: I am (g)root,, yes :)
> Second: The snapshot was taken in ro mode, the fs is not ro and the
> rest of the snapshots and volumes work as intended (rw)
>
> Thanks
>
> On Wed, Aug 7, 2019 at 11:04 AM Hugo Mills <hugo@carfax.org.uk> wrote:
> >
> > On Wed, Aug 07, 2019 at 10:37:43AM +0200, Jon Ander MB wrote:
> > > Hi!
> > > I have a snapshot with the read only flag set and I'm currently unable
> > > to delete it or change the ro setting
> > > btrfs property set -ts /path/t/snapshot ro false
> > > ERROR: failed to set flags for /path/t/snapshot: Operation not permitted
> > >
> > > Deleting the snapshot is also a no-go:
> > >
> > > btrfs subvolume delete /path/t/snapshot
> > > Delete subvolume (no-commit): '/path/t/snapshot'
> > > ERROR: cannot delete '/path/t/snapshot': Operation not permitted
> >
> >    First question: are you running those commands as root?
> >
> >    Second question: has the FS itself gone read-only for some reason?
> > (e.g. corruption detected).
> >
> >    Hugo.
> >
> > >
> > > The snapshot information:
> > >
> > > btrfs subvolume show /path/t/snapshot
> > > /path/t/snapshot
> > >         Name:                   snapshot
> > >         UUID:                   66a145da-a20d-a44e-bb7a-3535da400f5d
> > >         Parent UUID:            f1866638-f77f-e34e-880d-e2e3bec1c88b
> > >         Received UUID:          66a145da-a20d-a44e-bb7a-3535da400f5d
> > >         Creation time:          2019-07-31 12:00:30 +0200
> > >         Subvolume ID:           23786
> > >         Generation:             1856068
> > >         Gen at creation:        1840490
> > >         Parent ID:              517
> > >         Top level ID:           517
> > >         Flags:                  readonly
> > >         Snapshot(s):
> > >
> > >
> > > Any idea of what can I do?

Maybe strace the failing command, and see if that provides a hint
what's going on?

-- 
Chris Murphy
