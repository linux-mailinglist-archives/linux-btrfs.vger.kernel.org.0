Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A26320336
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 03:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBTCsN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 21:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBTCsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 21:48:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5ADC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 18:47:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id w4so8596826wmi.4
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 18:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6aO7Mb5plsxBkdQ9fpT/wHuDURjkxXDr4847dyjauI=;
        b=CagLpkyg4TwlrZ1y5b7ROM+L9O1t9xLxSIOcFRmJgXK0ckIysHwsRd7MbTtXgemN/6
         +1zHD+VAwWSyvWZW47bXp/99Cs0w7oujye0aiYv9egFTtIoHhtXbvvPKbxlILa2N3+9r
         0Ix+GmRkMOBOFRqN6YB2yCg0ml0oTxiatdK/yJct8TXzYY8+OWDwHOXO7zj7seFPU8Wi
         qTqMWJ3DnzLz0aIHonFoyuQaq3jt5KiDUtqH7luVkbW1O40jdCV4u7OJhmeSIE9BlYn5
         cdruVwfdAFFkjof0/7sWMVRWTTamDXZ+Ne+PP30xjvRLmoLg0AbTasvwDWzhP6YKD5q2
         UyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6aO7Mb5plsxBkdQ9fpT/wHuDURjkxXDr4847dyjauI=;
        b=nFP3XCDtRoxoX5jFZg8AhQP4uSQEVGbPFhxQ0b/QRveZpACFQSik73QRv8i/e1lmhr
         xfAVN+gVJFsKR267ClPKx+1VYfOEUPUi2WUDE8D/P6CMXenXKk84R3l08KbagBnzTpJG
         nZc2idRNII79h7WwOknb3nBDnnfy/LKSdrbn13uRz6HrSrEby2JE1iBol0hdpLkkSJOy
         hnHjZyzSTKb1k96c9POJeMISqeZu6Io849LBvQZ9/91XcvtSmCA/qMlbqDGqtG5lIoIT
         LwAfIGmJjsFLSh0QJ4lEDnl7z7dy40sqUz0yBcEq0TD2u59KJw07yYB7Y11RT66l2eEw
         Axhw==
X-Gm-Message-State: AOAM530XqnBZGlWS2SWT6bb6kC5bViLTwwsEJ7H+HA6Sjz8l45PSW9b8
        fVOI2LdopAT9uAiWuNliIH/b3KhiefVzpVQrB0MmYbCRspa3C8nVNyA=
X-Google-Smtp-Source: ABdhPJxqPxLL/U2wCsIdpIrmV3zq38cYdG7k6AjuiIYwqOY+s0wP8GKFFa4fuizZ7R64PdV071xRHJey3r1j7mK6Xfw=
X-Received: by 2002:a7b:cbc2:: with SMTP id n2mr10643211wmi.34.1613789250146;
 Fri, 19 Feb 2021 18:47:30 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <mtwofibp.fsf@damenly.su> <CAMj6ewNYSnFUFPER06qweZaypWC6qVHmUX7gYxRXO7Gbuw_16A@mail.gmail.com>
 <CAMj6ewMSw+UzZHhEEN=rhxN8O3pN9gWA05usAodk2xX5+s-Qjw@mail.gmail.com>
 <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com> <CAMj6ewOc+jJAo=rLmH_mBzaqO10daPkcN5XacPiwx6eh9PVvBQ@mail.gmail.com>
 <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com> <2ac19a21-1674-b34a-7e0a-8a5744f0513a@gmx.com>
 <CAMj6ewPbivS1yZOmvT22hJsMxHGK-fWhyGgm3PJ4TVUbo04Eew@mail.gmail.com>
 <b06c1665-7547-2321-3863-4c68c9818f90@gmx.com> <CAMj6ewOze4Ngw7ydj_Ry2nLeyvWs_dB=fuGJ2zBdCEepTiC6yA@mail.gmail.com>
 <c6c8cb80-455a-181b-ada5-83001d387044@gmx.com> <CAMj6ewP-xUUa2G448HhPDPV9ZB7XiYVf4eCv+SMMtLH5MzTJ8g@mail.gmail.com>
 <08061b36-c49d-9604-49dc-7e85720b5040@gmx.com> <CAMj6ewM2wr2tRrMjRk+sztH0nD7RG1J4tXKfoekg3-rqEL3RWA@mail.gmail.com>
 <50599154-2ab4-2184-7562-f0758cf216eb@gmx.com> <CAMj6ewPGbkxH-OdsRt+xKQyLUUgR3J7dV7Xcf9XMq2-E=n3-tA@mail.gmail.com>
 <b040e855-c0a6-cd75-c26a-4ed73ffeb08d@gmx.com>
In-Reply-To: <b040e855-c0a6-cd75-c26a-4ed73ffeb08d@gmx.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Fri, 19 Feb 2021 18:47:19 -0800
Message-ID: <CAMj6ewOJpH_Lo3JcL540-ACwvbFNr33XS0LixEt+wAzf-T4vag@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 18, 2021 at 12:59 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> Just send a mail to the fs-devel mail list, titled "page->index
> limitation on 32bit system?".
>
> I guess your experience as a real world user would definitely bring more
> weight to the discussion.
>
> Thanks,
> Qu

Given that it sounds like the issue is the metadata address space, and
given that I surely don't actually have 16TiB of metadata on a 24TiB
file system (indeed, Metadata, RAID1: total=30.00GiB, used=28.91GiB),
is there any way I could compact the metadata offsets into the lower
16TiB of the virtual metadata inode? Perhaps that could be something
balance could be taught to do? (Obviously, the initial run of such a
balance would have to be performed using a 64-bit system.)

Perhaps, on 32-bit, btrfs itself or some monitoring tool could even
kick off such a metadata balance automatically when the offset hits
10TiB to hopefully avoid ever reaching 16TiB?
