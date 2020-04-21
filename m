Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5788C1B2957
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 16:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDUOWe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 10:22:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27594 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUOWe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 10:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587478953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3M5o0j/VwLdR+lgLRDOMCPqUFFTZqNoZ5Tg/YFjEBd4=;
        b=d4WsTCeAoxtF5HgYRtLIYe4/npHvBl1DWOHrvtM45sagrKfXzhcjLcZ62vo7A3JF+FXKaM
        0kARDup8LJmVS8SfE2gG6DeVf1TjgLpimpJV6YXurVvB87z0UzYW4ghV/YBh7+lRTetc3l
        aUWyr5s1c3E3pC3bP4qnyk0LYmgqjCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-SqmpJyUlNqmoJwn_aPQ4Hg-1; Tue, 21 Apr 2020 10:22:29 -0400
X-MC-Unique: SqmpJyUlNqmoJwn_aPQ4Hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C57D8017F3;
        Tue, 21 Apr 2020 14:22:28 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D94941001B0B;
        Tue, 21 Apr 2020 14:22:27 +0000 (UTC)
Date:   Tue, 21 Apr 2020 10:22:26 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/4] fsx: allow zero range operations to cross eof
Message-ID: <20200421142226.GB32228@bfoster>
References: <20200420170738.9879-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420170738.9879-1-fdmanana@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 20, 2020 at 06:07:38PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently we are limiting the range for zero range operations to stay
> within the i_size boundary. This is not optimal because like this we lose
> coverage of the filesystem's zero range implementation, since zero range
> operations are allowed to cross the i_size. Fix this by limiting the range
> to 'maxfilelen' and not 'file_size', and update the 'file_size' after each
> zero range operation if needed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Thanks for the fixup. Looks good to me now:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  ltp/fsx.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 9d598a4f..56479eda 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1244,6 +1244,17 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
>  	}
>  
>  	memset(good_buf + offset, '\0', length);
> +
> +	if (!keep_size && end_offset > file_size) {
> +		/*
> +		 * If there's a gap between the old file size and the offset of
> +		 * the zero range operation, fill the gap with zeroes.
> +		 */
> +		if (offset > file_size)
> +			memset(good_buf + file_size, '\0', offset - file_size);
> +
> +		file_size = end_offset;
> +	}
>  }
>  
>  #else
> @@ -2141,7 +2152,7 @@ have_op:
>  		do_punch_hole(offset, size);
>  		break;
>  	case OP_ZERO_RANGE:
> -		TRIM_OFF_LEN(offset, size, file_size);
> +		TRIM_OFF_LEN(offset, size, maxfilelen);
>  		do_zero_range(offset, size, keep_size);
>  		break;
>  	case OP_COLLAPSE_RANGE:
> -- 
> 2.11.0
> 

