Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCAA4D3B5A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 21:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbiCIUt0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 15:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiCIUtY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 15:49:24 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124F3123C
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 12:48:24 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s25so5875401lfs.10
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 12:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGqeo2LtdIlvNqnd6R2s5eetiuT+hRt9mmDkO0Tckbg=;
        b=PWCsZlVycSx5+VU2FvKPokNaZvFARLZhdR+NloChOOsE5FG1pZlOARqcts3qtbEfiV
         Jac1mG8KWnbOw9MoSqlVRYlGu7wFIW/+vbmcBNGZj0T73vPlbfb4IVtymATFS/oyXcfM
         wPhJl5v4zoMSVNsy37CGUm/kJgR6HBdYc0ick=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGqeo2LtdIlvNqnd6R2s5eetiuT+hRt9mmDkO0Tckbg=;
        b=BMiE4+BHObRunar1d7bqsc5AosCFnPpburLzWUE9wrU9POEo8o5AIsQxkYD2wRTtZd
         kACIkdBo0fw7wkVt+Pq1bebQfgkJM9X/FJAENRIOgM/kVZrHdFWTzj1Q30MYDw1WARZO
         hKsOCJUM6kxS2tWGd62pCGYgHmXVYBz+Li/lpbS48hb6IEIjEwQyaQdk2jmru1wl5Q8A
         pZZ+GEbMMO+9eLI4iOS3utXiKegr/QM7Yl9ab2T6dYPTFwrKdj9mrwx7+F7HDVAqdZGx
         Qg+u4qQAN1Rrzx22yT52QVhpUauGI2rVKPaY9kraHiBd/e6qsEhybVBytHYGrwFoBrgq
         r9fA==
X-Gm-Message-State: AOAM5303JeiSmkiVlmJ6oHUtyWeiiPATS5ZCyJsiX3DIkONUuk3PpayI
        EWWFdyGZ3YojwQobBowT2bbFHxPpVFulUavZC7w=
X-Google-Smtp-Source: ABdhPJyK+Wn+UG7QRWkbKqgMUQ/pQax19aRQVOjY7vRsWK4vCkpehDjNGRhPSy4CHh510alYkhwggA==
X-Received: by 2002:a19:ad0a:0:b0:443:dc0d:b3ca with SMTP id t10-20020a19ad0a000000b00443dc0db3camr971177lfc.239.1646858902768;
        Wed, 09 Mar 2022 12:48:22 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id d16-20020a2eb050000000b002461d8f365bsm632817ljl.38.2022.03.09.12.48.19
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:48:19 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id w7so5916837lfd.6
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 12:48:19 -0800 (PST)
X-Received: by 2002:ac2:41cf:0:b0:448:1eaa:296c with SMTP id
 d15-20020ac241cf000000b004481eaa296cmr917150lfi.52.1646858899041; Wed, 09 Mar
 2022 12:48:19 -0800 (PST)
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
 <CAHk-=wj4Av2gecvTfExCq-d2cXx0m7fdO0sG6JC1DxdCCDT7ig@mail.gmail.com> <CAHc6FU4uzG+HR1doK5p+6kVW9GS0JGbCrbZnAvBhWuLZe8DGUw@mail.gmail.com>
In-Reply-To: <CAHc6FU4uzG+HR1doK5p+6kVW9GS0JGbCrbZnAvBhWuLZe8DGUw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 12:48:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whycC7kUa=_CiDr9pPpPp8g+9u7kKe1ssSsgGGkhBTvVg@mail.gmail.com>
Message-ID: <CAHk-=whycC7kUa=_CiDr9pPpPp8g+9u7kKe1ssSsgGGkhBTvVg@mail.gmail.com>
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

On Wed, Mar 9, 2022 at 12:37 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> It's a moot point now, but I don't think handle_mm_fault would have
> returned VM_FAULT_RETRY without FAULT_FLAG_ALLOW_RETRY, so there
> wouldn't have been any NULL pointer accesses.

No, it really does - FAULT_FLAG_KILLABLE will trigger the code in
page_lock_or_retry() (->__folio_lock_or_retry) even without
FAULT_FLAG_ALLOW_RETRY.

So lock_page_or_retry() will drop the mmap_sem and return false, and
then you have

        locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);

        if (!locked) {
                ret |= VM_FAULT_RETRY;
                goto out_release;
        }

for the swapin case.

And mm/filemap.c has essentially the same logic in
lock_folio_maybe_drop_mmap(), although the syntax is quite different.

Basically FAULT_FLAG_KILLABLE implies a kind of "half-way ALLOW_RETRY"
- allow aborting, but only for the fatal signal case.

                  Linus
