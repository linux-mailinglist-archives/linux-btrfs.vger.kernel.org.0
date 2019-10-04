Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56FBCBC4B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 15:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388914AbfJDNwn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 09:52:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:44518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388270AbfJDNwn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Oct 2019 09:52:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78B09AFAE;
        Fri,  4 Oct 2019 13:52:40 +0000 (UTC)
Subject: Re: [PATCH 1/3] btrfs: tree-checker: Fix false alerts on log trees
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>
References: <20191004093133.83582-1-wqu@suse.com>
 <20191004093133.83582-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4e1e4ffd-c8c1-0d02-d8a0-ebdb4deabe4c@suse.com>
Date:   Fri, 4 Oct 2019 16:52:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004093133.83582-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.10.19 г. 12:31 ч., Qu Wenruo wrote:
> [BUG]
> When running btrfs/063 in a loop, we got the following random write time
> tree checker error:
> 
>   BTRFS critical (device dm-4): corrupt leaf: root=18446744073709551610 block=33095680 slot=2 ino=307 file_offset=0, invalid previous key objectid, have 305 expect 307
>   BTRFS info (device dm-4): leaf 33095680 gen 7 total ptrs 47 free space 12146 owner 18446744073709551610
>   BTRFS info (device dm-4): refs 1 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) lock_owner 0 current 26176
>           item 0 key (305 1 0) itemoff 16123 itemsize 160
>                   inode generation 0 size 0 mode 40777
>           item 1 key (305 12 257) itemoff 16111 itemsize 12
>           item 2 key (307 108 0) itemoff 16058 itemsize 53 <<<
>                   extent data disk bytenr 0 nr 0
>                   extent data offset 0 nr 614400 ram 671744
>           item 3 key (307 108 614400) itemoff 16005 itemsize 53
>                   extent data disk bytenr 195342336 nr 57344
>                   extent data offset 0 nr 53248 ram 57344
>           item 4 key (307 108 667648) itemoff 15952 itemsize 53
>                   extent data disk bytenr 194048000 nr 4096
>                   extent data offset 0 nr 4096 ram 4096
> 	  [...]
>   BTRFS error (device dm-4): block=33095680 write time tree block corruption detected
>   BTRFS: error (device dm-4) in btrfs_commit_transaction:2332: errno=-5 IO failure (Error while writing out transaction)
>   BTRFS info (device dm-4): forced readonly
>   BTRFS warning (device dm-4): Skipping commit of aborted transaction.
>   BTRFS info (device dm-4): use zlib compression, level 3
>   BTRFS: error (device dm-4) in cleanup_transaction:1890: errno=-5 IO failure
> 
> [CAUSE]
> Commit 59b0d030fb30 ("btrfs: tree-checker: Try to detect missing INODE_ITEM")
> assumes all XATTR_ITEM/DIR_INDEX/DIR_ITEM/INODE_REF/EXTENT_DATA items
> should have previous key with the same objectid as ino.
> 
> But it's only true for fs trees. For log-tree, we can get above log tree
> block where an EXTENT_DATA item has no previous key with the same ino.
> As log tree only records modified items, it won't record unmodified
> items like INODE_ITEM.
> 
> So this triggers write time tree check warning.
> 
> [FIX]
> As a quick fix, check header owner to skip the previous key if it's not
> fs tree (log tree doesn't count as fs tree).
> 
> This fix is only to be merged as a quick fix.
> There will be a more comprehensive fix to refactor the common check into
> one function.
> 
> Reported-by: David Sterba <dsterba@suse.com>
> Fixes: 59b0d030fb30 ("btrfs: tree-checker: Try to detect missing INODE_ITEM")
> Signed-off-by: Qu Wenruo <wqu@suse.com>


It's not entirely clear why this bug manifests. My tests show that when
we write extents we always update the inode's c/m time so it's always
dirtied hence it's logged. OTOH when punching a hole the same thing is
valid.

Filipe, under what conditions should it be possible to log an
EXTENT_DATA item without first logging the inode it belongs to? It seems
using the usual write paths (e.g. buffered write and punchole) that's
impossible?

> ---
>  fs/btrfs/tree-checker.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index b8f82d9be9f0..5e34cd5e3e2e 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -148,7 +148,8 @@ static int check_extent_data_item(struct extent_buffer *leaf,
>  	 * But if objectids mismatch, it means we have a missing
>  	 * INODE_ITEM.
>  	 */
> -	if (slot > 0 && prev_key->objectid != key->objectid) {
> +	if (slot > 0 && is_fstree(btrfs_header_owner(leaf)) &&
> +	    prev_key->objectid != key->objectid) {
>  		file_extent_err(leaf, slot,
>  		"invalid previous key objectid, have %llu expect %llu",
>  				prev_key->objectid, key->objectid);
> @@ -322,7 +323,8 @@ static int check_dir_item(struct extent_buffer *leaf,
>  	u32 cur = 0;
>  
>  	/* Same check as in check_extent_data_item() */
> -	if (slot > 0 && prev_key->objectid != key->objectid) {
> +	if (slot > 0 && is_fstree(btrfs_header_owner(leaf)) &&
> +	    prev_key->objectid != key->objectid) {
>  		dir_item_err(leaf, slot,
>  		"invalid previous key objectid, have %llu expect %llu",
>  			     prev_key->objectid, key->objectid);
> 
