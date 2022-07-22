Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E4757DF08
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jul 2022 12:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiGVKIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jul 2022 06:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiGVKIq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jul 2022 06:08:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D34E70E6C
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jul 2022 03:08:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B62E31FDCF;
        Fri, 22 Jul 2022 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658484523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MT9rvDIM+h8/0pAuR2V5oPGmoEMpP5Aji42b8YzzaUo=;
        b=ql+PgpcaSCmO2Ne2b2YLv/OjNIS4EvIWgVAvn0WU7Mn9SaW6wuEQS8obRqPOblUl8L6yAO
        z4zr9O8IijK4CE2GxsRAyROtnXDwiFQinTkN9BcVcFGQ5XHnRUJBf6MgIzF+TZ4RLjqzxL
        aEJ79Q42esBW8TRqOWvtvuxnGoETRhk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7532013AB3;
        Fri, 22 Jul 2022 10:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FijaGSt32mIseAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 22 Jul 2022 10:08:43 +0000
Message-ID: <0e86b92c-2a2d-b8e5-050a-a1216d33f89f@suse.com>
Date:   Fri, 22 Jul 2022 13:08:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] btrfs-progs: corrupt generic item data with
 btrfs-corrupt-block
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1657919808.git.boris@bur.io>
 <4c0d4b0003c31f1c1ee1d7a475f70f25663b98f6.1657919808.git.boris@bur.io>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <4c0d4b0003c31f1c1ee1d7a475f70f25663b98f6.1657919808.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.07.22 г. 0:22 ч., Boris Burkov wrote:
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
>   btrfs-corrupt-block.c | 71 +++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> index e961255d5..5c39459db 100644
> --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c
> @@ -98,12 +98,14 @@ static void print_usage(int ret)
>   	printf("\t-m   The metadata block to corrupt (must also specify -f for the field to corrupt)\n");
>   	printf("\t-K <u64,u8,u64> Corrupt the given key (must also specify -f for the field and optionally -r for the root)\n");
>   	printf("\t-f   The field in the item to corrupt\n");
> -	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field to corrupt and root for the item)\n");
> +	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field, or bytes, offset, and value to corrupt and root for the item)\n");
>   	printf("\t-D <u64,u8,u64> Corrupt a dir item corresponding to the passed key triplet, must also specify a field\n");
>   	printf("\t-d <u64,u8,u64> Delete item corresponding to passed key triplet\n");
>   	printf("\t-r   Operate on this root\n");
>   	printf("\t-C   Delete a csum for the specified bytenr.  When used with -b it'll delete that many bytes, otherwise it's just sectorsize\n");
>   	printf("\t--block-group OFFSET  corrupt the given block group\n");
> +	printf("\t-v   Value to use for corrupting item data\n");
> +	printf("\t-o   Offset to use for corrupting item data\n");
>   	exit(ret);
>   }
>   
> @@ -974,6 +976,50 @@ out:
>   	return ret;
>   }
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
>   static int delete_item(struct btrfs_root *root, struct btrfs_key *key)
>   {
>   	struct btrfs_trans_handle *trans;
> @@ -1230,6 +1276,8 @@ int main(int argc, char **argv)
>   	u64 csum_bytenr = 0;
>   	u64 block_group = 0;
>   	char field[FIELD_BUF_LEN];
> +	u64 bogus_value = (u64)-1;
> +	u64 bogus_offset = (u64)-1;

nit: Why the casts, according to 
http://port70.net/~nsz/c/c99/n1256.html#6.3.1.3 :

2 Otherwise, if the new type is unsigned, the value is converted by 
repeatedly adding or subtracting one more than the maximum value that 
can be represented in the new type until the value is in the range of 
the new type.49)

So in this case the correct thing would happen without the casts.


<snip>
