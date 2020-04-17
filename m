Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FB31AE106
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgDQPXx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 11:23:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:36892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbgDQPXx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 11:23:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 81C8FB1DF;
        Fri, 17 Apr 2020 15:23:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9D719DA727; Fri, 17 Apr 2020 17:23:10 +0200 (CEST)
Date:   Fri, 17 Apr 2020 17:23:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] Btrfs: simplify error handling of
 clean_pinned_extents()
Message-ID: <20200417152310.GR5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200417144021.9319-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417144021.9319-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 17, 2020 at 03:40:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At clean_pinned_extents(), whether we end up returning success or failure,
> we pretty much have to do the same things:
> 
> 1) unlock unused_bg_unpin_mutex
> 2) decrement reference count on the previous transaction
> 
> We also call btrfs_dec_block_group_ro() in case of failure, but that is
> better done in its caller, btrfs_delete_unused_bgs(), since its the
> caller that calls inc_block_group_ro(), so it should be responsible for
> the decrement operation, as it is in case any of the other functions it
> calls fail.
> 
> So move the call to btrfs_dec_block_group_ro() from clean_pinned_extents()
> into  btrfs_delete_unused_bgs() and unify the error and success return
> paths for clean_pinned_extents(), reducing duplicated code and making it
> simpler.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
