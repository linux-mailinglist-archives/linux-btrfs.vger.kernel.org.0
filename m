Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D95A52100E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 10:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbiEJI4R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 04:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238279AbiEJI4E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 04:56:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEB415A3C7
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 01:52:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BDB2D1FA34;
        Tue, 10 May 2022 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652172726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZuV0rubJcUw+nT779qgTrdrZggFZiG5i6+LwKZvq2T0=;
        b=bWcBFcgjyk/ZXw5DkeCChrHRlrqDlxhUuL1D+vSlSTnUj2U2QyrbFZi6JsBuT2vkhEnjgh
        Jooc+ONhN4cSjtrFeTaNWjdr96uMsiD6YDa634gyl+t1wLbFUKK+nNQ/W8Ff0eoiqVtyhr
        /tRDH8UAxuDD6b+08eiOdiCJqqexBsM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94CF013AA5;
        Tue, 10 May 2022 08:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jNmxIbYnemIzHwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 10 May 2022 08:52:06 +0000
Message-ID: <cc5cf170-a5ff-791b-623f-01c893088593@suse.com>
Date:   Tue, 10 May 2022 11:52:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] btrfs: do not account twice for inode ref when reserving
 metadata units
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <bf988d76ebcb9003a16c6b3cd5d25ca94872b93e.1652109795.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <bf988d76ebcb9003a16c6b3cd5d25ca94872b93e.1652109795.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.05.22 г. 18:29 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When reserving metadata units for creating an inode, we don't need to
> reserve one extra unit for the inode ref item because when creating the
> inode, at btrfs_create_new_inode(), we always insert the inode item and
> the inode ref item in a single batch (a single btree insert operation,
> and both ending up in the same leaf).
> 
> As we have accounted already one unit for the inode item, the extra unit
> for the inode ref item is superfluous, it only makes us reserve more
> metadata than necessary and often adding more reclaim pressure if we are
> low on available metadata space.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

That's a neat little optimisation.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>   fs/btrfs/inode.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b42d6e7e4049..adc8b684fe31 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6138,12 +6138,15 @@ int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
>   		(*trans_num_items)++;
>   	} else {
>   		/*
> -		 * 1 to add inode ref
>   		 * 1 to add dir item
>   		 * 1 to add dir index
>   		 * 1 to update parent inode item
> +		 *
> +		 * No need for 1 unit for the inode ref item because it is
> +		 * inserted in a batch together with the inode item at
> +		 * btrfs_create_new_inode().
>   		 */
> -		*trans_num_items += 4;
> +		*trans_num_items += 3;
>   	}
>   	return 0;
>   }
