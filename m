Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFED9705AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 18:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfGVQsl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 12:48:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:43938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730026AbfGVQsl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 12:48:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B6D6AF41
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2019 16:48:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6F3F4DA882; Mon, 22 Jul 2019 18:49:15 +0200 (CEST)
Date:   Mon, 22 Jul 2019 18:49:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs-progs: tests: Make 64K page size system happier
Message-ID: <20190722164915.GA22308@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190705072651.25150-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705072651.25150-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 05, 2019 at 03:26:46PM +0800, Qu Wenruo wrote:
> Since I got another rockpro64, finally I could do some tests with
> aarch64 64K page size mode. (The first board is working as a NAS for
> a while)
> 
> Unsurprisingly there are several false test alerts in btrfs-progs
> selftests.
> 
> Although there is no existing CI service based on 64K page sized system,
> we'd better support for 64K page size as it's easier and easier to get
> SBC with good enough aarch64 SoC to compile kernel/btrfs-progs and run
> various tests on them.
> 
> The first patch fix a bug which mkfs can't accept any sector size on 64K
> page size system.
> 
> The remaining patches enhance test cases to make them work on 64K page
> size system (skip those tests unless kernel support subpage sized sector
> size)
> 
> Qu Wenruo (5):
>   btrfs-progs: mkfs: Apply the sectorsize user specified on 64k page
>     size system
>   btrfs-progs: fsck-tests: Check if current kernel can mount fs with
>     specified sector size
>   btrfs-progs: mkfs-tests: Skip 010-minimal-size if we can't mount with
>     4k sector size
>   btrfs-progs: misc-tests: Make test cases work or skipped on 64K page
>     size system
>   btrfs-progs: convert-tests: Skip tests if kernel doesn't support
>     subpage sized sector size

The fix is ok, but the test updates and pre-checks do not seem right to
me. The check_preerq helpers are for binaries and rather simple checks
unlike what the mkfs/mount test for 4k sectors does. I'll reply under
the patches with more specific comments.
