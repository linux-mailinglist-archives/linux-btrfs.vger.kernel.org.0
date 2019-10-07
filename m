Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32FCCE789
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfJGPbc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 11:31:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728390AbfJGPbc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 11:31:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AF5EAEF8;
        Mon,  7 Oct 2019 15:31:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6A12FDA7FB; Mon,  7 Oct 2019 17:31:46 +0200 (CEST)
Date:   Mon, 7 Oct 2019 17:31:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 1/3] btrfs: tree-checker: Fix false alerts on log trees
Message-ID: <20191007153146.GC2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20191004093133.83582-1-wqu@suse.com>
 <20191004093133.83582-2-wqu@suse.com>
 <CAL3q7H5TdwA5tJL-SFKGCozwexmhwWHnCvHgqucdmw=xB+MgCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5TdwA5tJL-SFKGCozwexmhwWHnCvHgqucdmw=xB+MgCw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 04, 2019 at 03:15:51PM +0100, Filipe Manana wrote:
> On Fri, Oct 4, 2019 at 11:27 AM Qu Wenruo <wqu@suse.com> wrote:
> > Reported-by: David Sterba <dsterba@suse.com>
> > Fixes: 59b0d030fb30 ("btrfs: tree-checker: Try to detect missing INODE_ITEM")
> 
> So this is bogus, since that commit is not in Linus' tree, and once it
> gets there its ID changes.
> More likely, this will get squashed into that commit in misc-next
> since we are still far from the 5.5 merge window.

You're right, squashing it in is preferred in this case. Split fixes
have bitten us in the past so if we can afford to rebase the devel
queue a single complete patch is preferred.

> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Anyway, the change looks fine to me.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks, I can add rev-by to "btrfs: tree-checker: Try to detect missing
INODE_ITEM" as well if you want.
