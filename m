Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43528E187
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 15:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgJNNmh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 09:42:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:59714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731278AbgJNNmf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 09:42:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B262B120;
        Wed, 14 Oct 2020 13:42:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 88476DA7C3; Wed, 14 Oct 2020 15:41:06 +0200 (CEST)
Date:   Wed, 14 Oct 2020 15:41:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pujin Shi <shipujin.t@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: Fix incorrect printf qualifier
Message-ID: <20201014134106.GM6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pujin Shi <shipujin.t@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201014032419.1268-1-shipujin.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014032419.1268-1-shipujin.t@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 14, 2020 at 11:24:19AM +0800, Pujin Shi wrote:
> This patch addresses a compile warning:
> fs/btrfs/extent-tree.c: In function '__btrfs_free_extent':
> fs/btrfs/extent-tree.c:3187:4: warning: format '%lu' expects argument of type 'long unsigned int', but argument 8 has type 'unsigned int' [-Wformat=]
> 
> Fixes: 3b7b6ffa4f8f ("btrfs: extent-tree: kill BUG_ON() in __btrfs_free_extent()")
> Signed-off-by: Pujin Shi <shipujin.t@gmail.com>

Added to misc-next, thanks.
