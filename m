Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F153E6F47DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbjEBQAR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 12:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjEBQAL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 12:00:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FC240CA
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 09:00:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D0E51FD72;
        Tue,  2 May 2023 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683043206;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBQnxQZss2k7/M6CbL408m/xQKhQUiUo/IszJqb15rQ=;
        b=UJRzRu23hsvRn0YPOssm9FL6u9Ju9xJuNNQResDd31QV2v3L6nAiIEWNrrmsnkn45kaY3u
        UNpQ0lhCbkTReiJ21ph+YsDoDrqkgsFR0FgkJ9D+c42fd1ZPkYHHDE9FbcxhmhTfsUToCz
        NnygzBXXjI9BM6+RJvzrLrR30SK6yek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683043206;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBQnxQZss2k7/M6CbL408m/xQKhQUiUo/IszJqb15rQ=;
        b=BO7mELWf/gS/k0CeaGz32XcY+DQ45dhWVKf8+d4UNz8T8en/BkDyD3sHT48uJbQoWBzZTr
        hBVRzo1kIYhPUGCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 117CE134FB;
        Tue,  2 May 2023 16:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MOJsA4YzUWQEMwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 16:00:06 +0000
Date:   Tue, 2 May 2023 17:54:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: output affected files when relocation failed
Message-ID: <20230502155410.GH8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aa446804b679949a1bd77e653a205408af43048e.1681780522.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa446804b679949a1bd77e653a205408af43048e.1681780522.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 18, 2023 at 09:15:46AM +0800, Qu Wenruo wrote:
> [PROBLEM]
> When relocation failed (mostly due to checksum mismatch), we only got
> very cryptic error messages like
> 
>   BTRFS info (device dm-4): relocating block group 13631488 flags data
>   BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
>   BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>   BTRFS info (device dm-4): balance: ended with status: -5
> 
> The end user has to decrypt the above messages and use various tools to
> locate the affected files and find a way to fix the problem (mostly
> deleting the file).
> 
> This is not an easy work even for experienced developer, not to mention
> the end users.
> 
> [SCRUB IS DOING BETTER]
> By contrast, scrub is providing much better error messages:
> 
>  BTRFS error (device dm-4): unable to fixup (regular) error at logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
>  BTRFS warning (device dm-4): checksum error at logical 13631488 on dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
>  BTRFS info (device dm-4): scrub: finished on devid 1 with status: 0
> 
> Which provides the affected files directly to the end user.
> 
> [IMPROVEMENT]
> Instead of the generic data checksum error messages, which is not doing
> a good job for data reloc inodes, this patch introduce a scrub like
> backref walking based solution.
> 
> When a sector failed its checksum for data reloc inode, we go the
> following workflow:
> 
> - Get the real logical bytenr
>   For data reloc inode, the file offset is the offset inside the block
>   group.
>   Thus the real logical bytenr is @file_off + @block_group->start.
> 
> - Do an extent type check
>   If it's tree blocks it's much easier to handle, just go through
>   all the tree block backref.
> 
> - Do a backref walk and inode path resolution for data extents
>   This is mostly the same as scrub.
>   But unfortunately we can not reuse the same function as the output
>   format is different.

We should try to unify the messages eventually.
> 
> Now the new output would be more user friendly:
> 
>  BTRFS info (device dm-4): relocating block group 13631488 flags data
>  BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 logical 13631488 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
>  BTRFS warning (device dm-4): checksum error at logical 13631488 mirror 1, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
>  BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>  BTRFS info (device dm-4): balance: ended with status: -5

