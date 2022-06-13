Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7772547F8E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 08:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiFMGfd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 02:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiFMGfb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 02:35:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B44BCA0
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 23:35:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 520D31F91B;
        Mon, 13 Jun 2022 06:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655102128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTDXE6jdmVV9z2EL/fu8uUh7cP2qn2IBbZ21Z0mjO4M=;
        b=cBc1KRQTO+8eohQMMuJ2x4JUff0czgC9bUvUXWgtnHgcJiUxPOZSD86VZNuFUXV8GBgw0y
        CHkGqsi1IE8B+0GxP14C8PX/IhXWH6stx4mEacnGrw5WVOcbVz8J09uHHk71gGd/hTlxgj
        jP2c/TgGs6mfR2d8bTMNh35Kl2aVVwQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A4FA134CF;
        Mon, 13 Jun 2022 06:35:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dS+tA7DapmIefgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Jun 2022 06:35:28 +0000
Message-ID: <18ebc43a-05e8-8244-6841-24ed7c304439@suse.com>
Date:   Mon, 13 Jun 2022 09:35:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     willy@infradead.org
References: <20220609164629.30316-1-dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220609164629.30316-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.06.22 г. 19:46 ч., David Sterba wrote:
> Currently the super block page is from the mapping of the block device,
> this is result of direct conversion from the previous buffer_head to bio
> API.  We don't use the page cache or the mapping anywhere else, the page
> is a temporary space for the associated bio.
> 
> Allocate pages for all super block copies at device allocation time,
> also to avoid any later allocation problems when writing the super
> block. This simplifies the page reference tracking, but the page lock is
> still used as waiting mechanism for the write and write error is tracked
> in the page.
> 
> As there is a separate page for each super block copy all can be
> submitted in parallel, as before.
> 
> This was inspired by Matthew's question
> https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> v2:
> 
> - allocate 3 pages per device to keep parallelism, otherwise the
>    submission would be serialized on the page lock
> 
> fs/btrfs/disk-io.c | 42 +++++++++++-------------------------------
>   fs/btrfs/volumes.c | 12 ++++++++++++
>   fs/btrfs/volumes.h |  3 +++
>   3 files changed, 26 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 800ad3a9c68e..8a9c7a868727 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3887,7 +3887,6 @@ static void btrfs_end_super_write(struct bio *bio)
>   			SetPageUptodate(page);
>   		}
>   
> -		put_page(page);
>   		unlock_page(page);
>   	}
>   
> @@ -3974,7 +3973,6 @@ static int write_dev_supers(struct btrfs_device *device,
>   			    struct btrfs_super_block *sb, int max_mirrors)
>   {
>   	struct btrfs_fs_info *fs_info = device->fs_info;
> -	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>   	int i;
>   	int errors = 0;
> @@ -3989,7 +3987,6 @@ static int write_dev_supers(struct btrfs_device *device,
>   	for (i = 0; i < max_mirrors; i++) {
>   		struct page *page;
>   		struct bio *bio;
> -		struct btrfs_super_block *disk_super;
>   
>   		bytenr_orig = btrfs_sb_offset(i);
>   		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
> @@ -4012,21 +4009,17 @@ static int write_dev_supers(struct btrfs_device *device,
>   				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
>   				    sb->csum);
>   
> -		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
> -					   GFP_NOFS);
> -		if (!page) {
> -			btrfs_err(device->fs_info,
> -			    "couldn't get super block page for bytenr %llu",
> -			    bytenr);
> -			errors++;
> -			continue;
> -		}
> -
> -		/* Bump the refcount for wait_dev_supers() */
> -		get_page(page);
> +		/*
> +		 * Super block is copied to a temporary page, which is locked
> +		 * and submitted for write. Page is unlocked after IO finishes.
> +		 * No page references are needed, write error is returned as
> +		 * page Error bit.
> +		 */
> +		page = device->sb_write_page[i];
> +		ClearPageError(page);

In light of Anand's comment about lingering usage of page cache pages 
just a remark:

ClearPageError should be done under the page lock, as well as clearing 
pageuptodate. Subsequently other users of those page can makedo without 
actually calling into page cache but directly working with in-memory 
pages i.e scratching the super block etc.

> +		lock_page(page);
>   


<snip>
