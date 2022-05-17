Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8017C52AC40
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiEQTuJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 15:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiEQTuD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 15:50:03 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EA237BDC
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 12:50:02 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id a10so20406673ioe.9
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LiAiSc/ZiZwHkaF3b/Ftf5LnBXGMgfu8hnFDxQilFeY=;
        b=jOr29Y8cuo6mG62+QYfFfqQXdJF2+NqPboL+BJ93BjwzidKVvSlCeT+MDJp57cI5td
         SdM7xyPKwIw3n1DrRpqwMD4ZZwhb35QoWpoeUfneqiQnIci1pN//tyVafb/UC1mZrQjg
         4C+6YNvtLK/A2oYNinzaEH3a0ODar7SwrSG2lefg0re540vSmVJDmaRJx1ZNezFEkNlz
         kpYycs465RgUu72INE4a4ZjgJx1Z/m01RXDyMOlAhUO18JgloR14ScLCCQN3GvUOCWtm
         9e27OlVp84SfJKvKmTe2dpxc9OWLlKwA00Bd7To605ihJqYqP3XbIth3Zbv3UyL30xtE
         wFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LiAiSc/ZiZwHkaF3b/Ftf5LnBXGMgfu8hnFDxQilFeY=;
        b=Oa5JuA2wav3s2BSEzNuIatLdMXmLPcLNKu0CMOc0xsPLEMcWmTtdFdITF6JEKnR3t2
         I++OeB4uDmK2FROUdD77R86mOLQbLO+BZtAbtTAxKYv8Wnk925NYj5nmG9XAdlE/Qxne
         2NnClX7MTQ+TtxT5nD2OKJD5Evii0B0W9Q/+LEDIWrvSZU/ce4JUL9ZuWWpQoQMkged+
         I+18jR6uurkZKw2zgJh/zFB/usYIwhCuC6urK5QaKQ51Pchh6LNk+O7D/bZnC05kFGo5
         0sHPpCKsMNrbFDOmtyr05z9fg3BdMDI1XXoYR1Xg/g8ZEq9nfGhSGxALtycx8+jmq0Cf
         I9Rw==
X-Gm-Message-State: AOAM531tuwk4KrkeHIVOGbNgsh2IPnzBnEbVi5wFmb6/CztzEUj5nFVx
        ggff+JykWc3HjGuA2aHR0DACQ/VgtGVESt6RmUb92XWJIEM=
X-Google-Smtp-Source: ABdhPJykdBdEtGInhVkrcj1rpWvHjafYwtmDOjKOQed5wSOET6eUP07lSkjDO5RzRT9Jt/ZLUP3Xru4UFMb8EweiriM=
X-Received: by 2002:a05:6602:13c3:b0:65d:d052:9982 with SMTP id
 o3-20020a05660213c300b0065dd0529982mr11108733iov.83.1652817001426; Tue, 17
 May 2022 12:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqcZQVWwt1JSDg6z44dBYKW6fmmXmOTFoXiDWpoGXxufwQ@mail.gmail.com>
 <20220515154122.GB8056@merlins.org> <CAEzrpqc6MyW0t1H9ue_GQL-1AhgpWfumBfj3MK0eGstwJ3R1aw@mail.gmail.com>
 <20220515212951.GC13006@merlins.org> <20220515230147.GD13006@merlins.org>
 <CAEzrpqdbjeTYEy16KbzJ39bBkd8rkNTHA2n53UXHG-CdeUo6xw@mail.gmail.com>
 <20220516005759.GE13006@merlins.org> <CAEzrpqfMbB-sGLZUjGHjxHt1Gga+uULGkoZTqjXHwKnzsjP5aA@mail.gmail.com>
 <20220516151653.GF13006@merlins.org> <20220516153651.GG13006@merlins.org>
 <20220516165327.GD8056@merlins.org> <CAEzrpqfShQhaCVv1GY=JTTCO_T44ggidHFtbSABrcPCSNzY9hA@mail.gmail.com>
In-Reply-To: <CAEzrpqfShQhaCVv1GY=JTTCO_T44ggidHFtbSABrcPCSNzY9hA@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 17 May 2022 15:49:50 -0400
Message-ID: <CAEzrpqdsi63zgudjzbSa3QyMLuE5nD3+t9nOuzXEdWZGCbTcNA@mail.gmail.com>
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

