Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFBD699F12
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 22:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBPVnn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 16:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBPVnm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 16:43:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8903B3CF
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 13:43:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29C2B60C1D
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 21:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ECBC4339B
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 21:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676583820;
        bh=AA4P/7oNAVd0RUSU1kHy2/whsk5xZNt/lbx+zYu4YWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S1oVk4XYh3N2BlEcsd7DL5ZUohVC8mB8hkDRf8N4gOOUVCZbIXPO340cTb5pc8qMB
         LEi/XStlNDYFdtLos87Pzy2PlMX1renj/wvu8N9MyPeY+GYsUS79eFab6OFDjJme37
         s8H0La3BA/16vg1cGWr15cALbXe1ybyB2Y7m9DzH5gP3vjAp7/KbmDdzIjt4kOkeb9
         aTKj1DLTrqT8IhwFRptQrJ+B/RlnxGS98OBRdnQTiMUJc/n2qhRRy/bCsCcjToGtd4
         OzJRx9f5hqBkpdYA9BuAsSRuxQJJCQN7FFwaAnG8lJcJEETDj/gT7aMLbSTcFcoaVI
         MwtUAgeIpc+IQ==
Received: by mail-oi1-f169.google.com with SMTP id w11so3078372oiv.5
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 13:43:40 -0800 (PST)
X-Gm-Message-State: AO0yUKVpvWwO1X7t+SkXt0NlOsefu+moTHMBwg7/+mDXAEyZGPWC6iyS
        uxnVjGWlJ3RDTI/QpihE3YCxCqWChoz/g8l2u30=
X-Google-Smtp-Source: AK7set/NALiiQzRsSsEmVjeld9ObAJb6/D3R+1105NAYTHuyX318KDSYxfLDtEXcm/qNsLU2ehbOEuXSmH+hXCQfKm4=
X-Received: by 2002:a05:6808:2394:b0:37d:5e52:6844 with SMTP id
 bp20-20020a056808239400b0037d5e526844mr290407oib.98.1676583819616; Thu, 16
 Feb 2023 13:43:39 -0800 (PST)
MIME-Version: 1.0
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com> <Y+1pAoetotjEuef7@zen>
 <Y+16BVPQiwf8e1J3@zen> <CAL3q7H7n3BG_6B_riK9U=uCO5JKZwefU9DPtmcRZ0W=T+7K0Nw@mail.gmail.com>
 <Y+5kjpZJJxU+vz1X@zen> <CAL3q7H4CmQOG6wYBg8Ha0xUJ+QWKEfF8YixJ-DwnJy=fXs9e=Q@mail.gmail.com>
 <Y+56sPyNHZRVQdnj@infradead.org>
In-Reply-To: <Y+56sPyNHZRVQdnj@infradead.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 16 Feb 2023 21:43:03 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7gWmJhJ-xMcDifQ2hK=wMWJTmQ0tQWd8KRsaQM6fwiDg@mail.gmail.com>
Message-ID: <CAL3q7H7gWmJhJ-xMcDifQ2hK=wMWJTmQ0tQWd8KRsaQM6fwiDg@mail.gmail.com>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on ext4
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Boris Burkov <boris@bur.io>,
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

On Thu, Feb 16, 2023 at 6:49 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Feb 16, 2023 at 06:00:08PM +0000, Filipe Manana wrote:
> > Ok, so the problem is btrfs_dio_iomap_end() detects the submitted
> > amount is less than expected, so it marks the ordered extents as not
> > up to date, setting the BTRFS_ORDERED_IOERR bit on it.
> > That results in having an unexpected hole for the range [8192, 65535],
> > and no error returned to btrfs_direct_write().
> >
> > My initial thought was to truncate the ordered extent at
> > btrfs_dio_iomap_end(), similar to what we do at
> > btrfs_invalidate_folio().
> > I think that should work, however we would end up with a bookend
> > extent (but so does your proposed fix), but I don't see an easy way to
> > get around that.
>
> Wouldn't a better way to handle this be to cache the ordered_extent in
> the btrfs_dio_data, and just reuse it on the next iteration if present
> and covering the range?

That may work too, yes.
