Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90048E8D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 12:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiANLGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jan 2022 06:06:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39030 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiANLGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jan 2022 06:06:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD5542199C;
        Fri, 14 Jan 2022 11:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642158365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5GQsbNODb/boJqO97vFBzxn1VIkOP5hFVYc6+C3Wxg=;
        b=G4FaGjc0m50ZzuAAHu+SiqSvMJ7HZR0NeUeusNZ+N6ahh/cRuExZIfkna2Q9V6bCyI+6vf
        J7y4WGXPr7sRFFl6LahWKBeseo2Y4LnkRKxotAk8ypujdFpJRWr9iR0TMjXyDVs4e0vzIq
        EENBxb4WbftCQF6aKE3gy1ilDII/64I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65B9313BFD;
        Fri, 14 Jan 2022 11:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D82rFR1Z4WFMQQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 14 Jan 2022 11:06:05 +0000
Subject: Re: [PATCH] btrfs: zoned: Remove redundant initialization of to_add
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220114104136.3531-1-jiapeng.chong@linux.alibaba.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <db049584-dc23-78ca-9fc7-0d575855b4ed@suse.com>
Date:   Fri, 14 Jan 2022 13:06:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220114104136.3531-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.01.22 г. 12:41, Jiapeng Chong wrote:
> to_add is being initialized to len but this is never read as
> to_add is overwritten later on. Remove the redundant
> initialization.
> 
> Cleans up the following clang-analyzer warning:
> 
> fs/btrfs/extent-tree.c:2769:8: warning: Value stored to 'to_add' during
> its initialization is never read [clang-analyzer-deadcode.DeadStores].

To make it even better it would be good if to_add is define within the
if (!global_rsv->full) branch.

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/btrfs/extent-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index d89273c4b6b8..37117b62d005 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2766,7 +2766,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>  		spin_unlock(&cache->lock);
>  		if (!readonly && return_free_space &&
>  		    global_rsv->space_info == space_info) {
> -			u64 to_add = len;
> +			u64 to_add;
>  
>  			spin_lock(&global_rsv->lock);
>  			if (!global_rsv->full) {
> 
