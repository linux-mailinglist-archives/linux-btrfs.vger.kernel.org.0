Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4578360C819
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 11:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJYJak (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 05:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJYJaU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 05:30:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B3CBAF;
        Tue, 25 Oct 2022 02:29:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EBC5D1FDB3;
        Tue, 25 Oct 2022 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666690141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3hqIV0wZfEGGNbJBT4Kj1SM5tbGwTop51vS5maKUNI=;
        b=iklZYoBsKNhjMJ4wTorCWN5TtI7lP6OEUK/v0hqVKvfqWo7u6oBG82yYh0ynNx17tCj8y9
        SaedHE8rtfBX2dY7EB7oOrS2Sv5tmbVdbgfSlzj5qd2hoiq+fKUQpJ+y2YxxDG0w+rBFo1
        ykTU/b6lYYAqPmZdEg5GF6uREsmTvRk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 955FF134CA;
        Tue, 25 Oct 2022 09:29:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YombIV2sV2PiQAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 25 Oct 2022 09:29:01 +0000
Message-ID: <1d9d4d78-073d-fc49-1918-f7c8ab6fe15e@suse.com>
Date:   Tue, 25 Oct 2022 12:29:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] btrfs: volumes: Increase bioc pointer check
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221025082835.3751-1-zeming@nfschina.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20221025082835.3751-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25.10.22 г. 11:28 ч., Li zeming wrote:
> If kzalloc fails to allocate the bioc pointer, NULL is returned
> directly.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

This patch clearly shows you haven't really understood the code. As is 
evident there is __GFP_NOFAIL flag so as per the guarantees for this 
flag we either loop infinitely trying to allocate a bioc or simply 
allocated it. So this check can never be triggered.

NAK
> ---
>   fs/btrfs/volumes.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 064ab2a79c80..f9cb815fe23d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5892,6 +5892,8 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
>   		 */
>   		sizeof(u64) * (total_stripes),
>   		GFP_NOFS|__GFP_NOFAIL);
> +	if (!bioc)
> +		return NULL;
>   
>   	atomic_set(&bioc->error, 0);
>   	refcount_set(&bioc->refs, 1);
