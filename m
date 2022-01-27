Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A07C49ECD8
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 21:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbiA0Usm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 15:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbiA0Usl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 15:48:41 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6233FC061714
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 12:48:41 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id c6so12425355ybk.3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 12:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJ1XfRGn9U3hN+D7lqVinMglQrJVXdijXllgjG+lvpk=;
        b=yUSGv8rhsTB6BXOQnYwiKzzMsN6UNdpVyThCEenkxt8hCwC1oIh0Qc8LjAIu07djsT
         n05CPXqfUJE3sN7zaYSYKt+4e2GY3uN4M+WnIGDQsnxf7VW+7irMY4anvlfQm7C7ZV7K
         da/I3M+WHT3G8LgkSp4BpiiqXOohS+cxnfJshCohsfHoecIdJQtqg3Ow1WzsBr3GXVUc
         dKOeCqCgYk1E+Voo7m0y9oaamDsmnC82jvzb22uY0BVm53i1TfZuykaM9Pi8W5zS+cLJ
         WCXEDkNFdBBQUVAvo/TyXvLopi+AA+WJxFYpL1F6p4TVvrUuZBzFhLm1LHxK7apSWda7
         9nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJ1XfRGn9U3hN+D7lqVinMglQrJVXdijXllgjG+lvpk=;
        b=FxnmJL5cHW7sXcWzXVRcNbx6RGngE9xtXKdcT+CJckLhW7zbm1U2+/uk9DN+E0QCjf
         MWr1yuZyEx2NVuxXLv0QOceI391J/evOO5Ejn794D9CMN7wpJXAeUXRgxrOB8FUMx9Ar
         Cx5oW8QyGmoe0/5jUjQLP5NdU0R7wgU5wyyPi7Uv1gudY9HH07BS9s+Ur05Q5lp4KDiO
         ZclPBS6x5fzkMIg4BdLSIU9m5q8jE8bIKDKcbJEG6xIlJdha8Bd1+ElMZcVkRPcYNtaW
         1naznxN30CyZWU0Lkz+yh3KsMky1MMXFxqmKMI3yN+7awG/LJzhqj6vYSsqRykY+RXsc
         YcpQ==
X-Gm-Message-State: AOAM532IZUkfe4+jd5f/2WKMYSETM23U/xQgbPkzGGPYLIzqlAtIejF/
        ic2tN2uF6lFnAfttbe9KEjGBtV8P359J7ojrH/075bsO6Zn5lgFM
X-Google-Smtp-Source: ABdhPJwW8SXn8wzvOdRwpV814TFrh4GJ9Nq6ROb+gTiBR8NK7LriP8JFHa330tXtONt70PBPZTUamY9FZGDZcA/WIsg=
X-Received: by 2002:a25:9083:: with SMTP id t3mr7615534ybl.695.1643316520482;
 Thu, 27 Jan 2022 12:48:40 -0800 (PST)
MIME-Version: 1.0
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
 <YfHCLhpkS+t8a8CG@zen> <4263e65e-f585-e7f6-b1aa-04885c0ed662@gmail.com> <YfHXFfHMeqx4MowJ@zen>
In-Reply-To: <YfHXFfHMeqx4MowJ@zen>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 27 Jan 2022 13:48:24 -0700
Message-ID: <CAJCQCtR5ngU8oF6apChzBgFgX1W-9CVcF9kjvgStbkcAq_TsHQ@mail.gmail.com>
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
To:     Boris Burkov <boris@bur.io>
Cc:     "Apostolos B." <barz621@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        systemd Mailing List <systemd-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 26, 2022 at 4:19 PM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Jan 27, 2022 at 12:07:53AM +0200, Apostolos B. wrote:
> >  This is what homectl inspect user reports:
> >
> >   Disk Size: 128.0G
> >   Disk Usage: 3.8G (= 3.1%)
> >   Disk Free: 124.0G (= 96.9%)
> >
> > and this is what btrfs usage reports:
> >
> > sudo btrfs filesystem usage /home/toliz
> >
> > Overall:
> >     Device size:             127.98GiB
> >     Device allocated:               4.02GiB
> >     Device unallocated:     123.96GiB
> >     Device missing:                 0.00B
> >     Used:                           1.89GiB
> >     Free (estimated):             124.10GiB    (min: 62.12GiB)
> >     Free (statfs, df):             124.10GiB
> >     Data ratio:                  1.00
> >     Metadata ratio:                  2.00
> >     Global reserve:               5.14MiB    (used: 0.00B)
> >     Multiple profiles:                    no
> >
> > Data,single: Size:2.01GiB, Used:1.86GiB (92.73%)
> >    /dev/mapper/home-toliz       2.01GiB
> >
> > Metadata,DUP: Size:1.00GiB, Used:12.47MiB (1.22%)
> >    /dev/mapper/home-toliz       2.00GiB
> >
> > System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
> >    /dev/mapper/home-toliz      16.00MiB
> >
> > Unallocated:
> >    /dev/mapper/home-toliz     123.96GiB
> >
>
> OK, there is plenty of unallocated space, thanks for confirming.
>
> Looking at the stack trace a bit more, the only thing that really sticks
> out as suspicious to me is btrfs_shrink_device, I'm not sure who would
> want to do that or why.

systemd-homed by default uses btrfs on LUKS on loop mount, with a
backing file. On login, it grows the user home file system with some
percentage (I think 80%) of the free space of the underlying file
system. And on logout, it does both fstrim and shrinks the fs. I don't
know why it does both, it seems adequate to do only fstrim on logout
to return unused blocks to the underlying file system; and to do an fs
resize on login to either grow or shrink the user home file system.

But also, we don't really have a great estimator of the minimum size a
file system can be. `btrfs inspect-internal min-dev-size` is pretty
broken right now.
https://github.com/kdave/btrfs-progs/issues/271

I'm not sure if systemd folks would use libbtrfsutil facility to
determine the minimum device shrink size? But also even the kernel
doesn't have a very good idea of how small a file system can be
shrunk. Right now it basically has to just start trying, and does it
one block group at a time.

Adding systemd-devel@


-- 
Chris Murphy
