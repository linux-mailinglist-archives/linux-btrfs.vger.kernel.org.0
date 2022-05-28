Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E64536951
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 May 2022 02:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355225AbiE1ANx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 20:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiE1ANw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 20:13:52 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA57C119046
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 17:13:48 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id 2so4079223ilg.13
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 17:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9l6acg1hu6P5EL6SXzSmI3BdGQFt+LJAAwTA8QBhiQY=;
        b=8DXtRt2XWv2HW3iwshCd0iJFGU1523gUYNqirc3g0IqgD63D/yHR8yywpOPgqnxNSk
         CtLlfkWLZi20JQYj+PJnZlVsOa10sKQuc18W09BCSP4+X4Vs7UMAhVpE/da3McQuqOgE
         9pplkWgLeIHIljBkEBF0RXYmCqDwDmnltddKXOAqgpG9ZU8fvlzGB/ATlvAnarPeKKs6
         qAolJ9wxM89yvVP43y5R6HSf91iSS2pZWhqSxcz9Ec+MxC8KESdBbie3k7Wn+4LgZxoY
         w21v3A5GHkWJVhYG9Tx3lHMn2b8rZ5y/irRCvfcZRyQ7o90pYomn+MPqiIasNj6mfleP
         y/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9l6acg1hu6P5EL6SXzSmI3BdGQFt+LJAAwTA8QBhiQY=;
        b=ksFbLGDIrbQgDDaDjBLPF+hzPfOAcAX61yocLW+tJAtaDIrnCnKrMobG0bJHlWALdt
         UGkQ5gC9C++ZYojxEhdYb1+GjCjvaXPJO+Nz3pg/fajISJ7E3r0tK2505xXS+EkjmnJd
         D6xZSobM5BxBSUd0avGoixpa6bc7Uk15fcVHVpqymkqmZWXKgZE43Ybugol6mvVJIzbW
         Ba6OQDPj43LfaXhKPND80Fd2k5w+aM15gQ1x1RThUJ/J/WupgBLJEXvrTjGyboSgLowC
         IsheruLASYNo4ZzfZ5STThesna6WGTViTQi1IimGpZsWzV8f+qO/7Kjx82FWXZXEKB8p
         9ZNg==
X-Gm-Message-State: AOAM533l4Ce7NAmBtq+aJc3dhiCwhtH7VpatYdDIG+B2k9ocLve2OBnm
        r+e/GWfqWP0m5D/GOCF8ofhHCmdiRWM1Wn8dBk03DBqreb4=
X-Google-Smtp-Source: ABdhPJypgrbhYhb6MTVkcpBWGpYeeqfpkPHRCq/HibPaLhsMlHeSieMANANT2runD70yKoeEtTY0NRniYx35C97ktjA=
X-Received: by 2002:a92:c641:0:b0:2d3:1865:12f5 with SMTP id
 1-20020a92c641000000b002d3186512f5mr3596820ill.127.1653696828013; Fri, 27 May
 2022 17:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
 <20220526173119.GC1751747@merlins.org> <CAEzrpqemPU_=VTxGEQS2WtGiaGbHy+ssnj5MKyh=8JC36uyZ6Q@mail.gmail.com>
 <20220526181246.GA28329@merlins.org> <CAEzrpqfEmm0qGZkkdTgFYNjVvSn6SZwbdDUYLO2E3jV4DYELFQ@mail.gmail.com>
 <20220526191512.GE28329@merlins.org> <CAEzrpqetTskf-UtyfXHBajpJBci4vxdSaBXwDTm5cRs2QtNRkw@mail.gmail.com>
 <20220526213924.GB2414966@merlins.org> <20220527011622.GA24951@merlins.org>
 <CAEzrpqdbuQGwwuCfYyVdiDtGDsPb=3FWmKrTEA5Xukk1ex514g@mail.gmail.com> <20220527232604.GA22722@merlins.org>
In-Reply-To: <20220527232604.GA22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 27 May 2022 20:13:37 -0400
Message-ID: <CAEzrpqeJyupr02nUJkBBVCah46FN+znVczm-RtfBFauvJW9O6w@mail.gmail.com>
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

On Fri, May 27, 2022 at 7:26 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, May 27, 2022 at 02:35:05PM -0400, Josef Bacik wrote:
> > I'm augmenting my tree-recover tool to go and find any missing chunks
> > and add them in, which is what the chunk recover thing was supposed to
> > do.  This is going to take a bit, but should be the last piece.
>
> And by that you mean you're working on it and will tell me when it's
> ready to pull, or did you forget git push?
>

Still typing, just didn't want you to think I'd disappeared.  I'll let
you know when you can pull.  Thanks,

Josef
