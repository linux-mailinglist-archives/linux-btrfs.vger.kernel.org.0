Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEF3422CDD
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 17:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhJEPrN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 11:47:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57064 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbhJEPrM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 11:47:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 630B2223E4;
        Tue,  5 Oct 2021 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633448720;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uuo619kt7bkNKFrrKl8h3u4o5idsWzi7mbnu9WkaSzE=;
        b=kGvHdt8iCTviLzycUyVbHF8p7RLV1h3jNsLKBo0E+dEG1RLkyRNFoHbyIFXBHO3anrBH0M
        2BxkE0b3xNkKYP6uhWyoQwhhJu7mgKamcG9lMv5+J1ZFAYunL5tgdlkUcC68VrIkbi2yQq
        rPx9vU+GalY6hhJzhs0JBX/+l8dSmm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633448720;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uuo619kt7bkNKFrrKl8h3u4o5idsWzi7mbnu9WkaSzE=;
        b=E9aKGj5wuWtUQDJLDtfVoqVyBgSc5dnpxcov91wLXfjBk2U+Z/CVtuB3m21UQEvz2lwj7Y
        Gfx3+C5CTaYQLfCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 59DF7A3B81;
        Tue,  5 Oct 2021 15:45:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9057DDA7F3; Tue,  5 Oct 2021 17:45:00 +0200 (CEST)
Date:   Tue, 5 Oct 2021 17:45:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: add otime support to send_utimes()
Message-ID: <20211005154500.GG9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Hamza Mahfooz <someguy@effective-light.com>,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211005153514.4281-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005153514.4281-1-someguy@effective-light.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 05, 2021 at 11:35:14AM -0400, Hamza Mahfooz wrote:
> Commit 766702ef49b8 ("Btrfs: add/fix comments/documentation for
> send/receive") suggests that, otime support should be added to
> send_utimes() after btrfs gets otime support. So, since btrfs has had otime
> support for many years, we should add otime support to send_utimes().
> 
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
>  fs/btrfs/send.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 72f9b865e847..0bee9f7a45da 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -2544,7 +2544,7 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
>  	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_ATIME, eb, &ii->atime);
>  	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_MTIME, eb, &ii->mtime);
>  	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_CTIME, eb, &ii->ctime);
> -	/* TODO Add otime support when the otime patches get into upstream */

Are you going after TODOs in the btrfs code? Some of them are stale or
don't reveal the real scope of the required changes.

> +	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_OTIME, eb, &ii->otime);

For example this adds a new data to 'utimes' in the protocol v1, which
would require a major update. One such update is in progress and would
probably gather all pending updates though I'm not sure is this one in
particular is there.

So the reason why it can't be done by that is that the send steam would
be invalid and would break the receive. Also, testing changes is good.
