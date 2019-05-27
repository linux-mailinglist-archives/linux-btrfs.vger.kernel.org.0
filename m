Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0532B747
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 16:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfE0OJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 10:09:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbfE0OJg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 10:09:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9654AAD5C
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2019 14:09:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1F9CDA85C; Mon, 27 May 2019 16:10:30 +0200 (CEST)
Date:   Mon, 27 May 2019 16:10:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: convert: Workaround delayed ref bug by
 limiting the size of a transaction
Message-ID: <20190527141030.GJ15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190527051054.533-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527051054.533-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 27, 2019 at 01:10:54PM +0800, Qu Wenruo wrote:
> In convert we use trans->block_reserved >= 4096 as a threshold to commit
> transaction, where block_reserved is the number of new tree blocks
> allocated inside a transaction.
> 
> The problem is, we still have a hidden bug in delayed ref implementation
> in btrfs-progs, when we have a large enough transaction, delayed ref may
> failed to find certain tree blocks in extent tree and cause transaction
> abort.
> 
> This workaround will workaround it by committing transaction at a much
> lower threshold.
> 
> The old 4096 means 4096 new tree blocks, when using default (16K)
> nodesize, it's 64M, which can contain over 12k inlined data extent or
> csum for around 60G, or over 800K file extents.
> 
> The new threshold will limit the size of new tree blocks to 2M, aligning
> with the chunk preallocator threshold, and reducing the possibility to
> hit that delayed ref bug.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
