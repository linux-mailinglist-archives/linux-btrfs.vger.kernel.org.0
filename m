Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB4D44635D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 13:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhKEMan (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 08:30:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58792 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhKEMam (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 08:30:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 56AEE1FD48;
        Fri,  5 Nov 2021 12:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636115281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qy7qM6tsegDv130WHVbzxvoBhS7uJT0hwAnyTXDCcQw=;
        b=PvgDrMyTWM0e8bTfZzjlAHG5HxdQ5EbcHnLS81JIVz7xyvLdyCH7AGfEB7A3czKNCsk1p9
        vg7j9YfBDN6Zly3m3G46xcT2sMMvPqqAuJP3QIHX5eW4MjMBgGLLRApDnvu2bW1Dv8+2Ia
        tDCg0fXiKqPbkbDjQj6dWuTD03nK/mA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3200D13FFD;
        Fri,  5 Nov 2021 12:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UjexCVEjhWFzRwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 05 Nov 2021 12:28:01 +0000
Subject: Re: [PATCH v2] btrfs-progs: check: change commit condition in
 fixup_extent_refs()
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211104141610.48818-1-realwakka@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7f57af76-b994-e558-5aef-22f8644d3aef@suse.com>
Date:   Fri, 5 Nov 2021 14:28:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211104141610.48818-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.11.21 г. 16:16, Sidong Yang wrote:
> This patch fixes potential bugs in fixup_extent_refs(). If
> btrfs_start_transaction() fails in some way and returns error ptr, It
> goes to out logic. But old code checkes whether it is null and it calls
> commit. This patch solves the problem with make that it calls only if
> ret is no error.
> 
> Issue: #409
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
> v2:
>  - Checks ret as well as trans
> ---
>  check/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 235a9bab..ddcc5c44 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -7735,7 +7735,7 @@ static int fixup_extent_refs(struct cache_tree *extent_cache,
>  			goto out;
>  	}
>  out:
> -	if (trans) {
> +	if (!ret && !IS_ERR(trans)) {
>  		int err = btrfs_commit_transaction(trans, gfs_info->extent_root);
>  
>  		if (!ret)
> 
