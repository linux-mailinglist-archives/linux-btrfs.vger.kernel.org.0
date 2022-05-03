Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6829F51893D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 18:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbiECQEn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 12:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiECQEl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 12:04:41 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66473193C1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 09:01:08 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m6so15263938iob.4
        for <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6vbAnqdAPzrQp/2BCc7DQ/wLzDoUrcG3v+ebFuV58d8=;
        b=YC9tg8D5u2/X6ZjnT/1jX3/fQ4ly52d50HrnewnIArcS+garWFKTZQTuhCfgCbNDNG
         m3zZLimXPMdQHlA6mw5ULrknTDVLw+3GdtycROTZsrQqQ4GqqLAZ8TaBY8GOxiVg6fX5
         MMo4H35x5XStwa0YbsXVuL0mOKKtwSrxrv2giLcWgCom6ltvdqY+RQfLLcxPIOkZdlrU
         6Iku8mP44pVY9naUDIbSxjB6yEZ3YJV3FfJpuXh5fGuJByoc0q5owJqIPJ87/b/Vhk7Y
         mhn/hXiRc03RDrhtiAC2qumb/T6tz80szmoPys4Bm6vP4ifpie1U++PNdq/2tNDTNpqv
         5N2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vbAnqdAPzrQp/2BCc7DQ/wLzDoUrcG3v+ebFuV58d8=;
        b=3G56fVisxJqHqF4cPi6+p1oYir4bhBFNwfu2ogjmah1XVZU2WblJasJ4my6jJ+jt3W
         hRwuwPD/iSvlAe3OUmlZuMV2gUpTMAiJ9e3/DVAAZbXaOsXyZLhbaJcbDHXzFqOd+ZuO
         YfRvigYHWTcSUO5c+W6/WW7yrWSjooVQ11ZbXL8Sm8ma0r+r8EC2mAYonF5CtpubHjzI
         YSwKlKdBlcQhHNFMAWb0hL1TzRSyn/HD/OV6wBibM/J407scP9ms3j4tIuZxyQ7w5SQj
         Q8puREr08MgnCgw6mywXpJt8hE+7CzigYXiI/0QqBL6lEveuH2/MhLfhD54yFzFQpWy1
         y4NA==
X-Gm-Message-State: AOAM532cZhwV9mqFIjv6sJ5+uucOqe6BPX+ypq8J8XfGWxIR5xUW/zO2
        GWUF6Yf1frR2bSNR5v2WN6qOB9cRqsIl9Tx8NS3Ky0MAJNk=
X-Google-Smtp-Source: ABdhPJy9cPJyoeuFvV/DZ6b1DXe7UGztYbTHN0ordfd2FWi9jkZS8tcWUhz8ulnquj2eUEL3akRLJS8ManuFtXH5XQM=
X-Received: by 2002:a05:6602:14c2:b0:657:d130:daa with SMTP id
 b2-20020a05660214c200b00657d1300daamr6592432iow.83.1651593667692; Tue, 03 May
 2022 09:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220502200848.GR12542@merlins.org> <CAEzrpqf2VMEzZxO3k74imXCgXKhG=Nm+=ph=qkNhfJ_G8KFb4g@mail.gmail.com>
 <20220502214916.GB29107@merlins.org> <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
 <20220502234135.GC29107@merlins.org> <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
 <20220503012602.GT12542@merlins.org> <CAEzrpqdth9sKazxbiUhmuH7BTayzzsFGzfEDMpdd0ZOQ6C_GYw@mail.gmail.com>
 <20220503040250.GW12542@merlins.org> <CAEzrpqecGYEzA6WTNxkm5Sa_H-esXe7JzxnhEwdjhtoCCRe0Xw@mail.gmail.com>
 <20220503045553.GY12542@merlins.org>
In-Reply-To: <20220503045553.GY12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 3 May 2022 12:00:56 -0400
Message-ID: <CAEzrpqdegGAkJmdpzqeLJrFNwkfkMMWEdFxkVQnfA0DvdK5_Zg@mail.gmail.com>
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

On Tue, May 3, 2022 at 12:55 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 03, 2022 at 12:13:16AM -0400, Josef Bacik wrote:
> > Ok I fixed the debugging to not be so noisy so I can see what's going
> > on, lets give that a try,
>
> (...)
> inserting block group 13570381185024
> inserting block group 13571454926848
> inserting block group 13572528668672
> inserting block group 13573602410496
> inserting block group 13574676152320
> inserting block group 13575749894144
> inserting block group 13576823635968
> inserting block group 13577897377792
> inserting block group 13585413570560
> (...)
> inserting block group 15768498470912
> inserting block group 15769572212736
> inserting block group 15770645954560
> inserting block group 15771719696384
> inserting block group 15778162147328
> inserting block group 15779235889152
> inserting block group 15780309630976
> inserting block group 15781383372800
> inserting block group 15782457114624
> inserting block group 15783530856448
> inserting block group 15784604598272
> inserting block group 15785678340096
> inserting block group 15786752081920
> inserting block group 15787825823744
> inserting block group 15788899565568
> inserting block group 15789973307392
> inserting block group 15791047049216
> inserting block group 15792120791040
> inserting block group 15793194532864
> inserting block group 15794268274688
> inserting block group 15795342016512
> inserting block group 15796415758336
> inserting block group 15797489500160
> inserting block group 15798563241984
> inserting block group 15799636983808
> inserting block group 15800710725632
> inserting block group 15801784467456
> inserting block group 15802858209280
> inserting block group 15803931951104
> inserting block group 15809300660224
> inserting block group 15810374402048
> inserting block group 15811448143872
> inserting block group 15812521885696
> inserting block group 15813595627520
> inserting block group 15814669369344
> inserting block group 15815743111168
> inserting block group 15816816852992
> inserting block group 15817890594816
> inserting block group 15818964336640
> inserting block group 15820038078464
> inserting block group 15821111820288
> inserting block group 15822185562112
> inserting block group 15823259303936
> inserting block group 15824333045760
> inserting block group 15825406787584
> inserting block group 15826480529408
> inserting block group 15827554271232
> inserting block group 15828628013056
> inserting block group 15829701754880
> inserting block group 15830775496704
> inserting block group 15831849238528
> inserting block group 15832922980352
> inserting block group 15833996722176
> inserting block group 15835070464000
> inserting block group 15836144205824
> inserting block group 15837217947648
> inserting block group 15838291689472
> inserting block group 15839365431296
> inserting block group 15840439173120
> inserting block group 15842586656768
> processed 1556480 of 0 possible bytes
> processed 1474560 of 0 possible bytes
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
> Ignoring transid failure
> Recording extents for root 11223
> processed 1619902464 of 1635549184 possible bytesIgnoring transid failure
> failed to find block number 13576823652352
> kernel-shared/extent-tree.c:1432: btrfs_set_block_flags: BUG_ON `1` triggered, value 1
>

Fucking hell, do the tree-recover again and then the init-extent-tree.
Once I'm done with this conference I'll work out why this keeps
happening.  Thanks,

Josef
