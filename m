Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B090E5FAF60
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJKJbp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 05:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKJbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 05:31:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648271155
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 02:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A1FA6115A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 09:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672E1C433D7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 09:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665480701;
        bh=PlRgVWG0bmBcqpwVt0uWVeTWGzXDnkRjNy2fNw6goOY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F+kwOjEGqXAIdMCpJrWuwBYuULjTbLA7a3pKz/5Ffvy5KDLUPzJpcpRkcAnYfZ/Gw
         5x8gExhqihUZKlDs4vJAkp53D4inE0kpbFo17QxHcuj0cXmxFKHI2TgCjChaVDIHCx
         iaaNtvzR20d5oUnGujEM+aAg2RCN6b0oqw8HZ9ySIR/45DPAtw3h+SW8+BVnHN5kST
         MQVl94t3JEDOIu3LxH0b6VWqrt/iMWmtX29L7TEr1lDq8GsjHENYGUajuFqpOx5bqe
         48IpexQ8s+orwEnz3e+yoTkx2BkIRtazaRkW7b0sPW6NjFly2Ghce3vXP5PItb2amt
         f+NhyTBDnlDCg==
Received: by mail-oo1-f46.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so9626008oop.9
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 02:31:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf2CgMwXb6hP3PYdQjGvwAccqZybfjY6AabI9rSENyccLszRW29W
        XfgEwbH+YNJLsw0HwclqqOoO88tjVVR3NuHfWyM=
X-Google-Smtp-Source: AMsMyM5Yj/ZEoL0wXvjEng9q8d+UgMS04nvXIJ8RIWxe0ag0b5IRiRfTIUBdQP18xET+e3iUMKMNPHm4iaUaUqqy/p4=
X-Received: by 2002:a05:6830:651c:b0:659:185a:10d7 with SMTP id
 cm28-20020a056830651c00b00659185a10d7mr10225079otb.363.1665480700554; Tue, 11
 Oct 2022 02:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221008005704.795b44b0@crass-HP-ZBook-15-G2> <20221010094218.GA2141122@falcondesktop>
 <SYCPR01MB46853527E05CE137D9525B1F9E239@SYCPR01MB4685.ausprd01.prod.outlook.com>
In-Reply-To: <SYCPR01MB46853527E05CE137D9525B1F9E239@SYCPR01MB4685.ausprd01.prod.outlook.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 11 Oct 2022 10:31:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7VXjo1Zg=G_GmNh+BQYMuE7=F7fvK3nujJQzUwbwTtFg@mail.gmail.com>
Message-ID: <CAL3q7H7VXjo1Zg=G_GmNh+BQYMuE7=F7fvK3nujJQzUwbwTtFg@mail.gmail.com>
Subject: Re: btrfs send/receive not always sharing extents
To:     Paul Jones <paul@pauljones.id.au>
Cc:     Glenn Washburn <development@efficientek.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 11, 2022 at 1:30 AM Paul Jones <paul@pauljones.id.au> wrote:
>
> > -----Original Message-----
> > From: Filipe Manana <fdmanana@kernel.org>
> > Sent: Monday, 10 October 2022 8:42 PM
> > To: Glenn Washburn <development@efficientek.com>
> > Cc: linux-btrfs@vger.kernel.org
> > Subject: Re: btrfs send/receive not always sharing extents
> >
> ....
> > I have some work in progress and ideas to speedup send in some cases, but
> > I'm afraid we'll always have some limitations - in the best case we can
> > improve on them, but not eliminate them completely.
> >
> > You can run a dedupe tool on the destination filesystem to get the extents
> > shared.
>
> Is that possible? To use a dedupe tool the subvolume has to be RW, but changing it from RO will break any future send operations I thought?

Yes, it's possible.

The deduplication ioctl works on read-only subvolumes/snapshots.
So a dedupe tool just has to open the files in read-only mode and call
the ioctl with the respective file descriptors.
In other words, there's no need to set the snapshot to RW, dedupe and
then set it back to RO.

The only limitation, which I hope to remove soon, is that you can not
run send on a snapshot that is currently the source or destination of
a dedupe operation,
and you can't also run dedupe on a snapshot while it's being used by a
send operation (they are exclusive operations).

>
>
> Paul.
