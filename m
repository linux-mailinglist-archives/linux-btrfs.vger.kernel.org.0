Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF970213BE5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 16:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgGCOgh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 10:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCOgh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 10:36:37 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 129632070B
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jul 2020 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593786996;
        bh=b1/N8UMcozrXit8DXnlbbDqoXSdM/BVXDr7U96tmaWE=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=mTA9xcyDavy5bGGO4k/W3xDszmT1y9z98dMUTvwnAdv/aVzmhR9VkM+iN8WUU+uM7
         tvLh0K5skReKLzvir20R8a/wLwkfrempPFFKh9fdDj841wfGAup8Z4Xc/MXxSZqIgY
         9kozn1tzmbx9GTHGocukPhKY59pKBAdF4QN8A56I=
Received: by mail-vs1-f49.google.com with SMTP id 64so10987095vsl.3
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jul 2020 07:36:36 -0700 (PDT)
X-Gm-Message-State: AOAM533oP8RGONmckF0E6MoyV9RtTDye4HaNaRlfOg9BqyKoC5SDOzpD
        4lgzhiucUKxK272nbIezwgcN4ISv3kaRS/kk1PY=
X-Google-Smtp-Source: ABdhPJzipZxsY0fVdPK8DXW+KazobrpRP97rWRksVaApv1gb4EibWUSOOnQZJ/ORebW69AVJ1M+GUMooeNwgLzD80Dg=
X-Received: by 2002:a67:f68a:: with SMTP id n10mr26373342vso.14.1593786995242;
 Fri, 03 Jul 2020 07:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200702113159.153135-1-fdmanana@kernel.org> <20200703120812.GY27795@twin.jikos.cz>
In-Reply-To: <20200703120812.GY27795@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 3 Jul 2020 15:36:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6WeSbAWHex=Meu+71Qahyeep4efCa9JLTAuj8ap95Mcw@mail.gmail.com>
Message-ID: <CAL3q7H6WeSbAWHex=Meu+71Qahyeep4efCa9JLTAuj8ap95Mcw@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: only commit the delayed inode when doing a
 full fsync
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 3, 2020 at 1:08 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Jul 02, 2020 at 12:31:59PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Commit 2c2c452b0cafdc ("Btrfs: fix fsync when extend references are added
> > to an inode") forced a commit of the delayed inode when logging an inode
> > in order to ensure we would end up logging the inode item during a full
> > fsync. By committing the delayed inode, we updated the inode item in the
> > fs/subvolume tree and then later when copying items from leafs modified in
> > the current transaction into the log tree (with copy_inode_items_to_log())
> > we ended up copying the inode item from the fs/subvolume tree into the log
> > tree. Logging an up to date version of the inode item is required to make
> > sure at log replay time we get the link count fixup triggered among other
> > things (replay xattr deletes, etc). The test case generic/040 from fstests
> > exercises the bug which that commit fixed.
> >
> > However for a fast fsync we don't need to commit the delayed inode because
> > we always log an up to date version of the inode item based on the struct
> > btrfs_inode we have in-memory. We started doing this for fast fsyncs since
> > commit e4545de5b035c7 ("Btrfs: fix fsync data loss after append write").
> >
> > So just stop committing the delayed inode if we are doing a fast fsync,
> > we are only wasting time and adding contention on fs/subvolume tree.
> >
> > This patch is part of a series that has the following patches:
> >
> > 1/4 btrfs: only commit the delayed inode when doing a full fsync
> > 2/4 btrfs: only commit delayed items at fsync if we are logging a directory
> > 3/4 btrfs: stop incremening log_batch for the log root tree when syncing log
> > 4/4 btrfs: remove no longer needed use of log_writers for the log root tree
> >
> > After the entire patchset applied I saw about 12% decrease on max latency
> > reported by dbench.
>
> That's impressive. Getting reliable perf improvements in the low
> percents is hard and 10+ is beyond expectations.

Well, I don't find it that impressive. Not that it isn't good, just
not that huge.
While the reported aggregated max latency decreases by around 12%, the
aggregated throughput only increased by around 1.2 to 1.5%, probably
just noise.

>
> As the patches are short I'd like to tag them for stable. The closest
> one that applies to all is 5.4, that I determined from the commit
> references in the changelogs. However I'd appreciate if you could take a
> look if it's worth to tag the patches for older stable trees where it
> applies (since 4.4). I don't have full overview of all the logging or
> fsync updates so might miss some dependency. Thanks.

Normally I don't count changes like these for stable, unless they fix
a significant performance regression.
But I don't oppose adding them to stable either, to whichever releases
they apply cleanly.

thanks
