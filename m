Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792C74FBAAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 13:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244669AbiDKLRd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 07:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344023AbiDKLR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 07:17:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CAD11A11
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 04:14:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8F3C215FC;
        Mon, 11 Apr 2022 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649675691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmHGj2VuS0Jf+3WWDK3Z3Ir7SXWFYY8DhUqUoxREQho=;
        b=D3aY06M9xNerxvzNcKp+4f3jNsNvpfUHbFiYlwcERzGmNeB6y6AZ1HTWjc7TaoZqzSB9wl
        zfiFzePoUAaytvo3ZRUwDKo2Og4fB5MTg5IP7dhCY6a7LpVIOk68T0oHeAlgJkR4yIRkYj
        d01CAPvA1YkhHWMHwHcZeyu4Fz1dr58=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6C3513AB5;
        Mon, 11 Apr 2022 11:14:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DBrXJKsNVGIJcwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Apr 2022 11:14:51 +0000
Message-ID: <01f1427d-09fa-cf7c-dec7-95b6fd10bd9d@suse.com>
Date:   Mon, 11 Apr 2022 14:14:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: do not sleep unnecessary on successful batch page
 allocation
Content-Language: en-US
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <1c7f75c138cba65d0af23ad4eda7c1bab1cc21fe.1649666810.git.naohiro.aota@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <1c7f75c138cba65d0af23ad4eda7c1bab1cc21fe.1649666810.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.04.22 г. 12:02 ч., Naohiro Aota wrote:
> After commit 727fd577af04 ("btrfs: wait between incomplete batch memory
> allocations"), fstests btrfs/187 becomes incredibly slow. Before the commit
> it takes 335 seconds to run the test on 8GB ZRAM device running on QEMU.
> But, after that patch, it never finish after 4 hours.
> 
> This is because of unnecessary memalloc_retry_wait() call. If
> alloc_pages_bulk_array() successfully allocated all the requested pages, it
> is no use to call memalloc_retry_wait() to wait for retrying.
> 
> I confirmed the test run time back to 353 seconds with this patch applied.
> 
> Link: https://lore.kernel.org/linux-btrfs/20220411071124.zwtcarqngqqkdd6q@naota-xeon/
> Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>   fs/btrfs/extent_io.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1a5a7ded3175..2681a998ee1c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3150,6 +3150,9 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
>   
>   		allocated = alloc_pages_bulk_array(GFP_NOFS, nr_pages, page_array);
>   
> +		if (allocated == nr_pages)
> +			return 0;
> +
>   		/*
>   		 * During this iteration, no page could be allocated, even
>   		 * though alloc_pages_bulk_array() falls back to alloc_page()
