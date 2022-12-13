Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7EB64B358
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 11:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiLMKjw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 05:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbiLMKjr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 05:39:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453D71BEA1
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 02:39:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C86A561457
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8D0C433D2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670927985;
        bh=/50AGpNoBDDOx6n7sSsmdqWPm0z7s9QWozRKKmrD9rU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sCzcQU5Lkh7D5bM6Ow2xUJ4QP3gFZyOLtmGRKW2inNxJZLUBeOIfuzkf8DYxHO36E
         AGVCmCQ8P39v23F7mLcpPPDJQeBLQ6g3jC53BOl9ZJdiq2+IGUzEJ1ewfLGJlCSf/T
         y93gsLku3WjPOAU8AN0PMNpMmMUyvXfiG5kqFVqM0YoSyedCXSsvXcwlktx4bSX4Dt
         756bjJJOCDPDIWrNkSip4X1ApN8j1oOMm5RBqOR8pUDACrYcS5rjclA4VEjuR3jeXM
         vIj42RmetZwNvkPECXVhHvRTwgoXWq2PISovs9VJzfGGDRA+KNqGzvkScUPnm1+gvI
         HmtRd4xbuiyeg==
Received: by mail-oi1-f171.google.com with SMTP id v82so13824189oib.4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 02:39:44 -0800 (PST)
X-Gm-Message-State: ANoB5pnTictq4ap2Ist7B1mz4Bvdd9iK3mj14e98YOL32I89LVvBDMPH
        gHsbmrM95jr7iLuI4C6/F1ySev26w+msg/qhQDI=
X-Google-Smtp-Source: AA0mqf69SOnT4NF43Ip+0k8TXgqqPs4HdYO31ejM4BLYT2ty8zUFX3QeCoL/UkUmna0IxpnycDR8MzYMnSRBb/FmJNY=
X-Received: by 2002:a05:6808:8d2:b0:35b:75b:f3b9 with SMTP id
 k18-20020a05680808d200b0035b075bf3b9mr143541oij.98.1670927983964; Tue, 13 Dec
 2022 02:39:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668166764.git.fdmanana@suse.com> <20221213091107.aezonr65mivb2ijq@naota-xeon>
In-Reply-To: <20221213091107.aezonr65mivb2ijq@naota-xeon>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 13 Dec 2022 10:39:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7pdt0jbmGMV7mr0V6kT2_-VYF=6B-TiGke5Nkos_TfzA@mail.gmail.com>
Message-ID: <CAL3q7H7pdt0jbmGMV7mr0V6kT2_-VYF=6B-TiGke5Nkos_TfzA@mail.gmail.com>
Subject: Re: [PATCH 0/9] btrfs: more optimizations for lseek and fiemap
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 13, 2022 at 9:11 AM Naohiro Aota <Naohiro.Aota@wdc.com> wrote:
>
> Hello, Filipe

Hi Aota,

>
> Thank you for this series. We had a performance issue on a HDFS write only
> workload with the zoned mode. That issue is solved thanks to this
> series. In addition, it improves the performance even on the regular
> btrfs. So, this series might be worth backporting. I'd like to share the
> result.

I'm afraid backporting the whole series is not an option.
It depends on two very large patchsets that largely rewrite fiemap and lseek,
focused more on performance improvement but also fix one bug with fiemap
extent sharedness reporting.

In reverse order:

https://lore.kernel.org/linux-btrfs/cover.1665490018.git.fdmanana@suse.com/
(introduced in this merge window)

https://lore.kernel.org/linux-btrfs/cover.1662022922.git.fdmanana@suse.com/
(introduced in 6.1)

