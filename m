Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7134F20C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 04:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiDEBcR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 21:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiDEBcQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 21:32:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D87025D5F2
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 17:43:53 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r2so13366481iod.9
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 17:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcdReNhFBTDy4d30lJNzeH+YlaRrGwcHQ9VD9n08V5o=;
        b=f1RQI84az4qFjLjSAFRLSVnh04x+pPQa79TWtwOcasfF5hOfK51gP9p8qLFiKfjl2l
         Zl4BCpOo+rPY1rFbEvLwfSr+AnktHdcfWBQDx/WMwA9KNnbvM9vunF0ievcyyhukXlGT
         UpHKENMaED4uX9AcK7T2tjFGUwd24hRVnlypRtefXkhxo0XqO8g/EWNoBK7xPrb1YNyG
         kTlpeV6kGJHqbz/vWCOQ7aZzrkJ7q832zS8WaxUj01aAu4KWNVETCa8L7eNh7vf0euva
         cDQuSaBpSOcTI9NDsMY/3XQpyRHskcxD3H3LZGl1QiMz64KnpTfPVnppXO/TQJ3lmQ/c
         RsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcdReNhFBTDy4d30lJNzeH+YlaRrGwcHQ9VD9n08V5o=;
        b=IYwwgCCvTdkWhsNzutIDK0Dqx0YQtrmzy1NwkDUEzIwz7KGpoZ+lGrZ32sQetnwOy5
         bMXg6ZC+QY6hNM318PN1hmj56sd7MONpC3xzJcnWoY3UQdnjXBqScWdPkfhUNFqqWRZE
         2A6PN+pgzZkIDsqvuZQQPOOShPXx+I35yRTSXwCJ506aq9fgdvO+pJzb1ISC9gIIk7zR
         049eHybZbsXx/YA943qNqMMDahRphiWL8DYXH5fzErTNE6I33cbSV+DKeRH7Cys2ILo6
         LdyTICnuB3XguBCwI7lgkZOY5AoDZJMhG5JgFPkTKt1j3UUd7pPHI8/PAShRxr93muZl
         JmYA==
X-Gm-Message-State: AOAM530LMzYRePJ0YvNFNCVVnOR5xyufwS3kyUlXL78dx8SU0N2G81IK
        BSpYiF3OLp5gafnW3tpWNpHSpV/51wYrZCLJFU6JhS+7uYM=
X-Google-Smtp-Source: ABdhPJzWFnPohtxk+geVAE4xB8jildqwEts61FpH9t1IGGhyFolx/8M13PcFWH1+7FtdrP9Bzn7U4IO+fUYq5Kh0a6o=
X-Received: by 2002:a05:6602:2bc4:b0:645:eb96:6495 with SMTP id
 s4-20020a0566022bc400b00645eb966495mr485137iov.166.1649119165257; Mon, 04 Apr
 2022 17:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220404224503.GA11442@merlins.org> <CAEzrpqfJ7-GQHZicxpn2x3D=aOY=tnKkt9XiPJ8O+_VZAgK7wg@mail.gmail.com>
 <20220404231838.GA1314726@merlins.org> <CAEzrpqd2kVY=mpttaP3+YJJ_1t1Z3crfXAdF-69pMU10aVe5OA@mail.gmail.com>
 <20220404234213.GA5566@merlins.org> <CAEzrpqft7WzRB+6+=_tTXYU4geBB_38navF1opr6cd9PXiWUGg@mail.gmail.com>
 <20220405001325.GB5566@merlins.org> <CAEzrpqcb2jHehpnrjxtNJ4KWW3M5pvJThUNGFZw78=MBNdTG5g@mail.gmail.com>
 <20220405001808.GC5566@merlins.org> <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
 <20220405002826.GD5566@merlins.org>
In-Reply-To: <20220405002826.GD5566@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 20:39:14 -0400
Message-ID: <CAEzrpqeHa7tG+S_9Owu5XYa0hwBKJPVN2ttr_E_1Q4UV8u0Nmg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 4, 2022 at 8:28 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 08:24:55PM -0400, Josef Bacik wrote:
> > > Binary identical after rebuild.
> >
> > Sigh time for printf sanity checks, thanks,
>

I'm dumb, try again please, thanks,

Josef
