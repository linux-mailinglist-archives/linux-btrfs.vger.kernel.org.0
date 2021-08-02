Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285C03DD150
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 09:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhHBHkI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 03:40:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42740 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhHBHkI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Aug 2021 03:40:08 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B55451FF3C;
        Mon,  2 Aug 2021 07:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627889998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6lgmF6NcYEnlGoOP7APHzuGZ1iFHfcqF1Y6yKIIhpsI=;
        b=RnJB0VnVyw9SPyhVf3Yh+CI3TzJG56YtK7GrzlAX4JC1Gwfu1L+nYdolgYuN0NOniVQlvF
        QfJ7qm48t8HV0OlFOCWY+lS1mgbfG7AqsbT9qqMxvyobQEsQ2ENEdBPdwvSy5xNcI+C3WB
        xhKM63JWhN2VpKF2a1tlCt/YjLLSLwg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7A85A1363C;
        Mon,  2 Aug 2021 07:39:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id +ShKG06hB2GbdwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 02 Aug 2021 07:39:58 +0000
Subject: Re: [PATCH] btrfs: send: Simplify send_create_inode_if_needed
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, fdmanana@suse.com
References: <20210801233549.25480-1-mpdesouza@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <ab7f7888-75f8-8145-1b7b-c77888a038b6@suse.com>
Date:   Mon, 2 Aug 2021 10:39:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210801233549.25480-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.08.21 г. 2:35, Marcos Paulo de Souza wrote:
> The out label is being overused, we can simply return if the condition
> permits.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/send.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 75cff564dedf..17cd67e41d3a 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -2727,19 +2727,12 @@ static int send_create_inode_if_needed(struct send_ctx *sctx)
>  	if (S_ISDIR(sctx->cur_inode_mode)) {
>  		ret = did_create_dir(sctx, sctx->cur_ino);
>  		if (ret < 0)
> -			goto out;
> -		if (ret) {
> -			ret = 0;
> -			goto out;
> -		}
> +			return ret;
> +		if (ret > 0)
> +			return 0;

nit: Personally I'd prefer in such cases to use an if/else if construct
since which branch is taken is dependent on the same value. To me using
an if/else if is a more explicit way to say "those 2 branches are
directly related). However it's not a big deal.

>  	}
>  
> -	ret = send_create_inode(sctx, sctx->cur_ino);
> -	if (ret < 0)
> -		goto out;
> -
> -out:
> -	return ret;
> +	return send_create_inode(sctx, sctx->cur_ino);
>  }
>  
>  struct recorded_ref {
> 
