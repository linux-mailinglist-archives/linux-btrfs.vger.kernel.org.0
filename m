Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0D21C51E
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jul 2020 18:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgGKQQl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jul 2020 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgGKQQl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jul 2020 12:16:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8CBC08C5DD
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 09:16:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a6so10518276wmm.0
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=teHR+Mbi25ZrcwxHJN5rOBgLfpkeFI4h8KNBGtAunjE=;
        b=BmQVm7xmGf0QDkOIA05Uxm7tCMF7zZrreilipLMXgktxqIpQWnaoQqJcuwtvFTDVaj
         5J2zFn5TD+Y2GqbnlhZ9TKBI2IA/5iFIhJtP3OEFDJ9hMH8PTeJsBDVlif2BnI4ALemF
         BUGuP+CZ/mRlyUMe42MbqsSUwmxCCCjWmpJHtTuMJWBT07U6qpue9qVuFh//xXrmcVcM
         +zz8VF3YMTXR5uJX/E3NOzUXiix4i09GisoeiKWolGDW9g+ucswotX4GNAZclIRqrpxx
         qDtMmPj2R/6VpcluWCLWbKX+d4lQzWHJlr6qN6bx/p03PGIDu0HhiUlc9Ie4NWWsaAOy
         YeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=teHR+Mbi25ZrcwxHJN5rOBgLfpkeFI4h8KNBGtAunjE=;
        b=f73PfshKWROarbRW5M52wNxUI/wb8ppM1YUg+10xSRxC0rU4E9WcQqef4cRRylG+jc
         yGv++BMWnjZqwLRVelBAEskuTyXfpLQPAJSfyV4pT51nqoDv1vTOXwQUd03i6PVcT74r
         00W/LbjYF99eZ0FO3x3ntw7rqUXcZra5ND8ZXdvMkBsMqlcvwzDAJfbxWP755Tmn+ek/
         MKqG51A6e/0v93Y3zKeovaiPNKTWfFFSoLsPa6AzB2fbdfGWCdPjqULq9kssw1QXNqN+
         BASJHb51CdnrLaP2URhkkhKd9P5insNyJO/FyE4KB3gqiDhwq2U/ir3sEbdnexd2SPC7
         513A==
X-Gm-Message-State: AOAM530jz7NTTONuC/W5NBdMh286k0XUf+EAEddpYZkLcaT64ZX8fuQ4
        r64dNQcU05srCnmPaCT7qiXsVOYSh3y4U3qQsa+A5g==
X-Google-Smtp-Source: ABdhPJzbMZ53XmK3oawUsIbemKyox3DgcG3286ZzgtdLDoH+PyqghH7V4aPz7SjWs20LlJ6c89iuVh6ByNOGjjPTJ0k=
X-Received: by 2002:a1c:e383:: with SMTP id a125mr10732735wmh.11.1594484199303;
 Sat, 11 Jul 2020 09:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRfXy9YDqZQgYz0_djd78oEMwiYY7Og2x=J=w361FENWg@mail.gmail.com>
 <7f9a8467-6b03-6699-f124-2833fffef4ab@gmail.com>
In-Reply-To: <7f9a8467-6b03-6699-f124-2833fffef4ab@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 11 Jul 2020 10:16:23 -0600
Message-ID: <CAJCQCtS7cYVDQ9mn3BrsO=OFPt=05ZgZEer=g2=1vGjHPLCREw@mail.gmail.com>
Subject: Re: raid0 and different sized devices
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 11, 2020 at 12:28 AM Andrei Borzenkov <arvidjaar@gmail.com> wro=
te:
>
> 11.07.2020 04:37, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Summary:
> >
> > df claims this volume is full, which is how it actually behaves. Rsync
> > fails with an out of space message. But 'btrfs fi us' reports
> > seemingly misleading/incorrect information:
> >
> >     Free (estimated):          12.64GiB    (min: 6.33GiB)
> >
> > If Btrfs can't do single device raid0, and it seems it can't, then
> > this free space reporting seems wrong twice. (Both values.)
> >
>
> This space can be used with single or dup profiles so it is actually
> correct (second number being for dup). It would of course be nice to get
> extended output "how much space for each profile", but as "estimation of
> theoretical free space" it is absolutely correct.
>
> Of course I do not know whether it is correct by design or by coincidence=
 :)

I also wonder about the effect of metadata raid1 in this case. For
sure it can't allocate another raid1 chunk, even if raid0 profile were
able to support single stripe raid0 block groups on a single device.

And in fact we end up with a weird situation where premature out of
space can still happen with -d single -m raid1. What should be true is
data block groups are only created on the large device, in effect
making the small device metadata only. But since in this extreme
example it's only ~700M, it's just a matter of time before we're in
metadata exhaustion because there's no fall back to single metadata.

This is a peculiar case in a VM, where it's easy to create such
(somewhat) contrived scenarios. In the real world we're not likely to
see these kinds of problems, I think. A 2G device is rare indeed, let
alone matched with a ~16 GiB device. We could also argue the UI/UX of
an installer allowing multiple device selection for automatic
partitioning. But alas it is allowed, and currently defaults to
LVM+ext4. So it becomes a concat/linear arrangement and just works, no
matter how possibly fragile it is to device failure. So the closest
approximation for Btrfs would be mkfs.btrfs -d single -m single. The
next closest is -d single -m raid1, which at least allows the
possibility of salvaging the data on the surviving drive, and probably
worth the risk of metadata exhaustion in the rare case of including a
small second device in the pool.

--=20
Chris Murphy
