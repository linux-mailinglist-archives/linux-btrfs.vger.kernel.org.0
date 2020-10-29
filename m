Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5195629F196
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 17:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgJ2QeC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 12:34:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:37324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgJ2Qcg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 12:32:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE6ECB2FE;
        Thu, 29 Oct 2020 16:32:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D43E0DA7CE; Thu, 29 Oct 2020 17:30:59 +0100 (CET)
Date:   Thu, 29 Oct 2020 17:30:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] Some block rsv fixes
Message-ID: <20201029163059.GN6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1603745723.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603745723.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 26, 2020 at 04:57:25PM -0400, Josef Bacik wrote:
> v1->v2:
> - change the logic to max(1, root level), as generally we do not walk down into
>   level 0 for the merge, with the exception for root level == 0.
> 
> --- Original email ---
> 
> Hello,
> 
> Nikolay has noticed that -o enospc_debug was getting some warnings in
> btrfs_use_block_rsv() on some tests.  I dug into them and one class is easy to
> fix as it's a straight regression.  The other one is going to require some more
> debugging, so in the meantime here's the two patches I have so far that can be
> merged.  The first is just to make my life easier when debugging these problems,
> and the second is the actual regression fix.  It should probably be tagged for
> stable as well since the regression was backported to stable.  Thanks,

Yeah, for stable 5.4+.

> Josef
> 
> Josef Bacik (2):
>   btrfs: print the block rsv type when we fail our reservation
>   btrfs: fix min reserved size calculation in merge_reloc_root

Added to misc-next, thanks.
