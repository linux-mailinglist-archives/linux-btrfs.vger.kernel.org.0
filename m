Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBCF44E90A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 15:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhKLOh6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 09:37:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50658 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbhKLOh5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 09:37:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 454F721981;
        Fri, 12 Nov 2021 14:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636727706;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aSrrXX1B1TvaR3l7Q2fbXy9bSv2ciIyw7ukigrC/diw=;
        b=3JsJGWimxI6GMtLPNy6VINl6b2aSEstJjk+chBuGE4P38Ox56a71UQnDbc0eakLx7DgwuN
        nh5hHzCyiNunrADB303c/v0uOffM2AItdGyanSRQXAyzBENP+EbuBcBZ+0C8+a8o/KHm+R
        FTSk4hIznt4v+CJ6dX9TFIPGBa7IzvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636727706;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aSrrXX1B1TvaR3l7Q2fbXy9bSv2ciIyw7ukigrC/diw=;
        b=jBpDNOLobwNqBJPwON6afMyrNdS5N/0/leZAJd9CQEuILddL4S5OREVTu4Lnc21HtbXicI
        TSoAufJD7KJ9AsDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3B037A3B8E;
        Fri, 12 Nov 2021 14:35:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB02BDA781; Fri, 12 Nov 2021 15:35:04 +0100 (CET)
Date:   Fri, 12 Nov 2021 15:35:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] btrfs: fix a out-of-boundary access for
 copy_compressed_data_to_page()
Message-ID: <20211112143504.GI28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>
References: <20211112022253.20576-1-wqu@suse.com>
 <YY3qvDNC6S/YVrkZ@localhost.localdomain>
 <5424db53-a734-6fcf-6b1f-e2e11b50e624@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5424db53-a734-6fcf-6b1f-e2e11b50e624@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 12, 2021 at 12:41:37PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/11/12 12:17, Josef Bacik wrote:
> > On Fri, Nov 12, 2021 at 10:22:53AM +0800, Qu Wenruo wrote:
> >> [BUG]
> >> The following script can cause btrfs to crash:
> >>
> >>   mount -o compress-force=lzo $DEV /mnt
> >>   dd if=/dev/urandom of=/mnt/foo bs=4k count=1
> >>   sync
> >>
> >> The calltrace looks like this:
> >>
> >>   general protection fault, probably for non-canonical address 0xe04b37fccce3b000: 0000 [#1] PREEMPT SMP NOPTI
> >>   CPU: 5 PID: 164 Comm: kworker/u20:3 Not tainted 5.15.0-rc7-custom+ #4
> >>   Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
> >>   RIP: 0010:__memcpy+0x12/0x20
> >>   Call Trace:
> >>    lzo_compress_pages+0x236/0x540 [btrfs]
> >>    btrfs_compress_pages+0xaa/0xf0 [btrfs]
> >>    compress_file_range+0x431/0x8e0 [btrfs]
> >>    async_cow_start+0x12/0x30 [btrfs]
> >>    btrfs_work_helper+0xf6/0x3e0 [btrfs]
> >>    process_one_work+0x294/0x5d0
> >>    worker_thread+0x55/0x3c0
> >>    kthread+0x140/0x170
> >>    ret_from_fork+0x22/0x30
> >>   ---[ end trace 63c3c0f131e61982 ]---
> >>
> >> [CAUSE]
> >> In lzo_compress_pages(), parameter @out_pages is not only an output
> >> parameter (for the compressed pages), but also an input parameter, for
> >> the maximum amount of pages we can utilize.
> >>
> >> In commit d4088803f511 ("btrfs: subpage: make lzo_compress_pages()
> >> compatible"), the refactor doesn't take @out_pages as an input, thus
> >> completely ignoring the limit.
> >>
> >> And for compress-force case, we could hit incompressible data that
> >> compressed size would go beyond the page limit, and cause above crash.
> >>
> >> [FIX]
> >> Save @out_pages as @max_nr_page, and pass it to lzo_compress_pages(),
> >> and check if we're beyond the limit before accessing the pages.
> >>
> >> Reported-by: Omar Sandoval <osandov@fb.com>
> >> Fixes: d4088803f511 ("btrfs: subpage: make lzo_compress_pages() compatible")
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/lzo.c | 12 +++++++++++-
> >>   1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> >> index 00cffc183ec0..f410ceabcdbd 100644
> >> --- a/fs/btrfs/lzo.c
> >> +++ b/fs/btrfs/lzo.c
> >> @@ -125,6 +125,7 @@ static inline size_t read_compress_length(const char *buf)
> >>   static int copy_compressed_data_to_page(char *compressed_data,
> >>   					size_t compressed_size,
> >>   					struct page **out_pages,
> >> +					unsigned long max_nr_page,
> >
> > If you want to do const down below you should use const here probably?  Thanks,
> 
> Right, max_nr_page should also be const.

const for non-pointer parameters does not make much sense, it only
prevents reuse of the variable inside the function.
