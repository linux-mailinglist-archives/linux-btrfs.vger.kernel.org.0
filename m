Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC86D1B0E77
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 16:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgDTOeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 10:34:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59794 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726895AbgDTOeF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 10:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587393244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DpVbr6tSMcRmTg3645/1+FPULSloVrxfzPfzAFBRWS0=;
        b=RhkySmNoCArHWpevDP0x1lDHpmYJK12u8hJaaZTzIwN49uy7N3fFMoW/0khxKahmnFypOC
        SK7Wrve7YxhjqR3A22meqrJGklV2iX9oOtYkma8axyygXYBz5q5JcKM/USGY01CDZ1TBLL
        8KrRjZ1WKjeTgN5yaPSqQsWJeY+VLPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-n9SG6eiKM5Ww_gzN2n39Kg-1; Mon, 20 Apr 2020 10:34:02 -0400
X-MC-Unique: n9SG6eiKM5Ww_gzN2n39Kg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F361113784B;
        Mon, 20 Apr 2020 14:34:01 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE6AF27BD8;
        Mon, 20 Apr 2020 14:34:00 +0000 (UTC)
Date:   Mon, 20 Apr 2020 10:33:59 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 4/4] fsx: move range generation logic into a common helper
Message-ID: <20200420143359.GL27516@bfoster>
References: <20200408103627.11514-1-fdmanana@kernel.org>
 <20200417173221.6380-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417173221.6380-1-fdmanana@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 17, 2020 at 06:32:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have very similar code that generates the destination range for clone,
> dedupe and copy_file_range operations, so avoid duplicating the code three
> times and move it into a helper function.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Turned the first parameter of the helper into a boolean as Darrick suggested.
> V3: Added destination offset align by writebdy when bdy_align is true.
> 
>  ltp/fsx.c | 94 ++++++++++++++++++++++++++-------------------------------------
>  1 file changed, 39 insertions(+), 55 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 89a5f60e..2e51169b 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1930,6 +1930,39 @@ range_overlaps(
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
> +			*dst_offset = *dst_offset & writebdy;

That still doesn't look right (and either way we might as well use
consistent logic for readbdy and writebdy).

Brian

> +		else
> +			*dst_offset = *dst_offset & ~(block_size - 1);
> +	} while (range_overlaps(*src_offset, *dst_offset, *size) ||
> +		 *dst_offset + *size > max_range_end);
> +}
> +
>  int
>  test(void)
>  {
> @@ -2004,63 +2037,14 @@ test(void)
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

