Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC326A00B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 09:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIOHpQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 03:45:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:60338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgIOHpJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 03:45:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C56DAD73;
        Tue, 15 Sep 2020 07:45:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EA709DA7C7; Tue, 15 Sep 2020 09:43:47 +0200 (CEST)
Date:   Tue, 15 Sep 2020 09:43:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Cleanup metadata page reading path
Message-ID: <20200915074347.GC1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200914093711.13523-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914093711.13523-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 14, 2020 at 12:37:02PM +0300, Nikolay Borisov wrote:
> Here is v2 of the metadata readout cleanups [0]. This series incorporates the
> feedback I received, namely:
> 
> * Added justification why removing btree_readpage is safe in Patch 1
> * Dropped Patch 2 (pg_offset remove from btrfs_get_extent) as Qu intends on using
> it in his subpage blocksize work.
> * Add a comment about caller's responsibility for cleanup in Patch 3
> * Added RB for patches which haven't changed since v1 and got RB by Josef.
> 
> [0] https://lore.kernel.org/linux-btrfs/20200909094914.29721-1-nborisov@suse.com/T/#t
> 
> Nikolay Borisov (9):
>   btrfs: Remove btree_readpage
>   btrfs: Simplify metadata pages reading
>   btrfs: Remove btree_get_extent
>   btrfs: Remove btrfs_get_extent indirection from __do_readpage
>   btrfs: Remove mirror_num argument from extent_read_full_page
>   btrfs: Promote extent_read_full_page to btrfs_readpage
>   btrfs: Sink mirror_num argument in extent_read_full_page
>   btrfs: Sink read_flags argument into extent_read_full_page
>   btrfs: Sink mirror_num argument in __do_readpage

Added to misc-next, thanks.
