Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2620C362D5E
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 05:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbhDQDpY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 23:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbhDQDpX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 23:45:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B264EC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 20:44:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 12so47634941lfq.13
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 20:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hypertriangle-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OuxMdiKx2mJUgqNCJdGpN/eyTNHxcmmmpwQ+Iw5/uDo=;
        b=nk7M9eThP68mqEHgUSAiEI3VVMSX+pwPAcxwMyMoX8fEJZHP7tfqTgFe7aaBXIWA6p
         H1My9uERtYWUE0sxzXZ6kSRTuusJG7aSvyZHygmZZGCFhGdQJBB6ynEwbFDXu4+3Lr6H
         rFSUWLet54XcmDR8xz6HheMsh1UJbjWRaUPX6p16xOKQhnEqNslLoFm1gQO+BilLUk6q
         Iw3+AWqR/nyNT1lFsIchU4CeFY9igC5qQCMpxynCOpMyuThzmiFby4Ox7JfxoFpG7iwy
         5nuMhjPwcatI3gsp3PEebClENwkhORRBmomJTIwEtTXCaFyR2vEMtCQYb5U+pdUK2Hby
         a2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OuxMdiKx2mJUgqNCJdGpN/eyTNHxcmmmpwQ+Iw5/uDo=;
        b=WzaJ8mjYtIKtGzhS0WLT6DjI5aiQdP9tiskiasBfLjfmPBxlbQOVAHl32ULVCFiMcD
         20IhDjy8GSuT9iuNFnRJdmhwhknd5iodtGDFbz56B/MZN8lJOGJKY+1DEqbhBg1cA8wp
         xy6Fn2qsvuWbZ+WSornrHwTpJH7whNNZXLa7GCh6TXQCDaueAKyJCHbUSjjrj3PAX1if
         rNnjnDTaGNC5yISDEB3Ez2Uv8ob7ZjUsCYZcbXerYJWXgMOzEp01SL+e+k/8UcLw2h1P
         nm8gQ1sV+DxTgj1dhj4NsFYO91Ic98z0Y/yiFeHbNXXSskpBgI3S6JaYooDLI0IXgriy
         grcg==
X-Gm-Message-State: AOAM533Y+YChXsKArQjMZc0w6jjVQM67E2nTvO6LQbI7D8vwMRHQcAuI
        deMl/CrkRWxtR0cvQjM6lbxVYCd6cl0eosasYiCiP/tKLSbQPR69
X-Google-Smtp-Source: ABdhPJzAD77Mr1ze3zS1Za0PH4sE+44cUCeS9YNxuTL8Uo93SxX+YhHCGIGQGPzScjQG6FGHyN9Z0zu5sjh8mpzd6u4=
X-Received: by 2002:a05:6512:38aa:: with SMTP id o10mr5074425lft.261.1618631096181;
 Fri, 16 Apr 2021 20:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAE9tQ0dr1+TTrALYUGfgx7tViU1tVU00OyAxkP1qsUUkyVsXPQ@mail.gmail.com>
 <CAJCQCtTD+XKZOfOi8dS13qbp7L_MUsSVt1eF6raFjsTEE3-NBg@mail.gmail.com>
In-Reply-To: <CAJCQCtTD+XKZOfOi8dS13qbp7L_MUsSVt1eF6raFjsTEE3-NBg@mail.gmail.com>
From:   Alexandru Stan <alex@hypertriangle.com>
Date:   Fri, 16 Apr 2021 20:44:19 -0700
Message-ID: <CAE9tQ0d9Mm+1sBJej6cTzdRiqYeAEMGG41yxEj=qNz23CO=G6w@mail.gmail.com>
Subject: Re: Design strangeness of incremental btrfs send/recieve
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 16 Apr 2021 at 20:29, Chris Murphy <lists@colorremedies.com> wrote:
>
> On Fri, Apr 16, 2021 at 9:03 PM Alexandru Stan <alex@hypertriangle.com> wrote:
> >
> > # sending back incrementally (eg: without sending back file-0) fails
> >     alex@alex-desktop:/mnt% sudo btrfs send bigfs/myvolume-1 -p
> > bigfs/myvolume-3|sudo btrfs receive ssdfs/
> >     At subvol bigfs/myvolume-1
> >     At snapshot myvolume-1
> >     ERROR: cannot find parent subvolume
>
> What about using -c instead of -p?
>
>
>
> --
> Chris Murphy

Hey Chris,
Thank you for replying and challenging my setup.

I am a total idiot (you can quote me on that in the future).

It would really help if I provided the -p option in front of the right
subvolume:
- sudo btrfs send bigfs/myvolume-1 -p bigfs/myvolume-3
+ sudo btrfs send -p bigfs/myvolume-1 bigfs/myvolume-3

To be fair my whole command looks more like:
sudo -n btrfs send -p
/mnt/bigfs/snapshots/somefolder/root.some_date_earlier
/mnt/bigfs/snapshots/somefolder/root.$now | zstd -c -15 -T4 --long=27
| mbuffer -v 1 -m 256m | ssh -o compression=no alex@first-server 'zstd
-d -c -T4 --long=27 | sudo -n btrfs receive /mnt/fs/snapshots/'

My rootfs changes are now being transferred back happily! And... done
in 2 minutes, amazing.

Alright, </thread>

Alexandru Stan
