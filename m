Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB914444A2
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Nov 2021 16:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhKCP2R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Nov 2021 11:28:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56700 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhKCP2Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Nov 2021 11:28:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 77A2A1F782;
        Wed,  3 Nov 2021 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635953139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DG9ns99QS5Bp4/BgyTxGgOhjvHNQXMO8//VRXqqxpAk=;
        b=D14ZmikFcew/3u50gBl0jj81lfqlEQe7ec+W9HLZzUnfddUjGnpJ/dKtnye7fVl40efFHd
        r5KgaECTDDBhMTf5uIr5++HWivcMqVw7oZqexzG0xyMCfJd7RcDVQXkpJDA1pV29SnVtht
        jKnZZ5oShAj4PmXlOWySs+USwiR+j6c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5086A13C91;
        Wed,  3 Nov 2021 15:25:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8Q4VEfOpgmHfNgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 03 Nov 2021 15:25:39 +0000
Subject: Re: [PATCH] btrfs-progs: check: change commit condition in
 fixup_extent_refs()
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211103151554.46991-1-realwakka@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <665f8532-e176-3dc6-ccf0-395672cb3383@suse.com>
Date:   Wed, 3 Nov 2021 17:25:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211103151554.46991-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.11.21 г. 17:15, Sidong Yang wrote:
> This patch fixes potential bugs in fixup_extent_refs(). If
> btrfs_start_transaction() fails in some way and returns error ptr, It
> goes to out logic. But old code checkes whether it is null and it calls
> commit. This patch solves the problem with change the condition to
> checks if it is error by IS_ERR().
> 
> Issue: #409
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  check/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 235a9bab..ca858e07 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -7735,7 +7735,7 @@ static int fixup_extent_refs(struct cache_tree *extent_cache,
>  			goto out;
>  	}
>  out:
> -	if (trans) {
> +	if (!IS_ERR(trans)) {

Actually I think we want to commit the transaction only if ret is not
error, otherwise we run the risk of committing partial changes to the fs.

>  		int err = btrfs_commit_transaction(trans, gfs_info->extent_root);
>  
>  		if (!ret)
> 
