Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6238612C3A
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Oct 2022 19:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJ3ScN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Oct 2022 14:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ3ScM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Oct 2022 14:32:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70DC626C;
        Sun, 30 Oct 2022 11:32:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4D19733A0B;
        Sun, 30 Oct 2022 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667154729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ctx2ecB8mk87ajFyjy6myM7ABsa5iflpDws37hICbmU=;
        b=uQmv86USpdad9Sm3bF7HJHqa2Y5dt6xoXsYoGiR2iFTVx5ZzD/V8BTW2zzyYQXTlevXSbL
        NpMabeq3bokOrawR5vu9zvQHrdOxqyPZat+ewJjV+ai+y3/gD/P+nLApLoAqkB1JNnCHS+
        WMh8cHmKr+2fR+p5Zv39lofeboQFGBE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF61513A37;
        Sun, 30 Oct 2022 18:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rBHmLyjDXmPXdQAAMHmgww
        (envelope-from <nborisov@suse.com>); Sun, 30 Oct 2022 18:32:08 +0000
Message-ID: <4c92f908-f7e0-30d1-13a0-0230cc99f9ca@suse.com>
Date:   Sun, 30 Oct 2022 20:32:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] btrfs: Fix a memory allocation failure test
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <34dff6b621770b1f8078ce6c715b61c5908e1ad1.1667115312.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <34dff6b621770b1f8078ce6c715b61c5908e1ad1.1667115312.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.10.22 г. 9:35 ч., Christophe JAILLET wrote:
> 'dip' is tested instead of 'dip->csums'.
> Fix it.
> 
> Fixes: 642c5d34da53 ("btrfs: allocate the btrfs_dio_private as part of the iomap dio bio")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 966cc050cdbb..3bbd2dc6282f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8078,7 +8078,7 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
>   		 */
>   		status = BLK_STS_RESOURCE;
>   		dip->csums = kcalloc(nr_sectors, fs_info->csum_size, GFP_NOFS);
> -		if (!dip)
> +		if (!dip->csums)
>   			goto out_err;
>   
>   		status = btrfs_lookup_bio_sums(inode, dio_bio, dip->csums);
