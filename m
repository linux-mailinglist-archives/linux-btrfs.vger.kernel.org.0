Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB94027700C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgIXLgh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 07:36:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:38580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgIXLgh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 07:36:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3347AC65;
        Thu, 24 Sep 2020 11:36:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A99C2DA6E3; Thu, 24 Sep 2020 13:35:19 +0200 (CEST)
Date:   Thu, 24 Sep 2020 13:35:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] Remove struct extent_io_ops
Message-ID: <20200924113519.GV6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200918133439.23187-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918133439.23187-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 18, 2020 at 04:34:32PM +0300, Nikolay Borisov wrote:
> Finally it's time to remove "struct extent_io_ops" and get rid of the indirect
> calls to the "hook" functions. Each patch is rather self-explanatory, the basic
> idea is to replace indirect calls with an "if" construct (patches 1,3,5,6). The
> rest simply remove struct members and the struct it self.
> 
> This series survived a full xfstest run.
> 
> Nikolay Borisov (7):
>   btrfs: Don't call readpage_end_io_hook for the btree inode
>   btrfs: Remove extent_io_ops::readpage_end_io_hook
>   btrfs: Call submit_bio_hook directly in submit_one_bio
>   btrfs: Don't opencode is_data_inode in end_bio_extent_readpage
>   btrfs: Stop calling submit_bio_hook for data inodes
>   btrfs: Call submit_bio_hook directly for metadata pages
>   btrfs: Remove struct extent_io_ops

With the fixups added to misc-next, thanks.
