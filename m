Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD75C53E8D4
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiFFKl6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 06:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiFFKl4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 06:41:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6145EDE1
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 03:41:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B600A1F7AB;
        Mon,  6 Jun 2022 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654512111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qBqFwZCzuyr7XCH0MWG3gBM5DU3KHbdrwVY/aQR3lkk=;
        b=JP/rv8+XLsC8zeWsOlQ62mzTjntWeDCtsXYAZvYwJP+cbn6btCOCCoTQb/zHp6DJ6xJrvs
        y5jDz9MwZMwD/kV2MaphBn8UVqg266E5h/vTdwWMzX2iT/4TGkkujWDyeCMD9v2j2vwroK
        0X1vSHD1HYrijWCUR7QqdWOhEkCcxg8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 762E4139F5;
        Mon,  6 Jun 2022 10:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QC0CGu/ZnWI7GwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 06 Jun 2022 10:41:51 +0000
Message-ID: <0eb3ddf9-af5f-e67f-c8f8-17c80c731359@suse.com>
Date:   Mon, 6 Jun 2022 13:41:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] btrfs: pass the btrfs_bio_ctrl to submit_one_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220603071103.43440-1-hch@lst.de>
 <20220603071103.43440-4-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220603071103.43440-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.06.22 г. 10:11 ч., Christoph Hellwig wrote:
> submit_one_bio always works on the bio and compression flags from a
> btrfs_bio_ctrl structure.  Pass the explicitly and clean up the the
> calling conventions by handling a NULL bio in submit_one_bio, and
> using the btrfs_bio_ctrl to pass the mirror number as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 82 ++++++++++++++++++++------------------------
>   1 file changed, 37 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 72a258fa27947..facca7feb9a22 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -144,6 +144,7 @@ struct tree_entry {
>    */
>   struct btrfs_bio_ctrl {
>   	struct bio *bio;
> +	int mirror_num;
>   	enum btrfs_compression_type compress_type;
>   	u32 len_to_stripe_boundary;
>   	u32 len_to_oe_boundary;
> @@ -178,10 +179,11 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
>   	return ret;
>   }
>   
> -static void submit_one_bio(struct bio *bio, int mirror_num,
> -			   enum btrfs_compression_type compress_type)
> +static void __submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   {
> +	struct bio *bio = bio_ctrl->bio;
>   	struct inode *inode = bio_first_page_all(bio)->mapping->host;
> +	int mirror_num = bio_ctrl->mirror_num;
>   
>   	/* Caller should ensure the bio has at least some range added */
>   	ASSERT(bio->bi_iter.bi_size);
> @@ -191,14 +193,17 @@ static void submit_one_bio(struct bio *bio, int mirror_num,
>   	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
>   		btrfs_submit_data_write_bio(inode, bio, mirror_num);
>   	else
> -		btrfs_submit_data_read_bio(inode, bio, mirror_num, compress_type);
> +		btrfs_submit_data_read_bio(inode, bio, mirror_num,
> +					   bio_ctrl->compress_type);
>   
> -	/*
> -	 * Above submission hooks will handle the error by ending the bio,
> -	 * which will do the cleanup properly.  So here we should not return
> -	 * any error, or the caller of submit_extent_page() will do cleanup
> -	 * again, causing problems.
> -	 */
> +	/* The bio is owned by the bi_end_io handler now */
> +	bio_ctrl->bio = NULL;
> +}
> +
> +static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> +{
> +	if (bio_ctrl->bio)
> +		__submit_one_bio(bio_ctrl);
>   }

Why do you need a function just to put an if in it, just move this atop 
__submit_one_bio :

if (!bio_ctrl->bio)
     return

and rename it to submit_one_bio.

<snip>
