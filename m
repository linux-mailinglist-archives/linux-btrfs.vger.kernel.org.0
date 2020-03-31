Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F25199CEA
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 19:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCaRbb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 13:31:31 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:38406 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgCaRbb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 13:31:31 -0400
Received: by mail-yb1-f171.google.com with SMTP id 204so11591101ybw.5
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Mar 2020 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmqB4H82qaNfbMde8TcR4iWSrwoM9AtZg0HLoEOzwaw=;
        b=D5sDKlUaCbafkfz07I7+fe0VQO962vn220nePCCMc79uAayB3WYRGVH2RJx9SGW33E
         +TisxCed3fQ31CO2+VOLXPNLQg6UJLRUjwTYYy/wGbLd6iKsVCl+PyN1T5fT61Ev0/rR
         kZRFEzhfdjmqWyukQKn4vJaso7B1wg1CUW5nxznzbDNrA+q7pdxBIjAc7PMbkuaQgseI
         cO41+Z0wHO1pPCijLrGn4Q9/LZHPz/9aLNwjWNkRHaIIhSbU2Ion+g+1m87AmDDxLWjM
         3RP2nReaGnYxEWtGisH7zy2fL86iacQdxFpPaJrWaRvzEyAvh6HG0ArOPisT8MOrAcrP
         LRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmqB4H82qaNfbMde8TcR4iWSrwoM9AtZg0HLoEOzwaw=;
        b=c5Uao4aN/oZRJ1iFEpTSE31tPU3VEDsgl70jXvfXSuiGsINtXQABnhWlJRFjTqZMR3
         KFpTLwPxzMCY/kWUfR3jDmaotdSYmhOgyZ5EgZdLvY22jVzcfCLt75mWWzEtJJ5QDmba
         JAdOlFS2aRXydzmBDHOV+sJPDa/s2Cr/qGMifBHflSyOWWvBcC2OrMAFJqbKkkangLx/
         O9XtFoACZ2Jm4UnRoncp2lmEsjeB/wRYQ2UXy/tcvXMBYKsfc7JeWhJMPhOq3bIHAsl0
         z+cdPEdB+ynGfUuMBO6DsWxfctt0ilOHulI1Tk5DAvet4ffoeCvk9DqN+MTRhaZcVKFy
         F0DQ==
X-Gm-Message-State: ANhLgQ2FzZ/yCenuWluiOlUgVv91lkhjFa/cQ7WaPJ0SlVgdYzUSJbRx
        84Xuj4//mIut6k7uEbPGaOyzpq78LK1YDeOADyc=
X-Google-Smtp-Source: ADFU+vuYAt1I7MsK/rfvvfeL/YwugBGK9e+iV/zHzvFTWx9D7oTpiWrTrcndaY7oNmmtJFGnLgqZB4zO+Vr3ykA58NE=
X-Received: by 2002:a25:bfc8:: with SMTP id q8mr29888823ybm.205.1585675890039;
 Tue, 31 Mar 2020 10:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAMnnoULAX9Oc+O3gRbVow54H2p_aAENr8daAtyLR_0wi8Tx7xg@mail.gmail.com>
 <a9b73920-65d5-b973-8578-9659717434b5@gmail.com> <SYBPR01MB38978D6654705941C50AF95E9ECB0@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAJtFHUSjwBKGyjSQfB-aZwsvV=4AcnG+-h5uF_4zmBOESxd=hA@mail.gmail.com> <20200331221749.52b10248@natsu>
In-Reply-To: <20200331221749.52b10248@natsu>
From:   Eli V <eliventer@gmail.com>
Date:   Tue, 31 Mar 2020 13:31:19 -0400
Message-ID: <CAJtFHUQbcVSQw1tQzCKEtHegJT81QzTu9OkCo2bonVpMyryRyQ@mail.gmail.com>
Subject: Re: Using Intel Optane to accelerate a BTRFS array? (equivalent of
 ZLOG/SIL for ZFS?)
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Paul Jones <paul@pauljones.id.au>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Victor Hooi <victorhooi@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 31, 2020 at 1:17 PM Roman Mamedov <rm@romanrm.net> wrote:
>
> On Tue, 31 Mar 2020 13:01:09 -0400
> Eli V <eliventer@gmail.com> wrote:
>
> > Another option is to put the 12TB drives in an mdadm RAID, and then
> > use the mdadm raid & the ssd for btrfs RAID1 metadata, with SINGLE
> > data on the the array. Currently, this will make roughly half of the
> > meta data lookups run at SSD speed, but there is a pending patch to
> > allow all the metadata reads to go to the SSD. This option is, of
> > course, only useful for speeding up metadata operations. It can make
> > large btrfs filesystems feel much more responsive in interactive use
> > however.
>
> If you're not taking advantage of Btrfs-side features for RAID, then might as
> well run LVM Cache on top of mdadm, and then Btrfs on top of the
> cached LV.
> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/logical_volume_manager_administration/lvm_cache_volume_creation
> https://lukas.zapletalovi.com/2019/05/lvm-cache-in-six-easy-steps.html
>
> Or Bcache, which is the same concept, but I do not suggest it over LVM cache
> due to perceived lower code quality, i.e. many data loss bugs, at least in the
> past. And as the 2nd article mentions, you can't un-bcache a block device,
> even if the cache device is disabled, the metadata cannot be removed. Unlike
> LVM where it is easy to switch back an LV to a plain uncached one.
>
> --
> With respect,
> Roman

Yes using lvm cache is an option, and will give you actual caching of
the data files as well. However, in my experience it doesn't do much
caching of metadata so using it on large filesystems doesn't seem to
improve interactive usage much at all, i.e. ls -l, or btrfs filesystem
usage etc.

As to the question of "How do you restrict specific device for
metadata only?" With btrfs metadata as RAID1 and data as SINGLE, and
the mdadm array being much larger then the SSD, all data allocations
will naturally go to the mdadm array, and all metadata writes will go
to both the SSD and the array. Currently, the metadata reads will be
balanced across the 2 devices based on PID. Once the btrfs readmirror
patches are merged then you'll be able to have all the metadata reads
go to just the SSD.
