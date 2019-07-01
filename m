Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199225BFA0
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2019 17:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfGAPTK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 11:19:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:43152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbfGAPTJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 11:19:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C2710B0CC;
        Mon,  1 Jul 2019 15:19:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1CA79DA840; Mon,  1 Jul 2019 17:19:52 +0200 (CEST)
Date:   Mon, 1 Jul 2019 17:19:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs: move the block_rsv code out of extent-tree.c
Message-ID: <20190701151952.GJ20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <20190619174724.1675-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619174724.1675-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 19, 2019 at 01:47:16PM -0400, Josef Bacik wrote:
> This patchset depends on the space_info migration patchset.  This is the next
> logical chunk of things to move out of extent-tree.c  With these sets of patches
> we're down below 10k loc in extent-tree.c.  This chunk was much easier to move
> as we had exported a lot of these functions already.  There is 1 code change
> patch in here and that's to cleanup the logic in __btrfs_block_rsv_release so it
> could be used more globally by everybody.  The rest is just exporting and
> migrating code around.  Again I specifically didn't clean anything else up, I'm
> just trying to re-organize everything.  The diffstat of the series is as follows
> 
>  fs/btrfs/Makefile      |   3 +-
>  fs/btrfs/block-rsv.c   | 429 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/block-rsv.h   | 104 ++++++++++++
>  fs/btrfs/ctree.h       |  70 +-------
>  fs/btrfs/extent-tree.c | 452 ++-----------------------------------------------
>  5 files changed, 549 insertions(+), 509 deletions(-)

Added to misc-next, thanks.
