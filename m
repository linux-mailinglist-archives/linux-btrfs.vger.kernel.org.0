Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46249230B9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 15:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgG1Nlv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 09:41:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730069AbgG1Nlv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 09:41:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40EA4AEF6;
        Tue, 28 Jul 2020 13:42:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8493EDA701; Tue, 28 Jul 2020 15:41:21 +0200 (CEST)
Date:   Tue, 28 Jul 2020 15:41:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Luciano Chavez <chavez@us.ibm.com>
Subject: Re: [PATCH] btrfs: inode: Fix NULL pointer dereference if inode
 doesn't need compression
Message-ID: <20200728134121.GV3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Luciano Chavez <chavez@us.ibm.com>
References: <20200728083926.19518-1-wqu@suse.com>
 <20200728131920.GU3703@twin.jikos.cz>
 <c0e68f16-a55b-bf4c-47fe-289f83210847@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0e68f16-a55b-bf4c-47fe-289f83210847@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 28, 2020 at 09:26:43PM +0800, Qu Wenruo wrote:
> >> Fixes: 4d3a800ebb12 ("btrfs: merge nr_pages input and output parameter in compress_pages")
> > 
> > How does this patch cause the bug?
> > 
> Sorry, I should explain more on that.
> 
> In fact it takes me quite some time to find the proper culprit.
> 
> Before that commit, we have @nr_pages_ret initialized to 0 in
> compress_file_extent().
> 
> If inode_need_compress() returned false in that function, we continue to
> the same inline file extent insert,.
> 
> But in free_pages_out: tag, we use @nr_pages_nr to free pages, which is
> still 0, as it only get initialized to proper values after
> btrfs_compress_pages() call, which we skipped due to
> inode_need_compress() returned false.
> 
> Then free_pages_out: tag will not execute the WARN_ON() and put_pages()
> calls, just skip to kfree(pages). And kfree() can handle NULL pointers
> without any problem.
> 
> Thus a completely sane looking cleanup in fact caused the NULL pointer
> dereference regression for race cases.

Thanks. It was not obvious so I was expecting a bit more convoluted way
to hit the bug.