On Mon, May 16, 2022 at 12:55 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Mon, May 16, 2022 at 12:53 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Mon, May 16, 2022 at 08:36:51AM -0700, Marc MERLIN wrote:
> > > Could you update the code so that it says "deleted"?
> >
> > AI on this one? ^^^
> >
> > > I'm doing repair again, and I now see:
> > > Fixed 0 roots.
> > > [2/7] checking extents
> > > checksum verify failed on 364637798400 wanted 0xc3ba5144 found 0x30a5fff1
> > > checksum verify failed on 364637962240 wanted 0x91d33e8a found 0x00890be7
> > > checksum verify failed on 11970891186176 wanted 0x6b46adfb found 0xe40e4cbe
> > > checksum verify failed on 12511729680384 wanted 0x41be9fa6 found 0x01f06e9c
> > > checksum verify failed on 12512010420224 wanted 0x365027e7 found 0xba73f602
> > > checksum verify failed on 12512303677440 wanted 0xc08fc7a0 found 0x3cb30242
> > > checksum verify failed on 13576951021568 wanted 0x9511e976 found 0xd8fe35ea
> > > checksum verify failed on 13577013624832 wanted 0x76bbe220 found 0xdfabbbdb
> > > checksum verify failed on 13577013919744 wanted 0xafb37267 found 0x69504e0d
> > > checksum verify failed on 13577113485312 wanted 0x049c1e5a found 0x0ddcba27
> > > checksum verify failed on 13577170976768 wanted 0x9585372b found 0x048e24e3
> > > checksum verify failed on 13577420161024 wanted 0x6d37d200 found 0x45f7a0b8
> > > checksum verify failed on 13577490890752 wanted 0x426c3628 found 0x35008768
> > > checksum verify failed on 13577726541824 wanted 0xc3089b25 found 0x426c57c7
> > > checksum verify failed on 13577776611328 wanted 0x50eba933 found 0x4f0ec122
> > > checksum verify failed on 364983844864 wanted 0x3a556bff found 0xba7431e0
> > > checksum verify failed on 364986433536 wanted 0xa2ee2364 found 0xc0023b14
> > > checksum verify failed on 364986449920 wanted 0x55bf9ee9 found 0x9cda5c9f
> > > checksum verify failed on 364986482688 wanted 0x5421a4b7 found 0x37ac4734
> > > (...)
> > > checksum verify failed on 15646006722560 wanted 0x760a06a0 found 0xb44fcd95
> > > checksum verify failed on 15645319872512 wanted 0x3bfb10c8 found 0x2be82f60
> > > checksum verify failed on 15645980491776 wanted 0xe1e674a7 found 0x0fdfda2c
> > > checksum verify failed on 15645526884352 wanted 0xc2d409c1 found 0xb3eee8d2
> > > checksum verify failed on 13577013936128 wanted 0x4ba00b03 found 0x64614751
> > > Chunk[256, 228, 4523166793728] stripe[1, 4531228246016] is not found in dev extent
> > > Chunk[256, 228, 4524240535552] stripe[1, 4532301987840] is not found in dev extent
> > > Chunk[256, 228, 4525314277376] stripe[1, 4533375729664] is not found in dev extent
> > > Chunk[256, 228, 4526388019200] stripe[1, 4534449471488] is not found in dev extent
> > > Chunk[256, 228, 4527461761024] stripe[1, 4535523213312] is not found in dev extent
> > > Chunk[256, 228, 4528535502848] stripe[1, 4536596955136] is not found in dev extent
> > > Chunk[256, 228, 4529609244672] stripe[1, 4537670696960] is not found in dev extent
> > > (...)
> > > Chunk[256, 228, 15362624061440] stripe[1, 14782241439744] is not found in dev extent
> > > Chunk[256, 228, 15363697803264] stripe[1, 14783315181568] is not found in dev extent
> > > Chunk[256, 228, 15364771545088] stripe[1, 14784388923392] is not found in dev extent
> > > Chunk[256, 228, 15365845286912] stripe[1, 14785462665216] is not found in dev extent
> > > Chunk[256, 228, 15366919028736] stripe[1, 14786536407040] is not found in dev extent
> > > Device extent[1, 11503033909248, 1073741824] didn't find the relative chunk.
> > > Device extent[1, 11595375706112, 1073741824] didn't find the relative chunk.
> > > Device extent[1, 11596449447936, 1073741824] didn't find the relative chunk.
> > > Device extent[1, 11597523189760, 1073741824] didn't find the relative chunk.
> > > Device extent[1, 11598596931584, 1073741824] didn't find the relative chunk.
> > > Device extent[1, 11599670673408, 1073741824] didn't find the relative chunk.
> > > Device extent[1, 11600744415232, 1073741824] didn't find the relative chunk.
> > > Device extent[1, 11601818157056, 1073741824] didn't find the relative chunk.
> > > Device extent[1, 11611481833472, 1073741824] didn't find the relative chunk.
> > > Device extent[1, 11612555575296, 1073741824] didn't find the relative chunk.
> > > Device extent[1, 11613629317120, 1073741824] didn't find the relative chunk.
> > > (...)
> > > Device extent[1, 11422503272448, 1073741824] didn't find the relative chunk.
> > > Device extent[1, 10616123162624, 1073741824] didn't find the relative chunk.
>
> I'm going to have to fix check to fix these problems, I'll let you
> know when I have something.  Thanks,
>

Sorry, kids coming down with COVID.  I've pushed a fix for check to
delete these things, you can run btrfs check --repair and it should do
the right thing.  Thanks,

Josef
