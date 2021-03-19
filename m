Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D7E3427F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 22:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhCSVri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 17:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCSVrX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 17:47:23 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B4DC061761
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 14:47:23 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y1so13673531ljm.10
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6aTi9USXUTEe6463tZeUFfEF6sydMc4F3aHzBvCJTg=;
        b=EVtmZajDtoqqVNxo4gyn0Tekfg+N2EalnddFD5XT8VNUvhcJONV0/s2Heiwtgg/XEu
         Jo9KfgMdjGMAoM5ySFRHJGYq+wD1juQy4450shqWKbaECyQ2+tHotorC/Fh3vCah1/gh
         VNS8lE91M6kD7wqZS20wJD/pq9hJ4BfB/aGbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6aTi9USXUTEe6463tZeUFfEF6sydMc4F3aHzBvCJTg=;
        b=WzJOLTBDx0zOWiHn4k6eKa0dtsATEcC0Kx3xF0TnbyHwqTE1CPfR8bhbaGvv4Cgm0B
         IySE/u3HIRCCsfrje3DXMXuHimI0/VdyNdXnPmhhNUmJpkHXXCtIfegC7hgWYwktJWT9
         fBAvRZCrLPwerN5xRpw5YjqvPhw2FdXC8s9liOIOob06CJ0QjKTJXXvVMi+fRw+13GEv
         2PvmEmtHCqjbtPTte5KfZ7ViQBcxi+zheTGqBkex0Dg45u6T9/1en4bH39sBUi43Sa5G
         1HzIqa2qREESb3MU25ZnzNxZ8BtotxfDm8jagP//hJE6VW5jjXRjwdFZOs51HPxviA3T
         HbnQ==
X-Gm-Message-State: AOAM533DXMAYt7Bnyz+aBtq+kXdyzjEs0ObE9kqOFhXYgOJI3NMroz/M
        p5+f5n1lZABIo/GZLxw4dkOl08kbXQiziA==
X-Google-Smtp-Source: ABdhPJzPU/ZVYDHk39o9atynu5We9fJBdk/gUDhjaIHMXDmxOx0TtezV7quSXEb/jES9SC5AgaFvmA==
X-Received: by 2002:a2e:b011:: with SMTP id y17mr2122844ljk.390.1616190441509;
        Fri, 19 Mar 2021 14:47:21 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id g21sm743767lfr.212.2021.03.19.14.47.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 14:47:20 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id f3so3825901lfu.5
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 14:47:20 -0700 (PDT)
X-Received: by 2002:ac2:4250:: with SMTP id m16mr1890000lfl.40.1616190439785;
 Fri, 19 Mar 2021 14:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615922644.git.osandov@fb.com> <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
 <YFUJLUnXnsv9X/vN@relinquished.localdomain> <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
 <YFUTnDaCdjWHHht5@relinquished.localdomain>
In-Reply-To: <YFUTnDaCdjWHHht5@relinquished.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Mar 2021 14:47:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhSP88EcBnqVZQhGa4M6Tp5Zii4GCBoNBBdcAc3PUYbg@mail.gmail.com>
Message-ID: <CAHk-=wjhSP88EcBnqVZQhGa4M6Tp5Zii4GCBoNBBdcAc3PUYbg@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 19, 2021 at 2:12 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> After spending a few minutes trying to simplify copy_struct_from_iter(),
> it's honestly easier to just use the iterate_all_kinds() craziness than
> open coding it to only operate on iov[0]. But that's an implementation
> detail, and we can trivially make the interface stricter:

This is an improvement, but talking about the iterate_all_kinds()
craziness, I think your existing code is broken.

That third case (kernel pointer source):

+    copy = min(ksize - copied, v.iov_len);
+    memcpy(dst + copied, v.iov_base, copy);
+    if (memchr_inv(v.iov_base, 0, v.iov_len))
+        return -E2BIG;

can't be right. Aren't you checking that it's *all* zero, even the
part you copied?

Our iov_iter stuff is really complicated already, this is part of why
I'm not a huge fan of using it.

I still suspect you'd be better off not using the iterate_all_kinds()
thing at all, and just explicitly checking ITER_BVEC/ITER_KVEC
manually.

Because you can play games like fooling your "copy_struct_from_iter()"
to not copy anything at all with ITER_DISCARD, can't you?

Which then sounds like it might end up being useful as a kernel data
leak, because it will use some random uninitialized kernel memory for
the structure.

Now, I don't think you can actually get that ITER_DISCARD case, so
this is not *really* a problem, but it's another example of how that
iterate_all_kinds() thing has these subtle cases embedded into it.

The whole point of copy_struct_from_iter() is presumably to be the
same kind of "obviously safe" interface as copy_struct_from_user() is
meant to be, so these subtle cases just then make me go "Hmm".

I think just open-coding this when  you know there is no actual
looping going on, and the data has to be at the *beginning*, should be
fairly simple. What makes iterate_all_kinds() complicated is that
iteration, the fact that there can be empty entries in there, but it's
also that "iov_offset" thing etc.

For the case where you just (a) require that iov_offset is zero, and
(b) everything has to fit into the very first iov entry (regardless of
what type that iov entry is), I think you actually end up with a much
simpler model.

I do realize that I am perhaps concentrating a bit too much on this
one part of the patch series, but the iov_iter thing has bitten us
before. And it has bitten really core developers and then Al has had
to fix up mistakes.

In fact, it wasn't that long ago that I asked Al to verify code I
wrote, because I was worried about having missed something subtle. So
now when I see these iov_iter users, it just makes me go all nervous.

          Linus
