Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C27ADEC1E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 12:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfKALbm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 07:31:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfKALbm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 07:31:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27316AC53;
        Fri,  1 Nov 2019 11:31:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D9828DA791; Fri,  1 Nov 2019 12:31:49 +0100 (CET)
Date:   Fri, 1 Nov 2019 12:31:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Replace btrfs_block_group_cache::item with
 dedicated members
Message-ID: <20191101113149.GN3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191030074039.112707-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030074039.112707-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 30, 2019 at 03:40:39PM +0800, Qu Wenruo wrote:
> We access btrfs_block_group_cache::item mostly for @used and @flags.
> 
> @flags is already a dedicated member in btrfs_block_group_cache, only
> @used doesn't have a dedicated member.
> 
> This patch will remove btrfs_block_group_cache::item and add
> btrfs_block_group_cache::used.
> 
> It's the btrfs-progs equivalent of the following kernel patches:
> btrfs: move block_group_item::used to block group
> btrfs: move block_group_item::flags to block group
> btrfs: remove embedded block_group_cache::item
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Applied, thanks.
