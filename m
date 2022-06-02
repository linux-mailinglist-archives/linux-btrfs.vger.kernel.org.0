Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1636C53BF28
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 21:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbiFBTxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 15:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbiFBTxM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 15:53:12 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50025FDD
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 12:53:11 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id p1so4086935ilj.9
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8TLYJJNBK7abwjKxmIxtmEtdv8Xw3/fLsWVb2ojXlA=;
        b=oyeOxQEcVRK6f4tjSXFrwbgO//WzBU92zvnA/VAf7yBhM5UXvK93U8y2iLWE6eKYcJ
         t8E/dHgYfwnpAEXSJGvPrVDCQVnceyMy6WW3Q8F1qClm2Pxxqu8bQDwriO6JFdVsJO4J
         qt0tZhMwrYTYLjgk5OXVDuOFkqaFSvlX6yByLA8ynZbraZhQY/eeuUovlCd4x01LDINI
         MU1ntMI4t48gyuwMydo078rcJM38OLp9pfceCV007eSYW5Hya/xUXST2c3GZFasVF1Q2
         dQEMk9X+rUxryekFDpCx0tVm3zYPmp/jYkAT212nHt60X35lbVzOeZkjb5ngMKDzx87y
         ZAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8TLYJJNBK7abwjKxmIxtmEtdv8Xw3/fLsWVb2ojXlA=;
        b=Zphce2GYwnr/SHsuEHIxdhDFhMGhTwMaVH0IjobIxfvQeYopZyp/HrAIMCP3SUMpC5
         sVPWx+vGe0LQYMO+Brv0wKeXp9NIivwkdV/BOL+WfjsmqSF1QboCIXOjKQKLqaTq/VM1
         hxGq1fhk/Rhg64PGtlsM8LylyG4/xeqwKdcevXwpqh2nq7HYOhTgS4oLWpI5e41NNobf
         5wQyf3LxgK11ksc6V1HMGnGsvbUgs9bF4ExTzmVXbdcjq4cCJkP0KQ0oX3+ALnrganO3
         acX/Y2EHEGvnHpv2HQtcs+x1mRsFVbR7yWBPpmlIYNpm3I5W2HOm7Red3002fru0CCox
         K+Fg==
X-Gm-Message-State: AOAM532kf9cjqajztwOiHrDNMKWfVbt+NQWD1rWHqs493vPQbP0nmXay
        hjfrQw8DgYgCykzQLTjAwy0JVrxKBDf471bX6QvwlU6Faac=
X-Google-Smtp-Source: ABdhPJxCA6nLyiJt9ubuNKE+eLBMo5QUWt5GhPcrcBmieRhLhQ/m/tLAkheJB+uYL8LclCD3Y3tWgpz2jzToAyjFyzU=
X-Received: by 2002:a05:6e02:216a:b0:2d1:71a0:c2b8 with SMTP id
 s10-20020a056e02216a00b002d171a0c2b8mr4253626ilv.6.1654199591192; Thu, 02 Jun
 2022 12:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220602015526.GM22722@merlins.org> <CAEzrpqfMD1+c-datNzDWppr62NBz7vDHybeXqg55DVVDAiqAdQ@mail.gmail.com>
 <20220602021617.GP22722@merlins.org> <CAEzrpqfKbEvZh1td=UW6HGJ1x3htSVL1jo49KzcJPu+OSYt4jQ@mail.gmail.com>
 <20220602142112.GQ22722@merlins.org> <CAEzrpqdJHDte6jc7-ykD-wnuFe8_xB-Y4e97C-o5B-G-1Nnksw@mail.gmail.com>
 <20220602143606.GR22722@merlins.org> <CAEzrpqdADZbOcz0iSoiYvOX=UVsbWybiRdcdtc4GJ-tmpJqdRg@mail.gmail.com>
 <20220602190848.GS22722@merlins.org> <CAEzrpqdKjjPW5Bvqkt2=U1_jmiBMGui775BC=Mdx6Ei5FWL1AQ@mail.gmail.com>
 <20220602195134.GT22722@merlins.org>
In-Reply-To: <20220602195134.GT22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 2 Jun 2022 15:53:00 -0400
Message-ID: <CAEzrpqciXfV0NZMTJoMjX_E_TzQ-j5sEpsACnEhnJdAXzbVOEg@mail.gmail.com>
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

On Thu, Jun 2, 2022 at 3:51 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Jun 02, 2022 at 03:35:46PM -0400, Josef Bacik wrote:
> > On Thu, Jun 2, 2022 at 3:08 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Thu, Jun 02, 2022 at 02:43:03PM -0400, Josef Bacik wrote:
> > > > Now we run
> > > >
> > > > btrfs rescue tree-recover <device>
> > >
> > > It got pretty far, and then
> > > Invalid mapping for 364837339136-364837355520, got 11106814787584-11107888529408
> > > Couldn't map the block 364837339136
> > > Couldn't map the block 364837339136
> > > deleting slot 0 in block 11160501878784
> > > Invalid mapping for 364837306368-364837322752, got 11106814787584-11107888529408
> > > Couldn't map the block 364837306368
> > > Couldn't map the block 364837306368
> > > deleting slot 0 in block 11160501878784
> > > Invalid mapping for 364746457088-364746473472, got 11106814787584-11107888529408
> > > Couldn't map the block 364746457088
> > > Couldn't map the block 364746457088
> > > deleting slot 0 in block 11160501878784
> >
> > Was it printing a lot of these messages?  I was sort of hoping we
>
> Yes
>
> > found all the chunks so it didn't feel the need to delete a bunch of
> > stuff.  Can you re-run
> >
> > btrfs rescue recover-chunks <device>
> >
> > and make sure it doesn't find anything new?  Maybe there were some
> > system chunks that it found that has the other chunks in it.  Thanks,
>
> output is very long.  I was able to paste a good part in
> https://justpaste.it/5cy5s
>

Ok it seems like we're still missing some chunks, hopefully re-running
btrfs rescue recover-chunks <device> will find the remaining, there
must have been system chunks that got discovered.  Thanks,

Josef
