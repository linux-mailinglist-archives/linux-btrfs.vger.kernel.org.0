Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAFF5F9C25
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 11:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiJJJmZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiJJJmY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 05:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707F869F6E
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 02:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF64560EA9
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 09:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCC4C433D6;
        Mon, 10 Oct 2022 09:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665394941;
        bh=x9tkJmID/y9itlleFumg+spjTwxgIm3haRg7vfJRAPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9fPcX7fsWMADtb6HR6mzOu4ks4MOtKXjAfw1L7sTbYFr5E/ohkgKeyD7bkwqNRRs
         wcI/QwhS2sBMvhmPW8nEfJdTLZy1Sai5fERIUkB8BXlXsBnJYf3R5LkPVuAW0Z7tCT
         uCoj4jJ1Nu4riXJUlSBt7n5Hlm558akQSgN91aEKBEISL4zES5I0LR4hZ14WotJqat
         tpbQOiChdpWL90XlXTjoGUmdb5RxpJY+btk4Mw6F+jIe5o2TriQE8FJ++zPh7A/S/V
         iS2E0FytAc84PzMsLrXVK6dpXJpnfLOUx6boOHlUXXGEj4qftjTrKsaV3D/ZFg9c0i
         mC1Q1HegLTmGA==
Date:   Mon, 10 Oct 2022 10:42:18 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Glenn Washburn <development@efficientek.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs send/receive not always sharing extents
Message-ID: <20221010094218.GA2141122@falcondesktop>
References: <20221008005704.795b44b0@crass-HP-ZBook-15-G2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008005704.795b44b0@crass-HP-ZBook-15-G2>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 08, 2022 at 12:57:04AM -0500, Glenn Washburn wrote:
> I've got two reflinked files in a subvol that I'm sending/receiving to
> a different btrfs filesystem and they are not sharing extents on the
> receiving side. Other reflinked files in the same subvol are being
> reflinked on the receive side. The send side has a fairly old creation
> date if that matters. Attached is the receive log and a diff of
> filefrag's output for the files on the source volume to show that the
> two files (IMG_20200402_143055.dng and IMG_20200402_143055.dng.ref) are
> refinked on the source volume. This is a somewhat minimal example of
> what's happening on a big send that I'm doing that is failing because
> the receive side it too small to hold data when the reflinks are
> broken. Is this a bug? or what can I do to get send to see these files
> are reflinked?

send/receive only guarantees that the destination ends up with the same
data as the source.

It doesn't guarantee extents are always shared as in the source filesystem,
that the extent layout is the same, or holes are preserved for example.

There are two main reasons why extents don't often get cloned during
send/receive:

1) The extent is shared more than 64 times in the source filesystem.
   We have this limitation because figuring out all inodes/roots that
   share an extent can be expensive, and therefore massively slowdown
   send operations.

2) Even when an extent is shared less than 64 times in the source
   filesystem, we often don't clone the entirety of an extent and end up
   issuing write operations for the remaining part(s). This is due to
   algorithmic complexity as well, as identifying the best source for
   cloning an extent can be expensive and considerably slowdown send
   operations.

I have some work in progress and ideas to speedup send in some cases,
but I'm afraid we'll always have some limitations - in the best case
we can improve on them, but not eliminate them completely.

You can run a dedupe tool on the destination filesystem to get the
extents shared.

> 
> Glenn

> --- /dev/fd/63	2022-10-08 00:31:46.783138591 -0500
> +++ /dev/fd/62	2022-10-08 00:31:46.787138126 -0500
> @@ -1,5 +1,5 @@
>  Filesystem type is: 9123683e
> -File size of /media/test-btrfs/test/1.ro/IMG_20200402_143055.dng is 24674116 (6024 blocks of 4096 bytes)
> +File size of /media/test-btrfs/test/1.ro/IMG_20200402_143055.dng.ref is 24674116 (6024 blocks of 4096 bytes)
>   ext:     logical_offset:        physical_offset: length:   expected: flags:
>     0:        0..    6023: 1131665768..1131671791:   6024:             last,shared,eof
> -/media/test-btrfs/test/1.ro/IMG_20200402_143055.dng: 1 extent found
> +/media/test-btrfs/test/1.ro/IMG_20200402_143055.dng.ref: 1 extent found


