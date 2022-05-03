Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45419517B75
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 03:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiECBMx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 21:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiECBMu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 21:12:50 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304714ECC8
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 18:09:13 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id m6so13511075iob.4
        for <linux-btrfs@vger.kernel.org>; Mon, 02 May 2022 18:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGItHBSs/yYmXYOu8YCra0psDZ6oHQ8h7rBiuU7hGoI=;
        b=uujLTww2XfENKMKaX04zr3JpnYIXHVRgPlZZrBWF2sxLea5xe6GObRrZOR+MRlKXHm
         y+/pmtmcBHdcDc7nd4BnAZbf+jnbRWvogk1Q3M/ONtl3yIujvYvofKh2T6nyI2jPb30r
         4zUMlmkxGMz0bpT6hHNmeE4+bcBaQ70IptrcD+BVvQWGYxoB8rIG9PJwaP01jem4602i
         4plHL8wwO976sLZu8rHsB7mjvUd5xIEsHKf2dry/9gvUYx/bN+hrQ15gG1MnxfrCq3fn
         UITimH6Waeem+7WEnzEamGIWaaOW9ZegeYXkySe8QLcHjUSAxWJ/qe2gqHMxSC2J4LAD
         mtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGItHBSs/yYmXYOu8YCra0psDZ6oHQ8h7rBiuU7hGoI=;
        b=yp5UPxk2+irT8Ni7GzOXgFAvGjWF/Ss2fI/Si48E8QtWnFAfAJc+258BLT1F3n0DfH
         QhFC0P7LuEnfRPdAOLwyi3L/xRHb5mgErywL/Us7aiNanHY/osiCqnnsmwSKUjLY+qxS
         AxBQhm/tzIkhqFUXH8X03DZDSnTEW4h884FJ2jiofy7IRBxtORro0ezQ/JKT6XcaGJBA
         9FZNPR1YefTPcWE2ZoE0J10ane2Cjj2FUAi/n1BB6oVJVKQiyWJgVB8gC7mdCgWfWlwc
         YrWbMuUuwCo8P2zMAuxvHIGU5exTny5MQ/+7vjQapanMxKLn6pSBhgf293GNS3PVsSay
         6SGw==
X-Gm-Message-State: AOAM53324Hj8bFK/ublQdEWsImsuhFaCplFkKH1B9LiWfRiUu2f4hZJ4
        /rDGIAnfGXED3yWvIDPvrnOQ9N99KmquqmT9OVw6KU29GAU=
X-Google-Smtp-Source: ABdhPJx24bjDnQgB/j8dblCdRpAd2mtVwQZNpqq/6FpUNfyaV6hf+gqqn6DZBq/3zpB2YoEYPYsJWyKVtUPhMm/qjSc=
X-Received: by 2002:a05:6638:2501:b0:32b:6083:ca39 with SMTP id
 v1-20020a056638250100b0032b6083ca39mr3885605jat.281.1651540021943; Mon, 02
 May 2022 18:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220501152231.GM12542@merlins.org> <CAEzrpqeiWrW6NbWLmUiWwE96sVNb+H0bEXmaij1K-HJQ38vL7w@mail.gmail.com>
 <20220502012528.GA29107@merlins.org> <CAEzrpqdWyOivUQ3ZtE2DS-ME7=Fs_UJN=nzA_VhosS5o3bZ+Uw@mail.gmail.com>
 <20220502173459.GP12542@merlins.org> <CAEzrpqdK1oshgULiR8z-DhJ71vOfXJz3aZNTJRJ1xeu3Bmz9-A@mail.gmail.com>
 <20220502200848.GR12542@merlins.org> <CAEzrpqf2VMEzZxO3k74imXCgXKhG=Nm+=ph=qkNhfJ_G8KFb4g@mail.gmail.com>
 <20220502214916.GB29107@merlins.org> <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
 <20220502234135.GC29107@merlins.org>
In-Reply-To: <20220502234135.GC29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 2 May 2022 21:06:50 -0400
Message-ID: <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
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

On Mon, May 2, 2022 at 7:41 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 02, 2022 at 04:16:14PM -0700, Josef Bacik wrote:
> > On Mon, May 2, 2022 at 2:49 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Mon, May 02, 2022 at 05:03:40PM -0400, Josef Bacik wrote:
> > > > Ok I've fixed it to yell about what file has this weird extent so you
> > > > can delete it and we can carry on.  Thanks,
> > >
> > > That worked.  How do I delete this one?
> > >
> > > doing roots
> > > Recording extents for root 4
> > > processed 1032192 of 1064960 possible bytes
> > > Recording extents for root 5
> > > processed 10960896 of 10977280 possible bytes
> > > Recording extents for root 7
> > > processed 16384 of 16545742848 possible bytes
> > > Recording extents for root 9
> > > processed 16384 of 16384 possible bytes
> > > Recording extents for root 11221
> > > processed 16384 of 255983616 possible bytes
> > > Recording extents for root 11222
> > > processed 49479680 of 49479680 possible bytes
> > > Recording extents for root 11223
> > > processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819130,108,0 on root 11223
> >
> > btrfs-corrupt-block -d "1819130,108,0" -r 11223 <device>
>
> Whoops, it was right there in the text, sorry
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819130,108,0" -r 11223 /dev/mapper/dshelf1
> FS_INFO IS 0x564360382600
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x564360382600
>
>
> Didn't help?
> doing roots
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
> Recording extents for root 11223
> processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819131,108,0 on root 11223

It's a different inode number, 1819131 instead of 1819130.  This is
going to be the frustrating delete shit until it works thing again.
Thanks,

Josef
