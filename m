Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8A3283E7
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 17:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhCAQ1Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 11:27:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:53460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232065AbhCAQY6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 11:24:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8310AE14;
        Mon,  1 Mar 2021 16:24:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3AC84DA7AA; Mon,  1 Mar 2021 17:22:19 +0100 (CET)
Date:   Mon, 1 Mar 2021 17:22:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: support read-write for subpage metadata
Message-ID: <20210301162219.GW7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210222063357.92930-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222063357.92930-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 22, 2021 at 02:33:45PM +0800, Qu Wenruo wrote:
> This patchset can be fetched from the following github repo, along with
> the full subpage RW support:
> https://github.com/adam900710/linux/tree/subpage
> 
> This patchset is for metadata read write support.

I've skimmed the patches, it's adding further helpers and special cases
for subpage (but I could have missed something). From that I think it's
ok to add it to for-next for some test coverage, but rather to make sure
the subpage changes do not bleed to the regular case.

> [TEST]
> Since the data write path is not included in this patchset, we can't
> really test it, but during the lunar new year vocation, I have tested
> the full RW patchset with "fstresss -n 10000 -p2" on my Aarch64 board.
> 
> And the full RW patchset survives without any crash for a full week.
> 
> There is only one remaining bug exposed during the test, that we have
> random data checksum mismatch, which is still under investigation.
> 
> But the metadata part should be OK for submission.
> 
> [DIFFERENCE AGAINST REGULAR SECTORSIZE]
> The metadata part in fact has more new code than data part, as it has
> some different behaviors compared to the regular sector size handling:
> 
> - No more page locking
>   Now metadata read/write relies on extent io tree locking, other than
>   page locking.
>   This is to allow behaviors like read lock one eb while also try to
>   read lock another eb in the same page.
>   We can't rely on page lock as now we have multiple extent buffers in
>   the same page.
> 
> - Page status update
>   Now we use subpage wrappers to handle page status update.
> 
> - How to submit dirty extent buffers
>   Instead of just grabbing extent buffer from page::private, we need to
>   iterate all dirty extent buffers in the page and submit them.

I'm not sure if all this information is also preserved in some comments,
if not it definitely should.
