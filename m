Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0CC386C4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 23:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbhEQVeY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 17:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237583AbhEQVeY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 17:34:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE3AC06175F
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 14:33:06 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p20so9003607ljj.8
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiJZ32oScv7m1zG+HAZWQ025LTPY+uZIZxxPrDNtO68=;
        b=CX90tBycAt/a9ap0XhQ5a2CbhLjIYmXx/RbWktAmmGtyKUdNqMXIDLXg9tktJ93U/1
         6e41uY2jKeGuZZYpoIZe5zo87ZhLQu9fL9tImW+3DGJmNzxHnwhQj+EXTY7UQ/5JFfG7
         1VWuVB9RrkhYPVoJyq+rF8H0HM19LRTTPwqkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiJZ32oScv7m1zG+HAZWQ025LTPY+uZIZxxPrDNtO68=;
        b=QpIgb4oCqwXamGZVno91rVuL9ML5NVVKgOc4fl5J96tDePlw/HOE0J4Spp2VN+P7MT
         WqBDsCI1fv1708cCPDC999Lm8+HOy/J0B50arAcQWFpZDHU6+61T9XiZlrzQFaPDTude
         w3hFJGgDlsKgImLZPWR8uvF5szYgBJZIT4ztea8T+lpSTTtgkb1BvEVs/q1JGOt1OWkb
         rT/n1GsiIjDMLO4LDEiB4akz/ICkwSilKiHThsKG4yxNRmLWJShCV36NmhBy221sDDoi
         HJcg+7T9D7l2FTSsyJftAYKkjkF9VgjVIXNHid7M6OijpXZSjnYWc8+Yx0InXsmxPUKe
         vcWA==
X-Gm-Message-State: AOAM531moDASxFkwLINekMb4W9ixz4Q3tA5i8jTbc5L6KtP89UIlSIwX
        tYrl7g98nMcVjasAjqht/P+yBEz4gjzmzHbc
X-Google-Smtp-Source: ABdhPJwW8EZizFnCmrj/SBrxrKzDDC9A+tG3+k+O13Q5nK9xhfTkm0J6nYi/5CC/P4oBne4MvKqM1g==
X-Received: by 2002:a2e:8e67:: with SMTP id t7mr1090552ljk.264.1621287185169;
        Mon, 17 May 2021 14:33:05 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id a25sm2067092lfl.38.2021.05.17.14.33.03
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 14:33:03 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id y9so9011322ljn.6
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 14:33:03 -0700 (PDT)
X-Received: by 2002:a2e:968e:: with SMTP id q14mr1065866lji.507.1621287183341;
 Mon, 17 May 2021 14:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621276134.git.osandov@fb.com>
In-Reply-To: <cover.1621276134.git.osandov@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 May 2021 14:32:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
Message-ID: <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
Subject: Re: [PATCH RERESEND v9 0/9] fs: interface for directly
 reading/writing compressed data
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
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

On Mon, May 17, 2021 at 11:35 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> Patches 1-3 add the VFS support, UAPI, and documentation. Patches 4-7
> are Btrfs prep patches. Patch 8 adds Btrfs encoded read support and
> patch 9 adds Btrfs encoded write support.

I don't love the RWF_ENCODED flag, but if that's the way people think
this should be done, as a model this looks reasonable to me.

I'm not sure what the deal with the encryption metadata is. I realize
there is currently only one encryption type ("none") in this series,
but it's not clear how any other encryption type would actually ever
be described. It's not like you can pass in the key (well, I guess
passing in the key would be fine, but passing it back out certainly
would not be).  A key ID from a keyring?

So there's presumably some future plan for it, but it would be good to
verify that that plan makes sense..

                            Linus
