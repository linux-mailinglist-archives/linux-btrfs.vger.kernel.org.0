Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A74545D680
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 09:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353643AbhKYIzn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 03:55:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52692 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344142AbhKYIxk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 03:53:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DA6431FD37;
        Thu, 25 Nov 2021 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637830228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEBgH8D7dSK1MMh5NMF1Zx26gwHwT+r8CY9O1nUgP/0=;
        b=OQB852I6+yyrMxvlNqd/iT6ZW1h1ewmANbruHvYk9bNA+wDxlAoFhjiI+14OYtueua17Qy
        qBOmON7Ro3/vwQFNcTu49i70TroBwwfmlnIGFWg/5zGLTrQikVVdQHRYau8+4RD3IijeIC
        LSBwA20c3yohG6l1frWZnQLXn8YmPNI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A479B13F5A;
        Thu, 25 Nov 2021 08:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EdqZJVROn2EdegAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 25 Nov 2021 08:50:28 +0000
Subject: Re: [PATCH 1/2] btrfs: clear extent buffer uptodate when we fail to
 write it
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1637775291.git.josef@toxicpanda.com>
 <9d6f5682aeb573b58009a17dc4d2ab19a264db73.1637775291.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <519fc78c-4da4-e446-9cca-eada604e48c2@suse.com>
Date:   Thu, 25 Nov 2021 10:50:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9d6f5682aeb573b58009a17dc4d2ab19a264db73.1637775291.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.11.21 г. 19:37, Josef Bacik wrote:
> I got dmesg errors on generic/281 on our overnight xfstests.  Looking at
> the history this happens occasionally, with errors like this
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 673217 at fs/btrfs/extent_io.c:6848 assert_eb_page_uptodate+0x3f/0x50
> CPU: 0 PID: 673217 Comm: kworker/u4:13 Tainted: G        W         5.16.0-rc2+ #469
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> Workqueue: btrfs-cache btrfs_work_helper
> RIP: 0010:assert_eb_page_uptodate+0x3f/0x50
> RSP: 0018:ffffae598230bc60 EFLAGS: 00010246
> RAX: 0017ffffc0002112 RBX: ffffebaec4100900 RCX: 0000000000001000
> RDX: ffffebaec45733c7 RSI: ffffebaec4100900 RDI: ffff9fd98919f340
> RBP: 0000000000000d56 R08: ffff9fd98e300000 R09: 0000000000000000
> R10: 0001207370a91c50 R11: 0000000000000000 R12: 00000000000007b0
> R13: ffff9fd98919f340 R14: 0000000001500000 R15: 0000000001cb0000
> FS:  0000000000000000(0000) GS:ffff9fd9fbc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f549fcf8940 CR3: 0000000114908004 CR4: 0000000000370ef0
> Call Trace:
> 
>  extent_buffer_test_bit+0x3f/0x70
>  free_space_test_bit+0xa6/0xc0
>  load_free_space_tree+0x1d6/0x430
>  caching_thread+0x454/0x630
>  ? rcu_read_lock_sched_held+0x12/0x60
>  ? rcu_read_lock_sched_held+0x12/0x60
>  ? rcu_read_lock_sched_held+0x12/0x60
>  ? lock_release+0x1f0/0x2d0
>  btrfs_work_helper+0xf2/0x3e0
>  ? lock_release+0x1f0/0x2d0
>  ? finish_task_switch.isra.0+0xf9/0x3a0
>  process_one_work+0x270/0x5a0
>  worker_thread+0x55/0x3c0
>  ? process_one_work+0x5a0/0x5a0
>  kthread+0x174/0x1a0
>  ? set_kthread_struct+0x40/0x40
>  ret_from_fork+0x1f/0x30
> 
> This happens because we're trying to read from a extent buffer page that
> is !PageUptodate.  This happens because we will clear the page uptodate
> when we have an IO error, but we don't clear the extent buffer uptodate.
> If we do a read later and find this extent buffer we'll think its valid
> and not return an error, and then trip over this warning.
> 
> Fix this by also clearing uptodate on the extent buffer when this
> happens, so that we get an error when we do a btrfs_search_slot() and
> find this block later.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent_io.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b289d26aca0d..3454cac28389 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4308,6 +4308,12 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
>  	if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
>  		return;
>  
> +	/*
> +	 * A read may stumble upon this buffer later, make sure that it gets an
> +	 * error and knows there was an error.
> +	 */
> +	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);


Is it sufficient to set the flag only on the extent buffer, what about
using clear_extent_buffer_uptodate so that constituent pages also get
their UPTODATE cleared?

Also I can't help but think can't we get rid of the BUFFER_WRITE_ERR
because an error during write is signaled by both !UPTODATE and
BUFFER_WRITE_ERR being set.

Looking at the various call sites of set_btree_ioerr they'd call
set_btree_ioerr when the bio has errored out or if
EXTENT_BUFFER_WRITE_ERR is set but in the latter case set_btree_ioerr is
a noop due to the test_and_set_bit() call in set_btree_ioerr.

> +
>  	/*
>  	 * If we error out, we should add back the dirty_metadata_bytes
>  	 * to make it consistent.
> 
