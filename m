Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFDB220F9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 16:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgGOOiN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 10:38:13 -0400
Received: from [195.135.220.15] ([195.135.220.15]:35696 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgGOOiN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 10:38:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FC60B643;
        Wed, 15 Jul 2020 14:38:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E92E8DA790; Wed, 15 Jul 2020 16:37:49 +0200 (CEST)
Date:   Wed, 15 Jul 2020 16:37:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/4] btrfs: handle signal interruption during
 relocation more gracefully
Message-ID: <20200715143749.GZ3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200713010322.18507-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713010322.18507-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 13, 2020 at 09:03:18AM +0800, Qu Wenruo wrote:
> This bug is reported by Hans van Kranenburg <hans@knorrie.org>, that
> when a running btrfs balance get fatal signals (including SIGINT), some
> bad things can happen, mostly forced RO caused by -EINTR.
> 
> It turns out that, although we have addressed the btrfs balance cancel
> problems, we haven't addressed the signal related problems.
> 
> In theory, processes trapped into kernel space won't get interrupted by
> signals, as signal callbacks happen in user space, but kernel code can
> still check pending signals and change behavior accordingly.
> 
> In this case, the culprit is that, wait_reserve_ticket() can return
> -EINTR if there is a pending fatal signal.
> 
> While for balance, a lot of situations can't handle the -EINTR from it,
> especially for critical cleanup phase.
> 
> This patchset will address the bug in two directions:
> - Catch fatal signal early
>   Now btrfs_should_cancel_balance() will also check pending signals.
>   And will exit gracefully and treat it as a canceled balance.

This should be safe as it's checked in known locations.

> - Don't allow -EINTR for critical cleanup
>   For btrfs_drop_snapshot() for reloc trees, we shouldn't be interrupted
>   by signal, thus we use btrfs_join_transaction() instead of
>   btrfs_start_transaction().

This one is a bit more scary, but the interruption has been there
already so we're not changing anything.

I haven't spotted anything obviously wrong so I'll add the patches to
misc-next, thanks.
