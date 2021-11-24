Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C7145CB14
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 18:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhKXRg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 12:36:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36080 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhKXRg0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 12:36:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 297EF1FD37;
        Wed, 24 Nov 2021 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637775196;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XFuVfpmxIZUHVWMlchelc1rFV37Kwz/0SpGpZNrzBC4=;
        b=TxYve/mjJ7VHFaJkelFEU6ZCBE9vRFLzo23cR23Rfse9h89oDs8oRxb9dqEeMPROtrgCkd
        m47mbdEEx7iIvRC+kWotRPMfgAVsTqrAVUEnfev0GWaJxIksxXzo/zJo3Bt4myOVkT7GTE
        hZ3mY1x1fQWbFRIJ46xG22WSedCoDJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637775196;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XFuVfpmxIZUHVWMlchelc1rFV37Kwz/0SpGpZNrzBC4=;
        b=AAHOruqfq1jQ92noZR6vqJy2vmtMi6q9s/nDyQYXsf4u07TcA65kUFkh/HJKk3ac4IUsx9
        pJop+v1KFjt90oDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 217F6A3B83;
        Wed, 24 Nov 2021 17:33:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 62826DA735; Wed, 24 Nov 2021 18:33:08 +0100 (CET)
Date:   Wed, 24 Nov 2021 18:33:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 04/21] btrfs: zoned: it's pointless to check for
 REQ_OP_ZONE_APPEND and btrfs_is_zoned
Message-ID: <20211124173308.GV28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
 <2a77d18e249ace733422771b05d48a883c4e5b07.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a77d18e249ace733422771b05d48a883c4e5b07.1637745470.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 24, 2021 at 01:30:30AM -0800, Johannes Thumshirn wrote:
> REQ_OP_ZONE_APPEND can only work on zoned devices, so it is redundant to
> check if the filesystem is zoned when REQ_OP_ZONE_APPEND is set as the
> bio's bio_op.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/extent_io.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 96c2e40887772..d5eb31306c448 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3282,8 +3282,7 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
>  	else
>  		bio_ctrl->len_to_stripe_boundary = (u32)geom.len;
>  
> -	if (!btrfs_is_zoned(fs_info) ||
> -	    bio_op(bio_ctrl->bio) != REQ_OP_ZONE_APPEND) {
> +	if (bio_op(bio_ctrl->bio) != REQ_OP_ZONE_APPEND) {

As for this style of open coded conditions, I think it's fine in
functions that handle bios or the REQ_OPs anyway, so like here. Removing
redundant conditions is correct too.

>  		bio_ctrl->len_to_oe_boundary = U32_MAX;
>  		return 0;
>  	}
