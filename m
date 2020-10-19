Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1280C292836
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Oct 2020 15:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgJSNbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Oct 2020 09:31:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:59642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgJSNbi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Oct 2020 09:31:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA0C8ACDF;
        Mon, 19 Oct 2020 13:31:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3B801DA8EA; Mon, 19 Oct 2020 15:30:07 +0200 (CEST)
Date:   Mon, 19 Oct 2020 15:30:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pujin Shi <shipujin.t@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: btrfs: Fix incorrect printf qualifier
Message-ID: <20201019133007.GW6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pujin Shi <shipujin.t@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201017121249.1261-1-shipujin.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017121249.1261-1-shipujin.t@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 17, 2020 at 08:12:49PM +0800, Pujin Shi wrote:
> This patch addresses a compile warning:
> fs/btrfs/extent-tree.c: In function '__btrfs_free_extent':
> fs/btrfs/extent-tree.c:3187:4: warning: format '%lu' expects argument of type 'long unsigned int', but argument 8 has type 'unsigned int' [-Wformat=]
> 
> Fixes: 1c2a07f598d5 ("btrfs: extent-tree: kill BUG_ON() in __btrfs_free_extent()")
> Signed-off-by: Pujin Shi <shipujin.t@gmail.com>

Thanks, Fixes: tag updated.