>
> The test workload is a system call replay, which mimics a HDFS write only
> workload. The workload does buffered writes with pwrite() to multiple files
> and does not issue any sync operation, so the performance number is the
> number of bytes issued with pwrite() divided by the total runtime without
> sync. The total pwrite() size is about 60GB.
>
> Before the series:
> - Regular:         307.68 MB/s
> - Zoned emulation: 269.32 MB/s
> - Zoned:           231.93 MB/s
>
> At the first patch of the series:
> - Regular:         349.84 MB/s (+13.70%)
> - Zoned emulation: 363.48 MB/s (+34.96%)
> - Zoned:           326.40 MB/s (+40.73%)
>
> After the series (at b7af0635c87f ("btrfs: print transaction aborted messages with an error level")):
> - Regular:         350.22 MB/s (+13.83%)
> - Zoned emulation: 360.96 MB/s (+34.03%)
> - Zoned:           326.24 MB/s (+40.66%)
>
> So, before the first patch, the zoned case had poor performance (-12% on
> the zoned emulation and -24% on the zoned) compared to the regular case. As
> the regular case and the zoned emulation case ran on the same device, it
> shows the zoned mode's penalty.
>
> This series improves the performance for all the cases. But, the zoned
> cases have far better improvements and it somehow solved the performance
> degradation.
>
> Also, even only with the first patch, the performance greatly improved. So,
> interestingly, the first patch, touching only the readpage() side is the
> key to fixing the issue for our case.

Backporting the first patch only seems reasonable to me, and it
depends on the following one that landed in 6.1:

52b029f42751 ("btrfs: remove unnecessary EXTENT_UPTODATE state in
buffered I/O path")

(it's mentioned in the changelog)

It seems your workload is probably not fiemap/lseek heavy (I only see
mentions of pwrite).
Thanks for the report!

>
> On Fri, Nov 11, 2022 at 11:50:26AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Here follows a few more optimizations for lseek and fiemap. Starting with
> > coreutils 9.0, cp no longer uses fiemap to determine where holes are in a
> > file, instead it uses lseek's SEEK_HOLE and SEEK_DATA modes of operation.
> > For very sparse files, or files with lot of delalloc, this can be very
> > slow (when compared to ext4 or xfs). This aims to improve that.
> >
> > The cp pattern is not specific to cp, it's common to iterate over all
> > allocated regions of a file sequentially with SEEK_HOLE and SEEK_DATA,
> > for either the whole file or just a section. Another popular program that
> > does the same is tar, when using its --sparse / -S command line option
> > (I use it like that for doing vm backups for example).
> >
> > The details are in the changelogs of each patch, and results are on the
> > changelog of the last patch in the series. There's still much more room
> > for further improvement, but that won't happen too soon as it will require
> > broader changes outside the lseek and fiemap code.
> >
> > Filipe Manana (9):
> >   btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree
> >   btrfs: add an early exit when searching for delalloc range for lseek/fiemap
> >   btrfs: skip unnecessary delalloc searches during lseek/fiemap
> >   btrfs: search for delalloc more efficiently during lseek/fiemap
> >   btrfs: remove no longer used btrfs_next_extent_map()
> >   btrfs: allow passing a cached state record to count_range_bits()
> >   btrfs: update stale comment for count_range_bits()
> >   btrfs: use cached state when looking for delalloc ranges with fiemap
> >   btrfs: use cached state when looking for delalloc ranges with lseek
> >
> >  fs/btrfs/ctree.h          |   1 +
> >  fs/btrfs/extent-io-tree.c |  73 +++++++++++--
> >  fs/btrfs/extent-io-tree.h |  10 +-
> >  fs/btrfs/extent_io.c      |  30 +++---
> >  fs/btrfs/extent_map.c     |  29 -----
> >  fs/btrfs/extent_map.h     |   2 -
> >  fs/btrfs/file.c           | 221 ++++++++++++++++++--------------------
> >  fs/btrfs/file.h           |   1 +
> >  fs/btrfs/inode.c          |   2 +-
> >  9 files changed, 190 insertions(+), 179 deletions(-)
> >
> > --
> > 2.35.1
> >
