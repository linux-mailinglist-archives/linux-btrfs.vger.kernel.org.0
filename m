Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A1F30DB4E
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 14:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhBCN3h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 08:29:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:56214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhBCN3d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 08:29:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2399B12F;
        Wed,  3 Feb 2021 13:28:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52DE0DA6FC; Wed,  3 Feb 2021 14:27:01 +0100 (CET)
Date:   Wed, 3 Feb 2021 14:27:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] btrfs: add comment on why we can return 0 if we failed
 to atomically lock the page in read_extent_buffer_pages()
Message-ID: <20210203132701.GD1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210128112508.123614-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128112508.123614-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 28, 2021 at 07:25:08PM +0800, Qu Wenruo wrote:
> In read_extent_buffer_pages(), if we failed to lock the page atomically,
> we just exit with return value 0.
> 
> This is pretty counter-intuitive, as normally if we can't lock what we
> need, we would return something like -EAGAIN.
> 
> But the that return hides under (wait == WAIT_NONE) branch, which only
> get triggered for readahead.
> 
> And for readahead, if we failed to lock the page, it means the extent
> buffer is either being read by other thread, or has been read and is
> under modification.
> Either way the eb will or has been cached, thus readahead has no need to
> wait for it.
> 
> This patch will add extra comment on this counter-intuitive behavior.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks, I've slightly rephrased the subject.
