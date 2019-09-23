Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20EA0BBE19
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 23:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390044AbfIWVq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 17:46:57 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:39462 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389663AbfIWVq5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 17:46:57 -0400
Received: by mail-wm1-f47.google.com with SMTP id v17so10839511wml.4
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6LMRmx1qApvD6R71GApiIQopgZ8qzmMMJUzwxSVWtk=;
        b=Ch0uH2RcD9mf63nqeyp3BtTzsDaYS+4fDcId/TvfPxTHynGV9vtRPbVSTlOjwff5aD
         mt690dv4NSLsvoxdCgCNnPIpsGYP9PnpTd39ZV6vpaBrWV8jaJnSHd6w+cc1YmjLCnbu
         Di43THiV53trK+yadle6bDC+jxpDvfuiXyNrHzjDcNymtSMOuQnwR9+0rWRK5DxBMnmZ
         PNVYmKTAVNjiO/tX2xQHFdYqSeeieylrgvgDoYj8AUPxaoNky6fQcBu61Kb06aLECTxR
         iuWbmL+HyFKoTN37amDfPCoczEkDvDmj/ejMS8qhvXeOjvhVuQ+bQqT2dgYGX8jWWVEI
         bIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6LMRmx1qApvD6R71GApiIQopgZ8qzmMMJUzwxSVWtk=;
        b=lCpAfkfQaZ8/lgoSkW4KoyQHwUBOJem3WFDph9TjUpCqUCRyLxoc9QAx/uyzurP/J5
         uGbAv/LN4UzF7ShhVWGbaJ3Qw9mpDU5jQQ0Mesh3TD8AKYlDA3PKzEVzb+siEcepiyHb
         bjrKoH6MobLAKzdK6tUqKg40wh9dh/9DEjrT/dSveAT7uyifjl6UliG1NSlJMHor/eYC
         q5KGuXj9iS7PS+cjYnU/P86ujoGAHwGqlkeypwbenbJXwgjpPvwJ1nrtKySMmn41mqyz
         q/T2L/JGmGfwXPKGYjWjsGr092txDRTg/K9U34OSsiz7JXDjUdJ0XGYai/Wi9elTKw/1
         B23Q==
X-Gm-Message-State: APjAAAV3q7XvM8/S41yW5WzZFKsJuWrniQNijybOXG369OJau+LIB9pe
        XNLO7lPquvvHwpAQ5SSZNj0aOmEsvXO9NgtOsqaKbQ==
X-Google-Smtp-Source: APXvYqx166wG23sKrXx6hjdsYDD+o2+rDdf/utMLhLM12UjuQTtDQAS3I18viQOWn3YwUU9LR1LB/5rxzAFIYmGQcK0=
X-Received: by 2002:a1c:5942:: with SMTP id n63mr1215262wmb.65.1569275212241;
 Mon, 23 Sep 2019 14:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <94ebf95b-c8c2-e2d5-8db6-77a74c19644a@petezilla.co.uk>
 <CAJCQCtRAnJR+Z8Z8Bq91YXiMpfmwOiHK0tQ+9zAJvSVvexHnxg@mail.gmail.com>
 <54fa8ba3-0d02-7153-ce47-80f10732ef14@petezilla.co.uk> <CAJCQCtQLk1m8yAxPPDLVZBr3MehdDD3EpNZ6O_OCRsO-FFzRNw@mail.gmail.com>
 <eb9fdaee-ec76-5285-4384-7a615d3cd5c1@petezilla.co.uk> <00be81e2-bca2-3906-c27d-68f252a6ffe1@petezilla.co.uk>
