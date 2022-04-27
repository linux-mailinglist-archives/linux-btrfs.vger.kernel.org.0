Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E697D5123D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiD0UY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 16:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiD0UYy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 16:24:54 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC6286E23
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 13:21:43 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i8so707718ila.5
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2eKpz8alvGLF8AQ0B46Uc7IalvxxyADlHgnDLqt6wDY=;
        b=g94hQzp6MS7uqg+Q3LZrsxbZan3M6fxjXjmzxNZPFxqyhzW060w6R3BE2fOffVehB3
         YjSP7g/PK5R9Dx09dY7+kKCEbJ5j0EYbSwNnYxCZgMTluxxtAOoJvzBD5cQsRiI+2hFX
         9ZmX6m0nnx6xizYSKsjfYEZRE86dJWqg4gIOjdWDK2KGupjJARfCsyACldma/NTk//P/
         lgQnHIO1KB/qg0UFNMBa/wnrtt64pI4jNkNc9QwiDpZyWIWTCas48z2UiQeITFsrZCcm
         mxwtkk496QxuL1+ghtvptkGvXK/FQsb/ofjZU1/JpdSZZ2KIKCAxft5iYD38sKzQOxru
         wCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2eKpz8alvGLF8AQ0B46Uc7IalvxxyADlHgnDLqt6wDY=;
        b=skBurqMbW8nei4DyNcZ7SdW0dag+RjEIpWVT+c9HrWCkWBljc/QfSKCBDpc5wD/cft
         6l0oWjk2toeJdPP9j1R2T+reZu72JmomXVg8qyDdOY43MkJc4oMdZ8L1ssVh1/Cn6qWC
         oOHqU6UJjn3gSmymjEfn+A3vg8tL6CeGw90yphqOiKhxtmkk0amhCPM6BOJoYR4WBIFB
         9gVEvGUayR+LDHQ4epsKiPPdW27W4rA/7xa8diBMv9D+HDj3HzUYABqL4pUpTq5757fG
         QnXCFjNs/AjnxIa+bbmzD+BEvT64LZt/QCdfU1Yuu8iFdKYBc4Mx09gNLi4kDDyG6uvO
         Gh5A==
X-Gm-Message-State: AOAM532NWex7EgspmBLhTsjxaed/kqmkg1m2GD3POD5WKW+49mUpnRZu
        qiQwVzrxF1ckymFS1wwHX1rNZ8iv1cUeZid2Go+03gjw/Jo=
X-Google-Smtp-Source: ABdhPJzfOOmUtbEQ9LS3986Wgj7ZqZny/M5ZcU2q5dMzf3AeyVRUHAWAcJ/rDO+ykoxhBVsyFbWTNvqB6ySl37mm80o=
X-Received: by 2002:a05:6e02:194d:b0:2cd:93bf:9569 with SMTP id
 x13-20020a056e02194d00b002cd93bf9569mr7599201ilu.152.1651090902417; Wed, 27
 Apr 2022 13:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220425002415.GG29107@merlins.org> <CAEzrpqcQkiMJt1B4Bx9NrCcRys1MD+_5Y3riActXYC6RQrkakw@mail.gmail.com>
 <20220426002804.GI29107@merlins.org> <20220426204326.GK12542@merlins.org>
 <CAEzrpqcFewMWJ0e2umXNBdTkH32ehNi6_bnMQORAnGUg0nqFkw@mail.gmail.com>
 <CAEzrpqdKTrP_USiq9sKTXv1=uY1JVWRD5bVfdU_inGMhboxQdg@mail.gmail.com>
 <20220427035451.GM29107@merlins.org> <CAEzrpqdN7FaMMpemFbr6fO9Vi8t6upGPbAjonTtP-dpWMzdJwQ@mail.gmail.com>
 <20220427163423.GN29107@merlins.org> <CAEzrpqdaEFMi1ahnTkd+WHqN-pDWOnf4iK2AiOiOxb3Natv0Kw@mail.gmail.com>
 <20220427182440.GO12542@merlins.org>
In-Reply-To: <20220427182440.GO12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 27 Apr 2022 16:21:31 -0400
Message-ID: <CAEzrpqc7D5A6xZ7ztbWg4mztu+t9XUPSPt_gEgAbCCzVzhnHbA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 27, 2022 at 2:24 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 27, 2022 at 01:49:46PM -0400, Josef Bacik wrote:
> > > Result:
> > > doing insert of 12233379401728
> > > Failed to find [7750833868800, 168, 262144]
> >
> > Oh it's data, interesting.  Pushed some more debugging.  Thanks,
>
> inserting block group 15840439173120
> inserting block group 15842586656768
> processed 1556480 of 0 possible bytes
> processed 1130496 of 0 possible bytesdoing an insert that overlaps our bytenr 7750833627136 262144
> processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr??

Well crap, you have bytenrs that overlap.  I've adjusted
init-extent-tree to dump the paths of the files that have overlapping
extents, as well as the keys.  Run it again so we know what files are
fucked. From there you need to tell me which one you don't care about
and are willing to delete, and then I'll give you the command you need
to remove that bad extent and then we can go again.  Thanks,

Josef
