Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6733E1E53C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 04:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgE1COq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 22:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgE1COp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 22:14:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2689FC05BD1E
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 19:14:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so26220966wrt.9
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vbwx7gROkccURyG6rti91utFecEh7J3miHGvQsCjKbA=;
        b=XNa2aBrvJWM8+/CLWzS7KNYstyUkUJqa01IePVn9Opl9977xrgKYD3+Z2ongvrH83E
         FuFnxu3O/5KBclb6hyNMCMy+k2mc6Tcmx9F8IJ2W2KvY5q62KVCGqkPOgOqr3HTVp44u
         iIHK9HCWQmkrNgBh3mEI/8NHBjR1Da2mv2yXXkzeT8DHoljv3Yxp596+A4kTV2RXPg1R
         P9Z9fifbAAn95HW3ahPOT/oIkq3STtZ8rJk7wZZi/wGCpAt2UTH0SEeY2q+H5z1+pT4E
         W3keGzdKNg3dse+VZO6E0pBhO8I4N+OxNevBjNVc3ioawhLrfVcg8M5FZMmHmZgfN1Yq
         74HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vbwx7gROkccURyG6rti91utFecEh7J3miHGvQsCjKbA=;
        b=rOllHeURc4ThPfOqD7g0AufGOrXVLYJ1o1msXY2lzFpQcOJRLdLP57Q2r+7Kfzu6tb
         Nra35kpgtoD3pYKpcWNnKCrPSrFdnl3IjGyDyThoejMLNUsr4QUclUXZLtyNAPwtweuj
         eZjA5nXHvriT0v4J6ZG5G2QC+ZjtLnyzzAXPG3/kJELzMbT3sj7+aImLDoDHzU/w3BWl
         mtQOMsYqk0tBFjleva3z2/B/qiSm53lctax2J1Qp/IVw15WK83rymTlX1OY3k9l63pLo
         I/E+qhxaNLSQInGRju5NnWfQFkat5cOmhiOiCo8GbZ2RCvQv9tglzeZalNTIx+tFqf/e
         mwuA==
X-Gm-Message-State: AOAM530uUN/UplP+G4AYj3rOoiDjyZXAyq7aLa/aSsu4XLXMg3aA1LcR
        XgY2jPqFI/Fvc0V1KmVNAN6tUPPpKOQrrq6rp5Sp1w==
X-Google-Smtp-Source: ABdhPJw4a+htjUwx9tb4fOLRQLx9xOjV+syQ8dVZ9Oeo27GKkuZdy8li0ZR1CidKJIFXcQTiAoG1Ritvs81r2+XhmQc=
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr1137324wru.252.1590632082751;
 Wed, 27 May 2020 19:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGAeKut52ymR5WVDTxJgQ=-fZzJ+pU8oVF89p4mBO-eaoAHiKw@mail.gmail.com>
 <CAJCQCtSyJp0LiaO246NcEX-p7rk8-h1NocW4o4rJgN=B1Kwrug@mail.gmail.com>
 <46fa65a3-137b-3164-0998-12bb996c15ef@gmail.com> <CAJCQCtTmcRfrZEtdnUgF0CkFFWDW-d5-LtM4SFKO4F7Xr9ai_A@mail.gmail.com>
 <0d3b740d-a431-cca0-3841-a85e49ffff9e@libero.it> <CAJCQCtTt0cusvmo-W3vUqmWNbGeH1f3JFSD4gLNBE2_38avd9A@mail.gmail.com>
 <a53aaabf-412e-2124-49fd-c995dc5dc473@inwind.it>
In-Reply-To: <a53aaabf-412e-2124-49fd-c995dc5dc473@inwind.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 27 May 2020 20:14:26 -0600
Message-ID: <CAJCQCtS8z50Xcv=+HiwaDbvkcKup4+ArA4Li8363jPYWADhzfw@mail.gmail.com>
Subject: Re: Planning out new fs. Am I missing anything?
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Justin Engwer <justin@mautobu.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 1:51 PM Goffredo Baroncelli <kreijack@inwind.it> wr=
ote:
>
> On 5/27/20 8:40 PM, Chris Murphy wrote:
> > On Wed, May 27, 2020 at 10:23 AM Goffredo Baroncelli <kreijack@libero.i=
t> wrote:
> >>
> >> Hi All,
> >>
> >> On 5/27/20 8:25 AM, Chris Murphy wrote:
> >>> On Tue, May 26, 2020 at 11:22 PM Andrei Borzenkov <arvidjaar@gmail.co=
m> wrote:
> >>>>
> >>>> 27.05.2020 05:20, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>>
> >>>>> single, dup, raid0, raid1 (all), raid10 are safe and stable.
> >>>>
> >>>> Until btrfs can reliably detect and automatically handle outdated de=
vice
> >>>> I would not call any multi-device profiles "safe", at least uncondit=
ionally.
> >>>
> >>> I agree.
> >>>
> >>
> >> Checking the generation of each device should be sufficient to detect =
"outdated" devices. Why this check is not performed ?
> >> May be that I am missing something ?
> >
> > But transid isn't unique enough except in isolation. Degraded volumes
> > are treated completely independently. So if I take a 2x raid1 and
> > mount each one degraded on separate computers and modify them. Then
> > join them back together, how can Btrfs resolve the differences? It's a
> > mess. Yes that is obviously a kind of sabotage. While not literal
> > sabotage, the effect is the same if you have alternating degraded
> > drives in successive boots.
>
> Even tough we can't close all the holes, we can reduce the likelihood of =
a this issue.
>
> Anyway mounting a filesystem with different generation number is wrong. A=
nd the
> fact the we can't prevent all the kind of mismatches doesn't mean that
> we don't have to do anything.

Yep. You're right.

>
> I am thinking about adding a "opt in" check. I.e. if the mismatch happens
> btrfs should raise a warning. If a flag is passed at mount (like
> mount -o prevent-generation-mismatch) and the generations don't match,
> the mount fails.

I wonder about using a compat_flag to set a device as having been
mounted degraded. The next time a mount happens, all devices with
compat_flag degraded set should have identical transids or we know
something is screwy. If there is a device that does not have degraded
flag, and has older transid, there could be some kind of sanity check
to make sure the last 1-3 transids transactions are the same (?) and
if so (a) allow a non-degraded mount, (b) warn, (c) "replay" the
transactions between stale and current, so that all devices are caught
up, similar to the partial rebuild mdadm does using write intent
bitmap as the hint for what needs to be caught up.


--=20
Chris Murphy
