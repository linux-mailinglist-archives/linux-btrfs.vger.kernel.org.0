Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D91A1B778
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 15:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfEMNys (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 09:54:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:53510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729040AbfEMNys (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 09:54:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E32BAD64
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 13:54:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AEC77DA851; Mon, 13 May 2019 15:55:48 +0200 (CEST)
Date:   Mon, 13 May 2019 15:55:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: Handle error properly in
 btrfs_commit_transaction()
Message-ID: <20190513135548.GA3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190416071526.3576-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416071526.3576-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 16, 2019 at 03:15:23PM +0800, Qu Wenruo wrote:
> This patchset can be fetched from github:
> https://github.com/adam900710/btrfs-progs/tree/commit_failure_cleanup
> 
> This patchset will address the BUG_ON() triggered in fuzz-tests/003 and
> fuzz-tests/009.
> 
> For proper error handling in btrfs_commit_transaction(), we need a way
> to clean up per-transaction data properly.
> 
> Currently we only have delayed refs which are per-transaction, so
> introduce a new function, btrfs_destroy_delayed_refs() to cleanup
> delayed refs.
> 
> Now btrfs_commit_transaction() can error out gracefully with proper
> cleanup.
> 
> Patch 1 and 2 are just some minor cleanups found when crafting the 3rd
> patch.
> 
> Qu Wenruo (3):
>   btrfs-progs: Remove the dead branch in btrfs_run_delayed_refs()
>   btrfs-progs: Refactor btrfs_finish_extent_commit()
>   btrfs-progs: Handle error properly in btrfs_commit_transaction()

Added to devel, thanks.
