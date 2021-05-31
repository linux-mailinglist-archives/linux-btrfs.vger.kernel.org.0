Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1C5395FC4
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhEaOQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 10:16:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:47080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232577AbhEaONY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 10:13:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622470301;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4kTvqI/U6UNtgbz2HkdiHJG3zZQ6gYVBXErQROGA/6U=;
        b=mjWzLGR/Jnvb3cjbn6dMWECWzejNusmmo2TlT1CStkB6HtTbK+d985Li9MiVYSif5u4nnb
        YTRQInZ6MMeMnaBdxrKHt9Bm3yWRV5DY7KPyKZcGaLn17vpUh76PBjLQFR50fkVHKzVgNe
        tblMgGTRi79xZn6TjBYqO5ODqk3GeXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622470301;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4kTvqI/U6UNtgbz2HkdiHJG3zZQ6gYVBXErQROGA/6U=;
        b=N1TLlUSo/ta+4s9gAvkN6zVg/kDLOfgFDvWCeQc8U6vlhfsZJehWyW09lBWPtF6+yho2pb
        zFCnG2OvUPkjyWAw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8521B4D1;
        Mon, 31 May 2021 14:11:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 47090DA70B; Mon, 31 May 2021 16:09:02 +0200 (CEST)
Date:   Mon, 31 May 2021 16:09:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
Message-ID: <20210531140902.GD14136@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210531085106.259490-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531085106.259490-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 31, 2021 at 04:50:36PM +0800, Qu Wenruo wrote:
> This huge patchset can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
> 
> === Current stage ===
> The tests on x86 pass without new failure, and generic test group on
> arm64 with 64K page size passes except known failure and defrag group.
> 
> For btrfs test group, all pass except compression/raid56/defrag.
> 
> For anyone who is interested in testing, please apply this patch for
> btrfs-progs before testing.
> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.243715-1-wqu@suse.com/
> Or there will be too many false alerts.

This patch has been merged to progs 5.12.
> 
> === Limitation ===
> There are several limitations introduced just for subpage:
> - No compressed write support
>   Read is no problem, but compression write path has more things left to
>   be modified.
>   Thus for current patchset, no matter what inode attribute or mount
>   option is, no new compressed extent can be created for subpage case.
> 
> - No inline extent will be created
>   This is mostly due to the fact that filemap_fdatawrite_range() will
>   trigger more write than the range specified.
>   In fallocate calls, this behavior can make us to writeback which can
>   be inlined, before we enlarge the isize, causing inline extent being
>   created along with regular extents.
> 
> - No support for RAID56
>   There are still too many hardcoded PAGE_SIZE in raid56 code.
>   Considering it's already considered unsafe due to its write-hole
>   problem, disabling RAID56 for subpage looks sane to me.
> 
> - No defrag support for subpage
>   The support for subpage defrag has already an initial version
>   submitted to the mail list.
>   Thus the correct support won't be included in this patchset.
> 
> === Patchset structure ===
> 
> Patch 01~19:	Make data write path to be subpage compatible

We can chop the first series batch again as this is still preparatory
and we need to make sure it does not interfere with other patches.
