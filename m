Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3314461FD
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 11:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhKEKOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 06:14:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51784 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbhKEKOP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 06:14:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64C681FD48;
        Fri,  5 Nov 2021 10:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636107095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ejDMGvgIuDocz2b0aa98zlaQD86AN/VRlLMkw+8Vec=;
        b=JR8Vz4hLNEh4CPaZ3xdW9l99gjCqQCx01yrLKQCHmfNxqr+3swjJuOrsHCsMKGiAHASK5n
        g0O8IS45WEHHGy2R/xhAbmQpZ1bsM9ESdLIuHPUCn0K0o0awp+Y63GiVYhfwP6nlQ0YpAk
        ngQzrYBgROglOwVxNpAWA8jCe//J58Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3401513FBA;
        Fri,  5 Nov 2021 10:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EtY2ClcDhWEafAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 05 Nov 2021 10:11:35 +0000
Subject: Re: [PATCH v4 4/4] btrfs: increase metadata alloc size to 5GB for
 volumes > 50GB
To:     Stefan Roesch <shr@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20211029183950.3613491-1-shr@fb.com>
 <20211029183950.3613491-5-shr@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <443789f1-1b62-80e6-a88d-73e1fd11233b@suse.com>
Date:   Fri, 5 Nov 2021 12:11:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211029183950.3613491-5-shr@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.10.21 г. 21:39, Stefan Roesch wrote:
> This increases the metadata default allocation size from 1GB to 5GB for
> volumes with a size greater than 50GB.

Imo such a change would warrant more data about why it's ok. Clearly
there is some internal facebook workload which benefits from this,
however this doesn't automatically mean it will be beneficial for the
wider user base. Also your cover letter doesn't contain any more
specifics about the particular workload. Isn't 5g a bit too steep,
perhaps 2 is larger and yet more conservative?


> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  fs/btrfs/space-info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 7370c152ce8a..44507262c515 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -195,7 +195,7 @@ static u64 compute_chunk_size_regular(struct btrfs_fs_info *info, u64 flags)
>  
>  	/* Handle BTRFS_BLOCK_GROUP_METADATA */
>  	if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
> -		return SZ_1G;
> +		return 5ULL * SZ_1G;
>  
>  	return SZ_256M;
>  }
> 
