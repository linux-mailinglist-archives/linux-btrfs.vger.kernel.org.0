Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B6453724
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Nov 2021 17:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhKPQUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Nov 2021 11:20:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44478 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhKPQUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Nov 2021 11:20:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CD1DD218B5;
        Tue, 16 Nov 2021 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637079438;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s9WSaUzKQB+MGHP2uMFi88IqwamPv+0/VujK5xyFNY0=;
        b=iCEKgl1C+xPkqzkrjLmr+4NudAcd7YjWB9D16FXT+hUJWGLv+1F6rCo2mqCrqjVEbIO7Mv
        pmCvj17rxMPyw684Mh9nW7+/khtQw9R+o6qH+0Mhe/KId8JMaiAsOFiRrgaAcR33xluGNt
        Z4vdX0PcRCtPhA+6eohqZ/KAhD65kZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637079438;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s9WSaUzKQB+MGHP2uMFi88IqwamPv+0/VujK5xyFNY0=;
        b=3e2sOjqIf0F7CTC94F4Y89psgvaijjdUQOv1gQuODlGmoyKU3rH8r/EIotHCF3SkwhoYZA
        of/k0x7jlk6SlXAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C60D9A3B83;
        Tue, 16 Nov 2021 16:17:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5A1E3DA799; Tue, 16 Nov 2021 17:17:15 +0100 (CET)
Date:   Tue, 16 Nov 2021 17:17:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v2] btrfs: fix a out-of-boundary access for
 copy_compressed_data_to_page()
Message-ID: <20211116161715.GR28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>
References: <20211112044730.25161-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112044730.25161-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 12, 2021 at 12:47:30PM +0800, Qu Wenruo wrote:
> [BUG]
> The following script can cause btrfs to crash:
> 
>  mount -o compress-force=lzo $DEV /mnt
>  dd if=/dev/urandom of=/mnt/foo bs=4k count=1
>  sync
> 
> The calltrace looks like this:
> 
>  general protection fault, probably for non-canonical address 0xe04b37fccce3b000: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 5 PID: 164 Comm: kworker/u20:3 Not tainted 5.15.0-rc7-custom+ #4
>  Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
>  RIP: 0010:__memcpy+0x12/0x20
>  Call Trace:
>   lzo_compress_pages+0x236/0x540 [btrfs]
>   btrfs_compress_pages+0xaa/0xf0 [btrfs]
>   compress_file_range+0x431/0x8e0 [btrfs]
>   async_cow_start+0x12/0x30 [btrfs]
>   btrfs_work_helper+0xf6/0x3e0 [btrfs]
>   process_one_work+0x294/0x5d0
>   worker_thread+0x55/0x3c0
>   kthread+0x140/0x170
>   ret_from_fork+0x22/0x30
>  ---[ end trace 63c3c0f131e61982 ]---
> 
> [CAUSE]
> In lzo_compress_pages(), parameter @out_pages is not only an output
> parameter (for the number of compressed pages), but also an input
> parameter, as the upper limit of compressed pages we can utilize.
> 
> In commit d4088803f511 ("btrfs: subpage: make lzo_compress_pages()
> compatible"), the refactor doesn't take @out_pages as an input, thus
> completely ignoring the limit.
> 
> And for compress-force case, we could hit incompressible data that
> compressed size would go beyond the page limit, and cause above crash.
> 
> [FIX]
> Save @out_pages as @max_nr_page, and pass it to lzo_compress_pages(),
> and check if we're beyond the limit before accessing the pages.
> 
> Reported-by: Omar Sandoval <osandov@fb.com>
> Fixes: d4088803f511 ("btrfs: subpage: make lzo_compress_pages() compatible")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Omar Sandoval <osandov@fb.com>

Added to misc-next and verified that it also fixes the 32bit crashes.
Pull request will be out by the end of the week so hopefully this will
be over.
