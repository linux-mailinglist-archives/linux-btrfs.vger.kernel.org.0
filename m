Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBA35168D1
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 01:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiEAXM7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 19:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiEAXM5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 19:12:57 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB1A5DA41
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 16:09:31 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z18so14289076iob.5
        for <linux-btrfs@vger.kernel.org>; Sun, 01 May 2022 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Sq7Z/lIz8bbC56tb3CQAmeROLXNJUY4bdCbN5g9MAw=;
        b=Dug1yTgNhO6gRyXCogECxsNg1jVGKHtF/SOiWF2c1iWVIcGzW76e2W4KDjn4PogKtY
         z4k16K7Pjwhv4f0abzdaFF21TcBJ3fzT5jotaAop9+a8k5mIrnmQqJNbPh9Q2ucU6XJv
         6RheD41mMLFa/hTT5f93jcWG+0T+30yO5WlNjtnQlQztCFbdglP8JqVafjJWeJaXYmx3
         AQDibQ4+rbqKzwAb1hsoveevNhwh7C70ep2AlCblG19JmVDYP5hT/Mhg3RCi/PDau+Ac
         T1lTpG5gxrYh/GMMuREu6c8wA5Y/Sf1dKdrp+dRs0l63MA3X2al0MEpU51DEwBI4uTgX
         M8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Sq7Z/lIz8bbC56tb3CQAmeROLXNJUY4bdCbN5g9MAw=;
        b=uMfiRskbgJabZy6cfSXU+C7pXGtlUZl2ib3MeV+AbsixAibMtv230FJ+ajphYoAWYh
         1HEkhSnXoPz4Y+5mvk/5VjtkUhShihf31dUNMYL1caSGgPEUZedGQ3/2+4Nh0KsvoYpJ
         d3FY5i9HF1QU9SvaPObLBRKBH3jpBrRfFz9Iq1kxon/BaqTWH/gr2enxFKraASOp18R9
         /uu47SLkJmC5JxlUg6UFHeKMqGM6queYZQaAkqjqO3wRxDPSVwdEBQc1XMBNL6/jWgAU
         qKShLunjVyq3qUhui37hKql17eD9vTsafwrUVcYo5vUGHpOJmQ+4Z5d877WpeuOC6KpS
         cQSQ==
X-Gm-Message-State: AOAM532YtN6KxY/wL3hWVesTQwoyYIp6XbeVjs7n33f/B2cR/f1J1d/O
        mdkgZ8gMkAPTM5x7uSmMKUdj/k4onJsf3F//HNDuiKjCIv4=
X-Google-Smtp-Source: ABdhPJzJmi/UaA9E39pDtXL64ii7oxorADCwjku/wjgz09aB1/7kESmxtHNy/Df6AAJ/F2eAKP4PCj3EW+5gqjsFb9M=
X-Received: by 2002:a02:ccd0:0:b0:32a:e2da:1e1f with SMTP id
 k16-20020a02ccd0000000b0032ae2da1e1fmr3912463jaq.313.1651446570465; Sun, 01
 May 2022 16:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220429185839.GZ29107@merlins.org> <CAEzrpqdpTXvDCmo-7H6QU1BKXM+fcG6ZdfHzQj0+=+7kcgkuOw@mail.gmail.com>
 <20220430022406.GH12542@merlins.org> <CAEzrpqdiYrbG4FDyoR1=HFZ-d12kD6mF-szxE-e+M-9ahKWd8A@mail.gmail.com>
 <20220430130752.GI12542@merlins.org> <CAEzrpqc3jBA4gRiLuYWFgs8zu_XrNDZ_JS+d2J_TN2a-sivO=w@mail.gmail.com>
 <20220430231115.GJ12542@merlins.org> <CAEzrpqe9Kh7k6n_ohyjgeMm4Pvy6tNCoKBXBPKhtcC5CrVfexw@mail.gmail.com>
 <20220501045456.GL12542@merlins.org> <CAEzrpqe-92ZV-YqL8v9z1TV4wnqbVUjroTMsvC86z6Vws3Rb6A@mail.gmail.com>
 <20220501152231.GM12542@merlins.org>
In-Reply-To: <20220501152231.GM12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 1 May 2022 19:09:19 -0400
Message-ID: <CAEzrpqeiWrW6NbWLmUiWwE96sVNb+H0bEXmaij1K-HJQ38vL7w@mail.gmail.com>
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

On Sun, May 1, 2022 at 11:22 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 01, 2022 at 07:28:10AM -0400, Josef Bacik wrote:
> > > processed 81920 of 109445120 possible bytes
> > > Recording extents for root 165299
> > > processed 16384 of 75792384 possible bytes
> > > Recording extents for root 18446744073709551607
> > > processed 16384 of 16384 possible bytes
> > > doing block accounting
> > > doing close???
> >
> > Ok must be in the block accounting stuff which has 0 prints, fixed
> > that up.  Thanks,
>
> Recording extents for root 18446744073709551607
> processed 16384 of 16384 possible bytes
> doing block accounting
> ERROR: update block group failed
> FIX BLOCK ACCOUNTING FAILED -1
> ERROR: The commit failed???? -1
>

Sorry was on airplanes, pushed some more debugging.  Thanks,

Josef
