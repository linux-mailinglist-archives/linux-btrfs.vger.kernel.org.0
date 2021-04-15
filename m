Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B123610BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 19:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhDORHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 13:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDORHM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 13:07:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851D5C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 10:06:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so4304916wma.0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1i8OC59tBn4WqecKiHjRNfIP082GsyMG+fgG0IIXus=;
        b=LKyArfOJ3XzCBNH12znn7rDYAIYAU0vW/QG5ZbWEA5UGgXtSwy80m7GDmes2sOTZw7
         HWxFN8QYD149SyQ/hdz9voiGGhZCeNtCpIh+AvzDCYaPbKzAUFwRwKls6cuNgpcAB0MA
         HBlf8RFZ0IWUMgFycZWAtlQemeJ/eaRJEhRiZcpx9tuXTSBD8yWifbs055zCUp+4GxEC
         eFKO7y5T1eiItHdnYr5u1PX/RW3RjrfhNPjDWNxOE/lJrTIEYm+GO3FiQxm+QQf7fBJJ
         nOkcSI/GsXiQL2P4EebvkCchgIJwlUCJoiLlfy9QSurB/ZjYYDebcsFmWmUI9JEvBG9f
         F+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1i8OC59tBn4WqecKiHjRNfIP082GsyMG+fgG0IIXus=;
        b=TaVpJBji8De4rPnRaROP4cRZG/QiUMRlOvymqFCXABRYG4JJPCIKpuMZVb1t0i0Sz2
         ivxrkatnj3cn3eSRAjLYYboOwyLjBWn2UcpCuCkwECJbKFewRhje38Ceg6/TGHugF3vL
         7F+V1k+rtP0uErmqqSyDh8G+U1S5vQOB0S0H47c1JGfJnaTTRs9lztlwA4uEQd5U4bqV
         yGRfBn2lyUCIbFcKD3rFqFXYHcIeujqtGpUG2N+JIRIWT2xXozIsx5yIoccDPwcBNfVu
         8DtynHu56GTyMBcka7a1odFsLgrITBU3VWF+NPyqyiXrCsJ8nVJuQK/ty/o0kmeKQI2X
         eBbg==
X-Gm-Message-State: AOAM530NqbtiaQPt5Pb6C/6GbQZhu14maXaGw154mVm0wQM2NAOXF5V0
        IMyjYF9yp1elTcrceGn/K5x2KD76+5hpq3svR5TdM0H/xHhgtJn6
X-Google-Smtp-Source: ABdhPJx6IyyXTXy7VFS/K+IMpDgBWCKS4k1QFqsgl3mVFkCAEt5PLJ6PvzSaYEejbl23KeXYzE7aJZOMNIm/6OTWwUk=
X-Received: by 2002:a7b:c769:: with SMTP id x9mr4187964wmk.124.1618506408315;
 Thu, 15 Apr 2021 10:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <d97168fe4c9e7560fb6229fb4f971bfd@linuxsystems.it>
In-Reply-To: <d97168fe4c9e7560fb6229fb4f971bfd@linuxsystems.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 15 Apr 2021 11:06:32 -0600
Message-ID: <CAJCQCtQ_B6b2vrntaXLO5bWdi_1X7p09F84S1pbpEVXX9_g_1w@mail.gmail.com>
Subject: Re: Dead fs on 2 Fedora systems: block=57084067840 write time tree
 block corruption detected
To:     =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

First computer/file system:

(from the photo):

[   136.259984] BTRFS critical (device nvme0n1p8): corrupt leaf: root=257
block=31259951104 slot=9 ino=3244515, name hash mismatch with key, have
0x00000000F22F547D expect 0x0000000092294C62

This is not obviously a bit flip. I'm not sure what's going on here.

Second computer/file system:

[30177.298027] BTRFS critical (device nvme0n1p8): corrupt leaf: root=791
block=57084067840 slot=64 ino=1537855, name hash mismatch with key, have
0x00000000a461adfd expect 0x00000000a461adf5

This is clearly a bit flip. It's likely some kind of hardware related
problem, despite the memory checking already done, it just is rare
enough to evade detection with a typical memory tester like
memtest86(+). You could try 'memtester' or  '7z b 100' and see if you
can trigger it. It's a catch-22 with such a straightforward problem
like a bit flip, that it's risky to attempt a repair which can end up
causing worse corruption.

What about the mount options for both file systems? (cat /proc/mounts
or /etc/fstab)

--
Chris Murphy
