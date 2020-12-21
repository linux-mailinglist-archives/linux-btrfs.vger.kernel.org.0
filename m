Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC62DFEB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 18:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgLURFM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 12:05:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:58122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgLURFM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 12:05:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4448EAD35;
        Mon, 21 Dec 2020 17:04:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45E92DA7EF; Mon, 21 Dec 2020 18:02:49 +0100 (CET)
Date:   Mon, 21 Dec 2020 18:02:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Consolidate btrfs_previous_item ret val handling
 in btrfs_shrink_device
Message-ID: <20201221170249.GD6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201217132116.328291-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217132116.328291-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 17, 2020 at 03:21:16PM +0200, Nikolay Borisov wrote:
> Instead of having 3 'if' to handle non-null return value consolidate
> this in 1 'if (ret)'. That way the code is more obvious:
> 
>  - Always drop dlete_unused_bgs_mutex if ret is non null
>  - If ret is negative -> goto done
>  - If it's 1 -> reset ret to 0, release the path and finish the loop.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
