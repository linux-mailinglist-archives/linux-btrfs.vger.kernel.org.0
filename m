Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E342734C0CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 03:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhC2BCy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 21:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhC2BCv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 21:02:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6336C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Mar 2021 18:02:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso7668456wmi.3
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Mar 2021 18:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MmOHQ4okc7pM4ZI+Bdk1wIAQZmtf3Bz14E12U7LGCc=;
        b=WDnwnmf5k5pOx/1SUT9lFqqwNFwI2ZY8sMt90A+xk7TbEP9QONyKljGISf/EBuDjPk
         xPUX/smYp4/Eg8TONOKQW0cAW5dgm88D+jKzGhFiSeMFntj2nt4L2OPgwCKCx5XcfxCu
         qcMSYpnbQalfoHQ4kF5ij7xlRXJBtzFWy7bJvEx7Q1FcI+Ct+BRrdGInlA+TztGmXw58
         eoMmG+PCwVSbyvXwRQO0zchUB2TTbQxu1hgIxfczluHpasgcxlC5Qy5HYRTKEJ3gcEkF
         8fN3w+vIeFsk87sgFk8Cq5d5A/k3Iuv9lGg6B+5L285PVyyQqlvSJWDqAmIXyvraPtch
         AauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MmOHQ4okc7pM4ZI+Bdk1wIAQZmtf3Bz14E12U7LGCc=;
        b=gAN2JN06D1a9EsxZdrMNL3chWFXSvH3JxQM8czKEZ7kCKlWpuXjojH5HsWjXQMONFa
         WoSOh6b1939Ly9HvC2UueLFxiz7f+F1O/BcadCWx4vApwg0/WzQdvl6ogUQaTe1tbyAp
         KCnajny9XudPXEJo+8zObRJNNncVaEtGr2Bl83gO/R6R8BxvJzOn/30rNtkXNP1OGhKM
         VygVgTxb0lTzXBDnqkRJEkmCRZ/R9DjIeWoRLQVi2227mqSb/egykRuRq7VgKR4ympw9
         YWCwL2XVxY/oiOFjf5AhMI5Oarc6kTXYPrkujlHkNJX81rpaLWWtwUvv1RxuEvx7yjN2
         Y4Tw==
X-Gm-Message-State: AOAM531Qnv7og0gSSPkCcc+2gKYmhsJ6ob0sC13bAUVQiQdgysk434uh
        2hGRZdlGDpZFeXMxRRjsSA40Grz3/xAaAMovsNDRnQ==
X-Google-Smtp-Source: ABdhPJzmwkT99LBFvppjH6h3E9IjtdTdJXDrxEWk9Zug6AlNK7SesBHuGDFnE79wKFH9N2jVrtjK1LkPqb2/436Pg1A=
X-Received: by 2002:a05:600c:3650:: with SMTP id y16mr22787021wmq.182.1616979769567;
 Sun, 28 Mar 2021 18:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
In-Reply-To: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 28 Mar 2021 19:02:33 -0600
Message-ID: <CAJCQCtQZOywtL+sz1XBC54ew=JJaLsx=UkgmeZi3q-ob39vgjw@mail.gmail.com>
Subject: Re: Help needed with filesystem errors: parent transid verify failed
To:     B A <chris.std@web.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 28, 2021 at 9:41 AM B A <chris.std@web.de> wrote:
>
> Dear btrfs experts,
>
>
> On my desktop PC, I have 1 btrfs partition on a single SSD device with 3 subvolumes (/, /home, /var). Whenever I boot my PC, after logging in to GNOME, the btrfs partition is being remounted as ro due to errors. This is the dmesg output at that time:
>
> > [  616.155392] BTRFS error (device dm-0): parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
> > [  616.155650] BTRFS error (device dm-0): parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
> > [  616.155657] BTRFS: error (device dm-0) in __btrfs_free_extent:3054: errno=-5 IO failure
> > [  616.155662] BTRFS info (device dm-0): forced readonly
> > [  616.155665] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2124: errno=-5 IO failure

transid error usually means something below Btrfs got the write
ordering wrong and one or more writes dropped, but the problem isn't
detected until later which means it's an older problem. What's the
oldest kernel this file system has been written with? That is, is it a
new Fedora 33 file system? Or older? Fedora 33 came with 5.8.15.

ERROR: child eb corrupted: parent bytenr=1144783093760 item=14 parent
level=1 child level=2
ERROR: child eb corrupted: parent bytenr=1144881201152 item=14 parent
level=1 child level=2

Can you post the output from both:

btrfs insp dump-t -b 1144783093760 /dev/dm-0
btrfs insp dump-t -b 1144881201152 /dev/dm-0

> What shall I do now? Do I need any of the invasive methods (`btrfs rescue` or `btrfs check --repair`) and if yes, which method do I choose?

No repairs yet until we know what's wrong and if it's safe to try to repair it.

In the meantime I highly recommend refreshing backups of /home in case
this can't be repaired. It might be easier to do this with a Live USB
boot of Fedora 33, and use 'mount -o ro,subvol=home /dev/dm-0
/mnt/home' to mount your home read-only to get a backup. Live
environment will be more cooperative.


--
Chris Murphy
