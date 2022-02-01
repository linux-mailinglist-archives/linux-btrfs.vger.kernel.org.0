Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC884A5EEF
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 16:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbiBAPDv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 10:03:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49984 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiBAPDu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 10:03:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2173C1F37C;
        Tue,  1 Feb 2022 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643727830;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXdT0UryavYdRVbfBplciZI3/DfX21vWqjTM29rGsIY=;
        b=l63n9L8zxSOxefLa2ghGKxLufeUdqPSR+z5cfhbhHqza6IBZUnb8gQS0oDUmLWyiK6wgC6
        EBcJnFCO9QCf+f8aKawSqvRwvsly+4vlOv6qvD80h7lT8x8a5ps7jwC+R8qmclUl1CB6PV
        24/hNx7PwoGAg6Je+V39fQzZkFTo0js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643727830;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXdT0UryavYdRVbfBplciZI3/DfX21vWqjTM29rGsIY=;
        b=VkNqQ6rPSPplHpQ/gnIsqq7eaJObQLb/6ULoXulojG44vW9V3TqdMtMdhPTc3FGrn/9sly
        GOvfUq/RiHXhiIDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1ADE5A3B8C;
        Tue,  1 Feb 2022 15:03:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21078DA7A9; Tue,  1 Feb 2022 16:03:05 +0100 (CET)
Date:   Tue, 1 Feb 2022 16:03:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v4 2/3] btrfs: defrag: don't defrag extents which is
 already at its max capacity
Message-ID: <20220201150305.GQ14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1643354254.git.wqu@suse.com>
 <6da08401ba111e490c45c64fba3f9f60538d0fb8.1643354254.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da08401ba111e490c45c64fba3f9f60538d0fb8.1643354254.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 03:21:21PM +0800, Qu Wenruo wrote:
> [BUG]
> For compressed extents, defrag ioctl will always try to defrag any
> compressed extents, wasting not only IO but also CPU time to
> compress/decompress:
> 
>    mkfs.btrfs -f $DEV
>    mount -o compress $DEV $MNT
>    xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/foobar
>    sync
>    xfs_io -f -c "pwrite -S 0xcd 128K 128K" $MNT/foobar
>    sync
>    echo "=== before ==="
>    xfs_io -c "fiemap -v" $MNT/foobar
>    btrfs filesystem defrag $MNT/foobar
>    sync
>    echo "=== after ==="
>    xfs_io -c "fiemap -v" $MNT/foobar
> 
> Then it shows the 2 128K extents just get CoW for no extra benefit, with
> extra IO/CPU spent:
> 
>     === before ===
>     /mnt/btrfs/file1:
>      EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>        0: [0..255]:        26624..26879       256   0x8
>        1: [256..511]:      26632..26887       256   0x9
>     === after ===
>     /mnt/btrfs/file1:
>      EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>        0: [0..255]:        26640..26895       256   0x8
>        1: [256..511]:      26648..26903       256   0x9
> 
> This affects not only v5.16 (after the defrag rework), but also v5.15
> (before the defrag rework).
> 
> [CAUSE]
> >From the very beginning, btrfs defrag never checks if one extent is
> already at its max capacity (128K for compressed extents, 128M
> otherwise).
> 
> And the default extent size threshold is 256K, which is already beyond
> the compressed extent max size.
> 
> This means, by default btrfs defrag ioctl will mark all compressed
> extent which is not adjacent to a hole/preallocated range for defrag.

Is this wrong for all cases though? With your change compressed extents
would never get defragmented, while the defragmentation ioctl allows to
change the compression algorithm, so that's a loss of functionality.

And I think we can't do that even conditionally if the algorithm is
different, because what if we want to recompress a file with higher
level of the same algorithm? As the level not stored anywhere the defrag
ioctl can't decide which extents to skip to save work.
