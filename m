Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD7134F1C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 22:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgAHVtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 16:49:19 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36273 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgAHVtT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jan 2020 16:49:19 -0500
Received: by mail-wr1-f51.google.com with SMTP id z3so5105078wru.3
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jan 2020 13:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylZu9kySaggdq8fgzuPf1y68i/8YNzwm5iN+HWUa+wU=;
        b=aGOzW8IWpQs1oaVVO0EvN/Gm8wbHkU3w1WQGegF5LWayDmBQ2F7Dbkz6t7DlUdiZ87
         HtLToxqBA5OE31k+fjw8kis7EVJ7/P5aWvAR7Fsr0m+3GbN9AbGhM3ekKRShtqzl8Jnj
         NJqd6qI5pUwZOYd8YVbB4N45pju2/pQb1uSWPkX4AziRRsKMD26swU8Dzmpps+QoNbYD
         /dLLoVAY3Q9oqW8MQs326SZLfYme+wbutlpuC/8V9nXWvakXpbAO2w0qIIzkR9q/7gvV
         nKgNlfif82PtKsmy8zRbEx4D5CmORdtu0n3R0KNOwQ8aHzN2FRz7A8Kd8it9/UnPCcEs
         DYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylZu9kySaggdq8fgzuPf1y68i/8YNzwm5iN+HWUa+wU=;
        b=sP/lJ4TVYIdnTqKdYtdbgVwSIrN5qKstBRIGfwOHKlcO5baQARv+G7z1NxCjH0tFZm
         pHWcXPb0AI9LlDWE2mzhS2nQ2El4Q0LC2mAg4OGNeMt3wMWd4Km6PPUN2QYRzthXjO2Y
         NsecAHYxb8ZU4EaX9pWJH6J7yq4Zdxd2i0JQBFIr2NrlmsRd68QMpwUfWE2pWljW07eZ
         m80WsOrh2mFqbvjXzgWeGjcf74OOrHSPJ4NlP1JvdGH9150Bg4e7qPsQ7ZRN+JqQxguI
         HUdPnWMjxIbQsrmJMnNPN/2xxbvntenpbT69qjoePgrAQrBm3p8UvGXXlvjt8lit1sM2
         hlLw==
X-Gm-Message-State: APjAAAVos6Y8z/aqN70VeYLKMUOaKayaSp+6RrKOIhpVLV8Pueu59y4A
        xE05Z/RBLDgrvH7F5LfikTeYDoWUodL4GtKTz7c50cKoUZw=
X-Google-Smtp-Source: APXvYqy8TEarqg6vg0rzkSlJ7D7Rqcbfy0otHpC2Reid0vmhs2zqUfYWgLwaMioIsj6nRIsmcEa7ZT6rA1BDR2KF+ro=
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr6891157wrp.167.1578520157259;
 Wed, 08 Jan 2020 13:49:17 -0800 (PST)
MIME-Version: 1.0
References: <b2ccde6952d0fa67c9948a21cd3ac8eddcdb3970.camel@render-wahnsinn.de>
In-Reply-To: <b2ccde6952d0fa67c9948a21cd3ac8eddcdb3970.camel@render-wahnsinn.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 8 Jan 2020 14:49:01 -0700
Message-ID: <CAJCQCtQQWGRQBAeCKt07MG33t9vwi-gahn7Mn9xJpA=HSAuTbw@mail.gmail.com>
Subject: Re: How long should a btrfs scrub with RAID5/6 take?
To:     Robert Krig <robert.krig@render-wahnsinn.de>
Cc:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 8, 2020 at 3:19 AM Robert Krig
<robert.krig@render-wahnsinn.de> wrote:
>
> Hi, I've got a server where I have 4x8TB Disks in a BTRFS RAID5
> (metadata and systemdata as RAID1) configuration.
>
> It's just a backup server with data I can always recreate.
> This server is in the bedroom, so I send it to sleep/suspend when I go
> to bed and then wake it up in the morning.
>
> Since a scrub takes days on such a setup, I issue a btrfs scrub resume
> whenever the server wakes up again.
>
> btrfs scrub status shows me that the total data to scrub is 18.67TB,
> but it's already scrubbed 36.60TB. Is there any way I can calculate how
> much more data is going to be scrubbed? 4x8TB is 32TB, so we're passed
> that, but I'm guessing this also has to do with parity data as well.
>

What kernel version and btrfs-progs version? Recent btrfs progs has a
new output that shows more info including a time to completion
estimate. Can you post the output from 'btrfs scrub status
/mountpoint/' ?

-- 
Chris Murphy
