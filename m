Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520C41AE35B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgDQRLG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:11:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56168 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729229AbgDQRKn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kTYlNUK8aZh2HZI7/gj8fAi//1r8+x8BoHU4tJzCuHc=;
        b=Mno2TMkYY9/ddLJElXRIYvEnwN7S2DNVo9ubJNW2hqBao33e6YoCoDiEJwMGXCZTV0D1B6
        ycykass+Bggaw3V2zU7Fppc73cW3yXHkXu3yvCkvGvcAaoxMG/QtZkpBvmLrrqPpCygTCS
        mnKK5zU2GBB3is18UgFFLux4oSN8mvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-8SSolWJdPeu68yxd88y3EQ-1; Fri, 17 Apr 2020 13:10:40 -0400
X-MC-Unique: 8SSolWJdPeu68yxd88y3EQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F2BC1005513;
        Fri, 17 Apr 2020 17:10:39 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1665110027B4;
        Fri, 17 Apr 2020 17:10:39 +0000 (UTC)
Date:   Fri, 17 Apr 2020 13:10:37 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 3/4] fsx: fix infinite/too long loops when generating
 ranges for copy_file_range
Message-ID: <20200417171037.GD13463@bfoster>
References: <20200408103616.11458-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408103616.11458-1-fdmanana@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 08, 2020 at 11:36:16AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> While running generic/521 I've had fsx taking a lot of CPU time and not
> making any progress for several hours. Attaching gdb to the fsx process
> revealed that fsx was in the loop that generates the ranges for a
> copy_file_range operation, in particular the loop seemed to never end
> because the range defined by 'offset2' kept overlapping with the range
> defined by 'offset'.
> So far this happened one time only in one of my test VMs with generic/521.
> 
> Fix this by breaking out of the loop after trying 30 times, like we
> currently do for dedupe operations, which results in logging the operation
> as skipped.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  ltp/fsx.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 5949ebf0..89a5f60e 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2042,17 +2042,25 @@ test(void)
>  			break;
>  		}
>  	case OP_COPY_RANGE:
> -		TRIM_OFF_LEN(offset, size, file_size);
> -		offset -= offset % readbdy;
> -		if (o_direct)
> -			size -= size % readbdy;
> -		do {
> -			offset2 = random();
> -			TRIM_OFF(offset2, maxfilelen);
> -			offset2 -= offset2 % writebdy;
> -		} while (range_overlaps(offset, offset2, size) ||
> -			 offset2 + size > maxfilelen);
> -		break;
> +		{
> +			int tries = 0;
> +
> +			TRIM_OFF_LEN(offset, size, file_size);
> +			offset -= offset % readbdy;
> +			if (o_direct)
> +				size -= size % readbdy;
> +			do {
> +				if (tries++ >= 30) {
> +					size = 0;
> +					break;
> +				}
> +				offset2 = random();
> +				TRIM_OFF(offset2, maxfilelen);
> +				offset2 -= offset2 % writebdy;
> +			} while (range_overlaps(offset, offset2, size) ||
> +				 offset2 + size > maxfilelen);
> +			break;
> +		}
>  	}
>  
>  have_op:
> -- 
> 2.11.0
> 

