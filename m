Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F08493EEC
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jan 2022 18:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356351AbiASRTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jan 2022 12:19:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39608 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345023AbiASRTK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jan 2022 12:19:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E33CF210E3;
        Wed, 19 Jan 2022 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642612749;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qr3lKCeYxye9q/z77j3tCUG8B+Qopypg3DmRU7ZmcSk=;
        b=tgW2CInriKMXcfFf5dWLbpws1wqPAkhAjYlW65+kG6c8+wkEeNUrFAvfIyL/vLwI+Mm4L/
        pFcky1uk8Fgg4Uamb9QlVeaa6JmBLZCy5eulAAQC1PdDMaBB24VGkjDE9hIKo7Td80HbSI
        eJE9f3tyPwPb2VcZOP2jYqLKmnjBw9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642612749;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qr3lKCeYxye9q/z77j3tCUG8B+Qopypg3DmRU7ZmcSk=;
        b=k2268ywc8SmgG+YYD/stYnRRzpl/+l2+2E6mUwnuOHOeX0MuOmU/JhdxQ3O382XA3LANdW
        bjdo996RI4dar7Bw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DCDF6A3B87;
        Wed, 19 Jan 2022 17:19:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7EF55DA7A3; Wed, 19 Jan 2022 18:18:32 +0100 (CET)
Date:   Wed, 19 Jan 2022 18:18:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anthony Ruhier <aruhier@mailbox.org>
Subject: Re: [PATCH v2] btrfs: defrag: fix the wrong number of defragged
 sectors
Message-ID: <20220119171832.GQ14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Anthony Ruhier <aruhier@mailbox.org>
References: <20220118071904.29991-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118071904.29991-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 18, 2022 at 03:19:04PM +0800, Qu Wenruo wrote:
> [BUG]
> There are users using autodefrag mount option reporting obvious increase
> in IO:
> 
> > If I compare the write average (in total, I don't have it per process)
> > when taking idle periods on the same machine:
> >     Linux 5.16:
> >         without autodefrag: ~ 10KiB/s
> >         with autodefrag: between 1 and 2MiB/s.
> >
> >     Linux 5.15:
> >         with autodefrag:~ 10KiB/s (around the same as without
> > autodefrag on 5.16)
> 
> [CAUSE]
> When autodefrag mount option is enabled, btrfs_defrag_file() will be
> called with @max_sectors = BTRFS_DEFRAG_BATCH (1024) to limit how many
> sectors we can defrag in one try.
> 
> And then use the number of sectors defragged to determine if we need to
> re-defrag.
> 
> But commit b18c3ab2343d ("btrfs: defrag: introduce helper to defrag one
> cluster") uses wrong unit to increase @sectors_defragged, which should
> be in unit of sector, not byte.
> 
> This means, if we have defragged any sector, then @sectors_defragged
> will be >= sectorsize (normally 4096), which is larger than
> BTRFS_DEFRAG_BATCH.
> 
> This makes the @max_sectors check in defrag_one_cluster() to underflow,
> rendering the whole @max_sectors check useless.
> 
> Thus causing way more IO for autodefrag mount options, as now there is
> no limit on how many sectors can really be defragged.
> 
> [FIX]
> Fix the problems by:
> 
> - Use sector as unit when increaseing @sectors_defragged
> 
> - Include @sectors_defragged > @max_sectors case to break the loop
> 
> - Add extra comment on the return value of btrfs_defrag_file()
> 
> Reported-by: Anthony Ruhier <aruhier@mailbox.org>
> Fixes: b18c3ab2343d ("btrfs: defrag: introduce helper to defrag one cluster")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
