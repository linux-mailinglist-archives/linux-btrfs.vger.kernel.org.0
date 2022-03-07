Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1654D0BE6
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 00:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbiCGXTW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 18:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiCGXTU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 18:19:20 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7F3150F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 15:18:21 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id s25so22729806lji.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 15:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvag9d2yKnVQ2WA/+ZCk8meLFVTu4t3Z/Y+Vhn7jLqs=;
        b=iE1Mpo/4WNvmX4KVx+vCPrRdmpw6OvR5A+gP5peGjMWmvtI9qqXJ7QVWhM5mmjDAr9
         OxRVuE27WlAcAJxgb2qcdgwfIEVoyYkX+FP20GgX2hzl8hfi+DISfSMg4WgSb2Dw6/4C
         iRVzuKCVR8of2ZBhjlZfemAtmupGO2kDD76nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvag9d2yKnVQ2WA/+ZCk8meLFVTu4t3Z/Y+Vhn7jLqs=;
        b=Lr9x7gbgw2cyNHFxw6ndCN9Me5kx5sNgB9MQspQpvMao94+c6dDsVMxp9SLa6M/NY5
         OEs7IGSkzEcFKRc++SZEOnwpPWtnm0eQjjHlPdstDS1aiEgS4Xy58fp7Ih7cGBt9JsCk
         eRsN5uxt0E9qSc1fQVLGDKCZKltGt37pRwwRQ9njDvJRT6NZBLId9fQA/KXBW5A1mf5d
         U2ziF55KzHAFw9PNbH5ksvUF3qGak1LmpsJz8tKQ41rwPj6eBcU3EbHc2H/n4/q9uPEB
         ji8A19Ds7ZNcwHGzlOHu3bkQcI+pQkE240JZCSNFpGa20RmRy0aQfdTN1X0Gy3vSRLb7
         0kOA==
X-Gm-Message-State: AOAM532/0mLtN8BV+MPkdOwXP5pCPuaXwFGDxYbK0QMf3b3fni4Guko7
        5iNGmjBE5IphN9fzQoIj///aP5aJHoVW9cYGyiw=
X-Google-Smtp-Source: ABdhPJyMYvdi22QXBilGhnc3/g4x/fHsjThkmeYq8nGTDrJ4yGBDu5tMLk0sCKDunoA3T2QIiUbx2A==
X-Received: by 2002:a2e:a408:0:b0:246:35dd:c242 with SMTP id p8-20020a2ea408000000b0024635ddc242mr9135521ljn.197.1646695099739;
        Mon, 07 Mar 2022 15:18:19 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k7-20020a0565123d8700b004435a1e2e55sm3100312lfv.179.2022.03.07.15.18.18
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 15:18:18 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id bt26so9288942lfb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 15:18:18 -0800 (PST)
X-Received: by 2002:a05:6512:3049:b0:447:d55d:4798 with SMTP id
 b9-20020a056512304900b00447d55d4798mr8957028lfb.531.1646695098272; Mon, 07
 Mar 2022 15:18:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
In-Reply-To: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Mar 2022 15:18:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
Message-ID: <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
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

On Mon, Mar 7, 2022 at 2:52 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> After generic_file_read_iter() returns a short or empty read, we fault
> in some pages with fault_in_iov_iter_writeable(). This succeeds, but
> the next call to generic_file_read_iter() returns -EFAULT and we're
> not making any progress.

Since this is s390-specific, I get the very strong feeling that the

  fault_in_iov_iter_writeable ->
    fault_in_safe_writeable ->
      __get_user_pages_locked ->
        __get_user_pages

path somehow successfully finds the page, despite it not being
properly accessible in the page tables.

And it's presumably something specific in the s390x page table
functionality that makes that happen.

The places I'd look at in particular is to make sure that
follow_page_mask() actually has the same rules as a real page table
lookup on s390x.

IOW, if follow_page_mask() finds the page and thinks it's writable,
then it will return a 'page' successfully, and the __get_user_pages()
code will be happy and say "it's there".

But if then accessing the page by trying to write to it using the
virtual address fails despite that, then you'll get the behavior you
describe.

I'd take a look at that can_follow_write_pte() case in particular,
since this is a FOLL_WRITE thing, but it could be any of the pte
checking details.

Have you tried tracing through that path?

                      Linus
