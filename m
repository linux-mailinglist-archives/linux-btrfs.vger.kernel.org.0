Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D862E9123
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 08:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbhADHcx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 02:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbhADHcw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 02:32:52 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D1AC061574
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jan 2021 23:32:12 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t16so31146990wra.3
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Jan 2021 23:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HVwVt/6vonNun5e8yMXMVb89JMxDpALDsV9n4VaNvuc=;
        b=QHKKlFKOEBUG3mg8sgmNz54LrE7gSa9phaftVQgeGbI+7WZwoIdZMZJOBmucaFe3S/
         RG9B5gtzq6z96egG8SoyATDONgn8swMWbayvwIoxWXWII9xLmUQ0VOykwwsxW5QdUNiv
         pJ+85TQ7caspZjxZ/2DYFb8LUKEU5otQ3qv202RAJlgbmMQX10kB9kUquvTtdnxLRXJy
         watV+4qNBRV8mCuGOFxgNlJrsoHMEBWZU37pE9D1GF+kb8481IR6NskR+/gduxiFZD96
         BBeSSNulgIxUYUtkX7V6bIXusU3stFN/+SqR0A+VEPnX5EKbpkf7987JLpFi++NJQKBy
         GHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HVwVt/6vonNun5e8yMXMVb89JMxDpALDsV9n4VaNvuc=;
        b=pI+42qnv9TxhptiFBPa54ZmePCTpM9wpuYxrKPZOrRmlbVQgobaWzV5TZT8j9FcqBM
         2wZyYErnqH7y/ftG2XSHeJO9ITxy1F402PmFYtmeUHcicfZEWcajvle/4eong82wRHX+
         GBE4sFfFGnaHtPfo/DGSyauC5BjHgYO5sHgbk9wIyRsnOwhYxBt4uu1E0RRMLxg5RMso
         O0MyTf8SSWwnA1qtXk8Hkt/6BXqTUhOw7Y1ImFGu1L3gb3bsw/IVGbEsGt+s3TTsBoV0
         V3aRiif1b7FVionD2OQ/Pem8Xdpj/VyBvTZOI39KoPW6THe4fjyGbW6l0fUtJqmR2aaB
         emCQ==
X-Gm-Message-State: AOAM532vX15lRNQBuUeLQXDsmFqDLGUIVZJSyJ88Qv1I6lZ8lYgVI4SQ
        JJswfP9mKDKBtvSNk0R28sA24pAc3bx7ZhtEi920BS2puFiRqA==
X-Google-Smtp-Source: ABdhPJwoTEPvKqrAZhebTF+YWBm4d93CSvssLErAbKJbQ6XZDThkTzTF/vK4cY/0EYqZYITwQr57prU+vbWYFnfmeEs=
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr79228816wra.252.1609745531170;
 Sun, 03 Jan 2021 23:32:11 -0800 (PST)
MIME-Version: 1.0
References: <1bdca54c9a0c575288f2c509246e5a96@tecnico.ulisboa.pt>
In-Reply-To: <1bdca54c9a0c575288f2c509246e5a96@tecnico.ulisboa.pt>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 Jan 2021 00:31:55 -0700
Message-ID: <CAJCQCtTMmU5oWbvY0vOpWgiS6UvH2ZrrLhnaDivC4o2FnbBvag@mail.gmail.com>
Subject: Re: tldr; no BTRFS on dev, after a forced shutdown, help
To:     =?UTF-8?Q?Andr=C3=A9_Isidro_da_Silva?= 
        <andreisilva@tecnico.ulisboa.pt>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 3, 2021 at 9:30 PM Andr=C3=A9 Isidro da Silva
<andreisilva@tecnico.ulisboa.pt> wrote:
>
> I might be in some panic, I'm sorry for the info I'm not experienced
> enough to give.
>
> I was in a live iso trying really hard to repair my root btrfs from
> which I had used all the space avaiable.. I was trying to move a /usr
> partition into the btrfs system, but I didn't check the space available
> with the tool, instead used normal tools, because I didn't understand or
> actually thought about how the subvolumes would change... sorry this
> isn't even the issue anymore; to move /usr I had a temporary /usr copy
> in another btrfs system (my /home data partition) and so mounted both
> partitions. However this was done in a linux "boot fail console" from
> which I didn't know how to proper shutdown.. so I eventually forced the
> shutdown withou umounting stuff (...), I think that forced shutdown
> might have broken the second partition that now isn't recognized with
> btrfs check or mountable. It might also have happen when using the live
> iso, but the forced shutdown seemed more likely, since I did almost no
> operations but mount/cp. This partition was my data partition, I thought
> it was safe to use for this process, since I was just copying files from
> it. I do have a backup, but it's old so I'll still lose a lot.. help.

First, make no changes, attempt no repairs. Next save history of what you d=
id.

A forced shutdown does not make Btrfs unreadable, although if writes
are happening at the time of the shutdown and the drive firmware
doesn't properly honor write order, then it might be 'btrfs restore'
territory.

What do you get for:

btrfs filesystem show
kernel messages (dmesg) that appear when you try to mount the volume
but it fails.



--=20
Chris Murphy
