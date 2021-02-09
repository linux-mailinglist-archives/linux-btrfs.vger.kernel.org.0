Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF13148BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 07:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBIGY0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 01:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhBIGXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Feb 2021 01:23:44 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E33C06121F
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Feb 2021 22:22:56 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id e7so2885379pge.0
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Feb 2021 22:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9g0Mc8iWWNtcg9sKPnDex2D1Y94VyApoiGASyNmMceM=;
        b=hZPzZfj6jVKuBQuxAGSO3vaN1RbQ9ez0SgjIdz6ahFXo8aD79NmZ9w8zrvKZ9JGJZI
         09Af6caWmUM2/+uTPCIb7v1JfMIiKYej7NtgWUylXPtdOzm+GX0CbarK6J0jWUmQ1l4T
         f2pOn366jAfeVk78m/nxqGUtGjUyJW2UON4G5dJH5eTGqBxC/DE089QbmoN+lplekcwK
         SW3jEl6LnUN3EilZDMbfGzfD0dcwjMxCWj8AffZfkbKAiuDl29NpIitu5G7k2lHOBZja
         zN/uDJ/GRyWvnPFDVUoY0mF2DSJ1NHOCkRP3GoAzBz1guG+mUjlv3TXaTZMpH9q1SFtg
         qqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9g0Mc8iWWNtcg9sKPnDex2D1Y94VyApoiGASyNmMceM=;
        b=TcbqWL5UiMav2uoXedpKP77xUOFXI4ODhzsMISthMYxN+fxcSJBQBAJuEJyBUMJHbH
         r/lF4nMTEReF42eELNvjg6Q9myx+Hq2P8u+FniHD8ClQ/vXhfc9vFirKbMFn0bexEppM
         XDBUO7PGTwIkn4aW2z8LjS4y0I0NO2np2ZzLbVZ5+bx/F7vRw4CO73iZL+lf1Fd6IjS3
         4qaVzuv037yEC4UyWsfQ2cLCGImdOCSfjxGGG7cjH2aP0uJA3yyE45K9rsTDorvrbBsR
         V/j8W6XMjuYxa4NhNXlrMXIJXsgtOoZUgBet7hO6xB4SEDRY/WicOh+nXQ5uNnODe3+H
         w3hw==
X-Gm-Message-State: AOAM533OX4fDDEHoVCXjYAcABNSrKm+vFcDstULvlQSlPveF58dDbdcC
        Aoe/5WtuYGyJjmx4wPWdAGcdyyZ/GpBLfDLr
X-Google-Smtp-Source: ABdhPJwkC5ZzkiiHLdlXbyNNqtoAuMMnd8VhE99UmNvYucwxwA8pZfcWydW9yJM7g9sGpkrPO+7QOw==
X-Received: by 2002:a63:fc58:: with SMTP id r24mr20074586pgk.307.1612851775407;
        Mon, 08 Feb 2021 22:22:55 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id 16sm1145477pjc.28.2021.02.08.22.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 22:22:54 -0800 (PST)
Date:   Tue, 9 Feb 2021 06:22:47 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs-progs: corrupt generic item data with
 btrfs-corrupt-block
Message-ID: <20210209062247.GA3008@realwakka>
References: <cover.1612468824.git.boris@bur.io>
 <039c272f2bd6e8e0bb428c8f0b794e61d491aeef.1612468824.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039c272f2bd6e8e0bb428c8f0b794e61d491aeef.1612468824.git.boris@bur.io>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 04, 2021 at 12:09:31PM -0800, Boris Burkov wrote:

Hi Boris, I have a question for this code.

