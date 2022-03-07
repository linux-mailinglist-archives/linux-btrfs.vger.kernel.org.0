Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77D64CFCB2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 12:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiCGLZR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 06:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbiCGLYP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 06:24:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFE288790
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 02:51:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48083210F3;
        Mon,  7 Mar 2022 10:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646650286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k8BvbbyovOZD9ZbjVcDh7gU+Inq0nRH08s40tLV4VxQ=;
        b=iTNPNPko/LrzCwAm7/PJQJHwO9We220Cy76HDnrjUDldXupucNM63cwEcZGpVV68/zqjE0
        ZkToQ4HauZNJxGfQ1+iip9KNOP6owO5oqt6XARILZ8qFZ35q/Adro3PYPK7EOzb5TLmrz0
        NDz325am9jlWghC3rtMecZi0i7iKPqg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D82713AD8;
        Mon,  7 Mar 2022 10:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3llbAK7jJWKsOAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 07 Mar 2022 10:51:26 +0000
Message-ID: <843daedc-ffb7-658e-89ab-86c20d5db2f1@suse.com>
Date:   Mon, 7 Mar 2022 12:51:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: verify the tranisd of the to-be-written dirty
 extent buffer
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Christoph Anton Mitterer <calestyo@scientia.org>
References: <1f011e6358e042e5ae1501e88377267a2a95c09d.1646183319.git.wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <1f011e6358e042e5ae1501e88377267a2a95c09d.1646183319.git.wqu@suse.com>
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



On 2.03.22 г. 3:10 ч., Qu Wenruo wrote:
> [BUG]
> There is a bug report that a bitflip in the transid part of an extent
> buffer makes btrfs to reject certain tree blocks:
> 
>    BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
> 
> [CAUSE]
> Note the failed transid check, hex(262166) = 0x40016, while
> hex(22) = 0x16.
> 
> It's an obvious bitflip.
> 
> Furthermore, the reporter also confirmed the bitflip is from the
> hardware, so it's a real hardware caused bitflip, and such problem can
> not be detected by the existing tree-checker framework.
> 
> As tree-checker can only verify the content inside one tree block, while
> generation of a tree block can only be verified against its parent.
> 
> So such problem remain undetected.
> 
> [FIX]
> Although tree-checker can not verify it at write-time, we still have a
> quick (but not the most accurate) way to catch such obvious corruption.
> 
> Function csum_one_extent_buffer() is called before we submit metadata
> write.
> 
> Thus it means, all the extent buffer passed in should be dirty tree
> blocks, and should be newer than last committed transaction.
> 
> Using that we can catch the above bitflip.
> 
> Although it's not a perfect solution, as if the corrupted generation is
> higher than the correct value, we have no way to catch it at all.
> 
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
> Link: https://lore.kernel.org/linux-btrfs/2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/disk-io.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b6a81c39d5f4..a89aa523413b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -441,17 +441,31 @@ static int csum_one_extent_buffer(struct extent_buffer *eb)
>   	else
>   		ret = btrfs_check_leaf_full(eb);
>   
> -	if (ret < 0) {
> -		btrfs_print_tree(eb, 0);
> +	if (ret < 0)
> +		goto error;
> +
> +	/*
> +	 * Also check the generation, the eb reached here must be newer than
> +	 * last committed. Or something seriously wrong happened.
> +	 */
> +	if (btrfs_header_generation(eb) <= fs_info->last_trans_committed) {
> +		ret = -EUCLEAN;
>   		btrfs_err(fs_info,
> -			"block=%llu write time tree block corruption detected",
> -			eb->start);
> -		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> -		return ret;
> +			"block=%llu bad generation, have %llu expect > %llu",
> +			  eb->start, btrfs_header_generation(eb),
> +			  fs_info->last_trans_committed);
> +		goto error;

nit: I'd rather have this check in btrfs_check_node/check_leaf functions 
rather than having just this specific check in csum_one_extent_buffer. 
The only thing which is missing AFAICS is the fact the check function 
don't have a context whether we are checking for read or for write. It 
might make sense to extend them to get a boolean param whether the 
validation is for a write or not ?

>   	}
>   	write_extent_buffer(eb, result, 0, fs_info->csum_size);
>   
>   	return 0;
> +error:
> +	btrfs_print_tree(eb, 0);
> +	btrfs_err(fs_info,
> +		"block=%llu write time tree block corruption detected",
> +		eb->start);
> +	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +	return ret;
>   }
>   
>   /* Checksum all dirty extent buffers in one bio_vec */
