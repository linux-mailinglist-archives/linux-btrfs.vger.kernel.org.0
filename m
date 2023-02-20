Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F5469D4E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 21:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjBTUXI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 15:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjBTUXF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 15:23:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467EC222C8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 12:22:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8C92339C7;
        Mon, 20 Feb 2023 20:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676924520;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f3nVi2qK/OVCIdG//56TIte+IYawYGgjcWwLuvcnxKw=;
        b=O5Uowz1yx1pkErPnKWqHBlljFiV4NSR7c+Yz+JYZMNJpD5ZxOCBAHPEPa7rASq3JqfV6c9
        plZutR1Yx8GSrc+C+pBH7EziYdP2LKnv2nSMHRPiMaz1wSUds2f1u4JPfBndrR8fKV7RT/
        OHDB6WVdKrwrTDBYcl/mYITy3pfFeSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676924520;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f3nVi2qK/OVCIdG//56TIte+IYawYGgjcWwLuvcnxKw=;
        b=kKq6yqh1dLhtOxIfmZec0I2flWEYifhI5AtNytXV0cit2AjrCRMZgZLaodB0aH5Gd4vqhb
        JbmJrZjYY/IJlMCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAF6B139DB;
        Mon, 20 Feb 2023 20:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v8t9KGjW82OQWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Feb 2023 20:22:00 +0000
Date:   Mon, 20 Feb 2023 21:16:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: optimize search_file_offset_in_bio return
 value to bool
Message-ID: <20230220201605.GH10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676041962.git.anand.jain@oracle.com>
 <5ed6a5476b2be3d9b459db87f8e7d24bfadfe02f.1676041962.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed6a5476b2be3d9b459db87f8e7d24bfadfe02f.1676041962.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 11, 2023 at 12:15:55AM +0800, Anand Jain wrote:
> Function search_file_offset_in_bio() finds the file offset in the
> %file_offset_ret, and we use the return value to indicate if it is
> successful, so use bool.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/file-item.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 89e9415b8f06..a879210735aa 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -345,8 +345,8 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
>   *
>   * @inode is used to determine if the bvec page really belongs to @inode.
>   *
> - * Return 0 if we can't find the file offset
> - * Return >0 if we find the file offset and restore it to @file_offset_ret
> + * Return true if we can't find the file offset
> + * Return false if we find the file offset and restore it to @file_offset_ret

The comment seems to not match the code, true is returned when the
offset is found, previously >0. Fixed.

>   */
>  static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
>  				     u64 disk_bytenr, u64 *file_offset_ret)
> @@ -354,7 +354,7 @@ static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
>  	struct bvec_iter iter;
>  	struct bio_vec bvec;
>  	u64 cur = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> -	int ret = 0;
> +	bool ret = false;
>  
>  	bio_for_each_segment(bvec, bio, iter) {
>  		struct page *page = bvec.bv_page;
> @@ -368,7 +368,7 @@ static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
>  		ASSERT(in_range(disk_bytenr, cur, bvec.bv_len));
>  		if (page->mapping && page->mapping->host &&
>  		    page->mapping->host == inode) {
> -			ret = 1;
> +			ret = true;
>  			*file_offset_ret = page_offset(page) + bvec.bv_offset +
>  					   disk_bytenr - cur;
>  			break;
> -- 
> 2.31.1
