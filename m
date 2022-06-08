Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC37543EAB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 23:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbiFHVd5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 17:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiFHVdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 17:33:54 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFDE35DFD
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 14:33:54 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b17so13225429ilh.6
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jun 2022 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXD8BWf1tYtQXGoxXGHcjx8mKRvC9nAnQOfBzkFWlGA=;
        b=GANcKllocnm8BeZh/t+wViOuM0Vor+D1bWPQA6OW1bwSWIKSJ5aRmMj7SyhU2h7gPo
         RvMex14lMLWRyNAZZ6iGj7ufdIZ6SbfToJFqlX2sxcfmUk0DE84g4KhLWYapx27kz5MO
         ou8dch4UoVx+L4GRdfjftebXTq3B13nECZRqjUcKJhyRuvmEjRXZvkTrXKks9QbDfwok
         CKhlG3cKx+ADFqB4jISLsybSndKfBsSfKh1mTWqrjyjXwxeib381MbJFPC5Ncu2D8N/A
         igrKyK0CZsMuMr04JwBoeez+Jiyyg1fTy6xMpNeOSstVkugqB+bKngwzttnZC9Iois0j
         ASnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXD8BWf1tYtQXGoxXGHcjx8mKRvC9nAnQOfBzkFWlGA=;
        b=u7CXPk8pF6WUCqLzOev4xepe6UnVH1rJ2DSIfIjbNyuPu5bi541SAxqFe9gtceApvs
         e7dzgO7nJIjmnvMbMKS7SVUCXmFMZAUijImLuUfggLdu9eyyjIdjtgqU3fisRH3ItrXf
         Rj/5yxeWUK1jTTKF1U2YrgqFbSocw0YFRNJpQANbCoxD5kg4/pZy8OhGlRbqSZSQ9QvM
         a+9wEM1YmsIXaBQuI119o4J8MR2OwC4gWvrzyMUGKkj+3tYEo5aYxY7tBPilr2I81na7
         y/w2b5gq54GiBMe8KP7SzTTZorZc9s5ROqHBrdVCk7p1tPTu1YMbptMelsBmGMmqp9N4
         8vRw==
X-Gm-Message-State: AOAM530lCno+9Nz63Drtx1HAnyApI2XdsOqz/D3rgwFlbLAZm/AsUyaT
        ldhlDjl6vxPZszpP5S4KrKIMRxiv3Ci5CD7kfF7h2QkUq5E=
X-Google-Smtp-Source: ABdhPJzGe0Q9edMrGa0Oj1PrmJoowHzd6fQEZYve5dEivAXawEOS8MsmI368O9IB8ihFqq8a4DUSq4Bty1Mn/6boIXM=
X-Received: by 2002:a05:6e02:156e:b0:2d1:c265:964f with SMTP id
 k14-20020a056e02156e00b002d1c265964fmr21604269ilu.153.1654724033341; Wed, 08
 Jun 2022 14:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220607212523.GZ22722@merlins.org> <CAEzrpqex0PRGZA3_gaoUhpPb-7cpi-gi_mo1S3F=0xxKNptpEA@mail.gmail.com>
 <20220607233734.GA22722@merlins.org> <CAEzrpqcVO99HbrhmtABUENRCm4HEsyg3+T3oK33DZFuXamwqgA@mail.gmail.com>
 <20220608000700.GB22722@merlins.org> <CAEzrpqe79F=-0T7Q3dqb62J6+kcisOjnWP+aLkkY0z+EJY-m9Q@mail.gmail.com>
 <20220608004241.GC22722@merlins.org> <CAEzrpqdq8zTBQaw_VneL4rfZn0JseUiwvtfwXQx0jq=DYBCFFw@mail.gmail.com>
 <20220608021245.GD22722@merlins.org> <CAEzrpqeFFiHjbQ+VQ7zy9ZbV1MgaMT-V4ovJhB9iOan8Ao-cXg@mail.gmail.com>
 <20220608213030.GG22722@merlins.org>
In-Reply-To: <20220608213030.GG22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 8 Jun 2022 17:33:42 -0400
Message-ID: <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
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

On Wed, Jun 8, 2022 at 5:30 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 08, 2022 at 04:57:05PM -0400, Josef Bacik wrote:
>
> > Oops I think this is a system chunk, I've added some code to do the
> > right thing, can you give this a whirl and see if it fixes it?
> > Thanks,
>
> Better :)
>
> processed 196608 of 63193088 possible bytes, 0%
> searching 18446744073709551607 for bad extents
> processed 16384 of 16384 possible bytes, 100%
> Recording extents for root 3
> processed 180224 of 0 possible bytes, 0%
> Recording extents for root 1
> processed 999424 of 0 possible bytes, 0%
> doing roots
> Recording extents for root 4
> processed 163840 of 1064960 possible bytes, 15%
> Recording extents for root 5
> processed 65536 of 10960896 possible bytes, 0%
> Recording extents for root 7
> processed 16384 of 16570974208 possible bytes, 0%
> Recording extents for root 9
> processed 16384 of 16384 possible bytes, 100%
> Recording extents for root 161197
> processed 131072 of 108986368 possible bytes, 0%
> Recording extents for root 161199
> processed 196608 of 49479680 possible bytes, 0%
> Recording extents for root 161200
> processed 180224 of 254214144 possible bytes, 0%
> Recording extents for root 161889
> processed 196608 of 49446912 possible bytes, 0%
> Recording extents for root 162628
> processed 49152 of 49463296 possible bytes, 0%
> Recording extents for root 162632
> processed 114688 of 94633984 possible bytes, 0%
> Recording extents for root 163298
> processed 49152 of 49463296 possible bytes, 0%
> Recording extents for root 163302
> processed 98304 of 94633984 possible bytes, 0%
> Recording extents for root 163303
> processed 131072 of 76333056 possible bytes, 0%
> Recording extents for root 163316
> processed 98304 of 108544000 possible bytes, 0%
> Recording extents for root 163920
> processed 16384 of 108691456 possible bytes, 0%
> Recording extents for root 164620
> processed 49152 of 49463296 possible bytes, 0%
> Recording extents for root 164623
> processed 311296 of 63193088 possible bytes, 0%
> Recording extents for root 164624
> processed 933888 of 108822528 possible bytes, 0%
> Recording extents for root 164629
> processed 622592 of 108838912 possible bytes, 0%
> Recording extents for root 164631
> processed 16384 of 49430528 possible bytes, 0%
> Recording extents for root 164633
> processed 16384 of 75694080 possible bytes, 0%
> Recording extents for root 164823
> processed 131072 of 63193088 possible bytes, 0%
> Recording extents for root 18446744073709551607
> processed 16384 of 16384 possible bytes, 100%
> doing block accounting
> doing close???
> Init extent tree finished, you can run check now
> [Inferior 1 (process 12822) exited normally]
>
>
> Do I run check --repair now?

Just check, no --repair.  I want to make sure the only thing that is
missing is the corresponding device extents for the chunks we
recovered.  I'm going to start writing the code to do that now, but if
there's any errors other than missing device extents then we need to
figure out what those problems are and what to do about them.  Thanks,

Josef
