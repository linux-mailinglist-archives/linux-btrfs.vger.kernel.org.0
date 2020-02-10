Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5440B156FAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 07:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgBJGuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 01:50:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43866 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgBJGuy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 01:50:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so5265332oth.10
        for <linux-btrfs@vger.kernel.org>; Sun, 09 Feb 2020 22:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8vsR0g6MBbbufOXZexJ/Yk7ED9ODwjZYNy8nEISXCbY=;
        b=LtjRGetH2J2u2RDyHrwuYWEI+v++rs9qMnkASf6W+X3xPBtBglF/1AJnV3+Efo5r71
         nySyh96SMzEzq2RKJxzuM+KH2jzmt/QDEQiwK87TIiIe5H69JJRYGkM01qyUxevYc9rs
         q+hDKH0lVkBVjPJtJTDkvQvifxQN27N2Uuyey8Jf1YcIoZPhiTNJI1xkYZ0oOwMKzeFq
         N3Mymeg4NU4CXfYvcSuFXQ8HM+Ri/YavcW2GeQwRCx3CxPmGrX/yzZYGDjr7a9nGTbjF
         poGz0PAGaUDf4RGBZSoBYA9s96H6vwhbkQKBEAXv9WLpkN0m3FxAwH+DKbP1JWyvynu9
         8xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8vsR0g6MBbbufOXZexJ/Yk7ED9ODwjZYNy8nEISXCbY=;
        b=FCC7qwBrpufSqzpx4lKU6wX29Li6KQ7jDzDJ/Si3PvomkNsSdVXY9hpFwImK7ZDUW/
         T0U1uI+nPbgCbKZcghXUfogBfcn2gnjGdp2zFEMur055fcWfty0fqkHXMXUfUrhawiTH
         +kocWtblo/jslxjcVTPrIipRa3dnMTWcuS5MWO2L6DKg55xIs7HBoOVzBsT+WcAX7vSa
         UQsvUIdCOJa9qGwl3xv1f1Yoi+actDWxXUeK58iGcVOWirnKW3sMqW3BwnFDHNK6kIhI
         1A1jBS/WzbPK5LuY9/PI+E0eAAASUuFQ7CehgHp19FQLkZDmbyX+K8jqvr8Yce4Zqf1w
         krqw==
X-Gm-Message-State: APjAAAWMfNwjRGuundJPac9jE5zSM+Hob3XJlQBneOXiwn+9aQf4gCLH
        09mjeBRsdf2suC5CxXhg6GA9fTRlW7yAensEyOI=
X-Google-Smtp-Source: APXvYqxVmG/tGlr7uCL57jgmoN2sjOk7RzSK1Uazu0os+sB9FpHkoRMsuF7IYuLe+xVagZh/MlieXP02qdfw0YuVR8Y=
X-Received: by 2002:a9d:268:: with SMTP id 95mr12824otb.183.1581317453601;
 Sun, 09 Feb 2020 22:50:53 -0800 (PST)
MIME-Version: 1.0
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com> <CAEOGEKHf9F0VM=au-42MwD63_V8RwtqiskV0LsGpq-c=J_qyPg@mail.gmail.com>
 <f2ad6b4f-b011-8954-77e1-5162c84f7c1f@gmx.com> <CAEOGEKHEeENOdmxgxCZ+76yc2zjaJLdsbQD9ywLTC-OcgMBpBA@mail.gmail.com>
 <b92465bc-bc92-aa86-ad54-900fce10d514@gmx.com> <CAEOGEKGsMgT5EAdU74GG=0WbzJx81oAXM0p_0rFhZ4vFmbM3Zg@mail.gmail.com>
 <efb830f0-9990-efba-aead-60cef00ab3cb@gmx.com> <CAEOGEKGgA7-3CsjYhgZJdZjzHPJNQ9xZETjjZwAoNh_efeetAA@mail.gmail.com>
 <49cc4e6d-07c0-aea0-e753-6a6262e4dedb@gmx.com>
In-Reply-To: <49cc4e6d-07c0-aea0-e753-6a6262e4dedb@gmx.com>
From:   Chiung-Ming Huang <photon3108@gmail.com>
Date:   Mon, 10 Feb 2020 14:50:41 +0800
Message-ID: <CAEOGEKHARKKSYMEU5kbswA7-PjxT9xAOomktG32h9RS6aYUVjA@mail.gmail.com>
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> On 2020/2/7 =E4=B8=8B=E5=8D=882:16, Chiung-Ming Huang wrote:
> > Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8812:00=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>
> >> All these subvolumes had a missing root dir. That's not good either.
> >> I guess btrfs-restore is your last chance, or RO mount with my
> >> rescue=3Dskipbg patchset:
> >> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D170715
> >>
> >
> > Is it possible to use original disks to keep the restored data safely?
> > I would like
> > to restore the data of /dev/bcache3 to the new btrfs RAID0 at the first=
 and then
> > add it to the new btrfs RAID0. Does `btrfs restore` need metadata or so=
mething
> > in /dev/bcache3 to restore /dev/bcache2 and /dev/bcache4?
>
> Devid 1 (bcache 2) seems OK to be missing, as all its data and metadata
> are in RAID1.
>
> But it's strongly recommended to test without wiping bcache2, to make
> sure btrfs-restore can salvage enough data, then wipeing bcache2.
>
> Thanks,
> Qu

Is it possible to shrink the size of bcache2 btrfs without making
everything worse?
I need more disk space but I still need bcache2 itself.

Regards,
Chiung-Ming Huang


> >
> > /dev/bcache2, ID: 1
> >    Device size:             9.09TiB
> >    Device slack:              0.00B
> >    Data,RAID1:              3.93TiB
> >    Metadata,RAID1:          2.00GiB
> >    System,RAID1:           32.00MiB
> >    Unallocated:             5.16TiB
> >
> > /dev/bcache3, ID: 3
> >    Device size:             2.73TiB
> >    Device slack:              0.00B
> >    Data,single:           378.00GiB
> >    Data,RAID1:            355.00GiB
> >    Metadata,single:         2.00GiB
> >    Metadata,RAID1:         11.00GiB
> >    Unallocated:             2.00TiB
> >
> > /dev/bcache4, ID: 5
> >    Device size:             9.09TiB
> >    Device slack:              0.00B
> >    Data,single:             2.93TiB
> >    Data,RAID1:              4.15TiB
> >    Metadata,single:         6.00GiB
> >    Metadata,RAID1:         11.00GiB
> >    System,RAID1:           32.00MiB
> >    Unallocated:             2.00TiB
> >
> > Regards,
> > Chiung-Ming Huang
> >
>
