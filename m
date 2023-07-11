Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB16274F654
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 19:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjGKRCV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjGKRCQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 13:02:16 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C0B7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 10:02:15 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 56DF580BA4;
        Tue, 11 Jul 2023 13:02:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1689094934; bh=2blcNcThL6wuwOQFUP4TOB+rvKYsaoan+GBf3ZMW844=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=fOLWfu+IxU8Qkuo6+A3zCvA5xgXh0Xn91V7ChKCebLtxSmy0hsC+XF4XSWImDCy3j
         xjbRVBYvRnSZPOzLWuIe7K9OLViQ/eMzPV5gVqpkBH4ytCQAVsqZkrnVXvdX3X+OIa
         buMcbDBmD5rbonAVYI0zxKOmxAoUpQCQAUGR/+uF/P4FsduZyFQGf30pudyIS9g4Os
         9JLzx2JVha1dz9M5iXtMuGnHeZ95ShyLoWQ2a/qY8I+0A78bylrdkGrnAokjKLZD7n
         j6R87H3fMAs8MKL9XVMoR7pUBVSeTojIU4koFM9qHmYUCN0LRq73I9veM0z1llSNtx
         4r9mDVNykq20A==
Message-ID: <b0a7f7a2-1aca-836e-f59e-ffd55869c9d6@dorminy.me>
Date:   Tue, 11 Jul 2023 13:02:13 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] btrfs: use write_extent_buffer() to implement
 write_extent_buffer_*id()
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1689061099.git.wqu@suse.com>
 <e86267202871b02aad2359dc42aab05e96102aaa.1689061099.git.wqu@suse.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <e86267202871b02aad2359dc42aab05e96102aaa.1689061099.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6a7abcbe6bec..fef5a7b6c60a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4178,23 +4178,16 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
>   void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
>   		const void *srcv)
>   {
> -	char *kaddr;
> -
> -	assert_eb_page_uptodate(eb, eb->pages[0]);
> -	kaddr = page_address(eb->pages[0]) +
> -		get_eb_offset_in_page(eb, offsetof(struct btrfs_header,
> -						   chunk_tree_uuid));
> -	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
> +	write_extent_buffer(eb, srcv,
> +			    offsetof(struct btrfs_header, chunk_tree_uuid),
> +			    BTRFS_FSID_SIZE);
>   }
>   
>   void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
>   {
> -	char *kaddr;
>   
> -	assert_eb_page_uptodate(eb, eb->pages[0]);
> -	kaddr = page_address(eb->pages[0]) +
> -		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, fsid));
> -	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
> +	write_extent_buffer(eb, srcv, offsetof(struct btrfs_header, fsid),
> +			    BTRFS_FSID_SIZE);
>   }
>   
>   void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,

write_extent_buffer_chunk_tree_uuid() has only one caller in kernel now; 
perhaps inline the function into its only callsite? On the other hand, 
it has several more in -progs, so maybe the name is useful and it could 
be moved it into extent_io.h since it's such a thin wrapper around 
write_extent_buffer()?

write_extent_buffer_fsid() has three in kernel and five in -progs, maybe 
also into the .h?