This seems ok, scrub already does that so it's adding the missing
information, though the filenames in syslog may not be wanted due to
security/privacy reasons.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c      | 186 +++++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/relocation.c |  16 ++++
>  fs/btrfs/relocation.h |   1 +
>  3 files changed, 202 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 57d070025c7a..feb57ac3da84 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -70,6 +70,7 @@
>  #include "verity.h"
>  #include "super.h"
>  #include "orphan.h"
> +#include "backref.h"
>  
>  struct btrfs_iget_args {
>  	u64 ino;
> @@ -100,6 +101,14 @@ struct btrfs_rename_ctx {
>  	u64 index;
>  };
>  
> +struct data_reloc_warn {

Please add a description what's the structure used for.

> +	struct btrfs_path path;
> +	struct btrfs_fs_info *fs_info;
> +	u64 extent_item_size;
> +	u64 logical;
> +	int mirror_num;
> +};
> +
>  static const struct inode_operations btrfs_dir_inode_operations;
>  static const struct inode_operations btrfs_symlink_inode_operations;
>  static const struct inode_operations btrfs_special_inode_operations;
> @@ -122,14 +131,189 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
>  				       u64 ram_bytes, int compress_type,
>  				       int type);
>  
> +static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
> +					  u64 root, void *warn_ctx)
> +{
> +	struct data_reloc_warn *warn = warn_ctx;
> +	struct btrfs_fs_info *fs_info = warn->fs_info;
> +	struct extent_buffer *eb;
> +	struct btrfs_inode_item *inode_item;
> +	struct inode_fs_paths *ipath = NULL;
> +	struct btrfs_root *local_root;
> +	struct btrfs_key key;
> +	unsigned int nofs_flag;
> +	u32 nlink;
> +	int ret;
> +
> +	local_root = btrfs_get_fs_root(fs_info, root, true);
> +	if (IS_ERR(local_root)) {
> +		ret = PTR_ERR(local_root);
> +		goto err;
> +	}
> +
> +	/*
> +	 * this makes the path point to (inum INODE_ITEM ioff)
> +	 */

	/* This makes the path point to (inum INODE_ITEM ioff). */

> +	key.objectid = inum;
> +	key.type = BTRFS_INODE_ITEM_KEY;
> +	key.offset = 0;
> +
> +	ret = btrfs_search_slot(NULL, local_root, &key, &warn->path, 0, 0);
> +	if (ret) {
> +		btrfs_put_root(local_root);
> +		btrfs_release_path(&warn->path);
> +		goto err;
> +	}
> +
> +	eb = warn->path.nodes[0];
> +	inode_item = btrfs_item_ptr(eb, warn->path.slots[0],
> +				    struct btrfs_inode_item);
> +	nlink = btrfs_inode_nlink(eb, inode_item);
> +	btrfs_release_path(&warn->path);
> +
> +	nofs_flag = memalloc_nofs_save();
> +	ipath = init_ipath(4096, local_root, &warn->path);
> +	memalloc_nofs_restore(nofs_flag);
> +	if (IS_ERR(ipath)) {
> +		btrfs_put_root(local_root);
> +		ret = PTR_ERR(ipath);

Should this fail due to memory allocation error when printing a message?
We can print a generic one but this is not a serious error that the user
should react to.

> +		ipath = NULL;
> +		goto err;
> +	}
> +	ret = paths_from_inode(inum, ipath);
> +	if (ret < 0)
> +		goto err;
> +
> +	/*
> +	 * We deliberately ignore the bit ipath might have been too small to
> +	 * hold all of the paths here
> +	 */
> +	for (int i = 0; i < ipath->fspath->elem_cnt; i++)
> +		btrfs_warn_in_rcu(fs_info,

Why do you use btrfs_warn_in_rcu? There's nothing in the values that
would need RCU.

> +"checksum error at logical %llu mirror %u, root %llu, inode %llu, offset %llu, length %u, links %u (path: %s)",
> +				  warn->logical, warn->mirror_num,
> +				  root, inum, offset,
> +				  fs_info->sectorsize, nlink,
> +				  (char *)(unsigned long)ipath->fspath->val[i]);
> +
> +	btrfs_put_root(local_root);
> +	free_ipath(ipath);
> +	return 0;
> +
> +err:
> +	btrfs_warn_in_rcu(fs_info,
> +			  "checksum error at logical %llu mirror %u, root %llu, inode %llu offset %llu: path resolving failed with ret=%d",
> +			  warn->logical, warn->mirror_num,
> +			  root, inum, offset, ret);
> +
> +	free_ipath(ipath);
> +	return ret;
> +
> +}
