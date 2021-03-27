Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F361034B745
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Mar 2021 13:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhC0Mqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Mar 2021 08:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0Mqe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Mar 2021 08:46:34 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961EAC0613B1;
        Sat, 27 Mar 2021 05:46:34 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id n25so2255121vsl.2;
        Sat, 27 Mar 2021 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RrVbuP4yx7aVpvGRK5G+Y2BaGMrWO4PGd0V8ba4pyo0=;
        b=dbVv3vXFbLAyEu8JR9YoyZqiLOlT0vE+UupckIBPV2hbhKkvCbiRMCJC4CtqtETQbC
         Cnh0dMEE5OABeJ7eNCbJLLrAIALb9yd+srwA7yW2g+8a50EIQq2RhRmWoEoGYd14Zqt2
         ivhuKAIbxsNi+jbuZu8GiE6zUGP8MEx/7TfFYvGjaLu4q1yMEAyHdL2/XkgUPWAFkOdD
         UsQTd1omdV6XI/MAnv84R6KSbM4URZ3cBgkCxZSu2AdzEvvhWX1v701Ms9XpuIytsjcn
         StGQmsRj63N9Sfg6pnJeTgKGN8r6qI4a1UuPpZHnOAakNa1g4+hl5i3xyH2ib+zdsXlp
         2lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RrVbuP4yx7aVpvGRK5G+Y2BaGMrWO4PGd0V8ba4pyo0=;
        b=CFbbvCyD9AI9BIoIJec0gOlBzyIdHRC8za3+sCK9hg9ii2fnu/4SrHHCFCJT2YJsrj
         lpEroCXhRfsS0ATrhUPvt+vKJtrvkdoBVS/DxheTpf5h3XlP2tnaOoR9z892b4CexmqW
         9q1W9X0JI/yOBAxZX7kehmmQNhG9A09/ouEf611GcUy5KxQOFWqEXtL2gLDVvOv5gS2E
         taBM27ByMFMpHFHDhRaOL+2JdA+GyWFZuvxqzLzSKRGB7w5kTKjqTfs/apQn9TLhKGg5
         Zsf4zOM6MCNdt/crCqMwC8QAw3EBVzgX0o06goUIhHTrAM2I7EmhBWOWfDl4JglP0tC3
         +2rw==
X-Gm-Message-State: AOAM533G1KCSJ5TiN37VvBdtEbUuMt4V7vaPOPTIldROSZ9beHFtMv19
        HPVtU1aKyF4UbGKiYGyCl3TZSpy7wvPgIhIcbpfwIeUZ2vk=
X-Google-Smtp-Source: ABdhPJwlRFfJB4xqm7yl/waKf7pdUKzLTdtxvi7mDHEC1NHB2zqeWQ2wh+ifMfnZBHGk/h3/0QQR9z7Hh2+nfYGAli0=
X-Received: by 2002:a67:b81:: with SMTP id 123mr10927656vsl.52.1616849193669;
 Sat, 27 Mar 2021 05:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <CALaQ_hrZZmAi2AKtmCm2QUXeg9VWuyeWmmk__OFEG1ycHMiX8A@mail.gmail.com>
 <CALaQ_hoXDSP7Fe4SWFArHbv2ppmoKKPVEXTkO-Ex0FsjKaYd=w@mail.gmail.com>
In-Reply-To: <CALaQ_hoXDSP7Fe4SWFArHbv2ppmoKKPVEXTkO-Ex0FsjKaYd=w@mail.gmail.com>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Sat, 27 Mar 2021 07:46:22 -0500
Message-ID: <CALaQ_hrwsEsD5PU7QtyXOW3OXXRzQ9QV5tyEMpd70GsRLhV+2A@mail.gmail.com>
Subject: Re: BTRFS Balance Hard System Crash (Blinking LEDs)
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

An update... I encountered blinking LEDs while I was away from my
computer again.
I'm now pretty confident it wasn't an issue with btrfs balance, but
rather the sd-card not being seated well.

I just updated my old "F2FS Segmentation fault" post in linux-f2fs-devel.
In short, fsck for f2fs was failing, badblocks was coming up with only
errors, I cleaned the sd-card contacts, put it back in and badblocks
is running cleanly now.
It's just too late for me, and I have to rebuild that partition since,
for whatever reason, cryptsetup no longer recognizes the partition as
being LUKS even though badblocks was run non-destructive.

On Fri, Mar 26, 2021 at 11:51 AM Nathan Royce <nroycea+kernel@gmail.com> wrote:
>
> Oh man, I'm hoping things aren't starting to fall apart here.
> I was doing my normal routine (tv, browsing, ... (no filesystem
> manipulations)) and out of the blue "kodi" just crashes. It's actually
> not all that uncommon, and I fired up "iotop" to make sure "coredump"
> was happening, and it was.
> I then did something else in the terminal, maybe an "ls", and that came up with:
> *****
> error while loading shared libraries: /usr/lib/libutil.so.1: ELF file
> version does not match current one
> *****
...
