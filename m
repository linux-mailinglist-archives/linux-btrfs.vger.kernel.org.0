Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E522C14AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Nov 2020 20:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgKWTpf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Nov 2020 14:45:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbgKWTpe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Nov 2020 14:45:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66FFAAC75;
        Mon, 23 Nov 2020 19:45:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E6F2DA818; Mon, 23 Nov 2020 20:43:45 +0100 (CET)
Date:   Mon, 23 Nov 2020 20:43:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do nofs allocations when adding and removing
 qgroup relations
Message-ID: <20201123194345.GN8669@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <b3e4b5a1b95835d5309421349629cf36ffff9a7f.1606152412.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3e4b5a1b95835d5309421349629cf36ffff9a7f.1606152412.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 23, 2020 at 06:30:54PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When adding or removing a qgroup relation we are doing a GFP_KERNEL
> allocation which is not safe because we are holding a transaction
> handle open and that can make us deadlock if the allocator needs to
> recurse into the filesystem. So just surround those calls with a
> nofs context.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
