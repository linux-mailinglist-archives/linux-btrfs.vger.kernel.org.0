Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C429A52ACE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 22:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245365AbiEQUje (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 16:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353020AbiEQUjc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 16:39:32 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EA952B07
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 13:39:30 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i5so185190ilv.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbJ0GEMDzWvoebQKukfRIKf1+HnTzbs8yVMwRssgR4k=;
        b=M1jUyAYZMEwfG2SNJxhE+8A3GiVjF3bnRkBaKSeVlU8tfLLoi3ANVgyIjjpyU62hKx
         3J7FU81CHnI0Rk4y8Hjw13xrmmk2WL5Yqj6AXfznSInunVugizyyA9Ok+vVc9xKc3cug
         Jz5dR1MXj50Z7YcjVJV4YTdBpo3RYgI2d5Omol4oT/lFscAu24e4j5oG4voSrlKVfTVN
         PUtsuKjtrYR8842eRurgFzLdsl/2wh6MRUW/A0+kOiTDq/mLbInQsbcLh7fL5/Zkhwe2
         gjlz5i7Z5NCY4zmJCnV/VWuDfC7TMhuT2gJvm16f4DRembXpdqSW9yUwHnFeWvz4fhH2
         EXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbJ0GEMDzWvoebQKukfRIKf1+HnTzbs8yVMwRssgR4k=;
        b=EF3NNvndtVTGwW2i8YGbYL87u+RcAEfV1OKhbmDgtvK7p3tWp3qR3BvSPvaWeIn71j
         btfI0YmkiIi/+LkNVtoeaHHOUZkR16nYQxJj6BgRBzuDI+ibFtE7HuaIYT8/uhN2poTb
         oa/FrLMGMZtIZtR+9Qiw0ysH2DCOeilc04ftzW8+FgWUVq+Juk5nZePEv9NGPMiI3aLC
         jsXw5aRyCC6hLkhwveRLgk58Lw74Jvn9qYBw0uhu3M9yqaMTAEyRXNpT+uTyS11ePaJw
         EePxk748UDhJVyahhfWpodNP/scgre0BvnUxzFsqFddOKTKh8+6K3ajzUDEQyvjDWq7j
         jf1Q==
X-Gm-Message-State: AOAM532m2Oz7wmWXhIHqINUu8je8RsQS8HXV84AyqKlWlNgx4nUYPdrF
        9ubMAP+b4rpjQfkPJdYxKhkrasSvqW7dLN0UP45+CyaNCOA=
X-Google-Smtp-Source: ABdhPJz/ovCXJcHzNQjgYNKB743Yk17nw+NaO3zBJRTh6Knwz3PdBbzZju2loMNufWKRBjnqmsXBxyKuv45btm6j6i0=
X-Received: by 2002:a92:ca0d:0:b0:2cf:3bb8:f1a5 with SMTP id
 j13-20020a92ca0d000000b002cf3bb8f1a5mr12866362ils.152.1652819969366; Tue, 17
 May 2022 13:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220515212951.GC13006@merlins.org> <20220515230147.GD13006@merlins.org>
 <CAEzrpqdbjeTYEy16KbzJ39bBkd8rkNTHA2n53UXHG-CdeUo6xw@mail.gmail.com>
 <20220516005759.GE13006@merlins.org> <CAEzrpqfMbB-sGLZUjGHjxHt1Gga+uULGkoZTqjXHwKnzsjP5aA@mail.gmail.com>
 <20220516151653.GF13006@merlins.org> <20220516153651.GG13006@merlins.org>
 <20220516165327.GD8056@merlins.org> <CAEzrpqfShQhaCVv1GY=JTTCO_T44ggidHFtbSABrcPCSNzY9hA@mail.gmail.com>
 <CAEzrpqdsi63zgudjzbSa3QyMLuE5nD3+t9nOuzXEdWZGCbTcNA@mail.gmail.com> <20220517202756.GK8056@merlins.org>
In-Reply-To: <20220517202756.GK8056@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 17 May 2022 16:39:18 -0400
Message-ID: <CAEzrpqdgKtSDJj2QekYuS+M77wYrp6bvXv2Ue3xQ8Vm2bGGYAg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 17, 2022 at 4:27 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 17, 2022 at 03:49:50PM -0400, Josef Bacik wrote:
> > Sorry, kids coming down with COVID.  I've pushed a fix for check to
>
> Oh no, sorry to hear. Hopefully they'll be ok.
>
> > delete these things, you can run btrfs check --repair and it should do
> > the right thing.  Thanks,
>
> Thanks for not giving up. I'm really surprised by the amount of damage that this filesystem
> endured in less than 60 seconds, especially when I'm pretty sure I wasn't even writing to it.
> Although I understand that some extra damage may have been done during the repair attempts.
>

I'm an idiot, wrong root for the dev extents.

What I *think* happened is you essentially lost random blocks from 1
transaction.  This isn't particularly harmful, except you had a chunk
allocation that happened, so you lost some of the chunk root.  I
didn't realize this is what was happening until now.  If I had I
probably could have pieced together these dev extents into chunks, and
then all those blocks that we had that didn't map to a chunk probably
would have been fine, because they were in the range that we lost.

It's not that you lost a lot of blocks, you just lost a few really,
really important blocks, and then I failed to recognize what happened
so I threw out more than I should have, plus all the other little
wonkiness from experimental recovery tools.  Thanks,

Josef
