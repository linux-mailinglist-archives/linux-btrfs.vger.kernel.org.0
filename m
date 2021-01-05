Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E922EA39F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 04:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbhAEDBb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 22:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbhAEDBb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 22:01:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E83C061574
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jan 2021 19:00:45 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d26so34098514wrb.12
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Jan 2021 19:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HGZSbDE1S8dLwDUubmWWNOWFcP77/2fDqNh7XXF388=;
        b=LAP5bZJRQZqq7sDkIjok+i7EWA94y0V8wNbnuQ3DiLGVTCHKiQUWzR2BjcYf9h3PAN
         nBkuCUtjPJ/1MqIATJG1PLRC5KnzInyxJeqhu+g+EXdwlIvVJ8aH4ria49HXzcItk/Vv
         3gduz8Qu37+gzw6eg3wcCnlGpYdTEX6dp+OaFxYSyiwBU5UW9oBivFNzKfvQFGPy9KC4
         kHnNyhT4fjLuLbic7Eee86R3bj0XTL2p478BRffgvO/8LpfeHWB/WLdH4v0Tyr7wygTw
         z3BR13mw+ASNgCaXLmxATGLT2mmqe/OdPVNNJVY7ZVdGY4Wrvk5pJJxFhVG4qEacx2bH
         8lvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HGZSbDE1S8dLwDUubmWWNOWFcP77/2fDqNh7XXF388=;
        b=L0iX9Jim2KEx8RAShDZSZAwjqOAh2EDkSWyQa9af0jcwdZ/lCdT+x59sjp6d9MXsI0
         WbNR3igl8U2phnvP1kOFbmutr9+E70iLjYx0/Nqbk6JJdPpo1J3VldLV42bE7u2ENmqV
         1VLr5uesnPzeaNCD2YcTy2GmZkPbnzINlOTm1LTEg8j9c89SJjuyfXI9+9PbDBKWAWv4
         jSN/1UNFgtp3nuIVZAuo6c8dH1WCN3RyQgSoXM5RtwvAGJVyRjaAhVZ2/yk+bE7xrjL4
         kUiZaAa+OJlNgDWqCuzdS41V9YHerhpaFZNfjXS8DXgdZ/d8NJzv6btPPViJF5OOW431
         UyNw==
X-Gm-Message-State: AOAM531Sls7GOEg+PLBbOGT4dLDXPYZCmDI1UrbJKENg6e3w+Vw9B2n7
        vYpZ1Xqlmj57OeSxvzHfRjg9WflEZhkk/2b+rUvEAr9bWcMffA==
X-Google-Smtp-Source: ABdhPJwwb3gHHYamR77h33qVpwOeyz88p4PjccZPXIaiSmCJ1TnwqcNjwqA/u5nSrzP7kUpEPjP8rPhQgRT8vmmMxvo=
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr82601202wrw.42.1609815643573;
 Mon, 04 Jan 2021 19:00:43 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBehVoPJxcdwD6wiohR9pSfAdSvzXabz6ohyFQibQ_VrxQ@mail.gmail.com>
In-Reply-To: <CAN4oSBehVoPJxcdwD6wiohR9pSfAdSvzXabz6ohyFQibQ_VrxQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 Jan 2021 20:00:27 -0700
Message-ID: <CAJCQCtRx1kRDdDF7vK=9Y8vLS1azX5-Bh+_OosyqU=GuHhEv1w@mail.gmail.com>
Subject: Re: btrfs receive eats CoW attributes
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 4, 2021 at 7:42 PM Cerem Cem ASLAN <ceremcem@ceremcem.net> wrote:
>
> I need my backups exactly same data, including the file attributes.
> Apparently "btrfs receive" ignores the CoW attribute. Here is the
> reproduction:
>
> btrfs sub create ./a
> mkdir a/b
> chattr +C a/b
> echo "hello" > a/b/file
> btrfs sub snap -r ./a ./a.ro
> mkdir x
> btrfs send a.ro | btrfs receive x
> lsattr a.ro
> lsattr x/a.ro
>
> Result is:
>
> # lsattr a.ro
> ---------------C--- a.ro/b
> # lsattr x/a.ro
> ------------------- x/a.ro/b
>
> Expected: x/a.ro/b folder should have CoW disabled (same as a.ro/b folder)
>
> How can I workaround this issue in order to have correct attributes in
> my backups?

It's the exact opposite issue with chattr +c (or btrfs property set
compression), you can't shake it off :)

I think we might need 'btrfs receive' to gain a new flag that filters
some or all of these? And the filter would be something like
--exclude=$1,$2,$3 and --exclude=all

I have no strong opinion on what should be the default. But I think
probably the default should be "do not preserve any" because these
features aren't mkfs or mount time defaults, so I'd make preservation
explicitly opt in like they were on the original file system.


-- 
Chris Murphy
