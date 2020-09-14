Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E82D2690E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 17:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgINP6d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 11:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgINPr6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 11:47:58 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D487D208DB
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600098475;
        bh=qX6E8xnrHDxf53qM3vJDzeafEfDv9EhJl7jwfhYSDmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fwPedZznNQ462zVQga74+lwVrGBXFhOYSSqdO0vyI+nrwODV/ERv8c0AEaz0Gxr6h
         Pb/zppyOjKFC0qvgfvSfnQ36By15vzgmFJZLmincHuRN44AipX6j8FdAh5VVcRr0DH
         GX2Pa0ObMW9j7mTUDSf5GAsk7zVGW6JPDjBwuJck=
Received: by mail-qk1-f180.google.com with SMTP id t138so593904qka.0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 08:47:54 -0700 (PDT)
X-Gm-Message-State: AOAM530vYcGcP9Qz8XQ0pRJSOaPt1vmnGyJujihtRE8iVLdAqpdRI4V8
        /9HAzL81yDapABr5pokCaIl/FKLPc0YteuCAv1E=
X-Google-Smtp-Source: ABdhPJwwLitdLeIpcJwHrYGla2KJWyyAFBNBxuXwp9Jm6Qd0hxMTn/G23FVbNtxMi/dzW9qZugGZTkBsKEP8I2Zjk8s=
X-Received: by 2002:a37:a94b:: with SMTP id s72mr12698072qke.383.1600098474006;
 Mon, 14 Sep 2020 08:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <78bf853ef63f2dbd62587bb02bb723fbaa77c198.1600070418.git.fdmanana@suse.com>
 <8c2f5f20-3868-4291-5bed-b571c8ae61a0@toxicpanda.com>
In-Reply-To: <8c2f5f20-3868-4291-5bed-b571c8ae61a0@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 14 Sep 2020 16:47:42 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6p2PEQhCM+zhMGvawJgJiTsfRLsirMoANH3p8h3f5N2A@mail.gmail.com>
Message-ID: <CAL3q7H6p2PEQhCM+zhMGvawJgJiTsfRLsirMoANH3p8h3f5N2A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix wrong address when faulting in pages in the
 search ioctl
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 14, 2020 at 4:23 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 9/14/20 4:01 AM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When faulting in the pages for the user supplied buffer for the search
> > ioctl, we are passing only the base address of the buffer to the function
> > fault_in_pages_writeable(). This means that after the first iteration of
> > the while loop that searches for leaves, when we have a non-zero offset,
> > stored in 'sk_offset', we try to fault in a wrong page range.
> >
> > So fix this by adding the offset in 'sk_offset' to the base address of the
> > user supplied buffer when calling fault_in_pages_writeable().
> >
> > Several users have reported that the applications compsize and bees have
> > started to operate incorrectly since commit a48b73eca4ceb9 ("btrfs: fix
> > potential deadlock in the search ioctl") was added to stable trees, and
> > these applications make heavy use of the search ioctls. This fixes their
> > issues.
> >
> > Link: https://lore.kernel.org/linux-btrfs/632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se/
> > Link: https://github.com/kilobyte/compsize/issues/34
> > Tested-by: A L <mail@lechevalier.se>
> > Fixes: a48b73eca4ceb9 ("btrfs: fix potential deadlock in the search ioctl")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/ioctl.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 5f06aeb71823..b91444e810a5 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -2194,7 +2194,8 @@ static noinline int search_ioctl(struct inode *inode,
> >       key.offset = sk->min_offset;
> >
> >       while (1) {
> > -             ret = fault_in_pages_writeable(ubuf, *buf_size - sk_offset);
> > +             ret = fault_in_pages_writeable(ubuf + sk_offset,
> > +                                            *buf_size - sk_offset);
> >               if (ret)
> >                       break;
> >
> >
>
> Eesh, can we get an xfstest for this?

I would have written one if it were simple to trigger.
I don't think it's easy to trigger it deterministically or close
enough to deterministic.

How do you guarantee that a call to the ioctl will cause the pages to
fault in at any iteration of the loop?
That the pages aren't already faulted in, and then if you need to
fault them in, that happens on an iteration other than the first one?

Thanks.

>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks,
>
> Josef
