Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382964A5FDD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 16:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbiBAPSu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 10:18:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57400 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiBAPSu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 10:18:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 196E021108;
        Tue,  1 Feb 2022 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643728729;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rZ3N26C6Y+z+vfR6gzm2Jo7FEz/XOM8q649aUk/v/GU=;
        b=WOvZpG/8YV+/f47lgTV0iQHpQbG2rgZzjhvmBYTg/qeQAO6TeugDgKy9+H6BKIbJ7pM41m
        /tIhYHLPCoY7tfevnmRjzKBZV1tfoL+AINBeh9eUffjAcl/YDkFhCzLDFbHF/rk2BpEfUW
        dGllmW2414OdgxpPHCN3WZ9tvg3Pd5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643728729;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rZ3N26C6Y+z+vfR6gzm2Jo7FEz/XOM8q649aUk/v/GU=;
        b=I4ep7D4r0xbhTAgYMOMMqti2pO/FJo8qTjYmEcwPxAznZU1419cGYQ/GqcceeTL3GWibFU
        ODeZp52jRvUMZwBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0E8ADA3B83;
        Tue,  1 Feb 2022 15:18:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 149EDDA7A9; Tue,  1 Feb 2022 16:18:04 +0100 (CET)
Date:   Tue, 1 Feb 2022 16:18:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add test case to make sure autodefrag won't give
 up the whole cluster when there is a hole in it
Message-ID: <20220201151804.GS14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20220127054543.28964-1-wqu@suse.com>
 <YfKAr3AaFpzmY0LX@debian9.Home>
 <f76aed97-42a7-ae3e-c7e4-cdbbd2d001c8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f76aed97-42a7-ae3e-c7e4-cdbbd2d001c8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 07:32:53AM +0800, Qu Wenruo wrote:
> On 2022/1/27 19:23, Filipe Manana wrote:
> > On Thu, Jan 27, 2022 at 01:45:43PM +0800, Qu Wenruo wrote:
> >> +get_extent_disk_sector()
> >> +{
> >> +	local file=$1
> >> +	local offset=$2
> >> +
> >> +	$XFS_IO_PROG -c "fiemap $offset" "$file" | _filter_xfs_io_fiemap |\
> >> +		head -n1 | $AWK_PROG '{print $3}'
> >> +}
> >> +
> >> +# Needs 4K sectorsize, as larger sectorsize can change the file layout.
> >> +_require_btrfs_support_sectorsize 4096
> >> +
> >> +# We need a way to trigger autodefrag
> >> +_require_btrfs_debug_cleaner_trigger
> >
> > In order to trigger the cleaner, we don't need another special purpose
> > RFC debug patch.
> >
> > Just mount the fs with "-o commit=1", and then leave the "sleep 3" as it
> > is. We do this in other tests that expect the cleaner thread to do
> > something. Every time the transaction kthread wakes up, it will wake up
> > the cleaner kthread, even if it doesn't have any transaction to commit.
> 
> Right! That's way better than the RFC patch.

Also the BTRFS_IOC_SYNC ioctl (available as "btrfs filesystem sync")
will wake the transaction kthread.
