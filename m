Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF056D7E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 10:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiGKI2J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 04:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiGKI1t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 04:27:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CF61EEEF
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 01:27:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71A8A226ED;
        Mon, 11 Jul 2022 08:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657528062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfzOHljoliMDY6l2EVqs9cDfi9aapCJqvR0IVch9gGI=;
        b=XLBEizTNfB6j5YExA5L4yTu3oOzsX3x7XQ1QZADH5wmijalhSLJlaA+rv1pmsws8qkVQnS
        3yfSja3SdXevqRnvFLCE0X3PpUGfjKZ4nsJaUjmTKV+e6s4RoAEgQ3APrmN96rXQc15KxG
        bHRrcxus5Sxmm5m14v6qU0TV5/NXvD4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A31813322;
        Mon, 11 Jul 2022 08:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6Id7C/7ey2KiJAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Jul 2022 08:27:42 +0000
Message-ID: <866899c1-6952-e0f1-3a78-9caa483a7db9@suse.com>
Date:   Mon, 11 Jul 2022 11:27:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] btrfs: don't save block group root into super block
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <40ce67d5bbb8f9c471b3c9a33504b0bb4022a51b.1657520391.git.wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <40ce67d5bbb8f9c471b3c9a33504b0bb4022a51b.1657520391.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.07.22 г. 9:21 ч., Qu Wenruo wrote:
> The extent tree v2 (both thankfully not yet fully materialized) needs a
> new root for storing all block group items.
> 
> My initial proposal years just added a new tree rootid, and load it from
> tree root, just like what we did for quota/free space tree/uuid/extent
> roots.
> 
> But the extent tree v2 patches introduced a completely new (and to me,
> wasteful) way to store block group tree root into super block.
> 
> Currently only two roots enjoying the privilege to stay in super blocks:
> tree root and chunk root.
> 
> There is no special reason to store block group root into super block,
> even performance wise it doesn't make sense.
> 
> So just move block group root from super block into tree root.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>


Overall looks good but I'd like to hear Josef's take on this, but indeed 
it's better to make those changes before unleashing extent v2.

> ---
> Changelog:
> v2:
> - Fix a wrong check in btrfs_read_roots(), which makes us to read
>    block group root when EXTENT_TREE_V2 is not enabled
> ---
>   fs/btrfs/block-rsv.c   |  1 +
>   fs/btrfs/ctree.h       | 16 ++--------------
>   fs/btrfs/disk-io.c     | 32 +++++++++++++++++++++-----------
>   fs/btrfs/transaction.c |  8 --------
>   4 files changed, 24 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index 06be0644dd37..6ce704d3bdd2 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -424,6 +424,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
>   	case BTRFS_CSUM_TREE_OBJECTID:
>   	case BTRFS_EXTENT_TREE_OBJECTID:
>   	case BTRFS_FREE_SPACE_TREE_OBJECTID:
> +	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
>   		root->block_rsv = &fs_info->delayed_refs_rsv;
>   		break;
>   	case BTRFS_ROOT_TREE_OBJECTID:
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4e2569f84aab..2ffd8daaa26e 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -288,14 +288,9 @@ struct btrfs_super_block {
>   	/* the UUID written into btree blocks */
>   	u8 metadata_uuid[BTRFS_FSID_SIZE];
>   
> -	/* Extent tree v2 */
> -	__le64 block_group_root;
> -	__le64 block_group_root_generation;
> -	u8 block_group_root_level;
> -
>   	/* future expansion */
> -	u8 reserved8[7];
> -	__le64 reserved[25];
> +	u8 reserved8[8];

nit: This array of 8 u8's is simply a single u64 so just collapse it 
into the subsequent array.

> +	__le64 reserved[27];
>   	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
>   	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
>   

<snip>

> @@ -2596,6 +2599,23 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
>   	if (ret)
>   		return ret;
>   
> +	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
> +		location.objectid = BTRFS_BLOCK_GROUP_TREE_OBJECTID;
> +		location.type = BTRFS_ROOT_ITEM_KEY;
> +		location.offset = 0;

nit: Factor out the setting of .type/.offset at the beginning of the 
function. Subsequent loads of the various root tree depend on only 
.objectid, that makes the code somewhat straighforward.

> +
> +		root = btrfs_read_tree_root(tree_root, &location);
> +		if (IS_ERR(root)) {
> +			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> +				ret = PTR_ERR(root);
> +				goto out;
> +			}
> +		} else {
> +			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +			fs_info->block_group_root = root;
> +		}
> +	}
> +
>   	location.objectid = BTRFS_DEV_TREE_OBJECTID;
>   	location.type = BTRFS_ROOT_ITEM_KEY;
>   	location.offset = 0;

<snip>
