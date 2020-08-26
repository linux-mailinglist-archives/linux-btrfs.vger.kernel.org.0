Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2CA253984
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 23:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHZVGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 17:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZVGs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 17:06:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2372C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 14:06:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u18so3221017wmc.3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P/SK4JxAqq+TbhJV3TK6ZYDaGXW96BVTIHtBzOO1qSY=;
        b=AhuPBulAf4c/lYeUmUEyJJtUAN5De4gRjAp665XNiVMuHfbvMz6fM8YEWKZ/1XPZVL
         xUM3KDS42sVHsB5Y4lGw7Tb304/abfE5L9Ny/cexF69GVq/JhUY043/4zQJ46AjhnYtO
         9PKYYe4iOniY/NvOzzFVcYS7EoLUuGk2sTLZeoWCSHE5+P6LRotnX5TtnLtpz7W+6NPK
         net02HPMkorNh0p3e9CRXuTZ5eL7aiKupFWmCuNL2EUSsrXacO/cPFS2ynaY/MhbTN1G
         tmXbkW0BIv1gqNJGkmMfwKK7mmJ0BSUTx6/XjEZRVEe2KC8g8A4PyOFsfgV6/rVm/LM5
         WkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P/SK4JxAqq+TbhJV3TK6ZYDaGXW96BVTIHtBzOO1qSY=;
        b=GD8mDtOpg74bjLXKeGaj/6OTDujBzUHNv+3bzqKMPQcLAtInKC+QszblchFuRDPzjJ
         ri1gdt22HUCSIoWoKuKsfrhrF21W0UiATDXlRxFYjHEkoN0aSJrEd+1tbrbpIv8KyWl7
         lEAU26/gqrdwJJcMB8ODjK4FpcZC7OanPG8sr1MVk3uRsEj4qaGF0jhEupNgboeDjT5f
         7nBevMA2G284e3yirI7yeByw77mFxBFBsU8koqmNqH8ME878fVCP9CYmNfZUXfmKNmuS
         vtBdjJPonsgS1QT7KOA3YAhzaQ7S/xdDbLdCQWYzskGkeKC7/IRglMQu8xdWMyaWdFXk
         Frbw==
X-Gm-Message-State: AOAM533jeVfD1MoOLR7GlmOsZqJUr0onfslxE2CaLtAjiQRFoADAxRJR
        799e1SW+rhPBrbH9xI/PO+kwRXu0TncAZzLSR0+94CfgYbjTUA==
X-Google-Smtp-Source: ABdhPJy++2XJq8JBckzNwM0anshL2n8CGaf4NH/m54+p35nQJfX6EISKDzeF/pasJ79HFmb3fkIjBr4wAtkWchYnbxM=
X-Received: by 2002:a1c:81c6:: with SMTP id c189mr8583604wmd.124.1598476006267;
 Wed, 26 Aug 2020 14:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <CAJCQCtQH3h=NNr6PX3HZp7SbkgqZtNNdihi4aBMFvx+DN79XeA@mail.gmail.com>
 <6LDov933WqF3kLH8jtkEh-pfK6pRe0o6-Y9l3NcO2mVhswDL7rhbHyda71OnztoJKfgqqQT9jj1Ba52lz_ugNFmmRtzN33BlSa5pCvds0F8=@protonmail.com>
 <CAJCQCtQDt=x7WCX7KhWz_pPn4yB1YdZm9jN29jRuQDFy=ZTOjA@mail.gmail.com>
 <emBWetDIaC_TYsBRNRlPcz-yLjIOxlhIBny_K9bTqHxLO_kdKRZlGjMoHrVj4CwZ8aZAnMcXEyCj95vBFBxxOvJ1AANQr1sbeQ_CfZOrTH0=@protonmail.com>
 <VTDsoZlxoD7U7UxD61VnBts_awxM0n5PgKgeH-fCQOy4VeCCCj27DmdMt_oP490t0cKWbsY9qlK1hci8o-1uD7vtBcVQLub1Gl3JjIGU-o0=@protonmail.com>
 <CAJCQCtT8gLGNU6E+f=eM9SBPa4+tG+K7AbiCd=KjD2o8QrpxpA@mail.gmail.com>
 <dHPyoaNUuxoqxJjpSUjcxZvk21ew2ObKWFFhX0efJKBqjG8m27px3mPupviQuM3HYQDEcYQGFQ9jOprBuAX4x1Em3oVOyDl6EhKwEJSiuXs=@protonmail.com>
 <CAJCQCtSVMAEZP5OT77yCEBw9Z3C=oyVKcicWbRV9p_+pKcRwoQ@mail.gmail.com> <gp99KJ83xX5hsbU2_hXblYTSDI6Rmkk2fbRYAcKNoQik1CH8siYdTw11qFuFdAqo-iC48cJcB_vbMJgY8HuSySoWoBW3hcYHewIgB87Kzzw=@protonmail.com>