> btrfs-corrupt-block already has a mix of generic and specific corruption
> options, but currently lacks the capacity for totally arbitrary
> corruption in item data.
> 
> There is already a flag for corruption size (bytes/-b), so add a flag
> for an offset and a value to memset the item with. Exercise the new
> flags with a new variant for -I (item) corruption. Look up the item as
> before, but instead of corrupting a field in the item struct, corrupt an
> offset/size in the item data.
> 
> The motivating example for this is that in testing fsverity with btrfs,
> we need to corrupt the generated Merkle tree--metadata item data which
> is an opaque blob to btrfs.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  btrfs-corrupt-block.c | 71 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> index 0c022a8e..bf1ce9c5 100644
> --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c
> @@ -116,11 +116,13 @@ static void print_usage(int ret)
>  	printf("\t-m   The metadata block to corrupt (must also specify -f for the field to corrupt)\n");
>  	printf("\t-K <u64,u8,u64> Corrupt the given key (must also specify -f for the field and optionally -r for the root)\n");
>  	printf("\t-f   The field in the item to corrupt\n");
> -	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field to corrupt and root for the item)\n");
> +	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field, or bytes, offset, and value to corrupt and root for the item)\n");
>  	printf("\t-D <u64,u8,u64> Corrupt a dir item corresponding to the passed key triplet, must also specify a field\n");
>  	printf("\t-d <u64,u8,u64> Delete item corresponding to passed key triplet\n");
>  	printf("\t-r   Operate on this root\n");
>  	printf("\t-C   Delete a csum for the specified bytenr.  When used with -b it'll delete that many bytes, otherwise it's just sectorsize\n");
> +	printf("\t-v   Value to use for corrupting item data\n");
> +	printf("\t-o   Offset to use for corrupting item data\n");
>  	exit(ret);
>  }
>  
> @@ -896,6 +898,50 @@ out:
>  	return ret;
>  }
>  
> +static int corrupt_btrfs_item_data(struct btrfs_root *root,
> +				   struct btrfs_key *key,
> +				   u64 bogus_offset, u64 bogus_size,
> +				   char bogus_value)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_path *path;
> +	int ret;
> +	void *data;
> +	struct extent_buffer *leaf;
> +	int slot;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	trans = btrfs_start_transaction(root, 1);
> +	if (IS_ERR(trans)) {
> +		fprintf(stderr, "Couldn't start transaction %ld\n",
> +			PTR_ERR(trans));
> +		ret = PTR_ERR(trans);
> +		goto free_path;
> +	}
> +
> +	ret = btrfs_search_slot(trans, root, key, path, 0, 1);
> +	if (ret != 0) {
> +		fprintf(stderr, "Error searching to node %d\n", ret);
> +		goto commit_txn;

This is error case. but this code goes to commit transaction. I think there is
an option to abort transaction. This code has pros than aborting?

> +	}
> +	leaf = path->nodes[0];
> +	slot = path->slots[0];
> +	data = btrfs_item_ptr(leaf, slot, void);
> +	// TODO: check offset/size legitimacy
> +	data += bogus_offset;
> +	memset_extent_buffer(leaf, bogus_value, (unsigned long)data, bogus_size);
> +	btrfs_mark_buffer_dirty(leaf);
> +
> +commit_txn:
> +	btrfs_commit_transaction(trans, root);
> +free_path:
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
>  static int delete_item(struct btrfs_root *root, struct btrfs_key *key)
>  {
>  	struct btrfs_trans_handle *trans;
> @@ -1151,6 +1197,8 @@ int main(int argc, char **argv)
>  	u64 root_objectid = 0;
>  	u64 csum_bytenr = 0;
>  	char field[FIELD_BUF_LEN];
> +	u64 bogus_value = (u64)-1;
> +	u64 bogus_offset = (u64)-1;
>  
>  	field[0] = '\0';
>  	memset(&key, 0, sizeof(key));
> @@ -1177,11 +1225,13 @@ int main(int argc, char **argv)
>  			{ "delete", no_argument, NULL, 'd'},
>  			{ "root", no_argument, NULL, 'r'},
>  			{ "csum", required_argument, NULL, 'C'},
> +			{ "value", required_argument, NULL, 'v'},
> +			{ "offset", required_argument, NULL, 'o'},
>  			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
>  			{ NULL, 0, NULL, 0 }
>  		};
>  
> -		c = getopt_long(argc, argv, "l:c:b:eEkuUi:f:x:m:K:I:D:d:r:C:",
> +		c = getopt_long(argc, argv, "l:c:b:eEkuUi:f:x:m:K:I:D:d:r:C:v:o:",
>  				long_options, NULL);
>  		if (c < 0)
>  			break;
> @@ -1244,6 +1294,12 @@ int main(int argc, char **argv)
>  			case 'C':
>  				csum_bytenr = arg_strtou64(optarg);
>  				break;
> +			case 'v':
> +				bogus_value = arg_strtou64(optarg);
> +				break;
> +			case 'o':
> +				bogus_offset = arg_strtou64(optarg);
> +				break;
>  			case GETOPT_VAL_HELP:
>  			default:
>  				print_usage(c != GETOPT_VAL_HELP);
> @@ -1368,7 +1424,16 @@ int main(int argc, char **argv)
>  		if (!root_objectid)
>  			print_usage(1);
>  
> -		ret = corrupt_btrfs_item(target_root, &key, field);
> +		if (*field != 0)
> +			ret = corrupt_btrfs_item(target_root, &key, field);
> +		else if (bogus_offset != (u64)-1 &&
> +			 bytes != (u64)-1 &&
> +			 bogus_value != (u64)-1)
> +			ret = corrupt_btrfs_item_data(target_root, &key,
> +						      bogus_offset, bytes,
> +						      bogus_value);
> +		else
> +			print_usage(1);
>  		goto out_close;
>  	}
>  	if (delete) {
> -- 
> 2.24.1
> 
