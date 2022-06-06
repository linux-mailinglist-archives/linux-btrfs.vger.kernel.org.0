Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2057C53DF41
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 03:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348836AbiFFBLl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jun 2022 21:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241008AbiFFBLk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jun 2022 21:11:40 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6884E3A7
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jun 2022 18:11:39 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y16so11030806ili.13
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jun 2022 18:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMfZymVVa+5dsW6+54YSuGF3KJWSAdcHfcSeDvWfowU=;
        b=4iznP/QZTDMDk5ez33Qe71fZRqzImNZrsP5fIujpVgi+oLqIcpzuGC/A89joK0JkGO
         JNOLYCKhZhoU3etf9lQaQlGtLJ2tOkDWPzilfr0oGR434Uv2GAZtjOfTf/hBxapd0ecU
         YbgoWxSglVfN1zJB94q6DMoYOHvoIFJ1jQ3DuOAWP+nVKAMnzvhbzVJXr7+LH4o3+SAr
         IjkddIyC62jKzfV1/z3BLxR09Q6FnJG45ibHMu2FNe0vGovKCj8jo4rBNC5cbLxgUc9O
         9MRziGF4j7btYDzJkkrDeRC/p+EYaGSpn+CykFCMRA0wLk2/BOsNlbKmU/D7C0cRPnr3
         AV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMfZymVVa+5dsW6+54YSuGF3KJWSAdcHfcSeDvWfowU=;
        b=Ji1I16KlBURXtburboK834hUsUfs4qq2Pi6SleILYoXF9O/VUCh0fjxMm1hs4KmrhI
         1+B7M2I2jNuUnM018g1KnK4rUKNTRMrMzwdnuclbsNFUi340SxDLpYUNZg9mrl4Lv8gs
         AK6YI+8AYEnl6xM80XiXnD8C6CyrS2TXfXjvCDfdjAVDYx/FfTocb8GsLLcR5bjrmVTY
         lkKt585Hg4TAAxA57obTn269oZCgtjZrLKMSWfNORpL7VJgCZzRrGopEMOLShDZPrrBS
         g+NEaORWFt8XM+cuLTMmJf+tsO6kn+W4WKxPfPYmzItdevK4O9hoSGYLLl9jZBREbcWA
         EnyQ==
X-Gm-Message-State: AOAM530eRB6pYTBQ8A/mnzlY9iJDu35pSUY5PUsXaVYByz4ddPPQMBi+
        00kesDZJlqSDaOT5gENU98DtrdaV3C5vRdxd9yni4F7sXFA=
X-Google-Smtp-Source: ABdhPJwh08vXeNptxk8DPjeJtSWo1jTCohOIVJQqB++9iF8NpzETezUYIZkc57t0wnlPpaKrI/ND0tLSme+X89bJn2Q=
X-Received: by 2002:a92:d1c6:0:b0:2d3:96da:426e with SMTP id
 u6-20020a92d1c6000000b002d396da426emr12714896ilg.152.1654477898942; Sun, 05
 Jun 2022 18:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220604134823.GB22722@merlins.org> <CAEzrpqetLawF0wdYkz02nGQct63Yae_-ALF=ZUw3hVe=AH4wKg@mail.gmail.com>
 <20220605001349.GJ1745079@merlins.org> <CAEzrpqfjDL=GtAn9cHQ2cOPMVZeNnuaQBLq6K-X-tGaipaAouA@mail.gmail.com>
 <20220605201112.GN1745079@merlins.org> <CAEzrpqeW_-BJGwJLL+Rj_Eb7ht-A_5o-Lg+Y-MYWhgn0BqKHEQ@mail.gmail.com>
 <20220605212637.GO1745079@merlins.org> <CAEzrpqdFEsTNPAqqrALcMLpeMUbc+H4WJZ9buSZMKSQ-YS1PVA@mail.gmail.com>
 <20220605215036.GE22722@merlins.org> <CAEzrpqeYB0gC+pXr4UxL9TVipWDE2MFsg1tyrd7Nk+wEvV-zQQ@mail.gmail.com>
 <20220606000548.GF22722@merlins.org>
In-Reply-To: <20220606000548.GF22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 5 Jun 2022 21:11:28 -0400
Message-ID: <CAEzrpqdL6rK+-OUhW2AR3jXhK8TTsTM77A1CUkh=-+Y7Q1av9Q@mail.gmail.com>
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

On Sun, Jun 5, 2022 at 8:05 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Jun 05, 2022 at 07:03:31PM -0400, Josef Bacik wrote:
> > I wonder if our delete thing is corrupting stuff.  Can you re-run
> > tree-recover, and then once that's done run init-extent-tree?  I put
> > some stuff to check block all the time to see if we're introducing the
> > problem.  Thanks,
>
>
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# gdb./btrfs rescue tree-recover /dev/mapper/dshelf1

Ok more targeted debugging to figure out where the problem is coming
from specifically, but hooray I was right.  Thanks,

Josef
