Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92E45BE32C
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Sep 2022 12:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiITK2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 06:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiITK2g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 06:28:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA42719A5
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 03:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5750B81919
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 10:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4154C433C1
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 10:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663669710;
        bh=7pGEIXJIv8t4DVjeCorI27agj4IL1Fk3mHiVgAbvc48=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jMm7DSCFhtib75YMVSjmiePv6tZHJMQ3az25UPI/N0I5xqNNb1XdosFoJUN72zn3j
         UR6O/u0UKLAf4p/OADfABAB2k5Itvgc6oeZvqQ/Zalkr6BcM8Tv2k24OEN7ij5Z4ON
         Wu8bRotjylRGD5Pe85YEHv53JIQlcwuuwbN+cMWgesmbYlu96fOHTVV2AM18ADDmv0
         b2ELP7XOErwIGC9c3OMhddrtjk2dApFS4++iiPIypuZLhWVITPBUQ5p3/aWezGq2mx
         butxuCTXeSd4AQX3se2zLEUDIphEs95ycaSngQiP3+yGDKbLSmFsMqBodAekRQ49Y+
         bQLOu8jQTeN0g==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-11eab59db71so3483776fac.11
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 03:28:30 -0700 (PDT)
X-Gm-Message-State: ACrzQf1fuxMZMsE/FjfyUqDbhwWJcLUpH5zzT8IWaa7Pv8KWmeAhn/zU
        fzMETs9/t5pVeCnCEe8qsFebL/EBYpZttLg8Xcw=
X-Google-Smtp-Source: AMsMyM5bv1mn0HsY26MRDUkMMJp2RhalZ6r2Gfv2bjKh1TByLg452yHHgVJdccfO5FtZDipz9obyq1JCJueOPUxzDDc=
X-Received: by 2002:a05:6870:63a6:b0:12b:85ee:59ff with SMTP id
 t38-20020a05687063a600b0012b85ee59ffmr1625555oap.98.1663669709782; Tue, 20
 Sep 2022 03:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1663594828.git.fdmanana@suse.com> <25d72acc3215f74fbb885562667bf12401c214e9.1663594828.git.fdmanana@suse.com>
 <ab13659e-6166-7de5-986a-54f98bc74e66@oracle.com>
In-Reply-To: <ab13659e-6166-7de5-986a-54f98bc74e66@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 20 Sep 2022 11:27:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7=hSQi1gVOOXB3g860iFz9YO9n6OTdZaJtmtbduNqcdw@mail.gmail.com>
Message-ID: <CAL3q7H7=hSQi1gVOOXB3g860iFz9YO9n6OTdZaJtmtbduNqcdw@mail.gmail.com>
Subject: Re: [PATCH 01/13] btrfs: fix missed extent on fsync after dropping
 extent maps
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 20, 2022 at 11:19 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> On 19/09/2022 22:06, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When dropping extent maps for a range, through btrfs_drop_extent_cache(),
> > if we find an extent map that starts before our target range and/or ends
> > before the target range, and we are not able to allocate extent maps for
> > splitting that extent map, then we don't fail and simply remove the entire
> > extent map from the inode's extent map tree.
>
>
> > +             if (testend && em->start + em->len > start + len)
>
>   %len comes from
>
>         u64 len = end - start + 1;
>
>   IMO >= was correct here; because including %start + %len is already
>   after the range as in the original code. No?

No, > is the correct thing to do. It only matters if the extent map's
range ends after our range.
Try the math with a simple example, with a start of 0 and a length of
4096 (end offset if 4095), and you'll see.

Thanks.

>
> > +                     ends_after_range = true;
> >               flags = em->flags;
> >               gen = em->generation;
> >               if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
> > -                     if (testend && em->start + em->len >= start + len) {
> > +                     if (ends_after_range) {
> >                               free_extent_map(em);
> >                               write_unlock(&em_tree->lock);
> >                               break;
