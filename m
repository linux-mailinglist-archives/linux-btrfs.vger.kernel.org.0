Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48C85178C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 23:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386698AbiEBVHX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 17:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiEBVHW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 17:07:22 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76D0BC84
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 14:03:52 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id g21so17175219iom.13
        for <linux-btrfs@vger.kernel.org>; Mon, 02 May 2022 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IrY+sw4yLdPBCms62vQyQS0uZ27eBpL/qfbN2CFKEKI=;
        b=FzdAsyyLszc+XQu9Fuotu0mJwFkRAYpv0m95TlwWqxE7D1NlSapz+/4svpS2CDvqbF
         DwcIlEqD1Tp/i1Gw+yJagJR2uZGgho066ZwSl52L9IOhCQ0YNnn41atSTVmLrJZQG+mK
         phoOxR/YEFDx5jcmvE3dn7JQ4zKXknW6ziCHDUUUZRK6jzkjuIgVhwJ3zWq7HN6uE7dt
         KcuG6GYU7yRt6z9O2KLZDw8XUXXNHJubNLPwBQ6eUMSXHG9hsz+JpspFZ9MkvJX+1aMa
         rpKg3FwDKyPkNHYLkq2/PIdjjE6+9sTaaaoT58+3ECbmSZ9cwjPr+l0VGffoIhtVa0od
         EMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IrY+sw4yLdPBCms62vQyQS0uZ27eBpL/qfbN2CFKEKI=;
        b=fqtDtUTYjdStN8dKjVMkdZppQBcl5fkOfISxSxXMzZrw7rVCzv56d+7bRcOklbhCSd
         /TfM1dMPshF7MkrOR/T/I6DFTNv5qEucLoiiYtbSrtMTN89+IZuIssLLjTXsqrr7XwZK
         y6cplZAiJvZfByQDW/ZcXiEBZZWecsiE6RpgGU5D2sGpf3wcUZhLfJE+gZW6qg4dXBp1
         9mUGpJCzdbcgh4FhYHGmkn9wMUjSJt0PyO+asLqMOsDQIEUYUOzBaQR80259RLYI2AYi
         TlNQI7dW5fqUb/+YAcAwmQthxp5by4PUEPBnHWYh+6TPAwptUqYWBYB/1nwHgEOrX3vO
         dG2g==
X-Gm-Message-State: AOAM530wNxGOca7fA1jv3DshyKFEmPd6QM0+44SQ/nTyUeRGAI0gR7YX
        vJHs0b8UopAdWBgqdtGdpJBEaQSqg21Ot37Qj+BzzLfj/Rg=
X-Google-Smtp-Source: ABdhPJyeq+mMFiu322YieY9CO/jqKnaR1OM6RYCu3Lt8oRWRlYaHyCLo2Lp7oFpbv8QfvUFub3Qh3yPgDIy744GkjV0=
X-Received: by 2002:a05:6638:2501:b0:32b:6083:ca39 with SMTP id
 v1-20020a056638250100b0032b6083ca39mr3496803jat.281.1651525431993; Mon, 02
 May 2022 14:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220430231115.GJ12542@merlins.org> <CAEzrpqe9Kh7k6n_ohyjgeMm4Pvy6tNCoKBXBPKhtcC5CrVfexw@mail.gmail.com>
 <20220501045456.GL12542@merlins.org> <CAEzrpqe-92ZV-YqL8v9z1TV4wnqbVUjroTMsvC86z6Vws3Rb6A@mail.gmail.com>
 <20220501152231.GM12542@merlins.org> <CAEzrpqeiWrW6NbWLmUiWwE96sVNb+H0bEXmaij1K-HJQ38vL7w@mail.gmail.com>
 <20220502012528.GA29107@merlins.org> <CAEzrpqdWyOivUQ3ZtE2DS-ME7=Fs_UJN=nzA_VhosS5o3bZ+Uw@mail.gmail.com>
 <20220502173459.GP12542@merlins.org> <CAEzrpqdK1oshgULiR8z-DhJ71vOfXJz3aZNTJRJ1xeu3Bmz9-A@mail.gmail.com>
 <20220502200848.GR12542@merlins.org>
In-Reply-To: <20220502200848.GR12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 2 May 2022 17:03:40 -0400
Message-ID: <CAEzrpqf2VMEzZxO3k74imXCgXKhG=Nm+=ph=qkNhfJ_G8KFb4g@mail.gmail.com>
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

On Mon, May 2, 2022 at 4:08 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 02, 2022 at 03:07:09PM -0400, Josef Bacik wrote:
> > > Sure thing:
> > > Recording extents for root 165299
> > > processed 16384 of 75792384 possible bytes
> > > Recording extents for root 18446744073709551607
> > > processed 16384 of 16384 possible bytes
> > > doing block accounting
> > > couldn't find a block group at bytenr 15847955365888 total left 1073217536
> > > ERROR: update block group failed 15847955365888 1073217536 ret -1
> > > FIX BLOCK ACCOUNTING FAILED -1
> > > ERROR: The commit failed???? -1
> > >
> > > doing close???
> > > ERROR: commit_root already set when starting transaction
> > > extent buffer leak: start 13576823767040 len 16384
> > > Init extent tree failed
> > >
> >
> > Wtf, that's definitely in the range of block groups that I've seen
> > printed.  I added some more stuff, hoping the tree search is just
> > broken.  Thanks,
>

Ok I've fixed it to yell about what file has this weird extent so you
can delete it and we can carry on.  Thanks,

Josef
