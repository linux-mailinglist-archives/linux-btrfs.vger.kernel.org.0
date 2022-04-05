Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511294F477E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiDEVLz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446163AbiDEPoP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 11:44:15 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B19197FB8
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 07:11:37 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d3so9275092ilr.10
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmiqTTZZLUxvOzqYxnc6Ssp2o79XueuYazQdIqFfc2U=;
        b=Hhiirq17IpRtpr2xtPic35fpRJ7sNN+4cagcOIKn3S/ZSSh+7LE+MDmDmVuIFwwJgg
         erfa9EfcoXsCp4Xf+ZqzCpWByf1vHCT2ign/ZMoLiXVXhOnVOZFyOSmGAR/7z9d4yXm+
         rOm3K8EiSvZET8dJshDBjxAIONETLX8MoSXpOMM0PoXgxNK0YZYDiOSyRao9ZP6Tdo9U
         T8diPVZgT1M58Kou0gifLRHOncE0e7hO6U8i9VWnof+dP8q7IRmmgMaEE3+dV/Ng8L27
         GV50xB8kef+Hqz0ooQpRdp8vNMFhJASrBHawdXOF7l64nuHhiM+0FExaRop0vFL0dwJR
         hAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmiqTTZZLUxvOzqYxnc6Ssp2o79XueuYazQdIqFfc2U=;
        b=oCm3EGOtL8LeaQBvz48N7dSsuBejci0ybXcS/LqeNHQBSwVGjNQdkVhsn9v2HVMgwj
         4sEgDtI3UvT1/lkDwNiRm8PLZ1+ahP2NJGOl02RxS1LLIfGgCP7F97rJsU5etror8F2t
         PQxERcwHt3Bxd4uZFNd1KKd573cgzQCte4KLacIM72NArcHxQtmTjvs10jBB9QFkOhw5
         /klJ0diQU//+qzXC/Iy2hB2pEr3oY0q0I7yEamYeZJfhg4sKcxXmjf+eTtbiUxijQ51p
         FQUXcANyPlXT+7w9XJOrjCuZXk74SLSlaIw6vXVlLauu93uZ2DgmxcLmCmblqkpttCgL
         c0XA==
X-Gm-Message-State: AOAM533oyOB5OavkzwsUP7gkIjA/ZSlyazLSn9sDQpmWF6iu7CIRs3ks
        ptyw9JxYT0dxoN81j9B8RbCyJxRL1aYCPp5mSSt9xTarqlFjcw==
X-Google-Smtp-Source: ABdhPJwR7eMyVvrNDBYYqyIIK+l/RB3oR8C3nBqXU3QwX9geIYT9u5KSuxA4TjOxy03YcfRhFEAJTA8dluiHKatgenM=
X-Received: by 2002:a05:6e02:1889:b0:2ca:2105:78 with SMTP id
 o9-20020a056e02188900b002ca21050078mr1986720ilu.6.1649167896684; Tue, 05 Apr
 2022 07:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220405001808.GC5566@merlins.org> <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
 <20220405002826.GD5566@merlins.org> <CAEzrpqeHa7tG+S_9Owu5XYa0hwBKJPVN2ttr_E_1Q4UV8u0Nmg@mail.gmail.com>
 <20220405005809.GE5566@merlins.org> <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
 <20220405011559.GF5566@merlins.org> <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
 <20220405014259.GG5566@merlins.org> <CAEzrpqdjLn51R++iX0_7-MRbxoNo7HL5GZFs4399KV6=RO3cyQ@mail.gmail.com>
 <20220405020729.GH5566@merlins.org>
In-Reply-To: <20220405020729.GH5566@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 10:11:25 -0400
Message-ID: <CAEzrpqd6kePW6eiMB-R4DvMRvU=AK-jKpkBNUvSjttsSEsCwpA@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 10:07 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 09:55:41PM -0400, Josef Bacik wrote:
> > On Mon, Apr 4, 2022 at 9:43 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Mon, Apr 04, 2022 at 09:22:26PM -0400, Josef Bacik wrote:
> > > > Ok lets try again with -b 13577821667328, and if the owner doesn't say
> > > > ROOT_TREE try 13577775284224 and then 13577814573056.  Thanks,
> > >
> > > EXTENT_TREE, FS_TREE, and FS_TREE
> > >
> > > And shit, I got distracted and sent the text output to
> > > /dev/mapper/dshelf1a, so I clobbered about 30K of the device.
> > > I'm assuming there was probably something there?
> >
> > Yes the chunk tree, but your FS is DUP so we'll find the other copy,
> > it'll be fine.
>
> Great news, thanks.
>
> > Do you have any subvolumes that aren't snapshots?  I think I can
> > re-create everything without knowing what other roots there are, but
> > if you have snapshots/subvolumes I need to be more careful.
>
> 6 subvolumes plus snwpshots of them:
> media other Soft Sound Video Win
>
> Maybe 50 to 100 snapshots total (mostly snapshots)
>
> > In any case I'm going to go to bed, it's been a long week.  I'll start
> > working on a tool to re-create your root tree in the morning, and then
> > hopefully we can go from there.  Thanks,
>
> Thanks for your help, have a good night.
>

Ok the fs volumes are going to be trickier to put back together, so
first lets make sure the fs tree pointer is correct and relatively
intact.  Can you do

./btrfs inspect-internal dump-tree -b 13577799401472 /dev/whatever

I don't need the full dump since it's all the metadata for your fs
tree.  What I'm looking for is if this looks sane, you'll see the
normal errors you see from the fs being generally fucked, but I want
this to spew and seem like it worked, and all have owner of FS_ROOT.

The problem here is that since the tree root is fucked I can't easily
find the subvolumes bytenr, so we're going to have to walk the FS_ROOT
and find the ID's for all your subvolumes, and then use
btrfs-find-root to find the bytenrs of those roots.  From there I can
clear your old tree root and create it with just the subvolumes, chunk
root, and device root.  From there fsck can re-create the extent and
csum tree.  Thanks,

Josef