In-Reply-To: <00be81e2-bca2-3906-c27d-68f252a6ffe1@petezilla.co.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 23 Sep 2019 15:46:41 -0600
Message-ID: <CAJCQCtRvE90T-Gjn1u85++to3+Fjrj_4=x9P5PyUU4tURtu2gg@mail.gmail.com>
Subject: Re: Balance ENOSPC during balance despite additional storage added
To:     Peter Chant <pete@petezilla.co.uk>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 23, 2019 at 3:34 PM Peter Chant <pete@petezilla.co.uk> wrote:
>
> On 9/23/19 7:55 PM, Pete wrote:
>
> > I'm not sure the balance is resolving anything.  The filesystem has not
> > gone read only.  I'll try an unfiltered balance now to see how that goes.
> >
>
> OK, result of unfiltered balance:
>
> root@phoenix:/var/lib/lxc# btrfs bal start /var/lib/lxc
> WARNING:
>
>         Full balance without filters requested. This operation is very
>         intense and takes potentially very long. It is recommended to
>         use the balance filters to narrow down the scope of balance.
>         Use 'btrfs balance start --full-balance' option to skip this
>         warning. The operation will start in 10 seconds.
>         Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting balance without any filters.
> ERROR: error during balancing '/var/lib/lxc': No space left on device
> There may be more info in syslog - try dmesg | tail
> root@phoenix:/var/lib/lxc#
>
> OK, here is the output in the last 100 lines of dmesg.  The line 'unable
> to make block group nnnnnnnnnnnnnnn ro' is repeated, I presume that is
> relevant.  I'm noting no other ill effects, if I'd not tried the balance
> I would not know anything is amiss.
>
> root@phoenix:/var/lib/lxc# dmesg | tail -n 100
> [ 1880.155026] BTRFS info (device dm-4): sinfo_used=19522584576
> bg_num_bytes=54394880 min_allocable=1048576
> [ 1880.155027] BTRFS info (device dm-4): space_info 4 has
> 18446744065997733888 free, is not full
> [ 1880.155029] BTRFS info (device dm-4): space_info total=11811160064,
> used=10509664256, pinned=0, reserved=131072, may_use=9013182464, readonly=0
> [ 1880.155029] BTRFS info (device dm-4): global_block_rsv: size
> 536870912 reserved 536805376
> [ 1880.155030] BTRFS info (device dm-4): trans_block_rsv: size 262144
> reserved 262144
> [ 1880.155031] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
> [ 1880.155031] BTRFS info (device dm-4): delayed_block_rsv: size 0
> reserved 0
> [ 1880.155032] BTRFS info (device dm-4): delayed_refs_rsv: size
> 17514102784 reserved 8475983872
> [ 1880.155049] BTRFS info (device dm-4): unable to make block group
> 1608583741440 ro
> [ 1880.155050] BTRFS info (device dm-4): sinfo_used=19523239936
> bg_num_bytes=54394880 min_allocable=1048576
> [ 1880.155051] BTRFS info (device dm-4): space_info 4 has
> 18446744067071213568 free, is not full
> [ 1880.155052] BTRFS info (device dm-4): space_info total=12884901888,
> used=10509664256, pinned=0, reserved=131072, may_use=9013444608, readonly=0
> [ 1880.155053] BTRFS info (device dm-4): global_block_rsv: size
> 536870912 reserved 536805376
> [ 1880.155053] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
> [ 1880.155054] BTRFS info (device dm-4): chunk_block_rsv: size 393216
> reserved 393216
> [ 1880.155054] BTRFS info (device dm-4): delayed_block_rsv: size 0
> reserved 0
> [ 1880.155055] BTRFS info (device dm-4): delayed_refs_rsv: size
> 17515151360 reserved 8476639232
> [ 1880.155080] BTRFS info (device dm-4): unable to make block group
> 1607509999616 ro
> [ 1880.155081] BTRFS info (device dm-4): sinfo_used=19523239936
> bg_num_bytes=78774272 min_allocable=1048576
> [ 1880.155081] BTRFS info (device dm-4): space_info 4 has
> 18446744067071213568 free, is not full
> [ 1880.155083] BTRFS info (device dm-4): space_info total=12884901888,
> used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
> [ 1880.155083] BTRFS info (device dm-4): global_block_rsv: size
> 536870912 reserved 536805376
> [ 1880.155084] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
> [ 1880.155085] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
> [ 1880.155086] BTRFS info (device dm-4): delayed_block_rsv: size 0
> reserved 0
> [ 1880.155087] BTRFS info (device dm-4): delayed_refs_rsv: size
> 17515937792 reserved 8476606464
> [ 1880.155097] BTRFS info (device dm-4): unable to make block group
> 1607509999616 ro
> [ 1880.155098] BTRFS info (device dm-4): sinfo_used=19523239936
> bg_num_bytes=78774272 min_allocable=1048576
> [ 1880.155098] BTRFS info (device dm-4): space_info 4 has
> 18446744068144955392 free, is not full
> [ 1880.155099] BTRFS info (device dm-4): space_info total=13958643712,
> used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
> [ 1880.155100] BTRFS info (device dm-4): global_block_rsv: size
> 536870912 reserved 536805376
> [ 1880.155100] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
> [ 1880.155101] BTRFS info (device dm-4): chunk_block_rsv: size 393216
> reserved 393216
> [ 1880.155101] BTRFS info (device dm-4): delayed_block_rsv: size 0
> reserved 0
> [ 1880.155101] BTRFS info (device dm-4): delayed_refs_rsv: size
> 17516199936 reserved 8476606464
> [ 1880.155106] BTRFS info (device dm-4): unable to make block group
> 1606436257792 ro
> [ 1880.155106] BTRFS info (device dm-4): sinfo_used=19523239936
> bg_num_bytes=183910400 min_allocable=1048576
> [ 1880.155107] BTRFS info (device dm-4): space_info 4 has
> 18446744068144955392 free, is not full
> [ 1880.155107] BTRFS info (device dm-4): space_info total=13958643712,
> used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
> [ 1880.155108] BTRFS info (device dm-4): global_block_rsv: size
> 536870912 reserved 536805376
> [ 1880.155108] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
> [ 1880.155109] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
> [ 1880.155109] BTRFS info (device dm-4): delayed_block_rsv: size 0
> reserved 0
> [ 1880.155110] BTRFS info (device dm-4): delayed_refs_rsv: size
> 17515937792 reserved 8476606464
> [ 1880.155116] BTRFS info (device dm-4): unable to make block group
> 1606436257792 ro
> [ 1880.155116] BTRFS info (device dm-4): sinfo_used=19523239936
> bg_num_bytes=183910400 min_allocable=1048576
> [ 1880.155117] BTRFS info (device dm-4): space_info 4 has
> 18446744069218697216 free, is not full
> [ 1880.155118] BTRFS info (device dm-4): space_info total=15032385536,
> used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
> [ 1880.155118] BTRFS info (device dm-4): global_block_rsv: size
> 536870912 reserved 536805376
> [ 1880.155118] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
> [ 1880.155119] BTRFS info (device dm-4): chunk_block_rsv: size 393216
> reserved 393216
> [ 1880.155119] BTRFS info (device dm-4): delayed_block_rsv: size 0
> reserved 0
> [ 1880.155120] BTRFS info (device dm-4): delayed_refs_rsv: size
> 17516199936 reserved 8476606464
> [ 1880.155123] BTRFS info (device dm-4): unable to make block group
> 1605362515968 ro
> [ 1880.155124] BTRFS info (device dm-4): sinfo_used=19523239936
> bg_num_bytes=14385152 min_allocable=1048576
> [ 1880.155124] BTRFS info (device dm-4): space_info 4 has
> 18446744069218697216 free, is not full
> [ 1880.155125] BTRFS info (device dm-4): space_info total=15032385536,
> used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
> [ 1880.155126] BTRFS info (device dm-4): global_block_rsv: size
> 536870912 reserved 536805376
> [ 1880.155126] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
> [ 1880.155126] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
> [ 1880.155127] BTRFS info (device dm-4): delayed_block_rsv: size 0
> reserved 0
> [ 1880.155127] BTRFS info (device dm-4): delayed_refs_rsv: size
> 17515937792 reserved 8476606464
> [ 1880.155133] BTRFS info (device dm-4): unable to make block group
> 1605362515968 ro
> [ 1880.155134] BTRFS info (device dm-4): sinfo_used=19523239936
> bg_num_bytes=14385152 min_allocable=1048576
> [ 1880.155134] BTRFS info (device dm-4): space_info 4 has
> 18446744070292439040 free, is not full
> [ 1880.155135] BTRFS info (device dm-4): space_info total=16106127360,
> used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
> [ 1880.155136] BTRFS info (device dm-4): global_block_rsv: size
> 536870912 reserved 536805376
> [ 1880.155136] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
> [ 1880.155136] BTRFS info (device dm-4): chunk_block_rsv: size 393216
> reserved 393216
> [ 1880.155137] BTRFS info (device dm-4): delayed_block_rsv: size 0
> reserved 0
> [ 1880.155137] BTRFS info (device dm-4): delayed_refs_rsv: size
> 17516199936 reserved 8476606464
> [ 1880.155141] BTRFS info (device dm-4): unable to make block group
> 1525872066560 ro
> [ 1880.155141] BTRFS info (device dm-4): sinfo_used=19523239936
> bg_num_bytes=303333376 min_allocable=1048576
> [ 1880.155142] BTRFS info (device dm-4): space_info 4 has
> 18446744070292439040 free, is not full
> [ 1880.155143] BTRFS info (device dm-4): space_info total=16106127360,
> used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
> [ 1880.155143] BTRFS info (device dm-4): global_block_rsv: size
> 536870912 reserved 536805376
> [ 1880.155144] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
> [ 1880.155144] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
> [ 1880.155144] BTRFS info (device dm-4): delayed_block_rsv: size 0
> reserved 0
> [ 1880.155145] BTRFS info (device dm-4): delayed_refs_rsv: size
> 17515937792 reserved 8476606464
> [ 1880.155150] BTRFS info (device dm-4): unable to make block group
> 1525872066560 ro
> [ 1880.155151] BTRFS info (device dm-4): sinfo_used=19523239936
> bg_num_bytes=303333376 min_allocable=1048576
> [ 1880.155151] BTRFS info (device dm-4): space_info 4 has
> 18446744071366180864 free, is not full
> [ 1880.155152] BTRFS info (device dm-4): space_info total=17179869184,
> used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
> [ 1880.155152] BTRFS info (device dm-4): global_block_rsv: size
> 536870912 reserved 536805376
> [ 1880.155153] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
> [ 1880.155153] BTRFS info (device dm-4): chunk_block_rsv: size 393216
> reserved 393216
> [ 1880.155154] BTRFS info (device dm-4): delayed_block_rsv: size 0
> reserved 0
> [ 1880.155154] BTRFS info (device dm-4): delayed_refs_rsv: size
> 17516199936 reserved 8476606464
> [ 1880.155157] BTRFS info (device dm-4): unable to make block group
> 1524798324736 ro
> [ 1880.155158] BTRFS info (device dm-4): sinfo_used=19523239936
> bg_num_bytes=105562112 min_allocable=1048576
> [ 1880.155158] BTRFS info (device dm-4): space_info 4 has
> 18446744071366180864 free, is not full
> [ 1880.155159] BTRFS info (device dm-4): space_info total=17179869184,
> used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
> [ 1880.155159] BTRFS info (device dm-4): global_block_rsv: size
> 536870912 reserved 536805376
> [ 1880.155160] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
> [ 1880.155160] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
> [ 1880.155161] BTRFS info (device dm-4): delayed_block_rsv: size 0
> reserved 0
> [ 1880.155161] BTRFS info (device dm-4): delayed_refs_rsv: size
> 17515937792 reserved 8476606464
> [ 1880.155167] BTRFS info (device dm-4): unable to make block group
> 1524798324736 ro
>

I've got the same problem on a brand new file system. This is a bug.
And it's not fixed in 5.3.0. It might even be a regression.



-- 
Chris Murphy
