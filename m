Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C0A1B2959
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 16:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgDUOWq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 10:22:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21986 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUOWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 10:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587478962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NPS8xBoIVdk3F5yWrHwFenuTv4g4z7gntzX2tpFw+qE=;
        b=SQJpavyaJxZoYNp+W+M5qe0qEqTczb//Tq9/kviVMeA0AuMfNlFPzUEWYbiLIX51XI3O2q
        UjUAz9E1P/zNQChm35mBR6wblMrtLkjWms7I0OwD4q7seBT7bGlmVh8TaHvi0OIuCE/Bwy
        UQmznAkRHb971hNlroHs5gruIXVLohM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258--waoLJK1OIaXnDuVYHj4sg-1; Tue, 21 Apr 2020 10:22:38 -0400
X-MC-Unique: -waoLJK1OIaXnDuVYHj4sg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 122301005510;
        Tue, 21 Apr 2020 14:22:37 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80F50B3A63;
        Tue, 21 Apr 2020 14:22:36 +0000 (UTC)
Date:   Tue, 21 Apr 2020 10:22:34 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 4/4] fsx: move range generation logic into a common helper
Message-ID: <20200421142234.GC32228@bfoster>
References: <20200420170931.10047-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420170931.10047-1-fdmanana@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 20, 2020 at 06:09:31PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have very similar code that generates the destination range for clone,
> dedupe and copy_file_range operations, so avoid duplicating the code three
> times and move it into a helper function.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  ltp/fsx.c | 94 ++++++++++++++++++++++++++-------------------------------------
>  1 file changed, 39 insertions(+), 55 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 40cbd401..7c76655a 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1939,6 +1939,39 @@ range_overlaps(
>  	return llabs((unsigned long long)off1 - off0) < size;
>  }
>  
> +static void generate_dest_range(bool bdy_align,
> +				unsigned long max_range_end,
> +				unsigned long *src_offset,
> +				unsigned long *size,
> +				unsigned long *dst_offset)
> +{
> +	int tries = 0;
> +
> +	TRIM_OFF_LEN(*src_offset, *size, file_size);
> +	if (bdy_align) {
> +		*src_offset -= *src_offset % readbdy;
> +		if (o_direct)
> +			*size -= *size % readbdy;
> +	} else {
> +		*src_offset = *src_offset & ~(block_size - 1);
> +		*size = *size & ~(block_size - 1);
> +	}
> +
> +	do {
> +		if (tries++ >= 30) {
> +			*size = 0;
> +			break;
> +		}
> +		*dst_offset = random();
> +		TRIM_OFF(*dst_offset, max_range_end);
> +		if (bdy_align)
> +			*dst_offset -= *dst_offset % writebdy;
> +		else
> +			*dst_offset = *dst_offset & ~(block_size - 1);
> +	} while (range_overlaps(*src_offset, *dst_offset, *size) ||
> +		 *dst_offset + *size > max_range_end);
> +}
> +
>  int
>  test(void)
>  {
> @@ -2013,63 +2046,14 @@ test(void)
>  			keep_size = random() % 2;
>  		break;
>  	case OP_CLONE_RANGE:
> -		{
> -			int tries = 0;
> -
> -			TRIM_OFF_LEN(offset, size, file_size);
> -			offset = offset & ~(block_size - 1);
> -			size = size & ~(block_size - 1);
> -			do {
> -				if (tries++ >= 30) {
> -					size = 0;
> -					break;
> -				}
> -				offset2 = random();
> -				TRIM_OFF(offset2, maxfilelen);
> -				offset2 = offset2 & ~(block_size - 1);
> -			} while (range_overlaps(offset, offset2, size) ||
> -				 offset2 + size > maxfilelen);
> -			break;
> -		}
> +		generate_dest_range(false, maxfilelen, &offset, &size, &offset2);
> +		break;
>  	case OP_DEDUPE_RANGE:
> -		{
> -			int tries = 0;
> -
> -			TRIM_OFF_LEN(offset, size, file_size);
> -			offset = offset & ~(block_size - 1);
> -			size = size & ~(block_size - 1);
> -			do {
> -				if (tries++ >= 30) {
> -					size = 0;
> -					break;
> -				}
> -				offset2 = random();
> -				TRIM_OFF(offset2, file_size);
> -				offset2 = offset2 & ~(block_size - 1);
> -			} while (range_overlaps(offset, offset2, size) ||
> -				 offset2 + size > file_size);
> -			break;
> -		}
> +		generate_dest_range(false, file_size, &offset, &size, &offset2);
> +		break;
>  	case OP_COPY_RANGE:
> -		{
> -			int tries = 0;
> -
> -			TRIM_OFF_LEN(offset, size, file_size);
> -			offset -= offset % readbdy;
> -			if (o_direct)
> -				size -= size % readbdy;
> -			do {
> -				if (tries++ >= 30) {
> -					size = 0;
> -					break;
> -				}
> -				offset2 = random();
> -				TRIM_OFF(offset2, maxfilelen);
> -				offset2 -= offset2 % writebdy;
> -			} while (range_overlaps(offset, offset2, size) ||
> -				 offset2 + size > maxfilelen);
> -			break;
> -		}
> +		generate_dest_range(true, maxfilelen, &offset, &size, &offset2);
> +		break;
>  	}
>  
>  have_op:
> -- 
> 2.11.0
> 

