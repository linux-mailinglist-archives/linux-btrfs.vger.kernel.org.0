Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEB2269450
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgINSD4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 14:03:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgINSDu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 14:03:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06223AEC3;
        Mon, 14 Sep 2020 18:04:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A4B08DA86B; Mon, 14 Sep 2020 20:02:35 +0200 (CEST)
Date:   Mon, 14 Sep 2020 20:02:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix wrong address when faulting in pages in the
 search ioctl
Message-ID: <20200914180235.GA1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <78bf853ef63f2dbd62587bb02bb723fbaa77c198.1600070418.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78bf853ef63f2dbd62587bb02bb723fbaa77c198.1600070418.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 14, 2020 at 09:01:04AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When faulting in the pages for the user supplied buffer for the search
> ioctl, we are passing only the base address of the buffer to the function
> fault_in_pages_writeable(). This means that after the first iteration of
> the while loop that searches for leaves, when we have a non-zero offset,
> stored in 'sk_offset', we try to fault in a wrong page range.
> 
> So fix this by adding the offset in 'sk_offset' to the base address of the
> user supplied buffer when calling fault_in_pages_writeable().
> 
> Several users have reported that the applications compsize and bees have
> started to operate incorrectly since commit a48b73eca4ceb9 ("btrfs: fix
> potential deadlock in the search ioctl") was added to stable trees, and
> these applications make heavy use of the search ioctls. This fixes their
> issues.
> 
> Link: https://lore.kernel.org/linux-btrfs/632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se/
> Link: https://github.com/kilobyte/compsize/issues/34
> Tested-by: A L <mail@lechevalier.se>
> Fixes: a48b73eca4ceb9 ("btrfs: fix potential deadlock in the search ioctl")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks, it's on the way to mainline and stable trees.
