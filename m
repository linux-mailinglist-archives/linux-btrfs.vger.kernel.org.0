Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B500E3ED4DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 15:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhHPNFr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 09:05:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48088 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbhHPNFc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 09:05:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 281C421ADD;
        Mon, 16 Aug 2021 13:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629119100;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hI025OVT3wc2r744FvXDKVsj5mV8jY2bQLWMP5jriow=;
        b=wjeXDcxQb/BXkoXSUBmW/bCoZwXfDPIJCKiZMxX5i+aOdi/V0ZJuMregtX2oI7q8a9nzsn
        y2RLl5LVXfSfNncdXgzs/W7aENI0uSHYzRxnmzdeFY8WIJ0aDHh3kod5U7WBgcg7KNXYTx
        kkX+AyCgWi9csDs8BGM3lU7GLoQlYlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629119100;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hI025OVT3wc2r744FvXDKVsj5mV8jY2bQLWMP5jriow=;
        b=E2Cio/R2iKU0KrX767/C/N6Zjzrprz0E+dKKs5DN+e25ikcoIYLeFw6CaMkEIXLCX3KJ1p
        ievNM0M0dyJbufBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 21671A3B94;
        Mon, 16 Aug 2021 13:05:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6AE5FDA72C; Mon, 16 Aug 2021 15:02:04 +0200 (CEST)
Date:   Mon, 16 Aug 2021 15:02:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid unnecessarily logging directories that had
 no changes
Message-ID: <20210816130204.GZ5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <ffa14771bb6d672a2a74d92625bd024013b3f8ce.1627580467.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa14771bb6d672a2a74d92625bd024013b3f8ce.1627580467.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 29, 2021 at 06:52:46PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are several cases where when logging an inode we need to log its
> parent directories or logging subdirectories when logging a directory.
> 
> There are cases however where we end up logging a directory even if it was
> not changed in the current transaction, no dentries added or removed since
> the last transaction. While this is harmless from a functional point of
> view, it is a waste time as it brings no advantage.
> 
> One example where this is triggered is the following:
> 
>   $ mkfs.btrfs -f /dev/sdc
>   $ mount /dev/sdc /mnt
> 
>   $ mkdir /mnt/A
>   $ mkdir /mnt/B
>   $ mkdir /mnt/C
> 
>   $ touch /mnt/A/foo
>   $ ln /mnt/A/foo /mnt/B/bar
>   $ ln /mnt/A/foo /mnt/C/baz
> 
>   $ sync
> 
>   $ rm -f /mnt/A/foo
>   $ xfs_io -c "fsync" /mnt/B/bar
> 
> This last fsync ends up logging directories A, B and C, however we only
> need to log directory A, as B and C were not changed since the last
> transaction commit.
> 
> So fix this by changing need_log_inode(), to return false in case the
> given inode is a directory and has a ->last_trans value smaller than the
> current transaction's ID.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
