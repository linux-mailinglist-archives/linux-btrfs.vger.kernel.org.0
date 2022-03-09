Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F83A4D3093
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiCINxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiCINxA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:53:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE16149BA3
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:52:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A0451F380;
        Wed,  9 Mar 2022 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646833920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3E4Lexf/ilHvYlXvM/qw+LQVjoXcbAzHvCY4kYL6/uo=;
        b=snlqg7m3gAXq5je3Sy7q7J51D3S38+2F12lmNH78jHTNXwHAStmEAC6QXNNZato2oMKVMB
        4eMOqheaVgf6eM7mGSoM78EoV4pgJlqcq+XlbyWzqoN7N/Ij3aMjzcmLeOsqxpdHeVVopd
        WhsAOwAOUluPdMyN+85aIVwPMQHFIDM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C991013D7A;
        Wed,  9 Mar 2022 13:51:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8tRELv+wKGJbLgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 09 Mar 2022 13:51:59 +0000
Message-ID: <766bd883-e688-5a4e-2da9-038bd8bba945@suse.com>
Date:   Wed, 9 Mar 2022 15:51:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 12/12] btrfs: use _offset helpers instead of offsetof in
 generic_bin_search
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1646692306.git.josef@toxicpanda.com>
 <51de9fc987057bc50097fd217e8a3fa51068a49c.1646692306.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <51de9fc987057bc50097fd217e8a3fa51068a49c.1646692306.git.josef@toxicpanda.com>
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



On 8.03.22 г. 0:33 ч., Josef Bacik wrote:
> The starting offset for the items/keys are going to be dependent on
> extent tree v2, use the helpers instead of offsetof directly.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/ctree.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 1a6f24baf33b..6e8c02eec548 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -781,10 +781,10 @@ static noinline int generic_bin_search(struct extent_buffer *eb, int low,
>   	}
>   
>   	if (btrfs_header_level(eb) == 0) {
> -		p = offsetof(struct btrfs_leaf, items);
> +		p = btrfs_item_nr_offset(eb, 0);

nit: This could be switched to BTRFS_LEAF_DATA_OFFSET.

>   		item_size = sizeof(struct btrfs_item);
>   	} else {
> -		p = offsetof(struct btrfs_node, ptrs);
> +		p = btrfs_node_key_ptr_offset(eb, 0);
>   		item_size = sizeof(struct btrfs_key_ptr);
>   	}
>   
