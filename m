Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF08F3ADF5B
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jun 2021 18:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFTQ1B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 12:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhFTQ1B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 12:27:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9E9C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 09:24:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so9016844wma.0
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 09:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpd1ZQCHx4VukS9EOPjjsV1TXm+OX2sV/F3SuXd7hlA=;
        b=pGMHKF9XILBZ4/C1UfSxJ+aKxf79W2KQfyFlkP5jfkAmxgZZHdLNh4wvGZW0zfJ32H
         +xxSm2st9HFy4kVMGEKfkNqSUlrbh0RsGgkSVRtzUE0M/UDJlbecVK8tmrY5KYTbinXN
         k1BK25GS/SN9fyicTTD6kmq2kyBWIw7NpMQwh/5uZrPfdJHHPvPnqM6fuVq/SHGB1EwI
         zwVopg2HTyxmzk5Odg0O85i5WvP94/qdCtIbPffM/JlWQghM/abGX3TXVke5R5m39ymR
         Xtl7r38Wo9Q3B+mO/1rAk59cMgEhv30aritfmk4z3C06mpcJtIoye7rXeAcp9rZnSTON
         xgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpd1ZQCHx4VukS9EOPjjsV1TXm+OX2sV/F3SuXd7hlA=;
        b=TPUk1hLqDYTiaZv00nJoAQ195KFe3WVGSdYWuxd3qKeY8A6zlrkkXD9Y+dxXfxJd1S
         S+F5n33OxoI65QfekMgnxttE+L0eOj3j8L0N9TPNG0EcTiil/i0DZUGQiZ9HC2HclEFG
         JHYaD0dU9v+NOWUaMDyQvNl2M64R9mXO0cPVnzDPX88lnwyhc5sPA6j+zo65pcNhIgeI
         uJoQ96XNIyQy0C2RW3YsdibEl2htzEsVoJxGRUGK4bketUJ6p8XXbPAD8z9CWj6LR3Zf
         ItsQ3eNRSYEhqhpOb7Q3+nJqBIMLXL0MO0tMqYx7Wa/pfHaiYBOWT3bd5PpzAIAQhP7P
         sW8g==
X-Gm-Message-State: AOAM531HRyRAcakFrIDvct6QCeBTIsUAUYin4a6AGy9yUJ/yKSYZdGLE
        ERDWJOOarvBulGw/xuHjc7EYzH1068Lg9OMKtxx3uQ==
X-Google-Smtp-Source: ABdhPJyWan0ZDZSgeGH6t9VvghGlVH3n9/riqI1858+1dSD0uHV3losCRvwi7yyjSjcrSzOGIQ1KTa+8TYy0o2Zjkgc=
X-Received: by 2002:a05:600c:1d0a:: with SMTP id l10mr22688506wms.124.1624206285272;
 Sun, 20 Jun 2021 09:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <CAJCQCtSWxp+=nEJRFzEjEA0Lxt-rC+6Dq_CtpCNPmapzFw6WPA@mail.gmail.com> <ab0e8705-e18f-90eb-c42b-318c04a2101c@gmail.com>
In-Reply-To: <ab0e8705-e18f-90eb-c42b-318c04a2101c@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 20 Jun 2021 10:24:28 -0600
Message-ID: <CAJCQCtQXOgHTDAiGCWEN8_RaLNk26o9iDvtNcEBg9EVZ0yfdLg@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Asif Youssuff <yoasif@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 20, 2021 at 3:07 AM Asif Youssuff <yoasif@gmail.com> wrote:
>
> My complete mount options are:
> noatime,nodiratime,space_cache=v2,clear_cache,nospace_cache,skip_balance,commit=120,compress-force=zstd:9

space_cache=v2 is in conflict with nospace_cache and probably also
clear_cache; I'm not sure clear_cache can clear v2. Also once v2 is
used, there is a feature flag set on the super block so it always gets
used, and I'm not sure if nospace_cache means anything in the presence
of a free space tree feature flag.

Can you try to mount with just the skip_balance mount option, and show
dmesg from that point? I'd like to know how much time we have before
it goes read only and also what it's trying to do when it goes ro. And
make sure no user space programs write to this file system at all once
it's mounted.

Also, provide the output from "btrfs fi us".

There is a small chance it's possible to add four devices, and it
would need to be four, so that it can do what it's being very
insistent on, which is create a metadata block group. Since it's
raid1c4 profile, it needs to create one chunk on each of four devices.
If it works, that'd allow a filtered balance, to free up specific data
block groups and hopefully get enough space free to then remove those
four new devices.

The devices could be USB sticks, as terrible as that sounds. In theory
they can be RAM disks, but if you are put into a situation where you
*have to* reboot, or there's a crash or power failure, and can't
'btrfs dev remove' those devices first, you literally break the file
system, it'll be unfixable. So you do not want to use a ram disk. In a
bind you could use one disk containing four loop back mounted files,
but if you get really unlucky and that one disk has any issue
whatsoever, kaboom. Hence USB sticks, although if all four are in one
USB hub and the family turtle trips on its power cable...

There is also a small chance that freeing up space in metadata bg's by
clearing the v2 free space tree, but I'm reluctant to recommend it
right now. It's probably not going to free up that much space, and
currently it's pretty expensive to recreate on such a large file
system.

If you can mount with skip_balance and it does not go read only after
~5 minutes, try 'btrfs device add'. Just be aware that if the add
succeeds, that device is part of the file system now, until 'btrfs
device remove' succeeds. So they can't go missing or things get even
harder than they already are.

Also, consider backing up the most important data off this array in
case it's not repairable. Just in case. Right now it's going read-only
to prevent further confusion on disk. It's worth taking advantage of
it.

Last, consider updating btrfs-progs. Off hand I don't think you need
anything bug fix wise between 5.4 and 5.12, but 5.12.1 is current and
it'd be better to be closer to that, even though it's a low priority.

-- 
Chris Murphy
