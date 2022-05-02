Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD9651771B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 21:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiEBTKx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 15:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiEBTKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 15:10:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94445DEA0
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 12:07:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gh6so29569741ejb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 02 May 2022 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9Ei/W4L/Utc/pLa4TetORgT3Op8D3W3XPL4mJA+Tpo=;
        b=1iqfmSqyeW0/bbgEG8Gd8MxkS8ljUn5v6rVv5q7sULvgcSzX4VaYdyQ0aPy7J9O/2H
         XSmxT/TgIwonDBveFGZwHx9FofwWltOpCLX0kOmTRAfG9qAP3IDYEno2nYbcSDkke78V
         CsjQpPmSEAGlhxBGUS9Eofs8NUfGfsC1SrrXie+89XDkabRSqoX2ciUsKpHEOh1KskI8
         9jsu6tRaPFUT5W7LBFnkiu6YnTDOmSg5BWP6kEYshn7DxbcZ4ljMbZPyoJL2RqlNGoTs
         Pl1Wmbj7tHoXa+H53ui2qo7JdvLbCT9OBQVtWyrmRMSKPEqP99IHF01DYdPfoAV3zMCb
         CutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9Ei/W4L/Utc/pLa4TetORgT3Op8D3W3XPL4mJA+Tpo=;
        b=EvZm2hnYui61ecgwFVhaMSOMf5AuUMAKH/ha9NI9WOQHb2LeqbWaXeVJDnJSmRi4vz
         O4M3CEU8kjBgT6MCLaEbtfNyNZgkxonsgTiqrGtcNO+rsZEWcZBbnyQ83L27/RDsaIoV
         IRFYNhODRV1v3bPHqYW/Kyg4VNlr4PXbZS3GbRB5K+LmVdnjPqFDnWeMTObkqsRXF4ZD
         VPgWF6uoqo+Pp4wu8ooTW2qjzcJAg5zctr741iM08bDnPOHED4N66nOgMwFocgObdmGV
         wPg33wqknENJD592rPgtwGykoAUprxcETG9K8kSsD1xsexdDjDy+9y1JVI0H1HuHkUWr
         wflQ==
X-Gm-Message-State: AOAM532B/GAOYhqBQEeNfrjdb+aaWIAlwGUTL4ZR0NUQJkt9zHfwohxY
        /R3QKDR0D9l6UTxORsPKS/YKGO7EQP3rbsuXJQc3DA/qLeo=
X-Google-Smtp-Source: ABdhPJz11kHOvEXChiIVkK/qc6vwahI6jP/i0TQOA8LspHki7hKHGa2LT+TaR0vzyGRNT/vaC4+ZzXEBqgJIH48Jw3Q=
X-Received: by 2002:a17:907:7fa2:b0:6f4:2076:2bcc with SMTP id
 qk34-20020a1709077fa200b006f420762bccmr10835354ejc.212.1651518440998; Mon, 02
 May 2022 12:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220430130752.GI12542@merlins.org> <CAEzrpqc3jBA4gRiLuYWFgs8zu_XrNDZ_JS+d2J_TN2a-sivO=w@mail.gmail.com>
 <20220430231115.GJ12542@merlins.org> <CAEzrpqe9Kh7k6n_ohyjgeMm4Pvy6tNCoKBXBPKhtcC5CrVfexw@mail.gmail.com>
 <20220501045456.GL12542@merlins.org> <CAEzrpqe-92ZV-YqL8v9z1TV4wnqbVUjroTMsvC86z6Vws3Rb6A@mail.gmail.com>
 <20220501152231.GM12542@merlins.org> <CAEzrpqeiWrW6NbWLmUiWwE96sVNb+H0bEXmaij1K-HJQ38vL7w@mail.gmail.com>
 <20220502012528.GA29107@merlins.org> <CAEzrpqdWyOivUQ3ZtE2DS-ME7=Fs_UJN=nzA_VhosS5o3bZ+Uw@mail.gmail.com>
 <20220502173459.GP12542@merlins.org>
In-Reply-To: <20220502173459.GP12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 2 May 2022 15:07:09 -0400
Message-ID: <CAEzrpqdK1oshgULiR8z-DhJ71vOfXJz3aZNTJRJ1xeu3Bmz9-A@mail.gmail.com>
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

On Mon, May 2, 2022 at 1:35 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 02, 2022 at 12:41:11PM -0400, Josef Bacik wrote:
> > On Sun, May 1, 2022 at 9:25 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, May 01, 2022 at 07:09:19PM -0400, Josef Bacik wrote:
> > > > Sorry was on airplanes, pushed some more debugging.  Thanks,
> > >
> > > no worries
> > >
> > > Recording extents for root 165294
> > > processed 16384 of 49479680 possible bytes
> > > Recording extents for root 165298
> > > processed 81920 of 109445120 possible bytes
> > > Recording extents for root 165299
> > > processed 16384 of 75792384 possible bytes
> > > Recording extents for root 18446744073709551607
> > > processed 16384 of 16384 possible bytes
> > > doing block accounting
> > > ERROR: update block group failed 15847955365888 1073217536 ret -1
> > > FIX BLOCK ACCOUNTING FAILED -1
> > > ERROR: The commit failed???? -1
> > >
> >
> > More debugging, this really shouldn't happen because we wouldn't be
> > able to map the bytenr.  Thanks,
>
> Sure thing:
> Recording extents for root 165299
> processed 16384 of 75792384 possible bytes
> Recording extents for root 18446744073709551607
> processed 16384 of 16384 possible bytes
> doing block accounting
> couldn't find a block group at bytenr 15847955365888 total left 1073217536
> ERROR: update block group failed 15847955365888 1073217536 ret -1
> FIX BLOCK ACCOUNTING FAILED -1
> ERROR: The commit failed???? -1
>
> doing close???
> ERROR: commit_root already set when starting transaction
> extent buffer leak: start 13576823767040 len 16384
> Init extent tree failed
>

Wtf, that's definitely in the range of block groups that I've seen
printed.  I added some more stuff, hoping the tree search is just
broken.  Thanks,

Josef
