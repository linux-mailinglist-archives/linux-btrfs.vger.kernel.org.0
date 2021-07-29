Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07B3D9AA6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 02:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhG2A5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 20:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhG2A5c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 20:57:32 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D46C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 17:57:30 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id a19so6196148oiw.6
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 17:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfo8HZubu4mgMe3UdDjz3WBFhgYcWrLmUAlt7FuD0LE=;
        b=ASLmctXwIHTRroN15H6ZVD998EmIXJdJ9r+Ca6eJe3j6Pr30tSCjyIYv93wb47SXZq
         5WKSScLOtEKP7JTQzOUSIYL9WuwKQuWWe330s/CGspv/X+AbDb7HwB83LR/k1e5tcM01
         Td6emXzSrYV5vWIxgRq1T+z0IKzQq1v0T+AFNcyUnCl4VTvPfr8HGLaMhHMqCGTVwO8Y
         NyHY02cPrTxlae9pw+ND3MbrnQsSS4sng2rgXnA363FECu9F+4Zj7k/wT9pp7pVGLw6B
         rBcUZSj7Dyge31mYdge/b0Z0rtgxeL+KOwS8PziT9T9bKtwywXidr2WFA9gKPm6xFHDF
         BlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfo8HZubu4mgMe3UdDjz3WBFhgYcWrLmUAlt7FuD0LE=;
        b=ufriLthcg0knO+KXIuJNmRrcOeBHyfHMicZkhsW8far3BjJPhiDNDf4pesmTZlaQ0P
         +UBMGoH2zAd782jIeBsSzj/UueFIi3k60sFU/MqRa8JNNVEj/gJ6MxZ8Qc+uEjtW8xtv
         fBwWqRO21nNElj/MNiygGVpyAPnF/OsXMI+zjqmZ4pG66eclRxhf7bwKCKaQVuDO+ekt
         XYWfTVg5a6QtSfyzjivA+wNe54klKWGAX704KaDsgdxy81Xtc9wwKEbk51oK5sSqaGLH
         IravsC9Tu2sVgCfyL1g57FQRGt3kQ+ALn12ZMfXKaCCnOkmcKdKRu5KjTv6azbdHdMuz
         CrXw==
X-Gm-Message-State: AOAM5333X/hglU2J7lINvhOtL6jp8G7OzonQH1tGdNJ0E1fTsZOu57kW
        f8DG9WFqQKfhlj3MWgHwzP5mmP0YmNd8jWXqkoxyKj4JTY0=
X-Google-Smtp-Source: ABdhPJzGQL1b0/jSla74qylzYqv28RTIOEtIpfHguCG/vG2cWp5T/+TSkfMDJir8rGwMnOSGzL7lsOZeGfJgblFBeDE=
X-Received: by 2002:a05:6808:24d:: with SMTP id m13mr8501177oie.137.1627520249716;
 Wed, 28 Jul 2021 17:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB4EspQpmK-uK_5bC2iXdx4X-SxsOrF9DC9dF6g0jqrJpA@mail.gmail.com>
 <d6444a8d-f232-0744-1bcc-34457f0fcc3e@cobb.uk.net>
In-Reply-To: <d6444a8d-f232-0744-1bcc-34457f0fcc3e@cobb.uk.net>
From:   Dave T <davestechshop@gmail.com>
Date:   Wed, 28 Jul 2021 20:57:18 -0400
Message-ID: <CAGdWbB7-nebkXTrFRDADLYYLqBi3xhibucySpeKUWqGjFJMzng@mail.gmail.com>
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
> recommended and is unsupported. It may work but I am sure I have seen
> reports of problems with send/receive when snapshots have been made rw,
> changed and then set ro again.
>
> I recommend using the btrbk archive feature to move your existing
> snapshots and then start building on top of those. I think I did exactly
> this a long time ago when I was in a similar position of wanting to move
> my btrbk setup.

I tried the btrbk archive feature. It doesn't fit my use case.
ERROR: Source and target subvolumes are on the same btrfs filesystem!

Any other suggestions? (I am running kernel 5.13)
Thanks

>
> Graham
