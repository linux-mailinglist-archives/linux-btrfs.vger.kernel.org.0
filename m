Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F179C69AA33
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 12:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBQLT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 06:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBQLT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 06:19:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0A26CF2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 03:19:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5C2161827
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 11:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF87C4339E
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 11:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676632795;
        bh=Uy/tDmJwcriTrlu7uZpIgjMKLlqWbd7g85E0oeIdwZs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jm35hV5Oa76kbNDhSGQjYt2CiqucswfSJEj6+lv5RVgHmh50WTE6eUasxFu6TIjvF
         cGuoWh60EH15ARfQvqGG76R+klJM1RBlwQI1tBuZz2kyJI+OH/cY5LLKvQKGJ/CJOF
         VIsJkL+5QSuh/vEk144KQNw1Xc0K+NrHVH2PItIju9LBRV39oeO5d/99wyKXuIdbVt
         ukDBMGEzWCCXl0599yA7F2udKOiqtYZp7qm4kUu1xhak92qlM18kXlUSEPz4plYsbp
         SQvtQ/4yZc6BACv1Qw0zhKeg+XyWEcPxI3A8KyHPoQGmgWQ2Zbx1vR73DgldUj9ggE
         R9O1BldlT6DJw==
Received: by mail-oi1-f177.google.com with SMTP id t13so979554oiw.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 03:19:55 -0800 (PST)
X-Gm-Message-State: AO0yUKXcvStuBsThzAXAGQTI0QGPGxQlsYzUvoLiDoki06V2Pd529km8
        i4ilDy1Dmu4yar4oi7h6T+ZWW/FxQkYw9dAneHE=
X-Google-Smtp-Source: AK7set+DwN9T+XL4q7SYWsoS5SAPY4hhZhEjIaMNZXYymsQgjKEuFgdbQWqUwr57UYVmb3roB/jcNbC6RRhCsYqtKss=
X-Received: by 2002:a05:6808:2394:b0:37d:5e52:6844 with SMTP id
 bp20-20020a056808239400b0037d5e526844mr447513oib.98.1676632794410; Fri, 17
 Feb 2023 03:19:54 -0800 (PST)
MIME-Version: 1.0
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com> <Y+1pAoetotjEuef7@zen>
 <Y+16BVPQiwf8e1J3@zen> <CAL3q7H7n3BG_6B_riK9U=uCO5JKZwefU9DPtmcRZ0W=T+7K0Nw@mail.gmail.com>
 <Y+5kjpZJJxU+vz1X@zen> <CAL3q7H4CmQOG6wYBg8Ha0xUJ+QWKEfF8YixJ-DwnJy=fXs9e=Q@mail.gmail.com>
 <Y+56sPyNHZRVQdnj@infradead.org> <CAL3q7H7gWmJhJ-xMcDifQ2hK=wMWJTmQ0tQWd8KRsaQM6fwiDg@mail.gmail.com>
 <Y+6yEwymCdyOQ/4V@zen>
In-Reply-To: <Y+6yEwymCdyOQ/4V@zen>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 17 Feb 2023 11:19:18 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5tO=Xzw_8NvzV4Oi5-r1XAntT8hNEk-sT_O4KkN=UuuA@mail.gmail.com>
Message-ID: <CAL3q7H5tO=Xzw_8NvzV4Oi5-r1XAntT8hNEk-sT_O4KkN=UuuA@mail.gmail.com>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on ext4
To:     Boris Burkov <boris@bur.io>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 16, 2023 at 10:45 PM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Feb 16, 2023 at 09:43:03PM +0000, Filipe Manana wrote:
> > On Thu, Feb 16, 2023 at 6:49 PM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Thu, Feb 16, 2023 at 06:00:08PM +0000, Filipe Manana wrote:
> > > > Ok, so the problem is btrfs_dio_iomap_end() detects the submitted
> > > > amount is less than expected, so it marks the ordered extents as not
> > > > up to date, setting the BTRFS_ORDERED_IOERR bit on it.
> > > > That results in having an unexpected hole for the range [8192, 65535],
> > > > and no error returned to btrfs_direct_write().
> > > >
> > > > My initial thought was to truncate the ordered extent at
> > > > btrfs_dio_iomap_end(), similar to what we do at
> > > > btrfs_invalidate_folio().
> > > > I think that should work, however we would end up with a bookend
> > > > extent (but so does your proposed fix), but I don't see an easy way to
> > > > get around that.
> > >
> > > Wouldn't a better way to handle this be to cache the ordered_extent in
> > > the btrfs_dio_data, and just reuse it on the next iteration if present
> > > and covering the range?
> >
> > That may work too, yes.
>
> Quick update, I just got a preliminary version of this proposal working:
> - reuse btrfs_dio_data across calls to __iomap_dio_rw
> - store the dio ordered_extent when we create it in btrfs_dio_iomap_begin
> - modify btrfs_dio_iomap_end to not mark the unfinished ios done in the
>   incomplete case. (and to drop the ordered extent on done or error)
> - modify btrfs_dio_iomap_begin to short-circuit when it has a cached
>   ordered_extent
>
> The resulting behavior on this workload is:
> - write 8192
> - finish OE, write file extent
> - write 57344 (no extent, cached OE)
> - re-enter __iomap_dio_rw with a live OE
> - skip locking extent, reserving space, etc.
> - write 1769472
> - finish OE, write file extent
>
> and the file looks as if there were no partial write. I think this is a
> good structure for a fix to this bug, and plan to polish it up and send
> it soon, unless someone objects and thinks we should go a different way.

Sounds good to me. Thanks.
