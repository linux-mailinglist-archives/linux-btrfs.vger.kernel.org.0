Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32355364D0F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 23:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhDSV3l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 17:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhDSV3k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 17:29:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9521FC06174A
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Apr 2021 14:29:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m9so22734047wrx.3
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Apr 2021 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVf1KielBUuCJ9ZwW2SR3yD3Rrf8w8hXxORahX+BGGY=;
        b=n3hpSbZaDhxOiIUMKwj6ACkFHUmVDnTdbewn85dTYQRY4I3BbHt0CD+hBHbntnqjgL
         Gf24PXg1dykf/Etza6am1mj82p0a73VDPR/eddISspks+OUMdPINJCQRAeiDi/UnRoSB
         acJemfBtcjP1GjQtMWeDdr+N1Mb3jRvYz+idDzFWISKF+d4ZXKyS7MSUebkdHE8P3s9n
         WFCJdiE0RIlpqZJPp2sGPz7frTkzJ3ODGwVJYit0o0UDuaOIpf6/aNel6uW4W/VBsZu1
         PFKVwskQoMgUt5jVaCUuW1/gDSYjdEW+FC0J0kBiugYhoLCfdvjacytMu/BLKWpcfR6N
         +IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVf1KielBUuCJ9ZwW2SR3yD3Rrf8w8hXxORahX+BGGY=;
        b=n8ccvS7FXHzaTCA2EPIOIF2w4ZdVK3QarKTMehOi3p9mkfnGGJkkdXofI3ytY93Uwo
         GWOK9oPBUdRXu0t7m1QdaGl/6Rmqm6LWqO7sUNo7mbwNX8I1LQpnDpCKWP8Hn0njIaf8
         ak7MNpMZU5FeZA1peg5xe1IWage5Y50LVsL/37k9MyGWYy3sPJLpS/k4gYEVNbSSyhXq
         sF5Q9uGYgSGiGdF+9NbEOpbf4crAI8evv3LUX2O3LmIkdBrTo808krAxSEQM3y81nOPe
         KPuS7YcZRorJ25E17k2CdRQvykihwDQ6j2MYOw8PKkzneZ6vTXje7NsME497OKeaopgn
         CR/Q==
X-Gm-Message-State: AOAM533UdowwKonmZfneP4i5No6ukAspmlAdneU0g4yTAAfxgXaT93nF
        5NRMxOo+XhssCO99DfH49Uaz9tv9rRtOT4rDuRaDpsLNuPFppGMj
X-Google-Smtp-Source: ABdhPJw3JxWhC3D+D0m8JctR0C9rMmY21fHhO5gsBYtbRABRhPUCfRfhZt1aLNiWGMo4OPRUZP+WZV7VIujR5rRjWss=
X-Received: by 2002:adf:f506:: with SMTP id q6mr16718187wro.65.1618867749386;
 Mon, 19 Apr 2021 14:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <emeaeac76f-f9a6-4a02-8fb5-5534719439c4@fmf-laptop>
In-Reply-To: <emeaeac76f-f9a6-4a02-8fb5-5534719439c4@fmf-laptop>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 19 Apr 2021 15:28:53 -0600
Message-ID: <CAJCQCtTDhMmf03bF9fF3bQ73rCTi8x2VQgW+kn6x1St5NQv7BQ@mail.gmail.com>
Subject: Re: Help recover from btrfs error
To:     Florian Franzeck <fmfranzeck@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 17, 2021 at 4:03 PM Florian Franzeck <fmfranzeck@gmail.com> wrote:
>
> Dear users,
>
> I need help to recover from a btrfs error after a power cut
>
> btrfs-progs v5.4.1
>
> Linux banana 5.4.0-72-generic #80-Ubuntu SMP Mon Apr 12 17:35:00 UTC
> 2021 x86_64 x86_64 x86_64 GNU/Linux
>
> dmesg output:
>
> [   30.330824] BTRFS info (device md1): disk space caching is enabled
> [   30.330826] BTRFS info (device md1): has skinny extents
> [   30.341269] BTRFS error (device md1): parent transid verify failed on
> 201818112 wanted 147946 found 147960
> [   30.342887] BTRFS error (device md1): parent transid verify failed on
> 201818112 wanted 147946 found 147960
> [   30.344154] BTRFS warning (device md1): failed to read root
> (objectid=4): -5
> [   30.375400] BTRFS error (device md1): open_ctree failed
>
> Please advise what to do next to recover data on this disk
>
> Thank a lot
>

https://btrfs.wiki.kernel.org/index.php/Problem_FAQ#parent_transid_verify_failed

This might be repairable with 'btrfs check --repair
--init-extent-tree' but it's really slow. It's almost always faster to
just mkfs and restore from backups. If you don't have current backups,
you shouldn't use this option first because there's a chance it makes
things worse and then it's harder to recover the data.

These are safer if you need to first update backups:

Try 'mount -o usebackuproot'

If that doesn't work, there is a very small chance 5.11 or newer will
allow you to mount the file system using 'mount -o
rescue=usebackuproot,ignorebadroots'  which is a lot easier to do
recovery on because you can use normal tools to update your backups.

Try btrfs restore:

https://btrfs.wiki.kernel.org/index.php/Restore

This tool is quite dense with features to help isolate what you want
to recover. But the most simple command that tries to recover
everything that isn't a snapshot:

btrfs restore -vi -D /dev/ /path/to/save/files

It is also possible to use 'btrfs-find-root' and plug in the address
for roots (try most recent first, and then go older) into the 'btrfs
restore -t' option. Basically you're pointing it to an older root that
hopefully doesn't have damage. The older back you go though, the more
stale the trees are and they could have been overwritten. So you
pretty much have to try roots in order from most recent, one by one.

Might be easier to ask on irc.freenode.net, #btrfs.

-- 
Chris Murphy
