Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE812677223
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Jan 2023 20:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjAVTx2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Jan 2023 14:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVTx1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Jan 2023 14:53:27 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543B5FF08
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jan 2023 11:53:26 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id j9so8261220qtv.4
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jan 2023 11:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ctP10EJhYVqp3z/JqewEFMYB9962mKik31Egc7xVVsA=;
        b=Rn/RqTN+UfGRkoXXBJUiiQ0VPKaSTWcruxokqyC3rqO3RTSKRu12ykm5/VACEyhGeQ
         Xbhj2TFtlMqT9DRUSG4gNVRZTVjMDWKNJKY8d25BsHzHwRMsHzyxhlqyniFNxQAbRw/r
         fk7r/Nws+N4WsOGCYZEgqS28EzgadmC0yFBaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctP10EJhYVqp3z/JqewEFMYB9962mKik31Egc7xVVsA=;
        b=JdOcJ6ytiEpOKEq3UHtQ/MxEli370ZmtUQI8U/5OGODNlGesRTYJN+/7GoQqX6t6oX
         gSj/t9QbVBkOYm4MxUg4twiBjvBX6h0lXRnRXfDCEiecQCi6OEV2vNw5Y8Ffr9VhCA+t
         UsW10AZOiZ3nmZnIs3TWngKkr6xz+mGN0NilOLtrqpOK5BwEiVLWwVRBqIKhu+16d/mf
         YBIPOyBZp9B7Nwl/OSlqpijecVjFz5KKJ7SHNyzjUtWR4lXry4KRSi6sR5+dteP7CGjG
         kxY3ZaRHtqz9cfpggO6JszgNOCTMq6Dx8pHIB2jkZ57WuxSnP+1oldQoc8t0UvBPd8tb
         I2Xw==
X-Gm-Message-State: AFqh2kqR+uSaa3/hML9u/G0bb3UE0n4EPQ7X1kqLkj2QgnID2ZRrHQPe
        MVASTrLbojFfsOkbDBg6tvORj7b2ADue3F+V
X-Google-Smtp-Source: AMrXdXu+VkPWjmpSh5OpRK4M4lnxF3a7jkuNZgH1w3xR9qV3dG5ekXqcAUO920jXSMtHZMbq6cM9MQ==
X-Received: by 2002:ac8:6bd2:0:b0:3b2:2195:e2a2 with SMTP id b18-20020ac86bd2000000b003b22195e2a2mr31906601qtt.45.1674417205032;
        Sun, 22 Jan 2023 11:53:25 -0800 (PST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id bs25-20020ac86f19000000b0035d432f5ba3sm9883441qtb.17.2023.01.22.11.53.24
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 11:53:24 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id t9so4290766qkm.2
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jan 2023 11:53:24 -0800 (PST)
X-Received: by 2002:a05:620a:99d:b0:705:efa8:524c with SMTP id
 x29-20020a05620a099d00b00705efa8524cmr1088535qkx.594.1674417203910; Sun, 22
 Jan 2023 11:53:23 -0800 (PST)
MIME-Version: 1.0
References: <00000000000075a52e05ee97ad74@google.com> <0000000000006e58cb05f2d86236@google.com>
In-Reply-To: <0000000000006e58cb05f2d86236@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Jan 2023 11:53:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJ0Rya9++f5B=6euHxRGRKOYNZARxN7bZb61RmOHGnFA@mail.gmail.com>
Message-ID: <CAHk-=whJ0Rya9++f5B=6euHxRGRKOYNZARxN7bZb61RmOHGnFA@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] WARNING: kmalloc bug in btrfs_ioctl_send
To:     syzbot <syzbot+4376a9a073770c173269@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        dsterba@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, w@1wt.eu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 22, 2023 at 3:14 AM syzbot
<syzbot+4376a9a073770c173269@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 7661809d493b426e979f39ab512e3adf41fbcc69
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Jul 14 16:45:49 2021 +0000
>
>     mm: don't allow oversized kvmalloc() calls

Heh. I assume this is the

        sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
                                     arg->clone_sources_count + 1,
                                     GFP_KERNEL);

in btrfs_ioctl_send(), where the 'clone_sources_count' thing is
basically just an argument to the btrfs ioctl, and user space can set
it to anything it damn well likes.

So that warning is very much correct, and the problem is that the code
doesn't do any  realsanity checking at all on the ioctl arguments, and
basically allows the code to exhaust all memory.

Ok, there's a sanity check in the form of an overflow check:

        /*
         * Check that we don't overflow at later allocations, we request
         * clone_sources_count + 1 items, and compare to unsigned long inside
         * access_ok.
         */
        if (arg->clone_sources_count >
            ULONG_MAX / sizeof(struct clone_root) - 1) {
                ret = -EINVAL;
                goto out;
        }

but ULONG_MAX is a *lot* of memory that the btrfs code is happy to try
to allocate.

This ioctl does seem to be protected by a

        if (!capable(CAP_SYS_ADMIN))
                return -EPERM;

so at least it wasn't some kind of "random user can use up all memory".

I suspect the simplest way to make syzbot happy is to change the

        if (arg->clone_sources_count >
            ULONG_MAX / sizeof(struct clone_root) - 1) {

test to use INT_MAX instead of ULONG_MAX, which will then match the
vmalloc sanity check and avoid the warning.

But maybe an even smaller value might be more domain-appropriate here?

             Linus
