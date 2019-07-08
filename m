Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2871D61EB5
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfGHMqI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 08:46:08 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35270 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfGHMqH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jul 2019 08:46:07 -0400
Received: by mail-oi1-f178.google.com with SMTP id a127so12473360oii.2
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Jul 2019 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4zZTQIg5ZZZgmG6PHtwhTDfL7WLT0/Y06l/PYCPbveo=;
        b=dPkei6PbCmadFLd6bDO9v4BFJpngFXjaqLBPyfktHT3oAmsbH+pDBNBFrymyOH/Br1
         nWjPHgz66y34yucxLdFD3QIS+Zk/M7Amiq/iIcbzgTCyCiTw068IJWGN/QD+tdXyCSsh
         dohkQoC2M1ePs/ume5EikKXZyXsrhePo8Hq+m0/RZwC7j17YizxcxcqSN2Gbkg24Xs7F
         BuKAFhV0vMxyP49Z9S6lkDyfwrBiIe73kVvxO1Pbtg8cTKTUK5HvrRAdXDUfYt//0Y+8
         Vls9xvKaUSqZ296dZ3yiDDB0K7TWpuSQNpO7Vnjh6kVZcxN2uY/KjWGMnTPEGHtAvvVr
         INmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4zZTQIg5ZZZgmG6PHtwhTDfL7WLT0/Y06l/PYCPbveo=;
        b=lq5sGNHlGyjpD3mGuoUwiO+8fbBvSGvfo71GpUS+L5dcGxlkabq0YcncKrR2uDx40O
         nl6h/8zk9E6FLpGgDUUMGry1ZAAqXqwJMu1PyQWGa+9vEO1T29GJLo9Ip8BE9Uka+t0E
         Ac5lR7CikU/Kc5DmzCgrrE4wVGbGqG1zA3eEdnYZ/aYoH5+MPTpGfywRVqiTW0bE6iY5
         WNDZtyFwwMIukDxplFf9oTe9YTElApX9gw73zPcGgPMeWY+zM++m9sh1a/imBhlwcZl/
         PpBbs1tZK+gb4qdSFLWnt3RFisJ7gtLLYHJEeJDlOKXp2u4J36Omu0daMpOTyClVoI0d
         QviQ==
X-Gm-Message-State: APjAAAVGVjeaVk/MPmeDIph/M4UoS6UARuMrsH2by+kGil6orPfSCwAK
        7eTtcbkOjKE9Int3xG/8NXajT4TeVyuzhLCp/yWBb8QL
X-Google-Smtp-Source: APXvYqwUgT5oMPDfbDmyGy/Tkp3Vl96nOVXlS6OBr99bjC7DsRxM7C3HRnDIDMc9gfqGglK+bw7yzh1POZxd1nmiAis=
X-Received: by 2002:aca:a847:: with SMTP id r68mr9203091oie.69.1562589966798;
 Mon, 08 Jul 2019 05:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190708084821.GB15143@tik.uni-stuttgart.de>
In-Reply-To: <20190708084821.GB15143@tik.uni-stuttgart.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Mon, 8 Jul 2019 15:45:55 +0300
Message-ID: <CAA91j0XB0-Fz3AD8G1tuAAN0SF4n_O06CMouSc8=xPi404090A@mail.gmail.com>
Subject: Re: understanding SUSE / setup
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 8, 2019 at 3:02 PM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
...
>
> root@trulla:/# btrfs subvolume get-default /
> ID 453 gen 2273956 top level 270 path @/.snapshots/128/snapshot
>
> root@trulla:/# btrfs subvolume show / | grep UUID
>         UUID:                   c85dc50a-b126-1441-bddd-2832afac58d2
>         Parent UUID:            d2f6c896-ff9a-2f4c-b60f-7d0e20ab834c
>
>
> parent_uuid d2f6c896-ff9a-2f4c-b60f-7d0e20ab834c uuid c85dc50a-b126-1441-bddd-2832afac58d2 path @/.snapshots/128/snapshot
>
> All (snapper) snapshots have @/.snapshots/128/snapshot as parent which is
> the default / subvolme
> But what/where is subvolume with UUID d2f6c896-ff9a-2f4c-b60f-7d0e20ab834c?
> Was it the installation subvolume which has been deleted afterwards?
>

Immediately after installation default subvolume (your root) should
have been @/.snapshots/1/snapshot. Most likely at some point "snap
revert" was performed on this system which changed root to another
clone. Then original root aged off.

> The subvolume @ is not default mounted - why?

And why should it be? It is rather questionable whether this subvolume
is needed at all. I do not think it is created in current openSUSE or
SLES15.

> It uses disk space (/lib /lib64 ...) but it does not get updated?
>
> root@trulla:/# l -Rrt /mnt/_/@/lib/ | grep -v ^d|tail -3
> -RW-             573,168 2015-09-24 12:16 /mnt/_/@/lib/modules/3.12.44-52.18-default/modules.alias.bin
> -RW-             603,413 2015-09-24 12:16 /mnt/_/@/lib/modules/3.12.44-52.18-default/modules.alias
> l---                   - 2015-09-24 12:16 /mnt/_/@/lib/modules/3.12.44-52.18-default/weak-updates/updates/crash.ko -> /lib/modules/3.12.28-4-default/updates/crash.ko
>
> root@trulla:/# l -Rrt /lib/ | grep -v ^d|tail -3
> -RW-             680,805 2019-06-18 11:42 /lib/modules/4.4.180-94.97-default/modules.alias.bin
> -RW-             723,956 2019-06-18 11:42 /lib/modules/4.4.180-94.97-default/modules.alias
> lRW-                   - 2019-06-18 11:42 /lib/modules/4.4.180-94.97-default/weak-updates/updates/crash.ko -> /lib/modules/4.4.175-94.79-default/updates/crash.ko
>
> So, it uses disk space, which cannot be freed?
>

And how it is related to upstream btrfs? Open SUSE bug report (or
actually support request as you have SUSE and not openSUSE).
