Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF8B613DDC
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 19:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJaS5P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 14:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaS5O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 14:57:14 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58D61129
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 11:57:12 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id k67so11946477vsk.2
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 11:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MYV5cri+9HnK3IWri6K5wqHucbnY+96ft9BgHsjS9RI=;
        b=W76/72RqBQtjLnPqgZ54ZmtlZopTmyDXgMrUGd97TGur1nfvPTIrCbLZaCGH6MNb9U
         N1tim/PcJyN+2ZhG2ccBoIrQiSZfcKDV157X1Db/tti0An7B+C1A8k/pdgT+SQe58mGu
         4V8ISOnQYo6qKqrUSrD2SF8MTyAichuKjSAm6+lZwBYdzs8GYf1H1U+OG0XBZY1WuK+U
         p9AxrAn7CpUaEvV/opVaURLFDrXBEu4XukuDpWO2xZo9qgWwKI7gpO8pBFnkpYcNbV1B
         6hPcpsWhY58zhP4p8sjnYJ72FCvYBQUGmCWNeMkxBaRSXftsKqcKeYvKSb7FnJgYO/yN
         lSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYV5cri+9HnK3IWri6K5wqHucbnY+96ft9BgHsjS9RI=;
        b=Ij2YrnaSQ5qs1YxGxZGHC2nHsGdT2Ru4nB7yFt1If4ejKsvH0pKWmc/AxW6DMy30iE
         IHqC6Dm+soyTWeBRELTZwO7NznmSDBSH9+UY5EG6bUAtkkCM7Yv0RnwIic7y7XGqbn5w
         o8W1LFvltQLGwGlY6TUxLy0aQBJpXXwF5Ne6/sp8F+l5/tyMTvtxs5tKcWv+FTFSEBi1
         KS/3f+0HnCFYkoLkTz5qRE2XBhQRKEM0bRTvxhf0YGGpvHEjL+OspjC8wetMVJj22yNa
         xIrKOX6TdzwcDBV/mKcgiq9BhdR8xfJFq6oiDCw/ML/BYgOOpcjiaVsqU5hUozxBszHz
         Gvaw==
X-Gm-Message-State: ACrzQf2WsWmo2OU7CxKMoqv7pRbfb7NS61p918aP7YQ5ucAW0oOvU6YP
        7eC1EaofDo9fK6U5qCGPZIyE3DoLh+vpuuXJzHaWiw==
X-Google-Smtp-Source: AMsMyM4uj+RakYNC8icBKfPDn8ZRitjLBvfKlst7dEhYq+yOQu68BSAzB2n3pqMGfzMFF86CpR73qLnLG+KxXiFB7wQ=
X-Received: by 2002:a05:6102:3714:b0:3ac:f4c2:436 with SMTP id
 s20-20020a056102371400b003acf4c20436mr686439vst.80.1667242631728; Mon, 31 Oct
 2022 11:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000d9d6f05ec498263@google.com> <000000000000fa42c105ec5339ec@google.com>
 <Y1/SqIuP4tbszPAW@casper.infradead.org>
In-Reply-To: <Y1/SqIuP4tbszPAW@casper.infradead.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 31 Oct 2022 11:57:00 -0700
Message-ID: <CANp29Y68VeE9NHM2ekCvuZNVVaEZkmaG_NhyaUTH5DMOu0=QgA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in btrfs_space_info_update_bytes_may_use
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+8edfa01e46fd9fe3fbfb@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        hch@lst.de, josef@toxicpanda.com, linmiaohe@huawei.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 31, 2022 at 6:50 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Dmitry, I don't see a way to tell syzbot that its bisection has gone
> astray.  Can you add one or document it if it already exists?

No, unfortunately it's not possible now. I've filed an issue:
https://github.com/google/syzkaller/issues/3491

>
> On Mon, Oct 31, 2022 at 04:51:22AM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 0c7c575df56b957390206deb018c41acbb412159
> > Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Date:   Wed Feb 24 20:01:52 2021 +0000
> >
> >     mm/filemap: remove dynamically allocated array from filemap_read
>
> This change affects the read path.  The crash happens in the unmount
> path.  The data structure that's being checked is modified in the write
> path.  I just can't see how this commit is in any way related.

Most likely the bisection pointed at your patch because it removed
kmalloc while the reproducer for the bug does fault injection (see the
"(fail_nth: 10)" line in syz repro). So it might have inadvertently
made the issue more visible to the fuzzer.

>
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119e21b6880000
> > start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=139e21b6880000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=159e21b6880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17db9ab1880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124e21b6880000
> >
> > Reported-by: syzbot+8edfa01e46fd9fe3fbfb@syzkaller.appspotmail.com
> > Fixes: 0c7c575df56b ("mm/filemap: remove dynamically allocated array from filemap_read")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/Y1/SqIuP4tbszPAW%40casper.infradead.org.
