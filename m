Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FC21AE347
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgDQRKf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:10:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54414 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727986AbgDQRKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5PQbxqyj3/fHC51xvMfH+SOqYjpgGF8DVpxpQScCJg=;
        b=CksICl80JzAd18gCawAIQ4kIj+Gd9gq3zi9AdYl+cugTCb8fVXs9Iy07zMdvdKVZhrpl2x
        pNEU8VeyOQHaGUyhmQ3Uq9k9tKsVkbLtjrXDpfQRi6NJsfw3kouY43GjfBExLu6gA516d+
        kOzOJ5gXSwJTgSmTL8AL8tfq/kUKNk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-VTgXsje8Mw-4pu5v70QTfw-1; Fri, 17 Apr 2020 13:10:31 -0400
X-MC-Unique: VTgXsje8Mw-4pu5v70QTfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7787E107B7D8;
        Fri, 17 Apr 2020 17:10:30 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F7227E7CF;
        Fri, 17 Apr 2020 17:10:29 +0000 (UTC)
Date:   Fri, 17 Apr 2020 13:10:28 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/4] fsx: fix infinite/too long loops when generating
 ranges for clone operations
Message-ID: <20200417171028.GC13463@bfoster>
References: <20200408103604.11395-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408103604.11395-1-fdmanana@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 08, 2020 at 11:36:04AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> While running generic/457 I've had fsx taking a lot of CPU time and not
> making any progress for over an hour. Attaching gdb to the fsx process
> revealed that fsx was in the loop that generates the ranges for a clone
> operation, in particular the loop seemed to never end because the range
> defined by 'offset2' kept overlapping with the range defined by 'offset'.
> So far this happened two times in one of my test VMs with generic/457.
> 
> Fix this by breaking out of the loop after trying 30 times, like we
> currently do for dedupe operations, which results in logging the operation
> as skipped.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  ltp/fsx.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index fa383c94..5949ebf0 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2004,16 +2004,24 @@ test(void)
>  			keep_size = random() % 2;
>  		break;
>  	case OP_CLONE_RANGE:
> -		TRIM_OFF_LEN(offset, size, file_size);
> -		offset = offset & ~(block_size - 1);
> -		size = size & ~(block_size - 1);
> -		do {
> -			offset2 = random();
> -			TRIM_OFF(offset2, maxfilelen);
> -			offset2 = offset2 & ~(block_size - 1);
> -		} while (range_overlaps(offset, offset2, size) ||
> -			 offset2 + size > maxfilelen);
> -		break;
> +		{
> +			int tries = 0;
> +
> +			TRIM_OFF_LEN(offset, size, file_size);
> +			offset = offset & ~(block_size - 1);
> +			size = size & ~(block_size - 1);
> +			do {
> +				if (tries++ >= 30) {
> +					size = 0;
> +					break;
> +				}
> +				offset2 = random();
> +				TRIM_OFF(offset2, maxfilelen);
> +				offset2 = offset2 & ~(block_size - 1);
> +			} while (range_overlaps(offset, offset2, size) ||
> +				 offset2 + size > maxfilelen);
> +			break;
> +		}
>  	case OP_DEDUPE_RANGE:
>  		{
>  			int tries = 0;
> -- 
> 2.11.0
> 

