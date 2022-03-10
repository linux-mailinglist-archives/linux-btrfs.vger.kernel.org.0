Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410634D51DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 20:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243339AbiCJTXY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 14:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiCJTXX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 14:23:23 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED0AF1191
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 11:22:21 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id h11so9181471ljb.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 11:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHGuzVLaCZTJR5Z/FIfYDsWY8nrsVyf9XB/r18bCkXI=;
        b=ep7XFBy0Q99M5ouVxkQy/Xu+D2RZ7bpJRAdEIb9jXanfP8Lx6Lp5YBbGfSecYfO6B+
         2GOiehczcxMm6X1BX+TQuCcgQF28n9vabec+jv5ZwC9I+//4EvcchXvD9GydAvFCw2ua
         Uw2lQ/BCnimAOmwaI85VX66awfuh3v1U2bb5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHGuzVLaCZTJR5Z/FIfYDsWY8nrsVyf9XB/r18bCkXI=;
        b=Uty4Xj3aI5FqjA1qKvwJQD6V2IZUzIRfQ3XIDzaoLtUNueC3BW5a0SYgxZonDnisH5
         dW7vkYFqBKuWfu2BTxr8jgATKgzC036Nf3KokrmvlnQUrizoov4ucFRpZbQv0/T4C7ZJ
         spRz3BDECsqer0Hg9Fl9pI8y/xiwIOM9ScJZRyk2WUjreU/3FEGJWqu7RKqLq7IbvKSz
         dZloW9AhJ8gJMYoOPjAmbIcvLZC2LxjvmEsQt4KCp/Kb6P4bjNXg7eztNg7hrjSzEZNP
         nj1nFMKyubbIGQDLmg6S7H6JfClx8p3zkZtAcRUn8tknN7jRe/k+WksTv4yFvpdnhEBV
         OTBg==
X-Gm-Message-State: AOAM533btQ6hKPNu844R8qGOZbMoEYN6KQDrPcBFlPTC+eVv2J6KpGTl
        SPjJELgkoN1Qt1Xty6GjzoHhrFnZF24JVVYChyA=
X-Google-Smtp-Source: ABdhPJweC9kASkH7XI9M/ULzoYzEhwuL6gqG4FoBnkwB7rctsWFfwQrgEl4m2HcLp/DFuVVp14qL6g==
X-Received: by 2002:a2e:9c02:0:b0:246:585f:d127 with SMTP id s2-20020a2e9c02000000b00246585fd127mr3928196lji.244.1646940139530;
        Thu, 10 Mar 2022 11:22:19 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id bi2-20020a0565120e8200b004484aaaf818sm1136659lfb.13.2022.03.10.11.22.17
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:22:18 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id z26so9159107lji.8
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 11:22:17 -0800 (PST)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr4029456ljg.176.1646940137523; Thu, 10
 Mar 2022 11:22:17 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com> <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
 <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com>
In-Reply-To: <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 11:22:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXEQ9+NedP6LRbAXGTHrT4MZSPRvbJAFmgrDh75GpE2Q@mail.gmail.com>
Message-ID: <CAHk-=wiXEQ9+NedP6LRbAXGTHrT4MZSPRvbJAFmgrDh75GpE2Q@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 10, 2022 at 10:48 AM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> Works for me. This should probably still be tagged as:
>
> Fixes: cdd591fc86e3 ("iov_iter: Introduce fault_in_iov_iter_writeable")
> Cc: stable@vger.kernel.org # v5.16+

Yeah, I had already added the "Fixes" line there (and it makes the
stable one unnecessary).

            Linus
