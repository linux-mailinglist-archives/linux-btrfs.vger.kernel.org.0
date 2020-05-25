Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509501E0FD5
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 15:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403914AbgEYNux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 09:50:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403912AbgEYNux (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 09:50:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F3014B027;
        Mon, 25 May 2020 13:50:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 908F1DA728; Mon, 25 May 2020 15:49:55 +0200 (CEST)
Date:   Mon, 25 May 2020 15:49:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: check: Detect overlapping csum item
Message-ID: <20200525134955.GU18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200304072701.38403-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304072701.38403-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 04, 2020 at 03:26:59PM +0800, Qu Wenruo wrote:
> There is one report about tree-checker rejecting overlapping csum item.

Do you have link of the report?

I think the bug has been fixed by "btrfs: fix corrupt log due to
concurrent fsync of inodes with shared extents".

> I haven't yet seen another report, thus the problem doesn't look
> widespread, thus maybe some regression in older kernels.
> 
> At least let btrfs check to detect such problem.
> If we had another report, I'll spending extra time for the repair
> functionality (it's not that simple, as it involves a lot of csum item
> operation, and unexpected overlapping range).
> 
> Qu Wenruo (2):
>   btrfs-progs: check: Detect overlap csum items
>   btrfs-progs: fsck-tests: Add test image for overlapping csum item

Added to devel.
