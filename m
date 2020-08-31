Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1501257C29
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 17:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgHaPSh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 11:18:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:46028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbgHaPSd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 11:18:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 651EAABD2;
        Mon, 31 Aug 2020 15:18:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 875C2DA840; Mon, 31 Aug 2020 17:17:21 +0200 (CEST)
Date:   Mon, 31 Aug 2020 17:17:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: Fix error reporting on root inode
Message-ID: <20200831151721.GB28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200824140049.28633-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824140049.28633-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 24, 2020 at 05:00:49PM +0300, Nikolay Borisov wrote:
> If btrfs check detects an error on the root inode of a subvolume it
> prints:
> 
>     Opening filesystem to check...
>     Checking filesystem on /dev/vdc
>     UUID: 4ac7a216-bf97-4c5f-9899-0f203c20d8af
>     [1/7] checking root items
>     [2/7] checking extents
>     [3/7] checking free space cache
>     [4/7] checking fs roots
>     root 5 root dir 256 error
>     ERROR: errors found in fs roots
>     found 196608 bytes used, error(s) found
>     total csum bytes: 0
>     total tree bytes: 131072
>     total fs tree bytes: 32768
>     total extent tree bytes: 16384
>     btree space waste bytes: 124376
>     file data blocks allocated: 65536
>      referenced 65536
> 
> This is not very helpful since there is no specific information about
> the exact error. This is due to the fact that check_root_dir doesn't
> set inode_record::errors accordingly. This patch rectifies this and now
> the output would look like:
> 
> 	[1/7] checking root items
> 	[2/7] checking extents
> 	[3/7] checking free space cache
> 	[4/7] checking fs roots
> 	root 5 inode 256 errors 2000, link count wrong
> 	ERROR: errors found in fs roots
> 	found 196608 bytes used, error(s) found
> 	total csum bytes: 0
> 	total tree bytes: 131072
> 	total fs tree bytes: 32768
> 	total extent tree bytes: 16384
> 	btree space waste bytes: 124376
> 	file data blocks allocated: 65536
> 	 referenced 65536
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to devel, thanks.
