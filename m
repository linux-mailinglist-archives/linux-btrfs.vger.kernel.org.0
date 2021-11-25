Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EEE45D80C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 11:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354485AbhKYKRM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 05:17:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46272 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348687AbhKYKPM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 05:15:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F8A221954;
        Thu, 25 Nov 2021 10:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637835120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5RX7ivBwOWf/bFD/GJbHhfXII0Ai46b7xucinIeid6w=;
        b=nKpWk+1JKCurglERytwXC6b6AdPhpZsKn8yVxoxQH9JWA/wdc538rpkEsKplGkao93xqzC
        iqNgt+BQe+ybPYTj7wY4CAkSmkyQRp8yYAm6tVjcEjRkShT4yCYzlcfH9SwBMNhQBSPySa
        YcC9bOnCmni1Z0D4+asrRA9FOFuvxeU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 231F413F5A;
        Thu, 25 Nov 2021 10:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GcWxBXBhn2F/OQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 25 Nov 2021 10:12:00 +0000
Subject: Re: [PATCH 12/25] btrfs: use chunk_root in
 find_free_extent_update_loop
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636144971.git.josef@toxicpanda.com>
 <ded3b6f8c2730943739f2c88f88241994ce53612.1636144971.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3305a261-5596-c05b-e4b2-3ea5da32f4b9@suse.com>
Date:   Thu, 25 Nov 2021 12:11:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ded3b6f8c2730943739f2c88f88241994ce53612.1636144971.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.11.21 г. 22:45, Josef Bacik wrote:
> We're only using this to start the transaction with to possibly allocate
                                                  ^^
delete "with"

> a chunk.  It doesn't really matter which root to use, but with extent
> tree v2 we'll need a bytenr to look up a extent root which makes the
> usage of the extent_root awkward here.  Simply change it to the
> chunk_root.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index c33f3dc6b322..f40b97072231 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3977,7 +3977,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>  					struct find_free_extent_ctl *ffe_ctl,
>  					bool full_search)
>  {
> -	struct btrfs_root *root = fs_info->extent_root;
> +	struct btrfs_root *root = fs_info->chunk_root;
>  	int ret;
>  
>  	if ((ffe_ctl->loop == LOOP_CACHING_NOWAIT) &&
> 
