Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519BF533067
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 20:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbiEXS02 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 14:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiEXS0Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 14:26:25 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7D41D0EF
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 11:26:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a10so19172443ioe.9
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIX+u6GZcqLRZ1LgtPBGXuVTPAA3ys7NCaeczSP7CzQ=;
        b=cnC94j3KdxBGp5q2SD4aQS37QsMP139r9it3R5Pd2m+sd1XFGhx2fiK2bN3r1xHhE0
         EHYLdnna5xo8cr7HtCut0BiXj4c2zarUO5NSsmqF5s/9N63zCs3oMvTn73BkGihYtNAr
         kWswclS/AAdYJz3DvyaAHUdEzTKpCQmE9Iq04Yq09zwmgb2hDK1HLZLWYT1FsB2VHViY
         EoULp5kjq6i32h15Vpx1Ez1vCMMg41tNg3h+N/qcQ9TixvaVxw7ZBJTikNFvt1hS9phr
         xzppJXV1AnmrD7saMmAtWFUZHlwm9l3aVquzexQkxdgDGoSpfO8D5vd6s08ALvttToBS
         P5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIX+u6GZcqLRZ1LgtPBGXuVTPAA3ys7NCaeczSP7CzQ=;
        b=JlKVgMoIx8/VjRvxCMDcMaXSX+SYR7Vn2I+GROZDSIUvLSdigQLsJnm7X+W9ghxY6I
         UfSOW4WLMxu4YVS7AZYsu0oLZUH1cy1zTzHrrO0vK2XAzYUp5uDP1/B0fvnwoEsRX3XA
         wmwMhjl4+i5lrJ0TsiiL9O/FEqnngYTWMMcn1/WZGB4mknGHAJqe0Of6L1wvk6cmtz6L
         JvIIfjngJ3Cg+3/rAO+Q1tkBp1bPjz9NYtm7GrX/ym9VjMQlk6hJ3NOsRSgCsLOqr4WE
         A3vo7JpsL6XTx9unooo0S+0QuLnGoEYP/piw8cqpR/ehq+YGfYK6F+1pTS7dOTBQAV8A
         iAiQ==
X-Gm-Message-State: AOAM530ZHO4BbSeRdelrZXRESX+7nhWdupXDEv8M2Idt6HhF7vdOJnX6
        6r3eImn+ITNAb1a5NihzwdI3jZQal/OrJMp2DXUAQxEhjxIVwg==
X-Google-Smtp-Source: ABdhPJwYETbQfxaUOfllDRBJZck4W38c8Lsnk7uY4d8zLAhM7kaKCE9cMFjXCkWZUSgsrh/Ej9pXFW5gDuCiw9eP3Gw=
X-Received: by 2002:a02:a609:0:b0:32e:7865:17f4 with SMTP id
 c9-20020a02a609000000b0032e786517f4mr14619583jam.313.1653416782626; Tue, 24
 May 2022 11:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220516165327.GD8056@merlins.org> <CAEzrpqfShQhaCVv1GY=JTTCO_T44ggidHFtbSABrcPCSNzY9hA@mail.gmail.com>
 <CAEzrpqdsi63zgudjzbSa3QyMLuE5nD3+t9nOuzXEdWZGCbTcNA@mail.gmail.com>
 <20220517202756.GK8056@merlins.org> <CAEzrpqdgKtSDJj2QekYuS+M77wYrp6bvXv2Ue3xQ8Vm2bGGYAg@mail.gmail.com>
 <20220517212223.GL8056@merlins.org> <CAEzrpqcX3XEQGjoJCV1wARu=Od7vAypmzO4dCFgQ+_UBBuJdMA@mail.gmail.com>
 <20220518191241.GI13006@merlins.org> <CAEzrpqfPEU9Vt86ykVyxwvDXrihKfGc180oT7SUcQdwtYysquw@mail.gmail.com>
 <20220519222855.GL13006@merlins.org> <20220524011348.GR13006@merlins.org>
In-Reply-To: <20220524011348.GR13006@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 24 May 2022 14:26:11 -0400
Message-ID: <CAEzrpqd=G50pWKYJRD57ePVpfGNPu947zJXuZFdj0tF4yGzkbQ@mail.gmail.com>
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

On Mon, May 23, 2022 at 9:13 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, May 19, 2022 at 03:28:55PM -0700, Marc MERLIN wrote:
> > On Wed, May 18, 2022 at 03:17:55PM -0400, Josef Bacik wrote:
> > > Yes sorry I meant to say that.  Because we have these dangling block
> > > groups we'll suddenly have a bunch of files that no longer are
> > > mappable and we'll need to delete them.  Looks to be about 7gib of
> > > block groups so you're going to lose that stuff, it's going to be a
> > > while but it's expected.  Thanks,
> > >
> > So, it's definitely deleting a lot
> >
> > I think I'm at 81%
> >
> > searching 159785 for bad extents
> > processed 78446592 of 95879168 possible bytes, 81%
> > Found an extent we don't have a block group for in the file
> > Performances/Magic/Diversion 08022019.mkv
> > Deleting [70879, 108, 10708312064] root 6781246029824 path top 6781246029824 top slot 19 leaf 10678930079744 slot 34
> >
> > gargamel:~# grep -c Deleting /mnt/btrfs_space/ri1
> >  149583
> >
> > Ok, that's a lot of files, but let's see if it finishes
>
> mmmh, so I'm not sure if it's going to finish soon? still going after 5
> days.
> searching 162632 for bad extents
> processed 78446592 of 99090432 possible bytes, 79%
> Found an extent we don't have a block group for in the file
> file
> Deleting [70879, 108, 9305350144] root 6781246177280 path top 6781246177280 top slot 19 leaf 782788263936 slot 0
>
> searching 162632 for bad extents
> processed 78446592 of 99090432 possible bytes, 79%
> Found an extent we don't have a block group for in the file
> file
> Deleting [70879, 108, 9305358336] root 6781246128128 path top 6781246128128 top slot 19 leaf 782788296704 slot 0
>
> searching 162632 for bad extents
> processed 78446592 of 99090432 possible bytes, 79%
> Found an extent we don't have a block group for in the file
> file
> Deleting [70879, 108, 9305411584] root 6781246177280 path top 6781246177280 top slot 19 leaf 782788263936 slot 0
>
>
> gargamel:~# grep -c Deleting /mnt/btrfs_space/ri1
> 620577
>
> over 600K files deleted, it's still moving forward though.

So it's 600k extents, not files.  Here you have the same file, just
different offsets

Deleting [70879, 108, 9305350144] root 6781246177280 path top
6781246177280 top slot 19 leaf 782788263936 slot 0
Deleting [70879, 108, 9305411584] root 6781246177280 path top
6781246177280 top slot 19 leaf 782788263936 slot 0

I'm really wishing I had noticed this earlier, it would have been
faster to put together the old block groups than to wait for this,
sorry about that.

Right now I feel like absolute crap, my kids gave me COVID so I've
been fluctuating between dying and feeling ok.  Tomorrow if I'm
feeling better I'll take a look at the chunk restore code and see if I
can't just put the tree back the way it was easily.  Thanks,

Josef
