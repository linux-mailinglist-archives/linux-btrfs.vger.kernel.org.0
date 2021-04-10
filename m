Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B078235B0BF
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Apr 2021 01:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhDJXG6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Apr 2021 19:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbhDJXG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Apr 2021 19:06:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2730C06138A
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Apr 2021 16:06:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x7so9122652wrw.10
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Apr 2021 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62SJ/9WQlc9g9PimBtOmlLNY7vaEe/NEblvwUTAWtyE=;
        b=Z1LBe4vb87mRIuLUSZ5LDUBsHbKGslMQwjfZJkzUIexheU+zwW4nSbflaYkJc1Ml94
         Dqe3teQSAZYA9AuOtdnu55VgnqypzoIywpr/8RrlogjgVrUP+YmO5WdAg6dsFA46Bn5/
         FhRP5DlskFT4MX6E1edPFiI2UAB/vBiWqhYwfI1FRx6VRyUWI3Md96fEufZgJpJILARW
         QYxyE430Z8LfZbKMZ0BHCNyMeBcSF5CzH/NSKeUzz3bsMGlWmrBrGTOxe/RPIoZwTwv8
         bth6Jdak8okJT+ES89HK1Co8vf0Ha2GLOZIKbrLKAF8r0aRM8y4PpbPXU3OrvDobhVhP
         qhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62SJ/9WQlc9g9PimBtOmlLNY7vaEe/NEblvwUTAWtyE=;
        b=aZpyQMUdx/nPDInnL0n3qJcnVuPqSujmTu1IRr7MEcwdVTsaHiw23uSyGsKtfo7KRA
         FlL5xCx6TYOEiDk3IVweCV91rbcOmb69zpM2cKQBtKXlhcn4YULfH7Z19G966B+87Gb+
         jR5J1C2dlTzdh4YDBbWjiLu8tRIeYxOrHEbMzafq0lXGc+PZuyGhGWtjtqiyVVj/kOmS
         +abVttz7x/PYVTaPNNOwuCz+v+L6pdlgbIMQsyZ5h6CkNYdigF+gVwPUWtsPf8osc+hV
         3MGaAxxMTtioMa0fzYRlgldMab0jtBMidyuUQGUcJoz2SunPYmARzheH0Fy7ziZq+qvX
         3S2Q==
X-Gm-Message-State: AOAM5321SdrqMRkqqb+thb2dSyARNrGE3X5n0meedwIbOmuCwCHAmwj6
        lkp/nQiCCIUMLIQh8wNhzGYn8jZXNrNxAHZLnjuBkGkngz9G8cXN
X-Google-Smtp-Source: ABdhPJzjBT4wjS6sciYv0l92PrODbESvKoJvRJW3ThY/tqtNNrtq+V5J2a2d7QQsemmxyaFNzvk/jjs87jZwXiUBeQk=
X-Received: by 2002:adf:dd08:: with SMTP id a8mr14266435wrm.252.1618095998911;
 Sat, 10 Apr 2021 16:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <FRYP281MB058285E8F1BD4B521817F6CFB0729@FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM>
 <20210410194842.71f49059@natsu>
In-Reply-To: <20210410194842.71f49059@natsu>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 10 Apr 2021 17:06:22 -0600
Message-ID: <CAJCQCtRqaxE6k9JGK+xSF-onTcVTjageC4dWoPdD+RARMK652w@mail.gmail.com>
Subject: Re: Parent transid verify failed (and more): BTRFS for data storage
 in Xen VM setup
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Paul Leiber <paul@onlineschubla.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 10, 2021 at 8:49 AM Roman Mamedov <rm@romanrm.net> wrote:
>
> On Sat, 10 Apr 2021 13:38:57 +0000
> Paul Leiber <paul@onlineschubla.de> wrote:
>
> > d) Perhaps the complete BTRFS setup (Xen, VMs, pass through the partition, Samba share) is flawed?
>
> I kept reading and reading to find where you say you unmounted in on the host,
> and then... :)
>
> > e) Perhaps it is wrong to mount the BTRFS root first in the Dom0 and then accessing the subvolumes in the DomU?
>
> Absolutely O.o
>
> Subvolumes are very much like directories, not any kind of subpartitions.

Right. The block device (partition containing the Btrfs file system)
must be exclusively used by one kernel, host or guest. Dom0 or DomU.
Can't be both.

The only exception I'm aware of is virtiofs or virtio-9p, but I
haven't messed with that stuff yet.


-- 
Chris Murphy
