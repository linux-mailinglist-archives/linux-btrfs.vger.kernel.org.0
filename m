Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF561F9924
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgFONkk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 09:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbgFONkj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 09:40:39 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA12C061A0E;
        Mon, 15 Jun 2020 06:40:39 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id q69so3923975vkq.10;
        Mon, 15 Jun 2020 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ElaXRnkNmeRMuixjwpXiTNYKpSD0dU9yi1zQJdGOluc=;
        b=gHc+o9kgsumsCqjFesloEU/ufyWX3VJyGjRWxqDxYYrVadZMzpQraiPKM4R2zuvFiR
         RheoNEJW7LqiQmhnQlXxlIC2qFIkde7Qq5se95PpPOwJWDj1AgZOBP7uv2ZG5rSTVXA2
         KMkipN8Th899KgSJGXhQg+0e91S8wU7ku5NxCDhl2Ax9QZ6nbDYEz68b8DFI7Pnnvn6y
         wax7l16e4qLJ+rYAzCUHPVFmwiIJ7iuQzoFRp46BdWzHvWNcT/DrbtJ0qRIpjHTJ0Lzp
         LiJ8ZIUOoO6iyavd6kIh8sWBxmMu7kbg2t7Bu9RJvj5earU32OF2/Sz0wZW8uN/kYHA7
         4xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ElaXRnkNmeRMuixjwpXiTNYKpSD0dU9yi1zQJdGOluc=;
        b=KEQG2MJnYcTh+X9PVMQDHFjU1xd5IqULvPweUJ+CtCF5FL+h/+1jdyA66oFBJF5jpT
         dgbsyNEqxFJReMPVTMGfN3G7KGNcz8Zvxbm579MRZphhNgwQkdVB080M2XYMN1mxZVRE
         wfeEa8q5J+Q/7LP4ZoYXrHuUdw3z111nLlb+Yb2yUI2E8FQNGz9fAX8n+RB/PBsHUJiU
         2IpXEKBOVTpznaYkzl10GpI21kjmwk3h7XHXkuwjGeu29Lz/EzcGH9wwBKhogWYPbqeX
         +2AFLcpyBB4CaOS0XIr/EKDhO0KmwXe0unYV/WxCPJntdvs6LMvn6jEVAYwYvq2UkhxH
         6c7A==
X-Gm-Message-State: AOAM530xz9GWY1nj9Cz77Cfqi2VDsFIeDrosmE/+T/kjaATmlVNG1bbS
        U7fizvf6YenmeXo2fq6pBhIST2zkrkxzEmPk9EM=
X-Google-Smtp-Source: ABdhPJzMsRmgLZgO5xdVqsMeaOp9UyayolhyawQghYl9NToy2NJyfX8dqzUamTlqtF5+WFy1lmHCyClZU5ofEEU+LkQ=
X-Received: by 2002:a1f:de43:: with SMTP id v64mr17099201vkg.13.1592228438394;
 Mon, 15 Jun 2020 06:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592135316.git.dsterba@suse.com> <CAHk-=whbO-6zmwfQaX2=cDfsq_sN1PZ6_CAbqLgw3DUptnFrPg@mail.gmail.com>
 <20200615125701.GY27795@twin.jikos.cz> <20200615132632.GA27848@infradead.org>
In-Reply-To: <20200615132632.GA27848@infradead.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 15 Jun 2020 14:40:26 +0100
Message-ID: <CAL3q7H52qbmGdoq4U6ChZrqFBz+ufpfqJoRZBNhWnJVaAeKm=g@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.8, part 2
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dsterba@suse.cz, Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 15, 2020 at 2:29 PM Christoph Hellwig <hch@infradead.org> wrote=
:
>
> On Mon, Jun 15, 2020 at 02:57:01PM +0200, David Sterba wrote:
> > On Sun, Jun 14, 2020 at 09:50:17AM -0700, Linus Torvalds wrote:
> > > On Sun, Jun 14, 2020 at 4:56 AM David Sterba <dsterba@suse.com> wrote=
:
> > > >
> > > > Reverts are not great, but under current circumstances I don't see
> > > > better options.
> > >
> > > Pulled. Are people discussing how to make iomap work for everybody?
> > > It's a bit sad if we can't have the major filesystems move away from
> > > the old buffer head interfaces to a common more modern one..
> >
> > Yes, it's fixable and we definitely want to move to iomap. The direct t=
o
> > buffered fallback would fix one of the problems, but this would also
> > mean that xfs would start doing that. Such change should be treated mor=
e
> > like a feature development than a bugfix, imposed by another filesystem=
,
> > and xfs people rightfully complained.
>
> We can trivially key that off a flag at least for 5.8.  I suspect the
> fallback actually is the right thing for XFS in the long run for that
> particular case.

We also have another regression (a deadlock) [1] introduced by the patchset=
.
I haven't looked into detail to figure out if it can be completely
solved in btrfs or if it would need a change on iomap.
Goldwyn was looking into it, but I don't know if he made any progress.

[1] https://lore.kernel.org/linux-btrfs/CAL3q7H4F9iQJy3tgwZrWOKwenAnnn7oSth=
QZUMEJ_vWx3WE3WQ@mail.gmail.com/#t

--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
