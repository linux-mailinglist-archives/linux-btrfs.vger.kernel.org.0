Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABA55672C6
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiGEPgE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 11:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiGEPgD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 11:36:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACB417078
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 08:36:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF5DA21A92;
        Tue,  5 Jul 2022 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657035360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wao4i9RZ7N+oJJExXE3qodDUMTwnQxaU2zvQSo3/F+8=;
        b=LU18eqa6HueXEdlPKXxyV7HLy+kNrwqGAPUpYI8nXmgPb/QOqyTWVEOlDWgLq6mlh6Mu5/
        sHZb+OylJwCbjOHgiD5o7aF5sDnAJHrOYeUfH6BEV/sxqhBxjcXJDG4Dt3CuUd92fAzeHe
        NAsV/q0hgVDRDN/1rs+FsF2sETPWn2w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8976A13A79;
        Tue,  5 Jul 2022 15:36:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kVz2HmBaxGJBHgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 05 Jul 2022 15:36:00 +0000
Message-ID: <1376ac49-d51a-8004-d05a-eddfb6dd0d93@suse.com>
Date:   Tue, 5 Jul 2022 18:35:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] btrfs: remove the start argument to check_data_csum
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
References: <20220630160130.2550001-1-hch@lst.de>
 <20220630160130.2550001-4-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220630160130.2550001-4-hch@lst.de>
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



On 30.06.22 г. 19:01 ч., Christoph Hellwig wrote:
> Just derive it from the btrfs_bio now that ->file_offset is always valid.
> Also make the function available outside of inode.c as we'll need that
> soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/ctree.h |  2 ++
>   fs/btrfs/inode.c | 22 +++++++++-------------
>   2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4e2569f84aabc..164f54e6aa447 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3293,6 +3293,8 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
>   unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
>   				    u32 bio_offset, struct page *page,
>   				    u64 start, u64 end);
> +int check_data_csum(struct inode *inode, struct btrfs_bio *bbio, u32 bio_offset,
> +		    struct page *page, u32 pgoff);
>   struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
>   					   u64 start, u64 len);
>   noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a627b2af9e243..429428fde4a88 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3396,20 +3396,18 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
>   /*
>    * check_data_csum - verify checksum of one sector of uncompressed data
>    * @inode:	inode
> - * @io_bio:	btrfs_io_bio which contains the csum
> + * @bbio:	btrfs_io_bio which contains the csum
>    * @bio_offset:	offset to the beginning of the bio (in bytes)
>    * @page:	page where is the data to be verified
>    * @pgoff:	offset inside the page
> - * @start:	logical offset in the file
>    *
>    * The length of such check is always one sector size.
>    *
>    * When csum mismatch is detected, we will also report the error and fill the
>    * corrupted range with zero. (Thus it needs the extra parameters)
>    */
> -static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
> -			   u32 bio_offset, struct page *page, u32 pgoff,
> -			   u64 start)
> +int check_data_csum(struct inode *inode, struct btrfs_bio *bbio, u32 bio_offset,
> +		    struct page *page, u32 pgoff)

nit: The removal of the static could be tucked into the next patch as 
that's where it's being used for the first time.

<snip>
