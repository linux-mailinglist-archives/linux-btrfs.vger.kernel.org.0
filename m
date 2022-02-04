Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0524A9CF5
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376571AbiBDQ3J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 11:29:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34024 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiBDQ3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 11:29:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 87F91210F5;
        Fri,  4 Feb 2022 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643992147;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZR/3H3sIf6cDzCGCpTV09wbV22n9oSyBNgBb9XFveVs=;
        b=ufR/iQ3awxDdyE/sGNRAFqh5y6bdZR18EDMLm/w4lAJGrCv4OWn8m2+fBhBtkk1WF+7h2t
        +GvsT8FMZ9XPjQ75oGVW113p8c7PvkseZKl60IME9fZBo/9Ofp8Yy0qlKYDvp9U/PTeh3x
        mmDVGGfMyWj1TC4DPDso9b8YaIdQ3Kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643992147;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZR/3H3sIf6cDzCGCpTV09wbV22n9oSyBNgBb9XFveVs=;
        b=mPvLfYOg7piogHCpj+bClsKvH9PqZmko6vp5TVeZ0sF0R667rVkaD+UFN1JI0xBpkB9cr2
        2/TIgMV01VCgdBCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7EDB7A3B8E;
        Fri,  4 Feb 2022 16:29:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D3229DA781; Fri,  4 Feb 2022 17:28:21 +0100 (CET)
Date:   Fri, 4 Feb 2022 17:28:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: in case of IO error log inode
Message-ID: <20220204162821.GD14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org
References: <20220202201437.7718-1-davispuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220202201437.7718-1-davispuh@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 02, 2022 at 10:14:37PM +0200, Dāvis Mosāns wrote:
> Currently if we get IO error while doing send then we abort without
> logging information about which file caused issue.
> So log inode to help with debugging.

The Signed-off-by tag is missing.

> ---
>  fs/btrfs/send.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index d8ccb62aa7d2..945d9c01d902 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -5000,6 +5000,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
>  			if (!PageUptodate(page)) {
>  				unlock_page(page);
>  				put_page(page);
> +				btrfs_err(fs_info, "received IO error for inode=%llu", sctx->cur_ino);

A message here makes sense. I'd make it more explicit that it's for send
(the word "received" is kind of confusing), the inode number is not
unique identifier so the root id should be also printed, it's available
from the sctx->send_root and maybe also the file offset (taken from the
associated page by page_offset()).
