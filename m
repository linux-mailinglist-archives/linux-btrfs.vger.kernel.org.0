Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B27B6B374C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 08:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCJH1t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 02:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCJH1p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 02:27:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E64107D6E
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 23:27:35 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBlxM-1piGOp0Lim-00C7ZE; Fri, 10
 Mar 2023 08:27:27 +0100
Message-ID: <a2464aa9-8ce0-4cc0-6fd6-0355afd19358@gmx.com>
Date:   Fri, 10 Mar 2023 15:27:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 02/20] btrfs: move setting the buffer uptodate out of
 validate_extent_buffer
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230309090526.332550-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZOCuBD+hG6r6bWC4kAvZtjo05t22H7lIYTovJCEeOXLqgutGErs
 J/MzaVllMHiudGsX9BfKOYBzBSSCSr8fhpNLXxsfR8nnuKgpEGpRwdZYROSSZYlM2ssnY+3
 0KAT4FKDP5aCxduC04xSzBzc7MLe50ksw0HwHFXhu+2OzpuFshr3ccEzEQBTEPnYwsklKnZ
 /MIzgYYzhAyL1/kKjGOLQ==
UI-OutboundReport: notjunk:1;M01:P0:3kGXepGPpJU=;iCLqQ1INdBm85tezcyapsoHjmgk
 p+rQMq252fkCAN9sTTkVRnz3JgKCJHRAfAowW6gIrMNZz7tLxMixi2bQFRUgFj95e99/A+YXt
 uLWCXr1JCm0CgCHlEAUmKqGwqa7kaxKbzTEYcHu6Mw0BQYcL7wcA1RWkIbmACorLhYeoh2JP+
 oe1lVCh3284W0/Sh9L2CXOIO4c5fZHyjWP0b0uuxdlThbDTeSqJqd7GqUegLUrcyK3mSjb0wE
 hTAq9y8ufN0SORXHOTYOI3MwHwCMriuZ4Bm6NKbRe5TWqyqcdFhGz9nKRdYcBkG+/D+px6Rcg
 5XavwYdAduadNUTVIcODaay5d9rtu2qnLSgCntZWy4teVlYEC6xyCcVJM7TepvnImp7ZSKj08
 tqeWb/Tpxbs4D46EyxoMprRHoykp16JoJqI8wLuhWKHmKfK8gyLcjRnm19PsFtG2HoRF7kmDB
 04VkVm290tvr0UJaQ/Qs9MqaXq+39icvQYQ7AOuuafKcun1nKwZ+vMa1miAGeMGFJEKQZDtgr
 jYHwotTXLyf7e19AOKH63fimLM7QJTkTZoHuLoRCe6JeBl/BdThToj5d/95JH2dCR7bWJB+j9
 B9QC/dA7gEnjAZ3ooqkDtydH5I3s58aZHTeLSl8ZK8svqSB6IsJ5vq2pjj9VjKHjyFt8h9mrm
 Lcy1GbcG3juPZY8x+Cn/Di2xjY0hZzk1Hg15ZX1Ca0Wgn5KspGLMuC4ekr26JPCtdvhU2Nq5g
 MHeItQ+V8P6o4/iGjtuMww7b2Zf/js+tWiA4aIdnFCDGj7Cdm1vM+rbQBrtcqNDluFHzo/hQp
 XaEj6zTxIsNee7eN3gQxLoNA0YwuoN7eqF5qc9cW14aoHLHexarzoQXcRdL7AEUnybadt2833
 29D3pbPKFGDjbyqKOes4ygIwe2QDEGIW2Oge4x2MXrXeCInSnDoFJbd9tA+Avl7LUxLOG0nb4
 zJDQK3en4RC9G18V0qnwAOMIadQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/9 17:05, Christoph Hellwig wrote:
> Setting the buffer uptodate in a function that is named as a validation
> helper is a it confusing.  Move the call from validate_extent_buffer to
> the one of its two callers that didn't already have a duplicate call
> to set_extent_buffer_uptodate.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index bb864cf2eed60f..7d766eaef4aee7 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -590,9 +590,7 @@ static int validate_extent_buffer(struct extent_buffer *eb,
>   	if (found_level > 0 && btrfs_check_node(eb))
>   		ret = -EIO;
>   
> -	if (!ret)
> -		set_extent_buffer_uptodate(eb);
> -	else
> +	if (ret)
>   		btrfs_err(fs_info,
>   		"read time tree block corruption detected on logical %llu mirror %u",
>   			  eb->start, eb->read_mirror);
> @@ -684,6 +682,8 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
>   		goto err;
>   	}
>   	ret = validate_extent_buffer(eb, &bbio->parent_check);
> +	if (!ret)
> +		set_extent_buffer_uptodate(eb);
>   err:
>   	if (ret) {
>   		/*
