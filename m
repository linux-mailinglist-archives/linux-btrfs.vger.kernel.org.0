Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC581C5194
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 11:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEEJKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgEEJKv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 May 2020 05:10:51 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED36AC061A0F
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 02:10:50 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id di6so630555qvb.10
        for <linux-btrfs@vger.kernel.org>; Tue, 05 May 2020 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xYCo/xRtu+Fn98AR7JBFnWgUkXF9PogWNEUwA9RWYHU=;
        b=nhkYXu8vKAdMmOzeMItap1aZZ/6B0SKtR3pwpTQEeyZ1rkh66OtbQ7Y85sYVuONqxj
         pCu04ZQqvJPi/wI78l3kXUETWtY3/5EfGOx9Gz7xOjhwIlxP3EBC6tUcdY3QiSH1ljI8
         noBzrtiYQb9SfLUSZFWIErthIeWGjZijWlaE+O2RROuyqSEu1uQTV7q7Wulbn6L6bms7
         6c8oN93F3yjEwIPAhPgbU3/QX3PWgF7nHaUywmSAKNx85NHenvrSC24hVmtSMaPlaEQy
         zmy38vm0tH2bzGusVlta0WBKp7PRKB7y7ezbOM2efF4OL5Q9j/z55u2DzPgxYcr1GVSq
         LFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xYCo/xRtu+Fn98AR7JBFnWgUkXF9PogWNEUwA9RWYHU=;
        b=DNZYFWAPSHGn3nGjciJ6gMVr2YHnw/OrG+pdbhcDEuj5Ae4HgTtm034PExG8N1J59e
         6ve/12kE3u6FHUDIuKSmd40qZZY67FzBzY3z/Pm/8dq39LStxngCh3pukDd6eOZH6oHZ
         ea4PGd6gTyBELtqr5wIT/WxF/0S2f0rBsAtDwntY4LnSoDMkIRWwgQteJ7smnEg3B4eU
         CwB67U+uXclBcFY9ENEpd+NhbaCJg9hmz0s9xX3SzWlJAuB7wRgpUc6uX2rV85XCB43R
         suLRF9LCZdHcgzkMnvqQU/Beh8clH+z3y6jfASm7JRzdG7zPuwY9ewM2R1Y+/HvcLduo
         rBlw==
X-Gm-Message-State: AGi0PuacYtnWPQEgi/IZvPMPbREPrJ5MWsVFdGlC+AP2TuIzo1Tbva2C
        5wpTCj1btVglw3A7OkK2RBKqF1tOc0iNXwCRWAoCA+43Yls=
X-Google-Smtp-Source: APiQypJH7xi7dWT1GhA1MGd37686CDSFVhSboH/6KbmhuD2nsjb72xpnqDRsbOTySpzHv9c8J2XKFLOG1lCl5Q5ikd8=
X-Received: by 2002:a05:6214:bc6:: with SMTP id ff6mr1729654qvb.43.1588669849932;
 Tue, 05 May 2020 02:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200411211414.GP13306@hungrycats.org> <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org> <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
 <CAK-xaQYvgXuUtX6DKpOZ2NrvkYBfW9qgGOvMUCovAjVBO2Ay7g@mail.gmail.com> <a7d16528-b5c2-0dcb-27fa-8eee455fee55@gmx.com>
In-Reply-To: <a7d16528-b5c2-0dcb-27fa-8eee455fee55@gmx.com>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Tue, 5 May 2020 11:10:38 +0200
Message-ID: <CAK-xaQajcwVdwBZ6DhZ5EYax2FL28a6_+ZfsPjV7sqXeQ3RVKQ@mail.gmail.com>
Subject: Re: Balance loops: what we know so far
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno mar 5 mag 2020 alle ore 01:48 Qu Wenruo
<quwenruo.btrfs@gmx.com> ha scritto:

> I mean, btrfs-image dump of the umounted fs.
> (btrfs-image can compress the metadata, and won't include data, thus it
> can be way smaller than the image)

No problem to give you complete image, data and metadata.

> At this stage, the image should be pretty small.
> You can try restart the system and boot into liveCD and dump the image.

Just to give you more possible info, here=C2=B9 you find all the files. I
guess you figure out how to
use it without my explain, but anyway, just for the record:

- video.mkv : show you how I re-up the save-state of vm at the moment
I saw the loop;
- Virtualbox-Files.tar.bz2 : contains all the Virtualbox VM files, so
you can run it up on your own. You can also view the history command I
did;
- ubuntu-iso.tar : just to make it easier, it's simply the iso Ubuntu
I'm using, with the right path, so if you want to replicate my side;
- sda1.btrfs.dd.bz2 : is the dd of all the BTRFS partition, just after
the reset of the VM, but without mount it. So, if I mount it, I see
this:

[268398.481278] BTRFS: device fsid
cdbf6911-63f6-410e-9d22-a0376dfcc8ce devid 1 transid 32588 /dev/loop35
scanned by systemd-udevd (392357)
[268404.681217] BTRFS info (device loop35): disk space caching is enabled
[268404.681221] BTRFS info (device loop35): has skinny extents
[268404.694708] BTRFS info (device loop35): enabling ssd optimizations
[268404.700398] BTRFS info (device loop35): checking UUID tree
[268404.722430] BTRFS info (device loop35): balance: resume -musage=3D2 -su=
sage=3D2
[268404.722523] BTRFS info (device loop35): relocating block group
12546211840 flags metadata|dup
[268404.752675] BTRFS info (device loop35): found 21 extents
[268404.771509] BTRFS info (device loop35): relocating block group
12512657408 flags system|dup
[268404.792802] BTRFS info (device loop35): found 1 extents
[268404.819137] BTRFS info (device loop35): relocating block group
12210667520 flags metadata|dup
[268404.858634] BTRFS info (device loop35): found 26 extents
[268404.915321] BTRFS info (device loop35): balance: ended with status: 0

Just in case:
1aced5ec23425845a79966d9a78033aa  sda1.btrfs.dd.bz2
93c9a2d50395383090dd031015ca8e89  ubuntu-iso.tar
e9b3d49439cc41cd34fba078cf99c1b8  video.mkv
663b9a55bbfdb51fc8a77569445a9102  Virtualbox-Files.tar.bz2

Hope it helps,
Gelma

=C2=B9 http://mail.gelma.net/btrfs-vm/
