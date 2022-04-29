Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9B51404B
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 03:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348937AbiD2Ble (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 21:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiD2Blc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 21:41:32 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F05BF330
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 18:38:16 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h8so8328644iov.12
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 18:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h506AnMBI2v7IuNNxqewEnk8s4ImfaAstCN4ru02EfQ=;
        b=EGGFWc643W63/V+Bjt9zQEkAwBw5srQv9+UeRB92qYMBKuGhEZv7hWd+qIbEGG8FGj
         M1ttYN7DofbQnwm9nWH1dxpdZCvtlnd1hSn//5WX3lNgeX37ibQVlTJjwhXi8y0u2nsj
         spL3ZUDyRMaVfzBplY0s9vvWHaF5+m1otAZRE5d06KU5t3A+3hiwnYa198V3tv+riZKu
         L7LVk/MiHmdWtjUYzc0SE9G6f2S1uunguhidYe0aRjs97LcRf0HXDqKZWt/7XAI82fHo
         3zf+tFTEccK54uMU8TczumbjC6zUY0wCVoknYB554vh+b2BTfwOgIWy9X5X/7iR22ub+
         GK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h506AnMBI2v7IuNNxqewEnk8s4ImfaAstCN4ru02EfQ=;
        b=bhd705bL0LTL/jleA+MoHYh1hqXxcs9z/6MxkqcuBkDxns17xHlV/dPlfHpAziDRlW
         4h0iWtMV1E1k7Wf90KepMKY+rhjyI8SHTz+V/CPtYxQIxVVwFvYp9tb9PIL9a2fuQRQZ
         6YS7zO/dCUgyXqLl/KmVL6OOySU386V+IzYBvCyR4bEyuJZThAFxQ3IpR331TIrx1YXC
         4cEoit3ES0gQ7ylEo6J7CvXvBXmJ3zlxZCE8FTHhE2M++voEH04IAbP0RKoPe/Ru2tZT
         UthjY9VpKN1MMM/JlkMDmpP53jJe9jifihRDPlkl8N1+gFjVhHMu1zeVKP5OZ7qZ29iU
         1zuw==
X-Gm-Message-State: AOAM532t3PphVZMOX98I7SPKUSUUpe3o8bAEilo2r0JPYB/wTAgDdWXg
        8EgCvs4gKab6/KMzAK3hPbDcWciF5kzlwLyUA1La8J/u2IA=
X-Google-Smtp-Source: ABdhPJyj4eUzScfOf3WntCJgXG64RCU/9cmfjM9oRVEdjHwyshyj2b34vGiiAeFo/wrnau6ZU9rPA4wvfrnuBZfc2HM=
X-Received: by 2002:a02:ccd0:0:b0:32a:e2da:1e1f with SMTP id
 k16-20020a02ccd0000000b0032ae2da1e1fmr11256124jaq.313.1651196296062; Thu, 28
 Apr 2022 18:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220428202205.GT29107@merlins.org> <CAEzrpqfHjAn7X9tMm6jAw8NJiv3vsvYioXj9=cjMqNcXjFhSdA@mail.gmail.com>
 <20220428205716.GU29107@merlins.org> <CAEzrpqduAKibaDJPJ6s7dCAfQHeynwG6zJwgVXVS_Uh=cQq2dw@mail.gmail.com>
 <20220428214241.GW29107@merlins.org> <CAEzrpqd0deCQ132HjNJC=AKQsRTXc=shnAmHfs0BR9pWiD4mhg@mail.gmail.com>
 <20220428222705.GX29107@merlins.org> <CAEzrpqeQrSrMgGLh0F34fVj8dnzJQF7kv=XSBKcD92oHyV8-gA@mail.gmail.com>
 <20220429005624.GY29107@merlins.org> <CAEzrpqe+n9iGQymL01eZQjPBnN+Z1NeGDyTDaC-pwsGkOwvuDg@mail.gmail.com>
 <20220429013409.GD12542@merlins.org>
In-Reply-To: <20220429013409.GD12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 28 Apr 2022 21:38:05 -0400
Message-ID: <CAEzrpqfF7xfLxSBpJGfu2uP5iUzBhirg=wRfs108rLyuiUSW1Q@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 9:34 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Apr 28, 2022 at 09:11:51PM -0400, Josef Bacik wrote:
> > On Thu, Apr 28, 2022 at 8:56 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Thu, Apr 28, 2022 at 07:24:22PM -0400, Josef Bacik wrote:
> > > > > inserting block group 15835070464000
> > > > > inserting block group 15836144205824
> > > > > inserting block group 15837217947648
> > > > > inserting block group 15838291689472
> > > > > inserting block group 15839365431296
> > > > > inserting block group 15840439173120
> > > > > inserting block group 15842586656768
> > > > > processed 1556480 of 0 possible bytes
> > > > > processed 49152 of 0 possible bytesadding a bytenr that overlaps =
our
> > > > > thing, dumping paths for [4088, 108, 0]
> > > >
> > > > Oh huh, we must not have a free space object for this, in that case=
 lets do
> > > >
> > > > ./btrfs-corrupt-block -d "4088,108,0" -r 2 /dev/whatever
> > > >
> > > > and then do the init.  Thanks,
> > >
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block=
 -d "4088,108,0" -r 2 /dev/mapper/dshelf1
> > > FS_INFO IS 0x558c0e536600
> > > JOSEF: root 9
> > > Couldn't find the last root for 8
> > > FS_INFO AFTER IS 0x558c0e536600
> > > Error searching to node -2
> > >
> > > not good news I assume?
> > >
> >
> > Just that I=C2=B4m dumb and making silly mistakes, its -r 1, sorry abou=
t that,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d =
"4088,108,0" -r 1 /dev/mapper/dshelf1
> FS_INFO IS 0x557f68dd6600
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x557f68dd6600
>
> then init-extent-tree:
> inserting block group 15838291689472
> inserting block group 15839365431296
> inserting block group 15840439173120
> inserting block group 15842586656768
> processed 1556480 of 0 possible bytes
> processed 1474560 of 0 possible bytes
> Recording extents for root 4
> processed 1032192 of 1064960 possible bytes
> Recording extents for root 5
> processed 10960896 of 10977280 possible bytes
> Recording extents for root 7
> processed 16384 of 16545742848 possible bytes
> Recording extents for root 9
> processed 16384 of 16384 possible bytes
> Recording extents for root 11221
> processed 16384 of 255983616 possible bytes
> Recording extents for root 11222
> processed 49479680 of 49479680 possible bytes
> Ignoring transid failure
> ERROR: root [11223 4061] level 0 does not match 2
>

I'm going to scream.  Somehow the root pointer for 11223 got messed up
in all of this, do rescue tree-recover again so it can unfuck 11223,
and then init-extent-tree.  Thanks,

Josef
