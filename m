Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C095322CFE6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 22:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgGXUqx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 16:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgGXUqw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 16:46:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830DBC0619D3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 13:46:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so9429466wrw.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 13:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=weZZZXGZmYo0E5h4lo2itdSiO/5X8v37j62zoV8uhmQ=;
        b=tTlo05xOF9IevJq55RNbEma9VlSE3tTwXtoZDaGvkmQDVP1reOaZqEPf8qSwh8iwMY
         ppa8cogoT5hUQOG/rorG7162V9Tr3niisKYiyLGmRlHW4QdD3vwHsMA3t7lI48+KwPN0
         OpYQSn0vZ3Ifc7SI3ovRLMdKSDXDPVPsjgK039/yPB33Xn/K8nbETRgjrubWc/IYJxXJ
         wF+ytOonn9poR5yKLOmSr9WA5OP14b72r294lfzX51XHe0DCG4BqaVbXGs0kMkZdtWXN
         pfrwM1JPj8lr4ioH1sQYzLib8sSqAUubQREYxqQyqG1/YkYCLsA6PoQIeAoymrnoywTc
         8CgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=weZZZXGZmYo0E5h4lo2itdSiO/5X8v37j62zoV8uhmQ=;
        b=AIx36UyrGb102mDWu50d7RXqpQhOenkTqbkXsqgnmyCGqVW5GbpehH5ioe8lTMy1kk
         5cOBrxIg976jAroMxm/ZbipkTNJ1pUNhP0i+ZaHHUKc5NMhLIaBhqxQyyIV7Eli7JFq6
         34gbveRp9zUX4avN4vTNbV9ybglS+lFHWnoMYRu38YUqOE2zE/FJ3IfoJaAKad5IjD/C
         sQN85T1qTY4BrdAL5fQQhLTgMcjk3up1+3X741Yuqj6L19S22UTXFUQ8hxK1mWQBWxEP
         uajNmwgXmA0KP04ig/KN8UKaunUhgJbPXDwJt4R9uTokErb8hx0VfxucBLv097cLpiYe
         ChRA==
X-Gm-Message-State: AOAM531fnlyNcIWSD3MQH8y3s4YxbUqBOcbi5DXM9JaDJwNJq4sYymQM
        +8Br4E9PjP3/pDIiC+Az56M8hMtHVOtDAzIvhZFaHw==
X-Google-Smtp-Source: ABdhPJxNM7qz9IAz5LTyrUSWlm7x0AdeOQNXJN69xSt1ZzzdgKWYFhvVlMGC1lw+ZtM6YZdp6ReH9gA/EJhKK50U3AA=
X-Received: by 2002:adf:aace:: with SMTP id i14mr9878004wrc.236.1595623610869;
 Fri, 24 Jul 2020 13:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHzMYBTU=JuEsRX7YXzMJMELy63TXrm3J6onKnhGSOOzTnnMBg@mail.gmail.com>
 <CAJCQCtS6eS7a+wHR__A_aDujANWNJEmUMApjChVMk1WNuZ0BKg@mail.gmail.com> <CAHzMYBT8a9D817i2TRqdRiJFdmF-c3WVyo6HNgbv8bJqqOyr5g@mail.gmail.com>
In-Reply-To: <CAHzMYBT8a9D817i2TRqdRiJFdmF-c3WVyo6HNgbv8bJqqOyr5g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 24 Jul 2020 14:46:34 -0600
Message-ID: <CAJCQCtSeAKD_bVk7GUVyLdzdSZqR8O9zEX40kCmyR--DyWtSRw@mail.gmail.com>
Subject: Re: df free space not correct with raid1 pools with an odd number of devices
To:     Jorge Bastos <jorge.mrbastos@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 24, 2020 at 2:16 AM Jorge Bastos <jorge.mrbastos@gmail.com> wrote:
>
> > > Filesystem      Size  Used Avail Use% Mounted on
> > > /dev/sdd1       1.2T  3.4M  931G   1% /mnt/cache

Oh yeah Avail is clearly goofy.


> Filesystem      Size  Used Avail Use% Mounted on
> /dev/sdd1       699G  3.4M  466G   1% /mnt/cache


Anybody know what's up?


-- 
Chris Murphy
