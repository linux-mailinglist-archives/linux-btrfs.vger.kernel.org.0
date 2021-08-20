Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DDC3F26A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 08:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhHTGJH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 02:09:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49640 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhHTGJF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 02:09:05 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4754021FAF;
        Fri, 20 Aug 2021 06:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629439707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzPobBwT/2VH+4sOJwojCOpyVUOdu0cJq20bNzwRRKU=;
        b=Voidr3lev68Q1jWFEZ+JNgbM89+3v5MNnvznqn8kZtQWZcvOnQlgdft2i5Z8PP7nzchzzH
        A31lMuQvoPT29pcihOVRAvqAUvb/w3wYP3z81EQTSH29j/ZPNdSAZ5p48ONR8C4D0PSEXH
        LEhip8bDFD9RJvMxEPi7zZNs0B3FFKA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0F7CB13883;
        Fri, 20 Aug 2021 06:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ekidANtGH2EsLgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Fri, 20 Aug 2021 06:08:27 +0000
Subject: Re: [PATCH v2] btrfs: reflink: Initialize return value in
 btrfs_extent_same()
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
References: <20210820004100.35823-1-realwakka@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <6902f367-03d3-f732-5864-7c8b19a0f9e1@suse.com>
Date:   Fri, 20 Aug 2021 09:08:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820004100.35823-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20.08.21 г. 3:41, Sidong Yang wrote:
> btrfs_extent_same() cannot be called with zero length. This patch add
> code that initialize ret as -EINVAL to make it safe.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

One minor nit: In this case the variable could have been initialized
during definition to save 1 extra line of code.

> ---
> v2:
>  - Removed assert and added initializing ret
> ---
>  fs/btrfs/reflink.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 9b0814318e72..864f42198c5c 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -653,6 +653,7 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
>  	u64 i, tail_len, chunk_count;
>  	struct btrfs_root *root_dst = BTRFS_I(dst)->root;
>  
> +	ret = -EINVAL;
>  	spin_lock(&root_dst->root_item_lock);
>  	if (root_dst->send_in_progress) {
>  		btrfs_warn_rl(root_dst->fs_info,
> 
