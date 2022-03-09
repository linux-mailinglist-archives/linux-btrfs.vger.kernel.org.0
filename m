Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8549F4D3B71
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 21:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbiCIU4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 15:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiCIU4S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 15:56:18 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D27BF97F
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 12:55:18 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s25so4986593lji.5
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 12:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bcy1f96gz5DOfDjysAb1zu3cyQLaBT/MRqS63v2E8I=;
        b=HuhGkeK5Ax0l2g8f3/ZOEcuWQLabru0yBo4ttRCDmj0RcqKtz3ZUVaVLY1qklVIkSb
         sJXJZE4lYyo8vwtAh7nXgTRKAmiM62TiA9y3Vgm4oVeD96UK4y4pIDYlBeHKKACnV0uD
         rg4f7RRavY66vPc2Rk++aFQ/GGv88Akm6CMX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bcy1f96gz5DOfDjysAb1zu3cyQLaBT/MRqS63v2E8I=;
        b=oH6RS7gYpz5TsceKIjmR3rufSMr96V6iJXvtaQrwtqK/EENGDYNv5k7qHS3mFWQ/zT
         4r+gzzAjWDpEAqgfg0gUzthLDR2Mk7vLa2FsFHHROoHKWC1Sv2KfvZ9cUTNVWjFcO0jD
         lBeF0TXBzxj4aQp1RT8Xvj0ZrPc9fSv1m9TO1ePmvAyPvIVQ5hrCW4bZhtZcC1Q4aR4p
         v3KnmcX14wDRXSpm3fxv3VtcaskCG0ruRKKWhsynl2a2wFu6YgjqTH2qhJQqQdqKj3s0
         euipFCiHweGRXG3QAunTodu/2AXaxGY2Q/KYh2a8KOo2IEFfOXgJXfke8Td6IYXsMHOE
         0ZIQ==
X-Gm-Message-State: AOAM533nAxflpqMyo8o09Vk0jAEjk73Bxoeh+Q36x4Qxu9g1r8BBy9xU
        1aotjPNuEfvufNEM8fCWv5Dv5scs1HLWzEUpRsk=
X-Google-Smtp-Source: ABdhPJymZesJe/y8oU7PrYi/plDyhp4MXMqXDlHcMgX41rvS0XHhsBeDIr0bPvVTOQRp2RTq7V+/Dg==
X-Received: by 2002:a05:651c:1404:b0:244:32ad:42e8 with SMTP id u4-20020a05651c140400b0024432ad42e8mr860183lje.7.1646859316728;
        Wed, 09 Mar 2022 12:55:16 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k1-20020a2ea281000000b00244bc2ecfe9sm614069lja.66.2022.03.09.12.55.12
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:55:14 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id u3so5044635ljd.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 12:55:12 -0800 (PST)
X-Received: by 2002:a05:651c:19a9:b0:247:e199:4364 with SMTP id
 bx41-20020a05651c19a900b00247e1994364mr896569ljb.164.1646859312017; Wed, 09
 Mar 2022 12:55:12 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
 <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
 <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
 <20220309184238.1583093-1-agruenba@redhat.com> <CAHk-=wixOLK1Xp-LKhqEWEh3SxGak_ziwR0_fi8uMzY5ZYBzbg@mail.gmail.com>
 <CAHc6FU6aqqYO4d5x3=73bxr+9yfL6CLJeGGzFwCZCy9wzApgwQ@mail.gmail.com>
 <CAHk-=wj4Av2gecvTfExCq-d2cXx0m7fdO0sG6JC1DxdCCDT7ig@mail.gmail.com>
 <CAHc6FU4uzG+HR1doK5p+6kVW9GS0JGbCrbZnAvBhWuLZe8DGUw@mail.gmail.com> <CAHk-=whycC7kUa=_CiDr9pPpPp8g+9u7kKe1ssSsgGGkhBTvVg@mail.gmail.com>
In-Reply-To: <CAHk-=whycC7kUa=_CiDr9pPpPp8g+9u7kKe1ssSsgGGkhBTvVg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 12:54:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+U6SkJtNeWCJBaKv31dQALfXn_jCSo9=o5p-_==bBrA@mail.gmail.com>
Message-ID: <CAHk-=wh+U6SkJtNeWCJBaKv31dQALfXn_jCSo9=o5p-_==bBrA@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
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

On Wed, Mar 9, 2022 at 12:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Basically FAULT_FLAG_KILLABLE implies a kind of "half-way ALLOW_RETRY"
> - allow aborting, but only for the fatal signal case.

Side note: I'm not saying this is a *good* thing - it is very
confusing - but it's due to historical reasons where architectures
ended up getting these features incrementally.

So FAULT_FLAG_KILLABLE was one such half-way step, where you could
abort things without actually retrying them, because a fatal signal
could be handled without then repeating things.

These days, I think all architectures have converted their actual
fault handling to the full "retry/abort/error/success" spectrum, but
then you still have other uses of handle_mm_fault() that may not be
willing to have mmap_sem be dropped in the middle of operations
because they keep a 'vma' list around or something like that.

And then FAULT_FLAG_KILLABLE can still be a good way to say "ok, I'm
willing to _abort_ things entirely, but you can't drop the mmap sem
and ask me to recover if it's not fatal".

And this is all entirely due to historical behavior, since
_originally_ handle_mm_fault() wouldn't ever drop mmap_sem at all.
These days it would probably be simpler to *not* have all these
complicated special cases, and just say that FAULT_FLAG_ALLOW_RETRY is
always true.

But then somebody would have to walk through every user to make sure it's ok...

           Linus
