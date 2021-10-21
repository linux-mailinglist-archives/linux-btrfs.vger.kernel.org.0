Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8486436637
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhJUP31 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 11:29:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51050 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhJUP3Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 11:29:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C5D1A2198C;
        Thu, 21 Oct 2021 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634830028;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/h5uas0IEOUEzn71YXpfTwJ6JyDWRRYuRQG6zdwEbDI=;
        b=Q5udNCb6JXM45MPLj46nHK+KEV0SbFv1YAk4e90CE+IkrXmZc6E818jTuw6j+6yFAraM6h
        0NlEW7cF28kuVFbCz/sNEjfAck2I5I00HSLP88ZzFUIN75lPqlra7fOo7kCkyjnZsh8+u6
        G/jBfG1+Ri5SRXQ7olPTba8Kw8HEHyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634830028;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/h5uas0IEOUEzn71YXpfTwJ6JyDWRRYuRQG6zdwEbDI=;
        b=UrBJQPylBVo5MnXTtPaj7tUa/+Qwlw1vOPy+l0Zv+Ql7BPD1Ib+L9/E1dyRlnLIVRmaAJP
        kSae9JyiW3ArhzBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 88C4BA3B84;
        Thu, 21 Oct 2021 15:27:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DA842DA7A3; Thu, 21 Oct 2021 17:26:39 +0200 (CEST)
Date:   Thu, 21 Oct 2021 17:26:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: simplify redundant logic judgment
Message-ID: <20211021152639.GB20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qing Wang <wangqing@vivo.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1634714621-58190-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634714621-58190-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 20, 2021 at 12:23:41AM -0700, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> A || (!A && B) is equal to A || B
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  fs/btrfs/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 07ba22dd..e0d2660
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2011,8 +2011,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>  		 * to use run_delalloc_nocow() here, like for  regular
>  		 * preallocated inodes.
>  		 */
> -		ASSERT(!zoned ||
> -		       (zoned && btrfs_is_data_reloc_root(inode->root)));
> +		ASSERT(!zoned || btrfs_is_data_reloc_root(inode->root));

Thanks, but somebody already sent such patch and we'd like to keep it as
it is for clarity.
