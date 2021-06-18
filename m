Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7AA3AD260
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhFRSw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 14:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbhFRSwy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 14:52:54 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B31C061760
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 11:50:45 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id k8so15229127lja.4
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9O4pmyP/vSvHJYgWv9Om+E3eGkH5o7mKzQ/WCRHcUE=;
        b=D/ni6iaZuLdcRoE55isBo9vR44yQpZtJdOHWiLpCJlhn5F7w1t34r2mAAgw5DFrpOd
         BcbFVIwClkEhZr/tnURZcly1r7HrlRB62reaqLW9r0QujJtk4J5Sm51sK7Ksm0QMIRFE
         TiSqMXghajOfx722+wfU/dD2HkEa2LGn7+H9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9O4pmyP/vSvHJYgWv9Om+E3eGkH5o7mKzQ/WCRHcUE=;
        b=HyZ929L995MtYHgzqRj1j24f+Fg1zp8Rh7J5lsDi/QCjfpzsul1XMwqN+uIXQaf+rY
         2gi0MS7iCxH0afsgMrllZRishcCOt6w226kJXFl6XbzU5oT8KoF6fgNtQgaEo4bpLqug
         qoPfoesSGZJ7j4Roq0R/fPNng9AVVc76Ws9ToS2Net1mDWbhFnjMfQrqpOp3bDRqr+TK
         QJaht0im+gTzwZWLMaT8zz3QY4iVAls8GkfaNq43KL4ZKfNe9MNAmtKgsfgEDQTUW0pc
         E4G6egYnU0IpBMslreEqybP8iweByim2dN5olxC7SgwRStCL2Te9B3vPHL44p1l1kSnW
         77VA==
X-Gm-Message-State: AOAM531/oQxKpC6BvliprCwdz041TsLtunPdm3vredX1SDgJ3k26BQN4
        vSBeOmVgAm8b2ycXwzo/CfllLnyOTguHbJB+
X-Google-Smtp-Source: ABdhPJxQQ2L5xOUyKpBsm7TxRnmesoi0lycugld5nyg6/9K1fqdxaSL0ZKkeJc9KO0nhUajYbwdLCw==
X-Received: by 2002:a2e:700f:: with SMTP id l15mr10798845ljc.52.1624042242992;
        Fri, 18 Jun 2021 11:50:42 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i5sm984801lfe.113.2021.06.18.11.50.42
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 11:50:42 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 131so15355254ljj.3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 11:50:42 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr10545904ljh.507.1624042241910;
 Fri, 18 Jun 2021 11:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623972518.git.osandov@fb.com> <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
In-Reply-To: <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jun 2021 11:50:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
Message-ID: <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 17, 2021 at 4:51 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> This is essentially copy_struct_from_user() but for an iov_iter.

So I continue to think that this series looks fine - if we want this
interface at all.

I do note a few issues with this iov patch, though - partly probably
because I have been reading Al's cleanup patches that had some
optimizations in place.

And in particular, I now react to this:

> +       iov_iter_advance(i, usize);

at the end of copy_struct_from_iter().

It's very wasteful to use the generic iov_iter_advance() function,
when you just had special functions for each of the iterator cases.

Because that generic function will now just end up re-testing that
whole "what kind was it" and then do each kind separately.

So it would actually be a lot simpler and m,ore efficient to just do
that "advance" part as you go through the cases, iow just do

        iov_iter_iovec_advance(i, usize);

at the end of the iter_is_iovec/iter_is_kvec cases, and

        iov_iter_bvec_advance(i, usize)

for the bvec case.

I think that you may need it to be based on Al's series for that to
work, which might be inconvenient, though.

One other non-code issue: particularly since you only handle a subset
of the iov_iter cases, it would be nice to have an explanation for
_why_ those particular cases.

IOW, have some trivial explanation for each of the cases. "iovec" is
for regular read/write, what triggers the kvec and bvec cases?

But also, the other way around. Why doesn't the pipe case trigger? No
splice support?

              Linus
