Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B208F3E9EB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 08:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhHLGmH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 02:42:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39456 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhHLGmG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 02:42:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 521611FF18;
        Thu, 12 Aug 2021 06:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628750501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qWVpUkH7Wdhx3rGOMuQ1rpIm5+4jmKokqPXifQTRd3o=;
        b=YftcYR/pP+6IMozIZEY56kP+ZJ2PM4rp+JOf0gj9LUc4r9ubBeLXU41Xj6a/SCNzBA+nIX
        vB5G25mUvwHBSLFpnKigT6TNpRXbPIa82CCyCmnv+7u6rRspUkP6XEOdJnEkrpJ36b/AAZ
        nzLGzyzRfTPdHzvAAGGaSGd6bA8V/gg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2635B1363C;
        Thu, 12 Aug 2021 06:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id j0AXBqXCFGHLcQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 12 Aug 2021 06:41:41 +0000
Subject: Re: [PATCH 3/4] btrfs-progs: map-logical: loosen the required trees
 to open the filesystem
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210812053508.175737-1-wqu@suse.com>
 <20210812053508.175737-4-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <ea8a6615-6b68-deaf-4972-66563794e716@suse.com>
Date:   Thu, 12 Aug 2021 09:41:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812053508.175737-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.08.21 г. 8:35, Qu Wenruo wrote:
> For btrfs-map-logical, it only requires chunk tree to do the
> logicla->physical mapping.
> 
> All othe trees are not really needed.
> 
> Loosen the required trees to make btrfs-map-logical to work better on
> corrupted fs.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  btrfs-map-logical.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
> index 21f00fa20ce8..9f119d08bad8 100644
> --- a/btrfs-map-logical.c
> +++ b/btrfs-map-logical.c
> @@ -261,7 +261,8 @@ int main(int argc, char **argv)
>  	radix_tree_init();
>  	cache_tree_init(&root_cache);
>  
> -	root = open_ctree(dev, 0, 0);
> +	root = open_ctree(dev, 0, OPEN_CTREE_PARTIAL |
> +				  OPEN_CTREE_NO_BLOCK_GROUPS);

nit: OPEN_CTREE_PARTIAL implies ignoring error when opening the csum and
extent tress, since those trees are opened via
setup_root_or_create_block. This tells me that
OPEN_CTREE_NO_BLOCK_GROUPS is redundant and can be removed and replaced
with simply OPEN_CTREE_PARTIAL.

>  	if (!root) {
>  		fprintf(stderr, "Open ctree failed\n");
>  		free(output_file);
> 
