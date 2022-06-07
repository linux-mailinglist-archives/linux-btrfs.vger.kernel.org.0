Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B487053F3E8
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 04:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbiFGC2j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 22:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiFGC2i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 22:28:38 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE83BE
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 19:28:37 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h18so13266906ilj.7
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jun 2022 19:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emYzr5B8fxm/cd0NmHZ1Sm+1PmQ6WkzYtnwAbaqBNo8=;
        b=HTCmDLMPdolsXw4aMtqmgJn8lGTFA5Q7yMMjLkZRDhqDanBiEiCK6yzKvUO5i1HCc7
         e4MpgLArGoWgcX/IHKabs+BT4Tole15X7+FFyaQuMM5ieZdSWH8FC9H2oDK/neQyQRlV
         WCTQkJJpKglnpsFwIuOvRhHKywiztcet8S1VHiJLyIv363Ibug3Hk/g6ar/lY8g8YSA6
         H8GAUpXbh+/hLGzwqvI3qeundUEkWZUN3t2Q6y1ccHTS6hHY1FbtsEINuKue5Geg+4rC
         MGCNfDFX8jYonWUlwEShEjQOKlBsTZhZydEIXusObXZnqepzYSU3nx0SZ5f4aHOdpB7f
         8+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emYzr5B8fxm/cd0NmHZ1Sm+1PmQ6WkzYtnwAbaqBNo8=;
        b=mvvQnW4q1TEzokyvX7BY/4nRLI09vh9pwoTmqdHmCdKPmX1a0qhmWN3c7+ICLCsnsN
         6ESGuLWSjN+Xy56/J0VKVlf6tFv5H8n0j1ExWaw70AhRhPSb5Jfhefeic1tTyaxSm24F
         W8gKPXQiY/N+fUVrkn65G6DS1c+dzTFzWBvH1DKSKjzno9NkVOg25348mkchkUcuGikB
         0Opo+96PUO7VTK7QIa9Tchmo960NeUAnK1hEGiBfNjjZV9lUzhEkgJXgw8z2XolUGRDd
         C5JGYh0/qIEn9QgttTjU9VT1CWhEC4rhCwoBKNt5JZ9FgrhEdA4slMMBVfU0MnJLL/A+
         sxeQ==
X-Gm-Message-State: AOAM532C0eHRcbog+yvD0hyplR21veQhvd0VTlnrtOTfIQYfUwgSBYe9
        oYjXZ2kSiInLSJ5zFRpxiif7J4WI86TlQzzginasGW2otymYKg==
X-Google-Smtp-Source: ABdhPJzwXFHlhhSl7uY3WQ44ddZRX3UMVFi0uOhg/rUqGwze1hoS+ZQD9SbEOyc7GyaJBb/+VDhtqr+xuKkLcnYv3Hk=
X-Received: by 2002:a92:ca49:0:b0:2d3:9e94:1af8 with SMTP id
 q9-20020a92ca49000000b002d39e941af8mr15637663ilo.127.1654568916140; Mon, 06
 Jun 2022 19:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220606000548.GF22722@merlins.org> <CAEzrpqdL6rK+-OUhW2AR3jXhK8TTsTM77A1CUkh=-+Y7Q1av9Q@mail.gmail.com>
 <20220606012204.GP1745079@merlins.org> <CAEzrpqeOb4XnGxbeMXNcDHn+wMNC7sBS7eFdsTbUj8c7BUgcuA@mail.gmail.com>
 <20220606210855.GL22722@merlins.org> <CAEzrpqe1_vbZ=+3C5=YPDJOCJGLAX9e4cmO_a+F1P3sdg9ubwQ@mail.gmail.com>
 <20220606212301.GM22722@merlins.org> <CAEzrpqdCpLsTqwBZ_W2sFZn9+uTrL88V=Cw6ZQe3XV0FxRO8nw@mail.gmail.com>
 <20220606215013.GN22722@merlins.org> <CAEzrpqcn_BRL7p3gPmS5OVn5D-m8hMB-5JcAHwEHwKpxGxOMqw@mail.gmail.com>
 <20220606221755.GO22722@merlins.org>
In-Reply-To: <20220606221755.GO22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 6 Jun 2022 22:28:25 -0400
Message-ID: <CAEzrpqcr08tHCesiwS9ysxrRQaadAeHyjSTg3Qp+CorvGz6psQ@mail.gmail.com>
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

On Mon, Jun 6, 2022 at 6:17 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Jun 06, 2022 at 06:00:10PM -0400, Josef Bacik wrote:
> > > Found an extent we don't have a block group for in the file
> > > file
> > > push node left from right mid nritems 48 right nritems 0 parent 15645019684864 parent nritems 7
> > > parent nritems is now 6
> > > corrupt node: root=164624 root bytenr 15645019684864 commit bytenr 15645019602944 block=15645019717632 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> > > kernel-shared/ctree.c:1042: balance_level: BUG_ON `check_path(path)` triggered, value -5
> >
> > Hmm ok this may just be a new thing I have to check for in
> > tree-recover.  Give this a shot please, thanks,
>
> searching 164623 for bad extents
> processed 311296 of 63193088 possible bytes, 0%
> searching 164624 for bad extents
>
> Found an extent we don't have a block group for in the file
> file

Ok I thought I caught this particular problem but I don't, so I fixed
tree-recover to handle unordered keys in different nodes.  Pull and
build, run tree-recover.  It's going to start deleting slots for
unordered keys, picking whichever node is newer as the source of
truth.  You should only see this happen on 164624, if you see it fire
a bunch right away stop it and send me the output so I can make sure I
didn't screw anything up.  I went over the code and diff a few times
to make sure I didn't mess anything up, but I could have missed
something.  If that runs and fixes stuff, run it again just to make
sure it doesn't find anything the second time.  It shouldn't since I
re-start the loop if we adjust things, but just in case.  I assume
this will blow up, but if it doesn't you can try running
init-extent-tree again and see how that goes.  Thanks,

Josef
