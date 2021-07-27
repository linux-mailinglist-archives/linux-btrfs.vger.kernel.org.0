Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A891B3D72EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhG0KRy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:17:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37602 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbhG0KRy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:17:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C913422186;
        Tue, 27 Jul 2021 10:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627381073;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4mcrNqb+b2oF2YjDIVV+R4msZXTUJTbehNMzziO55Bk=;
        b=HspGhS1uKy6rIK6nsFLMqtGDLRlnvmNXj7+zDpvqgUdTxWy8kDUaksaNSfDJtLBAnggMeo
        RCDwKMSTPbJL4I3vIoa4xsfasLfTifvr2+UCeWs37/c1PWcaK9BdlxiTk5UAWYMBbQp+/X
        ySVZ2qsOMNXLGk4XqZXp5X+lZ3xh4DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627381073;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4mcrNqb+b2oF2YjDIVV+R4msZXTUJTbehNMzziO55Bk=;
        b=N9coNHNAS6df1nT34IDY75SHlzzkzfuEYp1Laq1aKhpxri5Rn7cQAz3aQaZMdlkk+dU8Mz
        0Cfyxh95uCgWBQCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C2CFFA3B84;
        Tue, 27 Jul 2021 10:17:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75204DA8CC; Tue, 27 Jul 2021 12:15:09 +0200 (CEST)
Date:   Tue, 27 Jul 2021 12:15:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove the unused @start and @end parameter for
 btrfs_run_delalloc_range()
Message-ID: <20210727101509.GP5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210727054132.164462-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727054132.164462-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 01:41:32PM +0800, Qu Wenruo wrote:
> Since commit d75855b4518b ("btrfs: Remove
> extent_io_ops::writepage_start_hook") removes the writepage_start_hook()
> and added btrfs_writepage_cow_fixup() function, there is no need to
> follow the old hook parameters.
> 
> This patch just remove the @start and @end hook, since currently the
> fixup check is full page check, it doesn't need @start and @end hook.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Then at least start can be removed from __extent_writepage_io too with
the following

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3828,9 +3828,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
                                 int *nr_ret)
 {
        struct btrfs_fs_info *fs_info = inode->root->fs_info;
-       u64 start = page_offset(page);
-       u64 end = start + PAGE_SIZE - 1;
-       u64 cur = start;
+       u64 cur = page_offset(page);
+       u64 end = cur + PAGE_SIZE - 1;
        u64 extent_offset;
        u64 block_start;
        struct extent_map *em;
---

There's no warning because start is set and used.
