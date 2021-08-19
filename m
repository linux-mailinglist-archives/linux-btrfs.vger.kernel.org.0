Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C813C3F14CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 10:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbhHSIF7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 04:05:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52998 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237366AbhHSIFf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 04:05:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C97CC220AB;
        Thu, 19 Aug 2021 08:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629360298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbt5bilk+mkKsR6yUASoh7dcllM614kqXGh7Nu0wzoo=;
        b=HnGjtNie99tOrT/G6xAkAinVZGXKrEkd3TtISCnDr7ZK/kY3wJGQe0R9Zq9F+r5ZOLjVz2
        ebfGVvrwn220PiBhCmnWbS3zyThRMgeuk66KP7NKpeqJXkqQ5vRjgpHVFqzd9UJanmCUdq
        br/xb1p6xlOVR0VYVzESkpdpD1K4Szg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9B99A136DD;
        Thu, 19 Aug 2021 08:04:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id rc2QIqoQHmE8EgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 19 Aug 2021 08:04:58 +0000
Subject: Re: [PATCH] btrfs: reflink: Assure length != 0 in btrfs_extent_same()
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210818160815.1820-1-realwakka@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <e6423897-3886-73b1-42dc-5e24ca792682@suse.com>
Date:   Thu, 19 Aug 2021 11:04:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818160815.1820-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.08.21 г. 19:08, Sidong Yang wrote:
> btrfs_extent_same() cannot be called with zero length. Because when
> length is zero, it would be filtered by condition in
> btrfs_remap_file_range(). But if this function is used in other case in
> future, it can make ret as uninitialized.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

This is not sufficient, with the assert compiled out the error would
still be in place. It seem that it is sufficient to initialize ret to
some non-arbitrary value i.e -EINVAL ?

> ---
>  fs/btrfs/reflink.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 9b0814318e72..69eb50f2f0b4 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -653,6 +653,7 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
>  	u64 i, tail_len, chunk_count;
>  	struct btrfs_root *root_dst = BTRFS_I(dst)->root;
>  
> +	ASSERT(olen);
>  	spin_lock(&root_dst->root_item_lock);
>  	if (root_dst->send_in_progress) {
>  		btrfs_warn_rl(root_dst->fs_info,
> 
