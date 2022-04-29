Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8552E5149AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359132AbiD2Moc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 08:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358700AbiD2Moa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 08:44:30 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4201562DC
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 05:41:11 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 125so9558319iov.10
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 05:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9WcGdqB5J0pwXza5nkD7WuEUc3Izcg/De5UNlCT8g3M=;
        b=Ggk13mNPmfYna1bBqCRnPvArfhMs16XuXt1NJ7KlG1RAdd6rEWaaC/LIxXHUeRLeQk
         5NJPLqR/KYSE6SARXZYMJTqLuiQT5KrMOhWcrSWtSPA8hi9zwdpJH89ex0PfdmKmfHiI
         Hx0QOdUXt8al6EUGwPiDTYNAkds+IEoeHLWvgFGfQN4mKJGEzOrUX7V3mJD3hediNYPI
         VsWXxs1hMbuny0hBT3Aix5GHI++xm8RC2tCypQGDK+nw3YWfVzT5TsgrZd3EI5sEbxWc
         l1CG9pY2b98mvHXqp/jW75d2q7zk7ZtCDO0MUYoWCMW8FdXzmby25A7YLZMIqTcI/rfN
         QA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9WcGdqB5J0pwXza5nkD7WuEUc3Izcg/De5UNlCT8g3M=;
        b=phFjYMsT86IcVno0/LXtX0xqUhyhZVFtVgIZGQCFh8t4fH7DLLLJYPnJDQ5iIB6YN/
         HeHsatL6SlacexDoWEup5tRD+2FOHbFuJxggU9jIhybCt9HnrL0TWK/mowg5OLpMuAOb
         HozxdqkFVTcnDWMWmIAWTIMz0/AuiVMimbii8GUoA5p0Z0p0ag6TVobqgDj64R9vOQs2
         lA7DwNxFHATRfS/aAeMRPY5OJ+FfxM0m+3YfRKK2y0kh5MS8IoHK89uiaA+zUBFQ/u6J
         F6Ny2YHaPG9ljMTc9d5f7tZVDvSn0ZK4dG5zzrNWhLLhq1panMFytmhtbPui5BEf5b1g
         j1Qw==
X-Gm-Message-State: AOAM531bB06/MCue50fTHr2gti7qrrJ49Cga3HcRZn3o3Mc2QJANrrsx
        xFOS3W7pgq+Csr2yhVbmoMcO4Vkkd4stNXmJG5rSYxKoJQY=
X-Google-Smtp-Source: ABdhPJz4tcmiAyt9431AvFO272dn9zDnMaXuu3aQTNxNbr+FrukKt60enkT4qwSB4WdCBr7qVAsjs6295x54kIO+hmA=
X-Received: by 2002:a05:6602:14c2:b0:657:d130:daa with SMTP id
 b2-20020a05660214c200b00657d1300daamr1217736iow.83.1651236071271; Fri, 29 Apr
 2022 05:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220428205716.GU29107@merlins.org> <CAEzrpqduAKibaDJPJ6s7dCAfQHeynwG6zJwgVXVS_Uh=cQq2dw@mail.gmail.com>
 <20220428214241.GW29107@merlins.org> <CAEzrpqd0deCQ132HjNJC=AKQsRTXc=shnAmHfs0BR9pWiD4mhg@mail.gmail.com>
 <20220428222705.GX29107@merlins.org> <CAEzrpqeQrSrMgGLh0F34fVj8dnzJQF7kv=XSBKcD92oHyV8-gA@mail.gmail.com>
 <20220429005624.GY29107@merlins.org> <CAEzrpqe+n9iGQymL01eZQjPBnN+Z1NeGDyTDaC-pwsGkOwvuDg@mail.gmail.com>
 <20220429013409.GD12542@merlins.org> <CAEzrpqfF7xfLxSBpJGfu2uP5iUzBhirg=wRfs108rLyuiUSW1Q@mail.gmail.com>
 <20220429040335.GE12542@merlins.org>
In-Reply-To: <20220429040335.GE12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 29 Apr 2022 08:41:00 -0400
Message-ID: <CAEzrpqewAfxi9hK+vwK+Df3iziXBZZEmXhzgJdJDqTj-JXvFQw@mail.gmail.com>
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

