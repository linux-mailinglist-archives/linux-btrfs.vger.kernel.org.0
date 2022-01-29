Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2C74A314A
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jan 2022 19:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352995AbiA2SCM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Jan 2022 13:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244812AbiA2SCL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Jan 2022 13:02:11 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CAAC061714
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Jan 2022 10:02:11 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id i62so27947287ybg.5
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Jan 2022 10:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwh9/xiCdCBZy9hc1CgFcHMS9ivmp9/hjBA72Ni0/Rw=;
        b=N7Hl59DBBPvL+kz7Q7rVcWENH3blexEN7DTP/o3JKrS3Bj+10FgkZzzNr3xeFLTpvC
         gbxeDwL4XGQArj5j2KfP5/Q7RAFvggYyjQvxqOxFWH5E5w196bygcZWj2XUv6xh5qYEK
         SSpDEnoyCaChcdpzPA2MqoKd82wW1uusMAkqppt3ac4+Dr2xYCKOcPyOqcsCU/XZpkjE
         sKtiT/mLCzgWGyPPo2NjyQHxCeQIFd8xmMzAzvMzUekpllJ4hTTAjEUUKPcaNwUId6jz
         zCi3jJL1iIvP/U1Ra7XoSwwN9YdUjTHBSJdy6wFXO0m6MVLPUTbBe/EJ4MgJ9S5GC2ch
         +cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwh9/xiCdCBZy9hc1CgFcHMS9ivmp9/hjBA72Ni0/Rw=;
        b=Xb4Dm7aPm5PCDRAMtIHUfgu+lmGSX3ohb0FD1SDkElLoRLeeU/q66+LXZ71qBLfnGy
         s7AzPMpcvsgynAWCdg/7VuV/HWJ02aDEPTwL2dgNk5PeqkeXkzRdKLaGipIEWWhP7FY7
         GkYpH6XCORvroJSz5DNRC57gsdy3SDYTCiA8zFtTbRAqZGhRq6WSGwbuq8kUWJHGx5xd
         Cvokdl2gEBMaQ7Gsi5h65mS6ViJxzJo6vUSOr59yzqMcD70AMr7CNwlyqRyOQKwYGrbz
         4Nmz+nGLcBT7Cq2EgdonRssioW6gJqPTHUaOfyKKNltVb5mvbJQExJS+9fUH493rAE40
         Ahbg==
X-Gm-Message-State: AOAM531kfnmhJN6/hvo9yjD8DhJ81r1ptNHun2Qj0M5zKN0iGMEczxf0
        0xcVFQnTeXDdKZrvpBJB5KyHf1ZYh6Jc7fsnJMsvNOmSjtRLhM4D
X-Google-Smtp-Source: ABdhPJwqHELrolHmZL3ogwIiOegLQ45PiAD1yBbcw9W9eeHcEmR21lh1qU9yszjEGc6QnAEugdE6vxB/AjyqjCLFyL4=
X-Received: by 2002:a25:ba0a:: with SMTP id t10mr18396082ybg.509.1643479330737;
 Sat, 29 Jan 2022 10:02:10 -0800 (PST)
MIME-Version: 1.0
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
 <YfHCLhpkS+t8a8CG@zen> <4263e65e-f585-e7f6-b1aa-04885c0ed662@gmail.com>
 <YfHXFfHMeqx4MowJ@zen> <CAJCQCtR5ngU8oF6apChzBgFgX1W-9CVcF9kjvgStbkcAq_TsHQ@mail.gmail.com>
 <042e75ab-ded2-009a-d9fc-95887c26d4d2@libero.it>
In-Reply-To: <042e75ab-ded2-009a-d9fc-95887c26d4d2@libero.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 29 Jan 2022 11:01:54 -0700
Message-ID: <CAJCQCtQv327wHwsT+j+mq3Fvt2fJwyC7SqFcj_+Ph80OuLKTAw@mail.gmail.com>
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Boris Burkov <boris@bur.io>,
        "Apostolos B." <barz621@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        systemd Mailing List <systemd-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 29, 2022 at 2:53 AM Goffredo Baroncelli <kreijack@libero.it> wrote:
>
> I think that for the systemd uses cases (singled device FS), a simpler
> approach would be:
>
>      fstatfs(fd, &sfs)
>      needed = sfs.f_blocks - sfs.f_bavail;
>      needed *= sfs.f_bsize
>
>      needed = roundup_64(needed, 3*(1024*1024*1024))
>
> Comparing the original systemd-homed code, I made the following changes
> - 1) f_bfree is replaced by f_bavail (which seem to be more consistent to the disk usage; to me it seems to consider also the metadata chunk allocation)
> - 2) the needing value is rounded up of 3GB in order to consider a further 1 data chunk and 2 metadata chunk (DUP))
>
> Comments ?

I'm still wondering if such a significant shrink is even indicated, in
lieu of trim. Isn't it sufficient to just trim on logout, thus
returning unused blocks to the underlying filesystem? And then do an
fs resize (shrink or grow) as needed on login, so that the user home
shows ~80% of the free space in the underlying file system?

homework-luks.c:3407:                                /* Before we
shrink, let's trim the file system, so that we need less space on disk
during the shrinking */



-- 
Chris Murphy