In-Reply-To: <gp99KJ83xX5hsbU2_hXblYTSDI6Rmkk2fbRYAcKNoQik1CH8siYdTw11qFuFdAqo-iC48cJcB_vbMJgY8HuSySoWoBW3hcYHewIgB87Kzzw=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Aug 2020 15:06:01 -0600
Message-ID: <CAJCQCtQZW2ps1i4b6kGBd_d8icYZWyz5Ha+Ozo0VjsbvVNf03w@mail.gmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 26, 2020 at 1:57 PM Andrii Zymohliad
<azymohliad@protonmail.com> wrote:
>
> > Actually, if you can reproduce the fallocate problem and strace it,
> > that would be helpful. For sure, homectl deactivate, for starters. And
> > then just 'strace fallocate' that file the same way you did
> > previously. I assume it still fails. Put that strace into a text file
> > or pastebin (month expiration should be enough) and link it.
>
> Yep, still fails. Here's the one with exactly the same arguments as befor=
e (-l 403G): https://gitlab.com/-/snippets/2008996
>
> But I did "homectl resize azymohliad 300G" so now "ls -lhs" reports:
>
>     228G -rw------- 1 root root 300G =D1=81=D0=B5=D1=80 26 22:50 /home/az=
ymohliad.home
>
> But even "fallocate -l 300G -n /home/azymohliad.home" fails the same way.=
 Here's strace: https://gitlab.com/-/snippets/2008993
>
> (I hope gitlab is ok too, you can add /raw to URLs to get raw txt file)
>
>
> > And also paste into your reply:
> >
> > grep -r . /sys/fs/btrfs/<uuidofbtrfs>/allocation/
>
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadat=
a/disk_used:474251264
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadat=
a/bytes_pinned:0
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadat=
a/bytes_used:474251264
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadat=
a/single/used_bytes:474251264
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadat=
a/single/total_bytes:1073741824
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadat=
a/total_bytes_pinned:163840
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadat=
a/disk_total:1073741824
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadat=
a/total_bytes:1073741824
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadat=
a/bytes_reserved:163840
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadat=
a/bytes_readonly:0
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadat=
a/bytes_may_use:74252288
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadat=
a/flags:4
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/=
disk_used:81920
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/=
bytes_pinned:0
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/=
bytes_used:81920
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/=
single/used_bytes:81920
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/=
single/total_bytes:33554432
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/=
total_bytes_pinned:0
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/=
disk_total:33554432
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/=
total_bytes:33554432
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/=
bytes_reserved:0
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/=
bytes_readonly:0
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/=
bytes_may_use:0
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/=
flags:2
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/global_=
rsv_reserved:68730880
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/di=
sk_used:314346594304
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/by=
tes_pinned:0
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/by=
tes_used:314346594304
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/si=
ngle/used_bytes:314346594304
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/si=
ngle/total_bytes:510463901696
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/to=
tal_bytes_pinned:4096
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/di=
sk_total:510463901696
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/to=
tal_bytes:510463901696
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/by=
tes_reserved:4096
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/by=
tes_readonly:131072
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/by=
tes_may_use:4096
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/fl=
ags:1
>     /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/global_=
rsv_size:68730880
>
> I also added this output to the collection here: https://gitlab.com/-/sni=
ppets/2007189
> I'll keep all those gitlab snippets that I shared in this thread online f=
or a while (some months at least).

OK is the sysfs output from before or after the homectl resize? And it
matches with the second strace fallocate -l 300g ?


--=20
Chris Murphy
