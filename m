Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E940A3E9EB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 08:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhHLGm6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 02:42:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60472 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhHLGm6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 02:42:58 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B130522156;
        Thu, 12 Aug 2021 06:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628750552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6mohj9c8KaGz1DPunKJD0IcQey84b+cV6BnGvAQz28=;
        b=CmGiKnhV/OUENBd64Zz/wGLp7xvgZ8hDofLHzJrZhf8GQetQxxKEhqzTXdkMCm3chhIf1a
        /bxFJeQsXK53gf7+3H0BodzfKQ+TmTmP/OR25rvZp7LiZ7IutZH+kIdxzj1LTQWUMsYO/u
        pEdlNw69kkLexENBQ+tRTgucElv7rnw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8AC371363C;
        Thu, 12 Aug 2021 06:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2v5xH9jCFGH1cQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 12 Aug 2021 06:42:32 +0000
Subject: Re: [PATCH 2/4] btrfs-progs: map-logical: reject unaligned
 logical/bytes pair
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210812053508.175737-1-wqu@suse.com>
 <20210812053508.175737-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <d0141759-2ae0-f425-a020-3ddeb328b144@suse.com>
Date:   Thu, 12 Aug 2021 09:42:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812053508.175737-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.08.21 г. 8:35, Qu Wenruo wrote:
> Btrfs filesystem is a block filesystem, there is no sense to support
> unaligned logical/bytes pair.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  btrfs-map-logical.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
> index eff0b89dbec6..21f00fa20ce8 100644
> --- a/btrfs-map-logical.c
> +++ b/btrfs-map-logical.c
> @@ -289,6 +289,16 @@ int main(int argc, char **argv)
>  
>  	if (bytes == 0)
>  		bytes = root->fs_info->sectorsize;
> +
> +	if (!IS_ALIGNED(logical, root->fs_info->sectorsize) ||
> +	    !IS_ALIGNED(bytes, root->fs_info->sectorsize)) {
> +		ret = -EINVAL;
> +		error(
> +	"invalid logical/bytes, both need to aligned to %u, have %llu and %llu",
> +			root->fs_info->sectorsize, logical, bytes);

In order to be more graceful I'd say print this as a warning and do the
alignment automatically, informing the user this has been performed.

> +		goto close;
> +	}
> +
>  	cur_logical = logical;
>  	cur_len = bytes;
>  
> 
