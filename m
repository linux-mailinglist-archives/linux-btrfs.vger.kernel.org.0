Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F034753ACF8
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiFASnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiFASnJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 14:43:09 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E494768FBB
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 11:43:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9so1923591ilq.6
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRIyZm1V0p8nFxmyCbGC8u3op7oZGwi43gt4UKYaYcY=;
        b=HYQlRhzL4HxKwJG/duxgYwkOhr+rKgisfyAAQrXzMBE22aXQMt/wk/I2viQck9A9oc
         peSn1sRQJGWv88Q5tOYYVN0yh+aF0bER0FFNfevSyWwbpAMEhPEMMLURm2FX6i9L4QkW
         NFzYyKhJFS+ZMQ1qnG3Ajd3ntkZHTo/PwoZ5i5KyPD0UecGNPrK7Fmkytm6vhrCFYMmu
         fH0l/YuJ8S4nLs716q1KCbE+Y9mb1QKbakpoxuxWESWq1gg1qEsi75oObylOeUY6MdEp
         pm9Pcr5+PAWMqhYWxNryUJGH3KeZ4VQncOAaSTFATNBDAtlVol++VvoxjQwcj6holy3s
         n+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRIyZm1V0p8nFxmyCbGC8u3op7oZGwi43gt4UKYaYcY=;
        b=TZ0umG5HaGY+yWvHpWr3tFH4djxxMcwHrv3nP1umXkxvzAgEpqi5zG2RUBmrfG+joR
         0jcSnZEkudmtElLw/gHbkRzBWz2pWje2pccjhqbTXD9XGy0FeKbiZtxjA3CQbwIHfIPC
         6P58h0qq5Kx90UkMHY82VYWtpUZJbdX8HMnzWwR88tHh3/GBxCVgu3VY01DNfJIcaMMc
         6Fpx5Q9MZGgsWnIsvG3PK77z5lQyNGoNBJcwG3VZm9RqNwtnkclzWyADXo3EEOx5VpQA
         +vywUUdI7X22AecD1vJviIFjtdwLjvFjK7IhNkScDAB++pjG5Mgb8elSc1tjM+keEFKU
         95/g==
X-Gm-Message-State: AOAM532FUMXkCnaxErPaHb5MbPAkdJiBDgxJdLQHFQDqoUSjue5fMNpQ
        6dAih7p1wBi3i28dTQzqwdPA3+7++tyO1D/hmtJzhyKBJp8=
X-Google-Smtp-Source: ABdhPJwG8gvaeByAfmCknQ+JOeZFFErJghGcqKQZelA4fXhW8i8pDtQ0vcLdUzyFhy5uLkfLylRWJ3JamfZJuHH9O/U=
X-Received: by 2002:a05:6e02:216a:b0:2d1:71a0:c2b8 with SMTP id
 s10-20020a056e02216a00b002d171a0c2b8mr991166ilv.6.1654108986000; Wed, 01 Jun
 2022 11:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220531224951.GC22722@merlins.org> <CAEzrpqcui3A42ogkas9pQfMqX0qE+MApPuiUw12uwpqhNq2RHg@mail.gmail.com>
 <20220601002552.GD22722@merlins.org> <CAEzrpqfkrD4aYA3vMToi+vfYeoyj=h4JAx+xnGQj836FP+pbjg@mail.gmail.com>
 <20220601012919.GE22722@merlins.org> <CAEzrpqc_sCu18+tfP9E1Z3+kj70ss7nH-YTnEu0Rw_QQxPWTUQ@mail.gmail.com>
 <20220601031536.GD1745079@merlins.org> <CAEzrpqfw85GnLUq8=vywej1Gb6vjcgKUYucLw9DgoSaWEbyZbg@mail.gmail.com>
 <20220601163924.GE1745079@merlins.org> <CAEzrpqd7=9JxgjC0pqikEo5o7RTsP9M-qLLcCps0Vx1RxRak-g@mail.gmail.com>
 <20220601180824.GF22722@merlins.org>
In-Reply-To: <20220601180824.GF22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 1 Jun 2022 14:42:55 -0400
Message-ID: <CAEzrpqc1cFHwb8fczUatznbwzDFi87j-kuXMMcUf2rmKWzu5Lw@mail.gmail.com>
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

On Wed, Jun 1, 2022 at 2:08 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 01, 2022 at 02:00:43PM -0400, Josef Bacik wrote:
> > Ok perfect, now try btrfs rescue recover-chunks <device>, thanks,
>
> (gdb) run rescue recover-chunks /dev/mapper/dshelf1
> Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue recover-chunks /dev/mapper/dshelf1
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> FS_INFO IS 0x55555564fbc0
> Invalid mapping for 15645202989056-15645203005440, got 15664345513984-15665419255808
> Couldn't map the block 15645202989056
> Couldn't map the block 15645202989056
> bad tree block 15645202989056, bytenr mismatch, want=15645202989056, have=0
> Couldn't read tree root
> FS_INFO AFTER IS 0x55555564fbc0
> Walking all our trees and pinning down the currently accessible blocks

Ok you're ready to go.  Thanks,

Josef
