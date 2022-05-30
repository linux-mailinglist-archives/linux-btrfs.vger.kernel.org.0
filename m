Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D68537339
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 03:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiE3BOh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 21:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiE3BOg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 21:14:36 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6448A6EB30
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 18:14:35 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id f7so210595ilr.5
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 18:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QtyBxi/ABoD+yfeZ9t0ydTyHei1kGTv+xLQGNLCfAEc=;
        b=TAGk/InlvTlwNxiZwCFXN3IdTuR2oWDr5IiDBwxQqrrUbtxVBu0IkVqTenR/Wq6vvH
         Pf1R8rVFpkhYzJ+tZxPzm6QyzWQsljNIkFoiB3GWqnpec2japmp6Dgr3yoglxCt3xTmb
         rbtp+7z8ujbHp8pkEt0QKpg6Dyu9k+er7ecvJf0KPvRzGiqZHlLTZacuepXaUdaYC46V
         hv3pUQrmQ8s86NcRtFBic66sYRovAT6EgWCm0CdXEkwLBcOamMNr84Hdzx5L+SdrcrqM
         Hg6Q51DHNgHNFTzLdu9Nz5TjmYeZPt0KkHhYlwDGU1oXoa/qqDfXNj2hK3pgq9ItUiCB
         m1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtyBxi/ABoD+yfeZ9t0ydTyHei1kGTv+xLQGNLCfAEc=;
        b=wc5H7GHxkC4oTisb6x+rBW6kXU8Qw67QDA8DjL9KgW0+W3h6IZlybe4yX22zZ1ZgtF
         OsfdH94aqczNBlKg/dTkSqsBDl0Q1Y8g4tKO9ppk3H1UfYeFK3OhVYHqzTm1GkcECYWj
         cUNSk4ZIYNRVYLtndevYv294pn17gTDt5BqyyRR/pJvqDr19ZdbSKosVn5OqFazWFqcM
         AawAegCslLmSUm39uNtiUV3eMKJKz/HSyw+2mOEWfkklKg8GILcP8Qtga4jZxYhxlP/9
         BOROQs61Uon1cMLp/RPFdRY7HYrVCH2OtFwT7+DSidRB2pt+VROiXAtGKaWUQVa0njCl
         WNEQ==
X-Gm-Message-State: AOAM5329l+S7TC4sObe4v7rSVB/6HdC5MztLxE2jQC2LL0+BYYIPCq7N
        9Hic7ShllPr+HYm0K7wA/R7P9AMj4cscpkbhjqUJwKpOcsc=
X-Google-Smtp-Source: ABdhPJyr+HfUoJUfX+tBor7VWu66ZfzFa2tgZFJn1kNyOiXw8gP7exv04kkMJeFHtBHyIE1vVjzFClqstCU1EEqtYm8=
X-Received: by 2002:a92:ca49:0:b0:2d3:9e94:1af8 with SMTP id
 q9-20020a92ca49000000b002d39e941af8mr2673028ilo.127.1653873274304; Sun, 29
 May 2022 18:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220529035139.GE24951@merlins.org> <CAEzrpqcKeVNkXa3txx0nyDnKUCp06msmd97d1fBedTzbmR5KcA@mail.gmail.com>
 <20220529153312.GF24951@merlins.org> <CAEzrpqdEk-j2bMfBLEdkhHcq1hWLmHv_Nx-0mj1vh0yJgZuCZQ@mail.gmail.com>
 <20220529180510.GG24951@merlins.org> <CAEzrpqfqD8jkznVQR1SL-YpF0ALx7Pbg+ptz7dVgRecOXeDtPg@mail.gmail.com>
 <20220529194235.GH24951@merlins.org> <CAEzrpqfd2jPWxUayfqyYRDN25-etc4_jgzcHmZ3LhGkb4e7Tsw@mail.gmail.com>
 <20220529200415.GI24951@merlins.org> <CAEzrpqdpvnbzaH1gxWnvWLMWEKtOAdYsH25mBWhkF-urf7Zw3g@mail.gmail.com>
 <20220530003701.GJ24951@merlins.org>
In-Reply-To: <20220530003701.GJ24951@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 29 May 2022 21:14:23 -0400
Message-ID: <CAEzrpqcPirk3AOi1vy+N_V3VY49mvUCiwYL4A_0XoT_jxjgOrg@mail.gmail.com>
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

On Sun, May 29, 2022 at 8:37 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 29, 2022 at 04:32:19PM -0400, Josef Bacik wrote:
> > On Sun, May 29, 2022 at 4:04 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, May 29, 2022 at 03:49:26PM -0400, Josef Bacik wrote:
> > > > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> > > > > WARNING: cannot read chunk root, continue anyway
> > > > > none of our backups was sufficient, scanning for a root
> > > > > ERROR: Couldn't find a valid root block for 3, we're going to clear it and hope for the best
> > > > > Tree recover failed
> > > >
> > > > Lord alright, lets try some debugging.  Thanks,
> > >
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> > > WARNING: cannot read chunk root, continue anyway
> > > none of our backups was sufficient, scanning for a root
> > > scanning, best has 0 found 1 bad
> > > ERROR: Couldn't find a valid root block for 3, we're going to clear it and hope for the best
> > > Tree recover failed
> > > gargamel:/var/local/src/btrfs-progs-josefbacik#
> >
> > Hmm, the sys array should be fine, try again, hopefully that'll clear
> > things up.  Thanks,
>
> It went farther this time
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> WARNING: cannot read chunk root, continue anyway
> none of our backups was sufficient, scanning for a root
> scanning, best has 0 found 1 bad
> ret is 0 offset 20971520 len 8388608
> ret is -2 offset 20971520 len 8388608
> checking block 22495232 generation 1572124 fs info generation 0
> checking block 22462464 generation 1479229 fs info generation 0
> checking block 22528000 generation 1572115 fs info generation 0
> checking block 22446080 generation 1571791 fs info generation 0
> checking block 22544384 generation 1556078 fs info generation 0
> checking block 22511616 generation 1555799 fs info generation 0
> checking block 22577152 generation 1586277 fs info generation 0
> checking block 22478848 generation 1561557 fs info generation 0
> checking block 22593536 generation 1590219 fs info generation 0
> checking block 22609920 generation 1551635 fs info generation 0
> checking block 22560768 generation 1590217 fs info generation 0
> ERROR: Couldn't find a valid root block for 3, we're going to clear it and hope for the best
> Tree recover failed
>

Ah ok that makes sense, fixed it, sorry about that.  Thanks,

Josef
