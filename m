Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C454110B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 10:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhITIO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 04:14:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33282 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbhITIOZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 04:14:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9308121F8C;
        Mon, 20 Sep 2021 08:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632125578;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QKYd9sF7XRTOjHRTeV+kbP6E5drbgJizx985U77Zbc=;
        b=DwmgS9nFwkpvTWSw9IqG/11DOfzmsGyK3cbUoxkFzC7oHHvEHT+bHgnsdKySRme55/esAO
        WxZ1eIPXQ/qogrvi6EOqpmFJuHRYbBm2VxyUXf6wyjaz2HWW47iIMIRhYLlG96yZRLrZ6F
        WuVqnYM2b73pIh2AFZtAKZEI26q4Kak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632125578;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QKYd9sF7XRTOjHRTeV+kbP6E5drbgJizx985U77Zbc=;
        b=cIAN8C8en+SKy8M/X6XzGS9S3Wtu7g6TmL8E8oFv7JJ9J5jwwcHBX8C8E3uY91Wfu2SZb9
        Zax2btyqFAbJ1gAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8A279A3BA1;
        Mon, 20 Sep 2021 08:12:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49CA4DA781; Mon, 20 Sep 2021 10:12:47 +0200 (CEST)
Date:   Mon, 20 Sep 2021 10:12:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix initialiser warning in fs/btrfs/tree-checker.c
Message-ID: <20210920081246.GX9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <E1mS5UF-002wsg-0c@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1mS5UF-002wsg-0c@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 19, 2021 at 11:40:39PM +0100, Russell King (Oracle) wrote:
> Debian gcc 10.2.1 complains thusly:
> 
> fs/btrfs/tree-checker.c:1071:9: warning: missing braces
> around initializer [-Wmissing-braces]
>   struct btrfs_root_item ri = { 0 };
>          ^
> fs/btrfs/tree-checker.c:1071:9: warning: (near initialization for 'ri.inode') [-Wmissing-braces]
> 
> Fix it by removing the unnecessary '0' initialiser, leaving the
> braces.
> 
> Fixes: 1465af12e254 ("btrfs: tree-checker: fix false alert caused by legacy btrfs root item")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  fs/btrfs/tree-checker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index a8b2e0d2c025..1737b62756a6 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1068,7 +1068,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
>  			   int slot)
>  {
>  	struct btrfs_fs_info *fs_info = leaf->fs_info;
> -	struct btrfs_root_item ri = { 0 };
> +	struct btrfs_root_item ri = { };

Kees Cook does a tree wide unification to { } because there are some
oddities with partial initialization and { 0 } so this will get fixed
eventually. But again the minimum gcc version is now 5.1 so it won't
matter for 4.9 anyway.
