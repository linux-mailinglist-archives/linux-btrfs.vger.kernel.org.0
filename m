Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798BF48D4EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 10:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiAMJU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 04:20:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58150 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiAMJUp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 04:20:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5AE971F3A5;
        Thu, 13 Jan 2022 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642065644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5qqwYw+srk2Y7N0KR2Yr2lMhwsYbl37f1kN4gfiBp8=;
        b=DoWu3ZvRs9nMCJmDuxK5gCFWDc4fWLgfiQEB8MWKLVBzFU3zV2z+0sb/hte3AX3/hik8t8
        1feaJ1TVkr+hqpJpT/ZPtZ2z+zBk1o4IuoM3yPygaJPdqfKrX1C3SftcsBZUfKh8qvrhzo
        3FjpiHV8vRhqFSlDJSqEp3LiNtoc0w0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16F7613B87;
        Thu, 13 Jan 2022 09:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8sZ8Auzu32EzYQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 13 Jan 2022 09:20:44 +0000
Subject: Re: [PATCH v2 09/11] btrfs: abstract out loading the tree root
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1639600719.git.josef@toxicpanda.com>
 <fc9f1e2aa167dfe0d1b9b806246eb55e098092c9.1639600719.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <64a4fbdc-0a06-1c65-cd3c-5874a3ba6d4d@suse.com>
Date:   Thu, 13 Jan 2022 11:20:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fc9f1e2aa167dfe0d1b9b806246eb55e098092c9.1639600719.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.12.21 г. 22:40, Josef Bacik wrote:
> We're going to be adding more roots that need to be loaded from the
> super block, so abstract out the code to read the tree_root from the
> super block, and use this helper for the chunk root as well.  This will
> make it simpler to load the new trees in the future.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/disk-io.c | 82 ++++++++++++++++++++++++++--------------------
>  1 file changed, 47 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5c598e124c25..ddc3b9fcbabc 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2934,6 +2934,46 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
>  	return ret;
>  }
>  
> +static int load_super_root(struct btrfs_root *root, u64 bytenr, u64 gen,
> +			   int level)

nit: 'super' here sounds a bit off. Perhaps 'meta' (no pun intended!) or
'main' or 'core' or simply 'load_root' ?

> +{
> +	int ret = 0;
> +
> +	root->node = read_tree_block(root->fs_info, bytenr,
> +				     root->root_key.objectid, gen, level, NULL);
> +	if (IS_ERR(root->node)) {
> +		ret = PTR_ERR(root->node);
> +		root->node = NULL;
> +	} else if (!extent_buffer_uptodate(root->node)) {
> +		free_extent_buffer(root->node);
> +		root->node = NULL;
> +		ret = -EIO;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	btrfs_set_root_node(&root->root_item, root->node);
> +	root->commit_root = btrfs_root_node(root);
> +	btrfs_set_root_refs(&root->root_item, 1);
> +	return ret;
> +}
> +
> +static int load_important_roots(struct btrfs_fs_info *fs_info)

nit: This name is somewhat colloquial and naming something important
doesn't really convey much useful information about what it is. So I'm
wondering what a more becoming name might look like. I was thinking of
load_main_roots - but I have a feeling it's not much better than
'important' or load_core_roots but this introduces 'core' as a new
concept which we haven't had so far in the code.

> +{
> +	struct btrfs_super_block *sb = fs_info->super_copy;
> +	u64 gen, bytenr;
> +	int level, ret;
> +
> +	bytenr = btrfs_super_root(sb);
> +	gen = btrfs_super_generation(sb);
> +	level = btrfs_super_root_level(sb);
> +	ret = load_super_root(fs_info->tree_root, bytenr, gen, level);
> +	if (ret)
> +		btrfs_warn(fs_info, "couldn't read tree root");
> +	return ret;
> +}
> +
>  static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
>  {
>  	int backup_index = find_newest_super_backup(fs_info);

<snip>
