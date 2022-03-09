Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D444D25F6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 02:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiCIBOt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 20:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiCIBM5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 20:12:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D81A403ED
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 16:55:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e24so637641wrc.10
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 16:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOkhTNcLWPufcykwdZmZBF2oqQGok/K5B2vr+Tqh36g=;
        b=Vj4rshnTpWz5DU66OERET/pAsAiEtJHCvq1p7tYsuGWD7WJCMh23fM0fO4nZdPLYHC
         90pf8J0GgnEP+YZrzPyFs7Bg/J9pen3fzwCfz2wTn/gw4B+2lcPdZNWYCNfMWKpUwV9E
         ohAJR1uT0oUJ+kwVfBbrRuha/QYIMA/OMi3B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOkhTNcLWPufcykwdZmZBF2oqQGok/K5B2vr+Tqh36g=;
        b=3nqICJ6+7WwvAxfN4Pbiqa9gKk1nklhwsPr0ZCkFjOPeXL82x2JRFapLjMgNE9WAu7
         DtyBTz8Wk+pbplWlq4tdVTN0tiuuffS3iIu/7ZelG4QxYEZqtZk2QDxruAQsAA8jrBG8
         kNDjEQaP30j0KSkaYJ11rdHw0mDhKzI71fVXfCjgfZm7eYd793L5fhlV3v7y7H1apqJi
         6rM+SuskfGz4RHcy2vVYRVfUGseNJ1tMB9JShlC/RJLNm9jBDZDOpZOuwv7BMBgaByev
         IFT5LgZBFWbuHIIbTrnj8RxJvdHVWCWpqCfHH+kTIdoCDJLQfcXxbtrZHJCP9eNo+tPf
         kGeA==
X-Gm-Message-State: AOAM532zQBvulJL3Ux/ScDaObUT9v705/Kx0dESQwUeS8vlG1+Q6e/VS
        S+htnEwXtCgi5Z9pj+nVEjtiOZrjBLl4rn+loAM=
X-Google-Smtp-Source: ABdhPJzezQFrihKvcPh5DyFzslzBwzQ/3NUVoyliQocaSYhheNfnclCA2pkSwEQa9XKZnZwVt/yORA==
X-Received: by 2002:a2e:b954:0:b0:239:2768:cf0b with SMTP id 20-20020a2eb954000000b002392768cf0bmr12176124ljs.245.1646785373035;
        Tue, 08 Mar 2022 16:22:53 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id j17-20020a2e8511000000b00247ee6592cesm57353lji.104.2022.03.08.16.22.51
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 16:22:51 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id u3so954826ljd.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 16:22:51 -0800 (PST)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr696937ljc.506.1646785371366; Tue, 08
 Mar 2022 16:22:51 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com> <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
In-Reply-To: <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 16:22:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
Message-ID: <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
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

On Tue, Mar 8, 2022 at 3:25 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Seems to be working on s390x for this test case at least; the kind of
> trace I'm getting is:

Good.

> This shows bursts of successful fault-ins in gfs2_file_read_iter
> (read_fault). The pauses in between might be caused by the storage;
> I'm not sure.

Don't know about the pauses, but the burst size might be impacted by that

+       const size_t max_size = 4 * PAGE_SIZE;

thing that limits how many calls to fixup_user_fault() we do per
fault_in_safe_writeable().

So it might be worth checking if that value seems to make any difference.

> I'd still let the caller of fault_in_safe_writeable() decide how much
> memory to fault in; the tight cap in fault_in_safe_writeable() doesn't
> seem useful.

Well, there are real latency concerns there - fixup_user_fault() is
not necessarily all that low-cost.

And it's actually going to be worse when we have the sub-page coloring
issues happening, and will need to probe at a 128-byte granularity
(not on s390, but on arm64).

At that point, we almost certainly will need to have a "probe user
space non-destructibly for writability" instruction (possibly
extending on our current arch_futex_atomic_op_inuser()
infrastructure).

So honestly, if you do IO on areas that will get page faults on them,
to some degree it's a "you are doing something stupid, you get what
you deserve". This code should _work_, it should not have to worry
about users having bad patterns (where "read data into huge cold
mappings under enough memory pressure that it causes access bit faults
in the middle of the read" very much counts as such a bad pattern).

> Also, you want to put in an extra L here:
> > Signed-off-by: linus Torvalds <torvalds@linux-foundation.org>

Heh. Fixed locally.

                 Linus
