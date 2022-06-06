Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB22153F1EC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 00:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiFFWAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 18:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiFFWAY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 18:00:24 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E17DFD13
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 15:00:22 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id f12so12937727ilj.1
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jun 2022 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7zrD91wiuXanmdbCl8nlqr+uhWIcAYkcNoNojbzFIM=;
        b=c7Hi7PCHgreewOVB9AJaQvB3/sqqYElYGtcFZiUkPmRrRFU68odzNpxZTOhoBvwrn/
         lUm+ke2Z4lFfQQ6FbLAx9mVwYgFkViqMLXcoP3yCMio0Z6tIr+vYDVZMFEKIth1EPgT4
         FitEiNl70OUSpv9U+mtjt5c+h4FZ/87mG3nXdKARrw9Dttb00zfGvc52vzGbxzGsa1i5
         9BUGink76ksnZy8qN3/Ml2dSCsUXpVuGOsu/BGr1AWET5gB4uR8VlWfBeg6vTd3iHUUC
         xJkVqAw0jXURS0aqrgH/eWHePB2B4zIFjK9851/h9msECh298Ts/cOclwlCd9016NsFM
         Ylnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7zrD91wiuXanmdbCl8nlqr+uhWIcAYkcNoNojbzFIM=;
        b=12jjALTgdOF5C+YnPO7z4WD6/CxP8VLx3FZeRgn2oN8V9A5AOJ9M1jrjQAgcZA1zPN
         eLgHh/zXrcS7DLY6kjluH6Nduo4Cu88hnRojEXOWEhrK28kSl7oM+8Q4pgFOA/F0tedV
         SlfRQauh6TGgybeTkPHy+ZlSjFsZfb3SFYpjyasoMac/ZS3/uzSAQLPc9RkDb+eGrkHc
         YJrH8NBKxxugIZuNvdbmdX43dDMo+7Gc6pIt5RjkfnyeHWNI9cR2LVEuK4nxgupckBN7
         RnKG2yi5eMkaCABgJEB22l7KCDDaKebwcdm4J5PHd+yjIBqIZA9LacZglOjJj15AxX9w
         JqRQ==
X-Gm-Message-State: AOAM530B0Dyxoatnl79jUVXiaFI1pSgYPDx5MM/SoUwQW3C7LzrRXUZs
        x7wXPdMYgFEJ+a1cKxPIO4k4bbzGNqPwVlsKO2ulYBbBIws=
X-Google-Smtp-Source: ABdhPJzcdn0him+idNBc8fguZEVosCVbKxDy4Ohtkg5yCmga0tOttYQ9HGQHFb1MnL+ustLTCCk/ap9QkiuBcqrZ3KQ=
X-Received: by 2002:a05:6e02:156e:b0:2d1:c265:964f with SMTP id
 k14-20020a056e02156e00b002d1c265964fmr15755236ilu.153.1654552821508; Mon, 06
 Jun 2022 15:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220605215036.GE22722@merlins.org> <CAEzrpqeYB0gC+pXr4UxL9TVipWDE2MFsg1tyrd7Nk+wEvV-zQQ@mail.gmail.com>
 <20220606000548.GF22722@merlins.org> <CAEzrpqdL6rK+-OUhW2AR3jXhK8TTsTM77A1CUkh=-+Y7Q1av9Q@mail.gmail.com>
 <20220606012204.GP1745079@merlins.org> <CAEzrpqeOb4XnGxbeMXNcDHn+wMNC7sBS7eFdsTbUj8c7BUgcuA@mail.gmail.com>
 <20220606210855.GL22722@merlins.org> <CAEzrpqe1_vbZ=+3C5=YPDJOCJGLAX9e4cmO_a+F1P3sdg9ubwQ@mail.gmail.com>
 <20220606212301.GM22722@merlins.org> <CAEzrpqdCpLsTqwBZ_W2sFZn9+uTrL88V=Cw6ZQe3XV0FxRO8nw@mail.gmail.com>
 <20220606215013.GN22722@merlins.org>
In-Reply-To: <20220606215013.GN22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 6 Jun 2022 18:00:10 -0400
Message-ID: <CAEzrpqcn_BRL7p3gPmS5OVn5D-m8hMB-5JcAHwEHwKpxGxOMqw@mail.gmail.com>
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

On Mon, Jun 6, 2022 at 5:50 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Jun 06, 2022 at 05:39:45PM -0400, Josef Bacik wrote:
> > On Mon, Jun 6, 2022 at 5:23 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Mon, Jun 06, 2022 at 05:19:40PM -0400, Josef Bacik wrote:
> > > > Nope different spot, I added some more printf's to narrow down which
> > > > path is messing up the key order.  Thanks,
> > >
> > > processed 49152 of 49463296 possible bytes, 0%
> > > searching 164623 for bad extents
> > > processed 311296 of 63193088 possible bytes, 0%
> > > searching 164624 for bad extents
> > >
> > > Found an extent we don't have a block group for in the file
> > > file
> > > push node left from right mid nritems 48 right nritems 0
> > > setting parent slot 0 to [256 1 0]
> > > corrupt node: root=164624 root bytenr 15645019684864 commit bytenr 15645019602944 block=15645019717632 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> >
> > Hmm, this sounds like we're not adjusting nritems, but the code
> > definitely is, so I'm sort of nervous about what's going to be
> > uncovered here.  Added some more information,
>
> processed 49152 of 49463296 possible bytes, 0%
> searching 164623 for bad extents
> processed 311296 of 63193088 possible bytes, 0%
> searching 164624 for bad extents
>
> Found an extent we don't have a block group for in the file
> file
> push node left from right mid nritems 48 right nritems 0 parent 15645019684864 parent nritems 7
> parent nritems is now 6
> corrupt node: root=164624 root bytenr 15645019684864 commit bytenr 15645019602944 block=15645019717632 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> kernel-shared/ctree.c:1042: balance_level: BUG_ON `check_path(path)` triggered, value -5

Hmm ok this may just be a new thing I have to check for in
tree-recover.  Give this a shot please, thanks,

Josef
