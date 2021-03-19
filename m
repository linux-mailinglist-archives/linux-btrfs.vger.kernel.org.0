Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5D13426AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 21:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhCSUIs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhCSUIZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 16:08:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ABBC06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 13:08:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q13so11839025lfu.8
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/0awmwbYpldGtvhGbGrjtgg5S5AmtnvrJ31RfQjWzg=;
        b=Udu99pfuLvrG3/uGIHBn854uuyD2MnagNpLodzU1KeSa2MMu8iHwpvgaE2s5sLcD22
         weRb6idNCOSd97o1eHiD3ISp6GYnVz2SUXOIzQcXDYj1Oz/8mwXreNqGUuJeQNjkMvkB
         hBIs/RjQ8pcafCqVnLFRmLTU+wZUiLkOdJY5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/0awmwbYpldGtvhGbGrjtgg5S5AmtnvrJ31RfQjWzg=;
        b=hzVHyIauxjoYotrcgLzruRZY6dKyTAFV3YW4o24Im3Y9hdko/45uQ9GDUfNuRlsF52
         ubOgqYGJwInIs3/L3+RTd3UfJZu+O3a4LZ0Ik5p5YK2T8g/jooPIB04Qx+CTcP8C7mem
         WwShnkn0NLw5SQuYk5k85E2dDJnMO+/YCBNGxKlY25W9JMgr+pXtmHDINOXEsWX4GhPI
         Ryx2htXt29hoSuNWJTR/EnejKSlIoCqNKiYwH1oHPuTZFCgIdUc2+q9LZDoNEZeHJ0q2
         9/yyPXcBImdq/fW8p2dCxtmYyrr7iJ4a3jxpe5Iy2Xj4oZFa+r+zR/yOZv/w01x8nziG
         UPLQ==
X-Gm-Message-State: AOAM530Zq22+R60OW7oNOMLhE5GoogzmVpFROiLmrnmSnxO/3yDmgtZQ
        upiA87eCHuhDDBQe83dzk2o8HG51jbBF4Q==
X-Google-Smtp-Source: ABdhPJzTZ3e6VolEoYrdKqjlClgvhkaJ13wC7BpD79lYwHlUZ5hs0lqoJp7O0P0/ft00AZYgAo3+rw==
X-Received: by 2002:a05:6512:31d6:: with SMTP id j22mr1725400lfe.637.1616184502948;
        Fri, 19 Mar 2021 13:08:22 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 200sm134579lfm.215.2021.03.19.13.08.21
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 13:08:22 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id o10so11840266lfb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 13:08:21 -0700 (PDT)
X-Received: by 2002:a05:6512:33cc:: with SMTP id d12mr1663604lfg.487.1616184501624;
 Fri, 19 Mar 2021 13:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615922644.git.osandov@fb.com> <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
In-Reply-To: <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Mar 2021 13:08:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
Message-ID: <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
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

On Fri, Mar 19, 2021 at 11:21 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Can we get some movement on this?  Omar is sort of spinning his wheels here
> trying to get this stuff merged, no major changes have been done in a few
> postings.

I'm not Al, and I absolutely detest the IOCB_ENCODED thing, and want
more explanations of why this should be done that way, and pollute our
iov_iter handling EVEN MORE.

Our iov_iter stuff isn't the most legible, and I don't understand why
anybody would ever think it's a good idea to spread what is clearly a
"struct" inside multiple different iov extents.

Honestly, this sounds way more like an ioctl interface than
read/write. We've done that before.

But if it has to be done with an iov_iter, is there *any* reason to
not make it be a hard rule that iov[0] should not be the entirely of
the struct, and the code shouldn't ever need to iterate?

Also I see references to the man-page, but honestly, that's not how
the kernel UAPI should be defined ("just read the man-page"), plus I
refuse to live in the 70's, and consider troff to be an atrocious
format.

So make the UAPI explanation for this horror be in a legible format
that is actually part of the kernel so that I can read what the intent
is, instead of having to decode hieroglypics.

            Linus
