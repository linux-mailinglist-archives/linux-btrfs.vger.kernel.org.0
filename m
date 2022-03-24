Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5D64E6818
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 18:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbiCXRy2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 13:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiCXRy0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 13:54:26 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCA9B53D7
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 10:52:54 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id F12DE806B3;
        Thu, 24 Mar 2022 13:52:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648144374; bh=oOFzE/TdISs2kCrPv5dmVJIe8ckhXTTed7unKPMbcUY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vBoARiRfXIO8q8t9DZcJCxqV6A0GkgNhDWHufLcV+leJ9o+1xRuQvoP7IXiEwDeYm
         aBk6dbESgAnkOeF7fvN3vum2ADjplh/ZmXhHTnuQWQlfRc4IosBvhBfuvJjn4vcHT8
         AOcCuqc0bCSolLuEeiI8oHTiyucKMq7D5IyRUgYILg6MzAS7l7Z/WiG/Jo4rVM7aFa
         xmjcNlikdYzL9glaCukYGFTjk3BNkDjTFARqvQmjbHsEfF7VPeZGgjPXADGBrqWGys
         2PPy/ANQGWNpSgX89fYvp+GsSH9kHnAuTCTPFfU7phvF6UHhjgv6Dg6Ey/JpMO0cBa
         KAWOt/Hf+t3ZA==
Message-ID: <757b48b9-db01-e8d0-ec64-02443828dd7a@dorminy.me>
Date:   Thu, 24 Mar 2022 13:52:53 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v14 4/7] btrfs: send: write larger chunks when using
 stream v2
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1647537027.git.osandov@fb.com>
 <2ac307b0d20f84a09302d9d4f7c4fa1207edccc7.1647537027.git.osandov@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <2ac307b0d20f84a09302d9d4f7c4fa1207edccc7.1647537027.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 1f141de3a7d6..02053fff80ca 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -82,6 +82,7 @@ struct send_ctx {
>   	char *send_buf;
>   	u32 send_size;
>   	u32 send_max_size;
> +	bool put_data;
put_data's use seems to be about making sure put_data_header() isn't 
called more than once, which is not super obvious to me from the name; 
perhaps one of 'data_header_{set,setup,initialized}' might make it 
clearer? Or if it's actually about put_file_data, maybe moving the 
assertion there would make that clearer?
>   static int put_data_header(struct send_ctx *sctx, u32 len)
>   {
> -	struct btrfs_tlv_header *hdr;
> +	if (WARN_ON_ONCE(sctx->put_data))
> +		return -EINVAL;
> +	sctx->put_data = true;
> +	if (sctx->proto >= 2) {
> +		/*
> +		 * In v2, the data attribute header doesn't include a length; it
> +		 * is implicitly to the end of the command.
> +		 */
> +		if (sctx->send_max_size - sctx->send_size < 2 + len)
> +			return -EOVERFLOW;
> +		put_unaligned_le16(BTRFS_SEND_A_DATA,
> +				   sctx->send_buf + sctx->send_size);
> +		sctx->send_size += 2;
> +	} else {
> +		struct btrfs_tlv_header *hdr;
>   
> -	if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
> -		return -EOVERFLOW;
> -	hdr = (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size);
> -	put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
> -	put_unaligned_le16(len, &hdr->tlv_len);
> -	sctx->send_size += sizeof(*hdr);
> +		if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
> +			return -EOVERFLOW;
> +		hdr = (struct btrfs_tlv_header *)(sctx->send_buf +
> +						  sctx->send_size);
> +		put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
> +		put_unaligned_le16(len, &hdr->tlv_len);
> +		sctx->send_size += sizeof(*hdr);
> +	}
>   	return 0;
>   }

I wish the 2s were named, and that there were more commonality between 
the two branches... Might I propose this alternative? It doesn't check 
the length's suitability until after adding the two fields, but I don't 
think anything bad happens from delaying the check.

static int put_data_header(struct send_ctx *sctx, u32 len)
{
         struct btrfs_tlv_header *hdr =
                 (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size);

         if (WARN_ON_ONCE(sctx->put_data))
                 return -EINVAL;
         sctx->put_data = true;

         put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
         sctx->send_size += sizeof(hdr->tlv_type);
                                                                                                                        
         /*
          * In v2+, the data attribute header doesn't include a length; it is
          * implicitly to the end of the command.
          */
         if (sctx->proto == 1) {
                 put_unaligned_le16(len, &hdr->tlv_len);
                 sctx->send_size += sizeof(hdr->tlv_len);
         }

         if (sctx->send_max_size - sctx->send_size < len)
                 return -EOVERFLOW;

         return 0;
}

