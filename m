Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B06E72D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2019 14:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfJ1Nod (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Oct 2019 09:44:33 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:40180 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfJ1Nod (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Oct 2019 09:44:33 -0400
Received: by mail-wr1-f47.google.com with SMTP id o28so9946752wro.7
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2019 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNiOV+6+GU/KYL9atfQs9NOj0c1poYrF1KJUfSYG+HY=;
        b=D/PyAIoPi6WzND0pRBPIJOaCxIbNNSedGBxhSsIXr/qz8mpeQl1GgmayEl+ZUSCttt
         6mt24oVC4Fnzj8JZi7k6AlThJ2ClHgzkMDAA/vqE3/HIGq7E1pPUJzZ1EYqWM16uf/IV
         M1J0UIQQC3rcayQugi9ITAhVAXnEFBSgaHJedGkay+CtpM5atkQ9sc93BjU7OVrSXX9M
         nu5flZjaJ1zJtsvqnmT7lkh66WddQs8x61s11LoJGf0DcOhJcU8ExX5aplSTU/G+XYcz
         SPtmBlOochbPyKLcEyjyP3XKgqwQdNBi9nIl6pKtqwHTGr8o+9Lh/nBS7+/RIMf9YM0G
         7hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNiOV+6+GU/KYL9atfQs9NOj0c1poYrF1KJUfSYG+HY=;
        b=f9CtlgkMW4Emx2PU4bhm0unu5reJbpk2d+2JTvaZcuYAvTatgZuqzp4FsmIWMvsH3N
         lRAf1rCTe894ndrN/0sFv1ouBX9/D4um5y30UVrjGzr9rLttEtaqRfFFXP9HB7FWVY5f
         vfHJHGcaHC7ar5ys31941TE8CLNFgrCNQtyMGVHl2hbe/8VBx3cxBJgJzAQjVhRr3Ohm
         sVtl6oR8eqpeAEHIzKjC5nmM57Hwi1PmSDPn6e70u9t3DkVWyqR0VDqwuYLEIzwrZTHD
         Hr6dDoDpP0RO44eSgUrh9Z+KxFp9RkWWnbN0bJ/Jx7XOEzkgx4ia0qHyzZQztc0VqpUO
         7Yyw==
X-Gm-Message-State: APjAAAUGkoku1CkreOWqVNxTaW+Oav70QOn7AkFgRwXLwKjPpo1Cl2Kl
        4cUfg4six6bz+qwSJqd59WEZ7jvfLPb1pwpspII=
X-Google-Smtp-Source: APXvYqwlXrp3q/qbQ/uhuEqXb6SuGJ9ymGgcBCXaLEucFiADJoQQrp0ScnYPb80Oz1ZLisNkWuM/a35Ro8ciyQ62cyE=
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr15981099wrn.143.1572270271170;
 Mon, 28 Oct 2019 06:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com> <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com> <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
 <CAL3q7H4Wc0GnKNORVvwCOEk1QhzUweJr1JnN=+Scx5-TpQ5+yA@mail.gmail.com>
 <CAE4GHgntuxsoqv5vGMRTy6QYOTpQOocHgA2RxxeN6YKLgr5rNA@mail.gmail.com> <CAL3q7H5+xDr=0ZzW0+CnNqBh8ox9=rh8Vpp2aD4-jnXXnWCpgg@mail.gmail.com>
In-Reply-To: <CAL3q7H5+xDr=0ZzW0+CnNqBh8ox9=rh8Vpp2aD4-jnXXnWCpgg@mail.gmail.com>
From:   Atemu <atemu.main@gmail.com>
Date:   Mon, 28 Oct 2019 14:44:19 +0100
Message-ID: <CAE4GHgkvqVADtS4AzcQJxo0Q1jKQgKaW3JGp3SGdoinVo=C9eQ@mail.gmail.com>
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     fdmanana@gmail.com
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> You can run 'slabtop' while doing the send operation.
> That might be enough.
>
> It's very likely the backreference walking code, due to huge ulists
> (kmalloc-N slab), lots of btrfs_prelim_ref structures
> (btrfs_prelim_ref slab), etc.

I actually did run slabtop once but couldn't remember the exact name
of the top entry, so I didn't mention it.
Now that you mentioned the options though, I'm pretty sure it was
kmalloc-N. N was probably 64 but that I'm not sure about.

> Yes, it's likely a different bug. I don't think it's related either.

I have only seen these warnings after the bug triggered though,
reading the file under normal conditions doesn't produce them.

What would be the best way to get more information on how btrfs comes
to the conclusion that this file is corrupt?

> Ideally yes. But that's a lot harder to do for several reasons and in
> the end might not be worth it.

I see, thanks!

-Atemu
