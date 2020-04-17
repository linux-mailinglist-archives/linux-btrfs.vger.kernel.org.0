Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70A61AE346
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgDQRK2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:10:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32822 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727986AbgDQRK2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7471yaOL8BT2TykckgEiKJawHl9ogrU3pTiGzhFTvRM=;
        b=OkVz8ITqhagOHVCvEXBJEshaP1gfwcL100ad38KusXMnR/f66dhjAicRpR1970rbq8a/2i
        3aYlq7vwg/N/EpFMZxXgkn/lZT1ZLAcXkHxib4kBBAVyjAX6hiOXYhNn9Pe7l8ctiAhI9Q
        HviTF62BGSc0l+vpXRNyfUj1aDvXCno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-SbW4LFANPu2X6QjKL83Inw-1; Fri, 17 Apr 2020 13:10:24 -0400
X-MC-Unique: SbW4LFANPu2X6QjKL83Inw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BA79801E72;
        Fri, 17 Apr 2020 17:10:23 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDE4B5C219;
        Fri, 17 Apr 2020 17:10:22 +0000 (UTC)
Date:   Fri, 17 Apr 2020 13:10:20 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/4] fsx: add missing file size update on zero range
 operations
Message-ID: <20200417171020.GB13463@bfoster>
References: <20200408103552.11339-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408103552.11339-1-fdmanana@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 08, 2020 at 11:35:52AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When a zero range operation increases the size of the test file we were
> not updating the global variable 'file_size' which tracks the current
> size of the test file. This variable is used to for example compute the
> offset for a source range of clone, dedupe and copy file range operations.
> 
> So just fix it by updating the 'file_size' global variable whenever a zero
> range operation does not use the keep size flag and its range goes beyond
> the current file size.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  ltp/fsx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 9d598a4f..fa383c94 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1212,6 +1212,8 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
>  	}
>  
>  	end_offset = keep_size ? 0 : offset + length;
> +	if (!keep_size && end_offset > file_size)
> +		file_size = end_offset;

Should this ever happen if the caller uses TRIM_OFF_LEN() on the
offset and length?

Brian

>  
>  	if (end_offset > biggest) {
>  		biggest = end_offset;
> -- 
> 2.11.0
> 

