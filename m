Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE7987B42E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 22:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbfG3UPq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 16:15:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46010 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387406AbfG3UPq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 16:15:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so67093555wre.12
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2019 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m7EI3vntCmvJmJ6eO+YYdPUGaO6p7/rr2Az1b+GCojY=;
        b=VXwwvEpMsB+rn2+3QX3rTQQ4dxLZFlBtrXXMJqQEZvhBUHwll43gSG/h5t6j/25/Z9
         lwS5nfwPL/hip9KnDd3yPjKRrG0/HZrPmLW2w2QDq5Cvu4+vgEVTbq2/Yzy4ccxdMYZ3
         wGIo0WaF8WgZ1df+rbGEnb4LGT/sT+E2hiIK5g7Vfn0QHZzjkCOcPizgEQToDo5otHfP
         GByPt6NdT9hcLmyB5qcwNI/Dm6V1SIS43A5XVUUj37S+cBaW1TMb5HSq24WqFk5OCcld
         1IafijJs9PV4t07gIeF11F09INr60PO8rmD0jhRXQgcpO3HgKVOJanGanDcip6fYGeOm
         UQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m7EI3vntCmvJmJ6eO+YYdPUGaO6p7/rr2Az1b+GCojY=;
        b=EDTyfv2kOv+8lVovrkDotaAk3nDf0BVMy1wtnN4uahFwnDaQJTndLJ9F5EGnK+GuYe
         nqsljSxWUSwFvF79iTyquM8u/obXXpgQSjGG4yBpO9HeyODfn5s6z2PREXhZCcibRRDx
         VDexBOG7TyKLTgQ787yV0Y+an3wOZyj9wWXzFHUEXdzHsBQ/JHtQT+u2lLGZ0g8EE0s1
         CvHhXYbMXHAShSqWR2Bn0NReH+pVQouIZQIW6NAAQlx7BqCYQiH5jIAFhm4K5WcMnDSj
         pcKiLIWX0gZoOMZTbLGSMNAUzKl8Ju5QzB+YY/TW8Xna7NY2KhFqWpElLYoVV9gUC5Wo
         GzFg==
X-Gm-Message-State: APjAAAXekBNRUEQdMrSuGDc5CGjNENkKI4eFbyyWtX8ibKYhoIxcEPZh
        4L6T7B8NOKFc4Z9MvM6LVpIoktT0kyqwZ3Kvi3U=
X-Google-Smtp-Source: APXvYqzl3dMk3xYadoSj358pdUEpvV9Qn0PjO03KkzeZkvakn2xb0eRIcaFa4Iz1O+REhzrxuVhnarvtnYdu0Ff/Ckw=
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr26733982wrx.82.1564517743954;
 Tue, 30 Jul 2019 13:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org> <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
 <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org> <49785aa8-fb71-8e0e-bd1d-1e3cda4c7036@gmx.com>
 <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org> <b7037726-14dd-a1a2-238f-b5d0d43e3c80@petaramesh.org>
 <71bc824e-1462-50ef-19b1-848c5eb0439d@gmx.com> <a08455f0-0ee0-7349-69b3-9cdd00bfe2aa@petaramesh.org>
 <fc26d1e5-ea31-b0c9-0647-63db89a37f53@gmx.com> <4aa57293-3f60-8ced-db14-ed38dff7644b@petaramesh.org>
 <43dc92e7-cd13-81db-bbe5-68affcdd317b@gmx.com> <CAJCQCtTSu4XdUmEPHD_8QL71U3O3M8-0m+SweqhPonkKRMUMeg@mail.gmail.com>
 <d76a038d-fc7f-5910-ec2d-ac783891f001@petaramesh.org>
In-Reply-To: <d76a038d-fc7f-5910-ec2d-ac783891f001@petaramesh.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 30 Jul 2019 14:15:32 -0600
Message-ID: <CAJCQCtR3pW7T7=DxuAyqwfG+4ii-jg2AVqQL2wVEAx2VrGAY8g@mail.gmail.com>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 30, 2019 at 2:09 AM Sw=C3=A2mi Petaramesh <swami@petaramesh.org=
> wrote:
>
> On 7/29/19 9:10 PM, Chris Murphy wrote:
> > We've discussed many times how both file system repair, and file
> > system restore from backup, simply are not scalable for big file
> > systems. It takes too long.
>
> So what would be the solution ?

There presently is no solution, and I'm not aware of the future plan
either. I think it's a problem.

>
> IMHO yes, having to full backup then reformat then full restore is
> impractical for big FSes. Especially if they have a lot of subvols.
>
> Also most private individuals do not have enough disks to perform a full
> backup of their RAID NAS, etc.

I sympathize with the lack of resources. But no full disk backup
simply cannot be taken seriously in any computer science context. The
data cannot be that important by the user's own estimation if there
aren't backups. It's reasonable for resource limitations to have a
subset of data backed up. But if none of it is *shrug* there just
aren't that many people who will sympathize with data loss if there
are no backups.

Backup+restore is for sure a Byzantine work around for the data
storage problem, but you have no idea what will fail or what will
fail. There's not a file system list on earth that will tell you it's
OK to not have backups.


> I believe that we should have a repair tool that can fix a filesystem
> metadata and make it clean and usable again even if this is at the cost
> of losing a whole directory tree or subvols or whatever.

So far that isn't how it works. I don't know if it's a limitation of
the on disk format. Or a limitation on reconstructing from incorrect
information, even though the checksum is correct.


> But it would be better to lose clearly identified things and resume with
> a working FS and a list of files to be restored, rather than being
> unable to repair and having to reformat everything and restore everything=
...

Yep. That doesn't exist yet and I don't know if that's a design goal
of Btrfs eventually.

ZFS meanwhile has no repair tool. If it becomes inconsistent, that's
it, recreate the file system.

If your use case policy requires a repair tool, you really have to
disqualify both ZFS and Btrfs because the Btrfs repair tool is still
marked in the man page as dangerous. I just cannot take repair of
Btrfs seriously when Btrfs developers consider it dangerous on a case
by case basis.

It's always the case with any file system that a clean reproducer has
the best chance of getting developer attention. This is not easy. Part
of practical best practice is having a bulk of systems on some very
stable operating system with well maintained stable, or actively
maintained long term kernels. And to have some smaller percentage of
machines to test mainline kernels on. It might be annoying and
tedious, and definitely bad and a bug, to have a problem. But at least
your problem is restricted to your test machines.

There isn't enough history here to piece together with any certainty
why you're experiencing what you're experiencing beyond what Qu has
already stated.

--=20
Chris Murphy
