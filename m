Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BFF1CA0DD
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 04:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgEHC0j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 22:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEHC0i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 May 2020 22:26:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF8AC05BD43
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 19:26:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g13so73217wrb.8
        for <linux-btrfs@vger.kernel.org>; Thu, 07 May 2020 19:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ufnq3tfC7lSvh2Xrk/O/B15KMooRmhm0GWPlUHg2wYo=;
        b=UstaX3vurk6dKmQ/zsvY/kajLndoZJ1ir4sT6fTXKW1yj8G+lvMu87C9qfa2Kzlgzm
         MmUvsuuJf+F9sz/DZAYgdHjccCBXF/ZbkOf9c0ko8zo8z0e5T4TawyBr7nxycdJGGW6A
         Fft0J3tuZxwSlfS5o+Iun9tn7pLGwadt5WTr7ipKmmvTpelqJCHRrtCCEiMawD6ha+GS
         07/2SrQDQ9aXDDSD/KDhoaWEslMhPgziD29q71sBzsh/+MLV2N/cPGlcpwD7abZ5yZzc
         DRsLspgM4z625Kv9CF9duZLjgiUciprSlVD9N8zf+twNWVYn+ADp9Frr3NxhRrb0ADQl
         p9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ufnq3tfC7lSvh2Xrk/O/B15KMooRmhm0GWPlUHg2wYo=;
        b=DubxkYlZxmtguI1G2S+FK9KQCL0mzOi7MXoqQMRNgJjDPbGaJF4xqtMr3DU7pUEH1i
         GU4I2AYjgiU3Yb93L96djvPTN/avdofJ9naKJv7WqgxWpgFnTrHJTAyeM7tRkWELxhTs
         CAtDWd9Qqz9+5gjzD/BkNgK1REbA3kUY8PGctIwKA8ZpxeUkNR/zecaeQyFtZVzI1Xm/
         V1QQUYGe4UXJjGB54rveOA0y4plUYoZGBO4m+ku8dxNsmPgq+PB1uMtz+buJoRbRJpi9
         Usz/OMMbcTw9l1ggZ3DxEjlLZU9GAsaVoXpXmOHuwdbU/xv3sVEqEbn46cX2VZv658LT
         8+kA==
X-Gm-Message-State: AGi0PuYOHluKq8u5L23Cxo6Z8Ugz+XqQ+p9a7y3Iyekx0gSVeGo/m4KP
        kfgYyVsvQLiujmXzMe9bbpNb1D4h4ww8Os3Ha4xBVP8FkOo=
X-Google-Smtp-Source: APiQypKpXw480+QJiQj0Ol9ojFWVmO4W5OD3wC2KDh1Bfep15NX5UJDnoOK7FD46FF7+RXdd0XoOLQUQOoYIoQmSFms=
X-Received: by 2002:a5d:62cf:: with SMTP id o15mr153062wrv.252.1588904795799;
 Thu, 07 May 2020 19:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <fe7f6b83-aa2c-898e-648d-a8d86f5fd4d5@cobb.uk.net> <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au>
 <CAJCQCtSiEKi=ep-uh3fPVpKp3a8igTdTEm6i7cdPPkfHoDBA_g@mail.gmail.com>
 <9b763f5f-3e42-c26d-296c-e7a7d9cde036@sericyb.com.au> <CAJCQCtTorye5PTcH6crVYES4eAwVphhx3Au6xd7tijef1HU8uA@mail.gmail.com>
 <CAJCQCtRK+jEMVMz1QPCJCYqCciaaMZ5W+STabrdAQ5RyzWHhGA@mail.gmail.com> <7e54f0b9-d311-3d69-94dd-03279aa2dda2@sericyb.com.au>
In-Reply-To: <7e54f0b9-d311-3d69-94dd-03279aa2dda2@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 7 May 2020 20:26:19 -0600
Message-ID: <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 6, 2020 at 11:56 PM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> On 7/5/20 3:36 pm, Chris Murphy wrote:
> > This was fixed in 5.2.1. I'm not sure why you're seeing this.
> >
> > commit 96ed8e801fa2fc2d8a99e757566293c05572ebe1
> > Author: Grzegorz Kowal <grzegorz@amuncode.org>
> > Date:   Sun Jul 7 14:58:56 2019 -0300
> >
> >     btrfs-progs: scrub: fix ETA calculation
>
> Maybe not fixed under all conditions!  :)
>
> > What I would do is cancel the scrub. And then delete the applicable
> > file in /var/lib/btrfs, which is the file that keeps track of the
> > scrub. Then do 'btrfs scrub status' on that file system and it should
> > say there are no stats, but it'd be interesting to know if Total to
> > Scrub is sane.
>
> $ sudo btrfs scrub status /home
> UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
>         no stats available
> Total to scrub:   7.31TiB
> Rate:             0.00B/s
> Error summary:    no errors found
>
> > You can also start another scrub, and then again check
> > status and see if it's still sane or not. If not I'd cancel it and
> > keep troubleshooting.
>
> $ sudo btrfs scrub status -d /home
> UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
> scrub device /dev/sda (id 1) status
> Scrub started:    Thu May  7 15:44:21 2020
> Status:           running
> Duration:         0:06:53
> Time left:        9:23:26
> ETA:              Fri May  8 01:14:40 2020
> Total to scrub:   3.66TiB
> Bytes scrubbed:   45.24GiB
> Rate:             112.16MiB/s
> Error summary:    no errors found
> scrub device /dev/sdb (id 2) status
> Scrub started:    Thu May  7 15:44:21 2020
> Status:           running
> Duration:         0:06:53
> Time left:        9:24:50
> ETA:              Fri May  8 01:16:04 2020
> Total to scrub:   3.66TiB
> Bytes scrubbed:   45.12GiB
> Rate:             111.88MiB/s
> Error summary:    no errors found
>
> Still sane after cancelling and resuming.
>
> One thing that might be relevant:  On the original scrub, I started it
> on the mountpoint but initially cancelled and resumed it on the device
> /dev/sda rather than the mountpoint.  Could that trigger a bug?

Maybe. Try it and see.



-- 
Chris Murphy
