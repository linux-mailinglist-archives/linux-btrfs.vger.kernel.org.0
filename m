Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F50283045
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 08:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJEGBT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 02:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgJEGBS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Oct 2020 02:01:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC1DC0613CE
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Oct 2020 23:01:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so8050487wrw.11
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Oct 2020 23:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M2yQyErY8e5zQtZXztE8WagZTAVy4BPQZG5mC2KOu+c=;
        b=sEQNgzkdtBhzgtLRgoNHgkrqJbvEopymqVl4EL2ZhtDfXCCh2eAsDMm1YGMWLm8TEI
         fTE5H5oAnTu2/r/yh0jd+TuHYHH82JDo2dZtvExGAoHolYqll1ZTzrHnPQkEWY/54NYK
         G+WEZPDZzL1eNUh/MvqHyhl6cUG5QnLuy7MQDp03mt/oAlB6LTYIa295GoRZCUk0zZ1d
         ei87uSCMG3VGPBYjw0lOoV0z9SNw30rBlSVQcmU7lRIAG0djliTKj6ooxhrmKWkWwptW
         K7Q39tfGa5XCCcGripl9RGH/9MZvJZri5PdaHQdDr3do3KkA0V1NawV2CkU4pd33ciuK
         VuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M2yQyErY8e5zQtZXztE8WagZTAVy4BPQZG5mC2KOu+c=;
        b=T9UzBRJ1zGIGw18dSutPOTMUfyz/GNOm7hsw5AYfKrooXQiqUHjooUmfjrinmTRql0
         6KTTnIRNhCmA2M0Q4w36wMedp5FX4qzUIPXdy1TTH0rU0HMYAOI8rmHaDs9lzZiv0/uu
         bzycSyCkqSL6OzECRhq2fC1UIiyGK/vKzUZlTabkW4M9lIqISWG7iMWTrb56S/OB5igM
         jhl3EdBk14vDNOeQuAq6LVpbeGjfDbX6ng+2vMrhkWtTPx1dBpfJlq29YrgGUjQOyIYc
         +CTCKoIu5UZqFitQkSdWw20t3mZ2AUA+bFm37kxdCQupSZqu88Y70blSD+EdshIt4yHC
         /n4A==
X-Gm-Message-State: AOAM530aOcAAWyDHOnr3aJMQBmpd29JG8bcrfIa3j9cikGXK1gYxoPC2
        hFQHjyvabysiV+PMAqc+Ecdfidw4ReM66+LocPX9W2HFZbILPg==
X-Google-Smtp-Source: ABdhPJy3p//aWC9viAa5WlXL99atmDx7YfyRPbYExGEJHu/HDB+FY2KUep2pg1ODSSrFa5NtmnXabCILGomTfLmiLo0=
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr15144284wrn.236.1601877677102;
 Sun, 04 Oct 2020 23:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-8bafe7e4-3944-4586-8ccf-01fca6664979-1601808281835@3c-app-mailcom-bs04>
 <1c7b7bf3-5912-3d51-c1f2-5c2c889367f6@gmx.com>
In-Reply-To: <1c7b7bf3-5912-3d51-c1f2-5c2c889367f6@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 5 Oct 2020 00:01:01 -0600
Message-ID: <CAJCQCtQSy5Dknp46G08YHU2XxBuhKO2uCGkyU-eptHx4QSKRvw@mail.gmail.com>
Subject: Re: BTRFS device unmountable after system freeze
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Pet Eren <peteren@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 4, 2020 at 6:12 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/10/4 =E4=B8=8B=E5=8D=886:44, Pet Eren wrote:
> > Hi there!
> >
> > I have been using BTRFS on an external hdd (WD Elements 8TB, Single mod=
e, data, metadata and system in DUP). The device is LUKS encrypted.
> > After my Ubuntu 18.04 freezed, I can unlock LUKS, but I am not able to =
mount the BTRFS filesystem.
> >
> > - uname -a =3D 5.8.6-1-MANJARO
> > - btrfs --version =3D btrfs-progs v5.7
> > - btrfs fi show =3D Label: 'Elements'  uuid: 62a62962-2ad6-45db-a3ad-77=
d7f64983e8
> >                           Total devices 1 FS bytes used 2.81TiB
> >                           devid    1 size 7.28TiB used 5.77TiB path /de=
v/mapper/elements
> > - btrfs fi df /home =3D Unfortunatly I am not able to mount de btrfs fi=
lesystem
> > - dmesg:
> > [560852.004810] BTRFS info (device dm-4): disk space caching is enabled
> > [560852.004812] BTRFS info (device dm-4): has skinny extents
> > [560852.552878] BTRFS critical (device dm-4): corrupt leaf: block=3D290=
783232 slot=3D81 extent bytenr=3D2054053203968 len=3D262144 invalid generat=
ion, have 878116864 expect (0, 1475717]
> > [560852.552884] BTRFS error (device dm-4): block=3D290783232 read time =
tree block corruption detected
> > [560852.557557] BTRFS critical (device dm-4): corrupt leaf: block=3D290=
783232 slot=3D81 extent bytenr=3D2054053203968 len=3D262144 invalid generat=
ion, have 878116864 expect (0, 1475717]
> > [560852.557564] BTRFS error (device dm-4): block=3D290783232 read time =
tree block corruption detected
> > [560852.557605] BTRFS error (device dm-4): failed to read block groups:=
 -5
> > [560852.616539] BTRFS error (device dm-4): open_ctree failed
> >
> > I also tried to mount the device on another system (where the volume is=
 created) with the same results:
> > - uname -a =3D 4.15.0-118-generic
> > - btrfs --version =3D btrfs-progs v4.15.1
> >
> >
> > sudo btrfs check --readonly /dev/mapper/elements
> > Ends like this (with many more "Error: invalid generation for extent" l=
ines)
> > ..
> > ERROR: invalid generation for extent 4552998985728, have 15046180803710=
188199 expect (0, 1475717]
> > ERROR: invalid generation for extent 4555984134144, have 69219449903502=
60720 expect (0, 1475717]
> > ERROR: invalid generation for extent 4556810252288, have 13383730893851=
772781 expect (0, 1475717]
> > ERROR: invalid generation for extent 4558174781440, have 86490674675929=
86678 expect (0, 1475717]
> > ERROR: invalid generation for extent 4558308999168, have 12953021474535=
714951 expect (0, 1475717]
>
> Only extent tree corruptions, not a big problem.
>
> Nothing of your fs is lost, just kernel is too sensitive to any possible
> corrupted metadata, thus rejecting it completely, to avoid further proble=
ms.
>
> In fact, if you go several kernel version backward, you can mount the fs
> without problem.

Well he tried with 4.15 and got the same messages. Would '-o
usebackuproot' work here? Or is it corruption older than just this one
crash?



--=20
Chris Murphy
