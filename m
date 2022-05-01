Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6A851641B
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 13:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346173AbiEALcI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 07:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346396AbiEALbw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 07:31:52 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB606D953
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 04:28:23 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e1so6502973ile.2
        for <linux-btrfs@vger.kernel.org>; Sun, 01 May 2022 04:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/91Ws+9W6AHAYLZfA6GbZGrSIbQ3KlsmVj9hhFR75ak=;
        b=8CRezTH/DUTrpMuESwCj5I7hWpwRxR3YXcsQcEfp95MVt9x27cu18mq7xSstnrFhKC
         OhRt3gCTvwBT31gis9Mpa01kOFzI4l9xNrrLYu7a9ffbNHyIWFcufFm3nq5TZCF9+eIH
         g4ldOC9Y+8vdu4q5x5oc19IrrFauNWkB89NCttOLKpNCaLK5QvlPTAGdDoR5st6Ag0Yf
         gJc720x/iLIyelQ5nXMQtKSxjBhagxzzj1lzvgFfmxpSRthnxzcLpsDq8KP9TpwxwVcw
         ncmtZzrpGtuJRRc90D8G1+q2qcVyDvMM6/j7cI7CadilLB7qoZgU3ziHTPlA/X6EHpTt
         ndRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/91Ws+9W6AHAYLZfA6GbZGrSIbQ3KlsmVj9hhFR75ak=;
        b=Sgyza7f8cT8Sp8ZkWHvBzBeQ/3HySwF//ZHt/hi9DAt1oMPwUTw0RVh2nq637KzFhi
         MLVzkjybZ3UKKL+Rx+6Sei0Xm99P3roYDdSuKeQWVMWVAJOpy/bt/PwvSO6Q6OsGJxC3
         TJQzR7/AyFsMhtx9c29RJjjWPP3eZM6NC6pCs42tCCEGRxTVvSKDkOqef6/j969xblKC
         BjWoKIrHEwQEcG5GSpehAeXIhBxE1hybFQupndUpGiL/vd8joZyRL7SIDuf/dUzrPYGw
         2i0nOulaWl/LEWoSesMpLzr1ALUJHTKxpiTIJ0j0CQjyDYrPEKVPeShC6UafUwHDnKR1
         hXxQ==
X-Gm-Message-State: AOAM532zn6aHV1II/vjBDvonZeOPRZtiEFebzILOBMEvrdhwgIEBNnOC
        AsqOOaIlE1pQgR8GNARZFBsxT/5yY+fDjsAYToQzqHHk4yc=
X-Google-Smtp-Source: ABdhPJxIql02QbgzbXN0NRnegV/JNaHjFUfT0o0lpBleRoLj4W96+LKvP2NjLP/7rjmiLnjdQOBJbRvBVwN1B/D3s/w=
X-Received: by 2002:a05:6e02:194d:b0:2cd:93bf:9569 with SMTP id
 x13-20020a056e02194d00b002cd93bf9569mr3158597ilu.152.1651404501817; Sun, 01
 May 2022 04:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220429171619.GG12542@merlins.org> <CAEzrpqdTzbpUZR-+UV1_fx9p_pq188cQbGOqraHP=2Vpdi89Mw@mail.gmail.com>
 <20220429185839.GZ29107@merlins.org> <CAEzrpqdpTXvDCmo-7H6QU1BKXM+fcG6ZdfHzQj0+=+7kcgkuOw@mail.gmail.com>
 <20220430022406.GH12542@merlins.org> <CAEzrpqdiYrbG4FDyoR1=HFZ-d12kD6mF-szxE-e+M-9ahKWd8A@mail.gmail.com>
 <20220430130752.GI12542@merlins.org> <CAEzrpqc3jBA4gRiLuYWFgs8zu_XrNDZ_JS+d2J_TN2a-sivO=w@mail.gmail.com>
 <20220430231115.GJ12542@merlins.org> <CAEzrpqe9Kh7k6n_ohyjgeMm4Pvy6tNCoKBXBPKhtcC5CrVfexw@mail.gmail.com>
 <20220501045456.GL12542@merlins.org>
