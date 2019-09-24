Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2CBCA81
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbfIXOpY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:45:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:51342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfIXOpY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:45:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAD24AF10;
        Tue, 24 Sep 2019 14:45:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 96C16DA835; Tue, 24 Sep 2019 16:45:42 +0200 (CEST)
Date:   Tue, 24 Sep 2019 16:45:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/7] btrfs: workqueue fixes+cleanups
Message-ID: <20190924144542.GW2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1568658527.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568658527.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 16, 2019 at 11:30:51AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hello,
> 
> This series fixes a few issues with Btrfs' use of workqueues.
> 
> The bulk of this series fixes multiple cases of the same bug: a work
> item shouldn't be freed while it potentially depends on any other work
> items. Currently, we've mostly been side-stepping this issue by having
> different work functions for different work types (see commit
> 9e0af2376434 ("Btrfs: fix task hang under heavy compressed write").
> However, there are cases where a work function can depend on itself,
> usually through stacked filesystems (e.g., loop devices).
> 
> Patch 1 is a trivial cleanup.
> 
> Patches 2-5 fix all of the cases of this bug that I could find. Patch 2
> is the ordered_free fix I previously sent [1], now with an updated title
> and Josef's fix [2] folded in. Patch 3 fixes the deadlock reported with
> my previous cleanup, and patches 4 and 5 fix similar issues.
> 
> With all of those fixed, patch 6 is my previous cleanup [3] to get rid
> of the different work functions. Patch 7 is the same cleanup [4] as from
> before.
> 
> Based on misc-next.
> 
> Thanks!
> 
> 1: https://lore.kernel.org/linux-btrfs/0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com/
> 2: https://lore.kernel.org/linux-btrfs/20190821151803.cuyq2yzpdnwgwrmb@MacBook-Pro-91.local/
> 3: https://lore.kernel.org/linux-btrfs/afaf532af471dd1a8a1f4af9de570127529323b0.1565717248.git.osandov@fb.com/
> 4: https://lore.kernel.org/linux-btrfs/d4fa1870ffce027ada265a67f4e00d397b683241.1565717248.git.osandov@fb.com/
> 
> Omar Sandoval (7):
>   btrfs: get rid of unnecessary memset() of work item
>   btrfs: don't prematurely free work in run_ordered_work()
>   btrfs: don't prematurely free work in end_workqueue_fn()
>   btrfs: don't prematurely free work in reada_start_machine_worker()
>   btrfs: don't prematurely free work in scrub_missing_raid56_worker()
>   btrfs: get rid of unique workqueue helper functions
>   btrfs: get rid of pointless wtag variable in async-thread.c

Added to misc-next, thanks.
