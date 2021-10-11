Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32C64287B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 09:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhJKHen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 03:34:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54714 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhJKHem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 03:34:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E63622034;
        Mon, 11 Oct 2021 07:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633937562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7YVC7ZUjE+rqTJ8wP0zTOgmAurZ5Z7ls5Hwt5/ohus=;
        b=f6fV0GcxqQPfppUQkZhg2uqP7qf8anNSShT6RA0pd8YnPiBO7N40F6lwDq6VNptvLi6vtl
        7jqb/tjkVa9OrOzE6WPPDtasIzZVGvtbctX5+apvk7GtLv79/ozJrQT59C9U8Gd6bdo9HD
        NuG59/pK3716Fju2s3Q8hMW/Dmcj7xI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2813213BF1;
        Mon, 11 Oct 2021 07:32:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CokiB5roY2H8XQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Oct 2021 07:32:42 +0000
Subject: Re: [PATCH] btrfs-progs: parse-utils: allow single number qgroup id
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20211011070937.32419-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <408b0936-8793-a89b-6fa1-b852e10ddcfb@suse.com>
Date:   Mon, 11 Oct 2021 10:32:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011070937.32419-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.10.21 г. 10:09, Qu Wenruo wrote:
> [BUG]
> Since btrfs-progs v5.14, fstests/btrfs/099 always fail with the
> following output in 099.full:
> 
>   ...
>   # /usr/bin/btrfs quota enable /mnt/scratch
>   # /usr/bin/btrfs qgroup limit 134217728 5 /mnt/scratch
>   ERROR: invalid qgroupid or subvolume path: 5
>   failed: '/usr/bin/btrfs qgroup limit 134217728 5 /mnt/scratch'
> 
> [CAUSE]
> Since commit cb5a542871f9 ("btrfs-progs: factor out plain qgroupid
> parsing"), btrfs qgroup parser no longer accepts single number qgroup id
> like "5" used in that test case.
> 
> That commit is not a plain refactor without functional change, but
> removed a simple feature.
> 
> [FIX]
> Add back the handling for single number qgroupid.
> 
> Fixes: cb5a542871f9 ("btrfs-progs: factor out plain qgroupid parsing")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Tested-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  common/parse-utils.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/common/parse-utils.c b/common/parse-utils.c
> index ad57b74a7b64..863ca9f25fd8 100644
> --- a/common/parse-utils.c
> +++ b/common/parse-utils.c
> @@ -290,6 +290,12 @@ int parse_qgroupid(const char *str, u64 *qgroupid)
>  	level = strtoull(str, &end, 10);
>  	if (str == end)
>  		return -EINVAL;
> +	/* We accept single qgroupid like "5", to indicate "0/5"*/
> +	if (end[0] == '\0') {
> +		*qgroupid = level;
> +		return 0;
> +	}
> +	/* Otherwise qgroupid must go like "1/256" */
>  	if (end[0] != '/')
>  		return -EINVAL;
>  	str = end + 1;
> 
