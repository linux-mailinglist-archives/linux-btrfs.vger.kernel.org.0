Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7314153B188
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 04:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiFBBXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 21:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiFBBXn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 21:23:43 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CFC29564C
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 18:23:41 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y8so3482540iof.10
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 18:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eS9oSsvlb7H1c4Sr7xNPAHmnIY7oYXgsELY7P/icHqM=;
        b=lLZpdflub546Lb/OsS8idFwbi5pt1EEiQDsGMbOT3DX3F5TwdS/4h3XLjwSb0m/PqS
         uFQNsrrcpx184v4QP7zs0WUv6iYXoP2RNuS1/cKDLHCyx14rMbGTS031BtI9guC67MqB
         Ar1qWwymEVYxj1BqY+YdZALWgT6b1bv9UtXFfuFtlr5yu61t30jOrF3LEb8ibmWFB6do
         dQ0vVmDDBJi9LQBhccollh8xaWhTL9me+wWII/wPT6sQEGv3OAGD6yytKPmS6To4lyio
         9Vt1RZE/GNKtFldD0Fy7FXij3Do+8a4arZbAd24C9r62qvyk45s70Ha6iKXZjFRhPayD
         mDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eS9oSsvlb7H1c4Sr7xNPAHmnIY7oYXgsELY7P/icHqM=;
        b=a7KUoDrM8rRH/UvxPuFLi72cgkt7oFmX4r14VOkAJtRDU5GUOEyCPBwBHZtjatJcQK
         9ZQkq/K40nMcoN3VoUfffvoqLUgXP5ZxZYERVvuNYfj3GUHm0rOVGgc95NDlqITFfx55
         /y5EJuNgNnAsQi1JzUF/hxLc8vtFPxXKkfBBxE8jruSEfk+dMbXdE5WuAqbmqoaD/fcO
         gKxOxRccICismNYZieTnBXBRd+BroqncpVoGfizgha1WylbvBHLC58R40AEyJdp9o09o
         hVQCCoalWbRHwASnlXqrjN05CGDFt2/FAnUAl8NAyAQO6MeqUZi8b1nb8BmaDTHVJ/mW
         jawQ==
X-Gm-Message-State: AOAM530mrKBnbVMdtiEYQs8ag+UIpcv6Gqpq+l7Zq24bM9taup9I9oH3
        DJqnloQHCcMJWZkABiiZnbAqtD9Yba+aA47t/8Vg6LRdvB4=
X-Google-Smtp-Source: ABdhPJy12Yl/OxYGrQAcIRT+1/XNLB6UaAXyEqWgqQOkE4i014Vt1jtptpamvFKnxInE0+ml8LG9afE+UBZJtijloE0=
X-Received: by 2002:a05:6602:80a:b0:665:7139:4c4b with SMTP id
 z10-20020a056602080a00b0066571394c4bmr1440658iow.134.1654133021115; Wed, 01
 Jun 2022 18:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqcY-F4WOiaJcDfHykok0LB=JEX1DnZj53+KvM7a6j+daQ@mail.gmail.com>
 <CAEzrpqeTEuRzP_Nj1qoSerCObJLA4fJYDfR1u3XMatuG=RZf-g@mail.gmail.com>
 <20220601214054.GH22722@merlins.org> <CAEzrpqduFy+7LkgWyyEnvYLgdJU6zDEWv25JM-niOg9tjmZ3Nw@mail.gmail.com>
 <20220601223639.GI22722@merlins.org> <CAEzrpqdfz5FMFDiBbb1mrUTXqxNvJ2RkuqJCdE2VQ6op01k61g@mail.gmail.com>
 <20220601225643.GJ22722@merlins.org> <CAEzrpqe7Fm8d62GnRs5EZeggkbXdsF2JCxkSOWnQAU+pzFtG9g@mail.gmail.com>
 <20220601231008.GK22722@merlins.org> <CAEzrpqen1AXAYBq0M0LVzB8AVXMhAD_ve1Yj_+e=kPyCfdUiow@mail.gmail.com>
 <20220602000637.GL22722@merlins.org>
In-Reply-To: <20220602000637.GL22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 1 Jun 2022 21:23:30 -0400
Message-ID: <CAEzrpqc_Z=aqbfNHL_r=8X1=-Kvdqrmdzrd04M-n=79s7Mi26A@mail.gmail.com>
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

On Wed, Jun 1, 2022 at 8:06 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 01, 2022 at 08:04:03PM -0400, Josef Bacik wrote:
> > > Found missing chunk 15772793438208-15773867180032 type 0
> > > Found missing chunk 15773867180032-15774940921856 type 0
> > > Found missing chunk 15774940921856-15776014663680 type 0
> > > Found missing chunk 15776014663680-15777088405504 type 0
> > > Found missing chunk 15777088405504-15778162147328 type 0
> >
> > This segfault makes no sense, we check to make sure any of this stuff
> > is NULL.  I've added some debugging, hopefully that'll shed some
> > light.  Thanks,
>
> Found missing chunk 15486104371200-15487178113024 type 0
> Found missing chunk 15487178113024-15488251854848 type 0
> Found missing chunk 15488251854848-15489325596672 type 0
> Found missing chunk 15671861706752-15672935448576 type 0
> Found missing chunk 15672935448576-15674009190400 type 0
> Found missing chunk 15772793438208-15773867180032 type 0
> Found missing chunk 15773867180032-15774940921856 type 0
> Found missing chunk 15774940921856-15776014663680 type 0
> Found missing chunk 15776014663680-15777088405504 type 0
> Found missing chunk 15777088405504-15778162147328 type 0
> adding bg for 20971520 8388608
>

Ah ok I'm not confused anymore, try that now.  Thanks,

Josef
