Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B100E9D4B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfHZRMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 13:12:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:47876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729007AbfHZRMs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 13:12:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DFE32B63F
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 17:12:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AEC4BDA98E; Mon, 26 Aug 2019 19:13:11 +0200 (CEST)
Date:   Mon, 26 Aug 2019 19:13:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: print-tree: Use BFS as default traversal
 method
Message-ID: <20190826171311.GA2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190806062311.16194-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806062311.16194-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 06, 2019 at 02:23:11PM +0800, Qu Wenruo wrote:
> When debugging tree nodes with higher level, default DFS is not that
> reader friendly:
> 
>   file tree key (262 ROOT_ITEM 16)
>   node 33800192 level 2 items 4 free 117 generation 16 owner 262
>   fs uuid 2d66d111-6850-4ca1-ae73-03f50adde41c
>   chunk uuid 11141e63-2534-4d04-a0bd-c0531a8f5b88
>   	key (256 INODE_ITEM 0) block 33771520 gen 15
>   	key (330 EXTENT_DATA 0) block 33325056 gen 11
>   	key (438 EXTENT_DATA 0) block 33652736 gen 15
>   	key (654 EXTENT_DATA 0) block 33644544 gen 15
>   node 33771520 level 1 items 59 free 62 generation 15 owner 256
>   fs uuid 2d66d111-6850-4ca1-ae73-03f50adde41c
>   chunk uuid 11141e63-2534-4d04-a0bd-c0531a8f5b88
>   	key (256 INODE_ITEM 0) block 33787904 gen 15
>   	key (256 DIR_ITEM 273597024) block 33124352 gen 9
>   	[...]
>   leaf 33787904 items 30 free space 1868 generation 15 owner 256
>   fs uuid 2d66d111-6850-4ca1-ae73-03f50adde41c
>   chunk uuid 11141e63-2534-4d04-a0bd-c0531a8f5b88
>   	item 0 key (256 INODE_ITEM 0) itemoff 3835 itemsize 160
>   		generation 6 transid 15 size 12954 nbytes 0
>   		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
>   		sequence 528 flags 0x0(none)
>   		atime 1565071339.446118888 (2019-08-06 14:02:19)
>   		ctime 1565071339.449452222 (2019-08-06 14:02:19)
>   		mtime 1565071339.449452222 (2019-08-06 14:02:19)
>   		otime 1565071338.89452221 (2019-08-06 14:02:18)
>   	item 1 key (256 INODE_REF 256) itemoff 3823 itemsize 12
>   		index 0 namelen 2 name: ..
>   	item 2 key (256 DIR_ITEM 2487323) itemoff 3781 itemsize 42
>   		location key (487 INODE_ITEM 0) type FILE
>   		transid 7 data_len 0 name_len 12
>   		name: file_reg_115
>   	[...]
>   leaf 33124352 items 31 free space 1873 generation 9 owner 256
>   	[...]
> 
> However such DFS will show the leaves before nodes. If tracing things
> like drop_progress, we want to see nodes first then leaves.
> 
> So change default behavior to BFS to life of developers easier.

Ok, let it be BFS by default. Btw, the --bfs/--dfs options are
undocumented in dump-tree help, I'll add it should anybody need the
--dfs traversal.
