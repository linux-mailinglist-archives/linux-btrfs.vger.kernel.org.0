Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8D2C281B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 23:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfI3VDu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 17:03:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:47568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732102AbfI3VDu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 17:03:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F5FFAC2E;
        Mon, 30 Sep 2019 17:34:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 921CADA88C; Mon, 30 Sep 2019 19:34:23 +0200 (CEST)
Date:   Mon, 30 Sep 2019 19:34:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][v3] btrfs: use refcount_inc_not_zero in kill_all_nodes
Message-ID: <20190930173423.GA2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190926122932.7369-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926122932.7369-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 26, 2019 at 08:29:32AM -0400, Josef Bacik wrote:
> We hit the following warning while running down a different problem
> 
> [ 6197.175850] ------------[ cut here ]------------
> [ 6197.185082] refcount_t: underflow; use-after-free.
> [ 6197.194704] WARNING: CPU: 47 PID: 966 at lib/refcount.c:190 refcount_sub_and_test_checked+0x53/0x60
> [ 6197.521792] Call Trace:
> [ 6197.526687]  __btrfs_release_delayed_node+0x76/0x1c0
> [ 6197.536615]  btrfs_kill_all_delayed_nodes+0xec/0x130
> [ 6197.546532]  ? __btrfs_btree_balance_dirty+0x60/0x60
> [ 6197.556482]  btrfs_clean_one_deleted_snapshot+0x71/0xd0
> [ 6197.566910]  cleaner_kthread+0xfa/0x120
> [ 6197.574573]  kthread+0x111/0x130
> [ 6197.581022]  ? kthread_create_on_node+0x60/0x60
> [ 6197.590086]  ret_from_fork+0x1f/0x30
> [ 6197.597228] ---[ end trace 424bb7ae00509f56 ]---
> 
> This is because the free side drops the ref without the lock, and then
> takes the lock if our refcount is 0.  So you can have nodes on the tree
> that have a refcount of 0.

This sounds like breaking the assumptions of the refcounts, if the
object is in the tree it should not be accessible by anything else than
the freeing code, with refs == 0.

Now the delayed nodes do not follow that and there were bugs where the 0
was increased again (ec35e48b286959991c "btrfs: fix refcount_t usage
when deleting btrfs_delayed_nodes").

Your patch fixes another instance, I still see some other refcount_inc
that seem to be safe but the call to refcount_inc_not_zero should have a
comment, like is in the mentioned commit.

> Fix this by zero'ing out that element in our
> temporary array so we don't try to kill it again.

The fix looks correct.
