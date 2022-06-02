Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16FE53B17D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 04:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiFBCD7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 22:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiFBCDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 22:03:53 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB4611142
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 19:03:41 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y17so2533613ilj.11
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 19:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVv6Xz2EhhlsHeAddbdzj0zcS2VDw0h7bC3hZC3f1kY=;
        b=gLPyIlrTf5Y2vKXZfzDW5biibLJTCmYssHHNNiOTZv/htgItPLfBAJZ/EBeffT02Ng
         t+mZwRAos1sgdjBqf4RhVDpMJX6CDa8kZBTu2pSQl6VJ6Z0VZ+AeaN9aeU+yF1UdeYE/
         rr5E4qVCLMIFDnLPboRzFnqKhw7J4gGgmQGAhzx1Jju+0XxYWhjB/5jj8FE155q1h/XC
         IVf53rPbn6NvrNtABSAjEnTgjal7qm1mYqPyhb53XxNgoaBZmSXTzb7H1AD7fDysqrUv
         eO6kpNTcYZY+oL61hKWtJe0k4CqA5Xa49Kv6diGm57ydwidkrDpo1HsHkmHYKSwa65Xx
         AAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVv6Xz2EhhlsHeAddbdzj0zcS2VDw0h7bC3hZC3f1kY=;
        b=DkKgUuI9SFRJw0OZa7WF17nTcaw6CDltrhXD11uJ718vhfxTeP6dN6oilyLTucIDau
         peTYHQ5YsugYCrypmd54tRzWIxrKjoaDeEI5wytZnlFWevMI2NQm3ilFJkduWgRiHolN
         jOzR2LzEHsrF6LYeHMc8xibIe4qW9JMzBgMU3Oje74gWwolYWI5s9/Cm3sxhO/Q1Jklh
         WvCoQwG4QgdiQVmpF0X8m1fR8Nar6GL8OFQV3g9Qqtv2f8uXDhlDEd/Sir4jTA5wfG59
         jCX2RlSVznFe9txFtcHOBOBCpdgE29xzTt9gRWKRFU16t38ex2HnclfPJo/XOs6mLpJm
         MdKQ==
X-Gm-Message-State: AOAM533hL4fcVj7FlXaY1bM0SlYhmPnrZuxN2k0LC8c8xtzXHOVkMHmr
        Nk+5IKiqjhKL4/ZuVdcNqh6ok31NhPl29zm4IOfT406YGDc=
X-Google-Smtp-Source: ABdhPJyCFFwNLXqW+UG4mCDyhtZtEWBkjjdLd2MNU1oa5O/AaybVeds0ZHvMGvRH8l8WGKlbJ1w91icXUfkBlASe8Jc=
X-Received: by 2002:a92:d1c6:0:b0:2d3:96da:426e with SMTP id
 u6-20020a92d1c6000000b002d396da426emr1909549ilg.152.1654135420654; Wed, 01
 Jun 2022 19:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220601214054.GH22722@merlins.org> <CAEzrpqduFy+7LkgWyyEnvYLgdJU6zDEWv25JM-niOg9tjmZ3Nw@mail.gmail.com>
 <20220601223639.GI22722@merlins.org> <CAEzrpqdfz5FMFDiBbb1mrUTXqxNvJ2RkuqJCdE2VQ6op01k61g@mail.gmail.com>
 <20220601225643.GJ22722@merlins.org> <CAEzrpqe7Fm8d62GnRs5EZeggkbXdsF2JCxkSOWnQAU+pzFtG9g@mail.gmail.com>
 <20220601231008.GK22722@merlins.org> <CAEzrpqen1AXAYBq0M0LVzB8AVXMhAD_ve1Yj_+e=kPyCfdUiow@mail.gmail.com>
 <20220602000637.GL22722@merlins.org> <CAEzrpqc_Z=aqbfNHL_r=8X1=-Kvdqrmdzrd04M-n=79s7Mi26A@mail.gmail.com>
 <20220602015526.GM22722@merlins.org>
In-Reply-To: <20220602015526.GM22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 1 Jun 2022 22:03:29 -0400
Message-ID: <CAEzrpqfMD1+c-datNzDWppr62NBz7vDHybeXqg55DVVDAiqAdQ@mail.gmail.com>
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

On Wed, Jun 1, 2022 at 9:55 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 01, 2022 at 09:23:30PM -0400, Josef Bacik wrote:
> > Ah ok I'm not confused anymore, try that now.  Thanks,
>
> Better:
>

Ah right, we don't actually use the normal free space cache.  Fixed
that up, thanks,

Josef
