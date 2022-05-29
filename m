Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1726A536EFE
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 May 2022 03:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiE2BAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 May 2022 21:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiE2BAN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 May 2022 21:00:13 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D76CF6F
        for <linux-btrfs@vger.kernel.org>; Sat, 28 May 2022 18:00:12 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 2so8271764iou.5
        for <linux-btrfs@vger.kernel.org>; Sat, 28 May 2022 18:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rveWIQ7l6CNRFG5h4bD6BFalepotMxRIJcOsl+GnQW4=;
        b=Z01raw2wT+6IwLodyrIx5MCNUCR8b5iOemvLGYg7op7rjDBcku2+uJMud7BdiQFh2e
         HDLIhW1pUXOTK7zWbLy3Imr3w71l0aeVh5+ddfgnGM3FCRHmhLUp65eY7mB60Nwqd/Gy
         PL7ZK/jF2ECvxGkOEFANFIvFqDqNJD1SJDuCNtGYfm3w7mPfGEUlNU95Vdj/2Nz4KE+M
         UlNFml+MjkCjuXVtHAHr/f7Zjnl/8S2odRh9b+K889prrQ2naXi5+yDsu63BtRMMmhlg
         1E8AMwpJWGczeXYL1/ebIypZM9Egg8kNERXVL4kYBwsKnEgrud0gzHYxSXpUZokn+vJW
         3UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rveWIQ7l6CNRFG5h4bD6BFalepotMxRIJcOsl+GnQW4=;
        b=UU7XAX1k4o2h5iPdtUATSHQNT8M2p06t3R5ECYO2aNEGGEWG68EXusb9Oh1au9nQeg
         6sXpsAbuqyCAhtfdFO0PvXX5Tfr6UyoXP2OjV0V3iLZlJSoIXx0C9FPbEYue0olDrt0H
         l1lAfnrW6T6mHpSEJqlwyvOGrYZXyWuqt4wuWvkHIX5ypKLgrXrQK5n+Ntt9X/eOzT7D
         IhU9lGhb7/gBrEJikipfHkYaKl65uKY+1UrttNg83uBWZPFheyrWSbwQqoVG4OJnD/Yf
         su5kJI3y6x/3iTv+v7sIN1vGQhV0okZLGlrKYRSoaCFJx8bDo7qVWDMyDC6QlM7Djk/K
         c7IQ==
X-Gm-Message-State: AOAM531p/5JT0RUt+veksYOS4E201O18BlF+//hobT/bqpy3AaFPuFv5
        7DwrB3m4sGCkduyyOt9RQnOHUAhdjvtTeCi0LQkZg6j5lFI=
X-Google-Smtp-Source: ABdhPJyjz7EuCFSEPSgjew4Efj2BBm5cjBKrc6JMSNOH7eVMA6IBpqZolbvPJLXRD3XoO/0eBpR/pBskjRFnlZVKrBc=
X-Received: by 2002:a05:6602:3429:b0:663:d819:fb31 with SMTP id
 n41-20020a056602342900b00663d819fb31mr14739486ioz.166.1653786011915; Sat, 28
 May 2022 18:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220526181246.GA28329@merlins.org> <CAEzrpqfEmm0qGZkkdTgFYNjVvSn6SZwbdDUYLO2E3jV4DYELFQ@mail.gmail.com>
 <20220526191512.GE28329@merlins.org> <CAEzrpqetTskf-UtyfXHBajpJBci4vxdSaBXwDTm5cRs2QtNRkw@mail.gmail.com>
 <20220526213924.GB2414966@merlins.org> <20220527011622.GA24951@merlins.org>
 <CAEzrpqdbuQGwwuCfYyVdiDtGDsPb=3FWmKrTEA5Xukk1ex514g@mail.gmail.com>
 <20220527232604.GA22722@merlins.org> <CAEzrpqeJyupr02nUJkBBVCah46FN+znVczm-RtfBFauvJW9O6w@mail.gmail.com>
 <CAEzrpqfAYRUYttOAMmdth4mfi4e7MTM++s5WOQ+KAzg2Kv0Nsw@mail.gmail.com> <20220528225601.GD24951@merlins.org>
In-Reply-To: <20220528225601.GD24951@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sat, 28 May 2022 21:00:00 -0400
Message-ID: <CAEzrpqcG+9evRPKixVwGnAS_k2tb7o16jQgORtm1cw7hW_KsAw@mail.gmail.com>
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

On Sat, May 28, 2022 at 6:56 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sat, May 28, 2022 at 04:08:25PM -0400, Josef Bacik wrote:
> > Sorry my ability to think isn't doing so great right now.  I've wired
> > up the detection stuff, but it won't actually fix anything yet.  I
> > want to make sure I've got detection part right before I go messing
> > with the file system.  If you can pull and build and then run
> >
> > btrfs rescue recover-chunks <device>
> >
> > and capture the output that would be great.  Hopefully this shows the
> > missing block groups and I can just copy them into place.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> Csum didn't match
> ERROR: cannot read chunk root
> WTF???
> ERROR: open ctree failed, try btrfs rescue tree-recover
> Recover chunks tree failed
> gargamel:/var/local/src/btrfs-progs-josefbacik#
>
> So, should I do what it says?

Oh yeah duh sorry, I was adding it to tree-recover but decided it was
a bad place for it.  Go ahead and run tree-recover and then do the
recover-chunks.  Thanks,

Josef
