Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA5537286
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 May 2022 22:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiE2Uce (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 16:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiE2Ucc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 16:32:32 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8045F4578B
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 13:32:31 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id s1so1932543ilj.0
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CpsNZfGRJ7ATcbM/W0/76DqUmC6dD3Nt11rUMk+OJ/0=;
        b=foeOjIHTRYDOHFQE6owQ5oHZMbzlW2jc4Ox2lAinuJ+8TeRf5LduY7LJr8ismMPOXD
         lOCkuVYYmmXHAYaSXaBs+6JRRh01GrYNQank5LcE48uV4KElw1UBRqIabXCyaFX6xjej
         q9mOoXNC950NIog/IdcjKyzVmQVI5ZPBOAEUGbW6VnKapZk3kSL1TrIzrpo8RyXU5FRD
         rOM7iY1zlU7XPZmWO+GLb2+PfRIfM1vKT53JPyHTJYpDKDtj0ZYoorooM+5xazJurfyy
         n/PPOMmVN5OkSqM1dFenO8ga+1xxfBDHmU3VAasntMtVwGr8mDcOvo2f7DrtgkjCxzCD
         Yp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpsNZfGRJ7ATcbM/W0/76DqUmC6dD3Nt11rUMk+OJ/0=;
        b=2c1d24wCJGzdQWMnd7TelTnppSkzkNX1taNiutBl7dNqSoljRV238hrP0V1Fa3+4OK
         4Oaz2vwtClxhH/uSxcPR6B/RxrNeyir5l2NlSKHpLpBBrEGScLVMzJk5YXy2pqCz+AKy
         kvIn4sDZBSljRL2nEsD0pgVAKkQ1YW3JoUBgZICKsiVnDqs0yTXpHwge4fwqMQ/m84e5
         5+gRVHBHOU1aar9mYPijuWKn24dX4rwHdS3OG9kB0uG4iatLz4AM4FqwRJunw7EkqSH/
         bT41oUb4uu3A2BCE+CcXNhF92P+WDNamcORmUl84KCLGG6w5oslqnItz9cFCCoD8hP9g
         GTFA==
X-Gm-Message-State: AOAM5313/no1JzoVeBvyAgLEt9z4ivUe3f1McE82u1O3yBXca9deaS89
        uSb9hwVGaXxbb+qwegvB3VY8XYczItWj44zDSJ7lnQwJaVw=
X-Google-Smtp-Source: ABdhPJylXqHDcpB/LDSEQ8++xm7ja7NNEYslApudAaWdlv7zUR0XRmcZrIvN3S8JTHWQlo4PIcap28LZ7nom6wMWgAM=
X-Received: by 2002:a05:6e02:216a:b0:2d1:71a0:c2b8 with SMTP id
 s10-20020a056e02216a00b002d171a0c2b8mr25526652ilv.6.1653856350417; Sun, 29
 May 2022 13:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220528225601.GD24951@merlins.org> <CAEzrpqcG+9evRPKixVwGnAS_k2tb7o16jQgORtm1cw7hW_KsAw@mail.gmail.com>
 <20220529035139.GE24951@merlins.org> <CAEzrpqcKeVNkXa3txx0nyDnKUCp06msmd97d1fBedTzbmR5KcA@mail.gmail.com>
 <20220529153312.GF24951@merlins.org> <CAEzrpqdEk-j2bMfBLEdkhHcq1hWLmHv_Nx-0mj1vh0yJgZuCZQ@mail.gmail.com>
 <20220529180510.GG24951@merlins.org> <CAEzrpqfqD8jkznVQR1SL-YpF0ALx7Pbg+ptz7dVgRecOXeDtPg@mail.gmail.com>
 <20220529194235.GH24951@merlins.org> <CAEzrpqfd2jPWxUayfqyYRDN25-etc4_jgzcHmZ3LhGkb4e7Tsw@mail.gmail.com>
 <20220529200415.GI24951@merlins.org>
In-Reply-To: <20220529200415.GI24951@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 29 May 2022 16:32:19 -0400
Message-ID: <CAEzrpqdpvnbzaH1gxWnvWLMWEKtOAdYsH25mBWhkF-urf7Zw3g@mail.gmail.com>
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

On Sun, May 29, 2022 at 4:04 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 29, 2022 at 03:49:26PM -0400, Josef Bacik wrote:
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> > > WARNING: cannot read chunk root, continue anyway
> > > none of our backups was sufficient, scanning for a root
> > > ERROR: Couldn't find a valid root block for 3, we're going to clear it and hope for the best
> > > Tree recover failed
> >
> > Lord alright, lets try some debugging.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> WARNING: cannot read chunk root, continue anyway
> none of our backups was sufficient, scanning for a root
> scanning, best has 0 found 1 bad
> ERROR: Couldn't find a valid root block for 3, we're going to clear it and hope for the best
> Tree recover failed
> gargamel:/var/local/src/btrfs-progs-josefbacik#

Hmm, the sys array should be fine, try again, hopefully that'll clear
things up.  Thanks,

Josef
