Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121264461E4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 11:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhKEKHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 06:07:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52242 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhKEKHV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 06:07:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E092E212C0;
        Fri,  5 Nov 2021 10:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636106680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CeuJQKQgNlSqillxodvljQAeKavVgyCj3CgVS52QI8I=;
        b=YhReFoszp22yOB5i/FRrLh39LYL+0c+Dvz09zd6KRP3A4QJv8RD9Gk7WyCDMfZCR2OP9s5
        93xlROtyelJsTLGrBkeI2B3MXvwIZHCT0tdCIBEiRXrLecSqhuzYijGeH9WsmMdar/f4le
        rd8rtCvqC/LsNsWvTU9HjVX0lDos7HM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF9D113B97;
        Fri,  5 Nov 2021 10:04:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id alhgKLgBhWG5eAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 05 Nov 2021 10:04:40 +0000
Subject: Re: [PATCH v4 3/4] btrfs: add force_chunk_alloc sysfs entry to force
 allocation
To:     Stefan Roesch <shr@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20211029183950.3613491-1-shr@fb.com>
 <20211029183950.3613491-4-shr@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3b746e80-9799-3631-96d3-b95081d68fc3@suse.com>
Date:   Fri, 5 Nov 2021 12:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211029183950.3613491-4-shr@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.10.21 г. 21:39, Stefan Roesch wrote:
> This adds the force_chunk_alloc sysfs entry to be able to force a
> storage allocation. This is a debugging and test feature and is
> enabled with the CONFIG_BTRFS_DEBUG configuration option.
> 
> It is stored at
> /sys/fs/btrfs/<uuid>/allocation/<block_type>/force_chunk_alloc.
> ---
>  fs/btrfs/sysfs.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 3b0bcbc2ed2e..983c53b76aa6 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -771,6 +771,64 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
>  	return val;
>  }
>  
> +#ifdef CONFIG_BTRFS_DEBUG
> +/*
> + * Return if space info force allocation chunk flag is set.

nit: Well this is a dummy function which simply returns 0. I guess what
makes sense is to simply make the show op a NULL, i wonder if sysfs can
handle this gracefully though.

<snip>
