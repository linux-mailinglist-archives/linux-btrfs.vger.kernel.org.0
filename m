Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFCE6131734
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 19:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgAFSE0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 13:04:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:46360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFSE0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 13:04:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 97979AC9D;
        Mon,  6 Jan 2020 18:04:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F46EDA78B; Mon,  6 Jan 2020 19:04:14 +0100 (CET)
Date:   Mon, 6 Jan 2020 19:04:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: r
Message-ID: <20200106180413.GQ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200104135602.34601-1-wqu@suse.com>
 <b58caea4-476b-bf83-292d-ea71052bbea7@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b58caea4-476b-bf83-292d-ea71052bbea7@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 06, 2020 at 11:33:51AM -0500, Josef Bacik wrote:
> This took me a minute to figure out, but from what I can tell you are doing the 
> mb's around the BTRFS_ROOT_DEAD_RELOC_TREE flag so that in clean_dirty_subvols() 
> where we clear the bit and then set root->reloc_root = NULL we are sure to 
> either see the bit or that reloc_root == NULL.
> 
> That's fine, but man all these random memory barriers around the bit messing 
> make 0 sense and confuse the issue, what we really want is the 
> smp_mb__after_atomic() in clean_dirty_subvols() and the smp_mb__before_atomic() 
> in have_reloc_root().

The barriers around test_bit are required, test_bit could be reordered
as it's not a RMW operation. I suggest reding docs/atomic_t.rst on that
topic.

> But instead since we really want to know the right answer for root->reloc_root, 
> and we clear that _before_ we clear the BTRFS_ROOT_DEAD_RELOC_TREE let's just do 
> READ_ONCE/WRITE_ONCE everywhere we access the reloc_root.  In fact you could just do

But READ/WRITE_ONCE don't guarantee CPU-ordering, only that compiler
will not reload the variable in case it's used more than once.

> static struct btrfs_root get_reloc_root(struct btrfs_root *root)
> {
> 	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
> 		return NULL;
> 	return READ_ONCE(root->reloc_root);

Use of READ_ONCE has no effect here and produces the same buggy code as
we have now.

I sent the code to Qu in the previous discussion as work in progress,
with uncommented barriers, expecting that they will be documented in the
final version. So don't blame him, I should have not let barriers
reasoning left only on him. I'll comment under the patch.
