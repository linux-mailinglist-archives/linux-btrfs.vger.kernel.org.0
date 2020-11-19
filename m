Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412832B9CB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 22:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgKSVLH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 16:11:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:35586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgKSVLG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 16:11:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BB273ABF4;
        Thu, 19 Nov 2020 21:11:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8916BDA701; Thu, 19 Nov 2020 22:09:19 +0100 (CET)
Date:   Thu, 19 Nov 2020 22:09:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 14/24] btrfs: disk-io: only clear EXTENT_LOCK bit for
 extent_invalidatepage()
Message-ID: <20201119210919.GO20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-15-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-15-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:39PM +0800, Qu Wenruo wrote:
> In extent_invalidatepage() it will try to clear all possible bits since
> it's calling clear_extent_bit() with delete == 1.
> That would try to clear all existing bits.
> 
> This is currently fine, since for btree io tree, it only utilizes
> EXTENT_LOCK bit.
> But this could be a problem for later subpage support, which will
> utilize extra io tree bit to represent extra info.
> 
> This patch will just convert that clear_extent_bit() to
> unlock_extent_cached().
> 
> For current code since only EXTENT_LOCKED bit is utilized, this doesn't
> change the behavior, but provides a much cleaner basis for incoming
> subpage support.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next.
