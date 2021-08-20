Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B053F2CA3
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 15:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbhHTNB6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 09:01:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40910 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240262AbhHTNB5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 09:01:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AC85820160;
        Fri, 20 Aug 2021 13:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629464478;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ih7/oeUWNlYomlkiPJP6MxBzVExaplDeB0GZ/5Ku2P0=;
        b=o8oxHQG38VfmscFfzewXSg6bwqdyA0FKxjqHQyTZScbylqWD7foFAmLRxIBUeH5/k5iH33
        DrhUSBcOLmfmrNYJeDiKULTSfLpO7XWYU8krwb6/30tdHS+i6ymRFkTN/uxZPxXnCNaaYw
        Fz5rwJEWxohf3bcEI50JikT5MutFgGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629464478;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ih7/oeUWNlYomlkiPJP6MxBzVExaplDeB0GZ/5Ku2P0=;
        b=HMS9sMQIsmOl7pVnriw/z5/M7IygtvCLTl+lG3ldczjsxgN2J5IgJfqB1njganGhozbVct
        H9eV/8k5Bzby92Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A3ECEA3B87;
        Fri, 20 Aug 2021 13:01:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 02522DA8CA; Fri, 20 Aug 2021 14:58:20 +0200 (CEST)
Date:   Fri, 20 Aug 2021 14:58:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/3] btrfs-progs: add the ability to corrupt block group
 items
Message-ID: <20210820125820.GT5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629261403.git.josef@toxicpanda.com>
 <53e30ee44fcfa086685418304ae4af1ec550c02b.1629261403.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e30ee44fcfa086685418304ae4af1ec550c02b.1629261403.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 12:39:20AM -0400, Josef Bacik wrote:
> While doing the extent tree v2 stuff I noticed that fsck doesn't detect
> an invalid ->used value on the block group item in the normal mode.  To
> build a test case for this I need the ability to corrupt block group
> items.  This allows us to corrupt the various fields of a block group.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  btrfs-corrupt-block.c | 108 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> index 77bdc810..80622f29 100644
> --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c
> @@ -348,6 +348,24 @@ enum btrfs_key_field {
>  	BTRFS_KEY_BAD,
>  };
>  
> +enum btrfs_block_group_field {
> +	BTRFS_BLOCK_GROUP_ITEM_USED,
> +	BTRFS_BLOCK_GROUP_ITEM_FLAGS,
> +	BTRFS_BLOCK_GROUP_ITEM_CHUNK_OBJECTID,
> +	BTRFS_BLOCK_GROUP_ITEM_BAD,
> +};
> +
> +static enum btrfs_block_group_field convert_block_group_field(char *field)
> +{
> +	if (!strncmp(field, "used", FIELD_BUF_LEN))
> +		return BTRFS_BLOCK_GROUP_ITEM_USED;
> +	if (!strncmp(field, "flags", FIELD_BUF_LEN))
> +		return BTRFS_BLOCK_GROUP_ITEM_FLAGS;
> +	if (!strncmp(field, "chunk_objectid", FIELD_BUF_LEN))
> +		return BTRFS_BLOCK_GROUP_ITEM_CHUNK_OBJECTID;
> +	return BTRFS_BLOCK_GROUP_ITEM_BAD;
> +}
> +
>  static enum btrfs_inode_field convert_inode_field(char *field)
>  {
>  	if (!strncmp(field, "isize", FIELD_BUF_LEN))
> @@ -442,6 +460,83 @@ static u8 generate_u8(u8 orig)
>  	return ret;
>  }
>  
> +static int corrupt_block_group(struct btrfs_root *root, u64 bg, char *field)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_path *path;
> +	struct btrfs_block_group_item *bgi;
> +	struct btrfs_key key;
> +	enum btrfs_block_group_field corrupt_field;
> +	u64 orig, bogus;
> +	int ret = 0;
> +
> +	root = root->fs_info->extent_root;
> +
> +	corrupt_field = convert_block_group_field(field);
> +	if (corrupt_field == BTRFS_BLOCK_GROUP_ITEM_BAD) {
> +		fprintf(stderr, "Invalid field %s\n", field);
> +		return -EINVAL;
> +	}
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	trans = btrfs_start_transaction(root, 1);
> +	if (IS_ERR(trans)) {
> +		btrfs_free_path(path);
> +		fprintf(stderr, "Couldn't start transaction %ld\n",
> +			PTR_ERR(trans));
> +		return PTR_ERR(trans);
> +	}
> +
> +	key.objectid = bg;
> +	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
> +	key.offset = 0;
> +
> +	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
> +	if (ret < 0) {
> +		fprintf(stderr, "Error searching for bg %llu %d\n", bg, ret);
> +		goto out;
> +	}
> +
> +	ret = 0;
> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +	if (key.type != BTRFS_BLOCK_GROUP_ITEM_KEY) {
> +		fprintf(stderr, "Couldn't find the bg %llu\n", bg);
> +		goto out;
> +	}
> +
> +	bgi = btrfs_item_ptr(path->nodes[0], path->slots[0],
> +			     struct btrfs_block_group_item);
> +	switch (corrupt_field) {
> +	case BTRFS_BLOCK_GROUP_ITEM_USED:
> +		orig = btrfs_block_group_used(path->nodes[0], bgi);
> +		bogus = generate_u64(orig);
> +		btrfs_set_block_group_used(path->nodes[0], bgi, bogus);
> +		break;
> +	case BTRFS_BLOCK_GROUP_ITEM_CHUNK_OBJECTID:
> +		orig = btrfs_block_group_chunk_objectid(path->nodes[0], bgi);
> +		bogus = generate_u64(orig);
> +		btrfs_set_block_group_chunk_objectid(path->nodes[0], bgi,
> +						     bogus);
> +		break;
> +	case BTRFS_BLOCK_GROUP_ITEM_FLAGS:
> +		orig = btrfs_block_group_flags(path->nodes[0], bgi);
> +		bogus = generate_u64(orig);
> +		btrfs_set_block_group_flags(path->nodes[0], bgi, bogus);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	btrfs_mark_buffer_dirty(path->nodes[0]);
> +out:
> +	btrfs_commit_transaction(trans, root);
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
>  static int corrupt_key(struct btrfs_root *root, struct btrfs_key *key,
>  		       char *field)
>  {
> @@ -1150,6 +1245,7 @@ int main(int argc, char **argv)
>  	u64 file_extent = (u64)-1;
>  	u64 root_objectid = 0;
>  	u64 csum_bytenr = 0;
> +	u64 block_group = 0;
>  	char field[FIELD_BUF_LEN];
>  
>  	field[0] = '\0';
> @@ -1177,11 +1273,12 @@ int main(int argc, char **argv)
>  			{ "delete", no_argument, NULL, 'd'},
>  			{ "root", no_argument, NULL, 'r'},
>  			{ "csum", required_argument, NULL, 'C'},
> +			{ "block-group", required_argument, NULL, 'B'},

The command line interface of corrupt-block is absolute mess because of
the incremental additions like so this so at least please don't use
single letter options. Updated in devel in a separate patch.