In-Reply-To: <20220501045456.GL12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 1 May 2022 07:28:10 -0400
Message-ID: <CAEzrpqe-92ZV-YqL8v9z1TV4wnqbVUjroTMsvC86z6Vws3Rb6A@mail.gmail.com>
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

On Sun, May 1, 2022 at 12:54 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sat, Apr 30, 2022 at 10:48:08PM -0400, Josef Bacik wrote:
> > > Recording extents for root 165299
> > > processed 16384 of 75792384 possible bytes
> > > Recording extents for root 18446744073709551607
> > > processed 16384 of 16384 possible bytes
> > > ERROR: commit_root already set when starting transaction
> >
> > Well it looks like it finished, but I don't see my "start transaction
> > failed" messages which should be printing, I've added some extra
> > debugging to figure out wherever this is failing.  We're literally
> > done and of course it's failing somewhere at the end, hopefully
> > this'll be quicker to nail down.  Thanks,
>
> Good news :)
> Here is the new one:
> doing roots
> Recording extents for root 4
> processed 1032192 of 1064960 possible bytes
> Recording extents for root 5
> processed 10960896 of 10977280 possible bytes
> Recording extents for root 7
> processed 16384 of 16545742848 possible bytes
> Recording extents for root 9
> processed 16384 of 16384 possible bytes
> Recording extents for root 11221
> processed 16384 of 255983616 possible bytes
> Recording extents for root 11222
> processed 49479680 of 49479680 possible bytes
> Recording extents for root 11223
> processed 1635319808 of 1635549184 possible bytes
> Recording extents for root 11224
> processed 75792384 of 75792384 possible bytes
> Recording extents for root 159785
> processed 108855296 of 108855296 possible bytes
> Recording extents for root 159787
> processed 49152 of 49479680 possible bytes
> Recording extents for root 160494
> processed 1179648 of 109035520 possible bytes
> Recording extents for root 160496
> processed 49152 of 49479680 possible bytes
> Recording extents for root 161197
> processed 147456 of 109019136 possible bytes
> Recording extents for root 161199
> processed 49152 of 49479680 possible bytes
> Recording extents for root 162628
> processed 49152 of 49479680 possible bytes
> Recording extents for root 162632
> processed 2129920 of 109314048 possible bytes
> Recording extents for root 162645
> processed 49152 of 75792384 possible bytes
> Recording extents for root 163298
> processed 49152 of 49479680 possible bytes
> Recording extents for root 163302
> processed 147456 of 109314048 possible bytes
> Recording extents for root 163303
> processed 81920 of 75792384 possible bytes
> Recording extents for root 163316
> processed 49152 of 109314048 possible bytes
> Recording extents for root 163318
> processed 16384 of 49479680 possible bytes
> Recording extents for root 163916
> processed 49152 of 49479680 possible bytes
> Recording extents for root 163920
> processed 81920 of 109314048 possible bytes
> Recording extents for root 163921
> processed 49152 of 75792384 possible bytes
> Recording extents for root 164620
> processed 49152 of 49479680 possible bytes
> Recording extents for root 164624
> processed 491520 of 109445120 possible bytes
> Recording extents for root 164633
> processed 49152 of 75792384 possible bytes
> Recording extents for root 165098
> processed 212992 of 109445120 possible bytes
> Recording extents for root 165100
> processed 16384 of 49479680 possible bytes
> Recording extents for root 165198
> processed 49152 of 109445120 possible bytes
> Recording extents for root 165200
> processed 16384 of 49479680 possible bytes
> Recording extents for root 165294
> processed 16384 of 49479680 possible bytes
> Recording extents for root 165298
> processed 81920 of 109445120 possible bytes
> Recording extents for root 165299
> processed 16384 of 75792384 possible bytes
> Recording extents for root 18446744073709551607
> processed 16384 of 16384 possible bytes
> doing block accounting
> doing close???

Ok must be in the block accounting stuff which has 0 prints, fixed
that up.  Thanks,

Josef
