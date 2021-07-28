Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F823D91DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhG1P3W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbhG1P3V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 11:29:21 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40183C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 08:29:19 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so2454803ota.11
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=paHS5V34pKDg1JFPZ1MRVK/Ycpc7VkK0wcybJiJeNy4=;
        b=vY7/7A2Bm7DM5adY6yRrbgssr+BLosY0NByBZrmbPgrLKCh6wewHosa1D8vdgt44yi
         WaWAi3jRoKmjEepAcQlvgzyyP6WqOyQ/GpuRa9jrBoBZmCx89odzuLnkYcYYh2jLRQ3P
         LQvqn64puX+l7Q8m93QPO3+voCdwqM+hnHOH//tp4x+vQ+Pauv6qE+R6Pgbz96hbPDd8
         qg4CGW/qGA+JqUQVZ8139zEoQVRPrcxbYk97wxmTXhc8PiiKha/a/1gyEHMrabWPLhLD
         D4c+cF0s9Lo2lxhkA1oOpr5blLL9D2bdwUeo3+u7aoa6VCQ1M1FAqz6J7XRlZUIByY/z
         CdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=paHS5V34pKDg1JFPZ1MRVK/Ycpc7VkK0wcybJiJeNy4=;
        b=k5sRnXuqxi91ewYFuLLvo5k4aBd8PnaejDJtlFPWisNbX1CN6Zwg6BjLyiv8pBgeDb
         MN0Asl/W7M94bJ9uM1AO4OmR0Bs96F2k2neF1/eoO1RyhHvTeK4gW6HSJJf6f2hnpsNk
         9AlMz9OBSujDgMF2JN99D6LvIcJad8hWICdFTgOMpVWBhJ6aLHcF9j86w5IgT5qgP0R/
         suYY4EKCcwwbKFfxsI7BHz05UCxaoNTt8M6xWqTbvNOwgQjXBDApPgn83ouk1sxePofo
         J7wPD6LmL/z5mVvYg130iHUjEgHiDbuVTwnfQUJrLzekLl8BNrj0OkvFme0DmwwKOmgG
         YPug==
X-Gm-Message-State: AOAM530T/GezT+M4Yf0L8pWhxeFaId6+aj8Y9aEsfJ7JDaZ5D1nCMJ/5
        pvVczSzK1YrKvSA3qBXVqqNNNb8DQm4iKEre7cEEip80
X-Google-Smtp-Source: ABdhPJz3fKFyUR3xBXu/VA5gs6yQ0wgDQaVn2j9TCGPWZTXdN74Nq5+N35uQwYEnDegJQUhpn7gLXx6tqAuYiAjbu1I=
X-Received: by 2002:a05:6830:438b:: with SMTP id s11mr417826otv.133.1627486158675;
 Wed, 28 Jul 2021 08:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB4EspQpmK-uK_5bC2iXdx4X-SxsOrF9DC9dF6g0jqrJpA@mail.gmail.com>
 <d6444a8d-f232-0744-1bcc-34457f0fcc3e@cobb.uk.net>
In-Reply-To: <d6444a8d-f232-0744-1bcc-34457f0fcc3e@cobb.uk.net>
From:   Dave T <davestechshop@gmail.com>
Date:   Wed, 28 Jul 2021 11:29:07 -0400
Message-ID: <CAGdWbB6qy+aSbCQB8pBxwZAO2M6hS3PSPONCMOOqqCEMfEaobg@mail.gmail.com>
Subject: Re: reorganizing my snapshots: how to move a readonly snapshot? (btrbk)
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 1:34 PM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>
>
> On 27/07/2021 17:47, Dave T wrote:
> > I'm using btrbk to create regular snapshots. I see a way I can improve
> > the organization of my snapshots now that I have more experience with
> > this tool, but it requires moving existing snapshots to a different
> > directory.
> >
> > I would prefer to avoid re-creating the full initial snapshot in the
> > new location and I would prefer to avoid losing the existing
> > incremental snapshots. I also want to preserve the existing parent
> > relationships used by my snapshot tools (mainly btrbk).
> >
> > I'm thinking about using the solution mentioned here:
> > https://unix.stackexchange.com/a/149933
> >
> >> To set a snapshot to read-write, you do something like this:
> >> btrfs property set -ts /path/to/snapshot ro false
> >
> > My plan would be to change the ro property to false, move the
> > snapshots, reset the ro property to true, and change my btrbk.conf to
> > match the new path.
> >
> > What are the caveats in this plan?
>
> I believe that setting snapshots read-write and then back to ro is not
> recommended and is unsupported.

I have heard something vague about that before, which is why I asked
before doing it. It still seems unclear, but I'll avoid that approach
unless someone confirms it is OK.

> It may work but I am sure I have seen
> reports of problems with send/receive when snapshots have been made rw,
> changed and then set ro again.
>
> I recommend using the btrbk archive feature to move your existing
> snapshots and then start building on top of those. I think I did exactly
> this a long time ago when I was in a similar position of wanting to move
> my btrbk setup.

Thank you for the idea. The archive feature is the one btrbk feature I
have not explore yet. It looks simple to use. btrbk is a nice tool.

>
> Graham