On Fri, Apr 29, 2022 at 12:03 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Apr 28, 2022 at 09:38:05PM -0400, Josef Bacik wrote:
> > I'm going to scream.  Somehow the root pointer for 11223 got messed up
> > in all of this, do rescue tree-recover again so it can unfuck 11223,
> > and then init-extent-tree.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> FS_INFO IS 0x5588db830bc0
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x5588db830bc0
> Checking root 2 bytenr 15645018570752
> Checking root 4 bytenr 15645196861440
> Checking root 5 bytenr 13577660252160
> Checking root 7 bytenr 15645018554368
> Checking root 9 bytenr 15645878108160
> Checking root 11221 bytenr 13577562996736
> Checking root 11222 bytenr 15645261905920
> Checking root 11223 bytenr 13576823668736
> Repairing root 11223 bad_blocks 9 update 1
> deleting slot 54 in block 11652138631168
> deleting slot 54 in block 11652138631168
> deleting slot 64 in block 11652138631168
> deleting slot 86 in block 11652138631168
> deleting slot 87 in block 11652138631168
> deleting slot 87 in block 11652138631168
> deleting slot 87 in block 11652138631168
> deleting slot 87 in block 11652138631168
> deleting slot 87 in block 11652138631168
> Checking root 11224 bytenr 13577126182912
> Checking root 159785 bytenr 6781490577408
> Checking root 159787 bytenr 15645908385792
> Checking root 160494 bytenr 6781491265536
> Checking root 160496 bytenr 11822309965824
> Checking root 161197 bytenr 6781492101120
> Checking root 161199 bytenr 13576850833408
> Checking root 162628 bytenr 15645764812800
> Checking root 162632 bytenr 6781492756480
> Checking root 162645 bytenr 5809981095936
> Checking root 163298 bytenr 15645124263936
> Checking root 163302 bytenr 6781495197696
> Checking root 163303 bytenr 15645365993472
> Checking root 163316 bytenr 6781496393728
> Checking root 163318 bytenr 15645980491776
> Checking root 163916 bytenr 11822437826560
> Checking root 163920 bytenr 11971021275136
> Checking root 163921 bytenr 11971073802240
> Checking root 164620 bytenr 15645434036224
> Checking root 164624 bytenr 15645502210048
> Checking root 164633 bytenr 15645526884352
> Checking root 165098 bytenr 11970667446272
> Checking root 165100 bytenr 11970733621248
> Checking root 165198 bytenr 12511656394752
> Checking root 165200 bytenr 12511677972480
> Checking root 165294 bytenr 13576901328896
> Checking root 165298 bytenr 13577133326336
> Checking root 165299 bytenr 13577191505920
> Checking root 18446744073709551607 bytenr 13576823799808
> Tree recovery finished, you can run check now
>
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1
> inserting block group 15838291689472
> inserting block group 15839365431296
> inserting block group 15840439173120
> inserting block group 15842586656768
> processed 1556480 of 0 possible bytes
> processed 1474560 of 0 possible bytes
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
> processed 1634844672 of 1635549184 possible bytesadding a bytenr that overlaps our thing, dumping paths for [1834097, 108, 1835008]
> inode ref info failed???
> elem_cnt 1 elem_missed 0 ret 0
> Xilinx_Unified_2020.1_0602_1208/tps/lnx64/jre9.0.4/lib/modules
> doing an insert of the bytenr
> doing an insert that overlaps our bytenr 3700677820416 53248
> processed 1635319808 of 1635549184 possible bytes
> Recording extents for root 11224
> processed 75792384 of 75792384 possible bytes
> Recording extents for root 159785
> processed 108855296 of 108855296 possible bytes
> Recording extents for root 159787
> processed 49152 of 49479680 possible bytes
> Recording extents for root 160494
> processed 999424 of 109035520 possible bytesFailed to find [10467695652864, 168, 8675328]

Yayyyy progress, I just updated the debugging for the new problem
bytenr so we can figure out who to delete, run init-extent-tree again
please.  Thanks,

Josef
