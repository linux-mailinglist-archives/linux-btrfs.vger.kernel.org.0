Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCF2290722
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 16:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407660AbgJPO2G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 10:28:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:53672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407408AbgJPO2G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 10:28:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8342B1F7;
        Fri, 16 Oct 2020 14:28:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 723D6DA7C3; Fri, 16 Oct 2020 16:26:31 +0200 (CEST)
Date:   Fri, 16 Oct 2020 16:26:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Small QOI fixes for transaction_kthread
Message-ID: <20201016142631.GT6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201008122430.93433-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122430.93433-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 08, 2020 at 03:24:26PM +0300, Nikolay Borisov wrote:
> Following 4 patches make transaction_kthread code slitghly more user friendly.
> Namely, patch 1 convert from open-coded multiplicaiton by HZ to using
> msecs_to_jiffies helper. Patch 2 relies on the observation that the running
> transaction is obtained under trans_lock so an extra check can be removed.
> Patch 3/4 could possibly be squashed into 1 but the net effect is that the code
> is more intuitive when sleeping in case a lower interval than commit_trans has
> elapsed.
> 
> 
> This has survived full xfstest run.
> 
> Nikolay Borisov (4):
>   btrfs: Use helpers to convert from seconds to jiffies in
>     transaction_kthread
>   btrfs: Remove redundant check
>   btrfs: Record delta directly in transaction_kthread

1-3 added to misc-next, with some fixups.

>   btrfs: Be smarter when sleeping in transaction_kthread

There's a comment regarding correctness.
