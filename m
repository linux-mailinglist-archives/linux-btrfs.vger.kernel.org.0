Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FF51C03FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 19:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgD3Ri7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 13:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726503AbgD3Ri7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 13:38:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17B2C035494
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 10:38:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u16so2939143wmc.5
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUZi8buxxNA9O8mdb53p6Vsh5KcYllJQMQ6X2QPGrj4=;
        b=PPjMGngnNfsc84hfr6c3278HUEdaCHrOOIq8VoaLUn4mkXkPIlRr8JHYtwqIvduFQE
         Qjg1DI469VGBmGfz3Nzl8chwHxnTXklESlx6LwmF28HACCTAmV0eYrmpEdx0sXTcLERF
         x7qdKgxBK8ZLqdXjz1g9CPxcmeA0+YS3RGao/SNmWhTp5dGSv8ajElzh057GMOsMVYGc
         UfZV/QnTYy+YfE7bhxZ+BALfuj88o1kpYoG7YWOExor15H4Jt0btmE6KRzT+vUIFpRft
         3eqhUuxqgoduPyL7mtNf8bJz8y3iLABC53Fy+/hC72zjhjsdE5fulaFYy/FMhxKRiDYb
         gjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUZi8buxxNA9O8mdb53p6Vsh5KcYllJQMQ6X2QPGrj4=;
        b=MHMwv3EY+l11RbFv1/MUBgbCtmb6RM4bITA0vr3dMOguGPwS82oTd9md+G5LDbySSQ
         XKmtYF2F7FX9BxSaV3/e8HwuTxTu3zb4LR+7cmv50RQiRz7WicwvG/mv9FuVSISJB9iD
         k3bC7dKK1ymBbWcb2GV5SjVsI4dyHh6fWg5/cUpgVONEbvSWzws09RJtOBqb8J39o3gi
         6oj/ZcR4BRmxgF4P7tAgjh8EHUWSQt0VU+WMQBq2nkOj1XNhNEd9HiltACka+66YyFjd
         J0TsEso89xxWLqs4YmMOMjK4APZuPaLBzDQNB0IGHqTRAHN6UZsoI6gIlDM/6DWnkhW5
         QMPg==
X-Gm-Message-State: AGi0PuavrZg0XXfBBOVwpgcoqQsdx6jV4Yj6zKuXPpYjplUJ35/jttEC
        EeDQ9T+S0dwnomGAcfNzZ4VvGTreDxLNK7Tqz/t1fw==
X-Google-Smtp-Source: APiQypLmG+ZGokUdtMHfgkDV7+mgOjeEL0ghhCdxGULFM9r5pScmw/853gt7LUVkxo/J/tvcT3dhmu38xl6APMbSw7c=
X-Received: by 2002:a05:600c:2645:: with SMTP id 5mr4111555wmy.168.1588268336316;
 Thu, 30 Apr 2020 10:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
 <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
In-Reply-To: <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Apr 2020 11:38:40 -0600
Message-ID: <CAJCQCtT0mSYvN7FeCavsmKP9j_69JmZ0JdGz8ommhqag=GiM=Q@mail.gmail.com>
Subject: Re: Troubleshoot help needed - RAID1 not mounting : failed to read
 block groups
To:     Nouts <nouts@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 5:57 AM Nouts <nouts@protonmail.com> wrote:

> > [ 4645.402880] BTRFS info (device sdb): disk space caching is enabled
> > [ 4645.405687] BTRFS info (device sdb): has skinny extents
> > [ 4645.451484] BTRFS error (device sdb): failed to read block groups: -117
> > [ 4645.472062] BTRFS error (device sdb): open_ctree failed
> > mount: wrong fs type, bad option, bad superblock on /dev/sdb,missing codepage or helper program, or other error
> > In some cases useful info is found in syslog - trydmesg | tail or so.


> >
> > I attached you the smartctl result from the day before and the last scrub report I got from a month ago. From my understanding, it was ok.
> > I use hardlink (on the same partition/pool) and I deleted some data just the day before. I suspect my daily scrub routine triggered something that night and next day /home was gone.
> >
> > I can't scrub anymore as it's not mounted. Mounting with usebackuproot or degraded or ro produce the same error.
> > I tried "btrfs check /dev/sda" :
> > checking extents
> > leaf parent key incorrect 5909107507200
> > bad block 5909107507200
> > Errors found in extent allocation tree or chunk allocation
> > Checking filesystem on /dev/sda
> > UUID: 3720251f-ef92-4e21-bad0-eae1c97cff03

What do you get for:

btrfs insp dump-t -b 5909107507200 /dev/sda

> > Then "btrfs rescue zero-log /dev/sda", which produced a weird stacktrace...

btrfs-progs is really old


> > Finally I tried "btrfs rescue chunk-recover /dev/sda", which run on all 3 drives at the same time during 8+ hours...
> > It asks to rebuild some metadata tree, which I accepted (I did not saved the full output sorry) and it ended with the same stacktrace as above.
> >
> > The only command left is "btrfs check --repair" but I afraid it might do more bad than good.

With that version of btrfs-progs it's not advised.

> >
> > I'm running Debian 9 (still, because of some dependencies). My kernel is already backported : 4.19.0-0.bpo.6-amd64 #1 SMP Debian 4.19.67-2+deb10u2~bpo9+1 (2019-11-12) x86_64 GNU/Linux
> > btrfs version : v4.7.3

I suggest finding newer btrfs-progs, 5.4 or better, or compiling it from git.
https://github.com/kdave//btrfs-progs

And then run:

btrfs check /dev/sda

Let's see what that says.


--
Chris Murphy
